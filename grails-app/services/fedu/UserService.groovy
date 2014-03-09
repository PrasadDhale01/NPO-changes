package fedu

import grails.transaction.Transactional

@Transactional
class UserService {

    def bootstrap() {
        def adminRole = new Role(authority: 'ROLE_ADMIN').save(flush: true)
        def userRole = new Role(authority: 'ROLE_USER').save(flush: true)

        def admin = new User(username: 'admin@fedu.org', password: 'password').save(flush: true)
        def user = new User(username: 'user@fedu.org', password: 'password').save(flush: true)

        UserRole.create(admin, adminRole, true)
        UserRole.create(user, userRole, true)
    }
}
