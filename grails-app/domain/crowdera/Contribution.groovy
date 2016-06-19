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
    String panNumber
    String merchantTxId
    String splitRef
    String splitId
    String settleMentId
    
    String currency = 'USD'
    
    boolean shippingDone = false
    boolean isContributionOffline = false
    boolean isAnonymous = false
    boolean receiptSent = false
    boolean payout = false
    
    // payout = true means fund has been release to campaign owners 

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
        panNumber nullable: true
        merchantTxId nullable: true
        splitRef nullable: true
        splitId nullable: true
        settleMentId nullable: true
    }

    def beforeValidate() {
        if (!amount) {
            amount = reward.price
        }
    }

}
