package fedu

import grails.plugin.springsecurity.annotation.Secured

class UserController {
    def userService
    def projectService

    @Secured(['ROLE_ADMIN'])
    def admindashboard() {
        User user = (User)userService.getCurrentUser()
        render view: 'admin/dashboard', model: [user: user]
    }
    
    @Secured(['ROLE_ADMIN'])
    def list() {
        def users = User.list()
        render(view: 'admin/userList', model: [users:users])
    }


    @Secured(['IS_AUTHENTICATED_FULLY'])
    def dashboard() {
       userprofile('user/dashboard')
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
}
