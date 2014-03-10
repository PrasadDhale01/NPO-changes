package fedu

import grails.transaction.Transactional

@Transactional
class UserService {

    def ROLE_ADMIN = 'ROLE_ADMIN'
    def ROLE_USER = 'ROLE_USER'

    def bootstrap() {
        def adminRole = Role.findOrSaveByAuthority(ROLE_ADMIN)
        def userRole = Role.findOrSaveByAuthority(ROLE_USER)

        def admin = User.findByUsername('admin@fedu.org')
        if (!admin) {
            admin = new User(username: 'admin@fedu.org', password: 'FundEdu@2014').save(flush: true, failOnError: true)
        }
        def user = User.findByUsername('user@fedu.org')
        if (!user) {
            user = new User(username: 'user@fedu.org', password: 'password').save(flush: true, failOnError: true)
        }

        UserRole.create(admin, adminRole, true)
        UserRole.create(user, userRole, true)
    }
}
