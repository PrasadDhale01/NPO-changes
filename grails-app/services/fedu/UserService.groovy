package fedu

import grails.transaction.Transactional

class UserService {

    def springSecurityService

    def ROLE_ADMIN = 'ROLE_ADMIN'
    def ROLE_USER = 'ROLE_USER'
    def ROLE_AUTHOR = 'ROLE_AUTHOR'
    def ROLE_FACEBOOK = 'ROLE_FACEBOOK'

    def getFriendlyName(User user) {
        def friendlyName = user.firstName
        if (!friendlyName) {
            friendlyName = user.email
        }
        return friendlyName
    }

    def isFacebookUser(User user) {
        if (FacebookUser.findByUser(user)) {
            return true;
        } else {
            return false;
        }
    }

    def getCurrentUser() {
        return springSecurityService.getCurrentUser()
    }

    def isLoggedIn() {
        return springSecurityService.isLoggedIn()
    }

    def adminRole() {
        return Role.findByAuthority(ROLE_ADMIN)
    }

    def userRole() {
        return Role.findByAuthority(ROLE_USER)
    }

    def authorRole() {
        return Role.findByAuthority(ROLE_AUTHOR)
    }

    def facebookRole() {
        return Role.findByAuthority(ROLE_FACEBOOK)
    }

    @Transactional
    def bootstrap() {
        def adminRole = Role.findOrSaveByAuthority(ROLE_ADMIN)
        def userRole = Role.findOrSaveByAuthority(ROLE_USER)
        def authorRole = Role.findOrSaveByAuthority(ROLE_AUTHOR)
        def facebookRole = Role.findOrSaveByAuthority(ROLE_FACEBOOK)

        def admin = User.findByUsername('admin@fedu.org')
        if (!admin) {
            admin = new User(username: 'admin@fedu.org', password: 'P@$$w0rd').save(flush: true, failOnError: true)
        }
        def user = User.findByUsername('user@fedu.org')
        if (!user) {
            user = new User(username: 'user@fedu.org', password: 'password').save(flush: true, failOnError: true)
        }
        def author = User.findByUsername('author@fedu.org')
        if (!author) {
            author = new User(username: 'author@fedu.org', password: 'P@$$w0rd').save(flush: true, failOnError: true)
        }

        UserRole.findOrSaveByUserAndRole(admin, adminRole)
        UserRole.findOrSaveByUserAndRole(user, userRole)
        UserRole.findOrSaveByUserAndRole(author, authorRole)
    }

    @Transactional
    def bootstrapDeepshikha() {
        def deepshikha = User.findByUsername('info@deepshikha.org')
        if (!deepshikha) {
            deepshikha = new User(username: 'info@deepshikha.org', password: 'password').save(flush: true, failOnError: true)
        }
        UserRole.findOrSaveByUserAndRole(deepshikha, userRole())
        return deepshikha
    }
}
