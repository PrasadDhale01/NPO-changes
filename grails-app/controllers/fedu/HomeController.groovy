package fedu

class HomeController {
	def projectService

    def index() {
		def base_url = grailsApplication.config.crowdera.BASE_URL
		if(base_url.contains("localhost") || base_url.contains("staging")){
			def projects = projectService.showProjects()
			return [projects: projects]
		}else{
			def projects = projectService.projectOnHomePage()
			return [projects: projects]
		}
    }
}
