package fedu

import grails.transaction.Transactional
import org.apache.commons.validator.EmailValidator

class UserService {

    def springSecurityService
    def roleService

    def getEmail() {
        EmailValidator emailValidator = EmailValidator.getInstance()

        User user = getCurrentUser()
        if (user.email) {
            return user.email
        } else if (emailValidator.isValid(user.username)) {
            return user.username
        } else {
            return null
        }
    }

    def getFriendlyName() {
        return getFriendlyName(getCurrentUser())
    }

    def getFriendlyName(User user) {
        def friendlyName = user.firstName
        if (!friendlyName) {
            friendlyName = user.email
        }
        if (!friendlyName) {
            friendlyName = user.username
        }
        return friendlyName
    }

    def isFacebookUser() {
        return isFacebookUser(getCurrentUser())
    }

    def isCommunityManager() {
        if (UserRole.findByUserAndRole(getCurrentUser(), roleService.communityManagerRole())) {
            return true
        } else {
            return false
        }
    }

    def isAdmin() {
        if (UserRole.findByUserAndRole(getCurrentUser(), roleService.adminRole())) {
            return true
        } else {
            return false
        }
    }

    def isAuthor() {
        if (UserRole.findByUserAndRole(getCurrentUser(), roleService.authorRole())) {
            return true
        } else {
            return false
        }
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

    @Transactional
    def bootstrap() {
        def admin = User.findByUsername('admin@fedu.org')
        if (!admin) {
            admin = new User(username: 'admin@fedu.org', password: 'P@$$w0rd').save(flush: true, failOnError: true)
        }
        UserRole.findOrSaveByUserAndRole(admin, roleService.adminRole())

        def user = User.findByUsername('user@example.com')
        if (!user) {
            user = new User(username: 'user@example.com', password: 'password').save(flush: true, failOnError: true)
        }
        UserRole.findOrSaveByUserAndRole(user, roleService.userRole())

        def author = User.findByUsername('author@fedu.org')
        if (!author) {
            author = new User(username: 'author@fedu.org', password: 'P@$$w0rd').save(flush: true, failOnError: true)
        }
        UserRole.findOrSaveByUserAndRole(author, roleService.authorRole())

        def samplecommunitymgr = User.findByUsername('communitymgr@example.com')
        if (!samplecommunitymgr) {
            samplecommunitymgr = new User(username: 'communitymgr@example.com', password: 'password').save(flush: true, failOnError: true)
        }
        UserRole.findOrSaveByUserAndRole(samplecommunitymgr, roleService.communityManagerRole())
    }

    @Transactional
    def bootstrapDeepshikha() {
        def deepshikha = User.findByUsername('info@deepshikha.org')
        if (!deepshikha) {
            deepshikha = new User(username: 'info@deepshikha.org', password: 'password').save(flush: true, failOnError: true)
        }
        UserRole.findOrSaveByUserAndRole(deepshikha, roleService.userRole())
        return deepshikha
    }
}
