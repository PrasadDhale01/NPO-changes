package crowdera
import grails.util.Environment

class HomeController {
	def projectService

    def index() {
		if(Environment.DEVELOPMENT == Environment.current || Environment.TEST == Environment.current){
			def projects = projectService.showProjects()
			return [projects: projects]
		}else{
			def projects = projectService.projectOnHomePage()
			return [projects: projects]
		}
    }
    
    def crowderacustomerhelp() {
        def service = projectService.getCustomerRequest(params)
        def files = request.getFiles('files')
        projectService.setAttachments(service, files)
        
        flash.contactmessage="Message Sent ! Crowdera Happiness Team will be in touch with you shortly."
        redirect action: "customerService"
    }
	
    def customerService(){
    	render (view:'/contactus/index')
    }
}
