package crowdera

class Seller {

    String email
    String sellerId
    
    static constraints = {
        email nullable: true, unique: true
        email nullable: true, unique: true
    }
    
}
