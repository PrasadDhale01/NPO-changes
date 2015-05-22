package crowdera

import groovy.transform.EqualsAndHashCode
import groovy.transform.ToString

@ToString(includeNames = true, includeFields = true)
@EqualsAndHashCode

class VanityUsername {

    String username
    String vanityUsername

    static belongsTo = [user:User]

    static constraints = {
        username nullable:true
        vanityUsername (nullable:true,unique:true)
    }
}
