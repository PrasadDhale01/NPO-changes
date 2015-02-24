package crowdera

class Contribution {

    double amount
    boolean shippingDone = false

    static belongsTo = [user: User, project: Project, reward: Reward, credit: Credit]

    Date date
    String email
    String twitterHandle
    String custom
    String physicalAddress

    static constraints = {
        credit nullable: true
        reward nullable: true
        email nullable: true
        twitterHandle nullable: true
        custom nullable: true
        physicalAddress nullable: true
    }

    def beforeValidate() {
        if (!amount) {
            amount = reward.price
        }
    }

}
