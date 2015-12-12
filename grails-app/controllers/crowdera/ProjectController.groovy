package crowdera

import grails.plugin.springsecurity.annotation.Secured
import groovy.json.JsonSlurper

import org.apache.http.HttpEntity
import org.apache.http.HttpResponse
import org.apache.http.client.HttpClient
import org.apache.http.client.methods.HttpPost
import org.apache.http.entity.StringEntity
import org.apache.http.impl.client.DefaultHttpClient
import org.apache.http.util.EntityUtils
import org.apache.poi.ss.usermodel.Workbook
import org.apache.poi.ss.usermodel.WorkbookFactory
import org.codehaus.groovy.grails.web.json.JSONObject
import org.springframework.web.multipart.MultipartHttpServletRequest
import org.springframework.web.multipart.commons.CommonsMultipartFile
import grails.util.Environment
import javax.servlet.http.Cookie
import groovyx.net.http.ContentType
import groovyx.net.http.HTTPBuilder
import groovyx.net.http.Method

class ProjectController {
	def userService
	def excelImportService
	def rewardService
	def projectService
	def mandrillService
	def contributionService

	def FORMCONSTANTS = [
		/* Beneficiary */
		FIRSTNAME: 'firstName',
		LASTNAME: 'lastName',
		EMAIL: 'email',
		TELEPHONE: 'telephone',
		GENDER: 'gender',
		ADDRESSLINE1: 'addressLine1',
		ADDRESSLINE2: 'addressLine2',
		CITY: 'city',
		STATEORPROVINCE: 'stateOrProvince',
		POSTALCODE: 'postalCode',
		COUNTRY: 'country',
		CHARITABLE: 'charitableId',
		ORGANIZATIONNAME: 'organizationName',
		WEBADDRESS: 'webAddress',

		CATEGORY: 'category',
		DEFAULT_CATEGORY: Project.Category.EDUCATION,
		PAYMENT:'payment',
		AMOUNT: 'amount',
		DAYS: 'days',
		TITLE: 'title',
		STORY: 'story',
		DESCRIPTION: 'description',
		THUMBNAIL: 'thumbnail',
		IMAGEURL: 'imageUrl',
		REWARDS: 'rewards',
		PROJECTSEXCEL: 'projectsExcel',
		VIDEO:'videoUrl',
		PAYPALEMAIL:'paypalEmail',
		PAYUEMAIL:'payuEmail',
		PAYUSTATUS:'payuStatus',
		SECRETKEY:'secretKey',
        FACEBOOKURl:'facebookUrl',
        TWITTERURl:'twitterUrl',
        LINKEDINURL:'linkedinUrl'
    ]

    def list = {
        def countryOptions = projectService.getCountry()
		def currentEnv = Environment.current.getName()
		def discoverLeftCategoryOptions
		if(currentEnv =="testIndia" || currentEnv=="stagingIndia" || currentEnv=="prodIndia"){
			discoverLeftCategoryOptions = projectService.getIndiaCategory()
		}else{
			discoverLeftCategoryOptions=projectService.getCategory()
		}
        def sortsOptions = projectService.getSorts()
        
        def projects = projectService.getValidatedProjects(currentEnv)
        def selectedCategory = "All Categories"
        def multiplier = projectService.getCurrencyConverter();
        
        if (projects.size < 1) {
            flash.catmessage="There are no campaigns"
            render (view: 'list/index', model: [countryOptions: countryOptions, sortsOptions: sortsOptions,discoverLeftCategoryOptions: discoverLeftCategoryOptions, multiplier: multiplier])
        } else {
            render (view: 'list/index', model: [projects: projects,selectedCategory: selectedCategory, currentEnv: currentEnv, countryOptions: countryOptions, sortsOptions: sortsOptions, 
                                                discoverLeftCategoryOptions:discoverLeftCategoryOptions, multiplier: multiplier])
        }
    }

	def listwidget = {
		def projects = projectService.getValidatedProjects()
		render (view: 'list/index', model: [projects: projects])
	}

	def search () {
        def currentEnv = Environment.current.getName()
		def query = params.q
		def countryOptions = projectService.getCountry()
		def discoverLeftCategoryOptions
		if(currentEnv =="testIndia" || currentEnv=="stagingIndia" || currentEnv=="prodIndia"){
			discoverLeftCategoryOptions = projectService.getIndiaCategory()
		}else{
			discoverLeftCategoryOptions=projectService.getCategory()
		}
		def sortsOptions = projectService.getSorts()
		if(query) {
			List searchResults = projectService.search(query, currentEnv)
			if (searchResults.empty){
				flash.catmessage = "No Campaign found matching your input."
				redirect(action:"list")
			} else {
				searchResults.sort{x,y -> x.title<=>y.title ?: x.story<=>y.story}
				render(view: "list/index", model:[projects: searchResults, countryOptions:countryOptions, sortsOptions:sortsOptions, discoverLeftCategoryOptions:discoverLeftCategoryOptions])
			}
		} else {
			redirect(controller: "home", action: "index")
		}
	}

	def showCampaign() {
		def title = projectService.getVanityTitleFromId(params.id)
		def name = userService.getVanityNameFromUsername(params.fr, params.id)
		if(title && name){
			if(params.isPreview){
                if(params.tile){
                    redirect (action :'previewTile', params:['projectTitle':title, 'fr':name]);
                }else{
                    redirect (action :'preview', params:['projectTitle':title, 'fr':name]);
                }
			} else {
                redirect (action:'show', params:['projectTitle':title,'fr':name])
			}
		} else {
			render(view: '/404error', model: [message: 'This project does not exist.'])
		}
	}

	@Secured(['IS_AUTHENTICATED_FULLY'])
	def previewTile(){
		forward(action:'show', params:['projectTitle':params.projectTitle,'fr':params.name, 'isPreview':true, 'tile':true])
	}

	@Secured(['IS_AUTHENTICATED_FULLY'])
	def preview(){
		forward(action:'show', params:['projectTitle':params.projectTitle,'fr':params.name, 'isPreview':true, 'tile':false])
	}

    def show() {
        def projectId
        def username
        if (params.projectTitle){
            projectId = projectService.getProjectIdFromVanityTitle(params.projectTitle)
            username = userService.getUsernameFromVanityName(params.fr)
        } else {
            projectId = params.id
            username = params.fr
        }
        Project project = projectService.getProjectById(projectId)
        if (project) {
            def shortUrl = projectService.getShortenUrl(project.id, params.fr)
            def request_url=request.getRequestURL().substring(0,request.getRequestURL().indexOf("/", 8))
            def base_url = (request_url.contains('www')) ? grailsApplication.config.crowdera.BASE_URL1 : grailsApplication.config.crowdera.BASE_URL
            User user = userService.getUserByUsername(username)
            def currentUser = userService.getCurrentUser()
            def currentEnv = projectService.getCurrentEnvironment()
            def currentFundraiser = userService.getCurrentFundRaiser(user, project)
            Team currentTeam = projectService.getCurrentTeam(project,currentFundraiser)
            def totalContribution = contributionService.getTotalContributionForProject(project)
            def percentage = contributionService.getPercentageContributionForProject(totalContribution, project)

			def teamContribution = contributionService.getTotalContributionForUser(currentTeam.contributions)
			def teamPercentage = contributionService.getPercentageContributionForTeam(teamContribution, currentTeam)

			def isCrFrCampBenOrAdmin = userService.isCampaignBeneficiaryOrAdmin(project,currentFundraiser)
			def isCampaignAdmin = userService.isCampaignAdmin(project, username)
			def isEnabledTeamExist = userService.isTeamEnabled(project, currentFundraiser)
			def isCrUserCampBenOrAdmin
			def isTeamExist
			def CurrentUserTeam
			def projectComment
			def teamcomment

			List contributions = []
			List totalContributions = []
			
			/*Send feedback email before campaign end date */
			projectService.sendFeedbackEmailToOwners(project, base_url)
			
			if (project.user == currentTeam.user) {
				def contribution = projectService.getProjectContributions(params, project)
				totalContributions = contribution.totalContributions
				contributions = contribution.contributions
			} else {
			    def contribution = projectService.getTeamContributions(params, currentTeam)
				totalContributions = contribution.totalContributions
				contributions = contribution.contributions
			}
            
			if (currentUser) {
				isCrUserCampBenOrAdmin = userService.isCampaignBeneficiaryOrAdmin(project,currentUser)
				isTeamExist = userService.isValidatedTeamExist(project, currentUser)
				CurrentUserTeam = userService.getTeamByUser(currentUser, project)
			}
			
			def teamObj = projectService.getEnabledAndValidatedTeamsForCampaign(project, params)
			def teamOffset = teamObj.maxrange
			def teams = teamObj.teamList
			def totalteams = teamObj.teams
			
			boolean ended = projectService.isProjectDeadlineCrossed(project)
			boolean isFundingOpen = projectService.isFundingOpen(project)
			def rewards = rewardService.getSortedRewards(project);
			def day= projectService.getRemainingDay(project)
			def endDate = projectService.getProjectEndDate(project)
			def webUrl = projectService.getWebUrl(project)

			if (params.commentId) {
				projectComment = projectService.getProjectCommentById(params.long('commentId'))
			}
			if (params.teamCommentId) {
				teamcomment = projectService.getTeamCommentById(params.long('teamCommentId'))
			}

            def projectComments = projectService.getProjectComments(project)
            def teamComments = projectService.getTeamComments(currentTeam)
            def offset = params.int('offset') ?: 0

            def multiplier = projectService.getCurrencyConverter();
            def pieList = projectService.getPieList(project);
            def hasMorTags = projectService.getHashTags(project.hashtags)
            def reasons = projectService.getReasonsToFundFromProject(project)
            render (view: 'show/index',
            model: [project: project, user: user,currentFundraiser: currentFundraiser, currentTeam: currentTeam, endDate: endDate, isCampaignAdmin: isCampaignAdmin, projectComments: projectComments, totalteams: totalteams,
                    totalContribution: totalContribution, percentage:percentage, teamContribution: teamContribution, contributions: contributions, webUrl: webUrl, teamComments: teamComments, totalContributions:totalContributions,
                    teamPercentage: teamPercentage, ended: ended, teams: teams, currentUser: currentUser, day: day, CurrentUserTeam: CurrentUserTeam, isEnabledTeamExist: isEnabledTeamExist, offset: offset, teamOffset: teamOffset,
                    isCrUserCampBenOrAdmin: isCrUserCampBenOrAdmin, isCrFrCampBenOrAdmin: isCrFrCampBenOrAdmin, isFundingOpen: isFundingOpen, rewards: rewards, projectComment: projectComment, teamcomment: teamcomment,currentEnv: currentEnv,
                    isTeamExist: isTeamExist, vanityTitle: params.projectTitle, vanityUsername: params.fr, FORMCONSTANTS: FORMCONSTANTS, isPreview:params.isPreview, tile:params.tile, shortUrl:shortUrl, base_url:base_url,
                    multiplier: multiplier, spendCauseList:pieList.spendCauseList, spendAmountPerList:pieList.spendAmountPerList, hashTags:hasMorTags.firstFiveHashTags, remainingTags: hasMorTags.remainingHashTags, reasons:reasons])
		} else {
		    render(view: '/404error', model: [message: 'This project does not exist.'])
		}
	}
	
