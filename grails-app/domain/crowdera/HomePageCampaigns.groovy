package crowdera

import groovy.transform.EqualsAndHashCode;
import groovy.transform.ToString

@ToString(includeNames = true, includeFields = true)
@EqualsAndHashCode

class HomePageCampaigns {
    Project campaignOne
    Project campaignTwo
    Project campaignThree
    String currentEnv

    static constraints = {
    }
}
