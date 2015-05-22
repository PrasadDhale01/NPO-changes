package crowdera

import groovy.transform.EqualsAndHashCode
import groovy.transform.ToString

@ToString(includeNames = true, includeFields = true)
@EqualsAndHashCode

class PaykeyTemp {
    String paykey
    String timestamp

    static constraints = {
        paykey(nullable: true)
        timestamp(nullable: true,unique:true)
    }
}
