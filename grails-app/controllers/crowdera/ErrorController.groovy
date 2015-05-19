package crowdera

import grails.util.Environment

class ErrorController {
    
    def mandrillService

    def index() {
        try {
            Exception exception = request.exception
            
            if ( Environment.PRODUCTION == Environment.current) {
                mandrillService.sendEmailToDevGroup(exception)
                render(view:'/error')
            } else {
                render(view:'/error')
            }
        
        } catch(Exception e ) {
            render(view: '/error')
        }
    }
}
