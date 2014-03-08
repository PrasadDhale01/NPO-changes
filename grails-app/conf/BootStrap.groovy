import fedu.Blog
import fedu.BlogService
import fedu.UserService

class BootStrap {
	def BlogService
    def UserService

	def init = { servletContext ->
        // Bootstrap users and roles
        UserService.bootstrap()

		// Check whether blogs already exist, and create otherwise.
		if (Blog.count() == 0) {
			BlogService.bootstrap()
		}
	}

	def destroy = {
	}
}
