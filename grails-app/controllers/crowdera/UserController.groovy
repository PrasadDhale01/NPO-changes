package crowdera

import grails.plugin.springsecurity.annotation.Secured
import org.springframework.security.core.context.SecurityContextHolder;
import grails.util.Environment
import javax.servlet.http.Cookie

class UserController {
    def userService
    def projectService
	def mandrillService
    def contributionService
    def rewardService
    def roleService

    @Secured(['ROLE_ADMIN'])
    def admindashboard() {
        User user = (User)userService.getCurrentUser()
        def totalContribution
        def environment = Environment.current.getName()
        if ( environment == 'testIndia' || environment == 'stagingIndia' || environment == 'prodIndia') {
            totalContribution = contributionService.getTotalINRContributions()
            render view: 'admin/dashboard', model: [user: user, currency:'INR', amount:totalContribution, environment: environment]
        } else {
            totalContribution = contributionService.getTotalUSDContributions()
            render view: 'admin/dashboard', model: [user: user, currency:'USD', amount:totalContribution, environment: environment]
        }
    }
    
    @Secured(['ROLE_ADMIN'])
    def list() {
       def message = g.cookie(name: 'message')
       flash.contributionEmailSendMessage = message
       Cookie messageCookie = new Cookie("message", 'Email send to all contributors')
       messageCookie.path = '/'
       messageCookie.maxAge= 0
       response.addCookie(messageCookie)

       def verifiedUsers = userService.getVerifiedUserList()
       def nonVerifiedUsers = userService.getNonVerifiedUserList()
       render(view: 'admin/userList', model: [verifiedUsers:verifiedUsers,nonVerifiedUsers:nonVerifiedUsers])
   }

    @Secured(['IS_AUTHENTICATED_FULLY'])
    def dashboard() {
        userprofile('user/dashboard','myprojects')
    }

    @Secured(['IS_AUTHENTICATED_FULLY'])
    def accountSetting() {
        userprofile('user/dashboard','account-settings')
    }
	
    @Secured(['ROLE_ADMIN'])
    def resendConfirmMailByAdmin(){
        def user = userService.getUserId(params.long('id'))
        user.confirmCode = UUID.randomUUID().toString()
        mandrillService.reSendConfirmationMail(user)
        flash.message = "Confirmation Email has been send to ${user.email}"
        redirect(action:'list')
    }
    
    @Secured(['IS_AUTHENTICATED_FULLY'])
    def userprofile(String userViews, String activeTab){
        User user = (User)userService.getCurrentUser()
        def environment = Environment.current.getName()
        
        if (flash.prj_validate_message) {
            flash.prj_validate_message= "Campaign Discarded Successfully"
        }
        
        if (userService.isAdmin()) {
            redirect action: 'admindashboard'
        } else if(userService.isPartner() && userService.isPartnerValidated(user)) {
            redirect action: 'partnerdashboard'
        } else {
            def projects
            def projectAdmins
            def teams
            def project
            def sortByOptions = []
            if (user.email == 'campaignadmin@crowdera.co') {
                if (environment == 'testIndia' || environment == 'stagingIndia' || environment == 'prodIndia') {
                    project = projectService.getValidatedProjectsForCampaignAdmin('Pending', 'INDIA')
                } else {
                    project = projectService.getValidatedProjectsForCampaignAdmin('Pending', 'USA')
                }
                sortByOptions = projectService.getSortingList()
            } else {
                projects = projectService.getAllProjectByUser(user, environment)
                projectAdmins = projectService.getProjectAdminEmail(user)
                teams = projectService.getEnabledAndValidatedTeam(user)
                project = projectService.getProjects(projects, projectAdmins, teams, environment)
            }
            
            List totalCampaings = []
            def max = Math.min(params.int('max') ?: 6, 100)
            totalCampaings = projectService.getUsersPaginatedCampaigns(project, params, max)
            
            def contribution
            contribution = projectService.getPaginatedContibutionByUser(user, environment,params, max)
            
            def contributedAmount = projectService.getContributedAmount(contribution.contributions)
            def fundRaised = projectService.getTotalFundRaisedByUser(projects)
            def country = projectService.getCountry()
            def state
            if (environment == 'testIndia' || environment == 'stagingIndia' || environment == 'prodIndia') {
                state = projectService.getIndianState()
            } else {
                state = projectService.getState()
            }
            def multiplier = projectService.getCurrencyConverter();
            def countryOpts = [India: 'INDIA', USA: 'USA']
<<<<<<< HEAD

            def isUserProjectHavingContribution = userService.isUserProjectHavingContribution(user, environment)

            render view: userViews, 
            model: [user: user, projects: project, totalCampaings: totalCampaings,country: country, fundRaised: fundRaised, state: state,
                    activeTab:activeTab, environment: environment, contributedAmount: contributedAmount, multiplier: multiplier, countryOpts: countryOpts,
                    contributions: contribution.contributions, totalContributions : contribution.totalContributions, sortByOptions: sortByOptions,
                    isUserProjectHavingContribution:isUserProjectHavingContribution]
=======
            
            def partner = userService.getPartnerByUser(user)
            
            render view: userViews, model: [user: user, projects: project, totalCampaings: totalCampaings,country: country, fundRaised: fundRaised, state: state,
                                            activeTab:activeTab, environment: environment, contributedAmount: contributedAmount, multiplier: multiplier, countryOpts: countryOpts,
                                            contributions: contribution.contributions, totalContributions : contribution.totalContributions, sortByOptions: sortByOptions,
                                            partner: partner]
>>>>>>> upstream/master
        }
    }
    
    @Secured(['IS_AUTHENTICATED_FULLY'])
    def myproject() {
        userprofile('user/myproject',null)
    }

    @Secured(['IS_AUTHENTICATED_FULLY'])
    def mycontribution() {
        userprofile('user/mycontribution',null)
    }
    
    @Secured(['IS_AUTHENTICATED_FULLY'])
    def renderdashboard() {
        userprofile('user/dashboard', null)
    }

    def VALID_IMG_TYPES = ['image/png', 'image/jpeg']
    
