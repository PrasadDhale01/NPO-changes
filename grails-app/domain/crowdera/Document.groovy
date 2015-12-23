package crowdera

import groovy.transform.EqualsAndHashCode
import groovy.transform.ToString

@ToString(includeNames = true, includeFields = true)
@EqualsAndHashCode

class Document {

    static belongsTo = Folder, Partner
    
    String docName
    String docUrl
    int numberOfDocs
    
    static constraints = {
        docName nullable: true
        docUrl nullable: true
    }
}
