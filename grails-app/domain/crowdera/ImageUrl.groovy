package crowdera

import groovy.transform.EqualsAndHashCode
import groovy.transform.ToString

@ToString(includeNames = true, includeFields = true)
@EqualsAndHashCode

class ImageUrl {
	String url
    int numberOfUrls

	static belongsTo = Project, ProjectUpdate, CustomerService, TaxReciept

	static hasMany = [projects: Project]

}