    @Secured(['IS_AUTHENTICATED_FULLY'])
    def upload_avatar() {
        def avatarUser = userService.getUserId(params.long('id'))
        def imageFile = request.getFile('avatar')

        if (!imageFile.isEmpty() && imageFile.size < 3*1024*1024) {
            if (!VALID_IMG_TYPES.contains(imageFile.getContentType())) {
                flash.user_err_message = "Image must be one of: ${VALID_IMG_TYPES}"
                render (view: 'user/usererror')
                return
            } else {
                def url = userService.getImageUrl(imageFile)
                avatarUser.userImageUrl = url
            }
        } else {
            flash.user_err_message = "Size of the image must be less than [3*1024 * 1024]"
            render (view: 'user/usererror')
            return
        }
        flash.user_message = "Avatar added successfully"
        redirect(action:'accountSetting') 
    }
    
    @Secured(['IS_AUTHENTICATED_FULLY'])
    def edit_avatar() {
        def avatarUser = userService.getUserId(params.long('id'))
        def imageFile = request.getFile('profile')
        
        if (!imageFile.isEmpty() && imageFile.size < 3*1024*1024) {
            if (!VALID_IMG_TYPES.contains(imageFile.getContentType())) {
                flash.user_err_message = "Image must be one of: ${VALID_IMG_TYPES}"
                render (view: 'user/usererror')
                return
            } else {
                def url = userService.getImageUrl(imageFile)
                avatarUser.userImageUrl = url
            }
        } else {
            flash.user_err_message = "Size of the image must be less than [3*1024*1024]"
            render (view: 'user/usererror')
            return
        }
        flash.user_message = "Avatar updated successfully"
        redirect(action:'accountSetting')
    }
    
    @Secured(['IS_AUTHENTICATED_FULLY'])
    def deleteavatar() {
        def avatarUser = userService.getUserId(params.long('id'))
        if(avatarUser) {
            avatarUser.userImageUrl = null
            flash.user_message = "Avatar deleted successfully"
            redirect(action:'accountSetting')
        } else {
            flash.user_err_message = "User not found"
            render (view: 'user/usererror')
        }
    }
    
    @Secured(['ROLE_ADMIN'])
    def userquestionsList() {
        def services = userService.getCustomerServiceList()
        render view: '/user/userquestions/index', model: [services: services]
    }
    
    @Secured(['ROLE_ADMIN'])
    def response() {
        def imageFile = request.getFile('file')
        userService.sendResponseToCustomer(params, imageFile)
        flash.servicemessage = "Successfully Responded"
        redirect action:'userquestionsList'
    }
    
    @Secured(['ROLE_ADMIN'])
    def discardUserQuery() {
        userService.discardUserQuery(params)
        flash.discardQueryMessage = "User Query Discarded Successfully."
        redirect action:'userquestionsList'
    }
	
    @Secured(['ROLE_ADMIN'])
        def crewsList() {
        def nonRespondList = userService.getNonRespondList()
        def respondedList = userService.getRespondedList()
        render view: '/user/crew/index', model: [nonRespondList: nonRespondList, respondedList: respondedList]
    }

    @Secured(['ROLE_ADMIN'])
    def responseforCrews() {
        def docfile = request.getFile('resume')
        def request_url=request.getRequestURL().substring(0,request.getRequestURL().indexOf("/", 8))
        def base_url = (request_url.contains('www')) ? grailsApplication.config.crowdera.BASE_URL1 : grailsApplication.config.crowdera.BASE_URL
        userService.sendResponseToCrews(params,docfile, base_url)
        def crew = userService.getCrewRegById(params.long('id'))
        crew.adminReply = params.adminReply
        crew.adminDate = new Date()
        flash.crewsmessage = "Successfully Responded"
        redirect action:'crewsList'
    }
	
    @Secured(['ROLE_ADMIN'])
    def discardDetails() {
        userService.discardMessage(params)
        flash.discardMessage = "Applicant Query Discarded Successfully."
        redirect action:'crewsList'
    }

    @Secured(['ROLE_ADMIN'])
    def resendToUsers(){
        def mailstousers = userService.getUsersMails()
        if(mailstousers){
            redirect(action:'list')
            flash.message = "You have successfully sent an email"
        }else{
            redirect(action:'list')
            flash.message = "You have already sent an email"
        }
    }
    
    @Secured(['ROLE_ADMIN'])
    def deleteUser() {
        def user = userService.getUserById(params.long('id'))
        userService.deleteNonVerifiedUser(user)
        
        flash.deleteusermsg = "User Deleted Successfully"
        redirect (action: 'list')
    }
	
	//@Secured(['IS_AUTHENTICATED_FULLY'])
	def subscribeNewsLetter(){
	    def subscribeURL=grailsApplication.config.crowdera.MAILCHIMP.SUBSCRIBE_URL
		def userID=grailsApplication.config.crowdera.MAILCHIMP.USERID
		def listID=grailsApplication.config.crowdera.MAILCHIMP.LISTID
		def email= request.getParameter('email')
		def userName=userService.getUserByName(email)
		def status
	
		if(userName){
		  render ''
		}else{
		  status = userService.sendUserSubscription(subscribeURL,userID,listID, email)
		}
		render " "
    }
    
    def logout() {
        SecurityContextHolder.clearContext()
        render(view: '/login/error', model: [facelogoutmsg: 'A user with that email id already exists. Please log into your account.'])
    }
    
    @Secured(['IS_AUTHENTICATED_FULLY'])
    def paymentInfo() {
        def projectId = projectService.getProjectIdFromVanityTitle(params.projectTitle)
        def project = projectService.getProjectById(projectId)
        if (project) {
        userService.setBankInfoDetails(params, project)
        redirect (action: 'manageproject', controller:'project', params:['projectTitle': params.projectTitle], fragment:'payments')
        } else {
            render view:'404error'
        }
    }
    
    @Secured(['ROLE_ADMIN'])
    def metrics() {
        List projects = projectService.getListOfValidatedProjects()
        def object = projectService.getNumberOfEndedAndLiveCampaigns(projects)
        def selectedCategory = projectService.getNumberOfMostSelectedCategoryAndCount(projects)
        def avgNumberOFPerk = rewardService.getAverageNumberOfPerk(projects)
        def projectObj = projectService.getProjectList(params)
        def userObj = userService.getUsersList(params)
        
        render view: '/user/metrics/index',
               model:[endedProjects: object.endedProjects , LiveProjects : object.LiveProjects, totalProjects : object.totalProjects,
                      mostSelectedCategory: selectedCategory.mostSelectedCategory, mostSelectedCategoryCount: selectedCategory.mostSelectedCategoryCount,
                      avgNumberOFPerk: avgNumberOFPerk, verifiedUsers: userObj.users, totalUsers: userObj.totalUsers, sortedCampaigns: projectObj.projects, totalCampaigns: projectObj.totalCampaigns]
    }
    
