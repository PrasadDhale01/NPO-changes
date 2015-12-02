package crowdera

import groovy.transform.EqualsAndHashCode;
import groovy.transform.ToString

@ToString(includeNames = true, includeFields = true)
@EqualsAndHashCode
class Supporter {

	Date followedDate = new Date()
    static belongsTo = [user: User, project: Project]

    static constraints = {
		followedDate nullable:true
    }
}
