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
        boolean isFbDetailsChanged = false;
        if (fbUser) {
            def accessToken = fbUser.accessToken
            def facebookClient = new FacebookGraphClient(accessToken)
            def fbUserInfo = facebookClient.fetchObject("me")
            def userObj = User.findByEmail(fbUserInfo.email)
            
            if (userObj) {
                if (userObj.id != user.id) {
                    return true;
                }
            }
            if (user.firstName != fbUserInfo.first_name) {
                if (fbUserInfo.first_name) {
                    user.firstName = fbUserInfo.first_name
                    isFbDetailsChanged = true
                }
            }
            if (user.lastName != fbUserInfo.last_name) {
                if (fbUserInfo.last_name) {
                    user.lastName = fbUserInfo.last_name
                    isFbDetailsChanged = true
                }
            }
            if (user.email != fbUserInfo.email) {
                if (fbUserInfo.email) {
                    user.email = fbUserInfo.email
                    isFbDetailsChanged = true
                }
            }
            if (!user.userImageUrl) {
                user.userImageUrl = "//graph.facebook.com/"+fbUser.uid+"/picture?type=large"
                isFbDetailsChanged = true
            }
            if (isFbDetailsChanged) {
                user.save()
            }
            return false;
        }
    }
    
    def mergeFacebookUser() {
        User user = userService.getCurrentUser();
        FacebookUser fbUser = FacebookUser.findByUser(user)
        def accessToken = fbUser.accessToken
        def facebookClient = new FacebookGraphClient(accessToken)
        def fbUserInfo = facebookClient.fetchObject("me")
        def userObj = User.findByEmail(fbUserInfo.email)
        
        if (userObj) {
            if (userObj.id != user.id) {
                fbUser.user = userObj
                if(fbUser.save()) {
                    List projectComments = ProjectComment.findAllWhere(user: user)
                    List teamComments = TeamComment.findAllWhere(user: user)
                    List teams = Team.findAllWhere(user: user)
                    List contributors = Contribution.findAllWhere(user: user)
                    if (projectComments.isEmpty() && teamComments.isEmpty() && teams.isEmpty() && contributors.isEmpty()) {
                    List userRoles = UserRole.findAllWhere(user: user)
                        userRoles.each{ userRole ->
                            userRole.delete();
                        }
                        user.delete();
                    }
                }
            }
        }
    }
    
}
