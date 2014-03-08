package fedu

import grails.converters.JSON
import grails.plugin.springsecurity.annotation.Secured

@Secured(['permitAll'])
class RegistrationController {

    def mailService

    def create() {
        /*
        mailService.sendMail {
            to "atreya@gmail.com"
            from "info@fedu.org"
            subject "Welcome to FEDU"
            html "<h2>Welcome to FEDU. Above and beyond!<h2>"
        }

        render params as JSON
        */
    }
}
