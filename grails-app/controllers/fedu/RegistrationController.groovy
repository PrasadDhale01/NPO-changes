package fedu

import grails.plugin.springsecurity.SpringSecurityUtils

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
