package fedu

import grails.plugin.springsecurity.annotation.Secured

@Secured(['ROLE_ADMIN'])
class RewardController {
    def rewardService

    def list() {
        def rewards = rewardService.getNonObsoleteRewards()
        def obsoleteRewards = rewardService.getObsoleteRewards()
        render(view: 'list/index', model: [rewards: rewards, obsoleteRewards: obsoleteRewards])
    }

    def save() {
        def reward = new Reward(params)

        if(reward.save()) {
            flash.message = 'Successfully created a new reward'
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
                flash.message = "Successfully marked as unusable"
            } else {
                flash.error = "Couldn't find that reward"
            }
        } else {
            flash.error = "Couldn't find that reward"
        }
        redirect action: 'list'
    }
}
