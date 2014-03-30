package fedu

import grails.transaction.Transactional

class RoleService {

    /* Constants */
    def ROLE_ADMIN = 'ROLE_ADMIN'
    def ROLE_USER = 'ROLE_USER'
    def ROLE_AUTHOR = 'ROLE_AUTHOR'
    def ROLE_FACEBOOK = 'ROLE_FACEBOOK'
    def ROLE_COMMUNITY_MGR = 'ROLE_COMMUNITY_MGR'

    /* Helpers */
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

    def communityManagerRole() {
        return Role.findByAuthority(ROLE_COMMUNITY_MGR)
    }

    /* Bootstrap */
    @Transactional
    def bootstrap() {
        def adminRole = Role.findOrSaveByAuthority(ROLE_ADMIN)
        def userRole = Role.findOrSaveByAuthority(ROLE_USER)
        def authorRole = Role.findOrSaveByAuthority(ROLE_AUTHOR)
        def facebookRole = Role.findOrSaveByAuthority(ROLE_FACEBOOK)
        def communityManagerRole = Role.findOrSaveByAuthority(ROLE_COMMUNITY_MGR)
    }
}