    @Secured(['ROLE_ADMIN'])
    def usersList() {
        def userObj = userService.getUsersList(params)
        def model = [totalUsers: userObj.totalUsers, verifiedUsers: userObj.users, offset: params.offset]
        
        if (request.xhr) {
            render(template: "/user/metrics/users", model: model)
        }
    }
    
    @Secured(['IS_AUTHENTICATED_FULLY'])
    def campaignpagination() {
        User user = userService.getCurrentUser()
        def environment = Environment.current.getName()
        def projects = projectService.getAllProjectByUser(user, environment)
        def projectAdmins = projectService.getProjectAdminEmail(user)
        def teams = projectService.getEnabledAndValidatedTeam(user)
        List project = projectService.getProjects(projects, projectAdmins, teams, environment)
        def max = Math.min(params.int('max') ?: 6, 100)
        List totalCampaings = projectService.getUsersPaginatedCampaigns(project, params, max)
        def multiplier = projectService.getCurrencyConverter();
        
        def model = [user: user, totalCampaings: totalCampaings, projects: project, dashboard: 'dashboard', activeTab: 'campaigns', multiplier: multiplier]
        if (request.xhr) {
            render(template: "user/campaigntile", model: model)
        }
    }

    @Secured(['IS_AUTHENTICATED_FULLY'])
    def contributionspagination() {
        User user = userService.getUserById(params.int('userId'))
        if (user) {
            def environment = Environment.current.getName()
            def max = Math.min(params.int('max') ?: 6, 100)
            def contribution = projectService.getPaginatedContibutionByUser(user, environment, params, max)
            def multiplier = projectService.getCurrencyConverter();
    
            def model = [contributions: contribution.contributions, totalContributions : contribution.totalContributions, activeTab: 'contributions', multiplier: multiplier, user: user]
            if (request.xhr) {
                render(template: "user/campaignssupported", model: model)
            }
        } else {
            render view:'/404error'
        }
    }
    
    @Secured(['IS_AUTHENTICATED_FULLY'])
    def edituserprofile() {
        User user = userService.getCurrentUser()
        def country = projectService.getCountry()
        def state = projectService.getState()
        render (view: "/user/user/userprofile", model: [user : user, country: country, state: state])
    }

    @Secured(['IS_AUTHENTICATED_FULLY'])
    def updateuserprofile() {
        User user = userService.getCurrentUser()
        userService.updateUserProfile(params, user)
        redirect action:'dashboard'
    }

    @Secured(['IS_AUTHENTICATED_FULLY'])
    def mycampaigns() {
        userprofile('user/dashboard','campaigns')
    }

    @Secured(['IS_AUTHENTICATED_FULLY'])
    def mycontributions() {
        userprofile('user/dashboard','contributions')
    }

    @Secured(['IS_AUTHENTICATED_FULLY'])
    def edituserinfo() {
        userprofile('user/dashboard','editUserInfo')
    }

    @Secured(['IS_AUTHENTICATED_FULLY'])
    def editlocation() {
        userprofile('user/dashboard','editLocation')
    }

    @Secured(['IS_AUTHENTICATED_FULLY'])
    def sendTaxReceipt() {
        User user = (User)userService.getCurrentUser()
        def environment = projectService.getCurrentEnvironment()
        def projectList = projectService.getAllProjectByUserHavingContribution(user, environment, params)
        def contributions = projectService.getContibutionByUser(user, environment)
        def contributedAmount = projectService.getContributedAmount(contributions)
        def fundRaised = projectService.getTotalFundRaisedByUser(projectList.totalProjects)
        def isUserProjectHavingContribution = userService.isUserProjectHavingContribution(user, environment)
        def contributorListForProject
        def activeTab
        def totalContributions
        def contributionList
        def sortList
        if (projectList.totalProjects.size() == 1) {
            contributorListForProject = contributionService.getContributorsForProject(projectList.totalProjects[0].id, params)
            activeTab = 'sendtaxReciept'
            totalContributions = contributorListForProject.totalContributions
            contributionList = contributorListForProject.contributions
            sortList = (environment == 'testIndia' || environment == 'stagingIndia' || environment == 'prodIndia') ? contributionService.contributorsSortInd() : contributionService.contributorsSortUs();
        } else {
            contributorListForProject = null
            activeTab = 'taxReceiptTile'
            totalContributions = null
            contributionList= null
            sortList = null
        }
        render view: 'user/dashboard',
        model: [user: user, fundRaised: fundRaised, environment: environment, contributedAmount: contributedAmount,
                contributions: contributions, projects:projectList.projects, totalProjects:projectList.totalProjects,
                totalContributions:totalContributions, contributionList:contributionList,activeTab:activeTab,
                isUserProjectHavingContribution:isUserProjectHavingContribution, sortList:sortList]
    }

    def loadCampaignTile(){
        User user = (User)userService.getCurrentUser()
        def environment = projectService.getCurrentEnvironment()
        def projectList = projectService.getAllProjectByUserHavingContribution(user, environment, params)
        if (request.xhr) {
            render template:'/user/user/userCampaignTile',
            model : [projects:projectList.projects, totalProjects:projectList.totalProjects, user:user]
        }
    }

    def loadContributors() {
        def contributorListForProject = userService.getSortedContributorsForProject(params)
        def environment = projectService.getCurrentEnvironment()
        def offset = params.int('offset') ?: 0
        def sortList = (environment == 'testIndia' || environment == 'stagingIndia' || environment == 'prodIndia') ? contributionService.contributorsSortInd() : contributionService.contributorsSortUs();
        if (request.xhr) {
            render template: '/user/user/sendTaxReceipt',
            model: [vanityTitle: params.vanityTitle, offset: offset, sortList:sortList,
            totalContributions:contributorListForProject.totalContributions, 
            contributionList:contributorListForProject.contributions, sort:params.sort]
        }
    }
    