	def showMoreteam() {
		def vanityTitle = params.projectTitle
		redirect (controller: 'project', action: 'show', params:['projectTitle':vanityTitle,'fr': params.fr, teamOffset: params.teamOffset], fragment: 'manageTeam')
	}

	@Secured(['ROLE_ADMIN'])
	def validateShowCampaign(){
		def title = projectService.getVanityTitleFromId(params.id)
		def name = userService.getVanityNameFromUsername(params.fr, params.id)
		if(title && name){
			redirect (action:'validateshow', params:['projectTitle':title,'fr':name])
		}else{
			render view:"404error"
		}
	}

	@Secured(['ROLE_ADMIN'])
	def validateshow() {
		def projectId
		if (params.projectTitle){
			projectId = projectService.getProjectIdFromVanityTitle(params.projectTitle)
		} else {
			projectId = params.id
		}
		def project = projectService.getProjectById(projectId)
		if (project) {
			User user = project.user
			def currentUser = userService.getCurrentUser()
			def currentFundraiser = project.user
			def currentTeam = projectService.getCurrentTeam(project,currentFundraiser)
			def totalContribution = contributionService.getTotalContributionForProject(project)
			def percentage = contributionService.getPercentageContributionForProject(totalContribution, project)
			def teamContribution
			def teamPercentage
			if (currentTeam) {
                        teamContribution = contributionService.getTotalContributionForUser(currentTeam.contributions)
                        teamPercentage = contributionService.getPercentageContributionForTeam(teamContribution, currentTeam)
			}
			def isCrFrCampBenOrAdmin = userService.isCampaignBeneficiaryOrAdmin(project,currentFundraiser)
			def isCrUserCampBenOrAdmin
			def isTeamExist
			if (currentUser) {
				isCrUserCampBenOrAdmin = userService.isCampaignBeneficiaryOrAdmin(project,currentUser)
				isTeamExist = userService.isValidatedTeamExist(project, currentUser)
			}
			def teamObj = projectService.getEnabledAndValidatedTeamsForCampaign(project, params)
			def teamOffset = teamObj.maxrange
			def teams = teamObj.teamList
			def totalteams = teamObj.teams

			boolean ended = projectService.isProjectDeadlineCrossed(project)
			boolean isFundingOpen = projectService.isFundingOpen(project)
			def rewards = rewardService.getSortedRewards(project);
			def day= projectService.getRemainingDay(project)
			def endDate = projectService.getProjectEndDate(project)
			def webUrl = projectService.getWebUrl(project)
			def validatedPage = true
			def projectComments = projectService.getProjectComments(project)
			def teamComments = projectService.getTeamComments(currentTeam)
			List totalContributions = []
			List contributions = []
            def multiplier = projectService.getCurrencyConverter();

			if(project.validated == false) {

				render (view: 'validate/validateshow',
				model: [project: project, user: user,currentFundraiser: currentFundraiser, currentTeam: currentTeam, endDate: endDate,projectComments: projectComments,totalteams: totalteams,
					totalContribution: totalContribution, percentage:percentage, teamContribution: teamContribution, webUrl: webUrl, teamComments: teamComments, teamOffset: teamOffset,
					teamPercentage: teamPercentage, ended: ended, teams: teams, currentUser: currentUser, day: day,totalContributions: totalContributions,contributions: contributions,
					isCrUserCampBenOrAdmin: isCrUserCampBenOrAdmin, isCrFrCampBenOrAdmin: isCrFrCampBenOrAdmin, isFundingOpen: isFundingOpen, rewards: rewards,
					validatedPage: validatedPage, isTeamExist: isTeamExist, FORMCONSTANTS: FORMCONSTANTS, multiplier: multiplier])
			}
		} else {
			render (view: '404error')
		}
	}

	@Secured(['ROLE_ADMIN'])
	def updateValidation() {
		if (params.id) {
			projectService.getUpdateValidationDetails(params)
		}
		flash.prj_validate_message= "Campaign validated successfully"
		redirect (action:'validateList')
	}

	@Secured(['ROLE_ADMIN'])
	def delete() {
		def project = projectService.getProjectById(params.id)
		if (project) {
			project.rejected = true
			flash.prj_validate_message= "Campaign discarded successfully"
			redirect (action:'validateList')
		} else {
			flash.prj_validate_err_message = 'Campaign Not Found'
			render (view: 'validate/validateerror', model: [project: project])
		}
	}

    @Secured(['IS_AUTHENTICATED_FULLY'])
    def deleteProjectImage(){
        def imageUrl = projectService.getImageUrlById(request.getParameter("imgst"))
        def project = projectService.getProjectById(request.getParameter("projectId"))
        List imageUrls = project.imageUrl
        imageUrls.remove(imageUrl)
        imageUrl.delete()
        render ''
    }

    @Secured(['IS_AUTHENTICATED_FULLY'])
    def deleteTeamImage(){
        def imageUrl = projectService.getImageUrlById(request.getParameter("imgst"))
        def team = projectService.getTeamById(request.getParameter("teamId"))
        List imageUrls = team.imageUrl
        imageUrls.remove(imageUrl)
        imageUrl.delete()
        render ''
    }

    @Secured(['IS_AUTHENTICATED_FULLY'])
    def deleteOrganizationLogo(){
        def project = projectService.getProjectById(request.getParameter("projectId"))
        project.organizationIconUrl = null
        render ''
    }

    @Secured(['IS_AUTHENTICATED_FULLY'])
    def deleteTaxRecieptFile(){
        def file = projectService.getImageUrlById(params.fileId)
        def taxReciept = projectService.getTaxRecieptById(params.taxRecieptId)
        List files = taxReciept.files
        files.remove(file)
        file.delete()
        render ''
    }

	@Secured(['IS_AUTHENTICATED_FULLY'])
	def deleteCampaignAdmin(){
		def project = projectService.getProjectById(request.getParameter("projectId"))
		def username = request.getParameter("username")
		def projectAdmin = projectService.getProjectAdminByEmail(username)
		def projectAdmins = project.projectAdmins
		projectAdmins.remove(projectAdmin);
		projectAdmin.delete()
		render ''
	}

	@Secured(['IS_AUTHENTICATED_FULLY'])
	def validate() {
		Project project = projectService.getProjectById(params.id)
		if (project) {
			if(project.validated == true){
				redirect (action:'showCampaign', id:project.id)
			} else {
				render (view: 'validate/validateerror', model: [projects: project])
			}
		}
	}

	@Secured(['IS_AUTHENTICATED_FULLY'])
	def saveasdraft(){
		def project = projectService.getProjectById(params.id)
		def title = projectService.getVanityTitleFromId(params.id)
		if(project.draft) {
			project.draft = false
            if (params.submitForApprovalcheckbox && !project.touAccepted) {
                project.touAccepted = true
            }
            if (params.submitForApprovalcheckbox1 && !project.touAccepted) {
                project.touAccepted = true
            }
			flash.prj_mngprj_message="Campaign has been submitted for approval."
			redirect(action:'manageproject', params:['projectTitle':title])
		} else {
			flash.prj_mngprj_message="This Campaign has already been submitted for approval, and under review."
			redirect(action:'manageproject', params:['projectTitle':title])
		}
	}

	@Secured(['ROLE_ADMIN'])
	def validateList() {
        def currentEnv = Environment.current.getName()
		def projects = projectService.getNonValidatedProjects(currentEnv)
		render(view: 'validate/index', model: [projects: projects])
	}

	@Secured(['IS_AUTHENTICATED_FULLY'])
	def savecomment() {
		def title = projectService.getVanityTitleFromId(params.id)
		def name = userService.getVanityNameFromUsername(params.fr, params.id)
		if (params.id) {
			projectService.getCommentsDetails(params)
		} else {
			flash.sentmessage = "Something went wrong saving comment. Please try again later."
		}
		redirect (action: 'show', params:['projectTitle':title,'fr':name], fragment: 'comments')
	}

	@Secured(['IS_AUTHENTICATED_FULLY'])
	def updatecomment(){
		def checkid= request.getParameter('checkID')
		def proComment = projectService.getProjectCommentById(checkid)
		def status = request.getParameter('status')
		if(status=='false'){
			proComment.status=false
		}else{
			proComment.status=true
		}
		render ""
	}

	def create() {
        def currentEnv = Environment.current.getName()
        def inDays = projectService.getInDays()
		render(view: 'create/index1', model: [FORMCONSTANTS: FORMCONSTANTS, currentEnv: currentEnv, inDays:inDays])
	}
    
    def saveCampaign() {
        def request_url=request.getRequestURL().substring(0,request.getRequestURL().indexOf("/", 8))
        def base_url = (request_url.contains('www')) ? grailsApplication.config.crowdera.BASE_URL1 : grailsApplication.config.crowdera.BASE_URL

        def amount = params.amount ? params.amount : params.amount1;
        def currentdays = params.days ? params.days : params.days1
        def days = Integer.parseInt(currentdays)

        def reqUrl = base_url+"/project/createNow?firstName=${params.firstName}&amount=${amount}&title=${params.title}&description=${params.description}&usedFor=${params.usedFor}&days=${days}&customVanityUrl=${params.customVanityUrl}"
        def user = userService.getCurrentUser()
        if (!user) {
            Cookie cookie = new Cookie("requestUrl", reqUrl)
            cookie.path = '/'    // Save Cookie to local path to access it throughout the domain
            cookie.maxAge= 3600  //Cookie expire time in seconds
            response.addCookie(cookie)

            def loginSignUpCookie = projectService.setLoginSignUpCookie()
            if (loginSignUpCookie) {
                response.addCookie(loginSignUpCookie)
            }
        }
        redirect (url: reqUrl)
    }
    
