package fedu

import grails.converters.JSON
import grails.plugin.springsecurity.annotation.Secured

class FundController {
    def contributionService
    def projectService

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

        boolean fundingAchieved = contributionService.isFundingAchievedForProject(project)
        boolean ended = projectService.isProjectEnded(project)

        if (fundingAchieved || ended) {
            redirect(controller: 'project', action: 'show', id: project.id)
        } else if (!project || !reward) {
            render(view: 'notfound', model: [message: 'This project or reward does not exist.'])
        } else {
            return [project: project, reward: reward]
        }
    }
}
