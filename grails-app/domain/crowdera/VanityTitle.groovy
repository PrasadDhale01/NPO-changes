package crowdera

import groovy.transform.EqualsAndHashCode
import groovy.transform.ToString

@ToString(includeNames = true, includeFields = true)
@EqualsAndHashCode

class VanityTitle {

    String projectTitle
    String vanityTitle
	String title

    static belongsTo = [project:Project]

    static constraints = {
		title nullable:true
        projectTitle nullable:true
        vanityTitle (nullable:true,unique:true)
    }
}
