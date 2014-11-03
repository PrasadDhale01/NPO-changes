package fedu

class Project {

    def rewardService

    static belongsTo = [user: User]
    static hasMany = [contributions: Contribution, comments: ProjectComment, rewards: Reward, imageUrl: ImageUrl]

    Beneficiary beneficiary
    Date created

    /* Why */
    Category category

    /* How much & when */
    double amount
    int days
    List contributions 

    /* How */
    String id
    String title
    String description
    String story
    String videoUrl
    Image image
	List imageUrl
    String fileUrl
    String organizationIconUrl
    List rewards

    /* More */
    List comments
    String charitableId
    String organizationName
    String webAddress

    boolean validated = false
    boolean inactive = false
    boolean send_mail = false

    static mapping = {
        id(generator: "uuid")
        description type: 'text'
        story type: 'text'
    }


    static constraints = {
        image (nullable: true)
        imageUrl (nullable: true)
        videoUrl (nullable:true)
        rewards (nullable: true)
        amount (max: 50000 as double)
        description (nullable: true)
        charitableId (nullable: true)
        story (nullable: true)
        organizationName (nullable: true)
        webAddress (blank: false, url: true, nullable: true)
        fileUrl (nullable: true)
        organizationIconUrl (nullable: true)
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
        ANIMALS,
        ARTS,
        CHILDREN,
        COMMUNITY,
        EDUCATION,
        ELDERLY,
        ENVIRONMENT,
        HEALTH,
        PUBLIC_SERVICES,
        RELIGION,
        OTHER
    }
}