    @Secured(['IS_AUTHENTICATED_FULLY'])
    def createNow() {
        String requestUrl = g.cookie(name: 'requestUrl')
        if (requestUrl) {
            def cookie = projectService.setCookie(requestUrl)
            response.addCookie(cookie)
        }
        String loginSignUpCookie = g.cookie(name: 'loginSignUpCookie')
        if (loginSignUpCookie) {
            def cookie = projectService.deleteLoginSignUpCookie()
            response.addCookie(cookie)
        }
		
        
        def projectTitle
        if (params.title && params.amount && params.description && params.firstName) {
            def project = projectService.getProjectByParams(params)
            def beneficiary = userService.getBeneficiaryByParams(params)
            def user = userService.getCurrentUser()
            project.draft = true;
            project.beneficiary = beneficiary;
            project.beneficiary.email = user.email;
            
            if (project.usedFor == 'SOCIAL_NEEDS'){
                project.hashtags = '#SOCIAL-INNOVATION'
            } else if (project.usedFor == 'PERSONAL_NEEDS'){
                project.hashtags = '#PERSONAL-NEEDS'
            } else {
                project.hashtags = '#'+project.usedFor
            }

		    project.usedFor = params.usedFor;
		
            if(project.save(failOnError: true)){
                projectTitle = (project.customVanityUrl)? projectService.getCustomVanityUrl(project) : projectService.getProjectVanityTitle(project)
                projectService.getFundRaisersForTeam(project, user)
                projectService.getdefaultAdmin(project, user)
                redirect(action:'redirectCreateNow', params:[title:projectTitle])
            } else {
                render view:'/project/createerror'
            }
        } else {
            render view:'/project/createerror'
        }
    }
	
    @Secured(['IS_AUTHENTICATED_FULLY'])
    def redirectCreateNow() {
        def vanityTitle = params.title
        def project = projectService. getProjectFromVanityTitle(vanityTitle)
        if (project) {
            def user = project.user
            def currentUser = userService.getCurrentUser()
            def spends = project.spend
            spends = spends.sort{it.numberAvailable}
            if (user == currentUser) {
                def currentEnv = Environment.current.getName()
                def categoryOptions 
                if(currentEnv =='testIndia' || currentEnv =='stagingIndia' || currentEnv =='prodIndia'){
                    categoryOptions = projectService.getIndiaCategoryList()
                } else {
                    categoryOptions = projectService.getCategoryList()
                }

                def country = projectService.getCountry()
                def nonProfit = projectService.getRecipientOfFunds()
                def nonIndprofit = projectService.getRecipientOfFundsIndo()
                def vanityUsername = userService.getVanityNameFromUsername(user.username, project.id)

                def usedForCreate
                if (project.usedFor == 'SOCIAL_NEEDS'){
                    usedForCreate = 'SOCIAL-INNOVATION'
                } else if (project.usedFor == 'PERSONAL_NEEDS'){
                    usedForCreate = 'PERSONAL-NEEDS'
                } else {
                    usedForCreate = project.usedFor
                }
                def selectedCountry = (project.beneficiary.country) ? projectService.getCountryValue(project.beneficiary.country) : null;

                def endDate = projectService.getProjectEndDate(project)
                def campaignEndDate = endDate.getTime().format('MM/dd/yyyy')
                def date = new Date();
                List projectRewards = []
                project.rewards.each {
                    if (it.id != 1) {
                        projectRewards.add(it)
                    }
                }
				projectRewards = projectRewards.sort{it.rewardCount}
                if(campaignEndDate == date.format('MM/dd/yyyy')){
                    campaignEndDate = null
                }
                def adminemails = projectService.getAdminEmail(project)
                def payOpts
                if (currentEnv == 'testIndia' || currentEnv == 'stagingIndia' || currentEnv == 'prodIndia'){
                    payOpts = projectService.getIndiaPaymentGateway()
                } else {
                    payOpts = projectService.getPayment()
                }
                def pieList = projectService.getPieList(project);
                def reasonsToFund = projectService.getProjectReasonsToFund(project)
                def qA = projectService.getProjectQA(project)
                def taxReciept = projectService.getTaxRecieptOfProject(project)
                def deductibleStatusList = projectService.getDeductibleStatusList()
                def stateInd = projectService.getIndianState()
                render(view: 'create/index2',
                model: ['categoryOptions': categoryOptions, 'payOpts':payOpts, 'country': country, 
                    nonIndprofit:nonIndprofit, nonProfit:nonProfit , currentEnv: currentEnv,
                    FORMCONSTANTS: FORMCONSTANTS,projectRewards:projectRewards, project:project, 
                    user:user,campaignEndDate:campaignEndDate, pieList:pieList,stateInd:stateInd,
                    vanityTitle: vanityTitle, vanityUsername:vanityUsername, email1:adminemails.email1, 
                    email2:adminemails.email2, email3:adminemails.email3,reasonsToFund:reasonsToFund, 
                    qA:qA, spends:spends, usedForCreate:usedForCreate, selectedCountry:selectedCountry, 
                    taxReciept:taxReciept, deductibleStatusList:deductibleStatusList,
                    spendAmountPerList:pieList.spendAmountPerList])
            } else {
                render(view: '/401error', model: [message: 'Sorry, you are not authorized to view this page.'])
            }
        } else {
            render(view: '/404error', model: [message: 'This project does not exist.'])
        }
    }
	
    @Secured(['IS_AUTHENTICATED_FULLY'])
    def campaignOnDraftAndLaunch() {
        Project project = projectService.getProjectById(params.projectId)
        def vanitytitle
        if (project) {
            User user = userService.getCurrentUser()
            if (project.user == user) {
                def currentEnv = Environment.current.getName()
                if(currentEnv == 'testIndia' || currentEnv == 'stagingIndia' || currentEnv == 'prodIndia') {
                    if(params.payuEmail){
                        project.payuEmail = params.payuEmail
                    }
                }
				
                projectService.saveLastSpendField(params);

                vanitytitle = (project.customVanityUrl) ? projectService.getCustomVanityUrl(project) : params.title;

                rewardService.saveRewardDetails(params);
                project.story = params.story
                
                if (params.checkBox && !project.touAccepted) {
                    project.touAccepted = true
                }
                
                def taxReciept = TaxReciept.findByProject(project)
                if(taxReciept) {
                    if (currentEnv == 'testIndia' || currentEnv == 'stagingIndia' || currentEnv == 'prodIndia'){
                        taxReciept.country = 'India'
                    } else {
                        taxReciept.country = (taxReciept.country && taxReciept.country != 'null') ? taxReciept.country : 'United States';
                    }
                    taxReciept.save();
                }

                if (params.isSubmitButton == 'true'){
                    project.draft = false;
                    if (!project.beneficiary.country || project.beneficiary.country == 'null') {
                        if(currentEnv == 'testIndia' || currentEnv == 'stagingIndia' || currentEnv == 'prodIndia') {
                            project.beneficiary.country = 'IN'
                        } else {
                            project.beneficiary.country = 'US'
                        }
                    }
                    redirect (action:'launch' ,  params:[title:vanitytitle])
                } else {
                    redirect (action:'showCampaign' ,  params:[id:project.id, isPreview:true])
                }
            } else {
                render(view: '/401error', model: [message: 'Sorry, you are not authorized to view this page.'])
            }
        } else {
            render(view: '/404error', model: [message: 'This project does not exist.'])
        }
    }
	
	@Secured(['IS_AUTHENTICATED_FULLY'])
	def campaignOnDraft() {
		def vanityTitle = params.title
		def project = projectService.getProjectFromVanityTitle(vanityTitle)
		render (view: 'create/saveasdraft', model:[FORMCONSTANTS: FORMCONSTANTS, project:project])
	}
	
    @Secured(['IS_AUTHENTICATED_FULLY'])
    def launch() {
        def vanityTitle = params.title
        def project = projectService. getProjectFromVanityTitle(vanityTitle)
        def currentEnv = Environment.current.getName()
        if(currentEnv == 'testIndia' || currentEnv == 'stagingIndia' || currentEnv == 'prodIndia'){
            project.payuStatus = true
            if (project.fundsRecievedBy == null){
                project.fundsRecievedBy = "NGO"
                project.hashtags = project.hashtags + ", #NGO"
            }
        } else {
            if (project.fundsRecievedBy == null){
                project.fundsRecievedBy = "NON-PROFIT"
                project.hashtags = project.hashtags + ", #NON-PROFIT"
            }
        }
        render (view: 'create/justcreated', model:[project:project, FORMCONSTANTS: FORMCONSTANTS, vanityTitle: vanityTitle])
    }
	
	@Secured(['IS_AUTHENTICATED_FULLY'])
	def editCampaign(){
		def title = projectService.getVanityTitleFromId(params.id)
		if(title){
			redirect (action : 'edit', params:['projectTitle':title])
		}else{
			render(view: '/404error', model: [message: 'This project does not exist.'])
		}
	}

    @Secured(['IS_AUTHENTICATED_FULLY'])
    def edit() {
        def project = projectService.getProjectFromVanityTitle(params.projectTitle)
        def currentEnv = Environment.current.getName()
        def inDays = projectService.getInDays()
        def categoryOptions
        def spends = project.spend
        spends = spends.sort{it.numberAvailable}
        if(currentEnv =='testIndia' || currentEnv =='stagingIndia' || currentEnv =='prodIndia'){
            categoryOptions = projectService.getIndiaCategoryList()
        } else {
            categoryOptions = projectService.getCategoryList()
        }
        def vanityTitle = params.projectTitle
        def user = project.user
        def country = projectService.getCountry()
        def nonProfit = projectService.getRecipientOfFunds()
        def nonIndprofit = projectService.getRecipientOfFundsIndo()
        def vanityUsername = userService.getVanityNameFromUsername(user.username, project.id)
        def endDate = projectService.getProjectEndDate(project)
        def campaignEndDate = endDate.getTime().format('MM/dd/yyyy')
        def date = new Date();
        List projectRewards = []
        project.rewards.each {
            if (it.id != 1) {
                projectRewards.add(it)
            }
        }
        projectRewards = projectRewards.sort{it.rewardCount}
        if(campaignEndDate == date.format('MM/dd/yyyy')){
            campaignEndDate = null
        }
        def adminemails = projectService.getAdminEmail(project)
        def payOpts
        if (currentEnv == 'testIndia' || currentEnv == 'stagingIndia' || currentEnv == 'prodIndia'){
            payOpts = projectService.getIndiaPaymentGateway()
        } else {
            payOpts = projectService.getPayment()
        }
        def selectedCountry = (project.beneficiary.country) ? projectService.getCountryValue(project.beneficiary.country) : null;
        if (project) {
            def beneficiary = project.beneficiary
            def reasonsToFund = projectService.getProjectReasonsToFund(project)
            def qA = projectService.getProjectQA(project)
            def taxReciept = projectService.getTaxRecieptOfProject(project)
            def deductibleStatusList = projectService.getDeductibleStatusList()
            def stateInd = projectService.getIndianState()
            render (view: 'edit/index',
            model: ['categoryOptions': categoryOptions, 'payOpts':payOpts,spends:spends,
                'country': country, nonProfit:nonProfit, nonIndprofit:nonIndprofit,
                currentEnv: currentEnv,beneficiary:beneficiary,inDays:inDays,taxReciept:taxReciept,
                FORMCONSTANTS: FORMCONSTANTS,projectRewards:projectRewards,qA:qA,stateInd:stateInd,
                project:project, user:user,campaignEndDate:campaignEndDate,reasonsToFund:reasonsToFund,
                vanityTitle: vanityTitle, vanityUsername:vanityUsername, selectedCountry: selectedCountry,
                email1:adminemails.email1, email2:adminemails.email2, email3:adminemails.email3,
                deductibleStatusList:deductibleStatusList])
        } else {
            flash.prj_edit_message = "Campaign not found."
            render (view: 'edit/editerror')
            return
        }
    }

