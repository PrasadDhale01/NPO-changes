package crowdera

import groovy.transform.EqualsAndHashCode
import groovy.transform.ToString

@ToString(includeNames = true, includeFields = true)
@EqualsAndHashCode

class SpendMatrix {
	
    double amount
    String cause
    int numberAvailable
    
    static belongsTo = [project:Project]
    
    static constraints = {
        cause nullable:true
    }
}
