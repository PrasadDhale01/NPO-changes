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
        if (params.double('amount') && params.int('id')) {
            Community community = Community.findById(params.int('id'))
            if (community) {
                new Credit(
                    amount: params.double('amount'),
                    community: community,
                    date: new Date()
                ).save(failOnError: true)
            }
        }

        redirect (action: 'manage')
    }
}
