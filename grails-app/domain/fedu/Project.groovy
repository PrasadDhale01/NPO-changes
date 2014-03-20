package fedu

class Project {

    static belongsTo = [user: User]
    static hasMany = [contributions: Contribution, comments: ProjectComment, rewards: Reward]

	/* Who */
	String name
	String email
	String telephone
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

    /* More */
    List comments

	boolean validated = false

	static mapping = {
		story type: 'text'
	}

    static constraints = {
		email (email: true)
        image (nullable: true)
        imageUrl (nullable: true)
        rewards (nullable: true)
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
        NON_PROFIT,
        SCHOOL,
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
