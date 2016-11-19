package crowdera

import groovy.transform.EqualsAndHashCode
import groovy.transform.ToString

@ToString(includeNames = true, includeFields = true, excludes = 'created')
@EqualsAndHashCode

class Project {

    def rewardService
    
    static belongsTo = [user: User,country:Country]
    static hasMany = [contributions: Contribution, comments: ProjectComment, rewards: Reward, imageUrl: ImageUrl, projectAdmins: ProjectAdmin,projectUpdates: ProjectUpdate, teams: Team, vanityTitle: VanityTitle, supporters: Supporter, spend:SpendMatrix]
    
    Beneficiary beneficiary
    Date created
    
    /* Why */
    Category category
    
    /* How much & when */
    double amount
    int days
    int gmailShareCount
    int impactAmount
    int impactNumber
    List contributions 
    List projectAdmins
    List projectUpdates
    List teams
    List supporters
    
    /* How */
    String id
    String title
    String description
    String story
    String videoUrl
    Image image
    List imageUrl
    String organizationIconUrl
    List rewards
    
    /* More */
    List comments
    String organizationName
    String webAddress
    String secretKey
    String usedFor
    String fundsRecievedBy
    String customVanityUrl
    String partnerInviteCode
    String hashtags
    
    String sellerId
    
    /* Payment Info */
    String charitableId
    String payuEmail
    String paypalEmail
    String citrusEmail
    
    /* For India Platform payuStatus is true*/
    boolean payuStatus=false
    
    boolean validated = false
    boolean inactive = false
    boolean send_mail = false
    boolean draft = false
    boolean rejected = false
    boolean touAccepted = false
    boolean offeringTaxReciept = false
    boolean onHold = false
    
    static mapping = {
        id(generator: "uuid")
        description type: 'text'
        story type: 'text'
    }
    
    static constraints = {
        title (nullable: true)
        image (nullable: true)
        imageUrl (nullable: true)
        videoUrl (nullable:true)
        rewards (nullable: true)
        amount (max: 99999999 as double)
        description (nullable: true)
        charitableId (nullable: true)
        story (nullable: true)
        organizationName (nullable: true)
        webAddress (blank: false, nullable: true)
        organizationIconUrl (nullable: true)
        projectAdmins(nullable: true)
        paypalEmail(nullable: true)
        payuEmail(nullable:true)
        projectUpdates(nullable: true)
        secretKey(nullable: true)
        usedFor(nullable:true)
        fundsRecievedBy(nullable:true)
        customVanityUrl(nullable:true)
        partnerInviteCode (nullable: true)
        hashtags(nullable:true)
        citrusEmail (nullable: true)
        sellerId (nullable: true)
    }
    
    def beforeInsert() {
        /* If the $0 reward (which has id 1) isn't in the list, add it. */
        Reward reward = rewards.find {
            it.id == 1
        }
        if (!reward) {
            addToRewards(rewardService.getNoReward())
        }
    }
    
    enum Category {
        CATEGORY,
        ANIMALS,
        ARTS,
        CHILDREN,
        COMMUNITY,
        CIVIC_NEEDS,
        EDUCATION,
        ELDERLY,
        ENVIRONMENT,
        FILM,
        HEALTH,
        NON_PROFITS,
        SOCIAL_INNOVATION,
        RELIGION,
        OTHER
    }
}
