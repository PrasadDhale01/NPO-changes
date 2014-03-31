package fedu

import grails.plugin.springsecurity.annotation.Secured

@Secured(['ROLE_ADMIN'])
class CommunityController {
    def userService

    def manage() {
        User user = (User)userService.getCurrentUser()

        Set<User> communitymgrs = userService.getAllCommunityMgrs()
        render view: 'index', model: [user: user, communitymgrs: communitymgrs]
    }
}
