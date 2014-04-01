package fedu

import grails.plugin.springsecurity.annotation.Secured

@Secured(['ROLE_ADMIN'])
class CommunityController {
    def userService
    def roleService

    def manage() {
        User user = (User)userService.getCurrentUser()

        render view: 'admin/index', model: [
            user: user,
            communities: Community.list(),
            communitymgrs: userService.getAllCommunityMgrs()
        ]
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
