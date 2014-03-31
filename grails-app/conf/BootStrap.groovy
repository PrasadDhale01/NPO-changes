import fedu.Blog
import fedu.Contribution
import fedu.Project
import fedu.Reward
import fedu.Community

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
        if (Project.count() == 0) {
            projectService.bootstrap()
        }

        // Check whether communities already exist, and create otherwise.
        if (Community.count() == 0) {
            communityService.bootstrap()
        }

    }

	def destroy = {
	}
}
