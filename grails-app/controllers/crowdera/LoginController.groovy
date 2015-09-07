package crowdera

import grails.plugin.springsecurity.SpringSecurityUtils;
import grails.plugin.springsecurity.annotation.Secured;
import javax.servlet.http.Cookie
import org.springframework.security.core.context.SecurityContextHolder;

class LoginController {

    def mandrillService
    def userService
    def roleService
    def grailsLinkGenerator
    def facebookService
    def googlePlusService
    def oauthService
    def projectService

    public static final String SPRING_SECURITY_OAUTH_TOKEN = 'springSecurityOAuthToken'

    boolean invite_user = false

    /**
     * Default action; redirects to 'defaultTargetUrl' if logged in.
     * Look at LoginController.groovy for example.
     */
    def index() {

        if (userService.isLoggedIn()) {
            redirect uri: SpringSecurityUtils.securityConfig.successHandler.defaultTargetUrl
        }
    }

    /* User canceled during Facebook connect */
    def facebook_user_denied() {
        render(view: 'error', model: [message: "Can't authenticate using Facebook. Seems like you've canceled Facebook authentication."])
    }
    
    def facebook_user_login() {
        User user = userService.getCurrentUser();
        boolean ifFbUserAlreadyExist = facebookService.getFacebookUserDetails(user);
        if (ifFbUserAlreadyExist) {
            redirect (controller:'home', action:'index', params:[fb: 'yes'])
        } else {
            String requestUrl = g.cookie(name: 'requestUrl')
            if (requestUrl) {
                def cookie = projectService.setCookie(requestUrl)
                response.addCookie(cookie)
                redirect (url: requestUrl)
            } else {
                redirect (controller:'home', action:'index')
            }
        }
    }
    
    def facebook_login() {
        if (params.userResponse.equalsIgnoreCase("yes")) {
            facebookService.mergeFacebookUser()
            String requestUrl = g.cookie(name: 'requestUrl')  //get Cookie
            if (requestUrl) {
                def cookie = projectService.setCookie(requestUrl)
                response.addCookie(cookie)
                redirect (url: requestUrl)
            } else {
                redirect (controller:'home', action:'index')
            }
        } else {
           redirect controller:'logout'
        }
    }

    def user_request(){
        def userName=userService.getUserByName(params.username)
        if (userName){
            render(view: 'error', model: [message: 'A user with that email already exists. Please use a different email.'])
        } else {
            def user = userService.getUserObject(params)
            user.enabled = false
            user.confirmed = false
            user.inviteCode = UUID.randomUUID().toString()
            
            if (!user.save()) {
                render(view: 'error', model: [message: 'Problem in saving your details'])
        } else {
            render(view: 'success', model: [message: 'Your request has been send to admin.'])
                
            mandrillService.sendUserResponseToUserRequest(user)
            }
        }    
    }

    @Secured(['ROLE_ADMIN'])
    def list() {
        def users = userService.getRequesteUsers()
        render(view: 'register/adminViewIndex', model: [users:users])
    }

    @Secured(['ROLE_ADMIN'])
    def invite() {
        invite_user = true
        flash.user_admin_message = "You have now switched the registration procedure to invite only mode "
        render(view: '/user/admin/dashboard')
        return (invite_user)
    }
    
    @Secured(['ROLE_ADMIN'])
    def openRegister(){
        invite_user = false
        flash.user_admin_message = "You have switched the registration procedure to open registration mode"
        render(view: '/user/admin/dashboard')
        return (invite_user)
    }  
	
