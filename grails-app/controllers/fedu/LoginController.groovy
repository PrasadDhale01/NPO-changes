package fedu

import grails.plugin.springsecurity.SpringSecurityUtils
import grails.plugin.springsecurity.annotation.Secured

class LoginController {

    def mailService
    def mandrillService

    def userService
    def roleService
    def grailsLinkGenerator

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

    def user_request(){
        if (User.findByUsername(params.username)) {
            render(view: 'error', model: [message: 'A user with that email already exists. Please use a different email.'])
        } else {
            def user = new User(params)
            user.enabled = false
            user.confirmed = false
            user.inviteCode = UUID.randomUUID().toString()
            
            if (!user.save()) {
                render(view: 'error', model: [message: 'Problem in saving your details'])
           } else {
                render(view: 'success', model: [message: 'Your request has been send to admin.'])

                mailService.sendMail { 
                async true
                to user.email
                from "info@crowdera.org"
                subject "Crowdera - Registration Request"
                html g.render(template: 'register/acknowledgetemplate')
                }
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


    private def sendMandrillEmail(User user) {
        def link = grailsLinkGenerator.link(controller: 'login', action: 'confirm', id: user.confirmCode, absolute: true)

        def globalMergeVars = [[
            'name': 'LINK',
            'content': link
        ], [
            'name': 'NAME',
            'content': user.firstName + ' ' + user.lastName
        ], [
            'name': 'EMAIL',
            'content': user.email
        ]]

        def tags = ['registration']

        mandrillService.sendTemplate(user, 'new_user_confirmation', globalMergeVars, tags)
    }

    def create() {
        if (User.findByUsername(params.username)) {
            render(view: 'error', model: [message: 'A user with that email already exists. Please use a different email.'])
        } else {
            def user = new User(params)
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
                UserRole.create(user, roleService.userRole())

                sendMandrillEmail(user)

                redirect(action: 'success')
            }
        }
    }

    @Secured(['IS_AUTHENTICATED_FULLY'])
    def update() {
        User user = (User)userService.getCurrentUser()
        if(params.firstName){ 
            user.firstName = params.firstName
        }
        if(params.lastName){
            user.lastName = params.lastName
        }
        
        /* Password change is optional */
        if (params.password) {
              user.password = params.password
        }

        if (user.save()) {
            flash.user_message = "Profile updated successfully!"
            redirect (controller: 'user', action: 'dashboard')
        } else {
           render(view: 'error', model: [message: "Error while updating user. Please try again later."])
        }
    }

    def success() {
        render(view: 'success',
                model: [message: 'Your account has been created. Please confirm your email address. Confirmation link has been sent to your account.']);
    }

    def confirm(String id) {
        User user = User.findByConfirmCode(id)

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
        def users = User.get(params.id)
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
            int total = query.deleteAll()
        }
        flash.login_message= "User deleted successfully"
            redirect (action:'list')
        }

    def confirmUser(String id) {
        User users = User.findByInviteCode(id)
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
        def users = User.get(params.long('id'))
         users.password = params.password
         if (params.firstName || params.lastName) {
             users.firstName = params.firstName
             users.lastName = params.lastName
        }
        if (users.save()) {
            users.confirmed = true
            UserRole.create(users, roleService.userRole())
            render(view: 'success', model: [message: 'You have successfully registerd'])
        } else {
            render(view: 'error', model: [message: 'Problem creating user. Please try again.'])
        }
    }


    def send_reset_email() {
        User user = User.findByUsername(params.username)

        if (!user) {
            // TBD: We might not want to give any hint on existing users
            render(view: 'error', model: [message: 'A user with that email does not exist. Please use a registered email.'])
        } else {
            user.resetCode = UUID.randomUUID().toString()
            user.save()
           
            mandrillService.sendResetPassword(user)

            render(view: 'success',
                    model: [message: 'An email was sent to '+ params.username +' describing how to reset your password.']);
        }
    }

    def confirm_reset(String id) {
        User user = User.findByResetCode(id)

        if (!user) {
            render(view: 'error', model: [message: 'Problem resetting password. Please check your reset link.'])
        } else {
            render(view: 'forgot/edit_password_reset', model: [code: id])
        }
    }

    def reset_password(String id) {
        User user = User.findByResetCode(id)

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
}
