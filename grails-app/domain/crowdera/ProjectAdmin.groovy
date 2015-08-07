package crowdera

import groovy.transform.EqualsAndHashCode
import groovy.transform.ToString

@ToString(includeNames = true, includeFields = true)
@EqualsAndHashCode

class ProjectAdmin {

    static belongsTo = [project: Project]
    
    String email
    int adminCount
    
    static constraints = {
        email email: true, nullable: true
        adminCount nullable:true
    }
}
