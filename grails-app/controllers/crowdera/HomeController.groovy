package crowdera
import grails.util.Environment

class HomeController {
	def projectService
    def userService

    def index() {
        	def payu_url=	grailsApplication.config.crowdera.PAYU.BASE_URL
		def request_url=request.getRequestURL().substring(0,request.getRequestURL().indexOf("/", 8))
        def fb = params.fb
		if(Environment.DEVELOPMENT == Environment.current || Environment.TEST == Environment.current || Environment.current.getName() == 'testIndia'){
//			def projects = projectService.showProjects()
			def projects = projectService.showProjects(payu_url, request_url)
			return [projects: projects, fb: fb, isDuplicate:params.isDuplicate, email:params.email]
		} else{
			def projects = projectService.projectOnHomePage()
			return [projects: projects, fb: fb, isDuplicate:params.isDuplicate, email:params.email]
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
        if (loginurl){
            redirect (url: loginurl)
        }else{
            render (view: '/error')
        }
    }
	
}
