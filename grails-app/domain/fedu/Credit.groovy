package fedu

class Credit {
    double amount

    static belongsTo = [community: Community]
    static hasMany = [contributions: Contribution]

    Date date
    int daysValid = 30

    static constraints = {
    }
}
