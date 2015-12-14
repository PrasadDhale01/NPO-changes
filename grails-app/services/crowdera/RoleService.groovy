package crowdera

import grails.transaction.Transactional

class RoleService {

    /* Constants */
    def ROLE_ADMIN = 'ROLE_ADMIN'
    def ROLE_USER = 'ROLE_USER'
    def ROLE_ANONYMOUS= 'ROLE_ANONYMOUS'
    def ROLE_AUTHOR = 'ROLE_AUTHOR'
    def ROLE_FACEBOOK = 'ROLE_FACEBOOK'
    def ROLE_COMMUNITY_MGR = 'ROLE_COMMUNITY_MGR'
    def ROLE_GOOGLE_PLUS = 'ROLE_GOOGLE_PLUS'
    def ROLE_PARTNER = 'ROLE_PARTNER'

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
    
    def anonymousRole() {
        return Role.findByAuthority(ROLE_ANONYMOUS)
    }

    def facebookRole() {
        return Role.findByAuthority(ROLE_FACEBOOK)
    }

    def communityManagerRole() {
        return Role.findByAuthority(ROLE_COMMUNITY_MGR)
    }
    
    def googlePlusRole() {
        return Role.findByAuthority(ROLE_GOOGLE_PLUS)
    }
    
    def partnerRole() {
        return Role.findByAuthority(ROLE_PARTNER)
    }

    /* Bootstrap */
    @Transactional
    def bootstrap() {
        Role.findOrSaveByAuthority(ROLE_ADMIN);
        Role.findOrSaveByAuthority(ROLE_USER);
        Role.findOrSaveByAuthority(ROLE_AUTHOR);
        Role.findOrSaveByAuthority(ROLE_FACEBOOK);
        Role.findOrSaveByAuthority(ROLE_COMMUNITY_MGR);
        Role.findOrSaveByAuthority(ROLE_ANONYMOUS);
        Role.findOrSaveByAuthority(ROLE_GOOGLE_PLUS);
        Role.findOrSaveByAuthority(ROLE_PARTNER);
    }
}
