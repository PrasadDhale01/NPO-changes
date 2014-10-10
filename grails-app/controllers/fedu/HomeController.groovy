package fedu

class HomeController {
	def projectService

    def index() {
    	def projects = projectService.getValidatedProjects()
        return [projects: projects]
    }
}
