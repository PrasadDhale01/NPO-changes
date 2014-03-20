package fedu

import grails.transaction.Transactional

class RewardService {

    @Transactional
    def bootstrap() {
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
