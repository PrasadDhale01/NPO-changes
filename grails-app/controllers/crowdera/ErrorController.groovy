package crowdera

import grails.util.Environment

class ErrorController {
    
    def mandrillService

    def index() {
        try {
            Exception exception = request.exception
			def currentEnv = Environment.current.getName()
            if (currentEnv == 'production' || currentEnv == 'prodIndia') {
                mandrillService.sendEmailToDevGroup(exception, currentEnv)
                render(view:'/error')
            } else {
                render(view:'/error')
            }
        
        } catch(Exception e ) {
            render(view: '/error')
        }
    }
}
