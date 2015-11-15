package crowdera

import groovy.transform.EqualsAndHashCode
import groovy.transform.ToString

@ToString(includeNames = true, includeFields = true)
@EqualsAndHashCode

class QA {

	String ans1
	String ans2
	String ans3
	String ans4
	
	static belongsTo = [project:Project]

    static constraints = {
        ans1 nullable:true
		ans2 nullable:true
		ans3 nullable:true
		ans4 nullable:true
    }
}
