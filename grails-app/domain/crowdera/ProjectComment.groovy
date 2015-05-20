package crowdera

import groovy.transform.EqualsAndHashCode
import groovy.transform.ToString

@ToString(includeNames = true, includeFields = true, excludes = 'date')
@EqualsAndHashCode

class ProjectComment {

    static belongsTo = [project: Project, user: User]

    String comment
    Date date
    boolean status=false

    static mapping = {
        comment type: 'text'
    }

    static constraints = {
    }
}
