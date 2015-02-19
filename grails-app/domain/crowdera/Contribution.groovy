package crowdera

class Contribution {

    double amount
    boolean shippingDone = false

    static belongsTo = [user: User, project: Project, reward: Reward, credit: Credit]

    Date date

    static constraints = {
        credit nullable: true
        reward nullable: true
    }

    def beforeValidate() {
        if (!amount) {
            amount = reward.price
        }
    }

}
