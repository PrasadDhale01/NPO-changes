package crowdera

import static java.util.Calendar.*
import grails.transaction.Transactional
import grails.util.Environment
import groovy.json.JsonSlurper
import groovyx.net.http.ContentType
import groovyx.net.http.HTTPBuilder
import groovyx.net.http.Method

import java.security.MessageDigest
import java.text.DateFormat
import java.text.SimpleDateFormat

import javax.servlet.http.Cookie
import javax.websocket.Session;
import javax.servlet.http.HttpServletRequest;

import org.springframework.web.context.request.RequestContextHolder
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.commons.CommonsMultipartFile
import org.apache.http.HttpEntity
import org.apache.http.HttpRequest;
import org.apache.http.HttpResponse
import org.apache.http.client.HttpClient
import org.apache.http.client.methods.HttpPost
import org.apache.http.entity.StringEntity
import org.apache.http.impl.client.DefaultHttpClient
import org.grails.datastore.mapping.query.Query.IsNotNull;
import org.hibernate.Session
import org.hibernate.SessionFactory
import org.hibernate.criterion.Projections;
import org.hibernate.criterion.Restrictions;
import org.jets3t.service.impl.rest.httpclient.RestS3Service
import org.jets3t.service.model.*

import grails.util.Environment
import groovy.json.JsonSlurper
import static java.util.Calendar.*

import org.apache.http.util.EntityUtils
import org.jets3t.service.security.AWSCredentials

/*Merging Master branch changes*/
class ProjectService {
    def userService
    def contributionService
    def grailsLinkGenerator
    def imageFile
    def imageUrlService
    def mandrillService
    def rewardService
    def grailsApplication
    def socialAuthService
    def roleService
    
    SessionFactory sessionFactory;
	
	@Lazy
	private static List<Team> allTeams = new ArrayList<Team>()
	
	private static List<Team> allSortedTeams = new ArrayList<Team>()


    def getProjectById(def projectId){
        if (projectId) {
            return Project.get(projectId)
        }
        
    }
	
	Project getProjectByWepayAccountId(String accountId) {
		int wepayAccountId = Integer.parseInt(accountId)
		return Project.findByWepayAccountId(wepayAccountId)
	}

    def getTaxRecieptById(def taxRecieptId){
        if (taxRecieptId){
            return TaxReciept.get(taxRecieptId)
        }
    }

    def getImageUrlById(def imageId){
        if (imageId) {
            return ImageUrl.get(imageId)
        }
    }

    def getTeamById(def teamId){
        if (teamId) {
            return Team.get(teamId)
        }
    }

    def getTeamCommentById(def teamCommentId){
        if (teamCommentId) {
            return TeamComment.get(teamCommentId)
        }
    }

    def getTeamByUserAndProject(def project, def user){
        def team = Team.findByUserAndProject(user, project)
        return team
    }
    
    def getTeamByUsernameAndProject(def username, def project){
         def user = User.findByUsername(username)
         def team= Team.findByUserAndProject(user, project)

         if(team){
             return team
         }
         
         return null
    }
    
    def getEnableTeamFirstNameAndLastName(def teams) {
        Map teamNameMap = [:]
        
        teams.each { team->
            if(team.enable && team.contributions.size() > 0){
                teamNameMap.put(team.id, team.user.firstName +' ' + team.user.lastName)
            }
        }
        
//        sessionServiceProxy.addKeyToPageAttribute('', );
        return teamNameMap
    }
    
    def getTeamFirstNameAndLastName(def teams){
        Map teamNameMap = [:]
        
        teams.each { team ->
            if(team.enable) {
                teamNameMap.put(team.id, team.user.firstName +' ' + team.user.lastName)
            }
        }
        return teamNameMap
    }

    def getProjectAdminByEmail(def email){
        return ProjectAdmin.findByEmail(email)
    } 

    def getProjectCommentById(def commentId) {
        if (commentId) {
            return ProjectComment.get(commentId)
        }
    }
    
    def getCurrentEnvironment() {
        return Environment.current.getName()
    }
    
    def getBankInfoByProject(Project project) {
        return BankInfo.findByProject(project)
    }
    
    def getProjectByParams(def projectParams){
         Project project = new Project(projectParams)
		 Beneficiary beneficiary = new Beneficiary();
         project.beneficiary = beneficiary
         project.category = "Others"
         project.created = new Date()
         User user = userService.getCurrentUser()
         project.user = user
         return project
    } 

    def getListOfValidatedProjects() {
        List projects = Project.findAllWhere(validated: true)
        return projects
    }
    
    def getNumberOfEndedAndLiveCampaigns(List projects) {
        def totalProjects = projects.size();
        def LiveProjects = 0
        def endedProjects = 0
        projects.each { project->
            if (getRemainingDay(project) > 0) {
                LiveProjects = LiveProjects + 1
            } else {
                endedProjects = endedProjects + 1
            }
        }
        return [LiveProjects : LiveProjects , endedProjects: endedProjects, totalProjects: totalProjects]
    }
    
    def getNumberOfMostSelectedCategoryAndCount(List projects) {
        int animals = 0, arts = 0, children = 0, community = 0, education = 0, elderly = 0, environment = 0, health = 0, social_innovation = 0, religion = 0, other= 0
        projects.each{ project->
            def category = project.category
            
            switch (category) {
                case 'ANIMALS':
                    animals = animals + 1
                    break;
                case 'ARTS':
                    arts = arts + 1
                    break;
                case 'CHILDREN':
                    children = children + 1
                    break;
                case 'COMMUNITY':
                    community = community + 1
                    break;
                case 'EDUCATION':
                    education = education + 1
                    break;
                case 'ELDERLY':
                    elderly = elderly + 1
                    break;
                case 'ENVIRONMENT':
                    environment = environment + 1
                    break;
                case 'HEALTH':
                    health = health + 1
                    break;
                case 'SOCIAL_INNOVATION':
                    social_innovation = social_innovation + 1
                    break;
                case 'RELIGION':
                    religion = religion + 1
                    break;
                case 'OTHER':
                    other = other + 1
                    break;
                default :
                    other = other + 1
            }
        }
        
        Map categories = ['Animals' : animals, 'Arts': arts, 'Children' : children, 'Community': community, 'Education' : education,'Elderly': elderly, 'Environment': environment,'Health': health, 'Social_innovation': social_innovation, 'Religion': religion,'Other': other]
        def mostSelectedCategory = categories.max { it.value }.key
        def mostSelectedCategoryCount = categories.max { it.value }.value
        return [mostSelectedCategory: mostSelectedCategory, mostSelectedCategoryCount: mostSelectedCategoryCount]
    }

