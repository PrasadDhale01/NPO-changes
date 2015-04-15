package crowdera

import grails.transaction.Transactional

class CommunityService {
    def roleService

    def getNumberOfCommunities() {
        return Community.count()
    }

    def getMembersInCommunity(Community community) {
        return community.getMembers()
    }

    def isMemberInCommunity(Community community, User user) {
        def members = getMembersInCommunity(community)
        if (members.contains(user)) {
            return true
        } else {
            return false
        }
    }

    def getCommunitiesOwnedByManager(User manager) {
        return Community.findAllByManager(manager)
    }

    def getNumberofMembersInCommunity(Community community) {
        return getMembersInCommunity(community).size()
    }

    @Transactional
    def bootstrap() {

        def user1 = User.findByUsername('user1@community.com')
        if (!user1) {
            user1 = new User(username: 'user1@community.com', password: 'password').save(failOnError: true)
        }
        UserRole.findOrSaveByUserAndRole(user1, roleService.userRole())

        def user2 = User.findByUsername('user2@community.com')
        if (!user2) {
            user2 = new User(username: 'user2@community.com', password: 'password').save(failOnError: true)
        }
        UserRole.findOrSaveByUserAndRole(user2, roleService.userRole())

        def user3 = User.findByUsername('user3@community.com')
        if (!user3) {
            user3 = new User(username: 'user3@community.com', password: 'password').save(failOnError: true)
        }
        UserRole.findOrSaveByUserAndRole(user3, roleService.userRole())

        def user4 = User.findByUsername('user4@community.com')
        if (!user4) {
            user4 = new User(username: 'user4@community.com', password: 'password').save(failOnError: true)
        }
        UserRole.findOrSaveByUserAndRole(user4, roleService.userRole())

        def user5 = User.findByUsername('user5@community.com')
        if (!user5) {
            user5 = new User(username: 'user5@community.com', password: 'password', enabled: false).save(failOnError: true)
        }
        UserRole.findOrSaveByUserAndRole(user4, roleService.userRole())

        def user6 = User.findByUsername('user6@community.com')
        if (!user6) {
            user6 = new User(username: 'user6@community.com', password: 'password', enabled: false).save(failOnError: true)
        }
        UserRole.findOrSaveByUserAndRole(user4, roleService.userRole())

        def manager = User.findByUsername('manager@community.com')
        if (!manager) {
            manager = new User(username: 'manager@community.com', password: 'password').save(failOnError: true)
        }
        UserRole.findOrSaveByUserAndRole(manager, roleService.userRole())
        UserRole.findOrSaveByUserAndRole(manager, roleService.communityManagerRole())

        Community community = Community.findOrSaveWhere(
            title: "A community for Community.com",
            description: "A community for community.com employees",
            manager: manager
        )
        def communityMembers = [user1, user2, user3, user4, user5, user6] as Set
        if (!community.getMembers() || !community.getMembers().containsAll(communityMembers)) {
            community.setMembers(communityMembers)
        }
        community.save()

    }
}
