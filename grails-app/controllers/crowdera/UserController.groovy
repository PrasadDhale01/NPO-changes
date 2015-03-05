package crowdera

import crowdera.Contribution;
import crowdera.Project;
import crowdera.ProjectAdmin;
import crowdera.Team;
import crowdera.User;
import grails.plugin.springsecurity.annotation.Secured

class UserController {
    def userService
    def projectService
	def mandrillService

    @Secured(['ROLE_ADMIN'])
    def admindashboard() {
        User user = (User)userService.getCurrentUser()
        render view: 'admin/dashboard', model: [user: user]
    }
    
    @Secured(['ROLE_ADMIN'])
    def list() {
        def verifiedUsers = userService.getVerifiedUserList()
		def nonVerifiedUsers = userService.getNonVerifiedUserList()
        render(view: 'admin/userList', model: [verifiedUsers:verifiedUsers,nonVerifiedUsers:nonVerifiedUsers])
    }


    @Secured(['IS_AUTHENTICATED_FULLY'])
    def dashboard() {
       userprofile('user/dashboard')
    }
	
	@Secured(['ROLE_ADMIN'])
	def resendConfirmMailByAdmin(){
		def user = User.get(params.id)
		user.confirmCode = UUID.randomUUID().toString()
		mandrillService.reSendConfirmationMail(user)
		flash.message = "Confirmation Email has been send to ${user.email}"
		redirect(action:'list')
	}
    
    @Secured(['IS_AUTHENTICATED_FULLY'])
    def userprofile(String userViews )
    {
        
        User user = (User)userService.getCurrentUser()
        if (userService.isAdmin()) {
            redirect action: 'admindashboard'
        } else {
            def projects = Project.findAllByUser(user)
            def email = user.email
            def projectAdmins = ProjectAdmin.findAllByEmail(email)
            def teams = Team.findAllByUser(user)
            def project = projectService.getProjects(projects, projectAdmins, teams)
            def contributions = Contribution.findAllByUser(user)
            
            render view: userViews, model: [user: user, projects: project, contributions: contributions]
        }
        
    }
    
    @Secured(['IS_AUTHENTICATED_FULLY'])
    def myproject() {
         userprofile('user/myproject')
    }
    
    @Secured(['IS_AUTHENTICATED_FULLY'])
    def mycontribution() {
        userprofile('user/mycontribution')
    }

    def VALID_IMG_TYPES = ['image/png', 'image/jpeg']
    
    @Secured(['IS_AUTHENTICATED_FULLY'])
    def upload_avatar() {
        def avatarUser = User.get(params.id)
        def imageFile = request.getFile('avatar')

        if (!imageFile.isEmpty() && imageFile.size < 1024*1024) {
            if (!VALID_IMG_TYPES.contains(imageFile.getContentType())) {
                flash.user_err_message = "Image must be one of: ${VALID_IMG_TYPES}"
                render (view: 'user/usererror')
                return
            } else {
                def url = userService.getImageUrl(imageFile)
                avatarUser.userImageUrl = url
            }
        } else {
            flash.user_err_message = "Size of the image must be less than [1024 * 1024]"
            render (view: 'user/usererror')
            return
        }
        flash.user_message = "Avatar added successfully"
        redirect(action:'dashboard') 
    }
    
    @Secured(['IS_AUTHENTICATED_FULLY'])
    def edit_avatar() {
        def avatarUser = User.get(params.id)
        def imageFile = request.getFile('profile')
        
        if (!imageFile.isEmpty() && imageFile.size < 1024*1024) {
            if (!VALID_IMG_TYPES.contains(imageFile.getContentType())) {
                flash.user_err_message = "Image must be one of: ${VALID_IMG_TYPES}"
                render (view: 'user/usererror')
                return
            } else {
                def url = userService.getImageUrl(imageFile)
                avatarUser.userImageUrl = url
            }
        } else {
            flash.user_err_message = "Size of the image must be less than [1024 * 1024]"
            render (view: 'user/usererror')
            return
        }
        flash.user_message = "Avatar updated successfully"
        redirect(action:'dashboard')
    }
    
    @Secured(['IS_AUTHENTICATED_FULLY'])
    def deleteavatar() {
        def avatarUser = User.get(params.id)
        if(avatarUser) {
            avatarUser.userImageUrl = null
            flash.user_message = "Avatar deleted successfully"
            redirect(action:'dashboard')
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
        def services = userService.sendResponseToCustomer(params)
        flash.servicemessage = "Successfully Responded"
        redirect action:'userquestionsList'
    }
}
