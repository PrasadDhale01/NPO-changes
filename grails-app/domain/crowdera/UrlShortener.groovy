package crowdera

import groovy.transform.EqualsAndHashCode;
import groovy.transform.ToString

@ToString(includeNames = true, includeFields = true)
@EqualsAndHashCode

class UrlShortener {
    String shortenUrl
    String projectId
    String username

    static constraints = {
        shortenUrl unique:true, nullable:false, blank: false;
        projectId nullable: false, blank:false
        username nullable: false, blank:false
    }
}
