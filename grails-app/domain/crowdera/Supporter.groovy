package crowdera

import groovy.transform.EqualsAndHashCode;
import groovy.transform.ToString

@ToString(includeNames = true, includeFields = true)
@EqualsAndHashCode
class Supporter {

    static belongsTo = [user: User, project: Project]

    static constraints = {

    }
}
