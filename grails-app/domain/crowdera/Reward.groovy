package crowdera

import groovy.transform.EqualsAndHashCode
import groovy.transform.ToString

@ToString(includeNames = true, includeFields = true)
@EqualsAndHashCode

class Reward {
	Date perkCreatedDate = new Date()
    String title
    String description
	int numberAvailable
    double price
    int rewardCount
    Image image
    boolean obsolete = false

    static belongsTo = Project

    static hasMany = [projects: Project]

    static constraints = {
        image (nullable: true)
        title nullable: true
        description nullable: true
		perkCreatedDate nullable : true
    }

}
