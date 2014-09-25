package fedu

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
        new Reward(params).save(failOnError: true)
        flash.message = 'Successfully created a new reward'
        redirect action: 'list'
    }

    def delete() {
        def rewardId = params.long('id')
        if (rewardId) {
            Reward reward = Reward.findById(rewardId)
            if (reward) {
                reward.obsolete = true
                flash.message = "Successfully marked as unusable"
            } else {
                flash.error = "Couldn't find that reward"
            }
        } else {
            flash.error = "Couldn't find that reward"
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
        flash.message= "shipping done successfully"
        redirect action: 'shipping'
    }
}