    @Secured(['IS_AUTHENTICATED_FULLY'])
    def update() {
        def project = projectService.getProjectFromVanityTitle(params.vanityTitle)
        if(project) {
            def vanityTitle = projectService.getProjectUpdateDetails(params, project)
            rewardService.saveRewardDetails(params);
            projectService.saveLastSpendField(params);
            flash.prj_mngprj_message = "Successfully saved the changes"
            redirect (action: 'manageproject', params:['projectTitle':vanityTitle])
        } else {
            flash.prj_edit_message = "Campaign not found."
            render (view: 'edit/editerror')
        }
    }

	@Secured(['ROLE_ADMIN'])
	def importprojects() {
		render view: 'import/index'
	}

	static Map CONFIG_BOOK_COLUMN_MAP = [
		sheet: 'Sheet1',
		startRow: 1,
		columnMap:  [
			'A': 'createdDate',
			'B': 'amount',
			'C': 'days',
			'D': 'description',
			'E': 'fundRaisingFor',
			'F': 'category',
			'G': 'title',
			'H': 'story',
			'I': 'validated',
			'J': 'imageUrl',
			'K': 'createdBy',
			'L': 'firstName',
			'M': 'lastName',
			'N': 'email',
			'O': 'telephone',
			'P': 'gender',
			'Q': 'addressLine1',
			'R': 'addressLine2',
			'S': 'city',
			'T': 'stateOrProvince',
			'U': 'postalCode',
			'V': 'country',
		]
	]

	@Secured(['ROLE_ADMIN'])
	def bulkimport() {
		MultipartHttpServletRequest multipartRequest = request
		CommonsMultipartFile projectSpreadsheet = multipartRequest.getFile(FORMCONSTANTS.PROJECTSEXCEL)

		if (projectSpreadsheet.isEmpty()) {
			flash.prj_import_message = "Please choose a file and try again."
			redirect(action: 'importprojects')
			return
		}

		List projectParamsList
		try {
			Workbook workbook = WorkbookFactory.create(projectSpreadsheet.getInputStream())
			projectParamsList = excelImportService.columns(workbook, CONFIG_BOOK_COLUMN_MAP)
		} catch (Exception e) {
			flash.prj_import_message = "Error while importing file: " + e.getMessage()
			redirect(action: 'importprojects')
			return
		}

		/* Collect all the successfully created projects. */
		def projects = []

		projectParamsList.each { Map projectParams ->

			User createdBy = userService.getUserByUsername(projectParams.createdBy)
			if (!createdBy) {
				flash.projecterror = [
					'title': projectParams.title,
					'error': "Couldn't find user with email: " + projectParams.createdBy
				]
				render (view: 'import/importerror')
				return
			}

			Project project = projectService.getProjectByParams(projectParams)
			if (project.hasErrors()) {
				flash.projecterror = [
					'title': projectParams.title,
					'error': "Error mapping project: " + project.errors.toString()
				]
				redirect(action: 'importprojects')
				return
			}

			Beneficiary beneficiary = userService.getBeneficiaryByParams(projectParams)
			if (beneficiary.hasErrors()) {
				flash.projecterror = [
					'title': projectParams.title,
					'error': "Error mapping beneficiary: " + beneficiary.errors.toString()
				]
				redirect(action: 'importprojects')
				return
			}

			project.beneficiary = beneficiary
			project.user = createdBy

			try {
				project.created = projectParams.createdDate.toDate()
			} catch (Exception e) {
				flash.projecterror = [
					'title': projectParams.title,
					'error': "Error with createdDate: " + e.getMessage()
				]
				redirect(action: 'importprojects')
				return
			}


			if (project.validate()) {
				projects.add(project)
			} else {
				flash.projecterror = [
					'title': projectParams.title,
					'error': "Error validating project: " + project.errors.toString()
				]
				redirect(action: 'importprojects')
				return
			}
		}

		if (!projects.isEmpty()) {
			projects.each { Project project ->
				if (!project.save()) {
					flash.projecterror = [
						'title': project.title,
						'error': "Error while saving: " + project.errors.toString(),
						'note': "None of the Campaigns after this one would be imported."
					]
					redirect(action: 'importprojects')
					return
				}
			}

			flash.prj_import_message = "All Campaigns successfully imported"
			redirect(action: 'importprojects')
			return
		} else {
			flash.projecterror = "Nothing to import. Please make sure the file contains some valid rows."
			render (view: 'import/importerror')
			return
		}
	}

	def VALID_IMG_TYPES = ['image/png', 'image/jpeg']

	@Secured(['IS_AUTHENTICATED_FULLY'])
	def invalidateSession() {
		def status =request.getParameter("status")
		if(status==true)
			session.invalidate()
		render " "
	}


    @Secured(['IS_AUTHENTICATED_FULLY'])
    def save() {
        def environment = Environment.current.getName()
        Project project
        Beneficiary beneficiary
        User user = userService.getCurrentUser()
        project = projectService.getProjectByParams(params)
        beneficiary = userService.getBeneficiaryByParams(params)
        def amount=project.amount
        def boolPerk=false

        def button = params.isSubmitButton
        if (button == 'true') {
            project.draft = true
        }

        if(environment == 'testIndia' || environment == 'stagingIndia' || environment == 'prodIndia'){
            if(params.payuEmail) {
                project.payuStatus=true
            }

            if(params.(FORMCONSTANTS.COUNTRY) != "IN"){
                beneficiary.stateOrProvince = params.otherstate
            }
        } else{
            if(params.(FORMCONSTANTS.COUNTRY) != "US"){
                beneficiary.stateOrProvince = params.otherstate
            }
        }

        def rewardLength=Integer.parseInt(params.rewardCount)
        if (rewardLength >= 1) {
            def rewardTitle = new Object[rewardLength]
            def rewardPrice = new Object[rewardLength]
            def rewardDescription = new Object[rewardLength]
            def mailingAddress = new Object[rewardLength]
            def emailAddress = new Object[rewardLength]
            def twitter = new Object[rewardLength]
            def custom = new Object[rewardLength]

            for(def icount=0; icount< rewardLength; icount++){
                rewardTitle[icount] = params.("rewardTitle"+ (icount+1))
                rewardPrice[icount] = params.("rewardPrice"+(icount+1))
                rewardDescription[icount] = params.("rewardDescription"+(icount+1))
                mailingAddress[icount] = params.("mailingAddress"+(icount+1))
                emailAddress[icount] = params.("emailAddress"+(icount+1))
                twitter[icount] = params.("twitter"+(icount+1))
                custom[icount] = params.("custom"+(icount+1))
                if(rewardPrice[icount]==null || Double.parseDouble(rewardPrice[icount])>amount){
                    boolPerk=true;
                }
                if (mailingAddress[icount]==null && emailAddress[icount]==null && twitter[icount]==null && custom[icount]==null) {
                    emailAddress[icount]=true
                }
            }
            if(boolPerk==true){
                flash.prj_mngprj_message = "Enter a perk price less than Campaign amount: ${amount}"
                render (view: 'manageproject/error')
                return
            } else {
                rewardService.getMultipleRewards(project, rewardTitle, rewardPrice, rewardDescription, mailingAddress, emailAddress, twitter, custom)
            }
        }

        def iconFile = request.getFile('iconfile')
        if(!iconFile.isEmpty()) {
            def uploadedFileUrl = projectService.getorganizationIconUrl(iconFile)
            project.organizationIconUrl = uploadedFileUrl
        }

        def imageFiles = request.getFiles('thumbnail[]')
        if (!imageFiles.isEmpty()) {
            projectService.getMultipleImageUrls(imageFiles, project)
        }

        String email1 = params.email1
        String email2 = params.email2
        String email3 = params.email3

        project.user = user

        def days = params.days
        projectService.getNumberofDays(days, project)

        project.beneficiary = beneficiary

        if (project.save()) {
            projectService.getYoutubeUrlChanged(params.videoUrl, project)
            projectService.getFundRaisersForTeam(project, user)
            projectService.getdefaultAdmin(project, user)
            projectService.getAdminForProjects(email1, project, user)
            projectService.getAdminForProjects(email2, project, user)
            projectService.getAdminForProjects(email3, project, user)
            def projectTitle = projectService.getProjectVanityTitle(project)
            userService.getProjectVanityUsername(user)

            if(button == 'true') {
                redirect(action:'draftProject', params:['projectTitle': projectTitle])
            } else {
                redirect(action:'saveProject', params:['projectTitle': projectTitle])
            }
        } else {
            render (view: 'create/createerror', model: [project: project])
        }
    }

	def draftProject() {
		def project = projectService.getProjectFromVanityTitle(params.projectTitle)
		render (view: 'create/saveasdraft', model: [project: project])
	}

	@Secured(['IS_AUTHENTICATED_FULLY'])
	def saveProject() {
		def project = projectService.getProjectFromVanityTitle(params.projectTitle)
		render (view: 'create/justcreated', model: [project: project])
	}

    @Secured(['IS_AUTHENTICATED_FULLY'])
    def manageCampaign() {
        def title = projectService.getVanityTitleFromId(params.id)
        if(title) {
            redirect (action:'manageproject', params:['projectTitle':title])
        } else {
            render view:'404error'
        }
    }
	
