package fedu

class Contribution {

    double amount

    static belongsTo = [user: User, project: Project, reward: Reward]

    Date date

    static constraints = {
    }

    def beforeValidate() {
        if (!amount) {
            amount = reward.price
        }
    }

}
