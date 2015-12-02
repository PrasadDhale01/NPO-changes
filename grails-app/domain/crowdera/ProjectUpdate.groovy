package crowdera

import groovy.transform.EqualsAndHashCode
import groovy.transform.ToString

@ToString(includeNames = true, includeFields = true)
@EqualsAndHashCode

class ProjectUpdate {
    
    static belongsTo = [project: Project]
    static hasMany = [imageUrls: ImageUrl]
    
    List imageUrls
    String story
    String title
	Date updateDate = new Date()
    
    static constraints = {
        imageUrls (nullable: true)
        story (nullable: true)
        title (nullable: true)
		updateDate (nullable:true)
    }
    
    static mapping = {
        story type: 'text'
    }
}
