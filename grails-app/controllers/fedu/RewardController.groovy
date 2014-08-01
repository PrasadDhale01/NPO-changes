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

    def delete(){
		 def reward = params.int('rewardId')    
		 if (reward) {  
			 try {        
			 reward.delete(flush: true)        
			 flash.message = "${message(code: 'default.deleted.message', args: [message(code : 'feedback.label', default: 'Reward'), params.id])}"        
			 redirect(action: "list")      
			 }      
			 catch (org.springframework.dao.DataIntegrityViolationException e) {        
				 flash.message = "${message(code: 'default.not.deleted.message', args: [message( code: 'feedback.label', default: 'Reward'), params.id])}"        
				 redirect(action: "show", id: params.id)      
				 }    
			 }    
		 else {      
			 flash.message = "${message(code: 'default.not.found.message', args: [message(code : 'feedback.label', default: 'Reward'), params.id])}"      
			 redirect(action: "list")    
		     }
	}
}
