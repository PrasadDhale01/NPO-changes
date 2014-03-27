package fedu

import com.the6hours.grails.springsecurity.facebook.FacebookAuthToken
import grails.plugin.springsecurity.SpringSecurityUtils

import grails.plugin.facebooksdk.FacebookGraphClient

class FacebookAuthService {

    def getFacebookLoginRedirectUrl() {
        def conf = SpringSecurityUtils.securityConfig.facebook
        String target = conf.filter.redirect.redirectFromUrl
        return target
    }

    void afterCreate(FacebookUser fbUser, FacebookAuthToken token) {
        def facebookClient = new FacebookGraphClient(token.accessToken.accessToken)
        def fbUserInfo = facebookClient.fetchObject("me")

        User user = User.findById(fbUser.userId)
        user.firstName = fbUserInfo.first_name
        user.lastName = fbUserInfo.last_name
        user.email = fbUserInfo.email
        user.save()
    }

}
