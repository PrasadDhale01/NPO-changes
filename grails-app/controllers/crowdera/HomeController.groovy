package crowdera
import grails.util.Environment

class HomeController {
	def projectService
    def userService

    def index() {
        def fb = params.fb
		if(Environment.DEVELOPMENT == Environment.current || Environment.TEST == Environment.current){
			def projects = projectService.showProjects()
			return [projects: projects, fb: fb]
		}else{
			def projects = projectService.projectOnHomePage()
			return [projects: projects, fb: fb]
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
	
	def crewRequest(){
		def files = request.getFile('resume')
		projectService.setResume(files,params)
		flash.joinusmessage = "Thank you for applying! A confirmation has been sent to your email address: ${params.email}."
		redirect action: "crewrequest"
	}
	
	def crewrequest(){
		render (view: '/aboutus/index')
	}
    
    def customerSupport() {
        def loginurl = userService.getFreshDeskUrl()
        if (loginurl)
            redirect (url: loginurl)
        else
            render (view: '/error')
    }
	
    def searchOnHomePage(){
        def query = params.query
        redirect (action:'search', controller:'project', params:[q:query])
    }
    
}