    def loadExportThumbnail(){
        def user = userService.getCurrentUser();
        def taxReceiptRecievedList = userService.getContributionsForWhichTaxReceiptreceived(user, params)
        
        if (request.xhr) {
            def model = [totalTaxReceiptContributions:taxReceiptRecievedList.totalTaxReceiptContributions, taxReceiptContribution:taxReceiptRecievedList.taxReceiptList]
            
            render template: '/user/user/exportTaxReceipt', model : model
        }
    }

    @Secured(['IS_AUTHENTICATED_FULLY'])
        def exportTaxReceipt() {
        User user = (User)userService.getCurrentUser()
        def environment = projectService.getCurrentEnvironment()
        def projects = projectService.getAllProjectByUser(user, environment)
        def contributions = projectService.getContibutionByUser(user, environment)
        def contributedAmount = projectService.getContributedAmount(contributions)
        def fundRaised = projectService.getTotalFundRaisedByUser(projects)
        def isUserProjectHavingContribution = userService.isUserProjectHavingContribution(user, environment)

        render view: 'user/dashboard',
        model: [user: user, fundRaised: fundRaised, environment: environment, contributedAmount: contributedAmount,
                contributions: contributions, projects:projects, activeTab:'exporttaxReciept',
                isUserProjectHavingContribution:isUserProjectHavingContribution]
    }

    @Secured(['IS_AUTHENTICATED_FULLY'])
    def update() {
        User currentUser = userService.getCurrentUser()
        User user = userService.getUserById(params.int('id'))
        
        if (currentUser == user || userService.isAdmin() ){
            if (user) {
                userService.setUserInfo(params,user)
                if (user.save()) {
                    flash.user_message = "Profile updated successfully!"
                    redirect (controller: 'user', action: 'dashboard')
                } else {
                    render(view: 'error', model: [message: "Error while updating user. Please try again later."])
                }
            } else {
                render(view: '/404error')
            }
        } else {
            render(view: '/401error')
        }
    }
    
    @Secured(['ROLE_ADMIN'])
    def currency() {
        Currency currency = userService.getCurrencyById()
        if (currency) {
            currency.dollar = Double.parseDouble(params.currency)
        } else {
            currency = new Currency()
            currency.dollar = Double.parseDouble(params.currency)
        }
        if (currency.save()) {
            redirect (action:"transaction", controller:"fund")
        } else {
            render(view: 'error', model: [message: "Error while updating Currency. Please try again later."])
        }
    }
	
	@Secured(['IS_AUTHENTICATED_FULLY'])
	def saveFeedback(){
		def userId = params.user
		User user= userService.getUserById(userId)
		def feedback =userService.getFeedbackByUser(user)
		if(feedback){
			userService.setFeedbackByUser(feedback, params , user)
		}else{
			new Feedback(params).save()
		}
		flash.feedback_message = "Feedback submitted successfully"
		redirect url:'/'
	}
	
	@Secured(['ROLE_ADMIN'])
	def feedback(){
		def project =projectService.getValidatedProjects()
		render(view:'/user/survey/index', model:[project:project])
	}
	
	@Secured(['ROLE_ADMIN'])
	def previewUserFeedBack(){
		def projectId = params.projectId
		def project = Project.get(projectId)
		def user = userService.getUserById(project.user.id)
		def feedback=userService.getFeedbackByUser(user)
		render( view:"/user/survey/previewuserfeedback", model:[feedback:feedback, user:user])
	}
    
    @Secured(['IS_AUTHENTICATED_FULLY'])
    def getSortedCampaigns() {
        def projects = projectService.getValidatedProjectsForCampaignAdmin(params.selectedSortValue, params.country)
        def multiplier = projectService.getCurrencyConverter();
        def currentEnv = Environment.current.getName()
        def model = [projects: projects, multiplier: multiplier]
        if (request.xhr) {
            render(template: "/user/user/grid", model: model, currentEnv: currentEnv)
        }
    }
	
	@Secured(['IS_AUTHENTICATED_FULLY'])
	def userActivity1(){
		userActivity('page', params.id)
	}
	
	def userActivity(String page, String id){
	    def userId = id
 	    User user = User.get(userId)
        def currentUser = userService.getCurrentUser()
	    def username
	    def environment= projectService.getCurrentEnvironment()
		
	    if(user){
              def comments = userService.getUserCommnet(user)
              def projects = projectService.getAllProjectByUser(user, environment)
              def projectAdmins = projectService.getProjectAdminEmail(user)
              def teams = projectService.getEnabledAndValidatedTeam(user)
              def project = projectService.getProjects(projects, projectAdmins, teams, environment)
              def contributions =projectService.getContibutionByUser(user, environment)
              def recentActivity = userService.getUserRecentActivity(project, contributions,comments, user, teams)
              def supporterList = userService.getSupporterListActivity(project, user, teams)
              def supporters= userService.getSupportersByUser(user) 
              def userContribution = userService.getUserContribution(user)
              def fundRaised = projectService.getTotalFundRaisedByUser(projects)
              if(user.id == 3){
                  contributions.each{
                      if(!it.isAnonymous && !it.isContributionOffline){
                           def amt = it.amount.round()
                           if(amt == params.int("amount")){
                                username = it.contributorName.toString().replace('[', '').replace(']', '')
                           }
                      }
                  }
              }else{
                  username = user.firstName
              }
		
              if(page){
                  render(view:'/user/user/userprofile', model:[currentUser:currentUser, user:user, project:project, projects:projects, teams:teams, contributions:contributions, recentActivity: recentActivity, supporters:supporters, userContribution:userContribution, fundraised: fundRaised, page:page, environment:environment, username:username, supporterList:supporterList])
              }else{
                  render(view:'/user/user/userprofile', model:[currentUser:currentUser, user:user, project:project, projects:projects, teams:teams, contributions:contributions, recentActivity: recentActivity, supporters:supporters, userContribution:userContribution, fundraised: fundRaised, environment:environment, username:username,  supporterList:supporterList])
              }
	
          }else{
              render view:'/404error'
          }
	}
    
