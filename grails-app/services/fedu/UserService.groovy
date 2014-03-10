package fedu

import grails.transaction.Transactional

@Transactional
class UserService {

    def ROLE_ADMIN = 'ROLE_ADMIN'
    def ROLE_USER = 'ROLE_USER'

    def adminRole() {
        return Role.findByAuthority(ROLE_ADMIN)
    }

    def userRole() {
        return Role.findByAuthority(ROLE_USER)
    }

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
        def deepshikha = User.findByUsername('info@deepshikha.org')
        if (!deepshikha) {
            deepshikha = new User(username: 'info@deepshikha.org', password: 'password').save(flush: true, failOnError: true)
        }

        UserRole.findOrSaveByUserAndRole(admin, adminRole)
        UserRole.findOrSaveByUserAndRole(user, userRole)
    }
}
