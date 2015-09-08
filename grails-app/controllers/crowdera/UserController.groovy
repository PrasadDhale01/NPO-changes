package crowdera

import grails.plugin.springsecurity.annotation.Secured
import org.springframework.security.core.context.SecurityContextHolder;
import grails.util.Environment

class UserController {
    def userService
    def projectService
	def mandrillService
    def contributionService

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
        } else {
            def projects = projectService.getAllProjectByUser(user, environment)
            def projectAdmins = projectService.getProjectAdminEmail(user)
            def teams = projectService.getTeamByUserAndEnable(user, true)
            def project = projectService.getProjects(projects, projectAdmins, teams, environment)
            def contributions = projectService.getContibutionByUser(user, environment)
            render view: userViews, model: [user: user, projects: project, contributions: contributions, activeTab:activeTab, environment: environment]
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
}
