package fedu

class Contribution {

    static belongsTo = [user: User, project: Project, reward: Reward]

    Date date

    static constraints = {
    }

}
