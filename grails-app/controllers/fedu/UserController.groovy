package fedu

import grails.plugin.springsecurity.annotation.Secured

class UserController {
    def userService

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
            def contributions = Contribution.findAllByUser(user)

            render view: 'user/dashboard', model: [user: user, projects: projects, contributions: contributions]
        }
    }

    def VALID_IMG_TYPES = ['image/png', 'image/jpeg']
    def upload_avatar() {
        def avatarUser = User.get(params.id)
        def imageFile = request.getFile('avatar')

        if (!imageFile.isEmpty()) {
            if (!imageFile.isEmpty() && !VALID_IMG_TYPES.contains(imageFile.getContentType())) {
                flash.message = "Image must be one of: ${VALID_IMG_TYPES}"
                render (view: 'user/usererror')
                return
            } else {
                def url = userService.getImageUrl(imageFile)
                avatarUser.userImageUrl = url
            }
        }
        redirect(action:'dashboard') 
    }
}
