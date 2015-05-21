package crowdera

import groovy.transform.EqualsAndHashCode
import groovy.transform.ToString

@ToString(includeNames = true, includeFields = true)
@EqualsAndHashCode

class ImageUrl {
	String url

	static belongsTo = Project, ProjectUpdate, CustomerService

	static hasMany = [projects: Project]

	static mapping = {
		
	}
    static constraints = {
    }
}
