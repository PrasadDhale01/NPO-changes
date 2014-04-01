package fedu

import grails.plugin.springsecurity.annotation.Secured

@Secured(['ROLE_ADMIN'])
class CommunityController {
    def userService

    def manage() {
        User user = (User)userService.getCurrentUser()

        render view: 'admin/index', model: [user: user, communities: Community.list()]
    }

    def addcredit() {
        if (params.double('amount')) {
            if (params.int('id')) {
                Community community = Community.findById(params.id)
                community.credit += params.double('amount')
                community.save(failOnError: true)
            }
        }

        redirect (action: 'manage')
    }
}
