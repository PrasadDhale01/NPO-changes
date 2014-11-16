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

    @Secured(['IS_AUTHENTICATED_FULLY'])
    def dashboard() {
        User user = (User)userService.getCurrentUser()
        if (userService.isAdmin()) {
            redirect action: 'admindashboard'
        } else {
            def projects = Project.findAllByUser(user)
            def email = user.email
            def projectAdmins = ProjectAdmin.findAllByEmail(email)
            def project = projectService.getProjects(projects, projectAdmins)
            def contributions = Contribution.findAllByUser(user)
            
            render view: 'user/dashboard', model: [user: user, projects: project, contributions: contributions]
        }
    }

    def VALID_IMG_TYPES = ['image/png', 'image/jpeg']
    def upload_avatar() {
        def avatarUser = User.get(params.id)
        def imageFile = request.getFile('avatar')

        if (!imageFile.isEmpty() && imageFile.size < 1024*1024) {
            if (!VALID_IMG_TYPES.contains(imageFile.getContentType())) {
                flash.message = "Image must be one of: ${VALID_IMG_TYPES}"
                render (view: 'user/usererror')
                return
            } else {
                def url = userService.getImageUrl(imageFile)
                avatarUser.userImageUrl = url
            }
        } else {
            flash.message = "Size of the image must be less than [1024 * 1024]"
            render (view: 'user/usererror')
            return
        }

        redirect(action:'dashboard') 
    }
}