    def create() {
        def userName=userService.getUserByName(params.username)
        def userObj = userService.findUserByEmail(params.username)
        def message
        if (userName) {
            message: 'A user with that email already exists. Please use a different email.'
        } else if (userService.isFacebookUser(userObj)) {
            message: 'A Facebook user with that email already exists. Please use a different email to register or login through Facebook.'
        } else if (userService.isGooglePlusUser(userObj)) {
            message: 'A Google Plus user with that email already exists. Please use a different email to register or login through Google Plus.'
        }
        
        if (userName || userObj) {
            def config = SpringSecurityUtils.securityConfig
            if (g.cookie(name: 'loginSignUpCookie')) {
                String postUrl = "${request.contextPath}${config.apf.filterProcessesUrl}"
                flash.signUpMessage = message
                render view: 'auth', model: [postUrl: postUrl,
                                           rememberMeParameter: config.rememberMe.parameter]
            } else {
                render(view: 'error', model: [message: message])
            }
        } else {
            def user = userService.getUserObject(params)
            user.enabled = false
            user.confirmCode = UUID.randomUUID().toString()

            if(params.name){
                StringTokenizer tokenizer = new StringTokenizer(params.name)
                if (tokenizer.hasMoreTokens()) {
                    user.firstName = tokenizer.nextToken()
                }
                if (tokenizer.hasMoreTokens()) {
                    user.lastName = tokenizer.nextToken()
                }
            }

            if (!user.save()) {
                render(view: 'error', model: [message: 'Problem creating user. Please try again.'])
            } else {
                userService.createUserRole(user, roleService)
                mandrillService.sendMandrillEmail(user)

                redirect(action: 'success')
            }
        }
    }

    @Secured(['IS_AUTHENTICATED_FULLY'])
    def update() {
        User user = (User)userService.getCurrentUser()
        userService.getUserUpdatedDetails(params,user)
		
        if (user.save()) {
            flash.user_message = "Profile updated successfully!"
            redirect (controller: 'user', action: 'accountSetting')
        } else {
           render(view: 'error', model: [message: "Error while updating user. Please try again later."])
        }
    }

    def success() {
        render(view: 'success',
                model: [message: 'Your account has been created. Please confirm your email address. Confirmation link has been sent to your account.']);
    }

    def confirm(String id) {
        User user = userService.getUserByConfirmCode(id)

        if (!user) {
            render(view: 'error', model: [message: 'Problem activating account. Please check your activation link.'])
        } else {
            if (user.enabled) {
                render(view: 'success', model: [message: 'Your account is successfully activated. It seems like you were already activated.'])

            } else {
                user.enabled = true
                if (!user.save()) {
                    render(view: 'error', model: [message: 'Problem activating account. Please contact the administrator.'])
                } else {
                    render(view: 'success', model: [message: 'Your account is successfully activated.'])
                }
            }
        }
    }

    def edit_reset() {
        render(view: 'forgot/edit_reset_email')
    }

    def register() {
        if (invite_user == true){
            render view: 'register/inviteOnlyMode'
        } else {
            render view: 'register/index'
        }
    }

    def request_accept(){
        def users = userService.getUserId(params.long('id'))
        users.enabled = true
        mandrillService.sendMail(users)
        flash.login_message = "User Invited"
        redirect (action:'list')
    }
    
    @Secured(['ROLE_ADMIN'])
    def delete(){
        if (params.int('id')) {
            def users = params.long('id')
            def query = User.where {
                id == users
            }
            query.deleteAll()
        }
        flash.login_message= "User deleted successfully"
            redirect (action:'list')
        }

    def confirmUser(String id) {
        User users = userService.getUserByInviteCode(id)
        if (!users) {
            render(view: 'error', model: [message: 'Problem activating account. Please check your activation link.'])
        } else {
            if (users.confirmed) {
                render(view: 'success', model: [message: 'Your account is successfully activated. It seems like you were already activated.'])

            } else {
                if (!users.save()) {
                    render(view: 'error', model: [message: 'Problem activating account. Please contact the administrator.'])
                } else {
                    render(view:'register/inviteRegister', model:[users:users])
                }
            }
        }
    }

