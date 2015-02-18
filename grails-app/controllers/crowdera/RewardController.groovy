package crowdera

import crowdera.Contribution;
import crowdera.Reward;
import grails.plugin.springsecurity.annotation.Secured

@Secured(['ROLE_ADMIN'])
class RewardController {
    def rewardService
    def contributionService

    def list() {
        def rewards = rewardService.getNonObsoleteRewards()
        def obsoleteRewards = rewardService.getObsoleteRewards()
        render(view: 'list/index', model: [rewards: rewards, obsoleteRewards: obsoleteRewards])
    }

    def save() {
        def reward = new Reward(params)

        if(reward.save()) {
            flash.reward_message = 'Successfully created a new perk'
            redirect action: 'list'
        } else {
            render(view: 'list/rewarderror', model: [reward: reward])
        }
    }

    def delete() {
        def rewardId = params.long('id')
        if (rewardId) {
            Reward reward = Reward.findById(rewardId)
            if (reward) {
                reward.obsolete = true
                flash.reward_message = "Successfully marked as unusable"
            } else {
                flash.reward_message = "Couldn't find that perk"
            }
        } else {
            flash.reward_message = "Couldn't find that perk"
        }
        redirect action: 'list'
    }

    def shipping() {
        def shippingDoneItems = contributionService.getShippingDoneItems()
        def shippingPendingItems = contributionService.getShippingPendingItems()
        render (view: 'shipping/index', model: [shippingPendingItems: shippingPendingItems, shippingDoneItems: shippingDoneItems])
    }

    def update() {
        def contribution = Contribution.get(params.contributionId)
        contribution.shippingDone = params.shippingdone
        flash.reward_message= "shipping done successfully"
        redirect action: 'shipping'
    }
}
