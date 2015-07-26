package crowdera

import groovy.transform.EqualsAndHashCode
import groovy.transform.ToString

@ToString(includeNames = true, includeFields = true)
@EqualsAndHashCode

class Reward {
    String title
    String description
	String numberAvailable
    double price
    Image image
    boolean obsolete = false

    static belongsTo = Project

    static hasMany = [projects: Project]

    static constraints = {
        image (nullable: true)
        title nullable: true
        description nullable: true
		numberAvailable nullable:true
    }

    static mapping = {
        sort 'price'
    }
}
