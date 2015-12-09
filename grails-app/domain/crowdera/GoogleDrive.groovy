package crowdera

import groovy.transform.EqualsAndHashCode
import groovy.transform.ToString

@ToString(includeNames = true, includeFields = true)
@EqualsAndHashCode

class GoogleDrive {

    String alternateLink
    String fileId
    String title 

    static constraints = {
        alternateLink nullable: true
        fileId nullable: true
        title nullable: true
    }
}