    @Secured(['ROLE_ADMIN'])
    def managePartner() {
        if (flash.invitesuccessmsg) {
            flash.invitesuccessmsg = flash.invitesuccessmsg
        } else if(flash.discardmsg) {
            flash.discardmsg = flash.discardmsg
        } else if(flash.discardfailmsg) {
            flash.discardfailmsg = flash.discardfailmsg
        } else if (flash.validationSuccessMsg) {
            flash.validationSuccessMsg = flash.validationSuccessMsg
        }
        
        List partners = userService.getPartners()
        List nonVerified = userService.getNonVerifiedPartners()
        List pendingList = userService.getPendingPartners()
        List draftList = userService.getDraftPartners()
        def currentEnv = projectService.getCurrentEnvironment()
        
        render view:'/user/partner/index', model:[partners: partners, nonVerified: nonVerified, pendingList: pendingList,
                                                        draftList: draftList, currentEnv: currentEnv]
    }
    
    @Secured(['ROLE_ADMIN'])
    def addpartner() {
        User user = userService.findUserByEmail(params.email)
        def password
        if (!user) {
            def userObj = userService.setUserObject(params)
            user = userObj.user
            password = userObj.password
        }
        
        if (userService.getPartnerByUser(user)) {
            List partners = userService.getPartners()
            flash.alreadyExistMsg = "Partner with this email already exist."
            render view:'/user/partner/index', model:[partners: partners]
        } else {
            Partner partner = new Partner()
            partner.user = user
            partner.created = new Date()
            
            partner.confirmCode = UUID.randomUUID().toString()
            if (partner.save()) {
                mandrillService.sendEmailToPartner(user, partner, password);
                flash.invitesuccessmsg = "Email Sent Successfully"
                redirect action:'managePartner'
            } else {
                flash.user_err_message = 'Error occured while inviting a partner. Please try again.'
                render(view: '/usererror')
            }
        }
    }
    
    def confirmPartner(String id) {
        Partner partner = userService.getPartnerByConfirmCode(id)

        if (partner) {
            if (partner.enabled) {
                render(view: '/success', model: [sucess_message: 'Your account is successfully confirmed for Partner. It seems like you were already confirmed.'])
            } else {
                partner.enabled = true
                if (partner.save()) {
                    def user = userService.getCurrentUser()
                    
                    if (!user) {
                        def request_url=request.getRequestURL().substring(0,request.getRequestURL().indexOf("/", 8))
                        def base_url = (request_url.contains('www')) ? grailsApplication.config.crowdera.BASE_URL1 : grailsApplication.config.crowdera.BASE_URL
                        
                        def reqUrl = base_url+"/user/joinPartners"
                        
                        Cookie cookie = new Cookie("requestUrl", reqUrl)
                        cookie.path = '/'    // Save Cookie to local path to access it throughout the domain
                        cookie.maxAge= 3600  //Cookie expire time in seconds
                        response.addCookie(cookie)
                    }
                    
                    redirect action:'joinPartners'
                } else {
                    flash.user_err_message = 'Problem activating account. Please contact the administrator.'
                    render(view: '/usererror')
                }
            }
        } else {
            flash.user_err_message = 'Problem activating account. Please check your activation link'
            render(view: '/user/user/usererror')
        }
    }
    
    @Secured(['IS_AUTHENTICATED_FULLY'])
    def partnerdashboard() {
        def currentEnv = projectService.getCurrentEnvironment()
        def currentUser = userService.getCurrentUser()
        Partner partner
        if (params.id) {
            partner = userService.getPartnerById(params.int('id'))
        } else {
            partner = userService.getPartnerByUser(currentUser)
        }
        
        if (partner) {
            User user = partner.user
            def projectObj = projectService.getValidatedProjectsForPartner(user, partner, params)
            def numberOfInvites = userService.getTotalNumberOfInvites(partner)
            def userCampaign = projectService.getPartnerCampaigns(user, params)
            def fundRaised = projectService.getTotalFundRaisedByUser(userCampaign.campaigns)
            def country = projectService.getCountry()
            def state
            if (currentEnv == 'testIndia' || currentEnv == 'stagingIndia' || currentEnv == 'prodIndia') {
                state = projectService.getIndianState()
            } else {
                state = projectService.getState()
            }
            
            def isAdmin = userService.isAdmin()
            def conversionMultiplier = projectService.getCurrencyConverter();
            def folders = userService.getFolders(user)
            def files = partner.documents
            
            def contribution
            contribution = projectService.getPaginatedContibutionByUser(user, currentEnv,params, 6)
            
            def contributedAmount = projectService.getContributedAmount(contribution.contributions)
            
            def requestUrl=request.getRequestURL().substring(0,request.getRequestURL().indexOf("/", 8))
            def baseUrl = (requestUrl.contains('www')) ? grailsApplication.config.crowdera.BASE_URL1 : grailsApplication.config.crowdera.BASE_URL
            
            if (flash.prj_validate_message) {
                flash.prj_validate_message = flash.prj_validate_message
            } else if (flash.invite_message) {
                flash.invite_message = flash.invite_message
            } else if(flash.receipt_sent_msg) {
                flash.receipt_sent_msg = flash.receipt_sent_msg
            }
            
            def projectList = projectService.getAllProjectByUserHavingContribution(user, currentEnv, params)
            def isUserProjectHavingContribution = userService.isUserProjectHavingContribution(user, currentEnv)
            def userHasContributedToNonProfitOrNgo = userService.userHasContributedToNonProfitOrNgo(user)
            def contributorListForProject, totalContributions, contributionList
            def sortList = (currentEnv == 'testIndia' || currentEnv == 'stagingIndia' || currentEnv == 'prodIndia') ? contributionService.contributorsSortInd() : contributionService.contributorsSortUs();
            def vanityTitle
            def taxReceiptRecievedList = userService.getContributionsForWhichTaxReceiptreceived(user, params)
            if (projectList.totalProjects.size() == 1) {
                contributorListForProject = contributionService.getContributorsForProject(projectList.totalProjects[0].id, params)
                totalContributions = contributorListForProject.totalContributions
                contributionList = contributorListForProject.contributions
                vanityTitle = projectService.getVanityTitleFromId(projectList.totalProjects[0].id)
            } else {
                contributorListForProject = null
                totalContributions = null
                contributionList= null
                vanityTitle = null
            }

            def isInviteTrue = false;
            
            if(chainModel){
                render view:'/user/partner/dashboard', 
                model:[user: user, campaigns: projectObj.projects, totalCampaigns: projectObj.totalprojects, baseUrl: baseUrl,
                fundRaised: fundRaised, numberOfInvites: numberOfInvites, userCampaigns: userCampaign.projects, folders: folders,
                country: country, state: state, partner: partner, isAdmin: isAdmin, conversionMultiplier: conversionMultiplier,
                files: files, isUserProjectHavingContribution:isUserProjectHavingContribution, totalProjects:projectList.totalProjects, 
                projects:projectList.projects, totalUserCampaigns: userCampaign.totalprojects, currentEnv: currentEnv,
                contributorListForProject:contributorListForProject, totalContributions:totalContributions, sortList:sortList,
                userHasContributedToNonProfitOrNgo:userHasContributedToNonProfitOrNgo, vanityTitle:vanityTitle,
                contributionList:contributionList, totalTaxReceiptContributions:taxReceiptRecievedList.totalTaxReceiptContributions,
                taxReceiptContribution:taxReceiptRecievedList.taxReceiptList, isInviteTrue:isInviteTrue, email:chainModel.email,
                contactList:chainModel.contactList, provider:chainModel.socialProvider]
            } else {
                render view:'/user/partner/dashboard',
                model:[user: user, campaigns: projectObj.projects, totalCampaigns: projectObj.totalprojects, baseUrl: baseUrl,
                fundRaised: fundRaised, numberOfInvites: numberOfInvites, userCampaigns: userCampaign.projects, folders: folders,
                country: country, state: state, partner: partner, isAdmin: isAdmin, conversionMultiplier: conversionMultiplier,
                files: files, isUserProjectHavingContribution:isUserProjectHavingContribution, totalProjects:projectList.totalProjects,
                projects:projectList.projects, totalUserCampaigns: userCampaign.totalprojects, currentEnv: currentEnv,
                contributorListForProject:contributorListForProject, totalContributions:totalContributions, sortList:sortList,
                userHasContributedToNonProfitOrNgo:userHasContributedToNonProfitOrNgo, vanityTitle:vanityTitle,
                contributionList:contributionList, totalTaxReceiptContributions:taxReceiptRecievedList.totalTaxReceiptContributions,
                taxReceiptContribution:taxReceiptRecievedList.taxReceiptList, isInviteTrue:isInviteTrue,
                contributions: contribution.contributions, totalContributions : contribution.totalContributions,
                contributedAmount:contributedAmount]
            }
        }
    }

