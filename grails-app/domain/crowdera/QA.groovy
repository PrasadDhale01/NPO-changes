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
    String ans5
    String ans6
    String ans7
    String ans8
	
	static belongsTo = [project:Project]

    static constraints = {
        ans1 nullable:true
        ans2 nullable:true
        ans3 nullable:true
        ans4 nullable:true
        ans5 nullable:true
        ans6 nullable:true
        ans7 nullable:true
        ans8 nullable:true
    }
}
