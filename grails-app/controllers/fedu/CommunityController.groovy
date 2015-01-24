package fedu

import grails.plugin.springsecurity.annotation.Secured
import org.apache.commons.validator.EmailValidator

class CommunityController {
    def userService
    def roleService
    def communityService
    def communityInviteService
    def mailService

    def FORMCONSTANTS = [
        TITLE: 'title',
        DESCRIPTION: 'description',
        SUGGESTEDCREDIT: 'suggestedCredit'
    ]


    @Secured(['ROLE_COMMUNITY_MGR'])
    def create() {
        render view: 'create/index', model: [FORMCONSTANTS: FORMCONSTANTS]
    }

    @Secured(['ROLE_COMMUNITY_MGR'])
    def save() {
        Community community = new Community(params)
        community.manager = userService.getCurrentUser()

        if (!community.save(failOnError: true)) {
            render (view: '/error')
        } else {
            redirect(action: 'manage')
        }
    }

    @Secured(['ROLE_COMMUNITY_MGR'])
    def manage() {
        render view: 'manager/manage', model: [
            communities: communityService.getCommunitiesOwnedByManager(userService.getCurrentUser()),
            FORMCONSTANTS: FORMCONSTANTS
        ]
    }

    @Secured(['ROLE_COMMUNITY_MGR'])
    def updateSuggestedCredit() {
        Community community = Community.findById(params.int('communityId'))
        double suggestedCredit

        try {
            suggestedCredit = params.double(FORMCONSTANTS.SUGGESTEDCREDIT)
        } catch (Exception e) {
            flash.invalidsuggestedcredit = params[FORMCONSTANTS.SUGGESTEDCREDIT]
            redirect(action: 'manage')
            return
        }

        community.suggestedCredit = suggestedCredit
        if (!community.save(failOnError: true)) {
            render (view: '/error')
        } else {
            redirect(action: 'manage')
        }
    }

    @Secured(['ROLE_COMMUNITY_MGR'])
    def invite() {

        String emails = params.emails

        if (emails.isEmpty()) {
            redirect(action: 'manage')
            return
        }

        // Split comma-separated values
        def emailList = emails.split(',')
        emailList = emailList.collect { it.trim() }

        // Validate that all email addresses are valid format
        EmailValidator emailValidator = EmailValidator.getInstance()
        boolean allEmailsValid = true
        def invalidEmails = []
        emailList.each { email ->
            if (!emailValidator.isValid(email)) {
                allEmailsValid = false
                invalidEmails.add(email)
            }
        }
        if (!allEmailsValid) {
            flash.invalidemails = invalidEmails.join(", ")
            redirect action: 'manage'
            return
        }

        // Confirm that all users exist in the system before sending the invites
        def nonExistentUsers = []
        emailList.each { email ->
            // Check if the user with this email exists
            User user = userService.findUserByEmail(email)
            if (!user) {
                nonExistentUsers.add(email)
            }
        }
        if (nonExistentUsers.size() > 0) {
            flash.nonexistentusers = nonExistentUsers.join(", ")
            redirect action: 'manage'
            return
        }

        // Check which users already exist in the community
        Community community = Community.findById(params.int('communityId'))
        def usersToBeInvitedToCommunity = []
        def usersAlreadyInCommunity = []
        emailList.each { email ->
            User user = userService.findUserByEmail(email)
            if (!communityService.isMemberInCommunity(community, user)) {
                usersToBeInvitedToCommunity.add(user)
            } else {
                usersAlreadyInCommunity.add(email)
            }
        }
        flash.existingmembers = usersAlreadyInCommunity.join(", ")

        // Invite users
        usersToBeInvitedToCommunity.each { User user ->
            // Check if an invite has already been sent
            CommunityInvite communityInvite = communityInviteService.getInviteByCommunityAndUser(community, user)
            if (communityInvite) {
                emailInvite(communityInvite.community, communityInvite.user)
            } else {
                emailInvite(community, user)
            }
        }

        redirect(action: 'manage')

    }

    @Secured(['ROLE_COMMUNITY_MGR'])
    private def emailInvite(Community community, User user) {
        CommunityInvite invite = new CommunityInvite(community: community, user: user)
        invite.inviteCode = UUID.randomUUID().toString()
        invite.save()
        mailService.sendMail {
            async true
            to user.email
            from "info@fedu.org"
            subject "Crowdera - Invitation to join community"
            html g.render(template: 'manager/communityinviteemailtemplate',
                model: [code: invite.inviteCode, community: community, user: user])
        }
    }

    @Secured(['ROLE_USER'])
    def accept_invite(String id) {
        CommunityInvite communityInvite = CommunityInvite.findByInviteCodeAndUser(id, userService.getCurrentUser())

        if (!communityInvite) {
            flash.error = "Problem processing this invitation. Please check your invitation link"
            render view: '/error'
            return
        }

        // Add the user to community
        Community community = communityInvite.community
        User user = communityInvite.user
        community.addToMembers(user).save()

        // If save went well, then mark this invitation as accepted
        communityInvite.accepted = true
        communityInvite.save()

        flash.success_message = "Congratulations! You are now a member of ${community.title}."
        render view: '/success'
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
                flash.community_message = 'User with email "' + params.email + '" authorized to be a community manager'
            } else {
                flash.error = 'User with email "' + params.email + '" not found.'
            }
        }
        redirect (action: 'manageall')
    }
}
