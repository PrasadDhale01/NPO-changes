package fedu

import grails.transaction.Transactional

class RewardService {

    def getNoReward() {
        return Reward.findById(1)
    }

    def isRewardUnused(Reward reward) {
        if (reward.projects == null) {
            return true
        } else {
            return false
        }
    }

    def numProjectsUsingReward(Reward reward) {
        return reward.projects.size()
    }

    def getNonObsoleteRewards() {
        return Reward.findAllWhere(obsolete: false)
    }

    def getObsoleteRewards() {
        return Reward.findAllWhere(obsolete: true)
    }
    
    def getMultipleRewards(def project, def rewardTitle ,def rewardPrice ,def rewardDescription) {
        
        if(rewardTitle instanceof String) {
            Reward reward = new Reward()
            reward.title = rewardTitle
            reward.price = Integer.parseInt(rewardPrice)
            reward.description = rewardDescription
            reward.obsolete = true
            project.addToRewards(reward)
        
        } else {
            for(int i=0; i<rewardTitle.size();i++ ) {
                Reward reward = new Reward()
                reward.title = rewardTitle[i]
                reward.price = Integer.parseInt(rewardPrice[i])
                reward.description = rewardDescription[i]
                reward.obsolete = true
                project.addToRewards(reward)
            }
        }
        return
    }
    
    @Transactional
    def bootstrap() {
        new Reward(
                title: 'No reward',
                description: 'No reward. I just want to contribute',
                price: 0.0,
                image: null
        ).save(failOnError: true)
        new Reward(
                title: 'Personal thank you Email',
                description: 'Personal thank you email from beneficiary',
                price: 10.0,
                image: null
        ).save(failOnError: true)
        new Reward(
                title: 'Handwritten Postcard',
                description: 'A handwritten postcard',
                price: 15.0,
                image: null
        ).save(failOnError: true)
        new Reward(
                title: '6 FEDU Wristbands',
                description: '6 FEDU Wristbands',
                price: 20.0,
                image: null
        ).save(failOnError: true)
        new Reward(
                title: '12 FEDU Wristbands',
                description: '12 FEDU Wristbands',
                price: 25.0,
                image: null
        ).save(failOnError: true)
        new Reward(
                title: '1 FEDU T-shirt & 6 FEDU Wristbands',
                description: '1 FEDU T-shirt & 6 FEDU Wristbands',
                price: 25.0,
                image: null
        ).save(failOnError: true)
        new Reward(
                title: '1 FEDU T-shirt & 12 FEDU Wristbands',
                description: '1 FEDU T-shirt & 12 FEDU Wristbands',
                price: 30.0,
                image: null
        ).save(failOnError: true)
        new Reward(
                title: '2 FEDU T-shirts & 6 FEDU Wristbands',
                description: '2 FEDU T-shirts & 6 FEDU Wristbands',
                price: 40.0,
                image: null
        ).save(failOnError: true)
        new Reward(
                title: '2 FEDU T-shirts & 12 FEDU Wristbands',
                description: '2 FEDU T-shirts & 12 FEDU Wristbands',
                price: 45.0,
                image: null
        ).save(failOnError: true)
        new Reward(
                title: '3 FEDU T-shirts & 6 FEDU Wristbands',
                description: '3 FEDU T-shirts & 6 FEDU Wristbands',
                price: 50.0,
                image: null
        ).save(failOnError: true)
        new Reward(
                title: '4 FEDU T-shirts',
                description: '4 FEDU T-shirts',
                price: 60.0,
                image: null
        ).save(failOnError: true)
    }
}
