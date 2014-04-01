package fedu

import grails.transaction.Transactional

class CommunityService {
    def roleService

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
        community.setMembers([user1, user2, user3, user4] as Set)
        community.save()

    }
}
