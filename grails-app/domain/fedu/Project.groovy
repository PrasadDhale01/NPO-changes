package fedu

class Project {

    def rewardService

    static belongsTo = [user: User]
    static hasMany = [contributions: Contribution, comments: ProjectComment, rewards: Reward]

    Beneficiary beneficiary

    Date created

	/* Why */
	FundRaisingReason fundRaisingReason
	FundRaisingFor fundRaisingFor
    Category category

	/* How much & when */
	double amount
	int days
    List contributions

	/* How */
	String title
	String story
    String imageUrl
    Image image
    List rewards

    /* More */
    List comments

	boolean validated = false

	static mapping = {
		story type: 'text'
	}

    static constraints = {
        image (nullable: true)
        imageUrl (nullable: true)
        rewards (nullable: true)
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

    enum FundRaisingReason {
        /* Fund raising for self */
        VOCATIONAL_SCHOOL,
        TUITION_FEE,
        SCHOOL_SUPPLIES,
        STUDENT_LOAN,

        /* Fund raising for other... */
        SCHOOL_PROJECT,
        EDUCATE_POOR
    }

    enum FundRaisingFor {
        MYSELF,
        OTHER
    }

    enum Category {
        AGRICULTURE,
        TECHNOLOGY,
        ENTREPRENEURSHIP,
        PRIMARY_EDUCATION,
        WOMEN_EMPOWERMENT,
        COLLEGE_ACCESS,
        SCIENCE,
        ARTS_CULTURE,
        SPORTS,
        LITERACY_LANGUAGE,
        OTHER
    }
}
