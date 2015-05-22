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
    
    static constraints = {
        imageUrls (nullable: true)
        story (nullable: true)
    }
    
    static mapping = {
        story type: 'text'
    }
}
