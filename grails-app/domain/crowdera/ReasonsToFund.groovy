package crowdera

import groovy.transform.EqualsAndHashCode
import groovy.transform.ToString

@ToString(includeNames = true, includeFields = true)
@EqualsAndHashCode

class ReasonsToFund {
	
	String reason1
	String reason2
	String reason3
	
	static belongsTo = [project:Project]

    static constraints = {
		reason1 nullable:true
		reason2 nullable:true
		reason3 nullable:true
    }
}
