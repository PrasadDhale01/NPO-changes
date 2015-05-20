package crowdera

import groovy.transform.EqualsAndHashCode
import groovy.transform.ToString

@ToString(includeNames = true, includeFields = true)
@EqualsAndHashCode

class Transaction {
    
    String transactionId
    
    static belongsTo = [user: User,project:Project,contribution:Contribution]

    static constraints = {
        transactionId unique:true,required:true
    }
}
