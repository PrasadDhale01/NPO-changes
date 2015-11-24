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
        if (userService.isAdmin()) {
            redirect action: 'admindashboard'
        } else if(userService.isPartner()) {
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
                teams = projectService.getTeamByUserAndEnable(user, true)
                project = projectService.getProjects(projects, projectAdmins, teams, environment)
            }
            
            List totalCampaings = []
            if (activeTab == 'campaigns') {
                def max = Math.min(params.int('max') ?: 4, 100)
                totalCampaings = projectService.getUsersPaginatedCampaigns(project, params, max)
            } else {
                def max = Math.min(params.int('max') ?: 2, 100)
                totalCampaings = projectService.getUsersPaginatedCampaigns(project, params, max)
            }
            
            def contribution
            if (activeTab == 'contributions') {
                def max = Math.min(params.int('max') ?: 4, 100)
                contribution = projectService.getPaginatedContibutionByUser(user, environment,params, max)
            } else {
                def max = Math.min(params.int('max') ?: 2, 100)
                contribution = projectService.getPaginatedContibutionByUser(user, environment,params, max)
            }
            
            def contributedAmount = projectService.getContributedAmount(contribution.contributions)
            def fundRaised = projectService.getTotalFundRaisedByUser(projects)
            def country = projectService.getCountry()
            def state = projectService.getState()
            def multiplier = projectService.getCurrencyConverter();
            def countryOpts = [India: 'INDIA', USA: 'USA']
            
            render view: userViews, model: [user: user, projects: project, totalCampaings: totalCampaings,country: country, fundRaised: fundRaised, state: state,
                                            activeTab:activeTab, environment: environment, contributedAmount: contributedAmount, multiplier: multiplier, countryOpts: countryOpts,
                                            contributions: contribution.contributions, totalContributions : contribution.totalContributions, sortByOptions: sortByOptions]
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
        def model = [totalUsers: userObj.totalUsers, verifiedUsers: userObj.users]
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
        def teams = projectService.getTeamByUserAndEnable(user, true)
        List project = projectService.getProjects(projects, projectAdmins, teams, environment)
        def max = Math.min(params.int('max') ?: 4, 100)
        List totalCampaings = projectService.getUsersPaginatedCampaigns(project, params, max)
        def multiplier = projectService.getCurrencyConverter();
        
        def model = [totalCampaings: totalCampaings, projects: project, dashboard: 'dashboard', activeTab: 'campaigns', multiplier: multiplier]
        if (request.xhr) {
            render(template: "user/myprojects", model: model)
        }
    }

    @Secured(['IS_AUTHENTICATED_FULLY'])
    def contributionspagination() {
        User user = userService.getCurrentUser()
        def environment = Environment.current.getName()
        def max = Math.min(params.int('max') ?: 4, 100)
        def contribution = projectService.getPaginatedContibutionByUser(user, environment, params, max)
        def multiplier = projectService.getCurrencyConverter();

        def model = [contributions: contribution.contributions, totalContributions : contribution.totalContributions, activeTab: 'contributions', multiplier: multiplier]
        if (request.xhr) {
            render(template: "/user/user/dashboardcontributiontile", model: model)
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
    def update() {
        User user = (User)userService.getCurrentUser()
        userService.setUserInfo(params,user)

        if (user.save()) {
            flash.user_message = "Profile updated successfully!"
            redirect (controller: 'user', action: 'dashboard')
        } else {
           render(view: 'error', model: [message: "Error while updating user. Please try again later."])
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
		flash.feedback_message = "Feedback submitted successfully!"
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
		render( view:"/user/survey/previewuserfeedback.gsp", model:[feedback:feedback, user:user])
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
    
    @Secured(['ROLE_ADMIN'])
    def managePartner() {
        List partners = Partner.list()
        render view:'/user/partner/index', model:[partners: partners]
    }
    
    @Secured(['ROLE_ADMIN'])
    def addpartner() {
        User user = userService.getUserByUsername(params.email)
        def password
        if (user) {
            if (!userService.isPartner(user)) {
                userService.createPartnerRole(user, roleService)
            }
        } else {
            def userObj = userService.setUserObject(params)
            user = userObj.user
            password = userObj.password
        }
        
        if (userService.getPartnerByUser(user)) {
            List partners = Partner.list()
            flash.alreadyExistMsg = "Partner with this email already exist."
            render view:'/user/partner/index', model:[partners: partners]
        } else {
            Partner partner = new Partner()
            partner.user = user
            
            partner.confirmCode = UUID.randomUUID().toString()
            if (partner.save()) {
                mandrillService.sendEmailToPartner(user, partner, password);
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
                    render(view: '/success', model: [sucess_message: 'Your account is successfully activated for Partner.'])
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
        def currentEnv = Environment.current.getName()
        def currentUser = userService.getCurrentUser()
        Partner partner
        if (params.id) {
            partner = userService.getPartnerById(params.int('id'))
        } else {
            partner = userService.getPartnerByUser(currentUser)
        }
        
        if (partner) {
            User user = partner.user
            def projects = projectService.getNonValidatedProjectsForPartner(user, partner)
            def campaigns = projectService.getValidatedProjectsForPartner(user, partner)
            def fundRaised = projectService.getTotalFundRaisedByUser(campaigns)
            def numberOfInvites = userService.getTotalNumberOfInvites(partner)
            def userCampaigns = projectService.getPartnerCampaigns(user)
            def country = projectService.getCountry()
            def state = projectService.getState()
            
            def requestUrl=request.getRequestURL().substring(0,request.getRequestURL().indexOf("/", 8))
            def baseUrl = (requestUrl.contains('www')) ? grailsApplication.config.crowdera.BASE_URL1 : grailsApplication.config.crowdera.BASE_URL
            
            if (flash.prj_validate_message) {
                flash.prj_validate_message = "Campaign validated successfully"
            }
            
            render view:'/user/partner/dashboard', model:[projects: projects, user: user, campaigns: campaigns, baseUrl: baseUrl, currentEnv: currentEnv,
                                                         fundRaised: fundRaised, numberOfInvites: numberOfInvites, userCampaigns: userCampaigns,
                                                         country: country, state: state]
        }
    }
    
    @Secured(['IS_AUTHENTICATED_FULLY'])
    def invite() {
        if (userService.isPartner()) {
            userService.inviteCampaignOwner(params)
            redirect action: 'partnerdashboard'
        } else {
            render view:'/401error'
        }
    }
    
}
