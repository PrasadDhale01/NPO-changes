package crowdera

import groovy.transform.EqualsAndHashCode
import groovy.transform.ToString

@ToString(includeNames = true, includeFields = true)
@EqualsAndHashCode

class ProjectAdmin {

    static belongsTo = [project: Project]
    
    String email
    
    static constraints = {
        email email: true, nullable: true
    }
}