    def partnercampaigns() {
        Partner partner = userService.getPartnerById(params.int('partnerId'))
        if (partner) {
            User user = partner.user
            def projectObj = projectService.getPartnerCampaigns(user, params)
            def conversionMultiplier = projectService.getCurrencyConverter();
            def currentEnv = projectService.getCurrentEnvironment()
            
            def model = [userCampaigns: projectObj.projects, totalUserCampaigns: projectObj.totalprojects, partner: partner, user: user, conversionMultiplier: conversionMultiplier, currentEnv: currentEnv]
            render template:"/user/partner/tile", model: model
        }
    }
    
    @Secured(['IS_AUTHENTICATED_FULLY'])
    def promotecampaigns() {
        Partner partner = userService.getPartnerById(params.int('partnerId'))
        if (partner) {
            User user = partner.user
            def projectObj = projectService.getValidatedProjectsForPartner(user, partner, params)
            def model = [campaigns: projectObj.projects, totalCampaigns: projectObj.totalprojects, partner: partner, user: user]
            render template:"/user/partner/promote", model: model
        }
    }
    
    def validatecampaigns() {
        Partner partner = userService.getPartnerById(params.int('partnerId'))
        if (partner) {
            User user = partner.user
            def projectObj = projectService.getNonValidatedProjectsForPartner(user, partner, params)
            def model = [projects: projectObj.projects, totalprojects: projectObj.totalprojects, partner: partner, user: user]
            render template:'/user/partner/validatetile', model: model
        }
    }
    
    @Secured(['IS_AUTHENTICATED_FULLY'])
    def invite() {
        if (userService.isPartner()) {
            userService.inviteCampaignOwner(params)
            flash.invite_message = "Email Sent Successfully."
            redirect action: 'partnerdashboard'
        } else {
            render view:'/401error'
        }
    }
    
    def loadDriveFiles() {
        User user = userService.getUserId(params.int('userId'))
        if (user) {
            def fileObj = userService.getDriveFiles(user, params)
            def requestUrl=request.getRequestURL().substring(0,request.getRequestURL().indexOf("/", 8))
            def baseUrl = (requestUrl.contains('www')) ? grailsApplication.config.crowdera.BASE_URL1 : grailsApplication.config.crowdera.BASE_URL
            
            def model = [files: fileObj.files, totalFiles: fileObj.totalFiles, offset: params.offset, user : user, baseUrl: baseUrl]
            render template:'/user/partner/drivefiles', model: model
        }
    }
    
    def insertfile() {
        User user = userService.getUserId(params.int('userId'))
        if (user) {
            boolean isSelected = userService.getGoogleDriveFiles(user, params.fileId, params.title, params.url)
            def fileObj = userService.getDriveFiles(user, params)
            def requestUrl=request.getRequestURL().substring(0,request.getRequestURL().indexOf("/", 8))
            def baseUrl = (requestUrl.contains('www')) ? grailsApplication.config.crowdera.BASE_URL1 : grailsApplication.config.crowdera.BASE_URL
            
            def model = [files: fileObj.files, totalFiles: fileObj.totalFiles, offset: params.offset, user : user, baseUrl: baseUrl, isSelected: isSelected]
            render template:'/user/partner/drivefiles', model: model
        }
    }
    
    def trashdrivefile() {
        User user = userService.getUserId(params.int('userId'))
        if (user) {
            userService.deleteDriveFile(params)
            def requestUrl=request.getRequestURL().substring(0,request.getRequestURL().indexOf("/", 8))
            def baseUrl = (requestUrl.contains('www')) ? grailsApplication.config.crowdera.BASE_URL1 : grailsApplication.config.crowdera.BASE_URL
            def fileObj = userService.getDriveFiles(user, params)
            def model = [files: fileObj.files, totalFiles: fileObj.totalFiles, offset: params.offset, user : user, baseUrl: baseUrl]
            render template:'/user/partner/drivefiles', model: model
        }
    }
    
    def newfolder() {
        User user = userService.getUserId(params.int('userId'))
        if (user) {
            userService.setNewFolder(user, params)
            def folders = userService.getFolders(user)
            def model = [folders: folders]
            render template : '/user/partner/folders', model: model
        }
    }
    
