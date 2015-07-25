package crowdera

import groovy.transform.EqualsAndHashCode;
import groovy.transform.ToString

@ToString(includeNames = true, includeFields = true)
@EqualsAndHashCode

class GooglePlusUser {

    String uid
    String accessToken
    static belongsTo = [user: User] //connected to main Spring Security domain
    
    static constraints = {
        uid unique: true
    }
}
