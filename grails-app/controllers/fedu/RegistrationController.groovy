package fedu

import grails.plugin.springsecurity.SpringSecurityUtils
import grails.plugin.springsecurity.annotation.Secured

class RegistrationController {

    def mailService
    def userService
    def springSecurityService

    /**
     * Default action; redirects to 'defaultTargetUrl' if logged in.
     * Look at LoginController.groovy for example.
     */
    def index() {
        if (springSecurityService.isLoggedIn()) {
            redirect uri: SpringSecurityUtils.securityConfig.successHandler.defaultTargetUrl
        }
    }

    def create() {
        if (User.findByUsername(params.username)) {
            render(view: 'error', model: [message: 'A user with that email already exists. Please use a different email.'])
        } else {
            def user = new User(params)
            user.enabled = false
            user.confirmCode = UUID.randomUUID().toString()

            if (!user.save(flush: true)) {
                render(view: 'error', model: [message: 'Problem creating user. Please try again.'])
            } else {
                UserRole.create(user, userService.userRole())

                mailService.sendMail {
                    to user.username
                    from "info@fedu.org"
                    subject "FEDU - New user confirmation"
                    html g.render(template: 'mailtemplate', model: [code: user.confirmCode])
                }

                redirect(action: 'success')
            }
        }
    }

    @Secured(['IS_AUTHENTICATED_FULLY'])
    def show() {
        User user = (User)springSecurityService.currentUser

        return [user: user]
    }

    @Secured(['IS_AUTHENTICATED_FULLY'])
    def update() {
        User user = (User)springSecurityService.currentUser
        user.firstName = params.firstName
        user.lastName = params.lastName

        /* Password change is optional */
        if (params.password) {
              user.password = params.password
        }

        if (user.save(flush: true)) {
            flash.message = "Profile updated successfully"
        } else {
            flash.message = "Error while updating user. Please try again later"
        }

        render(view: 'show', model: [user: user])
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
                if (!user.save(flush: true)) {
                    render(view: 'error', model: [message: 'Problem activating account. Please contact the administrator.'])
                } else {
                    render(view: 'success', model: [message: 'Your account is successfully activated.'])
                }
            }
        }
    }

    def edit_reset() {
        render(view: 'edit_reset_email')
    }

    def send_reset_email() {
        User user = User.findByUsername(params.username)

        if (!user) {
            // TBD: We might not want to give any hint on existing users
            render(view: 'error', model: [message: 'A user with that email does not exist. Please use a registered email.'])
        } else {
            user.resetCode = UUID.randomUUID().toString()
            user.save(flush: true)
            mailService.sendMail {
                to params.username
                from "info@fedu.org"
                subject "FEDU - Reset Password"
                html g.render(template: 'resetmailtemplate', model: [code: user.resetCode])
            }

            render(view: 'success',
                    model: [message: 'An email was sent to '+ params.username +' describing how to reset your password.']);
        }
    }

    def confirm_reset(String id) {
        User user = User.findByResetCode(id)

        if (!user) {
            render(view: 'error', model: [message: 'Problem resetting password. Please check your reset link.'])
        } else {
            render(view: 'edit_password_reset', model: [code: id])
        }
    }

    def reset_password(String id) {
        User user = User.findByResetCode(id)

        if (!user) {
            render(view: 'error', model: [message: 'Error resetting password.'])
        } else {
            String newPassword = params.new_password
            String newPassword2 = params.new_password_2
            if (!newPassword || !newPassword2 || newPassword != newPassword2) {
                flash.message = 'Passwords do not match! Please enter a valid password.'
                render view: 'edit_password_reset', model: [code: user.resetCode]
                return
            } else {
                user.password = params.new_password
                user.resetCode = UUID.randomUUID().toString() // Scramble reset code, to avoid re-use
            }

            if (user.save(flush: true)) {
                render(view: 'success', model: [message: 'Password updated successfully. To continue, please login with your new password.'])
            } else {
                render(view: 'error', model: [message: 'Error while updating user password. Please try again later.'])
            }
        }
    }
}
