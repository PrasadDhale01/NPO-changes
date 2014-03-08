package fedu

import grails.transaction.Transactional

@Transactional
class UserService {

    def bootstrap() {
        def adminRole = new Role(authority: 'ROLE_ADMIN').save(flush: true)
        def userRole = new Role(authority: 'ROLE_USER').save(flush: true)

        def testUser = new User(username: 'admin', password: 'FundEdu@2014')
        testUser.save(flush: true)

        UserRole.create testUser, adminRole, true
    }
}
