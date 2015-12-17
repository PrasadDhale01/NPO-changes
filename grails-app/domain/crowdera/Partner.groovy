package crowdera

import groovy.transform.EqualsAndHashCode
import groovy.transform.ToString

@ToString(includeNames = true, includeFields = true)
@EqualsAndHashCode

class Partner {
    
    static belongsTo = [user: User]
    static hasMany = [documents : Document]
    
    String confirmCode
    List documents
    
    boolean enabled = false
    
    static constraints = {
        confirmCode nullable: false
    }
}
