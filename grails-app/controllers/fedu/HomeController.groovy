package fedu

class HomeController {
	def projectService

    def index() {
    	def projects = projectService.showProjects()
        return [projects: projects]
    }
}
