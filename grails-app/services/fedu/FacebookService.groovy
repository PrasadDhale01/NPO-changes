package fedu

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
}
