import fedu.Blog
import fedu.BlogService

class BootStrap {
	def BlogService

	def init = { servletContext ->
		// Check whether blogs already exist, and create otherwise.
		if (Blog.count() == 0) {
			BlogService.bootstrap()
		}
	}

	def destroy = {
	}
}
