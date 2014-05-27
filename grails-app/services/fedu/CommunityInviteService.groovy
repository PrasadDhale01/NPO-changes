package fedu

import grails.transaction.Transactional

class CommunityInviteService {
    def getInviteByCommunityAndUser(Community community, User user) {
        CommunityInvite invite = CommunityInvite.findByCommunityAndUser(community, user)
        return invite
    }

    def getPendingInviteesForCommunity(Community community) {
        return CommunityInvite.findAllByCommunityAndAccepted(community, false)
    }

    def getNumberOfPendingInviteesForCommunity(Community community) {
        return getPendingInviteesForCommunity(community).size()
    }
}
