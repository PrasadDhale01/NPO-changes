package fedu

class HomeController {
	def projectService

    def index() {
    	def projects = projectService.projectOnHomePage()
        return [projects: projects]
    }
}
