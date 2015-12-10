package crowdera
import groovy.transform.EqualsAndHashCode
import groovy.transform.ToString

@ToString(includeNames = true, includeFields = true)
@EqualsAndHashCode

class Folder {

    static hasMany = []
    
    String fName
    
    static constraints = {
        fName nullable: true
    }
}
