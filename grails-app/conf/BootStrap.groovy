import fedu.Blog
import fedu.Contribution
import fedu.Project
import fedu.Reward

class BootStrap {
    def blogService
    def userService
    def projectService
    def rewardService

	def init = { servletContext ->
        // Bootstrap users and roles
        userService.bootstrap()

		// Check whether blogs already exist, and create otherwise.
		if (Blog.count() == 0) {
            blogService.bootstrap()
		}

        // Check whether rewards already exist, and create otherwise
        if (Reward.count() == 0) {
            rewardService.bootstrap()
        }

        // Check whether projects already exist, and create otherwise.
        if (Project.count() == 0) {
            projectService.bootstrap()
        }
	}

	def destroy = {
	}
}
