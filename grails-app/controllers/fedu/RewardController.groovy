package fedu

import grails.plugin.springsecurity.annotation.Secured

@Secured(['ROLE_ADMIN'])
class RewardController {

    def list() {
        def projects = Project.list()
	def reward = Reward.list()
	        reward.each {
		    def rewardId = it.id
		    def rewardDelete = it.delete
		    def rewardDisabled = it.disabled
		    int result = 0
			
		    if (rewardDelete == false) {
		        projects.each {
			    def projectReward = it.rewards
			    projectReward.each {
			        def projectRewardId = it.id
				    if (rewardId == projectRewardId) {
				        result = 1	 
				    }
				}
			    }
			    if (result == 0) {
			        def update = Reward.where {
			        id == rewardId
			    }
			    int total = update.updateAll(delete: true)
			}
		    }
		    if (rewardDisabled == false) {
			if (result == 1) {
			    def update = Reward.where {
				id == rewardId
			    }
			    int total = update.updateAll(disabled: true)
			}
		    }
		}
        render (view: 'list/index', model: [reward: reward])
    }

    def save() {
        new Reward(params).save(failOnError: true)
        flash.message = 'Successfully created a new reward'
        redirect action: 'list'
    }

    def delete() {
        def rewardId = params.long('id')
        if(rewardId) {
	    int query = Reward.where { id == rewardId }.deleteAll()
	    flash.message = "Successfully deleted"
	    render (view: 'list/index', model: [reward: Reward.list()])
	} else {
	    flash.error = "Unable to delete. Some error had occured"
	    render (view: 'list/index', model: [reward: Reward.list()])
	}
    }
}
