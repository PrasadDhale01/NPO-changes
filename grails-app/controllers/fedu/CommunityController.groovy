package fedu

import grails.plugin.springsecurity.annotation.Secured

class CommunityController {
    def userService
    def roleService
    def communityService

    def FORMCONSTANTS = [
        TITLE: 'title',
        DESCRIPTION: 'description',
    ]


    @Secured(['ROLE_COMMUNITY_MGR'])
    def create() {
        render view: 'create/index', model: [FORMCONSTANTS: FORMCONSTANTS]
    }

    @Secured(['ROLE_COMMUNITY_MGR'])
    def save() {
        Community community = new Community(
            title: params.title,
            description: params.description,
            manager: userService.getCurrentUser())
        if (!community.save(failOnError: true)) {
            render (view: '/error')
        } else {
            redirect(action: 'manage')
        }
    }

    @Secured(['ROLE_COMMUNITY_MGR'])
    def manage() {
        render view: 'manager/manage', model: [
            communities: communityService.getCommunitiesOwnedByManager(userService.getCurrentUser())
        ]
    }

    @Secured(['ROLE_ADMIN'])
    def manageall() {
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

        redirect (action: 'manageall')
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
        redirect (action: 'manageall')
    }
}