    @Secured(['IS_AUTHENTICATED_FULLY'])
    def manageproject() {
        def projectId = projectService.getProjectIdFromVanityTitle(params.projectTitle)
        Project project = projectService.getProjectById(projectId)
        User user = userService.getCurrentUser()
        if (project) {
            def shortUrl = projectService.getShortenUrl(project.id, params.fr)
            def request_url=request.getRequestURL().substring(0,request.getRequestURL().indexOf("/", 8))
            def base_url = (request_url.contains('www')) ? grailsApplication.config.crowdera.BASE_URL1 : grailsApplication.config.crowdera.BASE_URL
            def isCampaignOwnerOrAdmin = userService.isCampaignBeneficiaryOrAdmin(project, user)
            def totalContribution = contributionService.getTotalContributionForProject(project)
            def currentEnv = projectService.getCurrentEnvironment()
            def projectimages = projectService.getProjectImageLinks(project)
            def vanityUsername = userService.getVanityNameFromUsername(project.user.username, project.id)
 
            def teamObj = projectService.getValidatedTeam(project, params)
            def teamOffset = teamObj.maxrange
            def validatedTeam = teamObj.teamList
            def totalteams = teamObj.teams
			
            def unValidatedTeam = projectService.getTeamToBeValidated(project)
            def discardedTeam = projectService.getDiscardedTeams(project)
            boolean ended = projectService.isProjectDeadlineCrossed(project)
            boolean isFundingOpen = projectService.isFundingOpen(project)
            def rewards = rewardService.getSortedRewards(project);
            def endDate = projectService.getProjectEndDate(project)
            def isCampaignAdmin = userService.isCampaignAdmin(project, user.username)
            def percentage = contributionService.getPercentageContributionForProject(totalContribution, project)
            
            Team currentTeam = projectService.getCurrentTeam(project,user)
            def isCrFrCampBenOrAdmin = isCampaignOwnerOrAdmin
            def webUrl = projectService.getWebUrl(project)
            def isEnabledTeamExist = userService.isTeamEnabled(project, user)
			
            List totalContributions = []
			List contributions = []
			def contribution = projectService.getProjectContributions(params, project)
			totalContributions = contribution.totalContributions
			contributions = contribution.contributions
			def offset = params.int('offset') ?: 0
			def bankInfo = projectService.getBankInfoByProject(project)
            
            def day = projectService.getRemainingDay(project)
            def multiplier = projectService.getCurrencyConverter();

            if(project.user==user || isCampaignOwnerOrAdmin){
                render (view: 'manageproject/index',
                        model: [project: project, isCampaignOwnerOrAdmin: isCampaignOwnerOrAdmin, validatedTeam: validatedTeam, percentage: percentage, currentTeam: currentTeam,totalContributions:totalContributions, totalteams: totalteams,
                                discardedTeam : discardedTeam, totalContribution: totalContribution, projectimages: projectimages,isCampaignAdmin: isCampaignAdmin, webUrl: webUrl,contributions: contributions, offset: offset, day: day,
                                ended: ended, isFundingOpen: isFundingOpen, rewards: rewards, endDate: endDate, user : user, isCrFrCampBenOrAdmin: isCrFrCampBenOrAdmin,isEnabledTeamExist: isEnabledTeamExist, teamOffset: teamOffset,
                                unValidatedTeam: unValidatedTeam, vanityTitle: params.projectTitle, vanityUsername:vanityUsername, FORMCONSTANTS: FORMCONSTANTS, isPreview:params.isPreview, currentEnv: currentEnv, bankInfo: bankInfo, 
								tile:params.tile, shortUrl:shortUrl, base_url:base_url, multiplier: multiplier])
            } else {
                flash.prj_mngprj_message = 'Campaign Not Found'
                render (view: 'manageproject/error', model: [project: project])
            }
        } else {
            render(view: '/404error', model: [message: 'This project does not exist.'])
        }
    }
	
	def showteams() {
		def vanityTitle = params.projectTitle
		redirect (controller: 'project', action: 'manageproject', params:['projectTitle':vanityTitle, teamOffset: params.teamOffset], fragment: 'manageTeam')
	}

	@Secured(['IS_AUTHENTICATED_FULLY'])
	def projectdelete() {
		def project = projectService.getProjectById(params.id)
		def currentUser= userService.getCurrentUser()
		if (project) {
			project.inactive = true
			List emailList= projectService.getProjectAdminEmailList(project)
			mandrillService.sendCampaignDeleteEmailsToOwner(emailList, project, currentUser)
			flash.user_message= "Campaign Discarded Successfully"
			redirect (action:'myproject' , controller:'user')
		} else {
			flash.prj_mngprj_message = 'Campaign Not Found'
			render (view: 'manageproject/error', model: [project: project])
		}
	}

	@Secured(['IS_AUTHENTICATED_FULLY'])
	def customrewardsave() {
		def reward = rewardService.getRewardByParams(params)
		RewardShipping shippingInfo = rewardService.getRewardShippingByParams(params)
		def title = projectService.getVanityTitleFromId(params.id)

		if(reward.save()) {
			def project= projectService.getProjectById(params.id)
			rewardService.setRewardCount(project, reward)
			shippingInfo.reward = reward
			shippingInfo.save(failOnError: true)
			project.addToRewards(reward)
			reward.obsolete = true
			flash.prj_mngprj_message = 'Successfully created a new perk'
			redirect(controller: 'project', action: 'manageproject',fragment: 'rewards', params:['projectTitle':title])
		} else {
			render (view: 'manageproject/error', model: [reward: reward])
		}
	}

	def sendemail() {
		def fundRaiser = params.fr
		projectService.shareCampaignOrTeamByEmail(params,fundRaiser)
		flash.prj_mngprj_message= "Email sent successfully."
		if (params.ismanagepage) {
			redirect(controller: 'project', action: 'manageproject', params:['projectTitle': params.vanityTitle])
		} else {
			redirect (action: 'show', params:[fr: params.vanityUsername, 'projectTitle': params.vanityTitle])
		}
	}

	@Secured(['IS_AUTHENTICATED_FULLY'])
	def projectupdate() {
		def projectId = projectService.getProjectIdFromVanityTitle(params.projectTitle)
		def project = projectService.getProjectById(projectId)
		def currentUser =userService.getCurrentUser()
		def isCampaignOwnerOrAdmin = userService.isCampaignBeneficiaryOrAdmin(project,currentUser)
		if(project) {
			if(!isCampaignOwnerOrAdmin){
				render view:"manageproject/error", model: [project: project]
			}else{
				render (view: 'update/index', model: [project: project, FORMCONSTANTS: FORMCONSTANTS])
			}
		} else {
			render (view: 'manageproject/error', model: [project: project])
		}
	}

	@Secured(['IS_AUTHENTICATED_FULLY'])
	def editCampaignUpdate(){
		def title = projectService.getVanityTitleFromId(params.projectId)
		if(title){
			redirect (action : 'editUpdate', id:params.id, params:['projectTitle':title])
		}else{
			render(view: '/404error', model: [message: 'This project does not exist.'])
		}
	}

    @Secured(['IS_AUTHENTICATED_FULLY'])
    def editUpdate() {
        def projectUpdate = projectService.getProjectUpdateById(params.id)
        def project = projectService.getProjectFromVanityTitle(params.projectTitle)
        def projectUpdates = project.projectUpdates
        if (projectUpdates.contains(projectUpdate)) {
            flash.editUpdateSuccessMsg = "Campaign Update Edited Successfully"
            render (view:'editupdate/index', model:[projectUpdate: projectUpdate, project: project, FORMCONSTANTS: FORMCONSTANTS])
        } else {
            render (view: 'manageproject/error')
        }
    }

	@Secured(['IS_AUTHENTICATED_FULLY'])
	def saveEditUpdate() {
		def project = projectService.getProjectById(params.projectId)
		projectService.editCampaignUpdates(params, project)
		def title = projectService.getVanityTitleFromId(params.projectId)

		flash.saveEditUpdateSuccessMsg = "Campaign Update Edited Successfully!"
		redirect(controller: 'project', action: 'manageproject', params:['projectTitle':title], fragment: 'projectupdates')
	}

    @Secured(['IS_AUTHENTICATED_FULLY'])
    def deleteProjectUpdateImage() {
        def imageUrl = ImageUrl.get(request.getParameter("imageId"))
        def projectUpdate = projectService.getProjectUpdateById(request.getParameter("projectUpdateId"))
        List imageUrls = projectUpdate.imageUrls
        imageUrls.remove(imageUrl)
        if (imageUrl) {
            imageUrl.delete()
        }
        render ''
    }

	@Secured(['IS_AUTHENTICATED_FULLY'])
	def updatesave() {
		def project = projectService.getProjectById(params.id)
		def story = params.story
		def title = projectService.getVanityTitleFromId(params.id)

		if(project ) {
			if (params.imageList || !story.isAllWhitespace()) {

				def projectUpdate = new ProjectUpdate()
				User user = userService.getCurrentUser()

				projectUpdate.story = story
                projectUpdate.title = params.title
				projectService.getUpdatedImageUrls(params.imageList, projectUpdate)

				project.addToProjectUpdates(projectUpdate)
				mandrillService.sendUpdateEmailsToContributors(project,projectUpdate,user,params.title)

				flash.prj_mngprj_message= "Update added successfully."
				redirect (action: 'manageproject', controller:'project', params:['projectTitle':title], fragment: 'projectupdates')
			} else {
				flash.prj_mngprj_message= "No Updates added."
				redirect (action: 'manageproject', controller:'project', params:['projectTitle':title], fragment: 'projectupdates')
			}
		} else {
			render (view: 'manageproject/error', model: [project: project])
		}
	}

	def category (){
		def category
		if(params.category){
		    if(params.category.equalsIgnoreCase("Campaign category")){
			    redirect(action:'list', controller:'project')
		    }else{
			    category=params.category.replace(' ', '-')
			    redirect(url:'/campaigns/category/'+ category)
		    }
		}else if(params.usedfor){
			category=params.usedfor
			redirect(action: 'categoryFilter', controller:'project',params:[usedfor: category])
		}else if(params.country){
			if(params.country.equalsIgnoreCase("Country")){
				redirect(action:'list', controller:'project')	
			}else{
				category = params.country.replace(' ', '-')
				redirect(action: 'categoryFilter', controller:'project',params:[country: category])
			}
		}
		
	}

