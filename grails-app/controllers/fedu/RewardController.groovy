package fedu

import grails.plugin.springsecurity.annotation.Secured

@Secured(['ROLE_ADMIN'])
class RewardController {

    def list() {
        render (view: 'list/index', model: [rewards: Reward.list()])
    }

    def save() {
        new Reward(params).save(failOnError: true)
        flash.message = 'Successfully created a new reward'
        redirect action: 'list'
    }
}
