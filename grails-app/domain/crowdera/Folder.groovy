package crowdera
import groovy.transform.EqualsAndHashCode
import groovy.transform.ToString

@ToString(includeNames = true, includeFields = true)
@EqualsAndHashCode

class Folder {

    static hasMany = [documents : Document]
    static belongsTo = [user: User]
    
    String fName
    List documents
    
    static constraints = {
        fName nullable: true
    }
}
