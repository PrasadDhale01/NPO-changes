package fedu

import grails.plugin.springsecurity.annotation.Secured

@Secured(['ROLE_ADMIN'])
class SecuredController {

    def index() {
        render 'In SecuredController.index'
    }
}
