import crowdera.Blog
import crowdera.Contribution
import crowdera.Project
import crowdera.Reward
import crowdera.Community

class BootStrap {
    def blogService
    def userService
    def roleService
    def projectService
    def rewardService
    def communityService

	def init = { servletContext ->
        // Bootstrap roles
        roleService.bootstrap()

        // Bootstrap users
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
        /*
        if (Project.count() == 0) {
            projectService.bootstrap()
        }
        */

        // Bootstrap communities.
        communityService.bootstrap()

    }

	def destroy = {
	}
}