	def categoryFilter() {
		def countryOptions = projectService.getCountry()
		def currentEnv = Environment.current.getName()
		def discoverLeftCategoryOptions
		if(currentEnv =="testIndia" || currentEnv=="stagingIndia" || currentEnv=="prodIndia"){
			discoverLeftCategoryOptions = projectService.getIndiaCategory()
		}else{
			discoverLeftCategoryOptions=projectService.getCategory()
		}
		def sortsOptions = projectService.getSorts()
		def category
		if(params.category){
			category=params.category
		}else if(params.usedfor){
			category=params.usedfor
		}else if(params.country){
			category=params.country
		}
		
		def project
		if (category == "Social-Innovation"){
			project = projectService.filterByCategory("SOCIAL_INNOVATION", currentEnv)
		}else if (category == "Civic-Needs"){
			project = projectService.filterByCategory("CIVIC_NEEDS", currentEnv)
		}else if (category == "Non-Profits"){
			project = projectService.filterByCategory("NON_PROFITS", currentEnv)
		}else if (category == "All-Categories"){
			project = projectService.filterByCategory("All", currentEnv)
		} else {
			project = projectService.filterByCategory(category, currentEnv)
		}
        flash.catmessage = (project) ? "" : "No campaign found."
        render (view: 'list/index', model: [projects: project, selectedCategory:category.replace('-',' '), countryOptions:countryOptions, sortsOptions:sortsOptions, discoverLeftCategoryOptions:discoverLeftCategoryOptions])
	}

    def addTeam() {
        def request_url=request.getRequestURL().substring(0,request.getRequestURL().indexOf("/", 8))
        def base_url = (request_url.contains('www')) ? grailsApplication.config.crowdera.BASE_URL1 : grailsApplication.config.crowdera.BASE_URL
       
        def reqUrl = base_url+"/project/addFundRaiser?id=${params.id}"
        Cookie cookie = new Cookie("requestUrl", reqUrl)
        cookie.path = '/'    // Save Cookie to local path to access it throughout the domain
        cookie.maxAge= 3600  //Cookie expire time in seconds
        response.addCookie(cookie)
        
        redirect (url: reqUrl)
    }
    
	@Secured(['IS_AUTHENTICATED_FULLY'])
	def addFundRaiser(){
        String requestUrl = g.cookie(name: 'requestUrl')  //get Cookie
        if (requestUrl) {
            def cookie = projectService.setCookie(requestUrl)
            response.addCookie(cookie)
        }
        
		def project = projectService.getProjectById(params.id)
		User user = userService.getCurrentUser()
		def fundraiser = project.user.username
		def iscampaignAdmin = userService.isCampaignBeneficiaryOrAdmin(project, user)
		def message = projectService.getFundRaisersForTeam(project, user)
		def title = projectService.getVanityTitleFromId(params.id)
		def name = userService.getVanityNameFromUsername(fundraiser, params.id)

		if (iscampaignAdmin) {
			flash.prj_mngprj_message = message
			redirect (action: 'manageproject', params:['projectTitle':title])
		} else {
			flash.prj_mngprj_message = message
			redirect (action: 'show', params:['projectTitle':title,'fr':name])
		}
	}

	@Secured(['IS_AUTHENTICATED_FULLY'])
	def inviteTeamMember() {
		def project = projectService.getProjectById(params.id)
		String emails = params.emailIds
		String name = params.username
		String message = params.teammessage
		User user = userService.getCurrentUser()
		def fundraiser =user.username
		def title = projectService.getVanityTitleFromId(params.id)
		def username = userService.getVanityNameFromUsername(fundraiser, params.id)

		if (params.ismanagepage) {
			sendEmailToTeam(emails, name, message, project)
			redirect (action: 'manageproject', params:['projectTitle':title], fragment: 'manageTeam')
		} else {
			sendEmailToTeam(emails, name, message, project)
			redirect (action: 'show', params:['projectTitle':title,'fr':username], fragment: 'manageTeam')
		}
	}

	@Secured(['IS_AUTHENTICATED_FULLY'])
	def editFundraiser(){
		def team = projectService.getTeamById(params.long('id'))
		def fundRaiser = team.user.username
		def title = projectService.getVanityTitleFromId(params.project)
		def username = userService.getVanityNameFromUsername(fundRaiser, params.project)
		if(params) {
			def message = projectService.getEditedFundraiserDetails(params, team)
			flash.teamUpdatemessage = message
		}
		redirect (action: 'show', params:['projectTitle':title,'fr':username], fragment: 'manageTeam')
	}

	@Secured(['IS_AUTHENTICATED_FULLY'])
	def sendEmailToTeam(def emails, def name, def message, Project project){
		def emailList = emails.split(',')
		emailList = emailList.collect { it.trim() }
		mandrillService.sendInvitationForTeam(emailList, name, message, project)
		flash.prj_mngprj_message= "Email sent successfully."
	}

	@Secured(['IS_AUTHENTICATED_FULLY'])
	def saveteamcomment() {
		def message = projectService.getTeamCommentsDetails(params)
		def title = projectService.getVanityTitleFromId(params.id)
		def username = userService.getVanityNameFromUsername(params.fr, params.id)
		flash.prj_mngprj_message = message

		if (!params.ismanagepage) {
			redirect (action: 'show', params:['projectTitle':title,'fr':username], fragment: 'comments')
		} else {
			redirect (action: 'manageproject', params:['projectTitle':title], fragment: 'manageTeam')
		}
	}

	@Secured(['IS_AUTHENTICATED_FULLY'])
	def enableOrDisableTeam() {
		def teamId= request.getParameter('teamId')
		def team = projectService.getTeamById(teamId)
		if(team.enable){
			team.enable = false
		}else{
			team.enable = true
		}
		render ""
	}

	@Secured(['IS_AUTHENTICATED_FULLY'])
	def deletecustomrewards() {
		def reward = rewardService.getRewardById(params.long('id'))
		def project = projectService.getProjectById(params.projectId)
		def shippingInfo = RewardShipping.findByReward(reward)
		def title = projectService.getVanityTitleFromId(params.projectId)
		if(reward){
			project.rewards.remove(reward)
			shippingInfo.reward = null
			shippingInfo.delete()
			reward.delete()
			flash.prj_mngprj_message = 'Successfully deleted a Perk'
		}
		redirect(controller: 'project', action: 'manageproject',fragment: 'rewards', params:['projectTitle':title])
	}

	@Secured(['IS_AUTHENTICATED_FULLY'])
	def contributiondelete() {
		projectService.getContributionDeleteDetails(params)
		def title = projectService.getVanityTitleFromId(params.projectId)
		def username = userService.getVanityNameFromUsername(params.fr, params.projectId)

		if (params.manageCampaign) {
			redirect (controller: 'project',action: 'manageproject', params:['projectTitle':title, offset: params.offset], fragment: 'contributions')
		} else {
			redirect (controller: 'project', action: 'show', params:['projectTitle':title,'fr':username, offset: params.offset], fragment: 'contributions')
		}
	}

	@Secured(['IS_AUTHENTICATED_FULLY'])
	def commentdelete() {
		projectService.getCommentDeletedDetails(params)
		if (params.manageCampaign) {
			redirect(controller: 'project', action: 'manageCampaign',fragment: 'comments', id: params.projectId)
		} else {
			redirect (controller: 'project', action: 'showCampaign',fragment: 'comments', id: params.projectId, params:[fr: params.fr])
		}
	}

	@Secured(['IS_AUTHENTICATED_FULLY'])
	def contributionedit() {
		projectService.getContributionEditedDetails(params)
		def title = projectService.getVanityTitleFromId(params.projectId)
		def username = userService.getVanityNameFromUsername(params.fr, params.projectId)
		if (params.manageCampaign) {
			redirect (controller: 'project',action: 'manageproject', params:['projectTitle':title, offset: params.offset], fragment: 'contributions')
		} else {
		    redirect (controller: 'project', action: 'show', params:['projectTitle':title,'fr':username, offset: params.offset], fragment: 'contributions')
		}
	}

	@Secured(['IS_AUTHENTICATED_FULLY'])
	def generateCSV(){
		def result = projectService.getCSVDetails(params, response)
		render (contentType:"text/csv", text:result)
	}

	@Secured(['IS_AUTHENTICATED_FULLY'])
	def validateteam() {
		def project = projectService.getProjectById(params.id);
		def team = projectService.getTeamById(params.long('teamId'))
		def title = projectService.getVanityTitleFromId(params.id)
		team.validated = true
		mandrillService.sendTeamValidatedConfirmation(project,team.user)
		flash.teamvalidationmessage = "Team validated Successfully."
		redirect(controller: 'project', action: 'manageproject',fragment: 'manageTeam', params:['projectTitle':title])
	}

	@Secured(['IS_AUTHENTICATED_FULLY'])
	def discardteam() {
		def project = projectService.discardTeam(params)
		def title = projectService.getVanityTitleFromId(project.id)
		if(project && title){
			flash.teamdiscardedmessage = "Team Discarded Successfully."
			redirect(controller: 'project', action: 'manageproject',fragment: 'manageTeam', params:['projectTitle':title])
		}else{
			render view:'404error'
		}
	}

	def campaignsSorts(){
		def sorts = params.sorts.replace(' ','-')
		
		if(sorts.equalsIgnoreCase('Sort-by')){
			redirect(action:'list', controller:'project')
		}else{
		 redirect(action:'sortCampaign', controller: 'project',params:[query: sorts])
		}
	}

	def sortCampaign(){
		def countryOptions = projectService.getCountry()
		def environment = Environment.current.getName()
		def discoverLeftCategoryOptions
		if(environment =="testIndia" || environment=="stagingIndia" || environment=="prodIndia"){
			discoverLeftCategoryOptions = projectService.getIndiaCategory()	
		}else{
			discoverLeftCategoryOptions=projectService.getCategory()
		}
		def sortsOptions = projectService.getSorts()
		def sorts = params.query.replace(' ','-')
		
		def campaignsorts = projectService.isCampaignsorts(sorts, environment)
		
		if(!campaignsorts){
			flash.catmessage="No campaign found."
			render (view: 'list/index', model: [projects: campaignsorts,sorts: sorts.replace('-',' '), countryOptions:countryOptions, sortsOptions:sortsOptions, discoverLeftCategoryOptions:discoverLeftCategoryOptions])
		} else {
			render (view: 'list/index', model: [projects: campaignsorts,sorts: sorts.replace('-',' '), countryOptions:countryOptions, sortsOptions:sortsOptions, discoverLeftCategoryOptions:discoverLeftCategoryOptions])
		}
	}
    
