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

    @Secured(['ROLE_USER', 'ROLE_ADMIN'])
    def show() {
        User user = springSecurityService.currentUser

        return [user: user]
    }

    @Secured(['ROLE_USER', 'ROLE_ADMIN'])
    def update() {
        User user = springSecurityService.currentUser
        user.firstName = params.firstName
        user.lastName = params.lastName

        /* Password change is optional */
        if (params.password)
        {
            String password = params.password
            String newPassword = params.password_new
            String newPassword2 = params.password_new_2
            if (!password || !newPassword || !newPassword2 || newPassword != newPassword2) {
                flash.message = 'Please enter your current password and a valid new password'
                render view: 'show', model: [user: user]
                return
            }

            if (!passwordEncoder.isPasswordValid(user.password, password, null /*salt*/)) {
                flash.message = 'Current password is incorrect'
                render view: 'show', model: [user: user]
                return
            }

            if (passwordEncoder.isPasswordValid(user.password, newPassword, null /*salt*/)) {
                flash.message = 'Please choose a different password from your current one'
                render view: 'show', model: [user: user]
                return
            }

            user.password = newPassword
            user.passwordExpired = false
        } else if (params.password_new || params.password_new_2)
        {
            flash.message = 'Please enter your current password and then a valid new password'
            render view: 'show', model: [user: user]
            return
        }

        if (user.save(flush: true)) {
            render(view: 'success', model: [message: 'Your profile has been updated successfully.'])
        } else {
            render(view: 'error', model: [message: 'Error while updating user. Please try again later.'])
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
            if (user.enabled == true) {
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
}
