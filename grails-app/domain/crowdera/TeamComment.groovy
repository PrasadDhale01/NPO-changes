package crowdera

import groovy.transform.EqualsAndHashCode
import groovy.transform.ToString

@ToString(includeNames = true, includeFields = true, excludes = 'date')
@EqualsAndHashCode

class TeamComment {

    static belongsTo = [team: Team, user: User]

    String comment
    String userName
    Date date

    static mapping = {
        comment type: 'text'
    }

    static constraints = {
        userName nullable:true
    }
}
