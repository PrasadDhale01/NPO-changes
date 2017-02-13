package crowdera
import grails.converters.JSON
import grails.plugin.springsecurity.annotation.Secured
import grails.util.Environment

import javax.servlet.http.Cookie

import org.springframework.web.multipart.commons.CommonsMultipartFile

class HomeController {
	def projectService
    def userService
	def static country = '';
	
		def indexToRedirect(){
			country = projectService.getCountryCodeForCurrentEnv(request);
			log.info("country_code: "+ country)
			redirect action: 'index', controller: 'home', params: [country_code: country]
		}

    def index() {
		def country_code = country
		log.info("country_code: "+ request.getHeader("cf-ipcountry"))
        /*def contributorEmail = g.cookie(name: 'contributorEmailCookie')*/
        def currentEnv = projectService.getCurrentEnvironment();
        def fb = params.fb

        /*if(contributorEmail){
            Cookie cookie = projectService.deleteContributorEmailCookie(contributorEmail)
            response.addCookie(cookie)
        }*/

        if( currentEnv == 'development'|| currentEnv == 'test' ||currentEnv == 'testIndia'){
            def projects = projectService.showProjects(country_code)
            return [projects: projects, fb: fb, isDuplicate:params.isDuplicate, email:params.email, currentEnv: currentEnv,country_code: country_code]
        } else {
            def projects = projectService.projectOnHomePage(country_code)
            if(projects){
                return [projects: projects, fb: fb, isDuplicate:params.isDuplicate, email:params.email, currentEnv: currentEnv,country_code: country_code]
            }else{
                projects = projectService.showProjects(country_code)
                return [projects: projects, fb: fb, isDuplicate:params.isDuplicate, email:params.email, currentEnv: currentEnv,country_code: country_code]
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
        
        if(carousel){
            render carousel as JSON
        }else{
           render ''
        }
    }
    
    def loadHomepageCarousel(){
        
        if(request.method=='POST'){
            
            def currentEnv = projectService.getCurrentEnvironment()
            def imageUrl = projectService.getHomePageCarouselImage(currentEnv, 'link')
            
            render template:'homepagecarousel', model:[imageUrl:imageUrl]
        }else{
            render "Carousel images not loaded. Please, refresh to load again."
        }
    }
    
    
    def loadFooterCallback(){
        
        def currentEnv = projectService.getCurrentEnvironment()
        boolean isTestEnv = false
        def mailChimpUrl
        def base_url = grailsApplication.config.crowdera.BASE_URL
		def country_code = projectService.getCountryCodeForCurrentEnv(request)
		
        if (currentEnv == 'development' || currentEnv == 'testIndia' || currentEnv == 'test') {
            isTestEnv = true
        }
        
        if (currentEnv == 'development' || currentEnv == 'testIndia' || currentEnv == 'stagingIndia'){
            mailChimpUrl = "//crowdera.us3.list-manage.com/subscribe/post?u=41c633b30eeabc78e88bd090d&id=11344f1cfe"
        } else if(currentEnv == 'production' && country == 'in'){
			mailChimpUrl = "//crowdera.us3.list-manage.com/subscribe/post?u=41c633b30eeabc78e88bd090d&id=11344f1cfe"
        } else {
			mailChimpUrl = "//crowdera.us3.list-manage.com/subscribe/post?u=41c633b30eeabc78e88bd090d&amp;id=e37aea1b78"
        }
        
        switch(params.device){
            case 'desktop':
                render template:'/layouts/footer', model:[currentEnv:currentEnv, isTestEnv:isTestEnv, mailChimpUrl:mailChimpUrl, base_url:base_url,country_code:country_code]
            break;
            case 'mobile':
                render template:'/layouts/mobilefooter', model:[currentEnv:currentEnv, isTestEnv:isTestEnv, mailChimpUrl:mailChimpUrl, base_url:base_url]
            break;
            case 'tab':
                render template:'/layouts/tabfooter', model:[currentEnv:currentEnv, isTestEnv:isTestEnv, mailChimpUrl:mailChimpUrl, base_url:base_url]
            break;
        }
    }
    
    def loadWhyCrowderaCallback(){
        def currentEnv = projectService.getCurrentEnvironment()
        
        if(request.method=='POST' && params.device){
            
            switch(params.device){
                case 'desktop':
                    render template:'whycrowdera', model:[currentEnv: currentEnv]
                break;
                case 'tab':
                    render template:'tabwhycrowdera', model:[currentEnv:currentEnv]
                break;
            }
            
        }else{
            render "WhyCrowdera section not loaded. Please, refresh to load again."
        }
    }
    
    def loadMediaStrip(){
        
        if(request.method=='POST'){
            render template:'media-strip'
        }else{
            render "Media strip not loaded. Please, refresh to load again."
        }
    }
    
    def loadHeaderCallback(){
        
        if(request.method=='POST' && params.device){
            def currentEnv = projectService.getCurrentEnvironment()
            def user = userService.getCurrentUser()
            String userImage = userService.getUserImageUrl(user)
            def model = [user:user, userImage:userImage, currentEnv:currentEnv ]
            
            switch(params.device){
                case 'desktop':
			        render template:'/layouts/header', model:model
                break;
                case 'tab':
                    render template:'/layouts/header', model:model
                break;
                case 'mobile':
                    render template:'/layouts/mobileheader', model:model
                break;
                
            }
            
        }else{
            render 'Header not loaded. Please, refresh to load again.'
        }
    }
	
	def getLearnMore(){
		String question =params.question?.replaceAll("20%", " ")
		def learnMore = LearnMore.findByArticleTitle(question+"?");
		render  (view:"/learnMore/database", model:[articleContent:learnMore?.articleContent])
	}
}
