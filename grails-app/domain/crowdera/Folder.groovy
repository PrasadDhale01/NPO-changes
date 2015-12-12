package crowdera
import groovy.transform.EqualsAndHashCode
import groovy.transform.ToString

@ToString(includeNames = true, includeFields = true)
@EqualsAndHashCode

class Folder {

    static hasMany = [documents : Document]
    
    String fName
    List documents
    
    static constraints = {
        fName nullable: true
    }
}
