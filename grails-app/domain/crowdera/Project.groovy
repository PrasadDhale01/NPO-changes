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
	String wepayEmail
	
	String wepayFirstName
	String wepayLastName
	String wepayAccessToken
	String wepayAccountStatus;
	int wepayAccountId
    
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
		wepayEmail (nullable: true)
		wepayFirstName (nullable: true)
		wepayLastName (nullable: true)
		wepayAccessToken(nullable: true)
		wepayAccountStatus(nullable: true)
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
		Poverty_Hunger,
		Health_Fitness,
		Education_Schools_PTAs,
		Gender_Equality,
		LGBT,
		Clean_Water,
		Clean_Energy,
		Social_Entrepreneurship,
		Social_Innovation,
		Community_CivicNeeds,
		Africa,
		Climate_Change,
		Ocean_Life,
		Animal_Safety,
		Environment,
		Peace_CivilRights_Justice,
		Funds_Syndicates,
		Disaster_Relief,
		Celebrations,
		Accidents_Medical_Emergencies,
		Faith_Religion_Politics,
		Memorials,
		Volunteering,
		Entrepreneurship_Startup,
		Arts_Sports_Culture,
		Film_Theater_Music,
		Children_Women_Elders,
		Veterans,
		Others
	}
}
