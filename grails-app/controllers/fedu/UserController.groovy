package fedu

import grails.plugin.springsecurity.annotation.Secured

@Secured(['IS_AUTHENTICATED_FULLY'])
class UserController {
    def userService

    @Secured(['IS_AUTHENTICATED_FULLY'])
    def profile() {
        User user = (User)userService.getCurrentUser()
        def projects = Project.findAllByUser(user)
        def contributions = Contribution.findAllByUser(user)
        if (userService.isAdmin()) {
            Set<User> communitymgrs = userService.getAllCommunityMgrs()
            render view: 'profile/admin/index', model: [user: user, communitymgrs: communitymgrs]
        } else {
            render view: 'profile/index', model: [user: user, projects: projects, contributions: contributions]
        }
    }

}