    def createAccount() {
        def users = userService.getUserId(params.long('id'))
         users.password = params.password
         if (params.firstName || params.lastName) {
             users.firstName = params.firstName
             users.lastName = params.lastName
        }
        if (users.save()) {
            users.confirmed = true
            userService.createUserRole(users, roleService)
            render(view: 'success', model: [message: 'You have successfully registered.'])
        } else {
            render(view: 'error', model: [message: 'Problem creating user. Please try again.'])
        }
    }


    def send_reset_email() {
        User user = userService.getUserByName(params.username)

        if (!user) {
            // TBD: We might not want to give any hint on existing users
            render(view: 'error', model: [message: 'A user with that email does not exist. Please use a registered email.'])
        } else if(user.enabled == false) {
		    render(view: 'error', model: [message: 'Email is not verified. Please complete the registration process.'])
		} else {
            user.resetCode = UUID.randomUUID().toString()
            user.save()
           
            mandrillService.sendResetPassword(user)

            render(view: 'success',
                    model: [message: 'An email was sent to '+ params.username +' describing how to reset your password.']);
        }
    }

    def confirm_reset(String id) {
        User user = userService.getUserByResetCode(id)

        if (!user) {
            render(view: 'error', model: [message: 'Problem resetting password. Please check your reset link.'])
        } else {
            render(view: 'forgot/edit_password_reset', model: [code: id])
        }
    }

    def reset_password(String id) {
        User user = userService.getUserByResetCode(id)

        if (!user) {
            render(view: 'error', model: [message: 'Error resetting password.'])
        } else {
                user.password = params.password
                user.resetCode = UUID.randomUUID().toString() // Scramble reset code, to avoid re-use

            if (user.save()) {
                render(view: 'success', model: [message: 'Password updated successfully. To continue, please login with your new password.'])
            } else {
                render(view: 'error', model: [message: 'Error while updating user password. Please try again later.'])
            }
        }
    }
    
    def googleSuccess (){
        def provider = 'google'
        def sessionKey = oauthService.findSessionKeyForAccessToken(provider)
        if (!session[sessionKey]) {
            flash.googlePlusErrorMessage =  "No OAuth token in the session for provider google!"
            render (view:'/login/error')
        }

        // Create the relevant authentication token and attempt to log in.
        def oAuth = googlePlusService.createAuthToken(session[sessionKey])
        def email = oAuth.userEmail
        def oAuthToken = oAuth.oAuthToken
        if (oAuthToken){
            if (oAuthToken.principal instanceof User) {
                authenticateAndRedirect(oAuthToken, email)
            }
        } else {
            flash.googlePlusErrorMessage = "Cannot get Google response.Please try again"
            render (view:'/login/error')
        }
    }

    def authenticateAndRedirect(def oAuthToken, def email) {
        try {
            session.removeAttribute SPRING_SECURITY_OAUTH_TOKEN
            SecurityContextHolder.getContext().setAuthentication(oAuthToken);
        }
        catch (Exception e) {
            log.errorEnabled = "Unable to login using spring security : "+e
        }
        def currentUser = userService.getCurrentUser();
        def user = User.findByEmail(email)
        if (currentUser.id == user.id){
            String requestUrl = g.cookie(name: 'requestUrl')
            if (requestUrl) {
                def cookie = projectService.setCookie(requestUrl)
                response.addCookie(cookie)
                redirect (url: requestUrl)
            } else {
                redirect (controller:'home', action:'index')
            }
        } else {
            redirect (controller:'home', action:'index', params:[isDuplicate: 'yes', email:email])
        }
        
        
    }

    def googleFailure = {
        flash.googleFailureMessage = "Google authentication failed.Please try again"
        redirect action:'auth'
    }
    
    def googlePlusAccountsMerge(){
        if (params.userResponse.equalsIgnoreCase("yes")) {
            googlePlusService.mergeGooglePlusUser(params.email)
            redirect (action : 'googleSuccess')
        }
    }
}
