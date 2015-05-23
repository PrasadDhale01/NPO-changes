package crowdera
import groovy.transform.EqualsAndHashCode
import groovy.transform.ToString

@ToString(includeNames = true, includeFields = true, excludes = 'date')
@EqualsAndHashCode

class Contribution {

    double amount

    static belongsTo = [user: User, project: Project, reward: Reward, credit: Credit]

    Date date
    String email
    String twitterHandle
    String custom
    String physicalAddress
    String contributorName
    String fundRaiser
    String contributorEmail
    String comments
    
    boolean shippingDone = false
    boolean isContributionOffline = false
    boolean isAnonymous = false

    static constraints = {
        credit nullable: true
        reward nullable: true
        comments  nullable: true
        email nullable: true
        twitterHandle nullable: true
        custom nullable: true
        physicalAddress nullable: true
        contributorName nullable: true
        contributorEmail nullable: true
        fundRaiser nullable: true
    }

    def beforeValidate() {
        if (!amount) {
            amount = reward.price
        }
    }

}