	@Secured(['IS_AUTHENTICATED_FULLY'])
	def customrewardedit() {
		def isPerkPriceLess = rewardService.editCustomReward(params)
		def amount = params.amount
		def title = projectService.getVanityTitleFromId(params.projectId)
		if (isPerkPriceLess) {
			flash.perkupdate = 'Perk Updated Successfully!!'
			redirect(controller: 'project', action: 'manageproject',fragment: 'rewards', params:['projectTitle':title])
		} else {
			flash.perkupdate = 'Perk price should be less than campaign amount '+amount
			redirect(controller: 'project', action: 'manageproject',fragment: 'rewards', params:['projectTitle':title])
		}
	}

	@Secured(['IS_AUTHENTICATED_FULLY'])
	def addcampaignsupporter() {
		def project = projectService.getProjectById(params.projectId)
		if (project) {
			def message = userService.getCampaignSupporter(project)
			flash.add_campaign_supporter = message

			def title = projectService.getVanityTitleFromId(params.projectId)
			def name = userService.getVanityNameFromUsername(params.fundRaiser, params.projectId)
			if(title && name){
				redirect (action:'show', params:['projectTitle':title,'fr':name])
			} else {
				render (view: '404error')
			}
		} else {
			render (view: '404error')
		}
	}

	def paypalEmailVerification (){
		def email = request.getParameter("email")
		String str
		String ack

		def BASE_URL = grailsApplication.config.crowdera.paypal.GetVerifiedStatus_URL

		HttpClient httpclient = new DefaultHttpClient()
		HttpPost httppost = new HttpPost(BASE_URL)

		httppost.setHeader("X-PAYPAL-SECURITY-USERID","${grailsApplication.config.crowdera.paypal.X_PAYPAL_SECURITY_USERID}")
		httppost.setHeader("X-PAYPAL-SECURITY-PASSWORD","${grailsApplication.config.crowdera.paypal.X_PAYPAL_SECURITY_PASSWORD}")
		httppost.setHeader("X-PAYPAL-SECURITY-SIGNATURE","${grailsApplication.config.crowdera.paypal.X_PAYPAL_SECURITY_SIGNATURE}")
		// Global Sandbox Application ID
		httppost.setHeader("X-PAYPAL-APPLICATION-ID","${grailsApplication.config.crowdera.paypal.X_PAYPAL_APPLICATION_ID}")
		// Input and output formats
		httppost.setHeader("X-PAYPAL-REQUEST-DATA-FORMAT","${grailsApplication.config.crowdera.paypal.GetVerifiedStatus_REQUEST_DATA_FORMAT}")
		httppost.setHeader("X-PAYPAL-RESPONSE-DATA-FORMAT","${grailsApplication.config.crowdera.paypal.X_PAYPAL_RESPONSE_DATA_FORMAT}")

		StringEntity input = new StringEntity("emailAddress="+email+"&matchCriteria=NONE")

		httppost.setEntity(input)

		HttpResponse httpres = httpclient.execute(httppost)
		int status = httpres.getStatusLine().getStatusCode()
		if (status == 200){
			HttpEntity entity = httpres.getEntity()
			if (entity != null){
				str = EntityUtils.toString(entity)
				def json = new JsonSlurper().parseText(str)
				ack = json.responseEnvelope.ack
			}
		}
		render ack
	}

    @Secured(['IS_AUTHENTICATED_FULLY'])
    def getRedactorImage() {
        def imageFile= params.file
        def fileUrl
        if (imageFile) {
            fileUrl = projectService.getRedactorImageUrl(imageFile)
        }
        JSONObject json = new JSONObject();
        json.put("filelink",fileUrl);
        render json
    }

	@Secured(['IS_AUTHENTICATED_FULLY'])
	def editComment() {
		def vanityUserName = userService.getVanityNameFromUsername(params.fr, params.projectId)
		if (params.commentId || params.teamCommentId) {
			if (params.commentId) {
				redirect (action:'show', controller:'project', fragment: 'comments', params:[projectTitle:params.projectTitle, fr: vanityUserName, commentId: params.commentId])
			}
			if (params.teamCommentId) {
				redirect (action:'show', controller:'project', fragment: 'comments', params:[projectTitle:params.projectTitle, fr: vanityUserName, teamCommentId: params.teamCommentId])
			}
		} else {
			render view:'404error'
		}
	}

	@Secured(['IS_AUTHENTICATED_FULLY'])
	def editCommentSave() {
		ProjectComment projectComment
		TeamComment teamcomment
		def vanityUserName = userService.getVanityNameFromUsername(params.fr, params.projectId)

		if (params.commentId) {
			projectComment = projectService.getProjectCommentById(params.long('commentId'))
			if (projectComment) {
				projectComment.comment = params.comment
			}
		}
		if (params.teamCommentId) {
			teamcomment = projectService.getTeamCommentById(params.long('teamCommentId'))
			if (teamcomment) {
				teamcomment.comment = params.comment
			}
		}
		redirect (action:'show', controller:'project', fragment: 'comments', params:[projectTitle:params.projectTitle, fr:vanityUserName])
	}

    @Secured(['IS_AUTHENTICATED_FULLY'])
    def autoSave() {
        def variable = request.getParameter("variable")
        def varValue = request.getParameter("varValue")
        def projectId = request.getParameter("projectId")
        projectService.autoSaveProjectDetails(variable, varValue, projectId)
        def taxRecieptId = projectService.getTaxRecieptIdByProjectId(projectId)
        render taxRecieptId
    }

    @Secured(['IS_AUTHENTICATED_FULLY'])
    def saveReward() {
        rewardService.autoSaveRewardDetails(params)
        render ''
    }

    @Secured(['IS_AUTHENTICATED_FULLY'])
    def deleteReward(){
        rewardService.deleteReward(params)
        render ''
    }

    @Secured(['IS_AUTHENTICATED_FULLY'])
    def deleteAllRewards(){
        rewardService.deleteAllRewards(params)
        render ''
    }
   
    def contributionList() {
        def username
        if (params.projectId && params.fr){
            username = userService.getUsernameFromVanityName(params.fr)
            User user = userService.getUserByUsername(username)
            Project project = projectService.getProjectById(params.projectId)
            Team currentTeam = projectService.getCurrentTeam(project,user)
            def currentUser = userService.getCurrentUser()
            List contributions = []
            List totalContributions = []
            
            def isCrUserCampBenOrAdmin
            def CurrentUserTeam
            if (currentUser) {
                isCrUserCampBenOrAdmin = userService.isCampaignBeneficiaryOrAdmin(project,currentUser)
                CurrentUserTeam = userService.getTeamByUser(currentUser, project)
            }

            if (project.user == user) {
                def contribution = projectService.getProjectContributions(params, project)
                totalContributions = contribution.totalContributions
                contributions = contribution.contributions
            } else {
                def contribution = projectService.getTeamContributions(params, currentTeam)
                totalContributions = contribution.totalContributions
                contributions = contribution.contributions
            }
            
            def multiplier = projectService.getCurrencyConverter();
            def model = [totalContributions : totalContributions, CurrentUserTeam: CurrentUserTeam,isCrUserCampBenOrAdmin: isCrUserCampBenOrAdmin, contributions: contributions, project: project,
                         team: currentTeam, multiplier: multiplier, vanityUsername:params.fr, currentUser: currentUser]
            if (request.xhr) {
                render(template: "show/contributionlist", model: model)
            }
       } else {
            render ''
       }
    }
    
    def teamsList() {
        if (params.projectId && params.fr){
            Project project = projectService.getProjectById(params.projectId)
            
            def teamObj = projectService.getEnabledAndValidatedTeamsForCampaign(project, params)
            def teamOffset = teamObj.maxrange
            def teams = teamObj.teamList
            def totalteams = teamObj.teams
            def multiplier = projectService.getCurrencyConverter();
            
            def model = [teamOffset : teamOffset, teams: teams, totalteams: totalteams, project: project, vanityUsername:params.fr, multiplier: multiplier]
            if (request.xhr) {
                render(template: "show/teamgrid", model: model)
            }
        } else {
            render ''
        }
    }
	
	def teamsMobileList() {
		if (params.projectId && params.fr){
			Project project = projectService.getProjectById(params.projectId)
			
			def teamObj = projectService.getEnabledAndValidatedTeamsForCampaign(project, params)
			def teamOffset = teamObj.maxrange
			def teams = teamObj.teamList
			def totalteams = teamObj.teams
            def multiplier = projectService.getCurrencyConverter();
			
			def model = [teamOffset : teamOffset, teams: teams, totalteams: totalteams, project: project, vanityUsername:params.fr, multiplier: multiplier]
			if (request.xhr) {
				render(template: "show/teamgridmobile", model: model)
			}
		} else {
			render ''
		}
	}
    
    @Secured(['IS_AUTHENTICATED_FULLY'])
    def contributionsList() {
        if (params.projectId){
            Project project = projectService.getProjectById(params.projectId)
            def user = userService.getCurrentUser();
            List contributions = []
            List totalContributions = []
            
            def contribution = projectService.getProjectContributions(params, project)
            totalContributions = contribution.totalContributions
            contributions = contribution.contributions
            def multiplier = projectService.getCurrencyConverter();
            
            def model = [totalContributions : totalContributions, contributions: contributions, project: project, user:user, multiplier: multiplier]
            if (request.xhr) {
                render(template: "manageproject/contributionlist", model: model)
            }
       } else {
            render ''
       }
    }
    
    @Secured(['IS_AUTHENTICATED_FULLY'])
    def teamList() {
        if (params.projectId){
            Project project = projectService.getProjectById(params.projectId)
            def teamObj = projectService.getValidatedTeam(project, params)
            def teamOffset = teamObj.maxrange
            def validatedTeam = teamObj.teamList
            def totalteams = teamObj.teams
            def multiplier = projectService.getCurrencyConverter();
            
            def model = [teamOffset : teamOffset, validatedTeam: validatedTeam, totalteams: totalteams, project: project, multiplier: multiplier]
            if (request.xhr) {
                render(template: "manageproject/teamgrid", model: model)
            }
        } else {
            render ''
        }
    }
    
    @Secured(['ROLE_ADMIN'])
    def paymentslist() {
        def bankInfos = userService.getBankInfoList()
        render (view:'/user/payments/index', model:[bankInfos: bankInfos])
    }

	def saveStory (){
		def projectId = params.projectId
		def varValue = params.story
		projectService.autoSaveProjectDetails('story', varValue, projectId)
		render ''
	}
    
    def uploadImage() {
        def imageFile= params.file
        Project project = projectService.getProjectById(params.projectId);
        JSONObject json = new JSONObject();
        if (project && imageFile) {
            json = projectService.getMultipleImageUrls(imageFile, project)
        }
        
        render json
    }

