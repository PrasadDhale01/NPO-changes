package crowdera

import groovy.transform.EqualsAndHashCode
import groovy.transform.ToString

@ToString(includeNames = true, includeFields = true)
@EqualsAndHashCode

class Partner {
    
    static belongsTo = [user: User]
    static hasMany = [documents : Document]
    
    String confirmCode
    String orgName
    String customUrl
    String description
    String category
    String youTube
    String twitter
    String linkedin
    String facebook
    String website
    String email
    String country
    String addressLine1
    String addressLine2
    String city
    String state
    String zipCode
    String telePhone
    
    List documents
    
    boolean enabled = false
    boolean discarded = false
    boolean rejected = false
    boolean validated = false
    boolean draft = true
    
    static constraints = {
        confirmCode nullable: false
        orgName nullable: true
        customUrl nullable: true
        description nullable: true
        category nullable: true
        youTube nullable: true
        twitter nullable: true
        linkedin nullable: true
        facebook nullable: true
        website nullable: true
        email nullable: true
        country nullable: true
        addressLine1 nullable: true
        addressLine2 nullable: true
        city nullable: true
        state nullable: true
        zipCode nullable: true
        telePhone nullable: true
    }
}
