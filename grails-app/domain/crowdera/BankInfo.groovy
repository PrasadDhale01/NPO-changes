package crowdera

import groovy.transform.EqualsAndHashCode
import groovy.transform.ToString

@ToString(includeNames = true, includeFields = true)
@EqualsAndHashCode

class BankInfo {
    String fullName
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
    }
}
