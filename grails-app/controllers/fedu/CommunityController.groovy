package fedu

import grails.plugin.springsecurity.annotation.Secured

class CommunityController {
    def userService
    def roleService

    @Secured(['ROLE_ADMIN'])
    def manage() {
        User user = (User)userService.getCurrentUser()

        render view: 'admin/index', model: [
            user: user,
            communities: Community.list(),
            communitymgrs: userService.getAllCommunityMgrs()
        ]
    }

    @Secured(['ROLE_ADMIN'])
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

    @Secured(['ROLE_ADMIN'])
    def addcommunitymgr() {
        if (params.email) {
            User user = User.findByEmail(params.email)
            if (user) {
                UserRole.findOrSaveByUserAndRole(user, roleService.communityManagerRole())
                flash.message = 'User with email "' + params.email + '" authorized to be a community manager'
            } else {
                flash.error = 'User with email "' + params.email + '" not found.'
            }
        }
        redirect (action: 'manage')
    }
}
