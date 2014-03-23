package fedu

import grails.converters.JSON
import grails.plugin.springsecurity.annotation.Secured

class FundController {

    @Secured(['ROLE_USER'])
    def paydetails() {
        Project project
        Reward reward

        if (params.int('projectId') && params.int('rewardId')) {

            project = Project.findById(params.int('projectId'))
            if (project) {
                reward = project.rewards.find {
                    it.id == params.int('rewardId')
                }
            }
        }

        if (!project || !reward) {
            render(view: 'notfound', model: [message: 'This project or reward does not exist.'])
        } else {
            return [project: project, reward: reward]
        }
    }
}
