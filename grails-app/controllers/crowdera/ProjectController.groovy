package crowdera

import grails.plugin.springsecurity.annotation.Secured
import grails.util.Environment
import groovy.json.JsonSlurper
import groovyx.net.http.ContentType
import groovyx.net.http.HTTPBuilder
import groovyx.net.http.Method

import java.text.SimpleDateFormat

import javax.servlet.http.Cookie

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

class ProjectController {
	def userService
	def excelImportService
	def rewardService
	def projectService
	def mandrillService
	def contributionService
	def socialAuthService
    CampaignService campaignService;
	def country_code 

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
		DEFAULT_CATEGORY: Project.Category.Education_Schools_PTAs,
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
		LINKEDINURL:'linkedinUrl',
        CITRUSEMAIL: 'citrusEmail',
        WEPAYEMAIL: 'wePayEmail'
	]

	/*def list = {
		def country_code =  projectService.getCountryCodeForCurrentEnv(request)
		def countryOptions = projectService.getCountry()
		def currentEnv = projectService.getCurrentEnvironment()
		def discoverLeftCategoryOptions=projectService.getCategory()
		def sortsOptions = projectService.getSorts()
        
        List projects = projectService.getValidatedProjectsByPercentage(country_code)
		//teamsList.sort{a,b-> b.percentage<=>a.percentage}
		projects.sort{contributionService.getPercentageContributionForProject(it)}
		projects.reverse(true) 
	
		def selectedCategory = "All Categories"
		//def multiplier = projectService.getCurrencyConverter();

		if (projects.size < 1) {
			flash.catmessage="There are no campaigns"
			render (view: 'list/index', model: [countryOptions: countryOptions, sortsOptions: sortsOptions,discoverLeftCategoryOptions: discoverLeftCategoryOptions])
		} else {
			render (view: 'list/index', model: [projects: projects,selectedCategory: selectedCategory, currentEnv: currentEnv, countryOptions: countryOptions, sortsOptions: sortsOptions,
				discoverLeftCategoryOptions:discoverLeftCategoryOptions,country_code:country_code])
		}
	}*/
	
	def sortCampaign(){
		if(params.documentLoaded==null || params.documentLoaded==true){
			ProjectService.allSortedTeams.clear()
		}
		Integer pageSize;
		Integer currentPageNumber;
		params.pageSize = Math.min(pageSize  ?: 6, 50)
		params.currentPageNumber  = params.currentPageNumber  ?: 0  // require offset for pagination
		println("documentLoaded status=="+params.documentLoaded)
		def countryOptions = projectService.getCountry()
		def environment = projectService.getCurrentEnvironment()
		def country_code = params.country_code
		def discoverLeftCategoryOptions = projectService.getCategory()
		def sortsOptions = projectService.getSorts()
		def selectedCategory = "All Categories"
		def sorts = params.query.replace(' ','-')
		def allTeamsList = new ArrayList();
		def team
		def teamsList
		
		if (request.xhr) {
			if(ProjectService.allSortedTeams.isEmpty()) {
				List campaignsorts = projectService.isCampaignsorts(sorts, country_code)
				for(Project prj : campaignsorts) {
					team = projectService.getTeamList(prj,"allSortedTeams")   // if static array list is empty then it first fetch from database
					teamsList = team.toList()
				}

			} else {
				team = ProjectService.allSortedTeams    // if static array list is  not empty then it  fetch from static arraylist
				teamsList = team.toList()
			}
		} else {

			ProjectService.allSortedTeams.clear();

			List campaignsorts = projectService.isCampaignsorts(sorts, country_code)
			for(Project prj : campaignsorts) {
				 team = projectService.getTeamList(prj,"allSortedTeams")   // if static array list is empty then it first fetch from database
				 teamsList = team.toList()
			 }
		}
		
		if(ProjectService.allSortedTeams.isEmpty()) {
			List campaignsorts = projectService.isCampaignsorts(sorts, country_code)
			for(Project prj : campaignsorts){
				team = projectService.getTeamList(prj,"allSortedTeams")         // if static array list is empty then it first fetch from database
				teamsList = team.toList()
			}
			
		}else{
			team = ProjectService.allSortedTeams					 // if static array list is  not empty then it  fetch from static arraylist
			teamsList = team.toList()
		}
		if(!ProjectService.allSortedTeams.empty){
			teamsList.sort{a,b-> b.percentage<=>a.percentage}
	
			use(PaginateableList) {
				allTeamsList = teamsList.toList()
				def to = params.int('currentPageNumber') * 6;
				allTeamsList= allTeamsList.paginate(params.pageSize, to)
			}
		}
		if(params.currentPageNumber==0) {
			if(allTeamsList.size()<1) {
				flash.catmessage="No campaign found."
				render (view: 'list/new-index', model: [projects: allTeamsList,sorts: sorts.replace('-',' '), countryOptions:countryOptions, sortsOptions:sortsOptions, discoverLeftCategoryOptions:discoverLeftCategoryOptions,country_code:country_code,query:sorts])
			} else {
				render (view: 'list/new-index', model: [projects: allTeamsList,sorts: sorts.replace('-',' '), countryOptions:countryOptions, sortsOptions:sortsOptions, discoverLeftCategoryOptions:discoverLeftCategoryOptions,country_code:country_code,query:sorts])
			}
		}else{
				render (template: 'list/new-grid', model: [projects: allTeamsList,selectedCategory: selectedCategory, countryOptions: countryOptions, sortsOptions: sortsOptions,
												   discoverLeftCategoryOptions:discoverLeftCategoryOptions,currentPageNumber:params.currentPageNumber,pageSize:params.pageSize,country_code:country_code,query:sorts])
		}
	}
	
	def list = {
		Integer pageSize;
		Integer currentPageNumber;
		params.pageSize = Math.min(pageSize  ?: 6, 50)
		params.currentPageNumber  = params.currentPageNumber  ?: 0  // require offset for pagination
	   
		def country_code =  projectService.getCountryCodeForCurrentEnv(request)
		def countryOptions = projectService.getCountry()
		def currentEnv = projectService.getCurrentEnvironment()
		def discoverLeftCategoryOptions=projectService.getCategory()
		def sortsOptions = projectService.getSorts()
		def isDeviceMobileOrTab = isDeviceMobileOrTab();
		def selectedCategory = "All Categories"
		def team
		def teamsList
		
		if(ProjectService.allTeams.isEmpty()) {
			def projects = projectService.getValidatedProjectsByPercentage(country_code)//projectService.getValidatedProjects(currentEnv)
			for(Project prj : projects){
					team = projectService.getTeamList(prj,"allTeams")   // if static array list is empty then it first fetch from database
					teamsList = team.toList()
			}

		}else{
			team = ProjectService.allTeams	// if static array list is  not empty then it  fetch from static arraylist
			teamsList = team.toList()
		}

		teamsList.sort{a,b-> b.percentage<=>a.percentage}
		
		def allTeamsList = new ArrayList();
		use(PaginateableList){
			allTeamsList = teamsList.toList()
			/*println("pageSize : "+ params.pageSize+ " currentPageNumber : "+ params.currentPageNumber )*/
			def to = params.int('currentPageNumber') * 6;
			allTeamsList= allTeamsList.paginate(params.pageSize, to)
		}
		
		if(params.currentPageNumber == 0) {
			if(allTeamsList.isEmpty()) {
				flash.catmessage="There are no campaigns"
				render (view: 'list/new-index', model: [countryOptions: countryOptions, sortsOptions: sortsOptions,discoverLeftCategoryOptions: discoverLeftCategoryOptions])
			}else {
				render (view: 'list/new-index', model: [projects: allTeamsList,selectedCategory: selectedCategory, currentEnv: currentEnv, countryOptions: countryOptions, sortsOptions: sortsOptions,
														discoverLeftCategoryOptions:discoverLeftCategoryOptions,currentPageNumber:currentPageNumber,pageSize:pageSize,country_code:country_code,isDeviceMobileOrTab:isDeviceMobileOrTab])

			}
		} else {
			render (template: 'list/new-grid', model: [projects: allTeamsList,selectedCategory: selectedCategory, currentEnv: currentEnv, countryOptions: countryOptions, sortsOptions: sortsOptions,
												   discoverLeftCategoryOptions:discoverLeftCategoryOptions,currentPageNumber:params.currentPageNumber,pageSize:params.pageSize,country_code:country_code,isDeviceMobileOrTab:isDeviceMobileOrTab])
		}
	}

	@Category(List) // From Colin Harrington's post
	class PaginateableList {
		List paginate(max, offset=0 ) {
			
			/*println("max:=="+ max)
			print("offset:=="+ offset)
			println("Hello1 "+Math.min( offset as Integer, this.size() ))
			println("Hello2 "+Math.min( (offset as Integer) + (max as Integer), this.size() ))*/

			((max as Integer) <= 0 || (offset as Integer) < 0) ? [] : this.subList( Math.min( offset as Integer, this.size() ), Math.min( (offset as Integer) + (max as Integer), this.size() ) )
		}
	}

	def listwidget = {
		def projects = projectService.getValidatedProjects()
		render (view: 'list/index', model: [projects: projects])
	}

	def search () {
		def currentEnv = projectService.getCurrentEnvironment()
		def query = params.q
		def countryOptions = projectService.getCountry()
		def discoverLeftCategoryOptions=projectService.getCategory()
		def sortsOptions = projectService.getSorts()
		if(query) {
			List searchResults = projectService.search(query, currentEnv)
			if (searchResults.empty){
				flash.catmessage = "No Campaign found matching your input."
				redirect(action:"list")
			} else {
				searchResults.sort{x,y -> x.title<=>y.title ?: x.story<=>y.story}
				render(view: "list/index", model:[projects: searchResults, countryOptions:countryOptions, sortsOptions:sortsOptions, discoverLeftCategoryOptions:discoverLeftCategoryOptions,country_code:country_code])
			}
		} else {
			redirect(controller: "home", action: "index")
		}
	}

	def showCampaign() {
		def title = projectService.getVanityTitleFromId(params.id)
		def name = userService.getVanityNameFromUsername(params.fr, params.id)
		def projectId = params?.id
		Project project = projectService.getProjectById(projectId)
		def country_code = project.country.countryCode
		if(title && name){
			if(params.isPreview){
				if(params.tile){
					redirect (action :'previewTile', params:['projectTitle':title, 'fr':name]);
				}else{
					redirect (action :'preview', params:['projectTitle':title, 'fr':name]);
				}
			} else {
				redirect (action:'show', params:['projectTitle':title,'fr':name,'country_code':country_code,'category':project.fundsRecievedBy.toLowerCase()])
			}
		} else {
			render(view: '/404error', model: [message: 'This campaign does not exist.'])
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
	
	
	def displayProjectFromCustomUrl(){
		def projectId
		
		if (params?.projectTitle){
			projectId = projectService.getProjectIdFromVanityTitle(params?.projectTitle)
		}
		Project project = projectService.getProjectById(projectId)
		
		def country_code = project?.country?.countryCode
		
		redirect (action:'show', params:['projectTitle':params.projectTitle,'country_code':country_code.toLowerCase()]);
	}

	def show() {
		
		def projectId
		def username
		country_code = params.country_code
		if (params?.projectTitle) {
			projectId = projectService.getProjectIdFromVanityTitle(params?.projectTitle)
		} else {
			projectId = params?.id
		}
		Project project = projectService.getProjectById(projectId)
		
        def vanityUsername
        
		if (project) {
            username = (params?.fr != null) ? userService.getUsernameFromVanityName(params?.fr) : project?.user?.username
            vanityUsername = (params.fr != null) ? params?.fr : userService.getVanityNameFromUsername(username, projectId)
            
			def shortUrl = projectService.getShortenUrl(project.id, params?.fr)
			def request_url=request.getRequestURL().substring(0,request.getRequestURL().indexOf("/", 8))
			def base_url = (request_url.contains('www')) ? grailsApplication.config.crowdera.BASE_URL1 : grailsApplication.config.crowdera.BASE_URL
			
            User user = userService.getUserByUsername(username)
            def projectimages = projectService.getProjectImageLinks(project)
			def currentUser = userService.getCurrentUser()
			def currentEnv = projectService.getCurrentEnvironment()
			def currentFundraiser = userService.getCurrentFundRaiser(user, project)
			Team currentTeam = projectService.getCurrentTeam(project,currentFundraiser)
			def totalContribution = contributionService.getTotalContributionForProject(project)
			def percentage = contributionService.getPercentageContributionForProject(totalContribution, project)

			def teamContribution = contributionService.getTotalContributionForUser(project?.country?.countryCode, currentTeam?.contributions, project?.country?.currency?.dollar)
			
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

			String campaignUrl =  grailsApplication.config.crowdera.BASE_URL +'/'+params.projectTitle
			int facebookCount = projectService.getFacebookShareCountForCampaign(campaignUrl)
			String facebookShare= (facebookCount > 1)?facebookCount + ' shares': facebookCount + ' share'
			
			/*Send feedback email before campaign end date */
			//projectService.sendFeedbackEmailToOwners(project, base_url)

			if (project?.user == currentTeam?.user) {
				def contribution = projectService.getProjectContributions(params, project)
				totalContributions = contribution?.totalContributions
				contributions = contribution?.contributions
			} else {
				def contribution = projectService.getTeamContributions(params, currentTeam)
				totalContributions = contribution?.totalContributions
				contributions = contribution?.contributions
			}

			if (currentUser) {
				isCrUserCampBenOrAdmin = userService.isCampaignBeneficiaryOrAdmin(project,currentUser)
				isTeamExist = userService.isValidatedTeamExist(project, currentUser)
				CurrentUserTeam = userService.getTeamByUser(currentUser, project)
			}

			def teamObj = projectService.getEnabledAndValidatedTeamsForCampaign(project, params)
			def teamOffset = teamObj?.maxrange
			def teams = teamObj?.teamList
			def totalteams = teamObj?.teams

			boolean ended = projectService.isProjectDeadlineCrossed(project)
			boolean isFundingOpen = projectService.isFundingOpen(project)
			def rewards = rewardService.getSortedRewards(project);
			def day= projectService.getRemainingDay(project)
			def endDate = projectService.getProjectEndDate(project)
			def webUrl = projectService.getWebUrl(project)

			if (params?.commentId) {
               
				projectComment = projectService.getProjectCommentById(params.long('commentId'))
				
			}
			if (params?.teamCommentId) {
				teamcomment = projectService.getTeamCommentById(params.long('teamCommentId'))
			}

			def projectComments = projectService.getProjectComments(project)
			def teamComments = projectService.getTeamComments(currentTeam)
			def offset = params.int('offset') ?: 0

          //  def multiplier = projectService.getCurrencyConverter();
            
            def pieList = projectService.getPieList(project);
            def hasTags = projectService.getHashTagsForCampaign(project.hashtags)
            
            def reasons = projectService.getReasonsToFundFromProject(project)
            def isDeviceMobileOrTab = isDeviceMobileOrTab();
            
            boolean isTaxReceipt = campaignService.isTaxReceiptExist(project.id);
			
			def wepayAccountStatus = project.wepayAccountStatus
			if (project.wepayEmail && project.wepayAccountId != 0) {
				// wepayAccountStatus = campaignService.getWepayAccountStatus(project.wepayAccountId, project.wepayAccessToken);
				log.info("Wepay Account Status = "+ wepayAccountStatus)
			}
            
            if((currentUser == project.user) && (project.draft || project.validated==false)){
                render (view: 'show/preview',
                model: [project: project, user: user,currentFundraiser: currentFundraiser, currentTeam: currentTeam, endDate: endDate, 
                        isCampaignAdmin: isCampaignAdmin, projectComments: projectComments, totalteams: totalteams,
                        totalContribution: totalContribution, percentage:percentage, teamContribution: teamContribution, 
                        contributions: contributions, webUrl: webUrl, teamComments: teamComments, totalContributions:totalContributions,
                        teamPercentage: teamPercentage, ended: ended, teams: teams, currentUser: currentUser, day: day, 
                        CurrentUserTeam: CurrentUserTeam, isEnabledTeamExist: isEnabledTeamExist, offset: offset, teamOffset: teamOffset,
                        isCrUserCampBenOrAdmin: isCrUserCampBenOrAdmin, isCrFrCampBenOrAdmin: isCrFrCampBenOrAdmin, 
                        isFundingOpen: isFundingOpen, rewards: rewards, projectComment: projectComment, teamcomment: teamcomment,
                        isTeamExist: isTeamExist, vanityTitle: params?.projectTitle, vanityUsername: vanityUsername, FORMCONSTANTS: FORMCONSTANTS, 
                        isPreview:params?.isPreview, tile:params?.tile, shortUrl:shortUrl, base_url:base_url,
                        spendCauseList:pieList.spendCauseList, spendAmountPerList:pieList.spendAmountPerList, reasons:reasons,
                        isDeviceMobileOrTab:isDeviceMobileOrTab, currentEnv: currentEnv, firstFiveHashtag: hasTags.firstFiveHashtag, firstThreeHashtag: hasTags.firstThreeHashtag,
                        remainingHashTags: hasTags.remainingHashTags, remainingHashTagsTab: hasTags.remainingHashTagsTab, hashtagsList: hasTags.hashtagsList, projectimages: projectimages, isTaxReceipt: isTaxReceipt])
            }else{
               if(project.validated){
                   render (view: 'show/index',
                       model: [project: project, user: user,currentFundraiser: currentFundraiser, currentTeam: currentTeam, endDate: endDate,
                               isCampaignAdmin: isCampaignAdmin, projectComments: projectComments, totalteams: totalteams,
                               totalContribution: totalContribution, percentage:percentage, teamContribution: teamContribution,
                               contributions: contributions, webUrl: webUrl, teamComments: teamComments, totalContributions:totalContributions,
                               teamPercentage: teamPercentage, ended: ended, teams: teams, currentUser: currentUser, day: day,
                               CurrentUserTeam: CurrentUserTeam, isEnabledTeamExist: isEnabledTeamExist, offset: offset, teamOffset: teamOffset,
                               isCrUserCampBenOrAdmin: isCrUserCampBenOrAdmin, isCrFrCampBenOrAdmin: isCrFrCampBenOrAdmin,
                               isFundingOpen: isFundingOpen, rewards: rewards, projectComment: projectComment, teamcomment: teamcomment,
                               isTeamExist: isTeamExist, vanityTitle: params.projectTitle, vanityUsername: vanityUsername, FORMCONSTANTS: FORMCONSTANTS,
                               isPreview:params.isPreview, tile:params.tile, shortUrl:shortUrl, base_url:base_url,
                               spendCauseList:pieList.spendCauseList, spendAmountPerList:pieList.spendAmountPerList, reasons:reasons,
                               isDeviceMobileOrTab:isDeviceMobileOrTab, currentEnv: currentEnv, firstFiveHashtag: hasTags.firstFiveHashtag, firstThreeHashtag: hasTags.firstThreeHashtag,
                               remainingHashTags: hasTags.remainingHashTags, remainingHashTagsTab: hasTags.remainingHashTagsTab, hashtagsList: hasTags.hashtagsList, projectimages: projectimages,
                               facebookShare: facebookShare, isTaxReceipt: isTaxReceipt,country_code:country_code,fr:username,projectTitle:params?.projectTitle,
							   'category':project.fundsRecievedBy.toLowerCase(), 'wepayAccountStatus' : wepayAccountStatus])
				   
               }else{
                  render(view: '/404error', model: [message: 'This campaign is under process.'])
               }
            } 
		} else {
			render(view: '/404error', model: [message: 'This campaign does not exist.'])
		}
	}
    
    def campaignShare() {
        def title = projectService.getVanityTitleFromId(params.id)
        def name = userService.getVanityNameFromUsername(params.fr, params.id)
        redirect (action:'show', params:['projectTitle':title,'fr':name])
    }
    
    def updateShare(){
        def title = projectService.getVanityTitleFromId(params.id)
        def name = userService.getVanityNameFromUsername(params.fr, params.id)
        redirect (action:'show', params:['projectTitle':title,'fr':name], fragment:'projectupdates')
    }

    def isDeviceMobileOrTab(){
        String userAgent = request.getHeader("User-Agent");
        if (userAgent?.contains('Mobile') || userAgent?.contains('Android') || userAgent?.contains('iPod')){
            return true
        } else {
            return false
        }
    }

	def showMoreteam() {
		def vanityTitle = params.projectTitle
		redirect (controller: 'project', action: 'show', params:['projectTitle':vanityTitle,'fr': params.fr, teamOffset: params.teamOffset], fragment: 'manageTeam')
	}

	@Secured(['IS_AUTHENTICATED_FULLY'])
	def validateShowCampaign(){
		def title = projectService.getVanityTitleFromId(params.id)
		def name = userService.getVanityNameFromUsername(params.fr, params.id)
		if(title && name){
			redirect (action:'validateshow', params:['projectTitle':title,'fr':name])
		}else{
			render view:"404error"
		}
	}

    @Secured(['IS_AUTHENTICATED_FULLY'])
    def validateshow() {
        if (userService.isAdmin() || userService.isPartner()) {
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
                def totalContribution = 0;/*contributionService.getTotalContributionForProject(project)*/
                def percentage = 0;/*contributionService.getPercentageContributionForProject(totalContribution, project)*/
                
                def teamContribution
                def teamPercentage
                if (currentTeam) {
                    teamContribution = 0;/*contributionService.getTotalContributionForUser(currentTeam.contributions)*/
                    teamPercentage = 0;/*contributionService.getPercentageContributionForTeam(teamContribution, currentTeam)*/
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
                List totalContributions = []
                List contributions = []
                
                def projectComments = projectService.getProjectComments(project)
                def teamComments = projectService.getTeamComments(currentTeam)
                //def multiplier = projectService.getCurrencyConverter();

                def pieList = projectService.getPieList(project);
                
                def hasTags = projectService.getHashTagsForCampaign(project.hashtags)
                
                def reasons = projectService.getReasonsToFundFromProject(project)
                
                def taxReceipt = projectService.getTaxRecieptOfProject(project)
                def deductibleStatus
                if (taxReceipt){
                    deductibleStatus = projectService.getDeductibleStatus(taxReceipt?.deductibleStatus)
                }
                
                if(project.validated == false) {
                    render (view: 'validate/validateshow',
                    model: [project: project, user: user,currentFundraiser: currentFundraiser, currentTeam: currentTeam, 
                    endDate: endDate,projectComments: projectComments,totalteams: totalteams,totalContribution: totalContribution, 
                    percentage:percentage, teamContribution: teamContribution, webUrl: webUrl,teamComments: teamComments, 
                    teamOffset: teamOffset,teamPercentage: teamPercentage, ended: ended, teams: teams, currentUser: currentUser, 
                    day: day,totalContributions: totalContributions,contributions: contributions, deductibleStatus:deductibleStatus,
                    isCrUserCampBenOrAdmin: isCrUserCampBenOrAdmin, isCrFrCampBenOrAdmin: isCrFrCampBenOrAdmin, 
                    isFundingOpen: isFundingOpen, rewards: rewards,validatedPage: validatedPage, isTeamExist: isTeamExist, 
                    FORMCONSTANTS: FORMCONSTANTS, spendCauseList:pieList.spendCauseList, 
                    spendAmountPerList:pieList.spendAmountPerList, reasons:reasons, taxReceipt:taxReceipt,
                    firstFiveHashtag: hasTags.firstFiveHashtag, firstThreeHashtag: hasTags.firstThreeHashtag,
                    remainingHashTags: hasTags.remainingHashTags, remainingHashTagsTab: hasTags.remainingHashTagsTab, hashtagsList: hasTags.hashtagsList])
                }
            } else {
                render (view: '404error')
            }
        }
    }

	@Secured(['IS_AUTHENTICATED_FULLY'])
	def updateValidation() {
        if (userService.isAdmin()) {
            if (params.id) {
                projectService.getUpdateValidationDetails(params)
            }
            flash.prj_validate_message= "Campaign validated successfully"
            redirect (action:'getCampaignList')
        } else if (userService.isPartner()) {
            if (params.id) {
                projectService.getUpdateValidationDetails(params)
            }
            flash.prj_validate_message= "Campaign validated successfully"
            redirect (action:'partnerdashboard', controller:'user')
        } else {
            render view:'/401error'
        }
	}

    @Secured(['IS_AUTHENTICATED_FULLY'])
    def delete() {
        def project = projectService.getProjectById(params.id)
        User user = userService.getCurrentUser()
        def currentEnv = projectService.getCurrentEnvironment()
        
        if (project) {
            if (userService.isAdmin()) {
                project.rejected = true
                flash.prj_validate_message= "Campaign discarded successfully!"
                redirect (action:'getCampaignList')
            } else if (userService.isPartner() && userService.isPartnerValidated(user)) {
                project.rejected = true
                flash.prj_validate_message= "Campaign discarded successfully!"
                redirect (action:'partnerdashboard', controller:'user')
            } else {
                render view:'/401error'
            }
        } else {
            flash.prj_validate_err_message = 'Campaign Not Found'
//            render (view: 'validate/validateerror', model: [project: project])
            def previousPage = "validate"
            render (view: 'edit/editerror', model:[project: project, currentEnv:currentEnv, previousPage:previousPage])
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
		def country_code = project.country.countryCode
		if (project) {
			if(project.validated == true){
				redirect (action:'showCampaign', id:project.id,params:['country_code':country_code])
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
		def currentEnv = projectService.getCurrentEnvironment()
		def projects = projectService.getNonValidatedProjects(currentEnv)
        if (flash.prj_validate_message) {
            flash.prj_validate_message = "Campaign validated successfully"
        }
		render(view: 'validate/index', model: [projects: projects])
	}
    
    @Secured(['ROLE_ADMIN'])
    def getCampaignList() {
		def country_code = projectService.getCountryCodeForCurrentEnv(request)
        def countryOpts = [India: 'INDIA', USA: 'USA']
        def sortByOptions = projectService.getSortingList()
        def environment = projectService.getCurrentEnvironment()
        def projects
        
        def isAdmin = userService.isAdmin()
        
		if('in'.equalsIgnoreCase(country_code)){
            projects = projectService.getValidatedProjectsForCampaignAdmin('Pending', 'INDIA')
        } else {
            projects = projectService.getValidatedProjectsForCampaignAdmin('Pending', 'USA')
        }
        
        if (flash.prj_validate_message) {
            flash.prj_validate_message = "Campaign validated successfully"
        }
        
        render (view: 'campaigns/index', model: [projects: projects, environment: environment, countryOpts: countryOpts,
                                                 sortByOptions: sortByOptions, isAdmin: isAdmin])
    }
    
    @Secured(['ROLE_ADMIN'])
    def getCampaignsByFilter() {
        def projects = projectService.getValidatedProjectsForCampaignAdmin(params.selectedSortValue, params.country)
      //  def multiplier = projectService.getCurrencyConverter();
        def currentEnv = projectService.getCurrentEnvironment()
        def isAdmin = userService.isAdmin()
        
        def model = [projects: projects, currentEnv: currentEnv, isAdmin: isAdmin]
        
        if (request.xhr) {
            if (params.selectedSortValue == 'Pending') {
                render(template: "/project/validate/validategrid", model: model)
            }else if(params.selectedSortValue=='Homepage'){
            
                def homePageCampaigns = projectService.getHomePageCampaignByEnv(currentEnv)
                
                if(homePageCampaigns){
                    render(template: "/project/validate/homepage", model: [projects:projects, campaignOne: homePageCampaigns.campaignOne.title,
                        campaignTwo: homePageCampaigns.campaignTwo.title, campaignThree: homePageCampaigns.campaignThree.title, currentEnv:currentEnv])
                }else{
                    render(template: "/project/validate/homepage", model: [projects:projects, currentEnv:currentEnv])
                }
                
            }else if(params.selectedSortValue=='Deadline'){
            
                def deadlinDays= projectService.getInDays()
                render(template: "/project/validate/deadline", model: [projects:projects, currentEnv:currentEnv, deadlinDays: deadlinDays])
                
            }else if(params.selectedSortValue=='Deleted'){
            
                render(template:"/project/validate/deletedcampaigns", model:[projects:projects, currentEnv:currentEnv])
                
            }else if(params.selectedSortValue== 'Carousel'){
            
                render(template:"/project/validate/homepagecarousel", model:[projects:projects, currentEnv:currentEnv])
                
            }  else {
                render(template: "/user/user/grid", model: model)
            }
        }
    }
    
    @Secured(['IS_AUTHENTICATED_FULLY'])
    def ContributorNames() {
        def teamContributionList = contributionService.getContributionListByTeamId(params.long('teamId'))
        
        if(teamContributionList.isEmpty()){
            render(contentType: 'text/json') {['data': '']}
        } else{
            render(contentType: 'text/json') {['data': teamContributionList]}
        }
    }
    
    @Secured(['IS_AUTHENTICATED_FULLY'])
    def manageCampaignDeadline(){
        
        def project
        def projects = projectService.getValidatedProjects()
        
        if(params.campaignSelection && params.deadline){
            project = projectService.getProjectFromTitle(params.campaignSelection)
            
            if(project){
                projectService.setCampaignDeadline(project, params.int('deadline'), params.int('extendDays'))
            }
        }
        
        render(template: "/project/validate/deadline", model:[projects: projects.title, project:project, extendDays: params.extendDays])
    }
    
    @Secured(['IS_AUTHENTICATED_FULLY'])
    def setCampaignCurrentDays(){
        def campaign = projectService.getProjectFromTitle(params.campaign)
        
        if(campaign){
            def daysLeft = projectService.getRemainingDay(campaign);
            def days= campaign.days
            render (contentType: 'text/json') {['daysLeft': daysLeft, 'days': days]}
        }else{
            render (contentType: 'text/json') {['daysLeft': 0, 'days': 0]}
        }
    }
    
    @Secured(['IS_AUTHENTICATED_FULLY'])
    def manageHomePageCampaigns(){
        
        def projects = projectService.getValidatedProjects()
        def liveProjects = projectService.getLiveProjects(projects)
        def currentEnv = params.currentEnv
        def homePageCampaigns = projectService.getHomePageCampaignByEnv(currentEnv)
        
        if(params.campaignOne && params.campaignTwo && params.campaignThree){
            def campaignOneId = projectService.getProjectFromTitle(params.campaignOne)
            def campaignTwoId = projectService.getProjectFromTitle(params.campaignTwo)
            def campaignThreeId = projectService.getProjectFromTitle(params.campaignThree)
            
            if(homePageCampaigns){
                projectService.setHomePageCampaignByEnv(campaignOneId, campaignTwoId, campaignThreeId, currentEnv )
            }else{
                new HomePageCampaigns(campaignOne:campaignOneId, campaignTwo:campaignTwoId, campaignThree:campaignThreeId, currentEnv:currentEnv).save()
            }
            
            render(template: "/project/validate/homepage", model:[projects:liveProjects, campaignOne:campaignOneId,
                campaignTwo: campaignTwoId, campaignThree: campaignThreeId])
        }else{
        
            if(homePageCampaigns){
                render(template: "/project/validate/homepage", model:[projects:liveProjects, campaignOne:campaignOneId,
                     campaignTwo: campaignTwoId, campaignThree: campaignThreeId])
            }else{
                render(template: "/project/validate/homepage", model:[projects:liveProjects])
            }
        }
    }
    
    def comment() {
        User user = userService.getCurrentUser()
        def base_url = grailsApplication.config.crowdera.BASE_URL
       
        CommonsMultipartFile projectcomment = params.attachedFileForProject
        def fileUrl = projectService.setAttachedFileForProject(projectcomment)
        
        def reqUrl= base_url+"project/savecomment?comment=${params.comment}&id=${params.id}&fr=${params.fr}&fileComment=${fileUrl}&managecomments=${params.managecomments}&campaign_country_code=${params.campaign_country_code}"
            Cookie cookie = new Cookie("requestUrl", reqUrl)
            cookie.path = '/'
            cookie.maxAge= 600
            response.addCookie(cookie)
        redirect (url: reqUrl)
    }

    def teamcomment() {
        User user = userService.getCurrentUser()
        def base_url = grailsApplication.config.crowdera.BASE_URL
        
        CommonsMultipartFile projectcomment = params.teamAttachFile
        def teamfileUrl = projectService.setAttachedFileForProject(projectcomment)
        
        def reqUrl
        if (!user) {
            Cookie cookie = new Cookie("requestUrl", reqUrl)
            cookie.path = '/'
            cookie.maxAge= 600
            response.addCookie(cookie)
        }
        reqUrl = base_url+"project/saveteamcomment?comment=${params.comment}&id=${params.id}&fr=${params.fr}&teamfileComment=${teamfileUrl}"
        redirect (url: reqUrl)
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
		if (params.managecomments.equals("manageCampaign")) {
		    redirect(controller: 'project', action: 'manageCampaign',fragment: 'comments', id: params.id,params:[country_code:params.campaign_country_code])
		} else {
		    redirect (action: 'show', params:['projectTitle':title,'fr':name], fragment: 'comments')
		}
	}

	@Secured(['IS_AUTHENTICATED_FULLY'])
	def updatecomment(){
          def checkid= request.getParameter('checkID')
          def proComment = projectService.getProjectCommentById(checkid)
          def status = request.getParameter('status')
          def currentUser = userService.getCurrentUser()
          def project = projectService.getProjectByComment(proComment)
          
          if(project){
              def projectAdmin = userService.isCampaignBeneficiaryOrAdmin(project, currentUser)
              def projectUser = project.user.email.toString().replace('[','').replace(']','')
              if(projectUser.equals(currentUser.username) || projectAdmin){
                  if(status=='false'){
                      proComment.status=false
                  }else{
                      proComment.status=true
                  }
              }
              render ""
          }else{
           render ""
          }
	}
    
    def createCampaign() {
        Cookie cookie = new Cookie("inviteCode", params.id)
        cookie.path = '/'    // Save Cookie to local path to access it throughout the domain
        cookie.maxAge= 60  //Cookie expire time in seconds
        response.addCookie(cookie)
        
        redirect action:'create'
    }


	def create() {
        def currentEnv = projectService.getCurrentEnvironment()
        String partnerInviteCode = g.cookie(name: 'inviteCode')
        def inDays = projectService.getInDays()
		def country = projectService.getCountryCodeForCurrentEnv(request)
		render(view: 'create/index1', model: [FORMCONSTANTS: FORMCONSTANTS, currentEnv: currentEnv, partnerInviteCode: partnerInviteCode, inDays:inDays,country_code:country])
	}

    def saveCampaign() {
        def request_url=request.getRequestURL().substring(0,request.getRequestURL().indexOf("/", 8))
        def base_url = (request_url.contains('www')) ? grailsApplication.config.crowdera.BASE_URL1 : grailsApplication.config.crowdera.BASE_URL

        def amount = params.amount ? params.amount : params.amount1;
        def currentdays = params.days ? params.days : params.days1
        def days = Integer.parseInt(currentdays)

        def reqUrl = base_url+ params.country_code+"/project/createNow?firstName=${params.firstName}&amount=${amount}&title=${params.title}&description=${params.description}&usedFor=${params.usedFor}&days=${days}&customVanityUrl=${params.customVanityUrl}&partnerInviteCode=${params.partnerInviteCode}&country_code=${params.country_code}"
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
        Project project = new Project()
        if (params.title && params.amount && params.description && params.firstName) {
            project = projectService.getProjectByParams(params)
            def beneficiary = userService.getBeneficiaryByParams(params)
            def user = userService.getCurrentUser()
            project.draft = true;
            
            
            //Send draft creation email to info@crowdera.co
            def currentEnv = projectService.getCurrentEnvironment()
            if(currentEnv == 'production' || currentEnv== 'prodIndia'){
                SimpleDateFormat dateFormat = new SimpleDateFormat("MM/dd/yyyy");
                mandrillService.sendDraftInfoEmail(params.title, user, currentEnv, dateFormat.format(project.created), project.beneficiary.telephone )
            }
            
			def country = projectService.getCountryByCountryCode(params.country_code)
            project.beneficiary = beneficiary;
            project.beneficiary.email = user.email;
			project.country = country
			project.fundsRecievedBy = "NGO";

            if (params.usedFor == 'SOCIAL_NEEDS') {
                project.hashtags = '#Social-Innovtion'
            } else if (params.usedFor == 'PERSONAL_NEEDS'){
                project.hashtags = '#Personal-Needs'
            } else if (params.usedFor == 'IMPACT'){
                project.hashtags = '#Impact';
            } else if (params.usedFor == 'PASSION'){
                project.hashtags = '#Passion';
            }

		    project.usedFor = params.usedFor;

			if('in'.equalsIgnoreCase(params.country_code)){
				project.payuStatus = true
			}
			
			if(project.save(failOnError: true)) {
                projectTitle = (project.customVanityUrl)? projectService.getCustomVanityUrl(project) : projectService.getProjectVanityTitle(project)
                projectService.getFundRaisersForTeam(project, user)
                projectService.getdefaultAdmin(project, user)
                redirect(action:'redirectCreateNow', params:[title:projectTitle,country_code:params.country_code])
            } else {
                def url = "/campaign/create"
                def previousPage = "create"
                render view:'/project/create/createerror', model:[project: project, url: url, previousPage: previousPage]
            }
        } else {
            def url = "/campaign/create"
            def previousPage = "create"
            render view:'/project/create/createerror', model:[project: project, url: url, previousPage: previousPage]
        }
    }
	
    @Secured(['IS_AUTHENTICATED_FULLY'])
    def redirectCreateNow() {
        def vanityTitle = params.title
        Project project = projectService. getProjectFromVanityTitle(vanityTitle)
		
        if (project) {
			def country_code = project.country.countryCode
			
            def user = project.user
            def currentUser = userService.getCurrentUser()
            def spends = project.spend
            spends = spends.sort{it.numberAvailable}
            if (user == currentUser) {
                def currentEnv = projectService.getCurrentEnvironment()
                def categoryOptions = projectService.getCategoryList()
                def country = projectService.getCountry()
                def nonProfit = projectService.getRecipientOfFunds()
                def nonIndprofit = projectService.getRecipientOfFundsIndo()
                def vanityUsername = userService.getVanityNameFromUsername(user.username, project.id)

                def usedForCreate = project.usedFor
                def selectedCountry
                if (project.beneficiary.country != null) {
                    selectedCountry = (project.beneficiary.country?.length() > 3 ) ? projectService.getCountryKey(project.beneficiary.country) : project.beneficiary.country
                }

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
				if('in'.equalsIgnoreCase(country_code)){   
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
				
				BankInfo bankInfo = projectService.getBankInfoByProject(project);
				
                render(view: 'create/index2',
                model: ['categoryOptions': categoryOptions, 'payOpts':payOpts, 'country': country, 
                    nonIndprofit:nonIndprofit, nonProfit:nonProfit , currentEnv: currentEnv,
                    FORMCONSTANTS: FORMCONSTANTS,projectRewards:projectRewards, project:project, 
                    user:user,campaignEndDate:campaignEndDate, pieList:pieList,stateInd:stateInd,
                    vanityTitle: vanityTitle, vanityUsername:vanityUsername, email1:adminemails.email1, 
                    email2:adminemails.email2, email3:adminemails.email3,reasonsToFund:reasonsToFund, 
                    qA:qA, spends:spends, usedForCreate:usedForCreate, selectedCountry:selectedCountry, 
                    taxReciept:taxReciept, deductibleStatusList:deductibleStatusList,
                    spendAmountPerList:pieList.spendAmountPerList,country_code:country_code, bankInfo: bankInfo])
            } else {
                render(view: '/401error', model: [message: 'Sorry, you are not authorized to view this page.'])
            }
        } else {
            render(view: '/404error', model: [message: 'This campaign does not exist.'])
        }
    }
	
    @Secured(['IS_AUTHENTICATED_FULLY'])
    def campaignOnDraftAndLaunch() {
		def country_code = params.country_code
        Project project = projectService.getProjectById(params.projectId)
        def vanitytitle
        if (project) {
            User user = userService.getCurrentUser()
            if (project.user == user) {
                
				def currentEnv = projectService.getCurrentEnvironment()
				if('in'.equalsIgnoreCase(country_code)){   
                    if(params.payuEmail){
                        project.payuEmail = params.payuEmail
                    }
					if(params.paypalEmail){
						project.paypalEmail = params.paypalEmail
					}
			    }
				
				projectService.saveLastSpendField(params);
                rewardService.saveRewardDetails(params);
                project.story = params.story
                
                if (params.checkBox && !project.touAccepted) {
                    project.touAccepted = true
                }
                
                def taxReciept = TaxReciept.findByProject(project)
                if(taxReciept) {
				if('in'.equalsIgnoreCase(country_code)){   
                        taxReciept.country = 'India'
                    } else {
                        taxReciept.country = (taxReciept.country && taxReciept.country != 'null') ? taxReciept.country : 'United States';
                    }
                    taxReciept.save();
                }
				vanitytitle = (project.customVanityUrl) ? projectService.getCustomVanityUrl(project) : params.title;

				rewardService.saveRewardDetails(params);
				project.story = params.story

				if (params.checkBox && !project.touAccepted) {
					project.touAccepted = true
				}

				if (params.isSubmitButton == 'true'){
					project.draft = false;
					if (!project.beneficiary.country || project.beneficiary.country == 'null') {
						if('in'.equalsIgnoreCase(country_code)){   
							project.beneficiary.country = 'IN'
						} else {
							project.beneficiary.country = 'US'
						}
					}
					redirect (action:'launch' ,  params:[title:vanitytitle,country_code:params.country_code,'category':project.fundsRecievedBy.toLowerCase()])
				} else {
					redirect (action:'showCampaign' ,  params:[id:project.id, isPreview:true,country_code:params.country_code,'category':project.fundsRecievedBy.toLowerCase()])
				}
			} else {
				render(view: '/401error', model: [message: 'Sorry, you are not authorized to view this page.'])
			}
		} else {
			render(view: '/404error', model: [message: 'This campaign does not exist.'])
		}
	}
	
	@Secured(['IS_AUTHENTICATED_FULLY'])
	def launch() {
		def vanityTitle = params.title
		def project = projectService. getProjectFromVanityTitle(vanityTitle)
		def currentEnv = projectService.getCurrentEnvironment()
        
        if(project) {
				if('in'.equalsIgnoreCase(country_code)){   
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
        
            render (view: 'create/justcreated', model:[project:project, FORMCONSTANTS: FORMCONSTANTS, country_code:params.country_code])
	    } else {
           
            def previousPage = "create"
            render (view: '/project/create/createerror', model:[project: project, currentEnv:currentEnv, previousPage:previousPage, country_code:params.country_code])
	    }
	}

	@Secured(['IS_AUTHENTICATED_FULLY'])
	def editCampaign(){
		def title = projectService.getVanityTitleFromId(params.id)
        
		if(title){
			redirect (action : 'edit', params:['projectTitle':title,country_code:params.country_code])
		}else{
			render(view: '/404error', model: [message: 'This campaign does not exist.'])
		}
	}

    @Secured(['IS_AUTHENTICATED_FULLY'])
    def edit() {
        Project project = projectService.getProjectFromVanityTitle(params.projectTitle)
        def currentEnv = projectService.getCurrentEnvironment()
        def vanityTitle = params.projectTitle
        
        if (project) {
            def inDays = projectService.getInDays()
           
            def spends = project.spend
            spends = spends.sort{it.numberAvailable}
            
            String countryCode = project?.country?.countryCode
			
			def categoryOptions= projectService.getCategoryList()
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
            if ('in'.equalsIgnoreCase(countryCode)){
                payOpts = projectService.getIndiaPaymentGateway()
            } else {
                payOpts = projectService.getPayment()
            }
            
            //Country Issue for India site
            //India: Map key is fetching for country like, AL is fetching for AL:"ALBANIA"
            //USA: Map value is fetching for country like, ALBANIA is fetching for AL:"ALBANIA"
           // def selectedCountry = (project.beneficiary.country.length() > 3 ) ? projectService.getCountryKey(project.beneficiary.country) : project.beneficiary.country
            def selectedCountry;
    		if (project.beneficiary.country != null) {
    			selectedCountry = (project.beneficiary.country?.length() > 3 ) ? projectService.getCountryKey(project.beneficiary.country) : project.beneficiary.country
    		}
    		def beneficiary = project.beneficiary
            
            def reasonsToFund = projectService.getProjectReasonsToFund(project)
            def qA = projectService.getProjectQA(project)
            def taxReciept = projectService.getTaxRecieptOfProject(project)
            def deductibleStatusList = projectService.getDeductibleStatusList()
            def stateInd = projectService.getIndianState()
            def pieList = projectService.getPieList(project);
            
			BankInfo bankInfo = projectService.getBankInfoByProject(project);
			
            def country_code = countryCode
            render (view: 'edit/index',
            model: ['categoryOptions': categoryOptions, 'payOpts':payOpts,spends:spends,
                'country': country, nonProfit:nonProfit, nonIndprofit:nonIndprofit,
                currentEnv: currentEnv,beneficiary:beneficiary,inDays:inDays,taxReciept:taxReciept,
                FORMCONSTANTS: FORMCONSTANTS,projectRewards:projectRewards,qA:qA,stateInd:stateInd,
                project:project, user:user,campaignEndDate:campaignEndDate,reasonsToFund:reasonsToFund,
                vanityTitle: vanityTitle, vanityUsername:vanityUsername, selectedCountry: selectedCountry,
                email1:adminemails.email1, email2:adminemails.email2, email3:adminemails.email3,
                deductibleStatusList:deductibleStatusList,spendAmountPerList:pieList.spendAmountPerList,country_code:country_code, bankInfo: bankInfo])
        } else {
            def previousPage = "manage"
        
            flash.prj_edit_message = "Campaign not found."
            render (view: 'edit/editerror', model:[project: project, currentEnv:currentEnv, previousPage:previousPage])
        }
    }

	@Secured(['IS_AUTHENTICATED_FULLY'])
	def update() {
		Project project = projectService.getProjectFromVanityTitle(params.vanityTitle)
        def vanityTitle = projectService.getProjectUpdateDetails(params, project,params.country_code)
        def currentEnv = projectService.getCurrentEnvironment()
        def country_code = params.country_code
		if(project) {
			rewardService.saveRewardDetails(params);
			projectService.saveLastSpendField(params);
			flash.prj_mngprj_message = "Successfully saved the changes"
			redirect (action: 'manageproject', params:['projectTitle':vanityTitle,country_code:country_code])
		} else {
            def previousPage = 'edit'
           
			flash.prj_edit_message = "Campaign not found."
			render (view: 'edit/editerror', model:[project: project, previousPage:previousPage, currentEnv: currentEnv])
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
		}

		List projectParamsList
		try {
			Workbook workbook = WorkbookFactory.create(projectSpreadsheet.getInputStream())
			projectParamsList = excelImportService.columns(workbook, CONFIG_BOOK_COLUMN_MAP)
		} catch (Exception e) {
			flash.prj_import_message = "Error while importing file: " + e.getMessage()
			redirect(action: 'importprojects')
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
			}

			Beneficiary beneficiary = userService.getBeneficiaryByParams(projectParams)
			if (beneficiary.hasErrors()) {
				flash.projecterror = [
					'title': projectParams.title,
					'error': "Error mapping beneficiary: " + beneficiary.errors.toString()
				]
				redirect(action: 'importprojects')
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
			}

			if (project.validate()) {
				projects.add(project)
			} else {
				flash.projecterror = [
					'title': projectParams.title,
					'error': "Error validating project: " + project.errors.toString()
				]
				redirect(action: 'importprojects')
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
				}
			}

			flash.prj_import_message = "All Campaigns successfully imported"
			redirect(action: 'importprojects')
		} else {
			flash.projecterror = "Nothing to import. Please make sure the file contains some valid rows."
			render (view: 'import/importerror')
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
	def manageCampaign() {
		def title = projectService.getVanityTitleFromId(params.id)
		if(title) {
			redirect (action:'manageproject', params:['projectTitle':title,country_code:params.country_code])
		} else {
			render view:'404error', model:[title:title]
		}
	}

	@Secured(['IS_AUTHENTICATED_FULLY'])
	def manageproject() {
		def projectId = projectService.getProjectIdFromVanityTitle(params.projectTitle)
		Project project = projectService.getProjectById(projectId)
		def country_code = params.country_code
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
            
            def enableTeamNamesList = projectService.getEnableTeamFirstNameAndLastName(totalteams)
            def teamNameList = projectService.getTeamFirstNameAndLastName(totalteams)

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
			//def multiplier = projectService.getCurrencyConverter();
            
            def pieList = projectService.getPieList(project);
            def hasMoreTagsDesktop = projectService.getHashTags(project.hashtags)
            def hasMoreTagsTabs = projectService.getHashTagsTabs(project.hashtags)
            def reasons = projectService.getReasonsToFundFromProject(project)
            
            def isDeviceMobileOrTab = isDeviceMobileOrTab();
            def isAdmin = userService.isAdmin();
            
            boolean isTaxReceipt = campaignService.isTaxReceiptExist(project.id);
			def currentFundraiser = userService.getCurrentFundRaiser(user, project)
			def hasTags = projectService.getHashTagsForCampaign(project.hashtags)
			def projectComments = projectService.getProjectComments(project)


			if(project.user==user || isCampaignOwnerOrAdmin || isAdmin){
				render (view: 'manageproject/index',
				model: [project: project, currentFundraiser:currentFundraiser,isCampaignOwnerOrAdmin: isCampaignOwnerOrAdmin, validatedTeam: validatedTeam, percentage: percentage, currentTeam: currentTeam,totalContributions:totalContributions, totalteams: totalteams,
					discardedTeam : discardedTeam, totalContribution: totalContribution, projectimages: projectimages,isCampaignAdmin: isCampaignAdmin, webUrl: webUrl,contributions: contributions, offset: offset, day: day,
					ended: ended, isFundingOpen: isFundingOpen, rewards: rewards, endDate: endDate, user : user, isCrFrCampBenOrAdmin: isCrFrCampBenOrAdmin,isEnabledTeamExist: isEnabledTeamExist, teamOffset: teamOffset,
					unValidatedTeam: unValidatedTeam, vanityTitle: params.projectTitle, vanityUsername:vanityUsername, FORMCONSTANTS: FORMCONSTANTS, isPreview:params.isPreview, currentEnv: currentEnv, bankInfo: bankInfo,
					tile:params.tile, shortUrl:shortUrl, base_url:base_url, reasons: reasons, isAdmin: isAdmin,projectComments:projectComments,
					spendCauseList:pieList.spendCauseList, spendAmountPerList:pieList.spendAmountPerList, isDeviceMobileOrTab: isDeviceMobileOrTab,
					firstFiveHashtag: hasTags.firstFiveHashtag, firstThreeHashtag: hasTags.firstThreeHashtag,remainingHashTags: hasTags.remainingHashTags, remainingHashTagsTab: hasTags.remainingHashTagsTab, hashtagsList: hasTags.hashtagsList, enableTeamNames: enableTeamNamesList,
					teamNames:teamNameList, isTaxReceipt: isTaxReceipt,country_code:country_code])
			} else {
				flash.prj_mngprj_message = 'Campaign Not Found'
                
                def previousPage = 'manage'
				render (view: 'manageproject/error', model: [project: project, previousPage: previousPage, currentEnv: currentEnv])
			}
		} else {
			render(view: '/404error', model: [message: 'This campaign does not exist.'])
		}
	}

	def showteams() {
		def vanityTitle = params.projectTitle
		redirect (controller: 'project', action: 'manageproject', params:['projectTitle':vanityTitle, teamOffset: params.teamOffset], fragment: 'manageTeam')
	}

	@Secured(['IS_AUTHENTICATED_FULLY'])
	def projectdelete() {
		Project project = projectService.getProjectById(params.id)
		def currentUser= userService.getCurrentUser()
        def currentEnv = projectService.getCurrentEnvironment()
		country_code = project.country.countryCode
        def vanityTitle = projectService.getProjectUpdateDetails(params, project,country_code)
		if (project) {
            def isAdminOrBeneficiary = userService.isCampaignBeneficiaryOrAdmin(project, currentUser)
            if (isAdminOrBeneficiary) {
                
                project.inactive = true
                List emailList= projectService.getProjectAdminEmailList(project)
                mandrillService.sendCampaignDeleteEmailsToOwner(emailList, project, currentUser,country_code)
                flash.prj_validate_message= "Campaign Discarded Successfully!"
                
                if (userService.isPartner()) {
                    redirect (action:'partnerdashboard', controller:'user')
                } else {
                    redirect (action:'renderdashboard' , controller:'user')
                }
			    
            } else {
                render view:'/401error'
            }
		} else {
			flash.prj_mngprj_message = 'Campaign Not Found'
        
            def previousPage = 'manage'
			render (view: 'manageproject/error', model: [project: project, currentEnv:currentEnv, previousPage:previousPage])
		}
	}

	@Secured(['IS_AUTHENTICATED_FULLY'])
	def customrewardsave() {
		def reward = rewardService.getRewardByParams(params)
		RewardShipping shippingInfo = rewardService.getRewardShippingByParams(params)
		def title = projectService.getVanityTitleFromId(params.id)
        def currentEnv = projectService.getCurrentEnvironment()

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
            def previousPage = 'manage'
			render (view: 'manageproject/error', model: [reward: reward, currentEnv:currentEnv, previousPage: previousPage])
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
    
    def sendupdateemail() {
        def fundRaiser = params.fr
        def updateId = projectService.getProjectUpdateById(params.projectUpdateId)
        projectService.shareupdateemail(params,fundRaiser,updateId)
        flash.prj_mngprj_message= "Email sent successfully."
        if (params.ismanagepage) {
            redirect(controller: 'project', action: 'manageproject', params:['projectTitle': params.vanityTitle], fragment:'projectupdates')
        } else {
            redirect (action: 'show', params:[fr: params.vanityUsername, 'projectTitle': params.vanityTitle], fragment:'projectupdates')
        }
    }

    @Secured(['IS_AUTHENTICATED_FULLY'])
    def projectupdate() {
        def projectId = projectService.getProjectIdFromVanityTitle(params.projectTitle)
        def project = projectService.getProjectById(projectId)
        
        def currentUser =userService.getCurrentUser()
        def isCampaignOwnerOrAdmin = userService.isCampaignBeneficiaryOrAdmin(project,currentUser)
        def currentEnv = projectService.getCurrentEnvironment()
        
        if(project) {
            if(!isCampaignOwnerOrAdmin){
                def previousPage = 'manage'
                render view:"manageproject/error", model: [project: project, previousPage: previousPage, currentEnv: currentEnv]
            }else{
                render (view: 'update/index', model: [project: project, FORMCONSTANTS: FORMCONSTANTS, currentEnv: currentEnv])
            }
        } else {
            def previousPage = 'manage'
            render (view: 'manageproject/error', model: [project: project, previousPage: previousPage, currentEnv: currentEnv])
        }
    }

	@Secured(['IS_AUTHENTICATED_FULLY'])
	def editCampaignUpdate(){
		def title = projectService.getVanityTitleFromId(params.projectId)
		if(title){
			redirect (action : 'editUpdate', id:params.id, params:['projectTitle':title])
		}else{
			render(view: '/404error', model: [message: 'This campaign does not exist.'])
		}
	}

	@Secured(['IS_AUTHENTICATED_FULLY'])
	def editUpdate() {
		def projectUpdate = projectService.getProjectUpdateById(params.id)
		def project = projectService.getProjectFromVanityTitle(params.projectTitle)
		def projectUpdates = project.projectUpdates
        def currentEnv = projectService.getCurrentEnvironment()
        
		if (projectUpdates.contains(projectUpdate)) {
			flash.editUpdateSuccessMsg = "Campaign Update Edited Successfully"
			render (view:'editupdate/index', model:[projectUpdate: projectUpdate, project: project, FORMCONSTANTS: FORMCONSTANTS])
		} else {
            def previousPage = 'manage'
			render (view: 'manageproject/error', model:[project: project, previousPage: previousPage, currentEnv: currentEnv])
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
	def deleteCampaignUpdate(){
		def title = projectService.getVanityTitleFromId(params.projectId)
		def project = projectService.getProjectFromVanityTitle(title)
		boolean deleteStatus = projectService.deleteCampaignUpdates(params,project)
		System.out.println(" delete Status = "+deleteStatus)
		if(deleteStatus){
		 flash.deleteUpdateSuccessMsg = "Campaign Update Deleted Successfully!"
		redirect(controller: 'project', action: 'manageproject', params:['projectTitle':title], fragment: 'projectupdates')
		}else{
		 render(view: '/404error', model: [message: 'Campaign Update not Deleted Successfully.'])
	    }
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
        def currentEnv = projectService.getCurrentEnvironment()

		if(project) {
			if (params.imageList || !story.isAllWhitespace()) {
                
                projectService.saveCampaignUpdate(params, project, story)
                
				flash.prj_mngprj_message= "Update added successfully."
				redirect (action: 'manageproject', controller:'project', params:['projectTitle':title], fragment: 'projectupdates')
			} else {
				flash.prj_mngprj_message= "No Updates added."
				redirect (action: 'manageproject', controller:'project', params:['projectTitle':title], fragment: 'projectupdates')
			}
		} else {
            def previousPage = 'update'
			render (view: 'manageproject/error', model: [project: project, previousPage: previousPage, currentEnv: currentEnv])
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
		def currentEnv = projectService.getCurrentEnvironment()
		def discoverLeftCategoryOptions=projectService.getCategory()
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
		/*if (category == "Social-Innovation"){
			project = projectService.filterByCategory("Social-Innovation", currentEnv)
		}else if (category == "Civic-Needs"){
			project = projectService.filterByCategory("Community_CivicNeeds", currentEnv)
		}else if (category == "Non-Profits"){
			project = projectService.filterByCategory("NON_PROFITS", currentEnv)
		}else if (category == "All-Categories"){
			project = projectService.filterByCategory("All", currentEnv)
		} else {
			project = projectService.filterByCategory(category, currentEnv)
		}*/
		println("category=="+ category)
		if (category == "All-Categories"){
			project = projectService.filterByCategory("All", currentEnv)
		} else {
			project = projectService.filterByCategory(category, currentEnv)
		}
		def country_code = project.country.countryCode
		flash.catmessage = (project) ? "" : "No campaign found."
		render (view: 'list/index', model: [projects: project, selectedCategory:category, countryOptions:countryOptions, sortsOptions:sortsOptions, discoverLeftCategoryOptions:discoverLeftCategoryOptions,country_code:country_code])
	}

	def addTeam() {
		def request_url=request.getRequestURL().substring(0,request.getRequestURL().indexOf("/", 8))
		def base_url = (request_url.contains('www')) ? grailsApplication.config.crowdera.BASE_URL1 : grailsApplication.config.crowdera.BASE_URL
		def reqUrl = base_url+"project/addFundRaiser?id=${params.id}"
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
	def redirectToInviteMember(){
		redirect (action:'inviteMember', params:[projectId:params.projectId, page: params.page ])
	}
	
	@Secured(['IS_AUTHENTICATED_FULLY'])
	def inviteMember(){
        def user=userService.getCurrentUser()
		def page = params.page?params.page : chainModel.page
		Project project = Project.get(params.projectId)
		session.setAttribute('projectId', project.id)
		session.setAttribute('page', params.page)
		if (page =="manage"){
			if(chainModel){
				def provider = session.getAttribute('socialProvider')
				render (view:"/project/manageproject/invitemember", model:[project:project, email:chainModel.email, contactList:chainModel.contactList,  provider:provider, user:user])
			}else{
				render (view:"/project/manageproject/invitemember", model:[project:project, user:user])
			}
		}else{
			if(chainModel){
				def provider = session.getAttribute('socialProvider')
				render (view:"/project/show/invitemember", model:[project:project, email:chainModel.email, contactList:chainModel.contactList, provider:provider, user:user])
			}else{
				render (view:"/project/show/invitemember", model:[project:project, user:user])
			}
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
		def country_code = project.country.countryCode
		def emailList = emails.split(',')
		emailList = emailList.collect { it.trim() }
		mandrillService.sendInvitationForTeam(emailList, name, message, project,country_code)
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
          def currentUser = userService.getCurrentUser()
          def teamId= request.getParameter('teamId')
          def team = projectService.getTeamById(teamId)
          def projectByTeam = projectService.getProjectByteam(team)
          def projectAdmin
          def projectUser
		  boolean isAdmin = userService.isAdmin();
		  
          if(projectByTeam && team) {
             projectAdmin = userService.isCampaignBeneficiaryOrAdmin(projectByTeam, currentUser)
             projectUser = projectByTeam.user.email.toString().replace('[','').replace(']','')
             if(isAdmin || projectUser.equals(currentUser.username) || projectAdmin){
                 if(!projectUser.equals(team.user.username)){
                     if(team.enable){
                         team.enable = false
                     }else{
                         team.enable = true
                     }
                 }
             }
             render ""
          }else{
             render ""
          }
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
		
		if (params.managecomments.equals("manageCampaign")) {
		    redirect (controller: 'project', action: 'manageCampaign',fragment: 'comments', id: params.projectId,params:[fr: params.fr,country_code:params.campaign_country_code])
		} else {
		    redirect (controller: 'project', action: 'showCampaign',fragment: 'comments', id: params.projectId, params:[fr: params.fr,country_code:params.campaign_country_code])
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
		country_code = project.country.countryCode
		team.validated = true
		mandrillService.sendTeamValidatedConfirmation(project,team.user,country_code)
		flash.teamvalidationmessage = "Team validated Successfully."
		redirect(controller: 'project', action: 'manageproject',fragment: 'manageTeam', params:['projectTitle':title,'country_code':country_code])
	}

	@Secured(['IS_AUTHENTICATED_FULLY'])
	def discardteam() {
		def project = projectService.discardTeam(params)
		def title = projectService.getVanityTitleFromId(project.id)
		if(project && title){
			flash.teamdiscardedmessage = "Team Discarded Successfully."
			redirect(controller: 'project', action: 'manageproject',fragment: 'manageTeam', params:['projectTitle':title])
		}else{
			render view:'404error', model:[project: project]
		}
	}

	def campaignsSorts(){
		def sorts = params.sorts.replace(' ','-')
		country_code =  projectService.getCountryCodeForCurrentEnv(request)

		if(sorts.equalsIgnoreCase('Sort-by')){
			redirect(action:'list', controller:'project')
		}else{
			redirect(action:'sortCampaign', controller: 'project',params:[query: sorts,country_code:country_code])
		}
	}

	/*def sortCampaign(){
		def countryOptions = projectService.getCountry()
		def environment = projectService.getCurrentEnvironment()
		def country_code = params.country_code
		def discoverLeftCategoryOptions
		if('in'.equalsIgnoreCase(country_code)){
			discoverLeftCategoryOptions = projectService.getIndiaCategory()
		}else{
			discoverLeftCategoryOptions=projectService.getCategory()
		}
		def sortsOptions = projectService.getSorts()
		def sorts = params.query.replace(' ','-')

		List campaignsorts = projectService.isCampaignsorts(sorts, country_code)
		campaignsorts.sort{contributionService.getPercentageContributionForProject(it)}
		campaignsorts.reverse(true)

		if(!campaignsorts){
			flash.catmessage="No campaign found."
			render (view: 'list/index', model: [projects: campaignsorts,sorts: sorts.replace('-',' '), countryOptions:countryOptions, sortsOptions:sortsOptions, discoverLeftCategoryOptions:discoverLeftCategoryOptions,country_code:country_code])
		} else {
			render (view: 'list/index', model: [projects: campaignsorts,sorts: sorts.replace('-',' '), countryOptions:countryOptions, sortsOptions:sortsOptions, discoverLeftCategoryOptions:discoverLeftCategoryOptions,country_code:country_code])
		}
	}*/

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
                CommonsMultipartFile attachFileUrl = params.attachFileUrls
                String fileUrl = projectService.setAttachedFileForProject(attachFileUrl)
                
                projectComment.attachFile = fileUrl?fileUrl:projectComment.attachFile;;
				projectComment.comment = params.comment
			}
		}
		if (params.teamCommentId) {
			teamcomment = projectService.getTeamCommentById(params.long('teamCommentId'))
			if (teamcomment) {
                CommonsMultipartFile attachFileUrl = params.attachFileUrls
                String fileUrl = projectService.setAttachedFileForProject(attachFileUrl)

                teamcomment.attachteamfile = fileUrl?fileUrl:teamcomment.attachteamfile;
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

			//def multiplier = projectService.getCurrencyConverter();
             def currentEnv = projectService.getCurrentEnvironment()
            
			def model = [totalContributions : totalContributions, CurrentUserTeam: CurrentUserTeam,isCrUserCampBenOrAdmin: isCrUserCampBenOrAdmin, contributions: contributions, project: project,
				team: currentTeam, currentEnv: currentEnv, vanityUsername:params.fr, currentUser: currentUser]
            
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
		//	def multiplier = projectService.getCurrencyConverter();
            boolean isshow = true;

			def model = [teamOffset : teamOffset, isshow: isshow, teams: teams, totalteams: totalteams, project: project, vanityUsername:params.fr]
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
			//def multiplier = projectService.getCurrencyConverter();

			def model = [teamOffset : teamOffset, teams: teams, totalteams: totalteams, project: project, vanityUsername:params.fr]
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
			//def multiplier = projectService.getCurrencyConverter();

			def model = [totalContributions : totalContributions, contributions: contributions, project: project, user:user]
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
			//def multiplier = projectService.getCurrencyConverter();

			def model = [teamOffset : teamOffset, validatedTeam: validatedTeam, totalteams: totalteams, project: project]
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
    
    def uploadUpdateAttachFile(){
        def file = params.file
        println"file===="+file
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
		def httptwit = new HTTPBuilder('http://opensharecount.com/count.json?url=' + campaignUrl)
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
		def url = params?.url
		def projectDetails = projectService.getCampaignFromUrl(url)
		redirect (action:'show', params:['projectTitle':projectDetails?.projectTitle,'fr':projectDetails?.fr,'country_code':projectDetails.country_code,'category':projectDetails.category])
	}

	def embedTile(){
		def project = projectService.getProjectFromVanityTitle(params.projectTitle)
		def currentFundraiser = userService.getUserFromVanityName(params.fr)
		render(view:'/project/manageproject/embedTile', model:[project:project, currentFundraiser:currentFundraiser])
	}

	def getFeedBackCSV(){
		Project project = projectService.getProjectById(params.projectId)
		def result = projectService.importCSVReportForUserFeedback(response, project)
		render (contentType:"text/csv", text:result)
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

    /*def getImpactText(){
        Project project = projectService.getProjectById(params.projectId)
        def currentEnv = projectService.getCurrentEnvironment()
        projectService.getCategoryAndHashTagsSaved(project, currentEnv, params.selectedCategory)
        if(request.xhr){
            render(template: "create/impactAnalysisText", model:[project:project, currentEnv:currentEnv, loadjs:true])
        }
    }*/

    def saveRecipientAndHashTags(){
        projectService.saveRecipientAndHashTags(params)
        render''
    }

    def autoSaveCharitableIdAndOrganisationName(){
        Project project = projectService.getProjectById(params.projectId)
        project.organizationName = params.organizationname
        project.charitableId = params.charitableId
        project.paypalEmail = null;
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

	@Secured(['IS_AUTHENTICATED_FULLY'])
	def importSocialContacts(){
        def refererURI = new URI(request.getHeader("referer")).getPath()
        String provider=params.socialProvider
        String email =params.socialContact
        session['email'] = email
        session['socialProvider'] = provider
        session['refererPage'] = refererURI
        def currentEnv = projectService.getCurrentEnvironment()
        def request_url=request.getRequestURL().substring(0,request.getRequestURL().indexOf("/", 8))
        def base_url = (request_url.contains('www')) ? grailsApplication.config.crowdera.BASE_URL1 : grailsApplication.config.crowdera.BASE_URL
        switch(currentEnv){
            case 'development':
                if(provider.equals('google')){
                    def oauthUrl=grailsApplication.config.crowdera.gmail.OAUTH_URL
                    def clientId= grailsApplication.config.crowdera.gmail.CLIENT_KEY
                    def scope = grailsApplication.config.crowdera.gmail.SCOPE
                    def redirectUri=base_url+'project/getSocialContactsCode'
                    render oauthUrl+'client_id='+clientId+'&scope='+scope+'&redirect_uri='+redirectUri+'&response_type=code'
                }else if(provider.equals("constant")){
                    def oauthUrl=grailsApplication.config.crowdera.cc.OAUTH_URL
                    def clientId= grailsApplication.config.crowdera.cc.CLIENT_KEY
                    def redirectUri='http%3A%2F%2flocalhost%3A8080%2Fproject%2FgetSocialContactsCode'
                    render oauthUrl+'client_id='+clientId+'&redirect_uri='+redirectUri
                }else if(provider.equals('mailchimp')){
                    def oauthUrl=grailsApplication.config.crowdera.MAILCHIMP.OAUTH_URL
                    def clientId= grailsApplication.config.crowdera.MAILCHIMP.CLIENT_ID
                    def redirectUri='http://127.0.0.1:8080/project/getSocialContactsCode'
                    render oauthUrl+'?response_type=code&client_id='+clientId+'&redirect_uri='+redirectUri
                }
            break;
            case 'test':
                if(provider.equals('google')){
                    def oauthUrl=grailsApplication.config.crowdera.gmail.OAUTH_URL
                    def clientId= grailsApplication.config.crowdera.gmail.CLIENT_KEY
                    def scope = grailsApplication.config.crowdera.gmail.SCOPE
                    def redirectUri=base_url+'project/getSocialContactsCode'
                    render oauthUrl+'client_id='+clientId+'&scope='+scope+'&redirect_uri='+redirectUri+'&response_type=code'
                }else if(provider.equals("constant")){
                    def oauthUrl=grailsApplication.config.crowdera.cc.OAUTH_URL
                    def clientId= grailsApplication.config.crowdera.cc.CLIENT_KEY
                    def redirectUri='http%3A%2F%2ftest%2Ecrowdera%2Eco%2Fproject%2FgetSocialContactsCode'
                    render oauthUrl+'client_id='+clientId+'&redirect_uri='+redirectUri
                }else if(provider.equals('mailchimp')){
                    def oauthUrl=grailsApplication.config.crowdera.MAILCHIMP.OAUTH_URL
                    def clientId= grailsApplication.config.crowdera.MAILCHIMP.CLIENT_ID
                    def redirectUri=base_url+'project/getSocialContactsCode'
                    render oauthUrl+'?response_type=code&client_id='+clientId+'&redirect_uri='+redirectUri
                }
            break;
			case 'testIndia':
			if(provider.equals('google')){
				def oauthUrl=grailsApplication.config.crowdera.gmail.OAUTH_URL
				def clientId= grailsApplication.config.crowdera.gmail.CLIENT_KEY
				def scope = grailsApplication.config.crowdera.gmail.SCOPE
				def redirectUri=base_url+'project/getSocialContactsCode'
				render oauthUrl+'client_id='+clientId+'&scope='+scope+'&redirect_uri='+redirectUri+'&response_type=code'
			}else if(provider.equals("constant")){
				def oauthUrl=grailsApplication.config.crowdera.cc.OAUTH_URL
				def clientId= grailsApplication.config.crowdera.cc.CLIENT_KEY
				def redirectUri='http%3A%2F%2ftest%2Ecrowdera%2Eco%2Fproject%2FgetSocialContactsCode'
				render oauthUrl+'client_id='+clientId+'&redirect_uri='+redirectUri
			}else if(provider.equals('mailchimp')){
				def oauthUrl=grailsApplication.config.crowdera.MAILCHIMP.OAUTH_URL
				def clientId= grailsApplication.config.crowdera.MAILCHIMP.CLIENT_ID
				def redirectUri=base_url+'project/getSocialContactsCode'
				render oauthUrl+'?response_type=code&client_id='+clientId+'&redirect_uri='+redirectUri
			}
		    break;
            case 'staging':
                if(provider.equals('google')){
                    def oauthUrl=grailsApplication.config.crowdera.gmail.OAUTH_URL
                    def clientId= grailsApplication.config.crowdera.gmail.CLIENT_KEY
                    def scope = grailsApplication.config.crowdera.gmail.SCOPE
                    def redirectUri=base_url+'project/getSocialContactsCode'
                    render oauthUrl+'client_id='+clientId+'&scope='+scope+'&redirect_uri='+redirectUri+'&response_type=code'
                }else if(provider.equals("constant")){
                    def oauthUrl=grailsApplication.config.crowdera.cc.OAUTH_URL
                    def clientId= grailsApplication.config.crowdera.cc.CLIENT_KEY
                    def redirectUri='http%3A%2F%2fstaging%2Ecrowdera%2Eco%2Fproject%2FgetSocialContactsCode'
                    render oauthUrl+'client_id='+clientId+'&redirect_uri='+redirectUri
                }else if(provider.equals('mailchimp')){
                    def oauthUrl=grailsApplication.config.crowdera.MAILCHIMP.OAUTH_URL
                    def clientId= grailsApplication.config.crowdera.MAILCHIMP.CLIENT_ID
                    def redirectUri=base_url+'project/getSocialContactsCode'
                    render oauthUrl+'?response_type=code&client_id='+clientId+'&redirect_uri='+redirectUri
                }
            break;
            case 'production':
               if(provider.equals('google')){
                   def oauthUrl=grailsApplication.config.crowdera.gmail.OAUTH_URL
                   def clientId= grailsApplication.config.crowdera.gmail.CLIENT_KEY
                   def scope = grailsApplication.config.crowdera.gmail.SCOPE
                   def redirectUri=base_url+'project/getSocialContactsCode'
                   render oauthUrl+'client_id='+clientId+'&scope='+scope+'&redirect_uri='+redirectUri+'&response_type=code'
               }else if(provider.equals("constant")){
                   def oauthUrl=grailsApplication.config.crowdera.cc.OAUTH_URL
                   def clientId= grailsApplication.config.crowdera.cc.CLIENT_KEY
                   def redirectUri='http%3A%2F%2fcrowdera%2Eco%2Fproject%2FgetSocialContactsCode'
                   render oauthUrl+'client_id='+clientId+'&redirect_uri='+redirectUri
               }else if(provider.equals('mailchimp')){
                   def oauthUrl=grailsApplication.config.crowdera.MAILCHIMP.OAUTH_URL
                   def clientId= grailsApplication.config.crowdera.MAILCHIMP.CLIENT_ID
                   def redirectUri=base_url+'project/getSocialContactsCode'
                   render oauthUrl+'?response_type=code&client_id='+clientId+'&redirect_uri='+redirectUri
               }
           break;
           case 'prodIndia':
               if(provider.equals('google')){
                   def oauthUrl=grailsApplication.config.crowdera.gmail.OAUTH_URL
                   def clientId= grailsApplication.config.crowdera.gmail.CLIENT_KEY
                   def scope = grailsApplication.config.crowdera.gmail.SCOPE
                   def redirectUri=base_url+'project/getSocialContactsCode'
                   render oauthUrl+'client_id='+clientId+'&scope='+scope+'&redirect_uri='+redirectUri+'&response_type=code'
               }else if(provider.equals("constant")){
                   def oauthUrl=grailsApplication.config.crowdera.cc.OAUTH_URL
                   def clientId= grailsApplication.config.crowdera.cc.CLIENT_KEY
                   def redirectUri='http%3A%2F%2fcrowdrera%2Ein%2Fproject%2FgetSocialContactsCode'
                   render oauthUrl+'client_id='+clientId+'&redirect_uri='+redirectUri
               }else if(provider.equals('mailchimp')){
                   def oauthUrl=grailsApplication.config.crowdera.MAILCHIMP.OAUTH_URL
                   def clientId= grailsApplication.config.crowdera.MAILCHIMP.CLIENT_ID
                   def redirectUri=base_url+'project/getSocialContactsCode'
                   render oauthUrl+'?response_type=code&client_id='+clientId+'&redirect_uri='+redirectUri
               }
           break;
        }
	}

	@Secured(['IS_AUTHENTICATED_FULLY'])
    def getSocialContactsCode(){
        def refererURI = session.getAttribute('refererPage')
        def email =session.getAttribute("email")
        def projectId =session.getAttribute("projectId")
        def provider = session.getAttribute('socialProvider')
        def page = session.getAttribute("page")
        def code=params.code
        def user =userService.getCurrentUser()
        def request_url=request.getRequestURL().substring(0,request.getRequestURL().indexOf("/", 8))
        def base_url = (request_url.contains('www')) ? grailsApplication.config.crowdera.BASE_URL1 : grailsApplication.config.crowdera.BASE_URL
        switch(provider){
            case 'mailchimp':
                def endpoint= grailsApplication.config.crowdera.MAILCHIMP.TOKEN_ENDPOINT
                def clientId= grailsApplication.config.crowdera.MAILCHIMP.CLIENT_ID
                def clientSecret= grailsApplication.config.crowdera.MAILCHIMP.CLIENT_SECRET
                def dcUrl = grailsApplication.config.crowdea.MAILCHIMP.DC_URL
                def redirectUri =base_url +'project/getSocialContactsCode'
                def tokenJson = socialAuthService.getAccessToken(code, endpoint, clientSecret, redirectUri, clientId, provider)
                def json = socialAuthService.getJsonStringObject(tokenJson)
                def accessToken= json.access_token
                def mailchimpDC = socialAuthService.getRequestData(accessToken, dcUrl)
                def jsonDC = socialAuthService.getJsonStringObject(mailchimpDC)
                def listUrl = 'https://'+ jsonDC.dc + grailsApplication.config.crowdera.MAILCHIMP.MEMBER_URL
                def mailchimpListID = socialAuthService.getRequestData(accessToken, listUrl)
                def jsonMailchimpList = socialAuthService.getJsonStringObject(mailchimpListID)
                def listId = jsonMailchimpList.lists.id
                def contactJson = socialAuthService.getMailchimpContactsByListId(accessToken, listId , listUrl)
                def mailchimpList
                if(contactJson == null){
                    flash.contact_message="You might already login with different account."
                    if(refererURI.equals('/partner/dashboard')){
                        chain ( action:'partnerdashboard', controller:'user',  model:[ email:email,contactList:'', socialProvider:provider, page:'invite'])
                    }else{
                        chain (action:"inviteMember",params:[projectId:projectId, page:page] , model:[ email:email,contactList:"", page:page])
                    }
                }else{
                    mailchimpList= contactJson.toString().replace('[', " ").replace(']',' ')
                    if(mailchimpList){
                         def socialContacts = SocialContacts.findByUser(user)
                         if(socialContacts){
                              socialAuthService.setSocailContactsByUser(socialContacts ,mailchimpList, provider)
                         }else{
                              new SocialContacts(constantContact:null, gmail:null, mailchimp:mailchimpList, facebook:null, csvContact:null,user:user).save(failOnError: true)
                         }
                         if(refererURI.equals('/partner/dashboard')){
                              chain ( action:'partnerdashboard', controller:'user',  model:[ email:email,contactList:mailchimpList, socialProvider:provider, page:'invite'])
                         }else{
                              chain (action:"inviteMember",params:[projectId:projectId, page:page] , model:[ email:email,contactList:mailchimpList, socialProvider:provider, page:page])
                         }
                    }
                }
            break;
            case 'constant':
                def token_endpoint =grailsApplication.config.crowdera.cc.TOKEN_URL
                def apiKey = grailsApplication.config.crowdera.cc.CLIENT_KEY
                def clientSecret= grailsApplication.config.crowdera.cc.CLIENT_SECRET
                def contactsUrl = grailsApplication.config.crowdera.cc.CONTACT_URL + apiKey
                def redirectUri =base_url +'project/getSocialContactsCode'
                def tokenJson = socialAuthService.getAccessToken(code,token_endpoint, clientSecret, redirectUri, apiKey, provider)
                def json = socialAuthService.getJsonStringObject(tokenJson)
                def accessToken= json.access_token
                def contactJson =socialAuthService.getRequestData(accessToken, contactsUrl)
                def jsonString = socialAuthService.getJsonStringObject(contactJson)
                def constantContactList
                if(jsonString.error){
                    flash.contact_message="You might already login with different account."
                    if(refererURI.equals('/partner/dashboard')){
                        chain ( action:'partnerdashboard', controller:'user',  model:[ email:email,contactList:'', socialProvider:provider, page:'invite'])
                    }else{
                        chain (action:"inviteMember",params:[projectId:projectId, page:page] , model:[ email:email,contactList:'', page:page])
                    }
                }else{
                    constantContactList= jsonString.results.email_addresses.email_address
                    def filterList = constantContactList.findAll{it.findAll{
                        it!=''
                    }}
  
                    def filterConstantContactList =filterList.toString().replace('[', " ").replace(']',' ')

                    if(constantContactList){
                        def socialContacts = SocialContacts.findByUser(user)
                        if(socialContacts){
                            socialAuthService.setSocailContactsByUser(socialContacts, filterConstantContactList,  provider)
                        }else{
                            new SocialContacts(constantContact:filterConstantContactList, gmail:null, mailchimp:null, facebook:null, csvContact:null, user:user).save(failOnError: true)
                        }
                    }
                    if(refererURI.equals('/partner/dashboard')){
                        chain ( action:'partnerdashboard', controller:'user',  model:[ email:email,contactList:filterConstantContactList, socialProvider:provider, page:'invite'])
                    }else{
                        chain (action:"inviteMember",params:[projectId:projectId, page:page] , model:[ email:email,contactList:filterConstantContactList, socialProvider:provider, page:page])
                    }
                }
            break;
            case 'google':
                def tokenEndpoint =grailsApplication.config.crowdera.gmail.TOKEN_URL
                def clientId= grailsApplication.config.crowdera.gmail.CLIENT_KEY
                def clientSecret=grailsApplication.config.crowdera.gmail.CLIENT_SECRET
                def contactUrl= grailsApplication.config.crowdera.gmail.CONTACT_URL+ email +'/full?alt=json'
                def redirectUri =base_url +'project/getSocialContactsCode'
                def tokenJson = socialAuthService.getAccessToken(code,tokenEndpoint, clientSecret, redirectUri, clientId, provider)
                def json = socialAuthService.getJsonStringObject(tokenJson)
                def accessToken= json.access_token
                def contactJson = socialAuthService.getRequestData(accessToken, contactUrl)
                def jsonString =socialAuthService.getJsonStringObject(contactJson)
                def gmailList
                if(jsonString.error){
                     flash.contact_message="You might already login with different account."
                     if(refererURI.equals('/partner/dashboard')){
                         chain ( action:'partnerdashboard', controller:'user',  model:[ email:email,contactList:'', page:'invite', socialProvider:provider])
                     }else{
                         chain (action:"inviteMember",params:[projectId:projectId, page:page] , model:[ email:email,contactList:"", page:page, socialProvider:provider])
                     }
                }else{
                     def filterList= jsonString.feed.entry.gd$email.address
                     gmailList = projectService.getFilterGmailContacts(filterList, email)
                     if(gmailList){
                         def socialContacts = SocialContacts.findByUser(user)
                         if(socialContacts){
                             socialAuthService.setSocailContactsByUser(socialContacts ,gmailList, provider)
                        }else{
                             new SocialContacts(constantContact:null, gmail:gmailList, mailchimp:null, facebook:null, csvContact:null, user:user).save(failOnError: true)
                        }

                        if(refererURI.equals('/partner/dashboard')){
                            chain ( action:'partnerdashboard', controller:'user',  model:[ email:email,contactList:gmailList, socialProvider:provider, page:'invite'])
                        }else{
                            chain (action:"inviteMember",params:[projectId:projectId, page:page] , model:[ email:email,contactList:gmailList, socialProvider:provider, page:page])
                        }
                     }
                }
            break;
        }
	}

    @Secured('IS_AUTHENTICATED_FULLY')
    def importDataFromCSV(){
        def user =userService.getCurrentUser()
        def contacts
        if(params.filecsv in String){
            render ''
        }else{
            contacts =projectService.getDataFromImportedCSV(params.filecsv, user)
            render(contentType: 'text/json') {['contacts': contacts]}
        }  
    }
    
    def getCountryVal(){
        def country = projectService.getCountryValue(params.country)
        projectService.autoSaveCountryAndHashTags(params)
        render country
    }

    @Secured(['IS_AUTHENTICATED_FULLY'])
    def keepCampaignOnHold(){
        Project project = projectService.getProjectById(params.id)
        if (project) {
            if (userService.isAdmin()) {
                project.onHold = true
                project.save()
                redirect (action:'getCampaignList')
            } else if (userService.isPartner()) {
                project.onHold = true
                project.save()
                redirect (action:'partnerdashboard', controller:'user')
            } else {
                render view:'/401error'
            }
        } else {
            render view:'/401error'
        }
    }
    
    def isTitleUnique(){
        def status = projectService.isTitleUnique(params.title, params.projectId)
        render status
    }
    
    def uploadDigitalSignature() {
        Project project = projectService.getProjectById(params.projectId)
        TaxReciept taxReciept = projectService.getTaxRecieptOfProject(project)
        
        def imageUrl = userService.getImageUrl(params.file)
        if (imageUrl) {
            if (taxReciept){
                taxReciept.signatureUrl = imageUrl
                taxReciept.save(failOnError:true);
            } else {
                TaxReciept taxreciept = new TaxReciept()
                taxreciept.signatureUrl = imageUrl
                taxreciept.project = project
                taxreciept.save(failOnError:true);
            }
            JSONObject json = new JSONObject();
            json.put('imageUrl',imageUrl)
            render json
        }
    }
    
    def deleteDigitalSign() {
        Project project = projectService.getProjectById(params.projectId)
        TaxReciept taxReciept = projectService.getTaxRecieptOfProject(project)
        if (taxReciept){
            taxReciept.signatureUrl = null;
            taxReciept.save(failOnError:true);
        }
        render ''
    }
    
    def urlBuilder(){
        println("country_code : " + params.country_code)
        String title = projectService.getVanityTitleFromId(params?.projectId)
        String name = userService.getVanityNameFromUsername(params?.fr, params?.projectId)
        StringBuilder url = projectService.getBuildURL(params?.pkey, title, name,params.country_code)
        
        render url?url:''
    }
    
    def requiredFields(){
        
        if(request.method=="POST"){
            def requiredFieldMessage = projectService.requiredFieldsService(params) 
            render  new JSONObject(requiredFieldMessage)
        }
    }
    
//    def loadOrganizationTemplate(){
//		
//		 def currentEnv = projectService.getCurrentEnvironment()
//         def user =userService.getCurrentUser()
//		 def project = projectService.getProjectById(params.campaignId)
//		 Team team = projectService.getTeamById(params.int('teamId'))
//		 def currentFundraiser = userService.getCurrentFundRaiser(team.user, project)
//		 Team currentTeam = projectService.getCurrentTeam(project,currentFundraiser)
//		 def totalContribution = contributionService.getTotalContributionForProject(project)
//		 def percentage = contributionService.getPercentageContributionForProject(totalContribution, project)
//		 def day= projectService.getRemainingDay(project)
//		 def conversionMultiplier = projectService.getCurrencyConverter()
//		 boolean ended = projectService.isProjectDeadlineCrossed(project)
//		 
//		 def isTeamExist, percent, cents, contributedSoFar, amount
//		 
//         if(!user){
//             user = userService.getUserByEmail("anonymous@example.com")
//         }
//		 
//         if(user){
//              isTeamExist = userService.isValidatedTeamExist(project, currentTeam?.user)
//         }
//		 
//	    if (project?.user == currentTeam?.user){
//	        percent = percentage
//	        contributedSoFar = totalContribution
//	        amount = project?.amount?.round()
//	    } else {
//			def teamContribution = contributionService.getTotalContributionForUser(currentTeam?.contributions)
//	        percent = contributionService.getPercentageContributionForTeam(teamContribution, currentTeam)
//	        contributedSoFar = teamContribution
//	        amount = currentTeam?.amount?.round()
//	    }
//	    
//	    if(percent >= 100) {
//	        cents = 100
//	    } else {
//	        cents = percent
//	    }
//         
//         def model =[project:project, totalContribution:totalContribution, percentage:percentage, user:user, day:day, isTeamExist: isTeamExist,
//			 contributedSoFar: contributedSoFar, percent:percent, cents:cents, amount:amount, currentEnv: currentEnv, conversionMultiplier: conversionMultiplier]
//         
//        if(request.method=="POST"&& params.activeTab){
//            switch(params.activeTab){
//                case "story":
//                    render template:"/layouts/showTilesanstitleForOrg", model:[currentEnv:currentEnv, payuStatus: project?.payuStatus, conversionMultiplier:conversionMultiplier,
//						percent: percent, cents:cents, amount:amount, ended:ended, day:day, totalContribution:totalContribution, contributedSoFar:contributedSoFar]
//                break;
//                case "team":
//                  render template:"/layouts/show_teamtileInfo", model:model
//                break;
//                case "contribution":
//                    render template:"/layouts/contributions_tilesanstitle" , model:model
//                break;
//            }
//        }else {
//            render "Organization template not loaded. Please, refresh to load again."
//        }
//    }
	
	def deleteCommentImage(){
		
		if(request.method== 'POST'){
			if(params.commentId){
				def projectComment = projectService.getProjectCommentById(params.commentId)
				projectComment.attachFile = null
			}else if(params.teamCommentId){
				def teamComment = projectService.getTeamCommentById(params.teamCommentId)
				teamComment.attachteamfile = null
			}
		}
		
		render ''
	}
    @Secured(["IS_AUTHENTICATED_FULLY"])
    def manageDeletedCamapaigns(){
        
        if(request.method == 'POST' && params.deletedCampaign){
            def project = projectService.getProjectFromTitle(params.deletedCampaign)
            def status = projectService.setCampaignActive(project, 'deleted')
            if(status){
                render 'true'
            }else{
                render 'false'
            }
        }else {
            render ''
        }
    }
    
    @Secured(['IS_AUTHENTICATED_FULLY'])
    def restoreCampaign(){
        if(request.method=='POST' && params.projectId){
            Project project =Project.get(params.projectId)
            def status =projectService.setCampaignActive(project, 'rejected')
            if(status){
                render 'true'
            }else{
                render 'false'
            }
        }
        render ''
    }
    
    @Secured(['ROLE_USER'])
    def updateSendMailModal(){
        if(request.method=='POST'){
            Project project = projectService.getProjectById(params.projectId)
            if(project){
                def vanityTitle = projectService.getVanityTitleFromId(params.projectId)
                render (template:'show/updatesendmailmodal', model:[project:project, vanityTitle:vanityTitle])
            }
        }else{
            render ''
        }
    }
	
	@Secured(['IS_AUTHENTICATED_FULLY'])
	def generateSellerId() {
		String status = "FAILURE";
		
		Project project = projectService.getProjectById(params.projectId);
		JSONObject json = new JSONObject();
		
		if (project != null && !project.validated) {
			boolean statusFlag = userService.setBankInfoDetails(params, project)
			if (statusFlag && project.citrusEmail != null && project.payuStatus) {
				def sellerObj = contributionService.setSellerId(project)
				
				if (sellerObj.sellerId != null && sellerObj.errorCode == null) {
					project.sellerId = sellerObj.sellerId
					
					if (sellerObj.sellerId && sellerObj.errorCode) {
						project.save();
					}
					status = "SUCCESS"
				} else {
					status = "FAILURE"
					json.put("errorDescription", sellerObj.errorDescription)
					json.put("errorCode", sellerObj.errorCode)
				}
			}
		} else if (project != null && project.validated) {
			json.put("status", "SUCCESS")
		}
		
		json.put("status", status)
		render json;
	}
	
	
	def authenticateWePayEmail() {
		
		JSONObject json = new JSONObject();
		Project project = projectService.getProjectById(params.projectId)
		if (project && params.email && params.firstName && params.lastName) {
			
			if (!project.validated) {
				def wePayObj = campaignService.registerUser(params.email, params.firstName, params.lastName, request)
				
				if (wePayObj.status == 200) {
					def accountId = campaignService.getWePayAccountId(wePayObj.accessToken, params.firstName, params.email, project)
					
					log.info("WePay User AccountId = "+accountId);
					
					def jsonObj = campaignService.confirmUser(params.email, params.firstName, params.lastName, wePayObj.accessToken, request)
					json.put("status", 1);
					json.put("userState", jsonObj.state)
					
					log.info("WePay User userState = "+jsonObj.state);
					
					project.wepayAccountId = accountId
					project.wepayAccessToken = wePayObj.accessToken
					project.wepayAccountStatus = "pending"
					project.save();
					
				} else {
					json.put("status", -99)
					log.info("WePay User registration Failed");
				}
			
			} else {
				json.put("status", 1);
			}
		} else {
			json.put("status", -99);
			log.info("Invalid Parameters for WepayAuthentication");
		}
		
		render json;
	}
	
	def wepayAccountCreateCallBack() {
		
		log.info("WEPAY ACCOUNT CALLBACK FUNCTION GETS CALLED");
		String accountId = request.getParameter("account_id")
		log.info("CALL BACK URI -- ACCOUNT ID == "+ accountId)
		
		if (accountId != null) {
			
			Project project = projectService.getProjectByWepayAccountId(accountId)
			if (project != null) {
				def wepayAccountStatus;
				if (project.wepayEmail && project.wepayAccountId != 0) {
					wepayAccountStatus = campaignService.getWepayAccountStatus(project.wepayAccountId, project.wepayAccessToken);
					
					project.wepayAccountStatus = wepayAccountStatus;
					project.save();
					log.info("WEPAY ACCOUNT Call back URI : Wepay Account Status = "+ wepayAccountStatus)
				}
			}
		}
	}
	
	
	@Secured(['ROLE_ADMIN'])
	def ownershiptransfer()	{
		def message
		String username = params.username
		String projectId = params.projectid
		def user = userService.getUserByUsername(username)
		
		if(user){
			Project project = projectService.getProjectById(projectId)
			Team team = Team.findByProjectAndUser(project,project.user )
			projectService.transferownership(project,team,user)
			message = 'Cheers...! Campaign transferred successfully...!'
			render message
		} else{
			message = 'Oops...! Please, enter the valid username. '
			render message
		}
	}
	
}
