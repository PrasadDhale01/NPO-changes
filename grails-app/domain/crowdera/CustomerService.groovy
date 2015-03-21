package crowdera

class CustomerService {

    static hasMany = [attachments: ImageUrl]
    
    List attachments
    
    String category
    String customername
    String description
    String email
    String subject
    boolean status = false
    
    static constraints = {
        category nullable: true
        customername nullable: true
        description nullable: true
        email nullable: true
        subject nullable: true
        attachments nullable: true
    }

}
