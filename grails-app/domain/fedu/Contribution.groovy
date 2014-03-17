package fedu

class Contribution {

    static belongsTo = [user: User, project: Project]

    double amount
    Date date

    static constraints = {
    }

}
