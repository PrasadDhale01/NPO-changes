package crowdera

import groovy.transform.EqualsAndHashCode
import groovy.transform.ToString

@ToString(includeNames = true, includeFields = true)
@EqualsAndHashCode

class Image {
    byte[] bytes
    String contentType

    // static belongsTo = [project: Project]

    static constraints = {
        // Limit upload file size to 2MB
        bytes (maxSize: 1024 * 1024 * 2)
    }
}