    def sendReceipt() {
        def file = request.getFile('file')
        userService.sendReceipt(params, file)
        flash.receipt_sent_msg = "Receipt Sent Successfully."
        redirect action: 'partnerdashboard'
    }
    
    def uploadDocument() {
        Partner partner = userService.getPartnerById(params.int('partnerId')) 
        if (partner) {
            Folder folder = userService.getFolderById(params.int('folderId'))
            def file = params.file
            userService.uploadDocument(file, params, partner, folder)
            def files
            def model
            def requestUrl= request.getRequestURL().substring(0,request.getRequestURL().indexOf("/", 8))
            def baseUrl = (requestUrl.contains('www')) ? grailsApplication.config.crowdera.BASE_URL1 : grailsApplication.config.crowdera.BASE_URL
            if (folder) {
                files = userService.getFolderDocuments(folder);
                model = [files: files, folderName : folder.fName, folder: folder, baseUrl: baseUrl]
                render (template:'/user/partner/files', model: model)
            } else {
                files = userService.getPartnerDocuments(partner);
                model = [files: files, partner: partner, baseUrl: baseUrl]
                render (template:'/user/partner/files', model: model)
            }
        }
    }
    
    def loadFolder() {
        Folder folder = userService.getFolderById(params.int('id'))
        if (folder) {
            def files = folder.documents
            def requestUrl= request.getRequestURL().substring(0,request.getRequestURL().indexOf("/", 8))
            def baseUrl = (requestUrl.contains('www')) ? grailsApplication.config.crowdera.BASE_URL1 : grailsApplication.config.crowdera.BASE_URL

            def model = [files: files, folderName : folder.fName, folder: folder, baseUrl: baseUrl]
            render (template:'/user/partner/files', model: model)
        }
    }
    
    def trashdocfile() {
        Folder folder = userService.getFolderById(params.int('folderId'))
        Partner partner = userService.getPartnerById(params.int('partnerId'))
        
        def requestUrl= request.getRequestURL().substring(0,request.getRequestURL().indexOf("/", 8))
        def baseUrl = (requestUrl.contains('www')) ? grailsApplication.config.crowdera.BASE_URL1 : grailsApplication.config.crowdera.BASE_URL
        
        if (folder) {
            userService.deleteFolderFile(folder, params)
            def files = folder.documents
            def model = [files: files, folderName : folder.fName, folder: folder, baseUrl: baseUrl]
            render (template:'/user/partner/files', model: model)
        
        } else if (partner) {
            userService.deleteDocFile(partner , params)
            def files = partner.documents
            def model = [files: files, partner: partner, baseUrl: baseUrl]
            render (template:'/user/partner/files', model: model)
        }
    }
    
    def trashFolder() {
        Partner partner = userService.getPartnerById(params.int('partnerId'))
        if (partner) {
            User user = partner.user
            userService.trashFolders(params);
            def folders = userService.getFolders(user)
            def model = [folders: folders]
            render template : '/user/partner/folders', model: model
        }
    }

    def exportTaxReceiptpdf() {
        def contribution = Contribution.get(params.id)
        def title = contribution.project.organizationName
        response.setContentType("application/pdf")
        response.setHeader("Content-Disposition", "attachment; filename=taxreceipt-"+title+".pdf")
        renderPdf(template:"/user/user/taxReceipt", model:[pdfRendering:true, contribution:contribution])
    }

    @Secured(['ROLE_ADMIN'])
    def deletePartner() {
        Partner partner = userServicoe.getPartnerById(params.int('partnerId'))
        if (partner) {
            boolean isPartnerDeleted = userService.deletePartner(params, partner)
            if (isPartnerDeleted) {
                flash.discardmsg = "Partner has been deleted successfully."
            } else {
                flash.discardfailmsg = "Oh snap! Something went wrong while deleting partner. Please try again."
            }
            redirect action:'managePartner'
        } else {
            render view: '/404error'
        }
    }

    @Secured(['IS_AUTHENTICATED_FULLY'])
    def sortContributorsList(){
        def contributorListForProject = userService.getSortedContributorsForProject(params)
        def environment = projectService.getCurrentEnvironment()
        def sortList = (environment == 'testIndia' || environment == 'stagingIndia' || environment == 'prodIndia') ? contributionService.contributorsSortInd() : contributionService.contributorsSortUs();
        def offset = params.int('offset') ?: 0
        if (contributorListForProject.isEmpty()){
            if (request.xhr) {
                render template: '/user/user/sendTaxReceipt',sortList:sortList,
                model: [vanityTitle: params.vanityTitle, offset: offset,
                totalContributions:null, contributionList:null, sort:params.sort, 
                doProjectHaveContribution:false]
            }
        } else {
            if (request.xhr) {
                render template: '/user/user/sendTaxReceipt',
                model: [vanityTitle: params.vanityTitle, offset: offset,sortList:sortList,
                totalContributions:contributorListForProject.totalContributions,
                contributionList:contributorListForProject.contributions, sort:params.sort,
                doProjectHaveContribution:true]
            }
        }
    }
    

    @Secured(['IS_AUTHENTICATED_FULLY'])
    def searchByName(){
        def contributorListForProject = userService.getContributorsListSearchedByName(params)
        def environment = projectService.getCurrentEnvironment()
        def sortList = (environment == 'testIndia' || environment == 'stagingIndia' || environment == 'prodIndia') ? contributionService.contributorsSortInd() : contributionService.contributorsSortUs();
        def offset = params.int('offset') ?: 0
        if (contributorListForProject.isEmpty()){
            if (request.xhr) {
                render template: '/user/user/sendTaxReceipt',sortList:sortList,
                model: [vanityTitle: params.vanityTitle, offset: offset,
                totalContributions:null, contributionList:null, sort:params.sort,
                doProjectHaveContribution:false]
            }
        } else {
            if (request.xhr) {
                render template: '/user/user/sendTaxReceipt',
                model: [vanityTitle: params.vanityTitle, offset: offset,sortList:sortList,
                totalContributions:contributorListForProject.totalContributions,
                contributionList:contributorListForProject.contributions, sort:params.sort,
                doProjectHaveContribution:true]
            }
        }

    }

    @Secured(['IS_AUTHENTICATED_FULLY'])
    def sendTaxReceiptToContributors(){
       projectService.sendTaxReceiptToContributors(params);
       render ''
    }

