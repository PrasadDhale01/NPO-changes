package fedu

class Reward {
    String title
    String description
    double price
    Image image
    boolean obsolete = false

    static belongsTo = Project

    static hasMany = [projects: Project]

    static constraints = {
        image (nullable: true)
        title nullable: true
        description nullable: true
        price nullable: true
    }

    static mapping = {
        sort 'price'
    }
}
