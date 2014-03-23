package fedu

import grails.converters.JSON
import grails.plugin.springsecurity.annotation.Secured

@Secured(['ROLE_USER'])
class FundController {
    def contributionService
    def projectService
    def userService
    def mailService

    def paymentdetails() {
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
            render(view: 'error', model: [message: 'This project or reward does not exist.'])
        } else {
            return [project: project, reward: reward]
        }
    }

    def authorizepay() {
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

        if (project && reward) {
            project.addToContributions(
                    date: new Date(),
                    user: userService.getCurrentUser(),
                    reward: reward
            ).save(failOnError: true)

            mailService.sendMail {
                async true
                to userService.getCurrentUser().username
                from "info@fedu.org"
                subject "FEDU - Thank you for funding"
                html g.render(template: 'ackfundingemailtemplate', model: [project: project, reward: reward])
            }

            render view: 'acknowledge', model: [project: project, reward: reward]
        } else {
            render view: 'error', model: [message: 'This project or reward does not exist. Please try again.']
        }
    }
}
