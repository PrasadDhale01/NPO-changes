package crowdera

import org.junit.internal.runners.statements.FailOnTimeout;
import grails.plugin.springsecurity.oauth.GoogleOAuthToken
import grails.plugin.springsecurity.SpringSecurityUtils
import grails.converters.JSON

class GooglePlusService {
    def oauthService
    def roleService
    def userService

    def createAuthToken(accessToken) {
        println "kartiki"
        def response = oauthService.getGoogleResource(accessToken, 'https://www.googleapis.com/oauth2/v1/userinfo')
        def userDetails
        User user
        GooglePlusUser googlePlusUser
        GoogleOAuthToken oAuthToken

        try {
            userDetails = JSON.parse(response.body)
        } catch (Exception e) {
            log.error "Error parsing response from Google. Response:\n${response.body}"
        }
        if (!userDetails?.email) {
            log.error "No user email from Google. Response:\n${response.body}"
        }
        
        if(userDetails){
            googlePlusUser = GooglePlusUser.findByUid(userDetails.id)
            if (googlePlusUser) {
                user = updateUser(googlePlusUser.user, userDetails)
            } else {
            def newuser = User.findByEmail(userDetails.email)
            
                user = new User()
                user.username = userDetails.id
                if(newuser){
                user.email = null
                } else {
                user.email = userDetails.email
                }
                user.password = userDetails.id
                if (userDetails.picture){
                    user.userImageUrl = userDetails.picture
                }
                user.firstName = userDetails.given_name
                user.lastName = userDetails.family_name
                user.save()
    
                if (!user.save()) {
                    log.error "Problem creating Google user, Response:\n${response.body}"
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
            
            oAuthToken = new GoogleOAuthToken(accessToken, userDetails.email)
            if (googlePlusUser) {
                oAuthToken.principal = user
                oAuthToken.authenticated = true
            }
        } else {
            oAuthToken = null;
        }
        return ['oAuthToken':oAuthToken,'userEmail':userDetails.email]
    }
    
    def updateUser(User user, def userDetails) {
        boolean isUserDetailsChanged = false;
        if (user.userImageUrl != userDetails.picture){
            if (userDetails.picture){
                user.userImageUrl = userDetails.picture
                isUserDetailsChanged = true
            }
        }
        if (user.firstName != userDetails.picture){
            if (userDetails.given_name){
                user.firstName = userDetails.given_name
                isUserDetailsChanged = true
            }
        }
        if (user.lastName != userDetails.family_name){
            if (userDetails.family_name){
                user.lastName = userDetails.family_name
                isUserDetailsChanged = true
            }
        }
        
        if(isUserDetailsChanged == true){
            user.save()   
        }
        
        return user
    }
    
    def mergeGooglePlusUser(def email) {
        User user = userService.getCurrentUser();
        GooglePlusUser googlePlusUser = GooglePlusUser.findByUser(user)
        def userObj = User.findByEmail(email)
    
        if (userObj) {
            if (userObj.id != user.id) {
                googlePlusUser.user = userObj
                if(googlePlusUser.save()) {
                    List userRoles = UserRole.findAllWhere(user: user)
                    userRoles.each{ userRole ->
                        userRole.delete();
                    }
                    user.delete();
                }
            }
            if (userObj.enabled == false) {
                userObj.enabled = true
                userObj.save()
            }
        }
    }
}
