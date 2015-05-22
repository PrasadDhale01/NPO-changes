package crowdera

import groovy.transform.EqualsAndHashCode
import groovy.transform.ToString

@ToString(includeNames = true, includeFields = true, excludes = 'date')
@EqualsAndHashCode

class Credit {
    double amount

    static belongsTo = [community: Community]
    static hasMany = [contributions: Contribution]

    Date date
    int daysValid = 30

    static constraints = {
    }
}
