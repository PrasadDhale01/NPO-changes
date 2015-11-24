package crowdera

import groovy.transform.EqualsAndHashCode
import groovy.transform.ToString

@ToString(includeNames = true, includeFields = true)
@EqualsAndHashCode

class Partner {
    
    static belongsTo = [user: User]
    
    String confirmCode
    
    boolean enabled = false
    
    static constraints = {
        confirmCode nullable: false
    }
}
