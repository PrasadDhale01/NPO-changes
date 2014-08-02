package fedu

import grails.transaction.Transactional

class RewardService {

    def getNoReward() {
        return Reward.findById(1)
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
                title: '6 CrowdEra Wristbands',
                description: '6 CrowdEra Wristbands',
                price: 20.0,
                image: null
        ).save(failOnError: true)
        new Reward(
                title: '12 CrowdEra Wristbands',
                description: '12 CrowdEra Wristbands',
                price: 25.0,
                image: null
        ).save(failOnError: true)
        new Reward(
                title: '1 CrowdEra T-shirt & 6 CrowdEra Wristbands',
                description: '1 CrowdEra T-shirt & 6 CrowdEra Wristbands',
                price: 25.0,
                image: null
        ).save(failOnError: true)
        new Reward(
                title: '1 CrowdEra T-shirt & 12 CrowdEra Wristbands',
                description: '1 CrowdEra T-shirt & 12 CrowdEra Wristbands',
                price: 30.0,
                image: null
        ).save(failOnError: true)
        new Reward(
                title: '2 CrowdEra T-shirts & 6 CrowdEra Wristbands',
                description: '2 CrowdEra T-shirts & 6 CrowdEra Wristbands',
                price: 40.0,
                image: null
        ).save(failOnError: true)
        new Reward(
                title: '2 CrowdEra T-shirts & 12 CrowdEra Wristbands',
                description: '2 CrowdEra T-shirts & 12 CrowdEra Wristbands',
                price: 45.0,
                image: null
        ).save(failOnError: true)
        new Reward(
                title: '3 CrowdEra T-shirts & 6 CrowdEra Wristbands',
                description: '3 CrowdEra T-shirts & 6 CrowdEra Wristbands',
                price: 50.0,
                image: null
        ).save(failOnError: true)
        new Reward(
                title: '4 CrowdEra T-shirts',
                description: '4 CrowdEra T-shirts',
                price: 60.0,
                image: null
        ).save(failOnError: true)
    }
}
