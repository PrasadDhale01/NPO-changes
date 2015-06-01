package crowdera

import grails.plugin.facebooksdk.FacebookGraphClient

class FacebookService {
    def userService

    def getUserFacebookUrl(User user) {
        if (userService.isFacebookUser(user)) {
            FacebookUser facebookUser = FacebookUser.findByUser(user)
            return 'https://www.facebook.com/'  + facebookUser.uid
        } else {
            return 'https://www.facebook.com/'
        }
    }
    
    def getFacebookUserDetails(User user) {
        FacebookUser fbUser = FacebookUser.findByUser(user)
        if (fbUser) {
            def accessToken = fbUser.accessToken
            def facebookClient = new FacebookGraphClient(accessToken)
            def fbUserInfo = facebookClient.fetchObject("me")
            
            if (user.firstName != fbUserInfo.first_name) {
                user.firstName = fbUserInfo.first_name
            }
            if (user.lastName != fbUserInfo.last_name) {
                user.lastName = fbUserInfo.last_name
            }
            if (user.email != fbUserInfo.email) {
                user.email = fbUserInfo.email
            }
            user.userImageUrl = "//graph.facebook.com/"+fbUser.uid+"/picture?type=large"
            user.save()
        }
    }
    
}
