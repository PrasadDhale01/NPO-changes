package crowdera
import grails.util.Environment
import javax.servlet.http.Cookie

class HomeController {
	def projectService
    def userService

    def index() {
        def contributorEmail = g.cookie(name: 'contributorEmailCookie')
        def currentEnv = Environment.current.getName()
        def fb = params.fb

        if(contributorEmail){
            Cookie cookie = projectService.deleteContributorEmailCookie(contributorEmail)
            response.addCookie(cookie)
        }

        if( currentEnv == 'development'|| currentEnv == 'test' ||currentEnv == 'testIndia'){
            def projects = projectService.showProjects(currentEnv)
            return [projects: projects, fb: fb, isDuplicate:params.isDuplicate, email:params.email, currentEnv: currentEnv, contributorEmail:contributorEmail]
        } else {
            def projects = projectService.projectOnHomePage()
            return [projects: projects, fb: fb, isDuplicate:params.isDuplicate, email:params.email, currentEnv: currentEnv, contributorEmail:contributorEmail]
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
