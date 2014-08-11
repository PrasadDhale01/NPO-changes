package fedu

class Reward {
    String title
    String description
    double price
    Image image
    boolean delete = false

    static constraints = {
        image (nullable: true)
    }

    static mapping = {
        sort 'price'
    }
}
