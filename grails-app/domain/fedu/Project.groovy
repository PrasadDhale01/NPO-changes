package fedu

class Project {

    def rewardService

    static belongsTo = [user: User]
    static hasMany = [contributions: Contribution, comments: ProjectComment, rewards: Reward]

    Beneficiary beneficiary
    Date created

	/* Why */
	FundRaisingFor fundRaisingFor
    Category category

	/* How much & when */
	double amount
	int days
    List contributions 

	/* How */
	String title
    String description
	String story
    String imageUrl
    Image image
    List rewards

    /* More */
    List comments
    String charitableId

	boolean validated = false

	static mapping = {
    description type: 'text'
	story type: 'text'
	}

    static constraints = {
        image (nullable: true)
        imageUrl (nullable: true)
        rewards (nullable: true)
        amount (max: 5000 as double)
        description (nullable: true)
        charitableId (nullable: true)
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

    enum FundRaisingFor {
        MYSELF,
        OTHER
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
