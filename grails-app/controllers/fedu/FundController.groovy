package fedu

import grails.converters.JSON
import grails.plugin.springsecurity.annotation.Secured

import com.stripe.model.Charge
import com.stripe.exception.CardException;

@Secured(['ROLE_USER'])
class FundController {
    def contributionService
    def projectService
    def userService
    def mailService
    def rewardService

    def paymentdetails() {
        Project project
        // Reward reward

        if (params.int('projectId')) {
            project = Project.findById(params.int('projectId'))
            /*
            if (project) {
                reward = project.rewards.find {
                    it.id == params.int('rewardId')
                }
            }
            */
        }

        boolean fundingAchieved = contributionService.isFundingAchievedForProject(project)
        boolean ended = projectService.isProjectEnded(project)

        if (!project) {
            render(view: 'error', model: [message: 'This project does not exist.'])
        } else if (fundingAchieved || ended) {
            redirect(controller: 'project', action: 'show', id: project.id)
        } else {
            render view: 'index', model: [project: project]
        }
    }

    def charge(String stripeToken) {
        Project project
        Reward reward

        if (params.int('projectId')) {
            project = Project.findById(params.int('projectId'))
        }

        if (project) {
            if (params.int('rewardId')) {
                reward = project.rewards.find {
                    it.id == params.int('rewardId')
                }
            } else {
                reward = rewardService.getNoReward()
            }
        }

        def amount = params.double(('amount'))
        if (amount < reward.price) {
            render view: 'error', model: [message: 'Funding amount cannot be smaller than reward price. Please choose a smaller reward, or increase the funding amount.']
            return
        }

        def amountInCents = (amount * 100) as Integer
        def chargeParams = [
            'amount': amountInCents,
            'currency': 'usd',
            'card': stripeToken,
            'description': userService.getCurrentUser().username
        ]

        if (project && reward) {
            try {
                Charge.create(chargeParams)
            } catch(CardException) {
                render view: 'error', model: [message: 'There was an error charging. Don\'t worry, your card was not charged. Please try again.']
                return
            }

            Contribution contribution = new Contribution(
                    date: new Date(),
                    user: userService.getCurrentUser(),
                    reward: reward,
                    amount: amount
            )
            project.addToContributions(contribution).save(failOnError: true)

            mailService.sendMail {
                async true
                to userService.getCurrentUser().username
                from "info@fedu.org"
                subject "FEDU - Thank you for funding"
                html g.render(template: 'ackfundingemailtemplate', model: [project: project, reward: reward])
            }

            render view: 'acknowledge', model: [project: project, reward: reward, contribution: contribution]
        } else {
            render view: 'error', model: [message: 'This project or reward does not exist. Please try again.']
        }
    }
}
