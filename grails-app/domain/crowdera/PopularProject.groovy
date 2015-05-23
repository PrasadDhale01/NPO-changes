package crowdera

import groovy.transform.EqualsAndHashCode
import groovy.transform.ToString

@ToString(includeNames = true, includeFields = true)
@EqualsAndHashCode

class PopularProject {

	static belongsTo = [project: Project]
	
    static constraints = {
		
    }
	
	static maping = {
		
	}
}
