package crowdera

import groovy.transform.EqualsAndHashCode
import groovy.transform.ToString

@ToString(includeNames = true, includeFields = true, excludes = 'dateCreated')
@EqualsAndHashCode

class CommunityInvite {

    static belongsTo = [community: Community, user: User]
    String inviteCode
    Date dateCreated
    boolean accepted = false

    static constraints = {
        inviteCode unique: true
    }
}
