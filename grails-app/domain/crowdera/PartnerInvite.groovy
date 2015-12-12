package crowdera

import groovy.transform.EqualsAndHashCode
import groovy.transform.ToString

@ToString(includeNames = true, includeFields = true)
@EqualsAndHashCode

class PartnerInvite {
    
    static belongsTo = [partner: Partner]

    String email
    
    static constraints = {
        email blank: false, nullable: true
    }
}
