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
    String contributorFirstName
    String contributorLastName
    String fundRaiser
    String contributorEmail
    String comments
    String panNumber
    
    // Citrus Related Information
    String merchantTxId
    String splitRef
    String splitId
    String settlementId
    String settlementDate
    String releaseFundRef
    
    String currency = 'USD'
    
    boolean shippingDone = false
    boolean isContributionOffline = false
    boolean isAnonymous = false
    boolean receiptSent = false
    
    // payout = true means fund has been release to campaign owners
    boolean payout = false

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
        settlementId nullable: true
        settlementDate nullable: true
        releaseFundRef nullable: true
        contributorFirstName nullable: true
        contributorLastName nullable: true
    }

    def beforeValidate() {
        if (!amount) {
            amount = reward.price
        }
    }

}