    def uploadTaxRecieptFiles(){
        def file= params.file
        TaxReciept taxReciept
        Project project = projectService.getProjectById(params.projectId);
        if (project){
            taxReciept = projectService.getTaxRecieptOfProject(project)
        }
        JSONObject json = new JSONObject();
        if (file && taxReciept){
            json = projectService.getTaxRecieptFile(file, taxReciept)
        }
        render json
    }
    
    def uploadOrganizationIcon() {
        def imageFile= params.file
        Project project = projectService.getProjectById(params.projectId);
        JSONObject json = new JSONObject();
        if (project && imageFile) {
            def iconUrl = projectService.getorganizationIconUrl(imageFile, project)
            json.put('filelink',iconUrl)
        }
        render json
    }
    
    def uploadTeamImage() {
        def imageFile= params.file
        Team team = projectService.getTeamById(params.teamId);
        
        JSONObject json = new JSONObject();
        if (team && imageFile) {
            json = projectService.getMultipleImageUrlsForTeam(imageFile, team)
        }
        render json
    }
    
    def uploadUpdateEditImage() {
        def imageFile= params.file
        ProjectUpdate projectUpdate = projectService.getProjectUpdateById(params.projectUpdateId);
        
        JSONObject json = new JSONObject();
        if (projectUpdate && imageFile) {
            json = projectService.getUpdatEditImageUrls(imageFile, projectUpdate)
        }
        render json
    }
    
    def uploadUpdateImage() {
        def imageFile= params.file
        
        JSONObject json = new JSONObject();
        if (imageFile) {
            def iconUrl = projectService.getSavedImageUrl(imageFile)
            json.put('filelink',iconUrl)
        }
        render json
    }

    def deleteCampaignUpdateImage() {
        def imageUrl = projectService.getImageUrlById(request.getParameter("imageId"))
        imageUrl.delete()
        render ''
    }
    
    @Secured(['ROLE_ADMIN'])
    def campaignHistory() {
        Project project = projectService.getProjectById(params.projectId)
        if (project) {
            def numberOfContributions = project.contributions.size()
            def percentageContribution = contributionService.getPercentageContributionForProject(project)
            def numberOFPerks = project.rewards.size()
            def maxSelectedPerkAmount = rewardService.getMostSelectedPerkAmountForCampaign(project)
            def numberOfComments = project.comments.size()
            def numberOfUpdates = project.projectUpdates.size()
            def numberOfTeams = projectService.getEnabledTeam(project)
            def disabledTeams = projectService.getDiscardedTeams(project)
            def highestContribution = contributionService.getHighestContributionDay(project)
            def campaignSupporterCount = projectService.getCampaignSupporterCount(project)
            
            def campaignUrl = projectService.getCampaignShareUrl(project)
            
            def shareCount = getViewAndShareCount(project, campaignUrl)
            
            def model = [project: project, numberOfContributions: numberOfContributions, percentageContribution: percentageContribution, numberOFPerks: numberOFPerks,
                         maxSelectedPerkAmount: maxSelectedPerkAmount, numberOfComments: numberOfComments, numberOfUpdates: numberOfUpdates, 
                         numberOfTeams: numberOfTeams.size(), highestContributionDay: highestContribution.highestContributionDay,highestContributionHour: highestContribution.highestContributionHour ,
                         ytViewCount: shareCount.ytViewCount, campaignUrl: campaignUrl, facebookCount: shareCount.facebookCount, linkedinCount: shareCount.linkedinCount, twitterCount: shareCount.twitterCount, campaignSupporterCount: campaignSupporterCount,
                         disabledTeams: disabledTeams.size()]
            
            if (request.xhr) {
                render(template: "/user/metrics/campaignhistory", model: model)
            }
        }
        
    }
    
    @Secured(['ROLE_ADMIN'])
    def campaignsList() {
        def projectObj = projectService.getProjectList(params)
        def model = [sortedCampaigns: projectObj.projects, totalCampaigns: projectObj.totalCampaigns]
        if (request.xhr) {
            render(template: "/user/metrics/campaigns", model: model)
        }
    }
    
    @Secured(['ROLE_ADMIN'])
    def campaignSearch() {
        def projectObj = projectService.getCampaignBySearchQuery(params)
        def model = [sortedCampaigns: projectObj.projects, totalCampaigns: projectObj.totalCampaigns, searchresultmessage: projectObj.message]
        if (request.xhr) {
            render(template: "/user/metrics/campaigns", model: model)
        }
    }
    
    @Secured(['IS_AUTHENTICATED_FULLY'])
    def generateCampaignCSV() {
        Project project = projectService.getProjectById(params.projectId)
        def campaignUrl = projectService.getCampaignShareUrl(project)
        
        def shareCount = getViewAndShareCount(project, campaignUrl)
        def ytViewCount = shareCount.ytViewCount
        def facebookCount = shareCount.facebookCount
        def twitterCount = shareCount.twitterCount
        def linkedinCount = shareCount.linkedinCount
        
        def result = projectService.generateCSVReportForCampaign(response, project, ytViewCount, linkedinCount, twitterCount, facebookCount)
        render (contentType:"text/csv", text:result)
    }

    def isCustomVanityUrlUnique(){
	    def vanityUrl = request.getParameter("vanityUrl")
	    def projectId = request.getParameter("projectId")
	    def status = projectService.isCustomUrUnique(vanityUrl, projectId)
	    render status
    }
    
    def getViewAndShareCount(Project project, def campaignUrl) {
        // Video Count
        def ytViewCount = 0, facebookCount = 0, twitterCount = 0, linkedinCount = 0
        
        if (project.videoUrl) {
            def videoUrls = project.videoUrl.split('=')
            videoUrls = videoUrls.collect { it.trim() }
            String ytVideoId = videoUrls.last()
            if (ytVideoId.length() == 11) {
                def http = new HTTPBuilder('https://www.googleapis.com/youtube/v3/videos?part=statistics&id='+ytVideoId+'&key=AIzaSyAKICKCeRbrUAwk4pXjbU6hgsSEH8nGw28')
                http.request(Method.GET, ContentType.JSON) {
                    response.success = { resp, reader ->
                        def statistics = reader.items.statistics
                        ytViewCount = statistics.viewCount[0]
                    }
                }
            }
        }
        
        // FaceBook Share Count
        def httpFb = new HTTPBuilder('http://graph.facebook.com/?id=' + campaignUrl)
        httpFb.request(Method.GET, ContentType.JSON) {
            response.success = { resp, reader ->
                facebookCount = reader.shares
            }
        }
       
        // Twitter Share Count
        def httptwit = new HTTPBuilder('http://cdn.api.twitter.com/1/urls/count.json?url=' + campaignUrl + '&callback=?')
        httptwit.request(Method.GET, ContentType.JSON) {
            response.success = { resp, reader ->
                twitterCount = reader.count
            }
        }
        // Linkedin Share Count
        def httpLink = new HTTPBuilder('http://www.linkedin.com/countserv/count/share?url=' + campaignUrl + '&format=json')
        httpLink.request(Method.GET, ContentType.JSON) {
            response.success = { resp, reader ->
                linkedinCount = reader.count
            }
        }
        return [ytViewCount : ytViewCount, facebookCount: facebookCount, twitterCount: twitterCount, linkedinCount: linkedinCount]
    }
	
    def sendEmailToNonUserContributors(){
        projectService.sendEmailTONonUserContributors()
        Cookie messageCookie = new Cookie("message", 'Email send to all non registered contributors')
        messageCookie.path = '/'
        messageCookie.maxAge= 3600
        response.addCookie(messageCookie)
        redirect (action : 'list', controller:'user')
    }
	
    def getCampaignFromShortUrl(){
        def url = params.url
        def projectDetails = projectService.getCampaignFromUrl(url)
        redirect (action:'show', params:[projectTitle:projectDetails.projectTitle, fr: projectDetails.fr])
    }
	
    def embedTile(){
        def project = projectService.getProjectFromVanityTitle(params.projectTitle)
        def currentFundraiser = userService.getUserFromVanityName(params.fr)
        render(view:'/project/manageproject/embedTile', model:[project:project, currentFundraiser:currentFundraiser])
    }

    def saveSpendMatrix(){
        Project project = projectService.getSpendMatrixSaved(params)
        def pieList = projectService.getPieList(project);
        if(request.xhr){
            render(template: "create/pieChartWithoutLabel", model:[project:project, spendAmountPerList:pieList.spendAmountPerList])
        }
    }

    def deleteSpendMatrix(){
        Project project = projectService.getSpendMatrixDeleted(params)
        def pieList = projectService.getPieList(project);
        if(request.xhr){
            render(template: "create/pieChartWithoutLabel", model:[project:project, spendAmountPerList:pieList.spendAmountPerList])
        }
    }

	def getFeedBackCSV(){
		Project project = projectService.getProjectById(params.projectId)
		def result = projectService.importCSVReportForUserFeedback(response, project)
		render (contentType:"text/csv", text:result)
	}
	
    def getCountryVal(){
        def country = projectService.getCountryValue(params.country);
        projectService.autoSaveCountryAndHashTags(params)
        render country
    }

    def deleteTaxReciept(){
        Project project = projectService.getProjectById(params.projectId)
        TaxReciept taxReciept = projectService.getTaxRecieptOfProject(project)
        project.offeringTaxReciept = false;
        if (taxReciept){
            def files = taxReciept.files
            if (files){
                files.removeAll(files)
            }
            taxReciept.delete();
        }
        render ''
    }

    def getImpactText(){
        Project project = projectService.getProjectById(params.projectId)
        def currentEnv = projectService.getCurrentEnvironment()
        projectService.getCategoryAndHashTagsSaved(project, currentEnv, params.selectedCategory)
        if(request.xhr){
            render(template: "create/impactAnalysisText", model:[project:project, currentEnv:currentEnv, loadjs:true])
        }
    }

    def saveRecipientAndHashTags(){
        projectService.saveRecipientAndHashTags(params)
        render''
    }

    def autoSaveCharitableIdAndOrganisationName(){
        Project project = projectService.getProjectById(params.projectId)
        project.organizationName = params.organizationname
        project.charitableId = params.charitableId
        project.save()
        render''
    }

    def autoSaveCityAndHashTags(){
        projectService.getCityAndHashTagsSaved(params)
        render''
    }
    
    def autoSaveUsedForAndHashTags(){
        projectService.getUsedForAndHashTagsSaved(params)
        render''
    }
    
}
