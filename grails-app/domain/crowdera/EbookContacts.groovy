package crowdera

import groovy.transform.EqualsAndHashCode
import groovy.transform.ToString

@ToString(includeNames = true, includeFields = true)
@EqualsAndHashCode
class EbookContacts {
    User user
    String email
    static constraints = {
        email nullable:true
    }
}
