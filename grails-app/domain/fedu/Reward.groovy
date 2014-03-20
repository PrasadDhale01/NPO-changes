package fedu

class Reward {
    String title
    String description
    double price
    Image image

    static constraints = {
        image (nullable: true)
    }
}
