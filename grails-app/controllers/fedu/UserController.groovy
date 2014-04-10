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
}
