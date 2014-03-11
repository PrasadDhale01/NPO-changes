import fedu.Blog
import fedu.Project

class BootStrap {
    def blogService
    def userService
    def projectService

	def init = { servletContext ->
        // Bootstrap users and roles
        userService.bootstrap()

		// Check whether blogs already exist, and create otherwise.
		if (Blog.count() == 0) {
            blogService.bootstrap()
		}

        // Check whether projects already exist, and create otherwise.
        if (Project.count() == 0) {
            projectService.bootstrap()
        }
	}

	def destroy = {
	}
}