    def getProjectUpdateDetails(def params, Project project,def country_code){
        def vanitytitle
        User currentUser = userService.getCurrentUser()
        def fullName = currentUser?.firstName + ' ' + currentUser?.lastName
        def currentEnv = Environment.current.getName()
        project.story = params?.story
        
        if (!project.validated) {
            project.paypalEmail = params.paypalEmail
            project.charitableId = params.charitableId
            project.organizationName = params.organizationName
        }
        
        def taxReciept = TaxReciept.findByProject(project)
        if (project.beneficiary.country == 'null') {
            if('in'.equalsIgnoreCase(country_code)) {
                project.beneficiary.country = 'IN'
                if (taxReciept){
                    taxReciept.country = 'India'
                    taxReciept.save();
                }
            } else {
                project.beneficiary.country = 'US'
                if (taxReciept){
                    taxReciept.country = (taxReciept.country && taxReciept.country != 'null') ? taxReciept.country : 'United States';
                    taxReciept.save();
                }
            }
        }
        
         if('in'.equalsIgnoreCase(country_code)) {
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
        
        def projectAdmins = project?.projectAdmins
        
        projectAdmins.each { projectAdmin ->
            def email = projectAdmin?.email
            if (currentUser?.email != email) {
                mandrillService.sendUpdateEmailToAdmin(email, fullName, project,country_code)
            }
        }

        def projectOwner = project.user
        ///if (projectOwner != currentUser) {
            def projectOwnerEmail = projectOwner.getEmail()
            mandrillService.sendUpdateEmailToAdmin(projectOwnerEmail, fullName, project,country_code)
        //}

        if (project.customVanityUrl && project.customVanityUrl != ''){
            vanitytitle = getCustomVanityUrl(project);
        } else {
            vanitytitle = vanityTitleOriginal(project)
            vanitytitle = (vanitytitle) ? vanitytitle : getProjectVanityTitle(project)
        }
        project.save();
        return vanitytitle
    }

    def vanityTitleOriginal (Project project){
        String vanitytitle
        def title = project.title.trim().replaceAll("[^a-zA-Z0-9]", "-")
        def vanityTitleList = VanityTitle.findAllWhere(title:title)
        if (vanityTitleList){
            vanityTitleList.each{
                if (it.project == project)
                    vanitytitle = it.vanityTitle
            }
        }
        return vanitytitle
    }

	def getCSVDetails(def params, def response){
		List contributions=[]

		def projectId= params.projectId
		def project = Project.get(projectId)

		def teamId = params.teamId
		def team = Team.get(teamId)

		if(team!=null) {
			if(project.user==team.user){
				contributions = project.contributions.reverse()
			} else {
				contributions = team.contributions.reverse()
			}
		} else {
			contributions = project.contributions.reverse()
		}

		response.setHeader("Content-disposition", "attachment; filename= Crowdera_report-"+project.title.replaceAll("[,;\\s]",'_')+".csv")
		def results=[]
		def  contributorName
		def payMode
		def shippingDetails=""
		def contributorEmail
		def currency
		contributions.each {
			if(it.isContributionOffline){
				payMode="offline"
				contributorName= it.contributorName
				contributorEmail= it.contributorEmail?it.contributorEmail:'-'
				shippingDetails="No Perk Selected"
				currency= it.currency
			}else{
				payMode="Online"
				contributorName= it.contributorName
				contributorEmail=it.contributorEmail
				shippingDetails= getShippingDetails(it)
				currency= it.currency
			}
			def fundRaiserName = contributionService.getFundRaiserName(it, project)
			if(project.rewards.size()>1){
				def rows = [it.project.title.replaceAll("[,;]",' '), fundRaiserName, it.date.format('YYYY:MM:dd HH:mm:ss'), contributorName, contributorEmail, it.reward.title.replaceAll("[,;]",' '), shippingDetails.replaceAll("[,]",' '), it.amount, it.currency, payMode]
				results << rows
				shippingDetails=""
			} else {
				def rows = [it.project.title.replaceAll("[,;]",' '), fundRaiserName, it.date.format('YYYY:MM:dd HH:mm:ss'), contributorName, contributorEmail, it.amount, it.currency, payMode]
				results << rows
				shippingDetails=""
			}
		}
		
		def result
		if(project.rewards.size()>1){
			result='CAMPAIGN, FUNDRAISER, DATE AND TIME, CONTRIBUTOR NAME,CONTRIBUTOR EMAIL, PERK , SHIPPING DETAILS, AMOUNT, CURRENCY, MODE \n'
			results.each{ row->
				row.each{
					col -> result+=col +','
				}
				result = result[0..-2]
				result+="\n"
			}
		}else{
			result='CAMPAIGN, FUNDRAISER, DATE AND TIME, CONTRIBUTOR NAME,CONTRIBUTOR EMAIL, AMOUNT, CURRENCY, MODE \n'
			results.each{ row->
				row.each{
					col -> result+=col +','
				}
				result = result[0..-2]
				result+="\n"
			}
		}
		return result
	}
	
    def getUpdateValidationDetails(def params){
        def project = Project.get(params.id)
		def country_code = project.country.countryCode
		
        if (project) {
            project.created = new Date()
            if(!project.validated) {
                /*if (project.citrusEmail != null && project.payuStatus) {
                    def sellerId = contributionService.setSellerId(project)
                    project.sellerId = sellerId
                }*/
                
                project.validated = true
                project.onHold = false
                project.save()
                mandrillService.sendValidationEmailToOWnerAndAdmins(project,country_code)
                //sendEmailOnValidation(project)
            }
        }
    }

    def getCommentsDetails(params){
        def project = Project.get(params.id)
        
        if (project && params.comment) {
            new ProjectComment(
                comment: params.comment,
                user: userService.getCurrentUser(),
                project: project,
                attachFile: params.fileComment,
                date: new Date()).save(failOnError: true)
        }
    }
    

     def getUpdateCommentDetails(def request){
         def checkid= request.getParrmeter('checkID')
         def proComment = ProjectComment.get(checkid)
         def status = request.getParameter('status')
         if(status=='false'){
             proComment.status=false
         }else{
             proComment.status=true
         }
     }

     def getEditedFundraiserDetails(def params, def team){
         def user = userService.getCurrentUser()
         def project = Project.get(params.project)
         def amount = Double.parseDouble(params.amount)
         if(amount <= project.amount){
             team.amount = amount
         }
         
         def video
         if (params.videoUrl) {
            def youtube = /^.*(youtube\/|v\/|u\/\w\/|embed\/|watch\?v=|\&v=)([^#\&\?]*).*/;
            def vimeo = /https?:\/\/(www\.)?vimeo.com\/(\d+)($|\/)/;
            def match = params.videoUrl.matches(youtube);
            def vimeomatch = params.videoUrl.matches(vimeo);
            if (match && !params.videoUrl.contains('embed')) {
                String videoUrl = params.videoUrl.replace("watch?v=","embed/")
                videoUrl = videoUrl + "?rel=0"
                video = videoUrl
            } else if (vimeomatch){
                video = params.videoUrl
            }
         }
         team.videoUrl = video
         team.story = params.story
         team.description = params.description
         def message = "Team Updated Successfully"
		 def country_code = project.country.countryCode
         if (user == project.user) {
             mandrillService.sendTeamUpdationEmail(project, team,country_code)
         }

         return message
     }

     def getTeamCommentsDetails(def params){
         def fundRaiser = params.fr
         def message
         User user = User.findByUsername(fundRaiser)
         Project project = Project.get(params.id)
         Team team = getTeamByUserAndProject(project, user)
         
         if (team) {
             TeamComment teamComment = new TeamComment(
                 comment: params.comment,
                 user: userService.getCurrentUser(),
                 team: team,
                 attachteamfile: params.teamfileComment,
                 date: new Date())
             team.addToComments(teamComment).save(failOnError: true)
         } else {
             message = "Something went wrong saving comment. Please try again later."
         }
         return message
     }

     def getContributionDeleteDetails(def params){
         def contribution = contributionService.getContributionById(params.long('id'))
         def project = Project.get(params.projectId)
         def fundraiser = params.fr
         def fundRaiser = User.findByUsername(fundraiser)
         Team team = getTeamByUserAndProject(project, fundRaiser)
         if (team) {
             List teamContributions = team.contributions
             teamContributions.remove(contribution)
         }

         List contributions = project.contributions
         contributions.remove(contribution)

         contribution.delete();
     }
	 
	 def getEmailDetails(def params){
		 def project = Project.get(params.id)
		 def fundraiser = User.get(params.long('fr'))
		 String emails = params.emails
		 String name = params.name
		 String message = params.message
		 String country_code = project.country.countryCode;

		 def emailList = emails.split(',')
		 emailList = emailList.collect { it.trim() }

		 mandrillService.shareContribution(emailList, name, message,project,fundraiser,country_code)
	 }

	def getTwitterShareUrlForCampaign(Project project, def fundraiser, def base_url){
		def vanityTitle = getVanityTitleFromId(project.id)
		def vanityUserName = userService.getVanityNameFromUsername(fundraiser.username, project.id)
		def url = base_url+'/campaigns/'+vanityTitle+'/'+vanityUserName
		return url
	}
	
	
	int getFacebookShareCountForCampaign(String campaignUrl){
		def httpFb = new HTTPBuilder('http://graph.facebook.com/?id=' + campaignUrl)
		int facebookCount= 0;
		
		try{
			httpFb.request(Method.GET, ContentType.JSON) {
				response.success = { resp, reader ->
					facebookCount = reader.share?.share_count?:0
				}
				
				response.failure = { resp, json ->
					return facebookCount
				}
			}
		}catch(UnknownHostException e){
			return facebookCount
		}catch(Exception e){
			return facebookCount
		}
			
		return facebookCount
	}

    def getUserContributionDetails(Project project,Reward reward, def amount,String transactionId,User users,User fundraiser,def params, def address, def request){
        def emailId, twitter,custom, userId,anonymous,panNumber
        def currency
		
		def countryCode = getCountryCodeForCurrentEnv(request)
		
		if(project.payuEmail && 'in'.equalsIgnoreCase(countryCode)) {
			currency = 'INR'
			twitter = request.getParameter('shippingTwitter')
			panNumber = request.getParameter('panNumber')
		} else if (project.paypalEmail || project.charitableId) {
			currency = 'USD'
			twitter = request.getParameter('twitterHandle')
		}
		
        /*if ((project.payuEmail && project.paypalEmail && 'us'.equalsIgnoreCase(countryCode)) || project.charitableId || 
			(project.citrusEmail && project.paypalEmail && 'us'.equalsIgnoreCase(countryCode)) ) {
			
			currency = 'USD'
			twitter = request.getParameter('twitterHandle')
		} else if(project.payuEmail) {
            currency = 'INR'
            twitter = request.getParameter('shippingTwitter')
            panNumber = request.getParameter('panNumber')
			
        } else if (project.paypalEmail) {
            currency = 'USD'
            twitter = request.getParameter('twitterHandle')
        }*/
		
		emailId = request.getParameter('shippingEmail')
		anonymous = request.getParameter('anonymous')
		userId = request.getParameter('tempValue')
		custom =  request.getParameter('shippingCustom')
        
        def shippingDetail = checkShippingDetail(emailId,twitter,address, custom)
        def name
        def username
 
        if (userId == null || userId == 'null' || userId.isAllWhitespace()) {
            if (project.paypalEmail || project.payuEmail) {
                name = request.getParameter('name')      
                username = request.getParameter('email')
            } else {
                name = params.billToFirstName + " " +params.billToLastName
                username = params.billToEmail
            }
        } else {
            def orgUser = User.get(userId)
            name = orgUser.firstName + " " + orgUser.lastName
            username = orgUser.email
        }
 
        Contribution contribution = new Contribution(
            date: new Date(),
            user: users,
            reward: reward,
            amount: amount,
            email: shippingDetail.emailid,
            twitterHandle: shippingDetail.twitter,
            custom: shippingDetail.custom,
            contributorName: name,
            contributorEmail:username,
            physicalAddress: shippingDetail.address,
            currency : currency,
            panNumber : panNumber,
			active   : true
        )
        project.addToContributions(contribution).save(failOnError: true)
		 
        Team team = Team.findByUserAndProject(fundraiser,project)
        if (team) {
            contribution.fundRaiser = fundraiser.username
            team.addToContributions(contribution).save(failOnError: true)
        }
		def country_code = project.country.countryCode
        contribution.isAnonymous = anonymous.toBoolean()
        
        if (project.payuStatus && project.contributions.size() == 1) {
            mandrillService.sendEmailToCampaignOwner(project, contribution,country_code) //Send Email to Campaign Owner when first contribution is done for INR
        }
		 
        userService.contributionEmailToOwnerOrTeam(fundraiser, project, contribution)
        
        def totalContribution = contributionService.getTotalContributionForProject(project)
        if(totalContribution >= project.amount){
            if(project.send_mail == false){
                def contributor = contributionService.getTotalContributors(project)
                contributor.each {
                    def user = User.get(it)
                    if (user.email != 'anonymous@example.com'){
                        mandrillService.sendContributorEmail(user, project)
                    }
                }
                def beneficiaryId = getBeneficiaryId(project)
                def beneficiary = Beneficiary.get(beneficiaryId)
                def user = User.list()
                user.each{
                   if(it.email == beneficiary.email){
                       mandrillService.sendBeneficiaryEmail(it,getCountryCodeForCurrentEnv(request))
                   }
                }
                project.send_mail = true
             }
         }
		 
         Transaction transaction = new Transaction(
             transactionId:transactionId,
             user:users,
             project:project,
             contribution:contribution,
             currency : currency
         )
         transaction.save(failOnError: true)
         return contribution.id
     }
     
     def getpayKeytempObject(def timestamp){
         PaykeyTemp paykeytemp = PaykeyTemp.findByTimestamp(timestamp)
         if(paykeytemp){
             return paykeytemp
         }
     }
	 
	 def generateCSV(def response, def params){
		 SimpleDateFormat dateFormat = new SimpleDateFormat("YYYY:MM:dd hh:mm:ss");
		 def userIdentity
		 def mode
		 def contributions
		 if (params.currency == 'INR'){
			 contributions = contributionService.getINRContributions()
		 } else {
			 contributions = contributionService.getUSDContributions()
		 }
		 List results=[]
	 
	 response.setHeader("Content-disposition", "attachment; filename=Crowdera_Transaction_Report.csv")
	 contributions.each{
		if (it.isAnonymous) {
			userIdentity = "Anonymous"
		} else {
			userIdentity = "Non Anonymous"
		}

		if(it.isContributionOffline){
			mode = 'Offline'
		} else {
			mode = 'Online'
		}

		def rows = [dateFormat.format(it.date), it.project.title.replaceAll('[,;] ',' '), it.contributorName, userIdentity, it.amount, it.contributorEmail, mode]
		results << rows
	 }
	 
	 def result='Contribution Date & Time, Campaign, Contributor Name, Identity, Contributed Amount, Contributor Email, Mode \n'
	 results.each{ row->
		row.each{
		col -> result+=col +','
		}
		result = result[0..-2]
		result+="\n"
	 }
	 
	 	return result
	 }

	 def getOfflineDetails(def params) {
		 def project = Project.get(params.id)
		 boolean userExist =false
		 def contributorEmail1 = params.contributorEmail1
		 def contributorFirstName = params.contributorName1
		 def amount = params.amount1
		 def contributorLastName = params.contributorLastName
		 
		 User contributor = User.findByEmail(contributorEmail1.trim())
		 def user;
		 
		 if(contributor != null){
			 userExist =true
		 } else {
			 user = createUserForNonRegisteredContributors(contributorFirstName, contributorEmail1, contributorLastName)
		 }
		 
		 def reward = rewardService.getNoReward()
		 
		 User fundRaiser = userService.getCurrentUser()
		 def username = fundRaiser.username
		 
		 def currency = params.currency
		 def contributorFullname = contributorFirstName +" "  + contributorLastName
		 def contributorName = ""
		 	contributorFullname.split(" ").each { word ->
			contributorName += word[0].toUpperCase() + word[1..(word.size()-1)].toLowerCase()+" "
		 }
		 if (amount && contributorFirstName && contributorEmail1 && contributorLastName) {
			 Contribution contribution = new Contribution(
					date: new Date(),
					user: (userExist) ? contributor : user.user,
					reward: reward,
					amount: amount,
					contributorFirstName: contributorFirstName,
					contributorLastName: contributorLastName,
					contributorName: contributorName,
					contributorEmail: contributorEmail1,
					panNumber: params.panNumber,
					isContributionOffline: true,
					fundRaiser: username,
					currency:currency,
					active: true
			 )
			 project.addToContributions(contribution).save(failOnError: true)
 
			 Team team = Team.findByUserAndProject(fundRaiser,project)
			 if (team) {
				 team.addToContributions(contribution).save(failOnError: true)
			 } else {
				 
				 if (userService.isAdmin() || userService.isCampaignAdmin(project, username)) {
					 team = Team.findByUserAndProject(project.user , project);
					 team.addToContributions(contribution).save(failOnError: true)
				 }
			 }
			 
			 if(userExist==false){
				 mandrillService.sendEmailToContributors(contribution, user.password)
			 }
		 }
		 
	 }

     def getCommentDeletedDetails(def params){
         def project = Project.get(params.projectId)
         def fundraiser = params.fr
         def fundRaiser = userService.getUserByUsername(fundraiser)
         Team team = getTeamByUserAndProject(project, fundRaiser)
         if (team && params.teamCommentId) {
             def teamcomment = TeamComment.get(params.long('teamCommentId'))
             if (teamcomment) {
                 List teamComments = team.comments
                 teamComments.remove(teamcomment)
                 teamcomment.delete()
             }
         }
         if (project && params.commentId){
             def projectcomment= ProjectComment.get(params.long('commentId'))
             if (projectcomment) {
                 List projectComments = project.comments
                 projectComments.remove(projectcomment)
                 projectcomment.delete()
             }
         }
    }

    def getContributionEditedDetails(def params){
        def contribution = Contribution.get(params.long('contributionId'))
        if (contribution) {
            contribution.contributorFirstName= params.contributorName
            contribution.contributorLastName = params.contributorLastName
            contribution.contributorName = params.contributorName+" "+params.contributorLastName
            contribution.amount = Double.parseDouble(params.amount)
            contribution.contributorEmail = params.contributorEmail
            contribution.panNumber = params.panNumber1
            contribution.save()
        }
    }

    def getNumberOfProjects() {
        return Project.count()
    }
    
    def getcardtypes(){
        def cardtypes=[
            VI: 'Visa',
            MC: 'Mastercard',
            DI: 'Discover Card',
            AX: 'American Express'
        ]
        return cardtypes
    }
    
    def getProjectUpdateById(def projectUpdateId) {
        def projectUpdate = ProjectUpdate.get(projectUpdateId)
        return projectUpdate
    }
    
    def getTitle(){
        def title = [
           Dr:'Dr.',
           Esq:'Esq.',
           Er:'Er',
           Hon:'Hon.',
           Jr:'Jr.',
           Lect:'Lect.',
           Miss:'Miss',
           Mr:'Mr.',
           Mrs:'Mrs.',
           Ms:'Ms.',
           Messr:'Messrs.',
           Mmes:'Mmes.',
           Msgr:'Msgr.',
           Prof:'Prof.',
           Rev:'Rev.',
           RtHon:'Rt. Hon.',
           Sr:'Sr.',
           St:'St.'
        ]
        return title
    }
    
    def getCountry(){
        def country = [
           AF:'Afghanistan',
           AX:'Aland Islands',
           AL:'Albania',
           DZ:'Algeria',
           AS:'American Samoa',
           AD:'Andorra',
           AO:'Angola',
           AI:'Anguilla',
           AQ:'Antarctica',
           AG:'Antigua and Barbuda',
           AR:'Argentina',
           AM:'Armenia',
           AW:'Aruba',
           AU:'Australia',
           AT:'Austria',
           AZ:'Azerbaijan',
           BS:'Bahamas',
           BH:'Bahrain',
           BD:'Bangladesh',
           BB:'Barbados',
           BY:'Belarus',
           BE:'Belgium',
           BZ:'Belize',
           BJ:'Benin',
           BM:'Bermuda',
           BT:'Bhutan',
           BO:'Bolivia',
           BA:'Bosnia and Herzegovina',
           BW:'Botswana',
           BV:'Bouvet Island',
           BR:'Brazil',
           IO:'British Indian Ocean Territory',
           BN:'Brunei Darussalam',
           BG:'Bulgaria',
           BF:'Burkina Faso',
           BI:'Burundi',
           KH:'Cambodia',
           CM:'Cameroon',
           CA:'Canada',
           CV:'Cape Verde',
           KY:'Cayman Islands',
           CF:'Central African Republic',
           TD:'Chad',
           CL:'Chile',
           CN:'China',
           CX:'Christmas Island',
           CC:'Cocos (Keeling) Islands',
           CO:'Colombia',
           KM:'Comoros',
           CG:'Congo',
           CD:'Congo, The Democratic Republic of The',
           CK:'Cook Islands',
           CR:'Costa Rica',
           CI:'Cote D\'ivoire',
           HR:'Croatia',
           CU:'Cuba',
           CY:'Cyprus',
           CZ:'Czech Republic',
           DK:'Denmark',
           DJ:'Djibouti',
           DM:'Dominica',
           DO:'Dominican Republic',
           EC:'Ecuador',
           EG:'Egypt',
           SV:'El Salvador',
           GQ:'Equatorial Guinea',
           ER:'Eritrea',
           EE:'Estonia',
           ET:'Ethiopia',
           FK:'Falkland Islands (Malvinas)',
           FO:'Faroe Islands',
           FJ:'Fiji',
           FI:'Finland',
           FR:'France',
           GF:'French Guiana',
           PF:'French Polynesia',
           TF:'French Southern Territories',
           GA:'Gabon',
           GM:'Gambia',
           GE:'Georgia',
           DE:'Germany',
           GH:'Ghana',
           GI:'Gibraltar',
           GR:'Greece',
           GL:'Greenland',
           GD:'Grenada',
           GP:'Guadeloupe',
           GU:'Guam',
           GT:'Guatemala',
           GG:'Guernsey',
           GN:'Guinea',
           GW:'Guinea-bissau',
           GY:'Guyana',
           HT:'Haiti',
           HM:'Heard Island and Mcdonald Islands',
           VA:'Holy See (Vatican City State)',
           HN:'Honduras',
           HK:'Hong Kong',
           HU:'Hungary',
           IS:'Iceland',
           IN:'India',
           ID:'Indonesia',
           IR:'Iran, Islamic Republic of',
           IQ:'Iraq',
           IE:'Ireland',
           IM:'Isle of Man',
           IL:'Israel',
           IT:'Italy',
           JM:'Jamaica',
           JP:'Japan',
           JE:'Jersey',
           JO:'Jordan',
           KZ:'Kazakhstan',
           KE:'Kenya',
           KI:'Kiribati',
           KP:'Korea, Democratic People\'s Republic of',
           KR:'Korea, Republic of',
           KW:'Kuwait',
           KG:'Kyrgyzstan',
           LA:'Lao People\'s Democratic Republic',
           LV:'Latvia',
           LB:'Lebanon',
           LS:'Lesotho',
           LR:'Liberia',
           LY:'Libyan Arab Jamahiriya',
           LI:'Liechtenstein',
           LT:'Lithuania',
           LU:'Luxembourg',
           MO:'Macao',
           MK:'Macedonia, The Former Yugoslav Republic of',
           MG:'Madagascar',
           MW:'Malawi',
           MY:'Malaysia',
           MV:'Maldives',
           ML:'Mali',
           MT:'Malta',
           MH:'Marshall Islands',
           MQ:'Martinique',
           MR:'Mauritania',
           MU:'Mauritius',
           YT:'Mayotte',
           MX:'Mexico',
           FM:'Micronesia, Federated States of',
           MD:'Moldova, Republic of',
           MC:'Monaco',
           MN:'Mongolia',
           ME:'Montenegro',
           MS:'Montserrat',
           MA:'Morocco',
           MZ:'Mozambique',
           MM:'Myanmar',
           NA:'Namibia',
           NR:'Nauru',
           NP:'Nepal',
           NL:'Netherlands',
           AN:'Netherlands Antilles',
           NC:'New Caledonia',
           NZ:'New Zealand',
           NI:'Nicaragua',
           NE:'Niger',
           NG:'Nigeria',
           NU:'Niue',
           NF:'Norfolk Island',
           MP:'Northern Mariana Islands',
           NO:'Norway',
           OM:'Oman',
           PK:'Pakistan',
           PW:'Palau',
           PS:'Palestinian Territory, Occupied',
           PA:'Panama',
           PG:'Papua New Guinea',
           PY:'Paraguay',
           PE:'Peru',
           PH:'Philippines',
           PN:'Pitcairn',
           PL:'Poland',
           PT:'Portugal',
           PR:'Puerto Rico',
           QA:'Qatar',
           RE:'Reunion',
           RO:'Romania',
           RU:'Russian Federation',
           RW:'Rwanda',
           SH:'Saint Helena',
           KN:'Saint Kitts and Nevis',
           LC:'Saint Lucia',
           PM:'Saint Pierre and Miquelon',
           VC:'Saint Vincent and The Grenadines',
           WS:'Samoa',
           SM:'San Marino',
           ST:'Sao Tome and Principe',
           SA:'Saudi Arabia',
           SN:'Senegal',
           RS:'Serbia',
           SC:'Seychelles',
           SL:'Sierra Leone',
           SG:'Singapore',
           SK:'Slovakia',
           SI:'Slovenia',
           SB:'Solomon Islands',
           SO:'Somalia',
           ZA:'South Africa',
           GS:'South Georgia and The South Sandwich Islands',
           ES:'Spain',
           LK:'Sri Lanka',
           SD:'Sudan',
           SR:'Suriname',
           SJ:'Svalbard and Jan Mayen',
           SZ:'Swaziland',
           SE:'Sweden',
           CH:'Switzerland',
           SY:'Syrian Arab Republic',
           TW:'Taiwan, Province of China',
           TJ:'Tajikistan',
           TZ:'Tanzania, United Republic of',
           TH:'Thailand',
           TL:'Timor-leste',
           TG:'Togo',
           TK:'Tokelau',
           TO:'Tonga',
           TT:'Trinidad and Tobago',
           TN:'Tunisia',
           TR:'Turkey',
           TM:'Turkmenistan',
           TC:'Turks and Caicos Islands',
           TV:'Tuvalu',
           UG:'Uganda',
           UA:'Ukraine',
           AE:'United Arab Emirates',
           GB:'United Kingdom',
           US:'United States',
           UM:'United States Minor Outlying Islands',
           UY:'Uruguay',
           UZ:'Uzbekistan',
           VU:'Vanuatu',
           VE:'Venezuela',
           VN:'Viet Nam',
           VG:'Virgin Islands, British',
           VI:'Virgin Islands, U.S.',
           WF:'Wallis and Futuna',
           EH:'Western Sahara',
           YE:'Yemen',
           ZM:'Zambia',
           ZW:'Zimbabwe',
        ]
        return country
    }
    
    Map<String, String> getRequiredFields(){
        Map<String, String> requiredFields =[
            "spendCause":"Please fill spend matrix cause.",
            "spendAmount":"Please fill spend matrix amount.",
            "reason1":"Please fill reason one field in 'reason to fund'.",
            "reason2":"Please fill reason two field in 'reason to fund'.",
            "reason3":"Please fill reason three field in 'reason to fund'.",
            "city":"Please fill city.",
            "organizationname":"Please fill organization name.",
            "telephone":"Please fill phone field in 'update personal information' section.",
            "webAddress":"Please fill web address.",
            "ans1":"Please select 'Your contributors want to know' option(s).",
            "ansText":"Please fill 'Your contributors want to know' field(s).",
            "ans3":"Please select 'Your contributors want to know' option(s).",
            "ans4":"Please select 'Your contributors want to know' option(s).",
            "projectImageFile":"Please upload aleast one image.",
            /*"impactAmount":"Please fill impact assessment amount.",*/
            "impactNumber":"Please fill impact assessment number.",
            "checkBox":"Please check 'Terms of use and privacy policy' checkbox.",
            "paypalEmailId":"Please fill Paypal email id.",
            "iconfile":"Please upload display picture.",
            "answer":"Please select perk option.",
            "rewardTitle":"Please fill perk title.",
            "rewardDesc":"Please fill perk description.",
            "rewardNumberAvailable":"Please fill available perk number.",
            "rewardPrice":"Please fill perk price.",
            "ein":"Please fill ein field in tax receipt section",
            "tax-reciept-holder-name":"Please fill name field in tax receipt section",
            "addressLine1":"Please fill address field in tax receipt section.",
            "tax-reciept-holder-city":"Please fill city field in tax receipt section.",
            "zip":"Please fill zip field in tax receipt section.",
            "tax-reciept-holder-state":"Please fill state field in tax receipt section.",
            "tax-reciept-holder-phone":"Please fill phone number in tax receipt section.",
            "digitalSign":"Please upload digital signature in tax-receipt section.",
            "payuemail":"Please fill PayU email.",
            "reg-date":"Please fill registration date in tax-receipt section",
            "tax-reciept-registration-num":"Please fill registration number in tax-receipt section.",
            "expiry-date":"Please fill expiry date in tax-receipt section.",
            "tax-reciept-holder-pan-card":"Please fill pan-card number in tax-receipt section",
            "hiddencharId":"Please select organization for charitable id."
        ]
        return requiredFields
    }
    
    def requiredFieldsService(def params){
        
        def jsonData = new JsonSlurper().parseText(params.data)
        Map fieldKeyAndValue = getRequiredFields()
        Map sortedfieldMessages = [:]
        
        jsonData.each{requestKey ->
            
            fieldKeyAndValue.each{responseKey ->
                
                if(requestKey.key ==~ /.*[^0-9]/){
                    if(requestKey.key.equalsIgnoreCase(responseKey.key)){
                        sortedfieldMessages.put(responseKey.key , responseKey.value)
                    }
                }else if(requestKey.key ==~ /.*[0-9]/){
                    if(requestKey.key.contains(responseKey.key)){
                        sortedfieldMessages.put(responseKey.key , responseKey.value)
                    }
                }  
            }
        }
        
       return sortedfieldMessages
        
    }

    def getRecipientOfFunds() {
        def recipientOfFunds = [
            'PERSON':'Person',
            'NON-PROFIT':'Non-Profit',
            'NGO':'NGO',
            'OTHER':'Other'   	    
        ]
        return recipientOfFunds
    }

    def getRecipientOfFundsIndo(){
        def RecipientOfIndia = [
            'INDIVIDUAL': 'Individual',
            'NGO': 'Indian NGO',
            'OTHER': 'Other'
        ]
        return RecipientOfIndia
    }

    def getInDays() {
        def inDays = [
            30:'30',
            60:'60',
            90:'90' 
        ]
        return inDays
    }

    def getPayment(){
        def currentEnv = getCurrentEnvironment();
        def payment;
        
		payment = [
			PAY:'Paypal',
			FIR:'FirstGiving',
			WEPAY:'WePay'
		]
        return payment
    }
	
	def getIndiaPaymentGateway() {
        def currentEnv = getCurrentEnvironment();
        
        def payment = [
                PAYU  : 'PayUMoney',
                CITRUS: 'Citrus'
            ]
		
		return payment
	}
    
    def getState() {
        def state = [
            AL  :   'Alabama',
            AK  :   'Alaska',
            AZ  :   'Arizona',
            AR  :   'Arkansas',
            CA  :   'California',
            CO  :   'Colorado',
            CT  :   'Connecticut',
            DC  :   'District of Columbia',
            DE  :   'Delaware',
            FL  :   'Florida',
            GA  :   'Georgia',
            HI  :   'Hawaii',
            ID  :   'Idaho',
            IL  :   'Illinois',
            IN  :   'Indiana',
            IA  :   'Iowa',
            KS  :   'Kansas',
            KY  :   'Kentucky',
            LA  :   'Louisiana',
            ME  :   'Maine',
            MD  :   'Maryland',
            MA  :   'Massachusetts',
            MI  :   'Michigan',
            MN  :   'Minnesota',
            MS  :   'Mississippi',
            MO  :   'Missouri',
            MT  :   'Montana',
            NE  :   'Nebraska',
            NV  :   'Nevada',
            NH  :   'New Hampshire',
            NJ  :   'New Jersey',
            NM  :   'New Mexico',
            NY  :   'New York',
            NC  :   'North Carolina',
            ND  :   'North Dakota',
            OH  :   'Ohio',
            OK  :   'Oklahoma',
            OR  :   'Oregon',
            PA  :   'Pennsylvania',
            RI  :   'Rhode Island',
            SC  :   'South Carolina',
            SD  :   'South Dakota',
            TN  :   'Tennessee',
            TX  :   'Texas',
            UT  :   'Utah',
            VT  :   'Vermont',
            VA  :   'Virginia',
            WA  :   'Washington',
            WV  :   'West Virginia',
            WI  :   'Wisconsin',
            WY  :   'Wyoming',
            GU  :   'Guam',
            VI  :   'Virgin Islands',
            PR  :   'Puerto Rico',
            AS  :   'American Samoa',
            other:  'Other'
        ]
        return state
    }
	
	def getIndianState() {
		def state = [
			AP  :   'Andhra Pradesh',
			AR  :   'Arunachal Pradesh',
			AS  :   'Assam',
			BR  :   'Bihar',
			CG  :   'Chattisgarh',
			CH  :	'Chandigarh',
			DL	:	'Delhi',
			GA  :   'Goa',
			GJ  :   'Gujarat',
			HR  :   'Haryana',
			HP  :   'Himachal Pradesh',
			JK  :   'Jammu and Kashmir',
			JH  :   'Jharkhand',
			KA  :   'Karnataka',
			KL  :   'Kerala',
			MP  :   'Madhya Pradesh',
			MH  :   'Maharashtra',
			MN  :   'Manipur',
			ML  :   'Meghalaya',
			MZ  :   'Mizoram',
			NL  :   'Nagaland',
			OR  :   'Orissa',
			PB  :   'Punjab',
			RJ  :   'Rajasthan',
			SK  :   'Sikkim',
			TN  :   'Tamil Nadu',
			TL  :   'Telangana',
			TR  :   'Tripura',
			UK  :   'Uttarakhand',
			UP  :   'Uttar Pradesh',
			WB  :   'West Bengal'
		]
		return state
	}
	
	def getSorts(){
        def sortsOptions = [
            Live_Campaigns: "Live",
            Latest_Campaigns: "Latest",
            Ending_Soon: "Ending Soon",
            Successful_Campaigns:"Most Funded",
            Ended_Campaign:"Ended",
            OFFERING_PERKS:"Offering Perks"
        ]
        return sortsOptions
	}
	
    def isCampaignsorts(def sorts ,def country_code) {
        List projects = getValidatedProjects(country_code)
        List p = []
        if(sorts == 'Most-Funded') {
            projects.each {
                def percentage = contributionService.getPercentageContributionForProject(it)
                if(percentage >= 100){
                    p.add(it)
                }
            }
        }
        if(sorts == 'Latest') {
            projects.each {project ->
                def percentage = contributionService.getPercentageContributionForProject(project)
                boolean ended = isProjectDeadlineCrossed(project)
                if(percentage >= 25 && (project.validated && ended == false)){
                    p.add(project)
                }
            }
        }
        if(sorts == 'Live') {
            projects.each {project ->
                boolean ended = isProjectDeadlineCrossed(project)
                if(project.validated && ended ==false){
                    p.add(project)
                }
            }
        }
        if(sorts == 'Ending-Soon') {
            projects.each {
                def day = getRemainingDay(it)
                if(day > 0 && day <10){
                    p.add(it)
                }
            }
        }
        if(sorts=='Ended'){
            projects.each{
                boolean ended_campaigns = isProjectDeadlineCrossed(it)
                if(ended_campaigns){
                    p.add(it)
                }
            }
        }
        if(sorts=='Offering-Perks'){
            projects.each{
                def  perkSize = it.rewards.size()
                if(perkSize > 1){
                    p.add(it)
                }
            }
        }
        return p
    }
    
    def getdefaultAdmin(Project project, User user) {
        def defaultAdminEmail = "campaignadmin@crowdera.co"
        getAdminForProjects(defaultAdminEmail, project, user)
    }
    
    def getAdminForProjects(String adminEmail, Project project, User user) {
                
        def fullName = user.firstName + ' ' + user.lastName
		def country_code = project.country.countryCode
        if (adminEmail) {
            mandrillService.inviteAdmin(adminEmail, fullName, project,country_code)
            ProjectAdmin projectAdmin = new ProjectAdmin()
            projectAdmin.email = adminEmail
            project.addToProjectAdmins(projectAdmin)
        }
    }

    def updateAdminsAndSendUpdateEmail(def email1, def email2, def email3, def project, def user) {
        
        def fullName = user.firstName + ' ' + user.lastName
        def projectadmins = project.projectAdmins
        
        def campaignCoCreator = projectadmins[0]
        def firstAdmin = projectadmins[0]
        def secondAdmin = projectadmins[1]
        def thirdAdmin = projectadmins[3]
        
        isAdminCreated (email1, project, firstAdmin, user)
        isAdminCreated (email2, project, secondAdmin, user)
        isAdminCreated (email3, project, thirdAdmin, user)
		
		def country_code = project.country.countryCode
        
        def campaignCoCreatorEmail = campaignCoCreator.getEmail()
        mandrillService.sendUpdateEmailToAdmin(campaignCoCreatorEmail, fullName, project,country_code)
        
        def projectOwner = project.user
        def projectOwnerEmail = projectOwner.getEmail()
        mandrillService.sendUpdateEmailToAdmin(projectOwnerEmail, fullName, project,country_code)
    }
    
    private def isAdminCreated(def email, def project, def projectAdmin, User user ) {
        
        def fullName = user.firstName + ' ' + user.lastName
        def projectadmins = project.projectAdmins
		def country_code = project.country.countryCode
        
        def adminAlreadyCreated = false
        projectadmins.each{
            if (email == it.getEmail()) {
                adminAlreadyCreated = true
            }
        }
        if (!adminAlreadyCreated && email) {
            if (projectAdmin != null) {
                projectAdmin.email = email
                mandrillService.inviteAdmin(email, fullName, project,country_code)
            } else {
                getAdminForProjects(email, project, user)
            }
        } else {
            if(projectAdmin != null) {
                def adminEmail= projectAdmin.getEmail()
                mandrillService.sendUpdateEmailToAdmin(adminEmail, fullName, project,country_code)
            }
        }
    }

    def getNumberofDays(def endingdate, Project project) {
        def endDate = Date.parse('MM/dd/yyyy', endingdate)
        def currentDate = new Date()
        def numberOfDays = endDate - currentDate
        project.days = numberOfDays
        project.created = currentDate
    }

    def getUpdatedNumberofDays(def endingdate, Project project){
        def endDate = Date.parse('MM/dd/yyyy', endingdate)
        def createdDate = project.created
        def numberOfDays = endDate - createdDate
        project.days = numberOfDays
    }
	
	def getDaysFromStartDate(Project project) {
		def startDate = project.created
		def currentDate = new Date()
		def numberOfDays = currentDate - startDate
		return numberOfDays
	}
	
	def isTeamAdmin(Project project) {
		def user = userService.getCurrentUser()
		def result = false
		project.projectAdmins.each{
			if(it.email == user.email)
				 result = true
		}
		return result
	}
    
    /*def sendEmailToAdminForProjectUpdate(def project, def user) {
        def projectadmins = project.projectAdmins
        def fullName = user.firstName + ' ' + user.lastName
        
        projectadmins.each{
            def projectadmin = it
            if (projectadmin) {
                def email = projectadmin.getEmail()
                mandrillService.sendUpdateEmailToAdmin(email, fullName, project)
            }
        }
        def projectOwner = project.user 
        
        if (projectOwner) {
            def projectOwnerEmail = projectOwner.getEmail()
            mandrillService.sendUpdateEmailToAdmin(projectOwnerEmail, fullName, project)
        }
    }*/
    
     def getCategoryList() {
        def categoryOptions = [
            (Project.Category.Poverty_Hunger): "Poverty & Hunger",
            (Project.Category.Health_Fitness): "Health & Fitness",
            (Project.Category.Education_Schools_PTAs): "Education, Schools, PTAs",
            (Project.Category.Gender_Equality): "Gender Equality",
			(Project.Category.LGBT): "LGBT",
            (Project.Category.Clean_Water): "Clean Water",
            (Project.Category.Clean_Energy): "Clean Energy",
            (Project.Category.Social_Entrepreneurship): "Social Entrepreneurship",
			(Project.Category.Social_Innovation): "Social Innovation",
            (Project.Category.Community_CivicNeeds): "Community & Civic Needs",
			(Project.Category.Africa):"Africa",
            (Project.Category.Climate_Change): "Climate Change",
            (Project.Category.Ocean_Life): "Ocean Life",
            (Project.Category.Animal_Safety): "Animal Safety",
			(Project.Category.Environment): "Environment",
			(Project.Category.Peace_CivilRights_Justice): "Peace, Civil Rights & Justice",
			(Project.Category.Funds_Syndicates): "Funds Syndicates",
			(Project.Category.Disaster_Relief): "Disaster Relief",
			(Project.Category.Celebrations): "Celebrations",
			(Project.Category.Accidents_Medical_Emergencies): "Accidents & Medical Emergencies",
			(Project.Category.Faith_Religion_Politics): "Faith, Religion, & Politics",
			(Project.Category.Memorials): "Memorials",
			(Project.Category.Volunteering): "Volunteering",
			(Project.Category.Entrepreneurship_Startup): "Entrepreneurship & Startup",
			(Project.Category.Arts_Sports_Culture): "Arts, Sports, & Culture",
			(Project.Category.Film_Theater_Music): "Film, Theater, & Music",
			(Project.Category.Children_Women_Elders): "Children, Women & Elders",
			(Project.Category.Veterans): "Veterans",
			(Project.Category.Others): "Others"
        ]
        return categoryOptions
    }
	
	/*def getIndiaCategoryList() {
		def categoryOptions = [
			(Project.Category.ANIMALS): "Animals",
			(Project.Category.ARTS): "Arts",
			(Project.Category.CHILDREN): "Children",
			(Project.Category.COMMUNITY): "Community",
			(Project.Category.CIVIC_NEEDS): "Civic Needs",
			(Project.Category.EDUCATION): "Education",
			(Project.Category.ELDERLY): "Elderly",
			(Project.Category.ENVIRONMENT): "Environment",
			(Project.Category.FILM): "Film",
			(Project.Category.HEALTH): "Health",
			(Project.Category.SOCIAL_INNOVATION): "Social Innovation",
			(Project.Category.RELIGION): "Religion",
			(Project.Category.OTHER): "Other"
		]
		return categoryOptions
	}*/
    
   def getCategory(){
	   def categoryOptions = [
		 //  	ALL:"All Categories",
		   	Poverty_Hunger:"Poverty & Hunger",
			Health_Fitness:"Health & Fitness",
			Education_Schools_PTAs:"Education,Schools & PTAs",
			Gender_Equality:"Gender Equality",
			LGBT:"LGBT",
			Clean_Water:"Clean Water",
			Clean_Energy:"Clean Energy",
			Social_Entrepreneurship:"Social Entrepreneurship",
			Social_Innovation:"Social Innovation",
			Community_CivicNeeds:"Community & CivicNeeds",
			Africa:"Africa",
			Climate_Change:"Climate Change",
			Ocean_Life:"Ocean Life",
			Animal_Safety:"Animal Safety",
			Environment:"Environment",
			Peace_CivilRights_Justice:"Peace,CivilRights & Justice",
			Funds_Syndicates:"Funds & Syndicates",
			Disaster_Relief:"Disaster Relief",
			Celebrations:"Celebrations",
			Accidents_Medical_Emergencies:"Accidents & Medical Emergencies",
			Faith_Religion_Politics:"Faith,Religion & Politics",
			Memorials:"Memorials",
			Volunteering:"Volunteering",
			Entrepreneurship_Startup:"Entrepreneurship & Startup",
			Arts_Sports_Culture:"Arts,Sports & Culture",
			Film_Theater_Music:"Film,Theater & Music",
			Children_Women_Elders:"Children,Women & Elders",
			Veterans:"Veterans",
			Others:"Others"
	   ]
	   return categoryOptions
   }
   
  /* def getIndiaCategory(){
	   def categoryOptions = [
		   ALL: "All Categories",
		   ANIMALS: "Animals",
		   ARTS: "Arts",
		   CHILDREN: "Children",
		   COMMUNITY: "Community",
		   CIVIC_NEEDS: "Civic Needs",
		   EDUCATION: "Education",
		   ELDERLY: "Elderly",
		   ENVIRONMENT: "Environment",
		   FILM: "Film",
		   HEALTH: "Health",
		   SOCIAL_INNOVATION: "Social Innovation",
		   RELIGION: "Religion",
		   OTHER: "Other"
	   ]
	   return categoryOptions
	}*/
   
	def getDiscoverTopCategory(){
		def categoryOptions = [
			PASSION: "PASSION",
			IMPACT: "IMPACT",
			SOCIAL_GOODS: "Social_Good",
			PERSONAL_NEEDS: "Personal_Needs"
		]
		return categoryOptions
	}
    
    def getValidatedProjects() {
		def popularProjectsList = getPopularProjects()
		def finalList = popularProjectsList + (Project.findAllWhere(validated: true,inactive: false) - popularProjectsList)
		List endedProjects = []
		List openProjects = []
		List sortedProjects
		finalList.each { project ->
            boolean ended = isProjectDeadlineCrossed(project)
            if(ended) {
                endedProjects.add(project)
            }else {
                openProjects.add(project)
            }
        }
        sortedProjects = openProjects.sort {contributionService.getPercentageContributionForProject(it)}
        finalList =  sortedProjects.reverse() + endedProjects.reverse()
        return Project.findAllWhere(validated: true,inactive: false)
		//return finalList
    }
	
    def getValidatedProjects(def country_code) {
        def popularProjectsList = getPopularProjects()
        def finalList
        List endedProjects = []
        List openProjects = []
        List sortedProjects = []
		List indiaOpenCampaign = []
		List usOpenCampaign = []
		List indiaEndedCampaign = []
		List usEndedCampaign = []
		List sortIndiaCampaign = []
		List sortUsCampaign = []
      /*  if ('in'.equalsIgnoreCase(country_code)){
            finalList = popularProjectsList + (Project.findAllWhere(validated: true,inactive: false) - popularProjectsList)
            finalList.each { project ->
                boolean ended = isProjectDeadlineCrossed(project)
                if(ended) {
					(project.payuStatus) ? indiaEndedCampaign.add(project) : usEndedCampaign.add(project)
                } else {
                    (project.payuStatus) ? indiaOpenCampaign.add(project) : usOpenCampaign.add(project)
                }
            }
			sortIndiaCampaign = indiaOpenCampaign.sort {contributionService.getPercentageContributionForProject(it)}
			sortUsCampaign = usOpenCampaign.sort {contributionService.getPercentageContributionForProject(it)}
			finalList = sortIndiaCampaign.reverse() + sortUsCampaign.reverse() + indiaEndedCampaign.reverse() + usEndedCampaign.reverse()
        } else {
            finalList = popularProjectsList + (Project.findAllWhere(validated: true,inactive: false, payuStatus: false) - popularProjectsList)
            finalList.each { project ->
                boolean ended = isProjectDeadlineCrossed(project)
                if(ended) {
                    endedProjects.add(project)
                } else {
                    openProjects.add(project)
                }
            }
            sortedProjects = openProjects.sort {contributionService.getPercentageContributionForProject(it)}
            finalList =  sortedProjects.reverse() + endedProjects.reverse()
        }*/
		
		finalList = popularProjectsList + (Project.findAllWhere(validated: true,inactive: false) - popularProjectsList)
		finalList.each { project ->
			boolean ended = isProjectDeadlineCrossed(project)
			if(ended) {
				(project.payuStatus) ? indiaEndedCampaign.add(project) : usEndedCampaign.add(project)
			} else {
				(project.payuStatus) ? indiaOpenCampaign.add(project) : usOpenCampaign.add(project)
			}
		}
		sortIndiaCampaign = indiaOpenCampaign.sort {contributionService.getPercentageContributionForProject(it)}
		sortUsCampaign = usOpenCampaign.sort {contributionService.getPercentageContributionForProject(it)}
		finalList = sortIndiaCampaign.reverse() + sortUsCampaign.reverse() + indiaEndedCampaign.reverse() + usEndedCampaign.reverse()

		return finalList
    }
    
    def getValidatedProjectsByPercentage(def country_code) {
        def popularProjectsList = getPopularProjects()
        def finalList
        List endedProjects = []
        List openProjects = []
        List sortedProjects = []
        List indiaOpenCampaign = []
        List usOpenCampaign = []
        List indiaEndedCampaign = []
        List usEndedCampaign = []
        List sortIndiaCampaign = []
        List sortUsCampaign = []
        List sortedCampaignByPercentage = []
       /* if ('in'.equalsIgnoreCase(country_code)){
            finalList = popularProjectsList + (Project.findAllWhere(validated: true,inactive: false) - popularProjectsList)
            finalList.each { project ->
                boolean ended = isProjectDeadlineCrossed(project)
                if(ended) {
                    (project.payuStatus) ? indiaEndedCampaign.add(project) : usEndedCampaign.add(project)
                } else {
                    (project.payuStatus) ? indiaOpenCampaign.add(project) : usOpenCampaign.add(project)
                }
            }
            indiaEndedCampaign = indiaEndedCampaign.sort {contributionService.getPercentageContributionForProject(it)}
            usEndedCampaign = usEndedCampaign.sort {contributionService.getPercentageContributionForProject(it)}
            sortIndiaCampaign = indiaOpenCampaign.sort {contributionService.getPercentageContributionForProject(it)}
            sortUsCampaign = usOpenCampaign.sort {contributionService.getPercentageContributionForProject(it)}
            finalList = sortIndiaCampaign.reverse() + sortUsCampaign.reverse() + indiaEndedCampaign.reverse() + usEndedCampaign.reverse()
        } else {
            finalList = popularProjectsList + (Project.findAllWhere(validated: true,inactive: false, payuStatus: false) - popularProjectsList)
            finalList.each { project ->
                boolean ended = isProjectDeadlineCrossed(project)
                if(ended) {
                    endedProjects.add(project)
                } else {
                    openProjects.add(project)
                }
            }
            endedProjects = endedProjects.sort {contributionService.getPercentageContributionForProject(it)}
            sortedProjects = openProjects.sort {contributionService.getPercentageContributionForProject(it)}
            finalList =  sortedProjects.reverse() + endedProjects.reverse()
        }*/
		finalList = popularProjectsList + (Project.findAllWhere(validated: true,inactive: false) - popularProjectsList)
		finalList.each { project ->
			boolean ended = isProjectDeadlineCrossed(project)
			if(ended) {
				(project.payuStatus) ? indiaEndedCampaign.add(project) : usEndedCampaign.add(project)
			} else {
				(project.payuStatus) ? indiaOpenCampaign.add(project) : usOpenCampaign.add(project)
			}
		}
		
		/*indiaEndedCampaign = indiaEndedCampaign.sort {contributionService.getPercentageContributionForProject(it)}
		usEndedCampaign = usEndedCampaign.sort {contributionService.getPercentageContributionForProject(it)}
		sortIndiaCampaign = indiaOpenCampaign.sort {contributionService.getPercentageContributionForProject(it)}
		sortUsCampaign = usOpenCampaign.sort {contributionService.getPercentageContributionForProject(it)}*/
		
		finalList = sortIndiaCampaign.reverse() + sortUsCampaign.reverse() + indiaEndedCampaign.reverse() + usEndedCampaign.reverse()
        
        finalList.each {
            def percentage = contributionService.getPercentageContributionForProject(it)
            if(percentage >= 17) {
                sortedCampaignByPercentage.add(it)
            }
        }
        return sortedCampaignByPercentage;
        
    }

    def isPayuProject(Project project) {
		if(project.payuStatus==true) {
			return true
		} else {
		   return false
		}
	}
	
	def getPopularProjects(){
		def results = PopularProject.getAll()
		def popularProjectsList = []
		results.each {
			popularProjectsList.add(it.getProject())
		}
		return popularProjectsList
	}
	
	def showProjects(){
		/* Logic to fetch the latest comes first out of the validated projects.*/
		//TO DO
		/* Later on the criteria will be modified in order to display the admin selected projects as the popular projects*/
		def popularProjectsList = getPopularProjects()
		def finalList = popularProjectsList + (Project.findAllWhere(validated: true,inactive: false) - popularProjectsList)
		return finalList
	}
	
    def showProjects(def country_code){
        /* Logic to fetch the latest comes first out of the validated projects.*/
        //TO DO
        /* Later on the criteria will be modified in order to display the admin selected projects as the popular projects*/
        List finalList = []
        if('in'.equalsIgnoreCase(country_code)){
            def popularProjectsList = getPopularProjects()
            finalList = popularProjectsList + (Project.findAllWhere(validated: true,inactive: false) - popularProjectsList)
        } else {
            def popularProjectsList = getPopularProjects()
            finalList = popularProjectsList + (Project.findAllWhere(validated: true,inactive: false, payuStatus:false) - popularProjectsList)
        }
        List subFinalList = []
        if (finalList.size() > 3) {
            subFinalList = finalList.subList(0, 3)
        } else {
            subFinalList = finalList
        }
        return subFinalList
    }

    def projectOnHomePage(def currentEnv) {
        def projects
        def homePageCampaigns = HomePageCampaigns.findByCurrentEnv(currentEnv)

        if(homePageCampaigns == null){
           return null
        }

        if (currentEnv == 'staging' || currentEnv == 'production'){
            projects = Project.getAll(homePageCampaigns.campaignOne.id, homePageCampaigns.campaignTwo.id, homePageCampaigns.campaignThree.id)
        }else{
            projects = Project.getAll(homePageCampaigns.campaignOne.id, homePageCampaigns.campaignTwo.id, homePageCampaigns.campaignThree.id)
        }
   
        return projects
    }

    def getBeneficiaryId(Project project) {
        return( project.beneficiaryId )
    }
	
    def getCurrentTeam(Project project,User user){
	return Team.findByProjectAndUser(project, user)
    }
	
    def getCurrentTeamAmount(Project project,User user){
	def team = Team.findByProjectAndUser(project, user)
	def amount = team.amount
	return amount.round()
    }
    
    def getProjectByteam(def team){
        def project
        if(team){
            project =Project.findById(team.projectId)
        }
        return project
    }
    
    def getProjectByComment(def comment){
        def project
        if(comment){
           project= Project.findById(comment.projectId)
        }
        return project
    }
    
    def getProjects(def projects, def projectAdmins, def fundRaisers) {
        def list = []
        projects.each {
            if(it.inactive == false) {
                list.add(it)           
            }
        }
    
        projectAdmins.each {
            def project = Project.findById(it.projectId)
            if(project.inactive == false) {
                list.add(project)
            }
        }
        
        fundRaisers.each { fundRaiser ->
            def project = fundRaiser.project
            def isProjectexist = false
            list.each {
                if (project == it) {
                    isProjectexist = true
                }
            }
            if(!isProjectexist) {
                if(project.inactive == false) {
                    list.add(project)
                }
            }
        }
        return list
    }
	
    def getProjects(def projects, def projectAdmins, def fundRaisers, def country_code) {
        def list = []
        List listIndAdmins = []
        List listUsAdmins = []
        List listIndTeams = []
        List listUsTeams = []
		projects.each {
			if(it.inactive == false) {
				list.add(it)
			}
		}
		projectAdmins.each {
			def project = Project.findById(it.projectId)
			if(project.inactive == false) {
				(project.payuStatus) ? listIndAdmins.add(project) : listUsAdmins.add(project)
			}
		}
		fundRaisers.each { fundRaiser ->
			def project = fundRaiser.project
			def isProjectexist = false
			list.each {
				if (project == it) {
					isProjectexist = true
				}
			}
			if (!isProjectexist) {
				if (project.inactive == false) {
					(project.payuStatus) ? listIndTeams.add(project) : listUsTeams.add(project)
				}
			}
		}
		list = list + listIndAdmins + listUsAdmins + listIndTeams + listUsTeams
        return list
    }
    
    def getDataType(Double amount){
        if (amount) {
            return amount.round()
        } else {
            return 0
        }
    }

    def getNonValidatedProjects() {
        return Project.findAllWhere(validated: false, inactive: false, draft: false, rejected: false)
    }
	
    def getNonValidatedProjects(currentEnv) {
        if(currentEnv == 'testIndia' || currentEnv == 'stagingIndia' || currentEnv == 'prodIndia'){
            return Project.findAllWhere(validated: false, inactive: false, draft: false, rejected: false, payuStatus:true)
        } else {
            return Project.findAllWhere(validated: false, inactive: false, draft: false, rejected: false, payuStatus:false)
        }
    }
    
    def getNonValidatedProjectsForPartner(User user, Partner partner, def params) {
        List projects = []
        List totalprojects = []
        def partnerInviteCode = partner.confirmCode
        List userProjects = Project.findAllWhere(validated: false, inactive: false, draft: false, rejected: false, user: user)
        List projectsByInviteCode = Project.findAllWhere(validated: false, inactive: false, draft: false, rejected: false, partnerInviteCode: partnerInviteCode)
        totalprojects = userProjects + projectsByInviteCode
        
        def max = Math.min(params.int('max') ?: 6, 100)
        def offset = params.int('offset') ? params.int('offset') : 0
        def count = totalprojects.size()
        def maxrange

        if(offset + max <= count) {
            maxrange = offset + max
        } else {
            maxrange = offset + (count - offset)
        }
        projects = totalprojects.subList(offset, maxrange)
        return [projects: projects, totalprojects: totalprojects]
    }
    
    def getValidatedProjectsForPartner(User user, Partner partner, def params) {
        List totalprojects = []
        List projects = []
        def partnerInviteCode = partner.confirmCode
        List userProjects = Project.findAllWhere(validated: true, inactive: false, rejected: false, user: user)
        List projectsByInviteCode = Project.findAllWhere(validated: true, inactive: false, rejected: false, partnerInviteCode: partnerInviteCode)
        totalprojects = userProjects + projectsByInviteCode
        
        def max = Math.min(params.int('max') ?: 6, 100)
        def offset = params.int('offset') ? params.int('offset') : 0
        def count = totalprojects.size()
        def maxrange

        if(offset + max <= count) {
            maxrange = offset + max
        } else {
            maxrange = offset + (count - offset)
        }
        projects = totalprojects.subList(offset, maxrange)
        return [projects: projects, totalprojects: totalprojects]
    }

    def search(String query, def currentEnv) {
        List result = []
        List projects = getValidatedProjects(currentEnv)
        projects.each {project->
            if( project.title.toLowerCase().contains(query.toLowerCase()) || project.description.toLowerCase().contains(query.toLowerCase()) ){
                 result.add(project)
            } else if (project.hashtags){
                List hashtagsList = project.hashtags.split(',')
                hashtagsList = hashtagsList.collect { it.trim() }
                hashtagsList.each{hashtag->
                    if (hashtag.toLowerCase().contains(query.toLowerCase())){
                        result.add(project)
                    }
                }
            } else if (project.story){
                if (project.story.toLowerCase().contains(query.toLowerCase()))
                    result.add(project)
            }
        }
        return result
    }

    def getBeneficiaryName(Project project) {
        def name
        if (project.beneficiary.firstName && project.beneficiary.lastName) {
            name = project.beneficiary.firstName + ' ' + project.beneficiary.lastName
        } else {
            name = project.beneficiary.firstName
            if (!name) {
                name = project.beneficiary.email
            }
        }
        return name
    }

    def getProjectImageLink(Project project) {
        if (project.organizationIconUrl) {
            if (project.organizationIconUrl.startsWith('http')) {
                return project.organizationIconUrl
            } else {
                return grailsLinkGenerator.resource(file: project.organizationIconUrl)
            }
        } else if (project.image) {
            return grailsLinkGenerator.link(controller: 'project', action: 'thumbnail', id: project.id)
        } else { 
		    def category = project.category.toString()
			return getCategoryImage(category)
		}
    }
    
	def getCategoryImage(String category) {
		if(category.equalsIgnoreCase('ANIMALS')) {
			return '//s3.amazonaws.com/crowdera/assets/animals.jpg'
		} else if (category.equalsIgnoreCase('ARTS')) {
			return '//s3.amazonaws.com/crowdera/assets/arts.jpg'
		} else if (category.equalsIgnoreCase('CHILDREN')) {
		    return '//s3.amazonaws.com/crowdera/assets/children.jpg'
		} else if (category.equalsIgnoreCase('COMMUNITY')){
		    return '//s3.amazonaws.com/crowdera/assets/community.jpg'
		}else if (category.equalsIgnoreCase('CIVIC_NEEDS')){
		    return '//s3.amazonaws.com/crowdera/assets/civic-category-img.jpg'
		}  else if (category.equalsIgnoreCase('EDUCATION')) {
		    return '//s3.amazonaws.com/crowdera/assets/education.jpg'
		} else if (category.equalsIgnoreCase('ELDERLY')) {
		    return '//s3.amazonaws.com/crowdera/assets/elderly.jpg'
		} else if (category.equalsIgnoreCase('ENVIRONMENT')) {
		    return '//s3.amazonaws.com/crowdera/assets/environment.jpg'
		} else if (category.equalsIgnoreCase('FILM')) {
		    return '//s3.amazonaws.com/crowdera/assets/film-category-img.jpg'
		}else if (category.equalsIgnoreCase('HEALTH')){
		    return '//s3.amazonaws.com/crowdera/assets/health.jpg'
		} else if (category.equalsIgnoreCase('SOCIAL_INNOVATION')){
		    return '//s3.amazonaws.com/crowdera/assets/social-Innovation.jpg'
		} else if (category.equalsIgnoreCase('RELIGION')) {
		    return '//s3.amazonaws.com/crowdera/assets/religion.jpg'
		} else if (category.equalsIgnoreCase('OTHER')) {
		    return '//s3.amazonaws.com/crowdera/assets/other.jpg'
		}
	}
	
    def getProjectImageLinks(Project project) {
        def imageUrls = []
        if(project.videoUrl){
            def regex =/^.*(youtube\/|v\/|u\/\w\/|embed\/|watch\?v=|\&v=)([^#\&\?]*).*/
            def vidUrl=project.getVideoUrl()
            def match = vidUrl.matches(regex);
            def vimeo = /https?:\/\/(www\.)?vimeo.com\/(\d+)($|\/)/;
            def vimeomatch = vidUrl.matches(vimeo);
            def vurl
            if(match){
                vurl=vidUrl.replace("watch?v=", "embed/");
                imageUrls.add(vurl)     
            } else if (vimeomatch){
                vurl = vidUrl.replace("https://vimeo.com/", "https://player.vimeo.com/video/");
                imageUrls.add(vurl)     
            }
        }
        for (imgUrl in project.imageUrl) {
            if (imgUrl) {
                if (imgUrl.getUrl().startsWith('http')) {
                    imageUrls.add(imgUrl.getUrl())
                } else {
                    imageUrls.add(grailsLinkGenerator.resource(file: imgUrl.getUrl()))
                }
            } else if (project.image) {
                return grailsLinkGenerator.link(controller: 'project', action: 'thumbnail', id: project.id)
            }
        }
        // if no project image, set the default project url
		def category = project.category.toString()
        if(imageUrls == []){
            imageUrls.add(getCategoryImage(category))
        }
            return imageUrls
    }
	
	def getTeamImageLinks(Team team, Project project) {
		def imageUrls = []
        if(team?.videoUrl){
            def regex =/^.*(youtube\/|v\/|u\/\w\/|embed\/|watch\?v=|\&v=)([^#\&\?]*).*/
            def teamVideoUrl=team.getVideoUrl()
            def match = teamVideoUrl.matches(regex);
            def vimeo = /https?:\/\/(www\.)?vimeo.com\/(\d+)($|\/)/;
            def vimeomatch = teamVideoUrl.matches(vimeo);
            def vurl
            if(match){
               vurl=teamVideoUrl.replace("watch?v=", "embed/");
               imageUrls.add(vurl)     
            } else if (vimeomatch){
               vurl = teamVideoUrl.replace("https://vimeo.com/", "https://player.vimeo.com/video/");
               imageUrls.add(vurl)     
            }
		}
		for (imgUrl in team?.imageUrl) {
			if (imgUrl) {
				if (imgUrl.getUrl().startsWith('http')) {
					imageUrls.add(imgUrl.getUrl())
				} else {
					imageUrls.add(grailsLinkGenerator.resource(file: imgUrl.getUrl()))
				}
			} 
		}
		// if no project image, set the default project url
		
		if(imageUrls == []){
			def category = project.category.toString()
			imageUrls.add(getCategoryImage(category))
		}
			return imageUrls
	}

    def getProjectUpdatedImageLink(def projectUpdate) {
        def imageUrls = []
        def imagelinks = projectUpdate.imageUrls
        imagelinks.each {
            def link = it.url
            imageUrls.add(link)
        }
        return imageUrls
    }
    
    def getMultipleImageUrls(CommonsMultipartFile imageFile, Project project){
        def awsAccessKey = "AKIAIAZDDDNXF3WLSRXQ"
        def awsSecretKey = "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"

        def awsCredentials = new AWSCredentials(awsAccessKey, awsSecretKey);
        def s3Service = new RestS3Service(awsCredentials);

        def bucketName = "crowdera"
        def s3Bucket = new S3Bucket(bucketName)

        def Folder = "project-images"

        def tempImageUrl
        def imageUrl = new ImageUrl()
        def imageUrls = project.imageUrl
        def imageCount = 0;
        
        if (!imageFile?.empty && imageFile.size < 1024 * 1024 * 3) {
            try {
                int index = imageFile.getOriginalFilename().lastIndexOf(".")
                String extName = imageFile.getOriginalFilename().substring(index);
                def fileName =  UUID.randomUUID().toString() + extName
                
                def file= new File("${fileName}")
                def key = "${Folder}/${fileName}"
                key = key.toLowerCase()
                imageFile.transferTo(file)
                def object=new S3Object(file)
                object.key=key

                tempImageUrl = "//s3.amazonaws.com/crowdera/${key}"
                s3Service.putObject(s3Bucket, object)
                imageUrl.url = tempImageUrl
                
                imageUrls.each {
                    imageCount = (it.url.equalsIgnoreCase(tempImageUrl)) ? imageCount + 1 : imageCount ;
                }
                imageUrl.numberOfUrls = imageCount
                imageUrl.save()
                project.addToImageUrl(imageUrl)
                file.delete()
                
            } catch(Exception e) {
                log.error("Error: " + e);
            }
        }
        return ['filelink':tempImageUrl, 'imageId':imageUrl.id]
    }
    
    def getTaxRecieptFile(CommonsMultipartFile taxfile, TaxReciept taxReciept) {
        def awsAccessKey = "AKIAIAZDDDNXF3WLSRXQ"
        def awsSecretKey = "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"

        def awsCredentials = new AWSCredentials(awsAccessKey, awsSecretKey);
        def s3Service = new RestS3Service(awsCredentials);

        def bucketName = "crowdera"
        def s3Bucket = new S3Bucket(bucketName)

        def Folder = "tax-reciept-files"

        def tempImageUrl
        def fileUrl = new ImageUrl()
        if (!taxfile?.empty && taxfile.size < 1024 * 1024 * 3) {
            try{
                int index = taxfile.getOriginalFilename().lastIndexOf(".")
                String extName = taxfile.getOriginalFilename().substring(index);
                def fileName =  UUID.randomUUID().toString() + extName
                
                def file= new File("${fileName}")
                def key = "${Folder}/${fileName}"
                key = key.toLowerCase()
                taxfile.transferTo(file)
                def object=new S3Object(file)
                object.key=key

                tempImageUrl = "//s3.amazonaws.com/crowdera/${key}"
                s3Service.putObject(s3Bucket, object)
                fileUrl.url = tempImageUrl
                fileUrl.save()
                taxReciept.addToFiles(fileUrl)
                file.delete()
            }catch(Exception e) {
                log.error("Error: " + e);
            }
        }
        return ['filelink':tempImageUrl, 'fileId':fileUrl.id]
    }

    def getMultipleImageUrlsForTeam(CommonsMultipartFile imageFile, Team team){
        def awsAccessKey = "AKIAIAZDDDNXF3WLSRXQ"
        def awsSecretKey = "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"

        def awsCredentials = new AWSCredentials(awsAccessKey, awsSecretKey);
        def s3Service = new RestS3Service(awsCredentials);

        def bucketName = "crowdera"
        def s3Bucket = new S3Bucket(bucketName)

        def Folder = "project-images"

        def tempImageUrl
        def imageUrls = team.imageUrl
        def imageCount = 0
        
        def imageUrl = new ImageUrl()
        if (!imageFile?.empty && imageFile.size < 1024 * 1024 * 3) {
            try{
                
                int index = imageFile.getOriginalFilename().lastIndexOf(".")
                String extName = imageFile.getOriginalFilename().substring(index);
                def fileName =  UUID.randomUUID().toString() + extName
                
                def file= new File("${fileName}")
                def key = "${Folder}/${fileName}"
                key = key.toLowerCase()
                imageFile.transferTo(file)
                def object=new S3Object(file)
                object.key=key

                tempImageUrl = "//s3.amazonaws.com/crowdera/${key}"
                s3Service.putObject(s3Bucket, object)
                imageUrl.url = tempImageUrl
                
                imageUrls.each {
                    imageCount = (it.url.equalsIgnoreCase(tempImageUrl)) ? imageCount + 1 : imageCount ;
                }
                imageUrl.numberOfUrls = imageCount
                imageUrl.save()

                team.addToImageUrl(imageUrl)
                file.delete()
            } catch(IllegalStateException e){
                 log.error("Error: " + e) 
            }
        }
        return ['filelink':tempImageUrl, 'imageId':imageUrl.id]
    }
    
    def getContributedAmount (Transaction transaction){
	    def contribution = transaction.contribution
	    return contribution.amount.round()
    }
    
    def getUpdatedImageUrls(def imageUrls, ProjectUpdate projectUpdate){
        def imageUrlList = imageUrls.split(',')
        imageUrlList = imageUrlList.collect { it.trim() }
        imageUrlList.each {
            if (!it.isAllWhitespace()){
                def imageUrl = new ImageUrl()
                imageUrl.url = it
                imageUrl.save()
                projectUpdate.addToImageUrls(imageUrl)
            }
        }
    }
    
    def saveCampaignUpdate(def params, Project project, def story) {
        def projectUpdate = new ProjectUpdate()
        User user = userService.getCurrentUser()

        projectUpdate.story = story
        projectUpdate.title = params.title
        
        SimpleDateFormat timeFormat = new SimpleDateFormat("hh:mm a");
        SimpleDateFormat dateFormat = new SimpleDateFormat("MM/dd/yyyy");
        def cronExp
        def cronExpBeforeAnHour
        def isIntimationRequired = true
        
        if (params.scheduledcheckbox == 'on') {
            
            Date scheduledate = dateFormat.parse(params.scheduledDate);
            Date dscheduleTime = timeFormat.parse(params.scheduletime);
            Date today = new Date();
            
            
            def calender = scheduledate.toCalendar()
            def calender1 = dscheduleTime.toCalendar()
            def calenderInstance = today.toCalendar()
            
            def delay = scheduledate - today
            
            calender[MINUTE] = calender1[MINUTE]
            calender[HOUR_OF_DAY] = calender1[HOUR_OF_DAY]
            def month = calender[MONTH] + 1
            
            def hourDiff = calender[HOUR_OF_DAY] - calenderInstance[HOUR_OF_DAY]
            def minDiff = 0
            if (hourDiff == 0) {
                minDiff = calender[MINUTE] - calenderInstance[MINUTE]
            }
            
            projectUpdate.scheduledDate = calender.getTime()
            
            // Cron Expression to schedule an Update
            cronExp = '0 '+calender[MINUTE]+' '+ calender[HOUR_OF_DAY] +' ' +calender[DATE] + ' '+ month + ' ? '+calender[YEAR]
            
            calender.set(Calendar.HOUR_OF_DAY , (calender.get(Calendar.HOUR_OF_DAY) - 1))
            
            if (delay > 0 ) {
                // Cron Expression to schedule an Update before an Hour
                cronExpBeforeAnHour = '0 '+calender[MINUTE]+' '+ calender[HOUR_OF_DAY] +' ' +calender[DATE] + ' '+ month + ' ? '+calender[YEAR]
                
                projectUpdate.isScheduled = true
            } else {
                if ((hourDiff == 0 && minDiff > 5) || hourDiff == 1) {
                    projectUpdate.isScheduled = true
                    isIntimationRequired = false
                    
                } else if (hourDiff >= 2)  {
                    projectUpdate.isScheduled = true
                    isIntimationRequired = true
                    // Cron Expression to schedule an Update before an Hour
                    cronExpBeforeAnHour = '0 '+calender[MINUTE]+' '+ calender[HOUR_OF_DAY] +' ' +calender[DATE] + ' '+ month + ' ? '+calender[YEAR]
    
                } else {
                    isIntimationRequired = false
                }
            }
            
        } else {
            projectUpdate.scheduledDate = new Date()
            projectUpdate.islive = true
        }
        getUpdatedImageUrls(params.imageList, projectUpdate)

        project.addToProjectUpdates(projectUpdate)
        
        if (projectUpdate.save()) {
            if (projectUpdate.isScheduled) {
                if (isIntimationRequired) {
                    SendUpdateLiveJob.schedule(cronExpBeforeAnHour, [id: projectUpdate.id, isIntimationRequired: true])
                }
                SendUpdateLiveJob.schedule(cronExp, [id: projectUpdate.id, isIntimationRequired: false])
            } else {
                mandrillService.sendUpdateEmailsToContributors(project,projectUpdate,user,params.title)
            }
        }
        
    }
    
    def getSavedImageUrl(CommonsMultipartFile imageFile) {
        def awsAccessKey = "AKIAIAZDDDNXF3WLSRXQ"
        def awsSecretKey = "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"

        def awsCredentials = new AWSCredentials(awsAccessKey, awsSecretKey);
        def s3Service = new RestS3Service(awsCredentials);

        def bucketName = "crowdera"
        def s3Bucket = new S3Bucket(bucketName)
        def Folder = "project-images"

        def tempImageUrl

        if (!imageFile?.empty && imageFile.size < 1024 * 1024 * 3) {
            int index = imageFile.getOriginalFilename().lastIndexOf(".")
            String extName = imageFile.getOriginalFilename().substring(index);
            def fileName =  UUID.randomUUID().toString() + extName
            
            def file= new File("${fileName}")
            def key = "${Folder}/${fileName}"
            key = key.toLowerCase()
            imageFile.transferTo(file)
            def object=new S3Object(file)
            object.key=key

            tempImageUrl = "//s3.amazonaws.com/crowdera/${key}"
            s3Service.putObject(s3Bucket, object)
            file.delete()
        }

        return tempImageUrl
    }
    
    def setImageUrl(CommonsMultipartFile imageFile, String imgFolder) {
        def awsAccessKey = "AKIAIAZDDDNXF3WLSRXQ"
        def awsSecretKey = "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"

        def awsCredentials = new AWSCredentials(awsAccessKey, awsSecretKey);
        def s3Service = new RestS3Service(awsCredentials);

        def bucketName = "crowdera"
        def s3Bucket = new S3Bucket(bucketName)
        def Folder = imgFolder

        def tempImageUrl

        if (!imageFile?.empty && imageFile.size < 1024 * 1024 * 3) {
            int index = imageFile.getOriginalFilename().lastIndexOf(".")
            String extName = imageFile.getOriginalFilename().substring(index);
            def fileName =  UUID.randomUUID().toString() + extName
            
            def file= new File("${fileName}")
            def key = "${Folder}/${fileName}"
            key = key.toLowerCase()
            imageFile.transferTo(file)
            def object=new S3Object(file)
            object.key=key

            tempImageUrl = "//s3.amazonaws.com/crowdera/${key}"
            s3Service.putObject(s3Bucket, object)
            file.delete()
        }

        return tempImageUrl
    }
    def getUpdatEditImageUrls(CommonsMultipartFile imageFile, ProjectUpdate projectUpdate){
        def awsAccessKey = "AKIAIAZDDDNXF3WLSRXQ"
        def awsSecretKey = "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"

        def awsCredentials = new AWSCredentials(awsAccessKey, awsSecretKey);
        def s3Service = new RestS3Service(awsCredentials);

        def bucketName = "crowdera"
        def s3Bucket = new S3Bucket(bucketName)
        def Folder = "project-images"

        def tempImageUrl
        def imageUrl = new ImageUrl()

        if (!imageFile?.empty && imageFile.size < 1024 * 1024 * 3) {
            
            int index = imageFile.getOriginalFilename().lastIndexOf(".")
            String extName = imageFile.getOriginalFilename().substring(index);
            def fileName =  UUID.randomUUID().toString() + extName
            
            def file= new File("${fileName}")
            def key = "${Folder}/${fileName}"
            key = key.toLowerCase()
            imageFile.transferTo(file)
            def object=new S3Object(file)
            object.key=key

            tempImageUrl = "//s3.amazonaws.com/crowdera/${key}"
            imageUrl.url = tempImageUrl
            s3Service.putObject(s3Bucket, object)
            imageUrl.save()
            projectUpdate.addToImageUrls(imageUrl).save()
            file.delete()
        }

        return ['filelink':tempImageUrl, 'imageId':imageUrl.id]
    }
    
    def isImageFileEmpty(List<MultipartFile> files) {
        def isImageFileEmpty = true
        files.each {file ->
            if (!file?.empty && file.size < 1024 * 1024 * 3) {
                isImageFileEmpty = false
            }
        }
        return isImageFileEmpty
    }

    def isFundingOpen(Project project) {
        if (isProjectDeadlineCrossed(project) || contributionService.isFundingAchievedForProject(project)) {
            return false
        } else {
            return true
        }
    }

    /*def getImageUrl(CommonsMultipartFile imageFile) {
        this.imageFile = imageFile
        def awsAccessKey = "AKIAIAZDDDNXF3WLSRXQ"
        def awsSecretKey = "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"
        def bucketName = "crowdera"
        def folder = "project-images"

        def awsCredentials = new AWSCredentials(awsAccessKey, awsSecretKey);
        def s3Service = new RestS3Service(awsCredentials);
        def myBuckets = s3Service.listAllBuckets();
        def s3Bucket = new S3Bucket(bucketName)

        def file = new File("${imageFile.getOriginalFilename()}")
        def key = "${folder}/${imageFile.getOriginalFilename()}"

        imageFile.transferTo(file)
        def object = new S3Object(file)
        object.key = key

        s3Service.putObject(s3Bucket, object)
        file.delete()
        def imageUrl = "//s3.amazonaws.com/crowdera/${key}"

        return imageUrl
    }*/

    def getorganizationIconUrl(CommonsMultipartFile iconFile, Project project) {
        if (!iconFile?.empty && iconFile.size < 1024 * 1024 * 3) {
            def awsAccessKey = "AKIAIAZDDDNXF3WLSRXQ"
            def awsSecretKey = "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"
            def bucketName = "crowdera"
            def folder = "project-icon"

            def awsCredentials = new AWSCredentials(awsAccessKey, awsSecretKey);
            def s3Service = new RestS3Service(awsCredentials);
            def s3Bucket = new S3Bucket(bucketName)
        
            int index = iconFile.getOriginalFilename().lastIndexOf(".")
            String extName = iconFile.getOriginalFilename().substring(index);
            def fileName =  UUID.randomUUID().toString() + extName
            
            def tempFile = new File("${fileName}")
            def key = "${folder}/${fileName}"
            key = key.toLowerCase()
            iconFile.transferTo(tempFile)
            def object = new S3Object(tempFile)
            object.key = key

            s3Service.putObject(s3Bucket, object)
            tempFile.delete()
        
            def organizationIconUrl = "//s3.amazonaws.com/crowdera/${key}"
            project.organizationIconUrl = organizationIconUrl
            return organizationIconUrl
        }
    }
    
    def VALID_IMG_TYPES = ['image/png', 'image/jpeg']

    def getImageUrls(Project project){
		def awsAccessKey = "AKIAIAZDDDNXF3WLSRXQ"
		def awsSecretKey = "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"

		def awsCredentials = new AWSCredentials(awsAccessKey, awsSecretKey);
		def s3Service = new RestS3Service(awsCredentials);

		def bucketName = "crowdera"
		def s3Bucket = new S3Bucket(bucketName)
		
		def Folder = "project-images"
		
		def tempImageUrl
		files.each {
            def imageUrl = new ImageUrl()
            def imageFile= it
            
            if (!imageFile?.empty && imageFile.size < 1024 * 1024 * 3) {
                
                if (VALID_IMG_TYPES.contains(imageFile.getContentType())) {
                    try{
                        int index = imageFile.getOriginalFilename().lastIndexOf(".")
                        String extName = imageFile.getOriginalFilename().substring(index);
                        def fileName =  UUID.randomUUID().toString() + extName
                        
                        def file= new File("${fileName}")
                        def key = "${Folder}/${fileName}"
                        key = key.toLowerCase()
                        imageFile.transferTo(file)
                        def object=new S3Object(file)
                        object.key=key
                    
                        tempImageUrl = "//s3.amazonaws.com/crowdera/${key}"
                        s3Service.putObject(s3Bucket, object)
                        imageUrl.url = tempImageUrl
                        project.addToImageUrl(imageUrl)
                        file.delete()
                    }catch(IllegalStateException e){
                        log.error("Error: " + e) 
                    }
                }
                
            }
        }
    }

    def isProjectDeadlineCrossed(Project project) {
        if (!project) {
            return null
        }

        def endDate = getProjectEndDate(project)

        def today = Calendar.instance
        boolean ended = endDate.compareTo(today) < 0 ? true : false

        return ended
    }
    def getRemainingDay(Project project) {
       if (!project) {
            return null
       }
        def day
        if ((getProjectEndDate(project)) > (Calendar.instance)) {
            day =(getProjectEndDate(project) - Calendar.instance)
        }
        else {
            day = 0
        }
        return day
    }

    def getProjectStartDate(Project project) {
        if (!project) {
            return null
        }

        def startDate = Calendar.instance
        startDate.setTime(project.created)

        return startDate
    }

    def getProjectEndDate(Project project) {
        if (!project) {
            return null
        }

        def endDate = Calendar.instance
        endDate.setTime(project.created)
        endDate.add Calendar.DAY_OF_YEAR, project.days

        return endDate
    }
    
    def filterByCategory(def categories, def currentEnv){
        def projects = getValidatedProjects(currentEnv)
        List list =[]
        if (categories == "All" || categories=="Country"){
            return projects
        } else {
			projects.each{
				String str = it.category
				String strSocialCategory = it.usedFor
				String strNonProfit = "NON_PROFITS"
				String strSocialGood = "Social_Innovation"
				categories = categories.replace('-&-','_')
				categories = categories.replace(',','_')
				categories = categories.replace('-','_')
				println("categories== " + categories + " str== " + str)
				if (str.equalsIgnoreCase(categories)){
					list.add(it)
				}else if(it?.beneficiary?.country !=null && (it?.beneficiary?.country == categories.replace('-',' '))){
					list.add(it)
				}else{
					return null
				}
				/*if (str.equalsIgnoreCase(categories)){
					if(strSocialGood.equalsIgnoreCase(categories.replace("Innovation","Needs")) && strSocialCategory !=null){
						String strSocialNeeds = strSocialGood.replace("Innovation","Needs")
						if(strSocialCategory.equalsIgnoreCase(strSocialNeeds.replace('-','_'))){
							list.add(it)
						}
				 	}
					list.add(it)
				}else if(strNonProfit.equalsIgnoreCase(categories)){
					String strNonProfitCat = it.fundsRecievedBy
					if(strNonProfitCat !=null && strNonProfitCat.equalsIgnoreCase(categories.replace('_','-'))){
						list.add(it)
					}
				}else if(it?.beneficiary?.country !=null && (it?.beneficiary?.country == categories.replace('-',' '))){
					list.add(it)
				}else if(strSocialCategory !=null){
				 	if(strSocialGood.equalsIgnoreCase(categories) && strSocialCategory !=null){
						 String strSocialNeeds = strSocialGood.replace("Innovation","Needs")
						 if(strSocialCategory.equalsIgnoreCase(strSocialNeeds.replace('-','_'))){
							 list.add(it)
						 }
				 	}else if(strSocialCategory !=null && strSocialCategory.equalsIgnoreCase(categories.replace('-', '_'))){
					 	list.add(it)
				 	}
				}else{
					return null
				}*/
			}
			return list
        }
    }
    
//    def getFundraiserByFirstnameAndLastName(def username, def teams){
//        def fundraiser = null
//        
//        if(username && teams){
//            teams.each{
//                def name = it.user.firstName+" " + it.user.lastName
//                if(name.equalsIgnoreCase(username)){
//                    fundraiser = it.user.username
//                }
//            }
//        }
//        
//        return fundraiser
//    }
    
    def getFundRaisersForTeam(Project project, User user) {
        def teams = project.teams
	    def amount = project.amount
	    def description = project.description
	    def videoUrl = project.videoUrl
	    def imageUrls = project.imageUrl
        def isTeamExist = false
        def isCampaignBeneficiaryOrAdmin = userService.isCampaignBeneficiaryOrAdmin(project, user)
		def country_code = project.country.countryCode
        String message
        teams.each {
            if(user.id == it.user.id) {
                isTeamExist = true
            }
        }
        if(!isTeamExist) {
            Team team = new Team(
                amount: amount,
                user: user,
				description:description,
	            videoUrl:videoUrl,
	            joiningDate: new Date()
            )
            if (isCampaignBeneficiaryOrAdmin) {
                team.validated = true
            } else {
                imageUrls.each { imageUrl ->
                    ImageUrl imgUrl = new ImageUrl()
                    imgUrl.url = imageUrl.url
                    imgUrl.save(failOnError: true)
                    team.addToImageUrl(imgUrl)
                }
            }
            project.addToTeams(team).save(failOnError: true)
            if (isCampaignBeneficiaryOrAdmin) {
                message= "You have successfully joined the team."
            } else {
                mandrillService.sendTeamInvitation(project, user,country_code)
                message= "You're simply awesome! Now lets wait for the Campaign Owner to validate your Team Request."
            }
        } else {
            def isValidatedTeamExist = userService.isValidatedTeamExist(project, user)
            if (isValidatedTeamExist) {
                message = "You already have a team."
            } else {
                message = "Your request is yet to be validated."
            }
        }
        return message
    }
    
    def getWebUrl(def project) {
        if (project.webAddress) {
            if (project.webAddress.startsWith('http')) {
                return project.webAddress
            } else {
                return "http://"+project.webAddress
            }
        }
    }
    
    def getCustomerRequest(def params) {
        CustomerService service = new CustomerService()
        service.category = params.customerType
        service.customername = params.firstAndLastName
        service.description = params.helpDescription
        service.email = params.emailAddress
        service.subject = params.subject
        service.date = new Date()

        service.save(failOnError: true)
        mandrillService.sendEmailToCustomer(service);
        return service
    }
	
	def getCrewRequest(def params, def resumeUrl){
		CrewReg crewrequest = new CrewReg()
		crewrequest.firstName = params.firstName
		crewrequest.lastName = params.lastName
		crewrequest.email = params.email
		crewrequest.phone = params.phone
		crewrequest.letterDescription = params.letterDescriptions
		crewrequest.crewDescription = params.crewDescriptions
		crewrequest.linkedIn = params.linkedIn
		crewrequest.faceBook = params.faceBook
		crewrequest.resumeUrl = resumeUrl
		crewrequest.requestDate = new Date()
		crewrequest.adminDate = new Date()
		
		crewrequest.save(failOnError: true)
		mandrillService.sendEmailToCrew(crewrequest)
	}
	
    def setResume(CommonsMultipartFile resume, def params) {
        if (!resume?.empty && resume.size < 1024 * 1024 * 3) {
            def awsAccessKey = "AKIAIAZDDDNXF3WLSRXQ"
            def awsSecretKey = "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"
            def bucketName = "crowdera"
            def folder = "Attachments"

            def awsCredentials = new AWSCredentials(awsAccessKey, awsSecretKey);
            def s3Service = new RestS3Service(awsCredentials);
            def s3Bucket = new S3Bucket(bucketName)

            int index = resume.getOriginalFilename().lastIndexOf(".")
            String extName = resume.getOriginalFilename().substring(index);
            def fileName =  UUID.randomUUID().toString() + extName
            
            def tempFile = new File("${fileName}")
            def key = "${folder}/${fileName}"
            key = key.toLowerCase()
            resume.transferTo(tempFile)
            def object = new S3Object(tempFile)
            object.key = key

            s3Service.putObject(s3Bucket, object)
            tempFile.delete()

            def resumeUrl = "//s3.amazonaws.com/crowdera/${key}"
            getCrewRequest(params, resumeUrl)
        }
    }
    
    def setAttachments(CustomerService service, List<MultipartFile> files){
        def awsAccessKey = "AKIAIAZDDDNXF3WLSRXQ"
        def awsSecretKey = "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"

        def awsCredentials = new AWSCredentials(awsAccessKey, awsSecretKey);
        def s3Service = new RestS3Service(awsCredentials);

        def bucketName = "crowdera"
        def s3Bucket = new S3Bucket(bucketName)
        
        def Folder = "Attachments"
        
        def tempImageUrl
        files.each {
            def fileUrl = new ImageUrl()
            def attachedFile= it
            
            if (!attachedFile?.empty && attachedFile.size < 1024 * 1024 * 3) {
                try{
                    int index = attachedFile.getOriginalFilename().lastIndexOf(".")
                    String extName = attachedFile.getOriginalFilename().substring(index);
                    def fileName =  UUID.randomUUID().toString() + extName
                    
                    def file= new File("${fileName}")
                    def key = "${Folder}/${fileName}"
                    key = key.toLowerCase()
                    attachedFile.transferTo(file)
                    def object=new S3Object(file)
                    object.key=key
                
                    tempImageUrl = "//s3.amazonaws.com/crowdera/${key}"
                    s3Service.putObject(s3Bucket, object)
                    fileUrl.url = tempImageUrl
                    service.addToAttachments(fileUrl)
                    file.delete()
                } catch(IllegalStateException e){
                     log.error("Error: " + e)
                }
            }
        }
    }
    
    def setAttachedFileForProject(CommonsMultipartFile attachFile) {
        if (!attachFile?.empty && attachFile.size < 1024 * 1024 * 3) {
            def awsAccessKey = "AKIAIAZDDDNXF3WLSRXQ"
            def awsSecretKey = "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"
            def bucketName = "crowdera"
            def folder = "Attachments"

            def awsCredentials = new AWSCredentials(awsAccessKey, awsSecretKey);
            def s3Service = new RestS3Service(awsCredentials);
            def s3Bucket = new S3Bucket(bucketName)

            int index = attachFile.getOriginalFilename().lastIndexOf(".")
            String extName = attachFile.getOriginalFilename().substring(index);
            def fileName =  UUID.randomUUID().toString() + extName
            
            def tempFile = new File("${fileName}")
            def key = "${folder}/${fileName}"
            key = key.toLowerCase()
            attachFile.transferTo(tempFile)
            def object = new S3Object(tempFile)
            object.key = key

            s3Service.putObject(s3Bucket, object)
            tempFile.delete()

            return "//s3.amazonaws.com/crowdera/${key}";
        }
    }
    
    def getEnabledAndValidatedTeamsForCampaign(Project project, def params) {
        List teams = Team.findAllWhere(project : project,enable:true, validated: true);
        List teamList = []
        def max = Math.min(params.int('max') ?: 6, 100)
        def offset = params.int('teamOffset') ? params.int('teamOffset') : 0
        def count = teams.size()
        def maxrange

        if(offset + max <= count) {
            maxrange = offset + max
        } else {
            maxrange = offset + (count - offset)
        }
        teamList = teams.subList(offset, maxrange)
        return [teamList: teamList, maxrange: maxrange, teams: teams]
    }
    
    def getTeamToBeValidated(def project) {
        def teams = Team.findAllWhere(project: project,validated: false)
        return teams
    }
    
    def getValidatedTeam(def project, def params) {
        List teams = Team.findAllWhere(project: project,validated: true)
        List teamList = []
        def max = Math.min(params.int('max') ?: 8, 100)
        def offset = params.int('teamOffset') ? params.int('teamOffset') : 0
        def count = teams.size()
        def maxrange

        if(offset + max <= count) {
            maxrange = offset + max
        } else {
            maxrange = offset + (count - offset)
        }
        teamList = teams.subList(offset, maxrange)
        return [teamList: teamList, maxrange: maxrange, teams: teams]
    }
    
    def getValidatedTeamForCampaign(Project project) {
        List teams = []
        teams = Team.findAllWhere(project: project , validated: true)
        return teams
    }
    
    def getDiscardedTeams(project) {
        def teams = Team.findAllWhere(project: project,validated: true, enable: false)
        return teams
    }
    
    def getEnabledTeam(project) {
        def teams = Team.findAllWhere(project: project,validated: true, enable: true)
        return teams
    }
    
    def discardTeam(def params) {
        def project = Project.get(params.id);
        def team = Team.get(params.long('teamId'))
        List imageUrls = team.imageUrl
        def i = imageUrls.size()
        for (int j=0; j< i; j++) {
            imageUrls[j] = null;
        }
        List teams = project.teams
        teams.remove(team)
        team.delete()
        return project
    }

    def getAllProjectByUser(User user){
      def projects= Project.findAllByUser(user)
	  List activeProjects=[]
	  List draftProjects=[]
	  List pendingProjects=[]
	  List endedProjects=[]
	  List sortedProjects
	  def finalList
	  projects.each{ project->
		  boolean ended = isProjectDeadlineCrossed(project)
          if(ended) {
			  endedProjects.add(project)
		  } else if(project.draft==true){
			  draftProjects.add(project)
		  } else if(project.inactive==false && project.validated==false && project.draft==false){
			  pendingProjects.add(project)
		  } else{
		  	  if(project.validated==true && project.inactive==false){
			      activeProjects.add(project)
			  }
		  }
	  }
      sortedProjects =activeProjects.sort{contributionService.getPercentageContributionForProject(it)}
	  finalList = draftProjects.reverse()+ pendingProjects.reverse() + sortedProjects.reverse() + endedProjects.reverse()
	  
      return finalList
    }
	
    def getAllProjectByUser(User user, def country_code){
        List activeProjects=[]
        List draftProjects=[]
        List pendingProjects=[]
        List endedProjects=[]
        List sortedProjects = []
        List draftIndiaProjects = [] 
        List draftUsProjects = []
        List pendingIndiaProjects = []
        List pendingUsProjects = []
        List endedIndiaProjects = []
        List endedUsProjects = []
        List sortedIndiaProjects = []
        List sortedUsProjects = []
        List activeIndiaProjects = []
        List activeUsProjects = []
        def finalList
		def projects= Project.findAllWhere(user:user)
		projects.each { project->
			boolean ended = isProjectDeadlineCrossed(project)
			if(project.draft==true){
				(project.payuStatus) ? draftIndiaProjects.add(project) : draftUsProjects.add(project)
			} else if(project.inactive==false && project.validated==false && project.draft==false){
				(project.payuStatus) ? pendingIndiaProjects.add(project) : pendingUsProjects.add(project)
			} else if (ended) {
				(project.payuStatus) ? endedIndiaProjects.add(project) : endedUsProjects.add(project)
			} else if(project.validated==true && project.inactive==false){
				(project.payuStatus) ? activeIndiaProjects.add(project) : activeUsProjects.add(project)
			}
		}

		sortedIndiaProjects = activeIndiaProjects.sort{contributionService.getPercentageContributionForProject(it)}
		sortedUsProjects = activeUsProjects.sort{contributionService.getPercentageContributionForProject(it)}
		finalList = draftIndiaProjects.reverse() + draftUsProjects.reverse() + pendingIndiaProjects.reverse() + pendingUsProjects.reverse() + sortedIndiaProjects.reverse() + sortedUsProjects.reverse() + endedIndiaProjects.reverse() + endedUsProjects.reverse()

        return finalList
    }

    def getProjectAdminEmail(User user){
      def projectAdminEmail= ProjectAdmin.findAllByEmail(user.email)
      return projectAdminEmail
    }

    def getTeamByUserAndEnable(User user, def enable){
      def teams=Team.findAllWhere(user:user, enable: enable)
      return teams
    }
    
    def getEnabledAndValidatedTeam(User user) {
        def teams=Team.findAllWhere(user:user, enable: true, validated: true)
        return teams
    }
    
    def getAddress(def params){
        def address 
        def state
        def country
        if (params.addressLine1 !=null){
            if (params.state == "other") {
                state = params.otherstate
            } else {
                Map states = getState()
                state = states.getAt(params.state)
            }
            Map countries = getCountry()
            country = countries.getAt(params.country)
            if (params.addressLine2 == null || params.addressLine2.isAllWhitespace()){
                address = params.addressLine1 +" "+ params.city +"-"+ params.zip +" "+ state +" "+ country
            } else {
                address = params.addressLine1 +" "+params.addressLine2 +" "+ params.city +"-"+ params.zip +" "+ state +" "+ country
            }
        } else {
            address = null
        }
        
        return address
    }
	
	def getAddress(def params, def country_code ){
		def address
		def state
		def country
		if('in'.equalsIgnoreCase(country_code)){
			if (params.addressLine1 !=null){
				if (params.state == "other") {
					state = params.otherstate
				} else {
					Map states = getIndianState()
					state = states.getAt(params.state)
				}
				Map countries = getCountry()
				country = countries.getAt(params.country)
				
				if (params.addressLine2 == null || params.addressLine2.isAllWhitespace()){
					address = params.addressLine1 +" "+ params.city +"-"+ params.zip +" "+ state +" "+ country
				} else {
					address = params.addressLine1 +" "+params.addressLine2 +" "+ params.city +"-"+ params.zip +" "+ state +" "+ country
				}
			} else {
				address = null
			}
		} else{
			if (params.addressLine1 !=null){
				if (params.state == "other") {
					state = params.otherstate
				} else {
					Map states = getState()
					state = states.getAt(params.state)
				}
				Map countries = getCountry()
				country = countries.getAt(params.country)
				if (params.addressLine2 == null || params.addressLine2.isAllWhitespace()){
					address = params.addressLine1 +" "+ params.city +"-"+ params.zip +" "+ state +" "+ country
				} else {
					address = params.addressLine1 +" "+params.addressLine2 +" "+ params.city +"-"+ params.zip +" "+ state +" "+ country
				}
			}
		}
		
		return address
	}

    def getContibutionByUser(User user){
        def contributions = Contribution.findAllByUser(user)
        return contributions
    }
	
    def getContibutionByUser(User user,def country_code){
        def contributions = Contribution.findAllByUser(user)
        /*List payuContributions=[]
        List otherContributions=[]
		
        contributions.each{
            if(it.project?.payuStatus){
                payuContributions.add(it)
            } else {
                otherContributions.add(it)
            }
        }
		
        if('in'.equalsIgnoreCase(country_code)){
            return payuContributions
        } else {
            return otherContributions
        }*/
		
		return contributions;
    }

    def shareCampaignOrTeamByEmail(def params, def fundRaiser) {
        def project = Project.get(params.id)
        String emails = params.emails
        String name = params.name
        String message = params.message
		String country_code = project.country.countryCode;
        if(emails) {
            def emailList = emails.split(',')
            emailList = emailList.collect { it.trim() }
            mandrillService.shareProject(emailList, name, message, project, fundRaiser,country_code)
        }
        project.gmailShareCount = project.gmailShareCount + 1
    }
    
    def shareupdateemail(def params, def fundRaiser, def projectUpdate) {
        def project = Project.get(params.id)
        String emails = params.emails
        String name = params.name
        String message = params.message
		String country_code = project.country.countryCode;
        if(emails) {
            def emaillist = emails.split(',')
            emaillist = emaillist.collect {it.trim()}
            mandrillService.shareProjectupdate(emaillist, name, message, project, fundRaiser, projectUpdate,country_code)
        }
        project.gmailShareCount = project.gmailShareCount + 1
    }

    def getShippingDetails(def contibutions){
      def shippingDetails=" "
      if(contibutions.email==null && contibutions.physicalAddress==null && contibutions.twitterHandle==null && contibutions.custom==null){         
          shippingDetails="No Perk Selected"
      }else{
        if(contibutions.email!=null){
          shippingDetails="Email: " +contibutions.email
          if(contibutions.physicalAddress!=null){
            shippingDetails+=" - Physical Address: " + contibutions.physicalAddress
          }
          if(contibutions.twitterHandle!=null){
            shippingDetails+=" - Twitter Handle: " + contibutions.twitterHandle
          }
          if(contibutions.custom!=null) {
            shippingDetails+=" - Custom: " + contibutions.custom
          }
        }
        if(contibutions.physicalAddress!=null){
          shippingDetails="Physical Address: " + contibutions.physicalAddress
          if(contibutions.twitterHandle!=null){
            shippingDetails+=" - Twitter Handle: " + contibutions.twitterHandle
          }
          if(contibutions.custom!=null) {
            shippingDetails+=" - Custom: " + contibutions.custom
          }
          if(contibutions.email!=null){
            shippingDetails+=" - Email: " +contibutions.email
          }
        }
        if(contibutions.twitterHandle!=null){
          shippingDetails ="Twitter Handle: " + contibutions.twitterHandle
          if(contibutions.physicalAddress!=null){
            shippingDetails+=" - Physical Address: " + contibutions.physicalAddress
          }
          if(contibutions.custom!=null) {
            shippingDetails+=" - Custom: " + contibutions.custom
          }
          if(contibutions.email!=null){
            shippingDetails+=" - Email: " +contibutions.email
          }
        }
        if(contibutions.custom!=null) {
          shippingDetails="Custom: " + contibutions.custom
          if(contibutions.physicalAddress!=null){
            shippingDetails+=" - Physical Address: " + contibutions.physicalAddress
          }
          if(contibutions.twitterHandle!=null) {
            shippingDetails+=" - Twitter Handle: " + contibutions.twitterHandle
          }
          if(contibutions.email!=null){
            shippingDetails+=" - Email: " +contibutions.email
          }     
        }
      }
      return shippingDetails      
    }
	
	def checkShippingDetail(def emailId, def twitter, def address, def custom){
		def emailid
		def tweet
		def add
		def cstm
		if(emailId=='null'){
			emailid=null
		}else{
		 	emailid=emailId
		}
		if(twitter =='null'){
			tweet=null
		}else{
			tweet=twitter
		}
		if(address=='null'){
			add=null
		}else{
			add=address
		}
		if(custom=='null'){
			cstm=null
		}else{
			cstm=custom
		}
		
		return ['emailid':emailid, 'twitter':tweet,'address':add,'custom':cstm]
		
	}
    
    def editCampaignUpdates(def params, def project) {
        ProjectUpdate projectUpdate = getProjectUpdateById(params.long('id'))
        def story = params.story
        
        boolean isCampaignUpdated = false
        if(projectUpdate) {
            
            if (!story.isAllWhitespace()) {
                if (projectUpdate.story != story) {
                    projectUpdate.story = story
                    isCampaignUpdated = true
                }
            } else {
                if (!projectUpdate.imageUrls.isEmpty()) {
                    projectUpdate.story = params.story
                    isCampaignUpdated = true
                }
            }
            
            if (projectUpdate.title != params.title) {
                projectUpdate.title = params.title
                isCampaignUpdated = true
            }
            
            if (isCampaignUpdated) {
                projectUpdate.save();
                
            } else if (projectUpdate.imageUrls.isEmpty() && story.isAllWhitespace()) {
                if (projectUpdate.story == null || projectUpdate.story.isAllWhitespace()) {
                    List projectUpdates = project.projectUpdates
                    projectUpdates.remove(projectUpdate)
                    projectUpdate.delete()
                }
            }
        }
    }
	
	
	def deleteCampaignUpdates(def params, def project) {
		boolean deleteStatus = true
		try{
		ProjectUpdate selectedprojectUpdate = getProjectUpdateById(params.long('id'))
		System.out.println("selectprojectUpdate = "+ selectedprojectUpdate.toString())
		List projectUpdates = project.projectUpdates
		 projectUpdates.remove( selectedprojectUpdate )
	   selectedprojectUpdate.delete()
	   
		}catch(Exception e){
		deleteStatus=false
		}
	   return deleteStatus
    }
		
    def getProjectVanityTitle(Project project) {
        def projectTitle = project?.title.trim()
        def title = projectTitle.replaceAll("[^a-zA-Z0-9]", "-")
		
		Long rowCount = (Long) VanityTitle.createCriteria().add(Restrictions.eq("title", title)).setProjection(Projections.rowCount()).uniqueResult();

		def vanitytitle
        if (rowCount.intValue() == 0) {
			vanitytitle = title
        } else {
            vanitytitle = title+"-"+rowCount.intValue()
        }

        new VanityTitle(
            project:project,
            projectTitle:title,
            vanityTitle:vanitytitle,
            title:title
        ).save(failOnError: true)

        return vanitytitle
    }
	
    def getCustomVanityUrl(Project project){
        def title = project.customVanityUrl.trim()
        def result = VanityTitle.findByVanityTitle(title)

        if (!result) {
            new VanityTitle(
               project:project,
               projectTitle:title,
               vanityTitle:title,
               title:title
            ).save(failOnError: true)
        }

        return title
    }

    def getVanityTitleFromId(def projectId) {
        def vanity_title
        def project = Project.get(projectId)
		VanityTitle vanitytitle;
		
        if(project) {
            
			if (project?.customVanityUrl) {
                vanitytitle = VanityTitle.findByVanityTitle(project?.customVanityUrl.trim())
            } 
			
			if (vanitytitle) {
				vanity_title = vanitytitle?.vanityTitle
			} else {
				List<VanityTitle> vanityTitles = VanityTitle.findAllWhere(project:project)
				vanitytitle = vanityTitles?.last();
				vanity_title = vanitytitle?.vanityTitle;
			}
        }
        return vanity_title
    }

    def getProjectIdFromVanityTitle(def title){
        def projectId
        def vanitytitle = VanityTitle.findByVanityTitle(title)
        if (vanitytitle)
            projectId = vanitytitle?.project?.id

        return projectId
    }

    def getProjectFromTitle(def title){
        def projectId
        def projectTitle = Project.findByTitle(title)
        
        if(projectTitle){
            projectId= projectTitle
        }
        
        return projectId
    }
    
    HomePageCampaigns getHomePageCampaignByEnv(def currentEnv){
        return HomePageCampaigns.findByCurrentEnv(currentEnv)
    }
    
    List<Project> getHomePageCampaignListByEnv(def currentEnv){
        def homePageCampaign = HomePageCampaigns.findByCurrentEnv(currentEnv)
        List<Project> projects = new ArrayList<Project>();
        
        if(homePageCampaign != null) {
            (homePageCampaign.campaignOne != null) ? projects.add(homePageCampaign.campaignOne) : "";
            (homePageCampaign.campaignTwo != null) ? projects.add(homePageCampaign.campaignTwo) : "";
            (homePageCampaign.campaignThree != null) ? projects.add(homePageCampaign.campaignThree) : "";
        }
        return projects;
    }

	def getLiveProjects(def projects){
        List liveProjects = []
		projects.each{project ->
			if(!isProjectDeadlineCrossed(project) && project.validated){
				liveProjects.add(project);
			}
		}
		return liveProjects
	}
	
	def getEndedCampaigns(def projects){
		List endedCampaigns = []
		projects.each{project ->
			if(isProjectDeadlineCrossed(project)){
				endedCampaigns.add(project);
			}
		}
		return endedCampaigns
	}

    def setHomePageCampaignByEnv(def campaignOne, def campaingTwo, def campaingThree, def currentEnv){
        def homePageCampaigns = getHomePageCampaignByEnv(currentEnv)
        
        if(homePageCampaigns){
            
            homePageCampaigns.campaignOne = campaignOne
            homePageCampaigns.campaignTwo = campaingTwo
            homePageCampaigns.campaignThree = campaingThree
            homePageCampaigns.currentEnv = currentEnv
        }
    }
    
    def setCampaignDeadline(Project project, int days, int daysLeft) {
        
        if(project) {
            def created = project.created.toCalendar();
            def remainingDays = getRemainingDay(project);
            
            if (remainingDays > 0) {
                if (daysLeft > remainingDays) {
                    project.days = (Calendar.instance - created) + daysLeft
                } else {
                    project.days = days - (remainingDays - daysLeft)
                }
            } else {
                def difference = (Calendar.instance - created)
                project.days = difference + daysLeft
            }
            project.save();
        }
    }
    
    def getProjectFromVanityTitle(def title){
        def projectId
        def vanitytitle = VanityTitle.findByVanityTitle(title)
        if (vanitytitle)
            projectId = vanitytitle?.project?.id

        def project = Project.get(projectId)
        return project
    }
    
    def getCampaignShareUrl(Project project) {
        def base_url = grailsApplication.config.crowdera.BASE_URL
        List vanityTitles = VanityTitle.findAllWhere(project:project)
        def url
        def vanityTitle
        if (vanityTitles.isEmpty()) {
            vanityTitle = getVanityTitleFromId(project.id)
        } else {
            def vanity = vanityTitles.last() 
            vanityTitle = vanity.vanityTitle
        }
        def vanityUserName
        List vanityUserNames = VanityUsername.findAllWhere(user : project.user)
        if (vanityUserNames.isEmpty()) {
            vanityUserName = userService.getProjectVanityUsername(project.user)
        } else {
            def vanity = vanityUserNames.last()
            vanityUserName = vanity.vanityUsername
        }
        url = base_url+'/campaigns/'+ vanityTitle +'/'+ vanityUserName
        return url
    }
	
    def getYoutubeUrlChanged(String video, Project project){
       def youtube = /^.*(youtube\/|v\/|u\/\w\/|embed\/|watch\?v=|\&v=)([^#\&\?]*).*/;
       def vimeo = /https?:\/\/(www\.)?vimeo.com\/(\d+)($|\/)/;
       def match = video.matches(youtube);
       def vimeomatch = video.matches(vimeo)
        if (match && !video.contains('embed')) {
            String videoUrl = video.replace("watch?v=","embed/")
            videoUrl = videoUrl + "?rel=0"
			project.videoUrl = videoUrl
        } else if (vimeomatch){
		    project.videoUrl = video
		}
    }
    
    def setContributorsComment(Project project,def comment,User fundRaiser,Contribution contribution) {
        User user = contribution.user
        def contributorName = contribution.contributorName
        TeamComment teamComment
        ProjectComment projectComment
        if (project.user == fundRaiser) {
            projectComment = new ProjectComment(
                comment: comment,
                userName: contributorName,
                user: user,
                project: project,
                date: new Date()).save(failOnError: true)
        } else {
            Team team = Team.findByUserAndProject(fundRaiser,project)
            if (team) {
                teamComment = new TeamComment(
                    comment: comment,
                    userName: contributorName,
                    user: user,
                    team: team,
                    date: new Date()).save(failOnError: true)
            }
        }
        return [projectComment: projectComment, teamComment:teamComment]
    }
	
    def getRedactorImageUrl(CommonsMultipartFile imageFile) {
        if (!imageFile?.empty && imageFile.size < 1024 * 1024 * 3) {
            def awsAccessKey = "AKIAIAZDDDNXF3WLSRXQ"
            def awsSecretKey = "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"
            def bucketName = "crowdera"
            def folder = "textEditor-Image"

            def awsCredentials = new AWSCredentials(awsAccessKey, awsSecretKey);
            def s3Service = new RestS3Service(awsCredentials);
            def s3Bucket = new S3Bucket(bucketName)
            
            int index = imageFile.getOriginalFilename().lastIndexOf(".")
            String extName = imageFile.getOriginalFilename().substring(index);
            def fileName =  UUID.randomUUID().toString() + extName
            
            def tempFile = new File("{fileName}")
            def key = "${folder}/${fileName}"
            key = key.toLowerCase()
            imageFile.transferTo(tempFile)
            def object = new S3Object(tempFile)
            object.key = key

            s3Service.putObject(s3Bucket, object)
            tempFile.delete()

            def redactorImageUrl = "//s3.amazonaws.com/crowdera/${key}"
            return redactorImageUrl
        }
    }

    def deleteContributorsComment(def projectComment,def teamComment,def project, def team) {
        if (project && projectComment) {
            List projectComments = project.comments
            projectComments.remove(projectComment)
            projectComment.delete()
        }
        if (team && teamComment) {
            List teamComments = team.comments
            teamComments.remove(teamComment)
            teamComment.delete()
        }
    }
    
    def getProjectComments(Project project) {
        List comments = ProjectComment.findAllWhere(project: project, status: false)
        return comments.reverse()
    }
    
    def getTeamComments(Team team) {
        List comments = TeamComment.findAllWhere(team: team)
        return comments.reverse()
    }
	def getProjectAdminEmailList(Project project) {
		List emailList = []
		project.projectAdmins.each { projectAdmin ->
			emailList.add(projectAdmin?.email)
		}
		emailList.add(project?.user?.email)
		return emailList
	}

	
	/*******************Generate HASH for payu*********************/
	String generateHash(String type, String hashstring){
		byte[] hashseq=hashstring.getBytes();
		StringBuffer hexString = new StringBuffer();
		try{
			MessageDigest algorithm = MessageDigest.getInstance(type);
			algorithm.reset();
			algorithm.update(hashseq);
			byte[] messageDigest = algorithm.digest();
			for (int i=0;i<messageDigest.length;i++) {
				String hex=Integer.toHexString(0xFF & messageDigest[i]);
				if(hex.length()==1) hexString.append("0");
				hexString.append(hex);
			}
		}catch(Exception nsae){
		    log.errorEnabled = "Unable to generate Hash String : "+nsae
		}
		return hexString.toString();
	}
	
	/****************Generate unique transaction Id for payu*********************/
	def generateTransId(){
		Random rand = new Random();
		String rndm = Integer.toString(rand.nextInt())+(System.currentTimeMillis() / 1000L);
		def txnid=generateHash("SHA-256",rndm).substring(0,20);
		return txnid
	}
	
	def getProjectContributions(def params, Project project) {
		List totalContributions = []
		List contributions = []
		def max = Math.min(params.int('max') ?: 12, 100)
		def offset = params.int('offset') ?: 0
		totalContributions = project.contributions.reverse();
		def count = totalContributions.size()
		def maxrange
		
		if(offset+max <= count) {
			maxrange = offset+max
		} else {
			maxrange = offset + (count - offset)
		}
		
		contributions = totalContributions.subList(offset, maxrange)
		return [totalContributions: totalContributions,contributions: contributions]
	}
	
	def getTeamContributions(def params, Team currentTeam) {
		List totalContributions = []
		List contributions = []
		if (currentTeam) {
		    def max = Math.min(params.int('max') ?: 12, 100)
		    def offset = params.int('offset') ?: 0
		    totalContributions = currentTeam.contributions.reverse();
		    def count = totalContributions.size()
		    def maxrange
		
		    if(offset+max <= count) {
			    maxrange = offset+max
		    } else {
			    maxrange = offset + (count - offset)
		    }
		
	     	contributions = totalContributions.subList(offset, maxrange)
		}
        
        return [totalContributions: totalContributions,contributions: contributions]
	}
	
    def autoSaveProjectDetails(def variable, def varValue, def projectId){
        Project project = Project.get(projectId);
        User user = userService.getCurrentUser()
        Beneficiary beneficiary = project.beneficiary;
        def isValueChanged = false; 
        switch (variable) {
            case 'category':
                project.category = varValue;
                isValueChanged = true;
                break;

            case 'country':
                beneficiary.country = varValue;
                isValueChanged = true;
                break;

            case 'videoUrl':
                project.videoUrl = (varValue.isAllWhitespace()) ? null : varValue;
                if (project.videoUrl){
                    if (project.videoUrl.contains('embed')) {
                        isValueChanged = true;
                        break;
                    } else {
                        getYoutubeUrlChanged(project.videoUrl, project)
                        isValueChanged = true;
                        break;
                    }
                }

            case 'email1':
                getFirstAdminForProjects(varValue, project, user)
                isValueChanged = true;
                break;
	
            case 'email2':
                getSecondAdminForProjects(varValue, project, user)
                isValueChanged = true;
                break;
	
            case 'email3':
                getThirdAdminForProjects(varValue, project, user)
                isValueChanged = true;
                break;

            case 'days':
                project.days = Integer.parseInt(varValue);
                isValueChanged = true;
                break;
				
            case 'organizationname':
                project.organizationName = varValue;
                isValueChanged = true;
                break;
	
            case 'webAddress':
                project.webAddress = varValue;
                isValueChanged = true;
                break;
	
            case 'telephone':
                beneficiary.telephone = varValue;
                isValueChanged = true;
                break;
	
            case 'paypalEmailId':
				if (!project.validated) {
	                project.paypalEmail = varValue;
	                project.charitableId = null;
					project.wepayEmail = null;
					project.wepayFirstName = null;
					project.wepayLastName = null;
					
	                isValueChanged = true;
				}
                break;
			
            case 'payuEmail':
				if (!project.validated) {
					project.payuEmail = varValue;
					project.citrusEmail = null;
					project.sellerId = null;
					
					BankInfo bankInfo = getBankInfoByProject(project);
					if (bankInfo) {
						bankInfo.delete();
					}
					isValueChanged = true;
				}
                break;
				
			case 'wepayEmail':
				if (!project.validated) {
					project.wepayEmail = varValue;
					project.paypalEmail = null;
					project.charitableId = null;
					isValueChanged = true;
				}
				break;
				
			case 'wepayFirstName':
				if (!project.validated) {
					project.wepayFirstName = varValue;
					isValueChanged = true;
				}
				break;
				
			case 'wepayLastName':
				if (!project.validated) {
					project.wepayLastName = varValue;
					isValueChanged = true;
				}
				break;

            case 'story':
                if (project.story != varValue) {
                    project.story = varValue;
                    isValueChanged = true;
                }
                break;
				
            case 'usedFor':
                project.usedFor = varValue;
                isValueChanged = true;
                break;
	
            case 'fundsRecievedBy':
                project.fundsRecievedBy = varValue;
                isValueChanged = true;
                break;

            case 'secretKey':
                project.secretKey = varValue;
                isValueChanged = true;
                break;
               
            case 'facebookUrl':
                beneficiary.facebookUrl = varValue;
                isValueChanged = true;
                break;
               
            case 'twitterUrl':
                beneficiary.twitterUrl = varValue;
                isValueChanged = true;
                break;
               
            case 'linkedinUrl':
                beneficiary.linkedinUrl = varValue;
                isValueChanged = true;
                break;
				
			case 'name':
				beneficiary.firstName = varValue;
				isValueChanged = true;
				break;
				
			case 'amount':
				project.amount = Double.parseDouble(varValue); 
				
				Team team = Team.findByProjectAndUser(project, project?.user);
				if (team) {
					team.amount = Double.parseDouble(varValue);
					team.save();
				}
				isValueChanged = true;
				break;
	
			case 'campaignTitle':
				project.title = varValue;
				isValueChanged = true;
				break;

			case 'descarea':
				project.description = varValue;
				isValueChanged = true;
				break;

			case 'customVanityUrl':
			    project.customVanityUrl = (varValue == '') ? null : varValue;
				isValueChanged = true;
				break;

            case 'city':
                if (varValue.isAllWhitespace()){
                    beneficiary.city = null;
                } else {
                    beneficiary.city = varValue;
                }
                isValueChanged = true;
                break;

            case 'ans1':
                QA qA = QA.findByProject(project)
                if (varValue.isAllWhitespace()){
                    if(qA){
                        qA.ans1 = null;
                        qA.save(failOnError:true);
                    }
                } else {
                    if(qA){
                        qA.ans1 = varValue;
                        qA.save(failOnError:true);
                    } else {
                        new QA(
                           ans1 : varValue,
                           project:project
                        ).save(failOnError:true)
                    }
                    isValueChanged = true;
                }
                break;

           case 'ans2':
               QA qA = QA.findByProject(project)
               if (varValue.isAllWhitespace()){
                   if(qA){
                       qA.ans2 = null;
                       qA.save(failOnError:true);
                   }
               } else {
                   if(qA){
                       qA.ans2 = varValue;
                       qA.save(failOnError:true);
                   } else {
                       new QA(
                           ans2 : varValue,
                           project:project
                       ).save(failOnError:true)
                   }
                   isValueChanged = true;
               }
               break;

            case 'ans3':
                QA qA = QA.findByProject(project)
                if (varValue.isAllWhitespace()){
                    if(qA){
                        qA.ans3 = null;
                        qA.save(failOnError:true);
                    }
                } else {
                    if(qA){
                        qA.ans3 = varValue;
                        qA.save(failOnError:true);
                    } else {
                       new QA(
                           ans3 : varValue,
                           project:project
                       ).save(failOnError:true)
                    }
                    isValueChanged = true;
                }
                break;

            case 'ans4':
                QA qA = QA.findByProject(project)
                if (varValue.isAllWhitespace()){
                    if(qA){
                        qA.ans4 = null;
                        qA.save(failOnError:true);
                    }
                } else {
                    if(qA){
                        qA.ans4 = varValue;
                        qA.save(failOnError:true);
                    } else {
                        new QA(
                            ans4 : varValue,
                            project:project
                        ).save(failOnError:true)
                    }
                    isValueChanged = true;
                }
               break;
               
           case 'ans5':
               QA qA = QA.findByProject(project)
               if (varValue.isAllWhitespace()){
                   if(qA){
                       qA.ans5 = null;
                       qA.save(failOnError:true);
                   }
               } else {
                   if(qA){
                       qA.ans5 = varValue;
                       qA.save(failOnError:true);
                   } else {
                       new QA(
                          ans5 : varValue,
                          project:project
                       ).save(failOnError:true)
                   }
                   isValueChanged = true;
               }
               break;

           case 'ans6':
              QA qA = QA.findByProject(project)
              if (varValue.isAllWhitespace()){
                  if(qA){
                      qA.ans6 = null;
                      qA.save(failOnError:true);
                  }
              } else {
                  if(qA){
                      qA.ans6 = varValue;
                      qA.save(failOnError:true);
                  } else {
                      new QA(
                          ans6 : varValue,
                          project:project
                      ).save(failOnError:true)
                  }
                  isValueChanged = true;
              }
              break;

           case 'ans7':
               QA qA = QA.findByProject(project)
               if (varValue.isAllWhitespace()){
                   if(qA){
                       qA.ans7 = null;
                       qA.save(failOnError:true);
                   }
               } else {
                   if(qA){
                       qA.ans7 = varValue;
                       qA.save(failOnError:true);
                   } else {
                      new QA(
                          ans7 : varValue,
                          project:project
                      ).save(failOnError:true)
                   }
                   isValueChanged = true;
               }
               break;

           case 'ans8':
               QA qA = QA.findByProject(project)
               if (varValue.isAllWhitespace()){
                   if(qA){
                       qA.ans8 = null;
                       qA.save(failOnError:true);
                   }
               } else {
                   if(qA){
                       qA.ans8 = varValue;
                       qA.save(failOnError:true);
                   } else {
                       new QA(
                           ans8 : varValue,
                           project:project
                       ).save(failOnError:true)
                   }
                   isValueChanged = true;
               }
               break;
 
            case 'reason1':
                ReasonsToFund reasonToFund = ReasonsToFund.findByProject(project)
                if (varValue.isAllWhitespace()){
                    if (reasonToFund){
                        reasonToFund.reason1 = null;
                        reasonToFund.save(failOnError:true)
                    }
                } else {
                    if (reasonToFund) {
                        reasonToFund.reason1 = varValue;
                        reasonToFund.save(failOnError:true)
                    } else {
                        new ReasonsToFund(
                           reason1 : varValue,
                           project : project
                        ).save(failOnError:true)
                    }
                    isValueChanged = true;
                }
                break;

            case 'reason2':
                ReasonsToFund reasonToFund = ReasonsToFund.findByProject(project)
                if (varValue.isAllWhitespace()){
                    if (reasonToFund){
                        reasonToFund.reason2 = null;
                        reasonToFund.save(failOnError:true)
                    }
                } else {
                    if (reasonToFund){
                        reasonToFund.reason2 = varValue;
                        reasonToFund.save(failOnError:true)
                    } else {
                        new ReasonsToFund(
                            reason2 : varValue,
                            project : project
                        ).save(failOnError:true)
                    }
                    isValueChanged = true;
                }
                break;

            case 'reason3':
                ReasonsToFund reasonToFund = ReasonsToFund.findByProject(project)
                if (varValue.isAllWhitespace()){
                    if (reasonToFund){
                       reasonToFund.reason3 = null;
                       reasonToFund.save(failOnError:true)
                    }
                } else {
                    if (reasonToFund){
                        reasonToFund.reason3 = varValue;
                        reasonToFund.save(failOnError:true)
                    } else {
                        new ReasonsToFund(
                            reason3 : varValue,
                            project : project
                        ).save(failOnError:true)
                    }
                    isValueChanged = true;
                }
                break;
				
            case 'hashtags':
                if (varValue.isAllWhitespace()){
                    project.hashtags = null;
                } else {
                    project.hashtags = varValue;
                }
                isValueChanged = true;
                break;

            case 'ein':
                TaxReciept taxReciept = TaxReciept.findByProject(project)
                if (varValue.isAllWhitespace()){
                    if (taxReciept){
                        taxReciept.ein = null
                        taxReciept.save(failOnError:true);
                    }
                } else {
                    if (taxReciept){
                        taxReciept.ein = varValue
                        taxReciept.save(failOnError:true);
                    } else {
                        TaxReciept taxreciept = new TaxReciept()
                        taxreciept.ein = varValue
                        taxreciept.project = project
                        taxreciept.save(failOnError:true);
                    }
                }
                break;

            case 'taxRecieptHolderCity':
                TaxReciept taxReciept = TaxReciept.findByProject(project)
                if (varValue.isAllWhitespace()){
                    if (taxReciept){
                        taxReciept.city = null
                        taxReciept.save(failOnError:true);
                    }
                } else {
                    if (taxReciept){
                        taxReciept.city = varValue
                        taxReciept.save(failOnError:true);
                    } else {
                        TaxReciept taxreciept = new TaxReciept()
                        taxreciept.city = varValue
                        taxreciept.project = project
                        taxreciept.save(failOnError:true);
                    }
                }
                break;

            case 'taxRecieptHolderName':
                TaxReciept taxReciept = TaxReciept.findByProject(project)
                if (varValue.isAllWhitespace()){
                    if (taxReciept){
                        taxReciept.name = null
                        taxReciept.save(failOnError:true);
                    }
                } else {
                    if (taxReciept){
                        taxReciept.name = varValue
                        taxReciept.save(failOnError:true);
                    } else {
                        TaxReciept taxreciept = new TaxReciept()
                        taxreciept.name = varValue
                        taxreciept.project = project
                        taxreciept.save(failOnError:true);
                    }
                }
                break;

            case 'taxRecieptHolderState':
                TaxReciept taxReciept = TaxReciept.findByProject(project)
                if (varValue.isAllWhitespace()){
                    if (taxReciept){
                        taxReciept.taxRecieptHolderState = null
                        taxReciept.save(failOnError:true);
                    }
                } else {
                    if (taxReciept){
                        taxReciept.taxRecieptHolderState = varValue
                        taxReciept.save(failOnError:true);
                    } else {
                        TaxReciept taxreciept = new TaxReciept()
                        taxreciept.taxRecieptHolderState = varValue
                        taxreciept.project = project
                        taxreciept.save(failOnError:true);
                    }
                }
                break;

            case 'deductibleStatus':
                TaxReciept taxReciept = TaxReciept.findByProject(project)
                if (varValue.isAllWhitespace()){
                    if (taxReciept){
                        taxReciept.deductibleStatus = null
                        taxReciept.save(failOnError:true);
                    }
                } else {
                    if (taxReciept){
                        taxReciept.deductibleStatus = varValue
                        taxReciept.save(failOnError:true);
                    } else {
                        TaxReciept taxreciept = new TaxReciept()
                        taxreciept.deductibleStatus = varValue
                        taxreciept.project = project
                        taxreciept.save(failOnError:true);
                    }
                }
                break;

            case 'taxRecieptHolderCountry':
                TaxReciept taxReciept = TaxReciept.findByProject(project)
                if (varValue.isAllWhitespace()){
                    if (taxReciept){
                        taxReciept.country = null
                        taxReciept.save(failOnError:true);
                    }
                } else {
                    if (taxReciept){
                        taxReciept.country = varValue
                        taxReciept.save(failOnError:true);
                    } else {
                        TaxReciept taxreciept = new TaxReciept()
                        taxreciept.country = varValue
                        taxreciept.project = project
                        taxreciept.save(failOnError:true);
                    }
                }
                break;
                
            case 'regDate':
                TaxReciept taxReciept = TaxReciept.findByProject(project)
                if (taxReciept){
                    
                    taxReciept.regDate = Date.parse("MM/dd/yyyy", varValue)
                    taxReciept.save(failOnError:true);
                } else {
                    TaxReciept taxreciept = new TaxReciept()
                    taxreciept.regDate = Date.parse("MM/dd/yyyy", varValue)
                    taxreciept.project = project
                    taxreciept.save(failOnError:true);
                } 
                break;
                
            case 'expiryDate':
                TaxReciept taxReciept = TaxReciept.findByProject(project)
                if (taxReciept){
                    taxReciept.expiryDate = Date.parse("MM/dd/yyyy", varValue)
                    taxReciept.save(failOnError:true);
                } else {
                    TaxReciept taxreciept = new TaxReciept()
                    taxreciept.expiryDate = Date.parse("MM/dd/yyyy", varValue)
                    taxreciept.project = project
                    taxreciept.save(failOnError:true);
                }
                break;
                
            case 'fcraRegDate':
                TaxReciept taxReciept = TaxReciept.findByProject(project)
                if (taxReciept){
                    taxReciept.fcraRegDate = Date.parse("MM/dd/yyyy", varValue)
                    taxReciept.save(failOnError:true);
                } else {
                    TaxReciept taxreciept = new TaxReciept()
                    taxreciept.fcraRegDate = Date.parse("MM/dd/yyyy", varValue)
                    taxreciept.project = project
                    taxreciept.save(failOnError:true);
                }
                break;

            case 'addressLine1':
                TaxReciept taxReciept = TaxReciept.findByProject(project)
                if (varValue.isAllWhitespace()){
                    if (taxReciept){
                    taxReciept.addressLine1 = null
                    taxReciept.save(failOnError:true);
                    }
                } else {
                    if (taxReciept){
                        taxReciept.addressLine1 = varValue
                        taxReciept.save(failOnError:true);
                    } else {
                        TaxReciept taxreciept = new TaxReciept()
                        taxreciept.addressLine1 = varValue
                        taxreciept.project = project
                        taxreciept.save(failOnError:true);
                    }
                }
                break;
                
            case 'addressLine2':
                TaxReciept taxReciept = TaxReciept.findByProject(project)
                if (varValue.isAllWhitespace()){
                    if (taxReciept){
                    taxReciept.addressLine2 = null
                    taxReciept.save(failOnError:true);
                    }
                } else {
                    if (taxReciept){
                        taxReciept.addressLine2 = varValue
                        taxReciept.save(failOnError:true);
                    } else {
                        TaxReciept taxreciept = new TaxReciept()
                        taxreciept.addressLine2 = varValue
                        taxreciept.project = project
                        taxreciept.save(failOnError:true);
                    }
                }
                break;
                
            case 'regNum':
                TaxReciept taxReciept = TaxReciept.findByProject(project)
                if (varValue.isAllWhitespace()){
                    if (taxReciept){
                    taxReciept.regNum = null
                    taxReciept.save(failOnError:true);
                    }
                } else {
                    if (taxReciept){
                        taxReciept.regNum = varValue
                        taxReciept.save(failOnError:true);
                    } else {
                        TaxReciept taxreciept = new TaxReciept()
                        taxreciept.regNum = varValue
                        taxreciept.project = project
                        taxreciept.save(failOnError:true);
                    }
                }
                break;
                
            case 'panCardNumber':
                TaxReciept taxReciept = TaxReciept.findByProject(project)
                if (varValue.isAllWhitespace()){
                    if (taxReciept){
                    taxReciept.panCardNumber = null
                    taxReciept.save(failOnError:true);
                    }
                } else {
                    if (taxReciept){
                        taxReciept.panCardNumber = varValue
                        taxReciept.save(failOnError:true);
                    } else {
                        TaxReciept taxreciept = new TaxReciept()
                        taxreciept.panCardNumber = varValue
                        taxreciept.project = project
                        taxreciept.save(failOnError:true);
                    }
                }
                break;

            case 'phoneNumber':
                TaxReciept taxReciept = TaxReciept.findByProject(project)
                if (varValue.isAllWhitespace()){
                    if (taxReciept){
                        taxReciept.phone = null
                        taxReciept.save(failOnError:true);
                    }
                } else {
                    if (taxReciept){
                        taxReciept.phone = varValue
                        taxReciept.save(failOnError:true);
                    } else {
                        TaxReciept taxreciept = new TaxReciept()
                        taxreciept.phone = varValue
                        taxreciept.project = project
                        taxreciept.save(failOnError:true);
                    }
                }
                break;
                
            case 'fcraRegNum':
                TaxReciept taxReciept = TaxReciept.findByProject(project)
                if (varValue.isAllWhitespace()){
                    if (taxReciept){
                        taxReciept.fcraRegNum = null
                        taxReciept.save(failOnError:true);
                    }
                } else {
                    if (taxReciept){
                        taxReciept.fcraRegNum = varValue
                        taxReciept.save(failOnError:true);
                    } else {
                        TaxReciept taxreciept = new TaxReciept()
                        taxreciept.fcraRegNum = varValue
                        taxreciept.project = project
                        taxreciept.save(failOnError:true);
                    }
                }
                break;

            case 'zip':
                TaxReciept taxReciept = TaxReciept.findByProject(project)
                if (varValue.isAllWhitespace()){
                    if (taxReciept){
                        taxReciept.zip = null
                        taxReciept.save(failOnError:true);
                    }
                } else {
                    if (taxReciept){
                        taxReciept.zip = varValue
                        taxReciept.save(failOnError:true);
                    } else {
                        TaxReciept taxreciept = new TaxReciept()
                        taxreciept.zip = varValue
                        taxreciept.project = project
                        taxreciept.save(failOnError:true);
                    }
                }
                break;
                
            case 'exemptionPercentage':
                TaxReciept taxReciept = TaxReciept.findByProject(project)
                if (varValue.isAllWhitespace()){
                    if (taxReciept){
                        taxReciept.exemptionPercentage = null
                        taxReciept.save(failOnError:true);
                    }
                } else {
                    if (taxReciept){
                        taxReciept.exemptionPercentage = Double.parseDouble((varValue != null) ? varValue : "0");
                        taxReciept.save(failOnError:true);
                    } else {
                        TaxReciept taxreciept = new TaxReciept()
                        taxreciept.exemptionPercentage = Double.parseDouble((varValue != null) ? varValue : "0");
                        taxreciept.project = project
                        taxreciept.save(failOnError:true);
                    }
                }

                break;

            case 'offeringTaxReciept':
                project.offeringTaxReciept = (varValue == 'true' || varValue == true) ? true : false;
                isValueChanged = true
                break;

            case 'impactNumber':
                if (varValue.isNumber()) {
                    project.impactNumber = Integer.parseInt(varValue);
                    isValueChanged = true
                }
                break;
                
            case 'citrusEmail': 
				if (!project.validated) {
	                project.citrusEmail = varValue
	                project.payuEmail = null
	                isValueChanged = true
				}
                break;
                
            default :
               isValueChanged = false;

        }

        if (isValueChanged){
            project.save(failOnError:true);
        }
    }
	
    def getFirstAdminForProjects(String adminEmail, Project project, User user) {
        def fullName = user.firstName + ' ' + user.lastName
        List projectAdmins = project.projectAdmins
		def country_code = project.country.countryCode
        ProjectAdmin projectAdmin = ProjectAdmin.findByProjectAndAdminCount(project, 1)
        if (adminEmail) {
            mandrillService.inviteAdmin(adminEmail, fullName, project,country_code)
            if (projectAdmin){
                projectAdmin.email = adminEmail
                projectAdmin.save()
            } else {
                projectAdmin = new ProjectAdmin()
                projectAdmin.email = adminEmail
                projectAdmin.adminCount = 1
                project.addToProjectAdmins(projectAdmin)
            }
        } else if ((adminEmail == '' || adminEmail == null) && projectAdmin) {
                projectAdmins.remove(projectAdmin);
                projectAdmin.delete()
         }
    }

    def getSecondAdminForProjects(String adminEmail, Project project, User user) {
        def fullName = user.firstName + ' ' + user.lastName
		def country_code = project.country.countryCode
        List projectAdmins = project.projectAdmins
		ProjectAdmin projectAdmin = ProjectAdmin.findByProjectAndAdminCount(project, 2)
        if (adminEmail) {
            mandrillService.inviteAdmin(adminEmail, fullName, project,country_code)
            if (projectAdmin){
                projectAdmin.email = adminEmail
                projectAdmin.save()
            } else {
                projectAdmin = new ProjectAdmin()
                projectAdmin.email = adminEmail
                projectAdmin.adminCount = 2
                project.addToProjectAdmins(projectAdmin)
            } 
        } else if ((adminEmail == '' || adminEmail == null) && projectAdmin){
                projectAdmins.remove(projectAdmin);
                projectAdmin.delete()
        }
    }

    def getThirdAdminForProjects(String adminEmail, Project project, User user) {
        def fullName = user.firstName + ' ' + user.lastName
		def country_code = project.country.countryCode
        List projectAdmins = project.projectAdmins
		ProjectAdmin projectAdmin = ProjectAdmin.findByProjectAndAdminCount(project, 3)
        if (adminEmail) {
            mandrillService.inviteAdmin(adminEmail, fullName, project,country_code)
            if (projectAdmin){
                projectAdmin.email = adminEmail
                projectAdmin.save()
           } else {
                projectAdmin = new ProjectAdmin()
                projectAdmin.email = adminEmail
                projectAdmin.adminCount = 3
                project.addToProjectAdmins(projectAdmin)
             }
         } else if ((adminEmail == '' || adminEmail == null) && projectAdmin) {
                projectAdmins.remove(projectAdmin);
                projectAdmin.delete()
         }
     }
	
	def getAdminEmail(Project project){
		List admins = project.projectAdmins
		def email1
		def email2
		def email3
		admins.each{
			if (it?.adminCount == 1){
				email1 = it?.email
			}
			if (it?.adminCount == 2){
				email2 = it?.email
			}
			if (it?.adminCount == 3){
				email3 = it?.email
			}
		}
		
		return ['email1':email1, 'email2':email2, 'email3':email3]
		
	}
    
    def getPayuInfo(def params, def base_url,def country_code) {
        def currentEnv = Environment.current.getName()
        def project = Project.get(params.campaignId)
        def user = User.get(params.userId)
        def reward = Reward.get(params.rewardId)

        User fundraiser = userService.getUserFromVanityName(params.fr)
        def address = getAddress(params, country_code)
        if (user == null){
            user = userService.getUserByUsername('anonymous@example.com')
        }
        
        def key = grailsApplication.config.crowdera.PAYU.KEY
        def salt = grailsApplication.config.crowdera.PAYU.SALT
        def amount = params.amount
        def firstname =  params.firstname
        def email = params.email
        def productinfo = params.productinfo
        def surl = base_url + "/fund/payureturn?projectId=${project.id}&rewardId=${reward.id}&amount=${params.amount}&result=true&userId=${user.id}&fundraiser=${fundraiser.id}&physicalAddress=${address}&shippingCustom=${params.shippingCustom}&shippingEmail=${params.shippingEmail}&shippingTwitter=${params.twitterHandle}&name=${params.firstname} ${params.lastname}&email=${params.email}&anonymous=${params.anonymous}&projectTitle=${params.projectTitle}&panNumber=${params.panNumber}"

        def furl = base_url + "/error"
        def txnid = generateTransId()
        StringBuilder sb = new StringBuilder()
        sb.append(key).append("|").append(txnid).append("|").append(amount).append("|").append(productinfo).append("|").append(firstname).append("|").append(email).append("|||||||||||").append(salt)
        
        String hashstring = sb.toString()
        def hash = generateHash("SHA-512",hashstring)

        return [txnid:txnid, hash:hash, furl:furl, surl:surl]
    }

    def getCountryValue(def country){
        Map countries = getCountry()
        def mapValue =  countries.getAt(country)
        return mapValue
    }
    
    def getCountryKey(def country){
        Map countries = getCountry()
        def mapKey = countries.find { it.value == country }?.key
        return mapKey
    }

    def setCookie(def requestUrl) {
        Cookie cookie = new Cookie("requestUrl", requestUrl)
        cookie.path = '/'
        cookie.maxAge= 0
        return cookie
    }
	
	def setRequestUrlCookie(def requestUrl){
		Cookie cookie = new Cookie("requestUrl", requestUrl)
		cookie.path = '/'
		cookie.maxAge= 3600
		return cookie
	}

    def setLoginSignUpCookie() {
        Cookie cookie = new Cookie("loginSignUpCookie", 'createCampaignloginSignUpActive')
        cookie.path = '/'
        cookie.maxAge= 3600
        return cookie
    }

	def setCampaignNameCookie(def title){
		Cookie cookie = new Cookie("campaignNameCookie", title)
		cookie.path = '/'
		cookie.maxAge= 3600
		return cookie
	}

	def setFundingAmountCookie(def amount){
		Cookie cookie = new Cookie("fundingAmountCookie", amount?.round().toString())
		cookie.path = '/'
		cookie.maxAge= 3600
		return cookie
	}

    def setContributorName(def contributorName){
        Cookie cookie = new Cookie("contributorNameCookie", contributorName)
        cookie.path = '/'
        cookie.maxAge= 3600
        return cookie
    }
	
	def setContributorEmailCookie(def contributorEmail){
		Cookie cookie = new Cookie("contributorEmailCookie", contributorEmail)
		cookie.path = '/'
		cookie.maxAge= 3600
		return cookie
	}
	
	def deleteContributorEmailCookie(def contributorEmail){
		Cookie cookie = new Cookie("contributorEmailCookie", contributorEmail)
		cookie.path = '/'
		cookie.maxAge= 0
		return cookie
	}

	def deleteContributorName(def contributorName){
        Cookie cookie = new Cookie("contributorNameCookie", contributorName)
        cookie.path = '/'
        cookie.maxAge= 0
        return cookie
    }

	def deleteCampaignNameCookie(def campaignNameCookieValue){
		Cookie cookie = new Cookie("campaignNameCookie", campaignNameCookieValue)
		cookie.path = '/'
		cookie.maxAge= 0
		return cookie
	}

	def deleteFundingAmountCookie(def fundingAmountCookieValue){
		Cookie cookie = new Cookie("fundingAmountCookie", fundingAmountCookieValue)
		cookie.path = '/'
		cookie.maxAge= 0
		return cookie
	}

    def deleteLoginSignUpCookie() {
        Cookie cookie = new Cookie("loginSignUpCookie", 'createCampaignloginSignUpActive')
        cookie.path = '/'
        cookie.maxAge= 0
        return cookie
    }
    
    def getProjectList(def params) {
        List totalCampaigns = []
        List projects = []
        def max = Math.min(params.int('max') ?: 12, 100)
        def offset = params.int('offset') ?: 0
        totalCampaigns = Project.findAllWhere(validated: true)
        totalCampaigns = totalCampaigns?.sort{it.title}
        
        def count = totalCampaigns.size()
        def maxrange
        
        if(offset+max <= count) {
            maxrange = offset + max
        } else {
            maxrange = offset + (count - offset)
        }
        
        projects = totalCampaigns.subList(offset, maxrange)
        return [totalCampaigns: totalCampaigns, projects: projects]
    }
    
    def getCampaignBySearchQuery(def params) {
        List totalCampaigns = []
        List projects = []
        List result = []
        def query = params.searchValue
        def max = Math.min(params.int('max') ?: 12, 100)
        def offset = params.int('offset') ?: 0
        totalCampaigns = Project.findAllWhere(validated: true)
        totalCampaigns.each {
            if( it.title.toLowerCase().contains(query.toLowerCase()) ){
                result.add(it)
            }
        }
        
        result = result?.sort{it.title}
        def count = result.size()
        def maxrange
        if (count > 0 && params.searchValue) {
            if(offset+max <= count) {
                maxrange = offset + max
            } else {
                maxrange = offset + (count - offset)
            }
            projects = result.subList(offset, maxrange)
            return [totalCampaigns: result, projects: projects]
        } else {
            count = totalCampaigns.size()
            totalCampaigns = totalCampaigns?.sort{it.title}
            if(offset+max <= count) {
                maxrange = offset + max
            } else {
                maxrange = offset + (count - offset)
            }
            projects = totalCampaigns.subList(offset, maxrange)
            def message = 'No campaign found'
            return [totalCampaigns: totalCampaigns, projects: projects, message: message]
        }
        
    }
    
    def getCampaignSupporterCount(Project project) {
        return project.supporters.size()
    }
    
    def ContributorNameCookie(contributorEmail){
		Cookie cookie = new Cookie("contributorEmail", contributorEmail)
		cookie.path = '/'    // Save Cookie to local path to access it throughout the domain
		cookie.maxAge= 3600  //Cookie expire time in seconds
	}

    def isCustomUrUnique(def vanityUrl, def projectId){
        /*List title = VanityTitle.list()
        Project project = Project.get(projectId)
        def status = true
        title.each {
            if (it.vanityTitle.equalsIgnoreCase(vanityUrl)){
                if (it.project != project)
                    status = false
            }
        }
        return status*/
		
		Long rowCount = (Long) VanityTitle.createCriteria().add(Restrictions.ne("project.id", projectId))
						.add(Restrictions.eq("vanityTitle", vanityUrl))
						.createAlias("project", "project").setProjection(Projections.rowCount()).uniqueResult();
		
		return (rowCount.intValue() == 0) ? true : false;
    }
	
	def getShippingInfo(def params){
		def shippingInfo
		def twitter, custom, address, email
		if (params.twitterField){
			twitter = params.twitterField
		} else {
			twitter = null
		}

		if(params.customField && params.customField != ''){
			custom = params.customField
		} else {
			custom = null
		}

		if(params.emailField){
			email = params.emailField
		} else {
			email = null
		}

		if(params.addr1){  
			address = params.addr1

		if (params.addr2 && params.addr2 != '' && params.addr2 != 'null'){
			address = address + " " + params.addr2
		}

		address = address + " " + params.cityField + "-" + params.zipField
		Map countries = getCountry()
		if (params.otherField && params.stateField == 'other'){
			address = address+ " " + params.otherField + " " + countries.getAt(params.countryField)
		} else {
			Map states = getState()
			address = address + " " + states.getAt(params.stateField) + " " + countries.getAt(params.countryField)
		}
	} else {
		address = null
	}
		
	shippingInfo = [twitter:twitter, custom:custom, address:address, email:email]
	return shippingInfo
	}

    def generateCSVReportForCampaign(def response, Project project, def ytViewCount, def linkedinCount, def twitterCount, def facebookCount){

        def numberOfContributions = project.contributions.size()
        def percentageContribution = contributionService.getPercentageContributionForProject(project)
        def numberOFPerks = (project.rewards.size() > 1) ? project.rewards.size() : 0
        def maxSelectedPerkAmount = rewardService.getMostSelectedPerkAmountForCampaign(project)
        def numberOfTeams = getValidatedTeamForCampaign(project)
        def disabledTeams = getDiscardedTeams(project)
        def highestContribution = contributionService.getHighestContributionDay(project)
        def campaignSupporterCount = getCampaignSupporterCount(project)
        def usedFor = (project.usedFor) ? project.usedFor : 'IMPACT'
        String highestContributionHour = highestContribution.highestContributionHour + ' hr'
        
        List results = []
        
        def campaignMetricsMap =[:]
        campaignMetricsMap.put('CAMPAIGN', project.title.replaceAll("[,;]",' '))
        campaignMetricsMap.put('CAMPAIGN GOAL', project.amount.round())
        campaignMetricsMap.put('RAISED FUND FOR', usedFor)
        campaignMetricsMap.put('TOTAL NUMBER OF CONTRIBUTIONS', numberOfContributions)
        campaignMetricsMap.put('PERCENTAGE GOAL RAISED', percentageContribution)
        campaignMetricsMap.put('NUMBER OF PERKS OFFERED', numberOFPerks)
        campaignMetricsMap.put('MOST SELECTED PERK AMOUNT', maxSelectedPerkAmount)
        campaignMetricsMap.put('TOTAL NUMBER OF COMMENTS', project.comments.size())
        campaignMetricsMap.put('TOTAL NUMBER OF UPDATES', project.projectUpdates.size())
        campaignMetricsMap.put('TOTAL NUMBER OF ENABLED TEAMS', numberOfTeams.size())
        campaignMetricsMap.put('TOTAL NUMBER OF DISABLED TEAMS', disabledTeams.size())
        campaignMetricsMap.put('NUMBER OF VIDEO VIEWERS', ytViewCount)
        campaignMetricsMap.put('HIGHEST CONTRIBUTION DAY', highestContribution.highestContributionDay)
        campaignMetricsMap.put('HIGHEST CONTRIBUTION HOUR', highestContributionHour)
        campaignMetricsMap.put('FACEBOOK SHARE COUNT', facebookCount)
        campaignMetricsMap.put('TWITTER SHARE COUNT', twitterCount)
        campaignMetricsMap.put('LINKEDIN SHARE COUNT', linkedinCount)
        campaignMetricsMap.put('EMAIL SHARE COUNT', project.gmailShareCount)
        campaignMetricsMap.put('TOTAL NUMBER OF SUPPORTERS', campaignSupporterCount)

        def result = ''
        response.setHeader("Content-disposition", "attachment; filename= Crowdera_report-"+project.title.replaceAll("[,;\\s]",'_')+".csv")
        
        campaignMetricsMap.each{campaignFeature , value ->
            def rows =[campaignFeature , value]
            results << rows
        }
        
        results.each{ row->
            row.each{
                col -> result+=col +','
            }
            result = result[0..-2]
            result+="\n"
        }
        return result
    }
	
	def importCSVReportForUserFeedback(def response,Project project){
		User user =User.get(project.user.id)
		def feedback = Feedback.findAllWhere(user:user)
		def feedbackMap =[:]
		List results = []
		
		feedback.each{
			feedbackMap.put("1) How did you hear about us?", it.answer_1)
			feedbackMap.put("2a) What others crowdfunding platforms did you use?", it.answer_2_y1)
			feedbackMap.put("2b) What did you like the best about those platforms?", it.answer_2_y2)
			feedbackMap.put("2n) What do you like the best about Crowdera?", it.answer_2_n)
			feedbackMap.put("3) How easy was it to create your campaign on Crowdera?", it.answer_3)
			feedbackMap.put("4a) How easy was it to Add and Manage Teams?", it.answer_4_y)
			feedbackMap.put("4n) Is there a reason why you didn't use the Team feature?", it.answer_4_n)
			feedbackMap.put('5) What other "must have" or "nice to have" feautres would your recommend?', it.answer_5)
			feedbackMap.put("6) Do you need volunteer or additional help in fundraising?", it.answer_6)
			feedbackMap.put("7) Did you face any challenge or aberration on our site?", it.answer_7)
			feedbackMap.put("8) How likely are you to use or recommend Crowdera in the future?", it.answer_8)
			feedbackMap.put("9a) What is the best way to provide you with more product information?", it.answer_9_y1)
			feedbackMap.put("9b) Did our platform provided with all the services that you hoped for?", it.answer_9_y2)
			feedbackMap.put("9c) How visually appealing is our website ?", it.answer_9_y3)
			feedbackMap.put("9d) Did you take more or less time than you had expected to create your campaign on crowdera?", it.answer_9_y4)
			feedbackMap.put("9e) Do you have any other suggestions or comments for crowdera?", it.answer_9_y5)
			feedbackMap.put("9f) If you could change one thing about the entire website of crowdera what would it be?", it.answer_9_y6)
			feedbackMap.put("9n) Please state the reason for your rating so that we can improve our service in future.", it.answer_9_n)
		}
		feedbackMap.each{question , answer ->
			def rows =[question, answer]
			results << rows
		}
		
		def result
		response.setHeader("Content-disposition", "attachment; filename= Crowdera_report-"+project.title.replaceAll("[,;\\s]",'_')+".csv")
		result ='Question, Answer, \n'
		results.each{ row->
			row.each{
				col -> result+=col +','
			}
			result = result[0..-2]
			result+="\n"
		}
		return result
	}

	def sendFeedbackEmailToOwners(def project, def  base_url){
		int emailCount=0
		def remainingDay=getRemainingDay(project)
		def user = userService.getUserById(project.user.id)
		def feedback=userService.getFeedbackByUser(user)
		if(!feedback){
			if((user.feedbackCount < 1 && remainingDay == 7) || (user.feedbackCount < 2 && remainingDay == 5) || (user.feedbackCount < 3 && remainingDay == 3)){
				emailCount = user.feedbackCount + 1
				def owner = project.user
				user.feedbackCount = emailCount
				mandrillService.sendFeedBackLinkToOwner(owner, base_url)
			}
		}
	}
    def sendEmailTONonUserContributors() {
        def contributionList = Contribution.list()
        List nonUserContributors = []
        List contributorsEmail = []
        def user
        contributionList.each {
           if (!contributorsEmail.contains(it.contributorEmail)) {
               user = User.findByEmail(it.contributorEmail)
               if (!user){
                   contributorsEmail.add(it.contributorEmail)
                   nonUserContributors.add(it)
               }
           }
       }
       mandrillService.sendEmailToNonUserContributors(nonUserContributors)
    }
    
    def getUsersPaginatedCampaigns(List projects, def params, def max) {
        List totalCampaigns = []
        if (!projects.isEmpty()) {
            def offset = params.int('offset') ?: 0

            def count = projects.size()
            def maxrange

            if(offset+max <= count) {
                maxrange = offset + max
            } else {
                maxrange = offset + (count - offset)
            }

            totalCampaigns = projects.subList(offset, maxrange)
        }
        return totalCampaigns
    }

    def getPaginatedContibutionByUser(User user,def environment, def params, def max) {
        List contributions = []
        List totalCampaignSupported = []
        List campaignSupported = []
        
        contributions = getContibutionByUser(user, environment)
        
        contributions.each { contribution ->
            if (!totalCampaignSupported.contains(contribution.project)) {
                totalCampaignSupported.add(contribution.project)
            }
        }
        
        if (!totalCampaignSupported.isEmpty()) {
            def offset = params.int('offset') ?: 0

            def count = totalCampaignSupported.size()
            def maxrange

            if(offset + max <= count) {
                maxrange = offset + max
            } else {
                maxrange = offset + (count - offset)
            }
            campaignSupported = totalCampaignSupported.reverse().subList(offset, maxrange)
        }
        return [totalCampaignSupported: totalCampaignSupported, campaignSupported: campaignSupported]
    }
    
    def getPaginatedCampaignsContributedByUser(User user,def country_code, def params, def max) {
        List contributions = []
        List totalCampaignSupported = []
        List campaignSupported = []
        
        contributions = getContibutionByUser(user, country_code)
        
        contributions.each { contribution ->
            if (!totalCampaignSupported.contains(contribution.project)) {
                totalCampaignSupported.add(contribution.project)
            }
        }
        
        if (!totalCampaignSupported.isEmpty()) {
            def offset = params.int('offset') ?: 0

            def count = totalCampaignSupported.size()
            def maxrange

            if(offset + max <= count) {
                maxrange = offset + max
            } else {
                maxrange = offset + (count - offset)
            }
            campaignSupported = totalCampaignSupported.reverse().subList(offset, maxrange)
        }
        return [totalCampaignSupported: totalCampaignSupported, campaignSupported: campaignSupported, contributions: contributions]
    }

    def getShortenUrl(def projectId, def user_name){
        def username
        def code
        if (projectId){
            if (user_name){
                username = userService.getUsernameFromVanityName(user_name)
                if (!username){
                    Project project = Project.get(projectId)
                    username = project.user.username
                }
            } else {
                Project project = Project.get(projectId)
                username = project.user.username
            }

            def urlShortener = UrlShortener.findByProjectIdAndUsername(projectId, username)
            if (urlShortener){
                code = urlShortener.shortenUrl
            } else {
                code = getAlphaNumbericRandomUrl()
                new UrlShortener(
                    shortenUrl: code,
                    projectId: projectId,
                    username : username
                ).save(failOnError:true)
            }
        }
        return code
    }

    def getAlphaNumbericRandomUrl() {
        String chars = "abcdefghijklmnopqrstuvwxyz0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ";
        int numberOfCodes = 0;//controls the length of alpha numberic string
        String code = "";
        while (numberOfCodes < 8) {
            char c = chars.charAt((int) (Math.random() * chars.length()));
            code += c;
            numberOfCodes++;
        }
        return code;
    }

    def getCampaignFromUrl(url){
        def projectId
        def vanityTitle
        def username
        def vanityName
		def country_code
        def details
        def urlShortener = UrlShortener.findByShortenUrl(url)
        if (urlShortener){
            projectId = urlShortener?.projectId
            username = urlShortener?.username
            if (projectId){
                vanityTitle = getVanityTitleFromId(projectId)
            }
            if (username){
                vanityName = userService.getVanityNameFromUsername(username, projectId)
            }
        }
		def project = getProjectById(projectId);
        details = [projectTitle:vanityTitle, fr:vanityName,country_code:project.country.countryCode,category:project.fundsRecievedBy.toLowerCase()]
        return details
    }
    
    def getCurrencyConverter() {
        Currency currency = userService.getCurrencyById();
        if (currency) {
            return currency.dollar.round();
        } else {
            return 65;
        }
    }
    
    def getContributedAmount(List contributions) {
        double amount = 0;
        contributions.each{ contribution ->
            amount = amount + contribution.amount
        }
        return amount
    }

    def getTotalFundRaisedByUser(List projects) {
        double amount = 0;
        def currentEnv = getCurrentEnvironment()
        projects.each { project ->
            def contributedAmount = contributionService.getTotalContributionForProject(project)
                    amount = amount + contributedAmount
        }
        return amount;
    }
	
    def saveLastSpendField(def params){
        def projectId = params.projectId
        def savingCount = params.lastSpendField
        def amount = params.('spendAmount'+savingCount)
        def cause = params.('spendCause'+savingCount)
        def spend = [projectId:projectId, savingCount:savingCount, amount:amount, cause:cause]
        getSpendMatrixSaved(spend)
    }

    def getSpendMatrixSaved(def params) {
        Project project = Project.get(params.projectId)
        def saveCount = Integer.parseInt(params.savingCount)
        if (params.amount && params.cause && params.amount.isNumber()) {
            def amount = Double.parseDouble(params.amount)
            SpendMatrix spendMatrix = SpendMatrix.findByNumberAvailableAndProject(saveCount, project)
            if (spendMatrix) {
                def isValueChanged = false

                if (amount && amount != ' '){
                    spendMatrix.amount = amount
                    isValueChanged = true
                }

                if (params.cause && params.cause != ' '){
                    spendMatrix.cause = params.cause
                    isValueChanged = true
                }
                
                if (isValueChanged){
                    spendMatrix.save(failOnError: true);
                }
            
            } else {
                new SpendMatrix(
                    project:project,
                    amount : amount,
                    cause : params.cause,
                    numberAvailable : saveCount
                ).save(failOnError:true);
            }
        }
        return project
    }

    def getSpendMatrixDeleted(def params){
        Project project = Project.get(params.projectId)
        def deleteCount = Integer.parseInt(params.deleteCount)
        SpendMatrix spendMatrix = SpendMatrix.findByNumberAvailableAndProject(deleteCount, project)
        if (spendMatrix){
            spendMatrix.delete(flush:true);
        }
        return project
    }

    def getPieList(Project project) {
        def spendMatrixs = project.spend;
        String sublist1;
        String sublist;
        def total = 0
        if (spendMatrixs){
            spendMatrixs.each{ spendMatrix ->
                sublist = (sublist) ? sublist + ', ' + spendMatrix.cause : spendMatrix.cause;
                sublist1 = (sublist1) ? sublist1 + ', ' + spendMatrix.amount.round() : spendMatrix.amount.round();
                total = total + spendMatrix.amount
            }
            if ((project.amount - total) > 0){
				
                def totalLeft = (project.amount - total);
                sublist = sublist + ', ' +'Miscellaneous'
                sublist1 = sublist1 + ', ' +totalLeft.round()
            }
        } else {
            sublist = null;
            sublist1 = null;
        }
        return [spendCauseList: sublist, spendAmountPerList: sublist1];
    }

    def getProjectReasonsToFund(Project project){
        return ReasonsToFund.findByProject(project)
    }
    	
    def getProjectQA(Project project){
        return QA.findByProject(project)
    }

    def getValidatedProjectsForCampaignAdmin(def condition, def country) {
        
        List projects = []
        List totalProjects = []
        List activeCampaigns = []
        if (condition == 'Live' || condition == 'Ended' || condition=='Deadline') {
            if (country == 'INDIA') {
                
                totalProjects = Project.findAllWhere(payuStatus: true, validated: true, inactive: false)
            } else if(country == 'USA') {
                
                totalProjects = Project.findAllWhere(payuStatus: false, validated: true, inactive: false)
            }
//            totalProjects.each { project->
//                if (isProjectDeadlineCrossed(project)) {
//                    endedCampaigns.add(project)
//                } else {
//                    activeCampaigns.add(project)
//                }
//            }
        }else if(condition=="Homepage" ) {
		    totalProjects = Project.findAllWhere(validated: true, inactive: false)
        }
        
        switch (condition) {
            case 'Ended':
                def endedCampaigns= getEndedCampaigns(totalProjects)
                projects = endedCampaigns.sort{it.created}.reverse()
                break;
            case 'Pending':
                if (country == 'INDIA') {
                    projects = Project.findAllWhere(payuStatus: true, draft: false, inactive: false, rejected: false, validated: false).sort{it.created}.reverse()
                    checkProjectExistence(projects)
                } else if(country == 'USA') {
                    projects = Project.findAllWhere(payuStatus: false, draft: false, inactive: false, rejected: false, validated: false).sort{it.created}.reverse()
                    checkProjectExistence(projects)
                }
                break;
            case 'Live':
                def liveProjects = getLiveProjects(totalProjects)
                projects = liveProjects.sort{it.created}.reverse()
                break;
            case 'Homepage':
                def liveProjects = getLiveProjects(totalProjects)
                projects = liveProjects.title.sort{it.toLowerCase()}
                break;
            case 'Deadline':
                projects= totalProjects.title.sort{it.toLowerCase()}
                break;
            case 'Draft':
                if (country == 'INDIA') {
                    projects = Project.findAllWhere(payuStatus: true, draft: true, inactive: false, rejected: false).sort{it.created}.reverse()
                    checkProjectExistence(projects)
                } else if(country == 'USA') {
                    projects = Project.findAllWhere(payuStatus: false, draft: true, inactive: false, rejected: false).sort{it.created}.reverse()
                    checkProjectExistence(projects)
                }
                break;
            case 'Rejected':
                if (country == 'INDIA') {
                    projects = Project.findAllWhere(payuStatus: true, rejected: true).sort{it.created}.reverse()
                } else if(country == 'USA') {
                    projects = Project.findAllWhere(payuStatus: false, rejected: true).sort{it.created}.reverse()
                }
                break;
            case 'Deleted':
                if(country == "INDIA"){
                    projects = Project.findAllWhere(payuStatus: true, inactive: true)
                }else if( country == 'USA'){
                    projects = Project.findAllWhere(payuStatus: false, inactive: true)
                }
            break;
            default :
               projects = []
        }
        
        return projects
    }
    
    private static void checkProjectExistence(def projects){
        Date currentDate = new Date()
        projects.each{project ->
            def dateDifference = currentDate - project.created
            if(dateDifference > 90){
                project.rejected = true
            }
        }
    }
    
    def getPartnerCampaigns(User user, def params) {
        def environment = getCurrentEnvironment();
        List projects = []
        def campaigns = getAllProjectByUser(user, environment)
        def projectAdmins = getProjectAdminEmail(user)
        def teams = getEnabledAndValidatedTeam(user)
        def totalprojects = getProjects(campaigns, projectAdmins, teams, environment)
        
        def max = Math.min(params.int('max') ?: 6, 100)
        def offset = params.int('offset') ? params.int('offset') : 0
        def count = totalprojects.size()
        def maxrange

        if(offset + max <= count) {
            maxrange = offset + max
        } else {
            maxrange = offset + (count - offset)
        }
        projects = totalprojects.subList(offset, maxrange)
        return [projects: projects, totalprojects: totalprojects, campaigns: campaigns]
    }
    
    def getSortingList() {
        def sortingOptions = [
            Draft: 'Draft',
            Pending: 'Pending',
            Live: 'Live',
            Ended: 'Ended',
            Rejected: 'Rejected',
            Deleted: 'Deleted',
            Homepage:'Homepage',
            Deadline: 'Deadline',
            Carousel: 'Carousel'
        ]
        return sortingOptions
    }

    def getTaxRecieptOfProject(Project project){
        return TaxReciept.findByProject(project)
    }
    
    def getTaxRecieptIdByProjectId(def projectId){
        Project project = Project.get(projectId)
        def taxreciept = TaxReciept.findByProject(project);
        def taxrecieptId = (taxreciept) ? taxreciept.id : null;
        return taxrecieptId
    }
    
    def getDeductibleStatusList(){
        def deductibleStatus = [
            PC : 'PC (50%)',
            POF : 'POF (30%)',
            PF : 'PF (30%)',
            GROUP : 'GROUP (Depends)',
            LODGE : 'LODGE (30%)',
            UNKWN : 'UNKWN (Depends)',
            EO : 'EO (Depends)',
            FED : 'FED (50%)',
            FORGN : 'FORGN (Depends)',
            SO : 'SO (50%)',
            SONFI : 'SONFI (50%)',
            SOUNK : 'SOUNK (50%)'
        ]
        return deductibleStatus
    }

    def getDeductibleStatus(def deductibleStatus){
        def deductibleStatusList = getDeductibleStatusList();
        return deductibleStatusList.getAt(deductibleStatus);
    }

    def getCategoryAndHashTagsSaved(Project project, def currentEnv, def selectedCategory){
        project.category = (selectedCategory) ? selectedCategory : 'OTHER';

        def category = (selectedCategory) ? selectedCategory : null;
        def country = (project.beneficiary.country) ? getCountryValue(project.beneficiary.country) : null;
        def usedFor = project.usedFor
        def fundRaisedBy = project.fundsRecievedBy
        def city = project.beneficiary.city
        def hashlist
        if (usedFor == 'SOCIAL_NEEDS') {
            hashlist = '#Social-Innovation';
        } else if (usedFor == 'PERSONAL_NEEDS') {
            hashlist = '#Personal-Needs';
        } else if (usedFor == 'IMPACT'){
            hashlist = '#Impact';
        } else if (usedFor == 'PASSION'){
            hashlist = '#Passion';
        }
        (fundRaisedBy && fundRaisedBy != 'null') ? hashlist = hashlist + ', #'+getStringCapitalise(fundRaisedBy) : ' ' ;
        (category && category != 'null') ? hashlist = hashlist + ', #'+getStringCapitalise(category.toString()) : ' ' ;
        if (currentEnv == 'development' || currentEnv == 'test' || currentEnv == 'staging' || currentEnv == 'production'){
            (country != 'null' && country != null && country != '') ? hashlist = hashlist + ', #'+country : ' ' ;
        }
        (city && city != '') ? hashlist = hashlist + ', #'+city : ' ' ;

        if (project.hashtags){
            def remainingList
            def hashtagsList = project.hashtags.split(',');
            hashtagsList = hashtagsList.collect { it.trim() }
            if (hashtagsList.size() > 5){
                for (int i=5; i<hashtagsList.size(); i++){
                    remainingList = (i == 5) ? hashtagsList[i] : remainingList + ', ' + hashtagsList[i];
                }
                hashlist = hashlist + ', ' + remainingList;
            }
        }

        project.hashtags = hashlist

        project.impactNumber = 0;
        /*project.impactAmount = 0;*/

        project.save();
    }

    def saveRecipientAndHashTags(def params){
        Project project = Project.get(params.projectId)
        project.fundsRecievedBy = params.recipient

        def category = project.category
        def country = (project.beneficiary.country) ? getCountryValue(project.beneficiary.country) : null;
        def usedFor = project.usedFor
        def fundRaisedBy = (params.recipient) ? params.recipient : null;
        def city = project.beneficiary.city
        def currentEnv = getCurrentEnvironment()
        def hashlist
        if (usedFor == 'SOCIAL_NEEDS') {
            hashlist = '#Social-Innovation';
        } else if (usedFor == 'PERSONAL_NEEDS') {
            hashlist = '#Personal-Needs';
        } else if (usedFor == 'IMPACT'){
            hashlist = '#Impact';
        } else if (usedFor == 'PASSION'){
            hashlist = '#Passion';
        }
        (fundRaisedBy && fundRaisedBy != 'null') ? hashlist = hashlist + ', #'+getStringCapitalise(fundRaisedBy) : ' ' ;
        (category && category != 'null') ? hashlist = hashlist + ', #'+getStringCapitalise(category.toString()) : ' ' ;
        if (currentEnv == 'development' || currentEnv == 'test' || currentEnv == 'staging' || currentEnv == 'production'){
            (country != 'null' && country != null && country != '') ? hashlist = hashlist + ', #'+country : ' ' ;
        }
        (city && city != '') ? hashlist = hashlist + ', #'+city : ' ' ;
        
        if (project.hashtags){
            def remainingList
            def hashtagsList = project.hashtags.split(',');
            hashtagsList = hashtagsList.collect { it.trim() }
            if (hashtagsList.size() > 5){
                for (int i=5; i<hashtagsList.size(); i++){
                    remainingList = (i == 5) ? hashtagsList[i] : remainingList + ', ' + hashtagsList[i];
                }
                hashlist = hashlist + ', ' + remainingList;
            }
        }

        project.hashtags = hashlist
        project.save();
    }
    
    def getCityAndHashTagsSaved(def params){
        Project project = Project.get(params.projectId)
        project.beneficiary.city = params.city

        def category = project.category
        def country = (project.beneficiary.country) ? getCountryValue(project.beneficiary.country) : null;
        def usedFor = project.usedFor
        def fundRaisedBy = project.fundsRecievedBy
        def city = project.beneficiary.city
        def currentEnv = getCurrentEnvironment()
        def hashlist
        if (usedFor == 'SOCIAL_NEEDS') {
            hashlist = '#Social-Innovation';
        } else if (usedFor == 'PERSONAL_NEEDS') {
            hashlist = '#Personal-Needs';
        } else if (usedFor == 'IMPACT'){
            hashlist = '#Impact';
        } else if (usedFor == 'PASSION'){
            hashlist = '#Passion';
        }
        (fundRaisedBy && fundRaisedBy != 'null') ? hashlist = hashlist + ', #'+getStringCapitalise(fundRaisedBy) : ' ' ;
        (category && category != 'null') ? hashlist = hashlist + ', #'+getStringCapitalise(category.toString()) : ' ' ;
        if (currentEnv == 'development' || currentEnv == 'test' || currentEnv == 'staging' || currentEnv == 'production'){
            (country != 'null' && country != null && country != '') ? hashlist = hashlist + ', #'+country : ' ' ;
        }
        (city && city != '') ? hashlist = hashlist + ', #'+city : ' ' ;
        
        if (project.hashtags){
            def remainingList
            def hashtagsList = project.hashtags.split(',');
            hashtagsList = hashtagsList.collect { it.trim() }
            if (hashtagsList.size() > 5){
                for (int i=5; i<hashtagsList.size(); i++){
                    remainingList = (i == 5) ? hashtagsList[i] : remainingList + ', ' + hashtagsList[i];
                }
                hashlist = hashlist + ', ' + remainingList;
            }
        }

        project.hashtags = hashlist
        project.save();
    }

    def getStringCapitalise(String string){
        if (string == 'CIVIC_NEEDS'){
            return 'Civic-Needs';
        } else if (string == 'NON_PROFITS'){
            return 'Non-Profits';
        } else if (string == 'SOCIAL_INNOVATION'){
            return 'Social-Innovation';
        } else if (string == 'NON-PROFIT'){
            return 'Non-Profit';
        } else if (string == 'NGO'){
            return 'NGO';
        } else {
            return string.capitalize();
        }
    }

    def getUsedForAndHashTagsSaved(def params){
        Project project = Project.get(params.projectId)
        project.usedFor = params.usedFor

        def category = project.category
        def country = (project.beneficiary.country) ? getCountryValue(project.beneficiary.country) : null;
        def usedFor = params.usedFor
        def fundRaisedBy = project.fundsRecievedBy
        def city = project.beneficiary.city
        def currentEnv = getCurrentEnvironment()
        def hashlist
        if (usedFor == 'SOCIAL_NEEDS') {
            hashlist = '#Social-Innovation';
        } else if (usedFor == 'PERSONAL_NEEDS') {
            hashlist = '#Personal-Needs';
        } else if (usedFor == 'IMPACT'){
            hashlist = '#Impact';
        } else if (usedFor == 'PASSION'){
            hashlist = '#Passion';
        }
        (fundRaisedBy && fundRaisedBy != 'null') ? hashlist = hashlist + ', #'+getStringCapitalise(fundRaisedBy) : ' ' ;
        (category && category != 'null') ? hashlist = hashlist + ', #'+getStringCapitalise(category.toString()) : ' ' ;
        if (currentEnv == 'development' || currentEnv == 'test' || currentEnv == 'staging' || currentEnv == 'production'){
            (country != 'null' && country != null && country != '') ? hashlist = hashlist + ', #'+country : ' ' ;
        }
        (city && city != '') ? hashlist = hashlist + ', #'+city : ' ' ;
        
        if (project.hashtags){
            def remainingList
            def hashtagsList = project.hashtags.split(',');
            hashtagsList = hashtagsList.collect { it.trim() }
            if (hashtagsList.size() > 5){
                for (int i=5; i<hashtagsList.size(); i++){
                    remainingList = (i == 5) ? hashtagsList[i] : remainingList + ', ' + hashtagsList[i];
                }
                hashlist = hashlist + ', ' + remainingList;
            }
        }

        project.hashtags = hashlist
        project.save();
    }
    
    def autoSaveCountryAndHashTags(def params){
        Project project = Project.get(params.projectId)
        project.beneficiary.country = (params.country && params.country != 'null' && params.country != '') ? getCountryValue(params.country) : null;

        def category = project.category
        def country = (params.country) ? getCountryValue(params.country) : null;
        def usedFor = project.usedFor
        def fundRaisedBy = project.fundsRecievedBy
        def city = project.beneficiary.city
        def hashlist
        if (usedFor == 'SOCIAL_NEEDS') {
            hashlist = '#Social-Innovation';
        } else if (usedFor == 'PERSONAL_NEEDS') {
            hashlist = '#Personal-Needs';
        } else if (usedFor == 'IMPACT'){
            hashlist = '#Impact';
        } else if (usedFor == 'PASSION'){
            hashlist = '#Passion';
        }
        (fundRaisedBy && fundRaisedBy != 'null') ? hashlist = hashlist + ', #'+getStringCapitalise(fundRaisedBy) : ' ' ;
        (category && category != 'null') ? hashlist = hashlist + ', #'+getStringCapitalise(category.toString()) : ' ' ;
        (country != 'null' && country != null && country != '') ? hashlist = hashlist + ', #'+country : ' ' ;
        (city && city != '') ? hashlist = hashlist + ', #'+city : ' ' ;

        if (project.hashtags){
            def remainingList
            def hashtagsList = project.hashtags.split(',');
            hashtagsList = hashtagsList.collect { it.trim() }
            if (hashtagsList.size() > 5){
                for (int i=5; i<hashtagsList.size(); i++){
                    remainingList = (i == 5) ? hashtagsList[i] : remainingList + ', ' + hashtagsList[i];
                }
                hashlist = hashlist + ', ' + remainingList;
            }
        }

        project.hashtags = hashlist
        project.save();
    }

    def getHashTags(def hashtags) {
        if (hashtags) {
            List hashtagsList = hashtags.split(',')
            hashtagsList = hashtagsList.collect { it.trim() }
            String firstFiveHashTags
            String remainingHashTags
            if (hashtagsList.size() > 5){
                for(int i=0;i<hashtagsList.size();i++){
                    if (i < 5){
                        firstFiveHashTags = (i==0) ? hashtagsList[i] :  firstFiveHashTags + ', ' + hashtagsList[i];
                    } else {
                        remainingHashTags = (i==5) ? hashtagsList[i] : remainingHashTags + ', ' + hashtagsList[i]
                    }
                }
            } else {
                firstFiveHashTags = hashtags
                remainingHashTags = null
            }
            return [firstFiveHashTags:firstFiveHashTags, remainingHashTags:remainingHashTags]
        } else {
            return [firstFiveHashTags:null, remainingHashTags:null]
        }
    }

    def getHashTagsTabs(def hashtags) {
        if (hashtags){
            List hashtagsList = hashtags.split(',')
            hashtagsList = hashtagsList.collect { it.trim() }
            String firstFiveHashTags
            String remainingHashTags
            if (hashtagsList.size() > 3){
                for(int i=0;i<hashtagsList.size();i++){
                    if (i < 3){
                        firstFiveHashTags = (i==0) ? hashtagsList[i] :  firstFiveHashTags + ', ' + hashtagsList[i];
                    } else {
                        remainingHashTags = (i==3) ? hashtagsList[i] : remainingHashTags + ', ' + hashtagsList[i]
                    }
                }
            } else {
                firstFiveHashTags = hashtags
                remainingHashTags = null
            }
            return [firstFiveHashTags:firstFiveHashTags, remainingHashTags:remainingHashTags]
        } else {
            return [firstFiveHashTags:null, remainingHashTags:null]
        }
    }
    
    def getHashTagsForCampaign(def hashtags) {
        if (hashtags){
            List hashtagsList = []
            hashtagsList = hashtags.split(',')
            hashtagsList = hashtagsList.collect { it.trim() }
            
            List firstFiveHashtag = []
            List firstThreeHashtag = []
            List remainingHashTags = []
            List remainingHashTagsTab = []
            
            if (hashtagsList.size() > 5) {
                firstFiveHashtag = hashtagsList.subList(0, 5)
                remainingHashTags = hashtagsList.subList(5, hashtagsList.size())
            } else {
                firstFiveHashtag = hashtagsList
            }
            
            if (hashtagsList.size() > 3) {
                firstThreeHashtag = hashtagsList.subList(0, 3)
                remainingHashTagsTab = hashtagsList.subList(3, hashtagsList.size())
            } else {
                firstThreeHashtag = hashtagsList
            }
            
            return [firstFiveHashtag: firstFiveHashtag, remainingHashTags: remainingHashTags, firstThreeHashtag: firstThreeHashtag, 
                    remainingHashTagsTab: remainingHashTagsTab, hashtagsList: hashtagsList]
        } else {
            return [firstFiveHashtag: [], remainingHashTags: [], firstThreeHashtag: [], remainingHashTagsTab: [], hashtagsList: [] ]
        }
    }
    
    def getReasonsToFundFromProject(Project project){
        return ReasonsToFund.findByProject(project)
    }
    
    def getFundRaisedByPartner(User user) {
        def environment = getCurrentEnvironment();
        def campaigns = getAllProjectByUser(user, environment)
        def projectAdmins = getProjectAdminEmail(user)
        def teams = getEnabledAndValidatedTeam(user)
        def totalprojects = getProjects(campaigns, projectAdmins, teams, environment)
        
        def raised = getTotalFundRaisedByUser(campaigns)
        return [totalprojects: totalprojects, raised: raised]
    }
    
    def makeContributorsUser(){
        User user, anonymousUser
        def password
        anonymousUser = User.findByUsername('anonymous@example.com')
        List contributions = Contribution.findAllWhere(user:anonymousUser, active: true);
        contributions.each{ contribution->
            if (contribution.contributorEmail && contribution.contributorName){
                user = User.findByEmail(contribution.contributorEmail)
                if (user) {
                    contribution.user = user
                    contribution.save();
                } else {
                    password = getAlphaNumbericRandomUrl()
                    user = new User(
                        firstName : contribution.contributorName,
                        username : contribution.contributorEmail,
                        email : contribution.contributorEmail,
                        password : password
                    ).save(failOnError:true)
                    contribution.user = user
                    contribution.save();
                    mandrillService.sendEmailToContributors(contribution, password)
                }
            }
        }
    }
    
    def createUserForNonRegisteredContributors(String contributorFirstName, String contributorEmail1, String contributorLastName){
        def contributorEmail = contributorEmail1.trim()
        def password = getAlphaNumbericRandomUrl()
        User user = new User(
            firstName : contributorFirstName,
            lastName : contributorLastName,
            username : contributorEmail,
            email : contributorEmail,
            password : password,
            confirmCode : UUID.randomUUID().toString()
        ).save(failOnError:true)
        
        userService.createUserRole(user, roleService)
        
        return [user:user, password:password]
    }
    
    def getDataFromImportedCSV(def file, def user){
        List contactList =[]
        InputStream is = file?.getInputStream()
        
        is.splitEachLine(',') {
            it.findAll{
                //Pattern matching to match email
                def matcher = (it ==~ /[+a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}/) 
                if(matcher){
                    contactList.add(it+' ')
                }
            }
        }
        def filterList = contactList.toString().replace('[','').replace(']','')
        def socialContact  = SocialContacts.findByUser(user)
        if(socialContact){
            socialAuthService.setSocailContactsByUser(socialContact ,filterList, 'csv')
        }else{
            new SocialContacts(constantContact:null, gmail:null, mailchimp:null, facebook:null, csvContact:filterList, user:user).save(failOnError: true)
        }
        return filterList
    }
    
    def getFilterGmailContacts(def filterList, def email){
        List gmailContacts = []

        filterList.each {
           it.each{
              if(it != email){
                  gmailContacts.add(it)
              }      
            }
         }
         return gmailContacts.toString().replace('[','').replace(']','')
    }
    
    def sendEmailOnValidation(Project project) {
        def currentEnv = getCurrentEnvironment()
		def country_code = project.country.countryCode
		
        def campaigns = getCampaignsByCategory(project.category)
        List emails = getBulkEmailsforCampaigns(campaigns)
        mandrillService.sendEmailOnValidation(currentEnv, emails, project,country_code)
    }
    
    def getCampaignsByCategory(def category) {
        return Project.findAllWhere(category: category, validated: true, rejected: false, inactive: false)
    }
    
    def isTitleUnique(def title, def projectId){
        def projectList = Project.findAllWhere(rejected:false, inactive:false, title:title)
        Project project = Project.get(projectId)
        Boolean status = true;
        
        projectList.each{
            if (it.title.equalsIgnoreCase(title)){
                if (it != project){
                    status = false
                }
            }
        }
        return status;
    }
    
    def getBulkEmailsforCampaigns(def campaigns) {
        List emails = []
        
        List teams = []
        List supporters = []
        List contributors = []
        
        def campaignsOwnerEmail = campaigns.user.email
        
        String supportersEmail
        String fundRaiserEmail
        String contributorsEmail
        
        campaignsOwnerEmail.each { it-> 
            if (it != null && (!emails.contains(it))) {
                emails.add(it)
            }
        }
        
        campaigns.each { campaign ->
            teams = campaign.teams
            teams.each { team ->
                fundRaiserEmail = team.user.email
                if (fundRaiserEmail != null && (!emails.contains(fundRaiserEmail))) {
                    emails.add(fundRaiserEmail)
                }
            }
            
            supporters = campaign.supporters
            supporters.each { supporter ->
                supportersEmail = supporter.user.email
                if (supportersEmail != null && (!emails.contains(supportersEmail))) {
                    emails.add(supportersEmail)
                }
            }
            
            contributors = campaign.contributions
            contributors.each { contribution ->
                contributorsEmail = contribution.contributorEmail
                if (contributorsEmail != null && (!emails.contains(contributorsEmail))) {
                    emails.add(contributorsEmail)
                }
            }
            
        }
        return emails
    }

    def getAllProjectByUserHavingContribution(User user , def country_code, def params){
        List activeProjects=[]
        List endedProjects=[]
        List sortedProjects = []
        def finalList
        boolean ended
        
        boolean doProjectHaveAnyContribution;

        if ('in'.equalsIgnoreCase(country_code)) {
            def projects = Project.findAllWhere(user:user, validated:true, rejected:false, inactive:false,payuStatus:true, offeringTaxReciept:true)
            projects.each { project->
                
                doProjectHaveAnyContribution = false;
                
                if (project.contributions && project.offeringTaxReciept) {
                    
                    project.contributions?.each { contribution ->
                        if (contribution.panNumber != null) {
                            doProjectHaveAnyContribution = true
                        }
                    }
                    
                    if (doProjectHaveAnyContribution) {
                        ended = isProjectDeadlineCrossed(project);
                        if (ended) {
                            endedProjects.add(project)
                        } else if(project.validated==true && project.inactive==false){
                            activeProjects.add(project)
                        }
                    }
                    
                }
                
            }
        } else {
            def projects= Project.findAllWhere(user:user, validated:true, rejected:false, inactive:false, payuStatus:false, offeringTaxReciept:true)
            projects.each { project->
                if (project.contributions && project.offeringTaxReciept){
                    ended = isProjectDeadlineCrossed(project)
                    if (ended) {
                        endedProjects.add(project)
                    } else if(project.validated==true && project.inactive==false){
                        activeProjects.add(project)
                    }
                }
            }
        }

        sortedProjects = activeProjects.sort{contributionService.getPercentageContributionForProject(it)}
        finalList = sortedProjects.reverse() + endedProjects.reverse()
        
        def projects = []
        if (!finalList.isEmpty()){
            def offset = params.offset ? params.int('offset') : 0
            def max = 6
            def count = finalList.size()
            def maxrange

            if(offset + max <= count) {
                maxrange = offset + max
            } else {
                maxrange = offset + (count - offset)
            }
            projects = finalList.reverse().subList(offset, maxrange)
        }
        return ['totalProjects' : finalList, 'projects' : projects]
    }

    def doProjectHaveContribution(def vanityTitle){
        Project project = getProjectFromVanityTitle(vanityTitle)
        if (project.contributions){
            return true
        } else {
            return false
        }
    }
    
    def sendTaxReceiptToContributors(def params){
        def idList = params.list.split(",");
        idList = idList.collect { it.trim() }
        mandrillService.sendTaxReceiptToContributors(idList);
    }
    
    def getCitrusTransactionDetails(def secret_key, def request, def session, def fundraiser) {
        
        String data="";
        String txnId=request.getParameter("TxId");
        String txnStatus=request.getParameter("TxStatus");
        
        String amount=request.getParameter("amount");
        String pgTxnId=request.getParameter("pgTxnNo");
        
        String issuerRefNo=request.getParameter("issuerRefNo");
        String authIdCode=request.getParameter("authIdCode");
        
        String firstName=request.getParameter("firstName");
        String lastName=request.getParameter("lastName");
        
        String pgRespCode=request.getParameter("pgRespCode");
        String zipCode=request.getParameter("addressZip");
        
        String resSignature=request.getParameter("signature");
        
        //Binding all required parameters in one string (i.e. data)
        if (txnId != null) {
            data += txnId;
        }
        if (txnStatus != null) {
            data += txnStatus;
        }
        if (amount != null) {
            data += amount;
        }
        if (pgTxnId != null) {
            data += pgTxnId;
        }
        if (issuerRefNo != null) {
            data += issuerRefNo;
        }
        if (authIdCode != null) {
            data += authIdCode;
        }
        if (firstName != null) {
            data += firstName;
        }
        if (lastName != null) {
            data += lastName;
        }
        if (pgRespCode != null) {
            data += pgRespCode;
        }
        if (zipCode != null) {
            data += zipCode;
        }
        
        javax.crypto.Mac mac = javax.crypto.Mac.getInstance("HmacSHA1");
        mac.init(new javax.crypto.spec.SecretKeySpec(secret_key.getBytes(), "HmacSHA1"));
        byte[] hexBytes = new org.apache.commons.codec.binary.Hex().encode(mac.doFinal(data.getBytes()));
        String signature = new String(hexBytes, "UTF-8");

        boolean flag = true;
        if (resSignature !=null && !resSignature.equalsIgnoreCase("") && !signature.equalsIgnoreCase(resSignature)) {
            flag = false;
        }
        
        
        if (flag && 'SUCCESS'.equalsIgnoreCase(txnStatus)) {
            def contributionId = createTransactionIdForCitrus(txnId, request, session, fundraiser, issuerRefNo)
            return contributionId
            
        } else {
            return null
        }
    }
    
    def createTransactionIdForCitrus(def transactionId, def request, def session, def fundraiser, def issuerRefNo) {
        
        def amount    = Double.parseDouble(request.getParameter('amount'))
        def marketplaceTxId = request.getParameter('marketplaceTxId');
        
        def emailId   = session.getAttribute('shippingEmail')
        def twitter   = session.getAttribute('twitterHandle')
        def custom    = session.getAttribute('shippingCustom')
        def userId    = session.getAttribute('tempValue')
        def anonymous = session.getAttribute('anonymous')
        def address   = session.getAttribute('address')
        def fr        = session.getAttribute('fr')
        def panNumber = session.getAttribute('panNumber')
        
        Project project  = Project.get(session.getAttribute('campaignId'))
        Reward reward    = rewardService.getRewardById(session.getAttribute('rewardId'));
        User contributor = userService.getUserForContributors(request.getParameter('email') , session.getAttribute('userId'))
        
        if (contributor == null) {
            contributor = userService.getUserByUsername('anonymous@example.com')
        }
        
        def shippingDetail = checkShippingDetail(emailId,twitter,address, custom)
        def name
        def username

        if (userId == null || userId == 'null' || userId.isAllWhitespace()) {
            name = request.getParameter("firstName") +" "+ request.getParameter("lastName");
            username = request.getParameter('email')
        } else {
            def orgUser = User.get(userId)
            name = orgUser.firstName + " " + orgUser.lastName
            username = orgUser.email
        }
        
        
        String splitId = getSplitIdForTransactionId(marketplaceTxId, project.sellerId, amount, issuerRefNo)

        Contribution contribution = new Contribution(
            date             : new Date(),
            user             : contributor,
            reward           : reward,
            amount           : amount,
            email            : shippingDetail.emailid,
            twitterHandle    : shippingDetail.twitter,
            custom           : shippingDetail.custom,
            contributorName  : name,
            contributorEmail : username,
            physicalAddress  : shippingDetail.address,
            currency         : 'INR',
            panNumber        : panNumber,
            merchantTxId     : marketplaceTxId,
            splitRef         : issuerRefNo,
            splitId          : splitId,
			active           : true
        )
        
        project.addToContributions(contribution).save(failOnError: true)
         
        Team team = Team.findByUserAndProject(fundraiser,project)
        if (team) {
            contribution.fundRaiser = fundraiser.username
            team.addToContributions(contribution).save(failOnError: true)
        }
		def country_code = project.country.countryCode
        contribution.isAnonymous = anonymous.toBoolean()
        
        if (project.payuStatus && project.contributions.size() == 1) {
            mandrillService.sendEmailToCampaignOwner(project, contribution,country_code) //Send Email to Campaign Owner when first contribution is done for INR
        }
         
        userService.contributionEmailToOwnerOrTeam(fundraiser, project, contribution)
        
        def totalContribution = contributionService.getTotalContributionForProject(project)
        
        if (totalContribution >= project.amount) {
            
            if(project.send_mail == false) {
                List contributorEmails = []
                def contributors = contributionService.getTotalContributors(project)
                contributors.each {
                    def user = User.get(it)
                    if (user.email != 'anonymous@example.com' && !contributorEmails.contains(user.email)) {
                        contributorEmails.add(user.email)
                        mandrillService.sendContributorEmail(user, project)
                    }
                }
                
                def beneficiaryId = getBeneficiaryId(project)
                def beneficiary = Beneficiary.get(beneficiaryId)
                def user = User.findByEmail(beneficiary.email)
                
                if (user) {
                    mandrillService.sendBeneficiaryEmail(user,getCountryCodeForCurrentEnv(request))
                }
                
                project.send_mail = true
            }
            
        }
        
        Transaction transaction = new Transaction(
            transactionId: transactionId,
            user         : contributor,
            project      : project,
            contribution : contribution,
            currency     : 'INR'
        )
        
        transaction.save(failOnError: true)
        
        return contribution.id
    }
    
    def getSplitIdForTransactionId(String transactionId, String sellerId, def amount, def issuerRefNo) {
        def citrusBaseUrl = grailsApplication.config.crowdera.CITRUS.SPLITPAY_URL
        def url = citrusBaseUrl +"/marketplace/split/"
        
        HttpClient httpclient = new DefaultHttpClient()
        HttpPost httppost = new HttpPost(url)
        def trans_id = transactionId
        def seller_id = sellerId
        def merchant_split_ref = issuerRefNo
        def split_amount = amount * 0.955
        def fee_amount = amount * 0.045
        def auto_payout = 1

        StringEntity input = new StringEntity("{\"trans_id\":${trans_id},\"seller_id\":${seller_id},\"merchant_split_ref\":\"${merchant_split_ref}\",\"split_amount\":${split_amount},\"fee_amount\":${fee_amount},\"auto_payout\":${auto_payout}}")
        input.setContentType("application/json")
        httppost.setEntity(input)

        def auth_token = contributionService.getAccessTokenForCitrus()
        httppost.setHeader("auth_token","${auth_token}")
        HttpResponse httpres = httpclient.execute(httppost)
        def splitId
        
        int status = httpres.getStatusLine().getStatusCode()
        if (status == 200){
            HttpEntity entity = httpres.getEntity()
            if (entity != null){
                def jsonString = EntityUtils.toString(entity)
                def slurper = new JsonSlurper()
                def json = slurper.parseText(jsonString)
                splitId = json.split_id
            }
        }
		
        return splitId
    }
    
    def setCitrusInfo(def session, def params) {
        session['rewardId']     = params.rewardId
        session['campaignId']   = params.campaignId
        session['userId']       = params.userId
        session['fr']           = params.fr
        session['anonymous']    = params.anonymous
        session['tempValue']    = params.tempValue
        
        session['email']        = params.email
        session['addressLine1'] = params.addressLine1
        session['addressLine2'] = params.addressLine2
        session['city']         = params.city
        session['zip']          = params.zip
        
        session['shippingEmail'] = params.shippingEmail
        session['twitterHandle'] = params.twitterHandle
        session['shippingCustom'] = params.shippingCustom
        session['projectTitle'] = params.projectTitle
        session['panNumber'] = params.panNumber
        def address = getAddress(params)
        session['address'] = address
    }
    
    
    public List<Project> getCitrusCampaigns() {
        def criteria = Project.createCriteria();
        
        def result = criteria.list{
            resultTransformer(org.hibernate.transform.Transformers.ALIAS_TO_ENTITY_MAP)
            createAlias('user', 'user')
            projections {
                property('id', 'id')
                property('title', 'title')
                property('amount', 'amount')
                property('citrusEmail', 'citrusEmail')
                property('description', 'description')
                property('user.username', 'username')
                property('days', 'days')
                property('created', 'created')
                property('sellerId', 'sellerId')
            }
            eq("payuStatus", true)
            eq("validated", true)
            eq("draft", false)
            eq("rejected", false)
            eq("inactive", false)
			isNotNull("citrusEmail")
        }
        
        def raised;
        def daysleft;
        List<Project> projectList = new ArrayList<>();
        
        result.each{  project ->
            if (project.citrusEmail) {
                raised = Contribution.createCriteria().get {
                    createAlias('project', 'project')
                    projections {
                        sum "amount"
                    }
                    eq("project.id", project.id)
                }
                
                if (project.days > (Calendar.instance - project.created.toCalendar()) ) {
                    daysleft = project.days - (Calendar.instance - project.created.toCalendar());
                } else {
                    daysleft =  (Calendar.instance - project.created.toCalendar()) - project.days;
                }
                project["daysleft"] = daysleft;
                project["raised"] = raised;
                projectList.add(project);
            }
        }
        return projectList;
        
    }
    
    
    List<Contribution> getContributionsListByProjectId(String projectId) {
        List<Contribution> contributionList = new ArrayList<>();
        contributionList = Contribution.createCriteria().list{ 
            					eq("project.id", projectId)
								eq("currency", "INR")
							}
    }
    
	
    StringBuilder getBuildURL(String pkey, String title, String name,String country_code) {
        
        StringBuilder builder = new StringBuilder()
        
        if('manage'.equalsIgnoreCase(pkey)){
            
            builder.append(grailsApplication.config.crowdera.BASE_URL)
			.append(country_code)
            .append("/campaign/managecampaign/")
            .append(title)
            
        }else if('edit'.equalsIgnoreCase(pkey)){
        
            builder.append(grailsApplication.config.crowdera.BASE_URL)
			.append(country_code)
            .append("/campaign/edit/")
            .append(title)
            
        }else if('usrPrfl'.equalsIgnoreCase(pkey)){
        
            builder.append(grailsApplication.config.crowdera.BASE_URL)
			.append(country_code)
            .append("/campaigns/")
            .append(title).append("#contributions")
            
        }else{
        
            builder.append(grailsApplication.config.crowdera.BASE_URL)
			.append(country_code)
            .append("/campaigns/")
            .append(title+"/").append(name)
            
        }
        
        return builder
    }
    
    def setCampaignActive(Project project, String status){
        if(project){
            switch(status){
                case 'deleted':
                    project.inactive=false
                break;
                case 'rejected':
                    project.rejected=false
                break;
            }
            return true
        }else{
            return false
        }
     }
    
    def setHomePageCarouselImage(String imageUrl, String imageName, String currentEnv){
        
        String environment = null
        
        if('USA'.equalsIgnoreCase(currentEnv) || 'INDIA'.equalsIgnoreCase(currentEnv) || 'development'.equalsIgnoreCase(currentEnv) || 'production'.equalsIgnoreCase(currentEnv) || 'staging'.equalsIgnoreCase(currentEnv) || 'test'.equalsIgnoreCase(currentEnv)){
            
            environment = 'production'
            
        }
        
        HomePageCarousel carousel = new HomePageCarousel()
        carousel.setImageUrl(imageUrl)
        carousel.setCurrentEnv(environment)
        carousel.setImageName(imageName)
        
        if(carousel.save()){
            return true
        }
        
        return false
    }
    
    def getHomePageCarouselImage(String currentEnv, String data){
        
        String environment = null
        def carousel
        
        if('USA'.equalsIgnoreCase(currentEnv) || 'INDIA'.equalsIgnoreCase(currentEnv) || 'development'.equalsIgnoreCase(currentEnv) || 'production'.equalsIgnoreCase(currentEnv) || 'staging'.equalsIgnoreCase(currentEnv) || 'test'.equalsIgnoreCase(currentEnv)){
            
            environment = 'production'
            
        }
        
        if("link".equalsIgnoreCase(data)){
            
            carousel = HomePageCarousel.findAllByCurrentEnv(environment)?.imageUrl
            
        }else if('name'.equalsIgnoreCase(data)){
        
            carousel= HomePageCarousel.findAllByCurrentEnv(environment)?.imageName
        }
        
        return carousel
    }
    
    
    def deleteHomeCarouselImage(String imageName, String currentEnv){
        
        String environment = null
        
        if('USA'.equalsIgnoreCase(currentEnv) ||'INDIA'.equalsIgnoreCase(currentEnv) || 'development'.equalsIgnoreCase(currentEnv) || 'production'.equalsIgnoreCase(currentEnv) || 'staging'.equalsIgnoreCase(currentEnv) || 'test'.equalsIgnoreCase(currentEnv)){
            
            environment = 'production'
            
        }
        
        if(imageName){
            
           def deleteImage = HomePageCarousel.findByImageNameAndCurrentEnv(imageName, environment)
           deleteImage.delete()
           return true
        }
        
        return false
        
    }
    
    def updateHomeCarouselImage(String oldImage,String newImage, String imageUrl, String currentEnv){
        
        String environment = null
        
        if('USA'.equalsIgnoreCase(currentEnv) || 'INDIA'.equalsIgnoreCase(currentEnv) ||'development'.equalsIgnoreCase(currentEnv) || 'production'.equalsIgnoreCase(currentEnv) || 'staging'.equalsIgnoreCase(currentEnv) || 'test'.equalsIgnoreCase(currentEnv)){
            
            environment = 'production'
            
        }
        
        if(oldImage && imageUrl && environment){
            
            def carouselImage = HomePageCarousel.findByImageNameAndCurrentEnv(oldImage, environment)
            carouselImage.imageName = newImage
            carouselImage.imageUrl = imageUrl
            return true
        }
        
        return false
    }
    
    @Transactional
    def rescheduleUpdates() {
        def currentEnv = getCurrentEnvironment();
        List<ProjectUpdate> projectUpdates = []
        
        Session session = sessionFactory.getCurrentSession();
        projectUpdates = session.createSQLQuery("select * from project_update join project on project_update.project_id = project.id where islive=0 and is_scheduled=1")
                         .addEntity(ProjectUpdate.class).list();
        /*} else {
             projectUpdates = session.createSQLQuery("select * from project_update join project on project_update.project_id = project.id where payu_status=0 and islive=0 and is_scheduled=1")
                             .addEntity(ProjectUpdate.class).list();
        }*/
        
        projectUpdates.each { projectUpdate ->
            def cronExp
            def cronExpBeforeAnHour
            def isIntimationRequired = true
            Date scheduledate = projectUpdate.scheduledDate
            Date today = new Date();
            
            def calender = scheduledate.toCalendar()
            def calenderInstance = today.toCalendar()
            def delay = scheduledate - today
            def month = calender[MONTH] + 1
            
            def hourDiff = calender[HOUR_OF_DAY] - calenderInstance[HOUR_OF_DAY]
            def minDiff = 0
            if (hourDiff == 0) {
                minDiff = calender[MINUTE] - calenderInstance[MINUTE]
            }
            
            // Cron Expression to schedule an Update
            cronExp = '0 '+calender[MINUTE]+' '+ calender[HOUR_OF_DAY] +' ' +calender[DATE] + ' '+ month + ' ? '+calender[YEAR]
            
            calender.set(Calendar.HOUR_OF_DAY , (calender.get(Calendar.HOUR_OF_DAY) - 1))
            
            if (delay > 0 ) {
                // Cron Expression to schedule an Update before an Hour
                cronExpBeforeAnHour = '0 '+calender[MINUTE]+' '+ calender[HOUR_OF_DAY] +' ' +calender[DATE] + ' '+ month + ' ? '+calender[YEAR]
                
            } else if (delay < 0) {
                projectUpdate.islive = true;
                projectUpdate.save();
                
            } else {
            
                if (hourDiff < 0 || (hourDiff == 0 && minDiff < 0)) {
                    projectUpdate.islive = true;
                    projectUpdate.save();
                    
                    //mandrillService.sendUpdateEmailsToContributors(projectUpdate.project, projectUpdate, projectUpdate.user, projectUpdate.title)
                } else if ((hourDiff == 0 && minDiff > 5) || hourDiff == 1 ) {
                    isIntimationRequired = false
                } else if (hourDiff >= 2)  {
                    isIntimationRequired = true
                    // Cron Expression to schedule an Update before an Hour
                    cronExpBeforeAnHour = '0 '+calender[MINUTE]+' '+ calender[HOUR_OF_DAY] +' ' +calender[DATE] + ' '+ month + ' ? '+calender[YEAR]
    
                } else {
                    isIntimationRequired = false
                }
            }
            if (projectUpdate.islive == false) {
                if (isIntimationRequired) {
                    SendUpdateLiveJob.schedule(cronExpBeforeAnHour, [id: projectUpdate.id, isIntimationRequired: true])
                }
                SendUpdateLiveJob.schedule(cronExp, [id: projectUpdate.id, isIntimationRequired: false])
            }
            
        }
    }
    
    @Transactional
    def bootstrap() {
        DateFormat dateFormat = new SimpleDateFormat("MM/dd/yyyy")

        User deepshikha = userService.bootstrapDeepshikha()
        User sampleUser = User.findByUsername('user@example.com')

        new Project(
                created: dateFormat.parse("01/15/2014"),
                amount: 600,
                days: 600,
                //fundRaisingReason: Project.FundRaisingReason.TUITION_FEE,
                //fundRaisingFor: Project.FundRaisingFor.MYSELF,
                category: Project.Category.ENVIRONMENT,
                title: 'Machine Learning',
                description: 'Machine learning is going to change the world for ever.',
                videoUrl: 'www.youtube.com/watch?v=UzxYlbK2c7E',
                charitableId: 'd207de72-2023-11e0-a279-4061860da51d',
                organizationIconUrl: 'https://s3.amazonaws.com/crowdera/project-icon/organization-icon.jpg',
                organizationName: 'Stanford',
                webAddress: 'https://www.coursera.org/course/ml',
                story: 'Machine learning is a scientific discipline that deals with the construction and study of algorithms that can learn from data',
                validated: true,
                user: sampleUser,
                beneficiary: new Beneficiary()
        ).addToRewards(
                Reward.findById(1)
        ).addToRewards(
                Reward.findById(2)
        ).addToRewards(
                Reward.findById(3)
        ).addToRewards(
                Reward.findById(4)
        ).addToRewards(
                Reward.findById(5)
        ).addToRewards(
                Reward.findById(6)
        ).addToContributions(
                date: dateFormat.parse("01/16/2014"),
                user: sampleUser,
                reward: Reward.findById(3)
        ).addToContributions(
                date: dateFormat.parse("01/20/2014"),
                user: sampleUser,
                reward: Reward.findById(2)
		).addToImageUrl(
				url: 'https://1.bp.blogspot.com/-tn9GwuoC45w/TvtQvP6_UFI/AAAAAAAAAHI/ECpLGjyH6AI/s1600/machine_learning_course.png'
		).save(failOnError: true)

        new Project(
                created: dateFormat.parse("01/15/2014"),
                amount: 100,
                days: 15,
                //fundRaisingReason: Project.FundRaisingReason.VOCATIONAL_SCHOOL,
                //fundRaisingFor: Project.FundRaisingFor.OTHER,
                category: Project.Category.SOCIAL_INNOVATION,
                title: 'Cooperative dairy farming',
                description: 'Project to support rural people to raise money',
                videoUrl:'https://www.youtube.com/embed/W_lME-8P-Dk',
                charitableId:'d207de72-2023-11e0-a279-4061860da51d',
                organizationIconUrl:'https://s3.amazonaws.com/crowdera/project-icon/organization-icon-1.jpg',
                organizationName:'Mother Dairy',
                webAddress:'https://www.gocrowdera.com',
                story: 'These women are from extremely impoverished and  rural areas of Maharashtra, India. Their husbands are farm owners or workers who are dependent upon the monsoon season to cultivate their produce. Inflation and poverty is making their lives unpredictable, unstable and strenuous. These women want to help their families by getting trained in cooperative dairy farming by Deepshikha and start their micro business.',
                validated: true,
                user: deepshikha,
                beneficiary: new Beneficiary(
                    firstName: 'Anasuya',
                    email: 'info@deepshikha.org'
                )
        ).addToRewards(
                Reward.findById(1)
        ).addToRewards(
                Reward.findById(2)
        ).addToRewards(
                Reward.findById(3)
        ).addToRewards(
                Reward.findById(4)
        ).addToRewards(
                Reward.findById(5)
        ).addToRewards(
                Reward.findById(6)
        ).addToContributions(
                reward: Reward.findById(5),
                date: dateFormat.parse("01/16/2014"),
                user: sampleUser
        ).addToContributions(
                reward: Reward.findById(5),
                date: dateFormat.parse("01/17/2014"),
                user: sampleUser
        ).addToContributions(
                reward: Reward.findById(5),
                date: dateFormat.parse("01/20/2014"),
                user: sampleUser
        ).addToContributions(
                reward: Reward.findById(5),
                date: dateFormat.parse("01/22/2014"),
                user: sampleUser
		).addToImageUrl(
				url: 'https://s3.amazonaws.com/crowdera/project-images/Anusuya.png'
        ).save(failOnError: true)

        new Project(
                created: dateFormat.parse("01/15/2014"),
                amount: 100,
                days: 15,
                //fundRaisingReason: Project.FundRaisingReason.VOCATIONAL_SCHOOL,
                //fundRaisingFor: Project.FundRaisingFor.OTHER,
                category: Project.Category.SOCIAL_INNOVATION,
                title: 'Cooperative dairy farming',
                description: 'Project to support rural people to raise money',
                videoUrl:'https://www.youtube.com/embed/W_lME-8P-Dk',
                charitableId:'d207de72-2023-11e0-a279-4061860da51d',
                organizationIconUrl:'https://s3.amazonaws.com/crowdera/project-icon/organization-icon-2.jpg',
                organizationName:'Mother Dairy',
                webAddress:'https://www.gocrowdera.com',
                story: 'These women are from extremely impoverished and  rural areas of Maharashtra, India. Their husbands are farm owners or workers who are dependent upon the monsoon season to cultivate their produce. Inflation and poverty is making their lives unpredictable, unstable and strenuous. These women want to help their families by getting trained in cooperative dairy farming by Deepshikha and start their micro business.',
                validated: true,
                user: deepshikha,
                beneficiary: new Beneficiary(
                    firstName: 'Roshanbai',
                    email: 'info@deepshikha.org'
                )
        ).addToRewards(
                Reward.findById(1)
        ).addToRewards(
                Reward.findById(3)
        ).addToRewards(
                Reward.findById(5)
        ).addToRewards(
                Reward.findById(7)
        ).addToRewards(
                Reward.findById(9)
        ).addToRewards(
                Reward.findById(4)
        ).addToContributions(
                reward: Reward.findById(7),
                date: dateFormat.parse("01/23/2014"),
                user: sampleUser
		).addToImageUrl(
			url: 'https://s3.amazonaws.com/crowdera/project-images/Roshanbai.png'
        ).save(failOnError: true)

        new Project(
                created: dateFormat.parse("01/15/2014"),
                amount: 100,
                days: 15,
                //fundRaisingReason: Project.FundRaisingReason.VOCATIONAL_SCHOOL,
                //fundRaisingFor: Project.FundRaisingFor.OTHER,
                category: Project.Category.SOCIAL_INNOVATION,
                title: 'Cooperative dairy farming',
                description: 'Project to support rural people to raise money',
                videoUrl:'https://www.youtube.com/embed/W_lME-8P-Dk',
                charitableId:'d207de72-2023-11e0-a279-4061860da51d',
                organizationIconUrl:'https://s3.amazonaws.com/crowdera/project-icon/organization-icon.jpg',
                organizationName:'Mother Dairy',
                webAddress:'https://www.gocrowdera.com',
                story: 'These women are from extremely impoverished and  rural areas of Maharashtra, India. Their husbands are farm owners or workers who are dependent upon the monsoon season to cultivate their produce. Inflation and poverty is making their lives unpredictable, unstable and strenuous. These women want to help their families by getting trained in cooperative dairy farming by Deepshikha and start their micro business.',
                validated: true,
                user: deepshikha,
                beneficiary: new Beneficiary(
                    firstName: 'Vandana',
                    email: 'info@deepshikha.org'
                )
        ).addToRewards(
                Reward.findById(2)
        ).addToRewards(
                Reward.findById(3)
        ).addToRewards(
                Reward.findById(5)
        ).addToRewards(
                Reward.findById(7)
        ).addToRewards(
                Reward.findById(9)
        ).addToRewards(
                Reward.findById(10)
        ).addToContributions(
                reward: Reward.findById(10),
                date: dateFormat.parse("01/21/2014"),
                user: sampleUser
		).addToImageUrl(
				url: 'https://s3.amazonaws.com/crowdera/project-images/Vandana.png'
        ).save(failOnError: true)

        new Project(
                created: dateFormat.parse("01/15/2014"),
                amount: 100,
                days: 15,
                //fundRaisingReason: Project.FundRaisingReason.VOCATIONAL_SCHOOL,
                //fundRaisingFor: Project.FundRaisingFor.OTHER,
                category: Project.Category.SOCIAL_INNOVATION,
                title: 'Cooperative dairy farming',
                description: 'Project to support rural people to raise money',
                videoUrl:'https://www.youtube.com/embed/W_lME-8P-Dk',
                charitableId:'d207de72-2023-11e0-a279-4061860da51d',
                organizationIconUrl:'https://s3.amazonaws.com/crowdera/project-icon/organization-icon-1.jpg',
                organizationName:'Mother Dairy',
                webAddress:'https://www.gocrowdera.com',
                story: 'These women are from extremely impoverished and  rural areas of Maharashtra, India. Their husbands are farm owners or workers who are dependent upon the monsoon season to cultivate their produce. Inflation and poverty is making their lives unpredictable, unstable and strenuous. These women want to help their families by getting trained in cooperative dairy farming by Deepshikha and start their micro business.',
                validated: true,
                user: deepshikha,
                beneficiary: new Beneficiary(
                    firstName: 'Pushpa',
                    email: 'info@deepshikha.org'
                )
        ).addToRewards(
                Reward.findById(1)
        ).addToRewards(
                Reward.findById(4)
        ).addToRewards(
                Reward.findById(5)
        ).addToRewards(
                Reward.findById(6)
        ).addToRewards(
                Reward.findById(9)
        ).addToRewards(
                Reward.findById(10)
        ).addToContributions(
                reward: Reward.findById(9),
                date: dateFormat.parse("01/26/2014"),
                user: sampleUser
		).addToImageUrl(
				url: 'https://s3.amazonaws.com/crowdera/project-images/Pushpa.png'
        ).save(failOnError: true)

        new Project(
                created: dateFormat.parse("01/15/2014"),
                amount: 100,
                days: 15,
                //fundRaisingReason: Project.FundRaisingReason.VOCATIONAL_SCHOOL,
                //fundRaisingFor: Project.FundRaisingFor.OTHER,
                category: Project.Category.SOCIAL_INNOVATION,
                title: 'Cooperative dairy farming',
                description: 'Project to support rural people to raise money',
                videoUrl:'https://www.youtube.com/embed/W_lME-8P-Dk',
                charitableId:'d207de72-2023-11e0-a279-4061860da51d',
                organizationIconUrl:'https://s3.amazonaws.com/crowdera/project-icon/organization-icon-2.jpg',
                organizationName:'Mother Dairy',
                webAddress:'https://www.gocrowdera.com',
                story: 'These women are from extremely impoverished and  rural areas of Maharashtra, India. Their husbands are farm owners or workers who are dependent upon the monsoon season to cultivate their produce. Inflation and poverty is making their lives unpredictable, unstable and strenuous. These women want to help their families by getting trained in cooperative dairy farming by Deepshikha and start their micro business.',
                validated: true,
                user: deepshikha,
                beneficiary: new Beneficiary(
                    firstName: 'Sangita',
                    email: 'info@deepshikha.org'
                )
        ).addToRewards(
                Reward.findById(2)
        ).addToRewards(
                Reward.findById(3)
        ).addToRewards(
                Reward.findById(4)
        ).addToRewards(
                Reward.findById(5)
        ).addToRewards(
                Reward.findById(6)
        ).addToRewards(
                Reward.findById(7)
        ).addToContributions(
                reward: Reward.findById(5),
                date: dateFormat.parse("01/18/2014"),
                user: sampleUser
		).addToImageUrl(
				url: 'https://s3.amazonaws.com/crowdera/project-images/Sangita.png'
        ).save(failOnError: true)

        new Project(
                created: dateFormat.parse("01/15/2014"),
                amount: 100,
                days: 15,
                //fundRaisingReason: Project.FundRaisingReason.VOCATIONAL_SCHOOL,
                //fundRaisingFor: Project.FundRaisingFor.OTHER,
                category: Project.Category.SOCIAL_INNOVATION,
                title: 'Cooperative dairy farming',
                description: 'Project to support rural people to raise money',
                videoUrl:'https://www.youtube.com/embed/W_lME-8P-Dk',
                charitableId:'d207de72-2023-11e0-a279-4061860da51d',
                organizationIconUrl:'https://s3.amazonaws.com/crowdera/project-icon/organization-icon-2.jpg',
                organizationName:'Mother Dairy',
                webAddress:'https://www.gocrowdera.com',
                story: 'These women are from extremely impoverished and  rural areas of Maharashtra, India. Their husbands are farm owners or workers who are dependent upon the monsoon season to cultivate their produce. Inflation and poverty is making their lives unpredictable, unstable and strenuous. These women want to help their families by getting trained in cooperative dairy farming by Deepshikha and start their micro business.',
                validated: true,
                user: deepshikha,
                beneficiary: new Beneficiary(
                    firstName: 'Sunanda',
                    email: 'info@deepshikha.org'
                )
        ).addToRewards(
                Reward.findById(1)
        ).addToRewards(
                Reward.findById(2)
        ).addToRewards(
                Reward.findById(3)
        ).addToRewards(
                Reward.findById(4)
        ).addToRewards(
                Reward.findById(8)
        ).addToRewards(
                Reward.findById(10)
        ).addToContributions(
                reward: Reward.findById(4),
                date: dateFormat.parse("01/24/2014"),
                user: sampleUser
		).addToImageUrl(
				url: 'https://s3.amazonaws.com/crowdera/project-images/Sunanda.png'
        ).save(failOnError: true)

        new Project(
                created: dateFormat.parse("01/15/2014"),
                amount: 100,
                days: 15,
                //fundRaisingReason: Project.FundRaisingReason.VOCATIONAL_SCHOOL,
                //fundRaisingFor: Project.FundRaisingFor.OTHER,
                category: Project.Category.SOCIAL_INNOVATION,
                title: 'Cooperative dairy farming',
                description: 'Project to support rural people to raise money',
                videoUrl:'https://www.youtube.com/embed/W_lME-8P-Dk',
                charitableId:'d207de72-2023-11e0-a279-4061860da51d',
                organizationIconUrl:'https://s3.amazonaws.com/crowdera/project-icon/organization-icon-3.jpg',
                organizationName:'Mother Dairy',
                webAddress:'https://www.gocrowdera.com',
                story: 'These women are from extremely impoverished and  rural areas of Maharashtra, India. Their husbands are farm owners or workers who are dependent upon the monsoon season to cultivate their produce. Inflation and poverty is making their lives unpredictable, unstable and strenuous. These women want to help their families by getting trained in cooperative dairy farming by Deepshikha and start their micro business.',
                validated: true,
                user: deepshikha,
                beneficiary: new Beneficiary(
                    firstName: 'Tarabai',
                    email: 'info@deepshikha.org'
                )
        ).addToRewards(
                Reward.findById(1)
        ).addToRewards(
                Reward.findById(2)
        ).addToRewards(
                Reward.findById(3)
        ).addToRewards(
                Reward.findById(5)
        ).addToRewards(
                Reward.findById(8)
        ).addToRewards(
                Reward.findById(10)
        ).addToContributions(
                reward: Reward.findById(8),
                date: dateFormat.parse("01/29/2014"),
                user: sampleUser
		).addToImageUrl(
				url: 'https://s3.amazonaws.com/crowdera/project-images/Tarabai.png'
        ).save(failOnError: true)

        new Project(
                created: dateFormat.parse("01/15/2014"),
                amount: 100,
                days: 15,
                //fundRaisingReason: Project.FundRaisingReason.VOCATIONAL_SCHOOL,
                //fundRaisingFor: Project.FundRaisingFor.OTHER,
                category: Project.Category.SOCIAL_INNOVATION,
                title: 'Cooperative dairy farming',
                description: 'Project to support rural people to raise money',
                videoUrl:'https://www.youtube.com/embed/W_lME-8P-Dk',
                charitableId:'d207de72-2023-11e0-a279-4061860da51d',
                organizationIconUrl:'https://s3.amazonaws.com/crowdera/project-icon/organization-icon-1.jpg',
                organizationName:'Mother Dairy',
                webAddress:'https://www.gocrowdera.com',
                story: 'These women are from extremely impoverished and  rural areas of Maharashtra, India. Their husbands are farm owners or workers who are dependent upon the monsoon season to cultivate their produce. Inflation and poverty is making their lives unpredictable, unstable and strenuous. These women want to help their families by getting trained in cooperative dairy farming by Deepshikha and start their micro business.',
                validated: true,
                user: deepshikha,
                beneficiary: new Beneficiary(
                    firstName: 'Asha',
                    email: 'info@deepshikha.org'
                )
        ).addToRewards(
                Reward.findById(1)
        ).addToRewards(
                Reward.findById(2)
        ).addToRewards(
                Reward.findById(3)
        ).addToRewards(
                Reward.findById(4)
        ).addToRewards(
                Reward.findById(5)
        ).addToRewards(
                Reward.findById(6)
        ).addToContributions(
                reward: Reward.findById(4),
                date: dateFormat.parse("01/27/2014"),
                user: sampleUser
		).addToImageUrl(
				url: 'https://s3.amazonaws.com/crowdera/project-images/Asha.png'
        ).save(failOnError: true)

        new Project(
                created: dateFormat.parse("01/15/2014"),
                amount: 100,
                days: 15,
                //fundRaisingReason: Project.FundRaisingReason.VOCATIONAL_SCHOOL,
                //fundRaisingFor: Project.FundRaisingFor.OTHER,
                category: Project.Category.SOCIAL_INNOVATION,
                title: 'Cooperative dairy farming',
                description: 'Project to support rural people to raise money',
                videoUrl:'https://www.youtube.com/embed/W_lME-8P-Dk',
                charitableId:'d207de72-2023-11e0-a279-4061860da51d',
                organizationIconUrl:'https://s3.amazonaws.com/crowdera/project-icon/organization-icon-3.jpg',
                organizationName:'Mother Dairy',
                webAddress:'https://www.gocrowdera.com',
                story: 'These women are from extremely impoverished and  rural areas of Maharashtra, India. Their husbands are farm owners or workers who are dependent upon the monsoon season to cultivate their produce. Inflation and poverty is making their lives unpredictable, unstable and strenuous. These women want to help their families by getting trained in cooperative dairy farming by Deepshikha and start their micro business.',
                validated: true,
                user: deepshikha,
                beneficiary: new Beneficiary(
                    firstName: 'Sunita',
                    email: 'info@deepshikha.org'
                )
        ).addToRewards(
                Reward.findById(1)
        ).addToRewards(
                Reward.findById(2)
        ).addToRewards(
                Reward.findById(3)
        ).addToRewards(
                Reward.findById(4)
        ).addToRewards(
                Reward.findById(5)
        ).addToRewards(
                Reward.findById(6)
        ).addToContributions(
                reward: Reward.findById(5),
                date: dateFormat.parse("01/22/2014"),
                user: sampleUser
		).addToImageUrl(
				url: 'https://s3.amazonaws.com/crowdera/project-images/Sunita.png'
        ).save(failOnError: true)

        new Project(
                created: dateFormat.parse("01/15/2014"),
                amount: 100,
                days: 15,
                //fundRaisingReason: Project.FundRaisingReason.VOCATIONAL_SCHOOL,
                //fundRaisingFor: Project.FundRaisingFor.OTHER,
                category: Project.Category.SOCIAL_INNOVATION,
                title: 'Cooperative dairy farming',
                description: 'Project to support rural people to raise money',
                videoUrl:'https://www.youtube.com/embed/W_lME-8P-Dk',
                charitableId:'d207de72-2023-11e0-a279-4061860da51d',
                organizationIconUrl:'https://s3.amazonaws.com/crowdera/project-icon/organization-icon-1.jpg',
                organizationName:'Mother Dairy',
                webAddress:'https://www.gocrowdera.com',
                story: 'These women are from extremely impoverished and  rural areas of Maharashtra, India. Their husbands are farm owners or workers who are dependent upon the monsoon season to cultivate their produce. Inflation and poverty is making their lives unpredictable, unstable and strenuous. These women want to help their families by getting trained in cooperative dairy farming by Deepshikha and start their micro business.',
                validated: true,
                user: deepshikha,
                beneficiary: new Beneficiary(
                    firstName: 'Yeshula',
                    email: 'info@deepshikha.org'
                )
        ).addToRewards(
                Reward.findById(1)
        ).addToRewards(
                Reward.findById(2)
        ).addToRewards(
                Reward.findById(3)
        ).addToRewards(
                Reward.findById(4)
        ).addToRewards(
                Reward.findById(5)
        ).addToRewards(
                Reward.findById(6)
        ).addToContributions(
                reward: Reward.findById(6),
                date: dateFormat.parse("01/20/2014"),
                user: sampleUser
		).addToImageUrl(
				url: 'https://s3.amazonaws.com/crowdera/project-images/Yeshula.png'
        ).save(failOnError: true)
    }
	
	def getCountryForProject(Project project){
		 return project?.country;
	}
    
    
    /*def getCountryForProject(Project project){
        def countryId= project.countryId;
        def country
        if(countryId)
        country = Country.findById(countryId)
        return country
    }*/
    
	def getCurrencyByCountryId(Country country){
		return country?.currency?.currency_value;
	}
	
	def getCountryByCountryCode(def country_code){
		if(country_code!=null){
			 return Country.findByCountryCode(country_code)
		}
	}
	
	public def getCountryCodeForCurrentEnv(HttpServletRequest request){
		def country_code = ""
		/**Change the country to 'in' if you want to test the India flow on development ENV*/
		def currentEnv = getCurrentEnvironment();
		if( currentEnv == 'development'|| currentEnv == 'test'){
			country_code  = "us"
		}else if (currentEnv == 'testIndia' || currentEnv==''){
			country_code = "in"
		}else if(currentEnv == 'staging') {
			country_code = request.getHeader("cf-ipcountry").toLowerCase()
		} else{
			country_code = request.getHeader("cf-ipcountry").toLowerCase()
		}
		return country_code;
		
	}
	
	// ownership transfer
	def transferownership(project,team,user){
		team.user = user
		team.save()
		project.user = user
		project.save()
		
	}
	
	def getTeamList(Project project,def type){
		
		List<Team> listOfTeam = new ArrayList<Team>()
		def teams =  Team.findAllWhere(project:project, enable:true, validated:true).collect {
			[
					id : it.id,
					amount: it.amount,
					description:it.description,
					enable:true, validated:true,
					user: it.user,
					projectId : project.id,
					projectTitle : project.title,
					projectOwner:project.user.username,
					contributions: it.contributions,
					sumOfTeamContributions: it.contributions.sum{ if(it?.amount){it?.amount}},
					campaignOwnerId: project.user.id
			]
		}
	    
		teams.each{ team ->

			def amount = 0;
			def percentage = 0;

			if (project?.user?.id == team?.user?.id) {
				amount = getDataType(project.amount)

				if(team.contributions == null){
					team["contributions"] = 0
				} else {

					if ('in'.equalsIgnoreCase(project?.country?.countryCode)) {
						team["contributions"] = project.contributions.sum {
							if ('usd'.equalsIgnoreCase(it?.currency)) {
								it?.amount * project.country?.currency?.dollar
							} else {
								(it?.amount != null) ? it?.amount : 0
							}
						}
					} else {
						team["contributions"] = project.contributions.sum {
							(it?.amount != null) ? it?.amount : 0
						}
					}
				}

				percentage = contributionService.getPercentageContributionForProject(team["contributions"], project)
			} else {
				amount = getDataType(team.amount)

				if(team.contributions == null){
					team["contributions"] = 0
				} else {

					if ('in'.equalsIgnoreCase(project?.country?.countryCode)) {
						team["contributions"] = team.contributions.sum {
							if ('usd'.equalsIgnoreCase(it?.currency)) {
								it?.amount * project.country?.currency?.dollar
							} else {
								(it?.amount != null) ? it?.amount : 0
							}
						}
					} else {
						team["contributions"] = team.contributions.sum {
							(it?.amount != null) ? it?.amount : 0
						}
					}
				}
				
				percentage = contributionService.getPercentageContributionForTeam(team["contributions"], team);
			}
			
			def ended = isProjectDeadlineCrossed(project)

			def imageLink = getProjectImageLink(project)
			def remainingDay = getRemainingDay(project)
			def isAdminOrBeneficiary = userService.isCampaignBeneficiaryOrAdmin(project, team.user)
			def isCampaignAdmin = userService.isCampaignAdmin(project, team.user.username)
			def isCampaignAdminByUser=userService.isCampaignAdminByUserID(project, team.user)
			//def multiplier = getCurrencyConverter();
			def alphabet = userService.getCurrentUserImage(team.user.username)
			def country = getCountryForProject(project)
			def currencyValue = getCurrencyByCountryId(country)
			def countryCode = project.country.countryCode
			def userName = userService.getVanityNameFromUsername(team?.user?.username, team?.id)
			
			//team["contributions"] = team.contributions.sum{ (it?.amount != null)?it?.amount:0}
			team["percentage"] = percentage;
			team["ended"] = ended;
			team["amount"]=amount;
			team["imageLink"] = imageLink;
			team["remainingDay"]= remainingDay
			team["description"]=project.description
			team["organizationName"]=project.organizationName
			team["title"]= getVanityTitleFromId(project?.id)
			team["isAdminOrBeneficiary"] = isAdminOrBeneficiary
			team["isCampaignAdmin"] = isCampaignAdmin
			team["isCampaignAdminByUser"] = isCampaignAdminByUser
			//team["multiplier"] = multiplier
			team["alphabet"]=alphabet
			team["payuStatus"] = project.payuStatus
			team["countryCode"]= countryCode
			team["currencyValue"]= currencyValue
			team["fundsRecievedBy"]= project.fundsRecievedBy
			team["username"]=userName

			if(type.equals("allTeams")) {
				if(percentage >= 17) {
					allTeams.add(team)
				}
				
			} else if(type.equals("allSortedTeams")) {
				allSortedTeams.add(team)
			}
		}
		
		if(type.equals("allTeams")){
			return allTeams
		}else{
			return allSortedTeams
		}
	}
	
	def isDeviceMobileOrTab(HttpServletRequest request){
		String userAgent = request.getHeader("User-Agent");
		if (userAgent?.contains('Mobile') || userAgent?.contains('Android') || userAgent?.contains('iPod')){
			return true
		} else {
			return false
		}
	}
}
