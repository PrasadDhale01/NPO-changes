package crowdera

import groovy.transform.EqualsAndHashCode
import groovy.transform.ToString

@ToString(includeNames = true, includeFields = true)
@EqualsAndHashCode

class RewardShipping {

    String address
    String email
    String twitter
    String custom
    static belongsTo = [reward: Reward]
    
    static constraints = {
        address nullable: true
        email nullable: true
        twitter nullable: true
        custom nullable: true
        reward nullable: true
    }
}
