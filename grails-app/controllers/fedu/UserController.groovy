package fedu

import grails.plugin.springsecurity.annotation.Secured

@Secured(['IS_AUTHENTICATED_FULLY'])
class UserController {
    def userService

    @Secured(['ROLE_ADMIN'])
    def adminprofile() {
        User user = (User)userService.getCurrentUser()
        render view: 'profile/admin/index', model: [user: user]
    }

    @Secured(['IS_AUTHENTICATED_FULLY'])
    def profile() {
        User user = (User)userService.getCurrentUser()
        if (userService.isAdmin()) {
            redirect action: 'adminprofile'
        } else {
            def projects = Project.findAllByUser(user)
            def contributions = Contribution.findAllByUser(user)

            render view: 'profile/index', model: [user: user, projects: projects, contributions: contributions]
        }
    }
}
