package crowdera
import grails.converters.JSON
import grails.plugin.springsecurity.annotation.Secured
import grails.util.Environment

import javax.servlet.http.Cookie

import org.springframework.web.multipart.commons.CommonsMultipartFile

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
            def projects = projectService.projectOnHomePage(currentEnv)
            if(projects){
                return [projects: projects, fb: fb, isDuplicate:params.isDuplicate, email:params.email, currentEnv: currentEnv, contributorEmail:contributorEmail]
            }else{
                projects = projectService.showProjects(currentEnv)
                return [projects: projects, fb: fb, isDuplicate:params.isDuplicate, email:params.email, currentEnv: currentEnv, contributorEmail:contributorEmail]
            }
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
	
    
    def EbookEmail(){
        def ebookEmail = params.loginEmail
        User user = User.get(params.int('userId'))
        if(ebookEmail && user){
            new EbookContacts(email:ebookEmail, user:user).save(failOnError: true)
            render 'https://s3.amazonaws.com/crowdera/assets/crowdera%20ebook-your%20go%20to%20guide%20for%20crowdfunding%20success.pdf'
        }else{
            redirect(view:'/error')
        }
    }
    
    @Secured(['IS_AUTHENTICATED_FULLY'])
    def manageHomePageCarousel(){
        
        String status
        switch(params?.carouselOption){
            case 'delete':
                status = projectService.deleteHomeCarouselImage(params?.carouselImage, params?.country)
            break;
            case 'update':
                CommonsMultipartFile file = params?.uploadFile
                def iconUrl = projectService.setImageUrl(params?.uploadFile, "home-carousel")
                status = projectService.updateHomeCarouselImage(params?.carouselImage, file.getOriginalFilename(), iconUrl, params.country)
            break;
            case 'upload':
                CommonsMultipartFile file = params?.uploadFile
                def iconUrl = projectService.setImageUrl(params?.uploadFile, "home-carousel")
                status = projectService.setHomePageCarouselImage(iconUrl, file.getOriginalFilename(), params?.country)
            break;
            
        }
        render status
    }
    
    @Secured(['IS_AUTHENTICATED_FULLY'])
    def getHomePageCarouselImage(){
        def carousel = projectService.getHomePageCarouselImage(params?.country, params?.data)
        render carousel as JSON
    }
    
}
