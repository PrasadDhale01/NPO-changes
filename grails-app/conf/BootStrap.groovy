import fedu.Blog
import fedu.BlogService
import fedu.Project
import fedu.ProjectService
import fedu.UserService

class BootStrap {
	def BlogService
    def UserService
    def ProjectService

	def init = { servletContext ->
        // Bootstrap users and roles
        UserService.bootstrap()

		// Check whether blogs already exist, and create otherwise.
		if (Blog.count() == 0) {
			BlogService.bootstrap()
		}

        // Check whether projects already exist, and create otherwise.
        if (Project.count() == 0) {
            ProjectService.bootstrap()
        }
	}

	def destroy = {
	}
}
