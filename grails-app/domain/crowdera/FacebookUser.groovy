package crowdera

import groovy.transform.EqualsAndHashCode
import groovy.transform.ToString

@ToString(includeNames = true, includeFields = true, excludes = 'accessTokenExpires')
@EqualsAndHashCode

class FacebookUser {
    long uid
    String accessToken
    Date accessTokenExpires
    static belongsTo = [user: User] //connected to main Spring Security domain

    static constraints = {
        uid unique: true
    }
}
