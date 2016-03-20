package crowdera

import groovy.transform.EqualsAndHashCode
import groovy.transform.ToString

@ToString(includeNames = true, includeFields = true)
@EqualsAndHashCode

class BankInfo {
    String fullName
    String email
    String mobile
    String address1
    String address2
    String city
    String state
    String country
    String zip
    
    String payoutmode
    String branch
    String ifscCode
    String accountType
    String accountNumber
    
    static belongsTo = [project: Project]
    
    static constraints = {
        fullName nullable: true
        branch nullable: true
        ifscCode nullable: true
        accountType nullable: true
        accountNumber nullable: true
        
        email nullable: true
        mobile nullable: true
        address1 nullable: true
        address2 nullable: true
        city nullable: true
        state nullable: true
        country nullable: true
        zip nullable: true
        payoutmode nullable: true
    }
}
