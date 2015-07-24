package crowdera

import org.junit.internal.runners.statements.FailOnTimeout;
import grails.plugin.springsecurity.oauth.GoogleOAuthToken
import grails.plugin.springsecurity.SpringSecurityUtils
import grails.converters.JSON

class GooglePlusService {
    def oauthService
    def roleService

    def createAuthToken(accessToken){
        def response = oauthService.getGoogleResource(accessToken, 'https://www.googleapis.com/oauth2/v1/userinfo')
        def userDetails
        User user
        GooglePlusUser googlePlusUser

        try {
            userDetails = JSON.parse(response.body)
        } catch (Exception e) {
            log.error "Error parsing response from Google. Response:\n${response.body}"
        }
        if (!userDetails?.email) {
            log.error "No user email from Google. Response:\n${response.body}"
        }
        googlePlusUser = GooglePlusUser.findByUid(userDetails.id)
   
        if (googlePlusUser) {
            user = user.findByUsername(userDetails.id)
        } else {
            user = new User()
            user.username = userDetails.id
            user.email = userDetails.email
            user.password = userDetails.id
            user.userImageUrl = userDetails.picture
            user.firstName = userDetails.given_name
            user.lastName = userDetails.family_name
            user.save()
    
            if (!user.save()) {
                log.error 'Problem creating Google user, Response:\n${response.body}'
            } else {
                UserRole.create(user, roleService.googlePlusRole())
                UserRole.create(user, roleService.userRole())
            }

            googlePlusUser = new GooglePlusUser()
            googlePlusUser.uid = userDetails.id
            googlePlusUser.accessToken = accessToken
            googlePlusUser.user = user
            googlePlusUser.save()
        }
    
        GoogleOAuthToken oAuthToken = new GoogleOAuthToken(accessToken, userDetails.email)
        if (googlePlusUser) {
            oAuthToken.principal = user
            oAuthToken.authenticated = true
        }
        return oAuthToken
    }
}