    def partners() {
        List partners = userService.getPartners()
        def currentEnv = projectService.getCurrentEnvironment()
        
        render (view:'/user/partner/show/index', model:[partners: partners, currentEnv: currentEnv])
    }
    
    def partnerFaq() {
        render (view:'/user/partner/show/partnerfaq')
    }
    
    def partnerpage() {
        render (view: '/user/partner/show/partnerpage')
    }
    
    def newpartner() {
        def user = userService.getCurrentUser()
        
        if (!user) {
            def request_url=request.getRequestURL().substring(0,request.getRequestURL().indexOf("/", 8))
            def base_url = (request_url.contains('www')) ? grailsApplication.config.crowdera.BASE_URL1 : grailsApplication.config.crowdera.BASE_URL
            
            def reqUrl = base_url+"/user/createpartner"
            
            Cookie cookie = new Cookie("requestUrl", reqUrl)
            cookie.path = '/'    // Save Cookie to local path to access it throughout the domain
            cookie.maxAge= 3600  //Cookie expire time in seconds
            response.addCookie(cookie)
        }
        
        redirect action:'createpartner'
    }
    
    @Secured(['IS_AUTHENTICATED_FULLY'])
    def createpartner() {
        def user = userService.getCurrentUser()
        Partner partner = userService.getPartnerByUser(user)
        
        if (partner) {
            boolean alreadyExist = true
            if (partner.rejected) {
                partner.rejected = false
                partner.save()
            }
            render (view: '/user/partner/create/justcreated', model:[partner: partner, alreadyExist: alreadyExist])
        } else {
            partner = userService.setPartner(user)
            if (partner) {
                def country = projectService.getCountry()
                def currentEnv = projectService.getCurrentEnvironment()
                render (view: '/user/partner/create/index', model:[currentEnv: currentEnv, country: country, partner: partner, user: user])
            } else {
                render view: '/404error'
            }
        }
    }
    
    @Secured(['IS_AUTHENTICATED_FULLY'])
    def joinPartners() {
        def user = userService.getCurrentUser()
        def partner = userService.getPartnerByUser(user)
        
        if (partner) {
            def country = projectService.getCountry()
            def currentEnv = projectService.getCurrentEnvironment()
            flash.success_msg = 'Your account is successfully confirmed for partner page.'
            render (view: '/user/partner/create/index', model:[currentEnv: currentEnv, country: country, partner: partner, user: user])
        } else {
            render view: '/404error'
        }
    }
    
    @Secured(['IS_AUTHENTICATED_FULLY'])
    def partnerautosave() {
        def user = userService.getCurrentUser()
        Partner partner = userService.getPartnerById(params.int('partnerId'))
        if (request.xhr) {
            if (partner) {
                if (partner.user == user) {
                    userService.updatePartnerInfo(partner, params)
                    render ''
                } else {
                    render 'Sorry you are not authorized to make changes.'
                }
            } else {
                render 'Sorry you are not authorized to make changes.'
            }
        } else {
            render view: '/404error'
        }
    }
    
    @Secured(['IS_AUTHENTICATED_FULLY'])
    def savedescription() {
        def user = userService.getCurrentUser()
        Partner partner = userService.getPartnerById(params.int('partnerId'))
        if (request.xhr) {
            if (partner) {
                if (partner.user == user) {
                    partner.description = params.description
                    render ''
                } else {
                    render 'Sorry you are not authorized to make changes.'
                }
            } else {
                render 'Sorry you are not authorized to make changes.'
            }
        } else {
            render view: '/404error'
        }
    }
    
    @Secured(['IS_AUTHENTICATED_FULLY'])
    def isCustomUrlUnique() {
        def user = userService.getCurrentUser()
        Partner partner = userService.getPartnerById(params.int('partnerId'))
        if (request.xhr) {
            if (partner) {
                if (partner.user == user) {
                    def status = userService.isCustomUrlUnique(params, partner)
                    render status
                } else {
                    render 'Sorry you are not authorized to make changes.'
                }
            } else {
                render 'Sorry you are not authorized to make changes.'
            }
        } else {
            render view: '/404error'
        }
    }
    
    @Secured(['IS_AUTHENTICATED_FULLY'])
    def partnersave() {
        Partner partner = userService.getPartnerById(params.int('partnerId'))
        User user = userService.getCurrentUser()
        boolean saved = true
        if (partner){
            if (partner.user == user) {
                partner.draft = false
                render (view: '/user/partner/create/justcreated', model:[partner: partner, saved: saved])
            }
        }
    }

    @Secured(['ROLE_ADMIN'])
    def verifypartner() {
        Partner partner = userService.getPartnerById(params.int('id'))
        if (partner) {
            if (!userService.isPartner(partner.user)) {
                userService.createPartnerRole(partner.user, roleService)
            }
            
            partner.validated = true
            partner.save()
            flash.validationSuccessMsg = "Partner is validated successfully!"
            redirect action:'managePartner'
        } else {
            render view:'/404error'
        }
    }
    
    @Secured(['IS_AUTHENTICATED_FULLY'])
    def editpartner() {
        Partner partner = userService.getPartnerById(params.int('partnerId'))
        User currentUser = userService.getCurrentUser()
        if (partner) {
            if(partner.user == currentUser) {
                def country = projectService.getCountry()
                def currentEnv = projectService.getCurrentEnvironment()
                render (view: '/user/partner/create/index', model:[currentEnv: currentEnv, country: country, partner: partner, user: currentUser])
            } else {
                 render view:'/401error'
            }
        } else {
            render view:'/404error'
        }
    }
    
    @Secured(['ROLE_ADMIN'])
    def rejectpartner() {
        Partner partner = userService.getPartnerById(params.int('id'))
        if (partner) {
            partner.rejected = true
            partner.save()
            flash.validationSuccessMsg = "Partner is discarded successfully!"
            redirect action:'managePartner'
        } else {
            render view:'/404error'
        }
    }
    
    @Secured(['ROLE_ADMIN'])
    def reInvitePartner() {
        Partner partner = userService.getPartnerById(params.int('id'))
        if (partner) {
            mandrillService.sendReInvitationEmailToPartner(partner)
            flash.validationSuccessMsg = "Partner is discarded successfully!"
            redirect action:'managePartner'
        } else {
            render view:'/404error'
        }
    }
    
}
