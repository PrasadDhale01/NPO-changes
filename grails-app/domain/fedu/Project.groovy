package fedu

class Project {

    static belongsTo = [user: User]
    static hasOne = [image: Image]
    static hasMany = [contributions: Contribution]

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

	boolean validated = false

	static mapping = {
		story type: 'text'
	}

    static constraints = {
		email (email: true)
        image (nullable: true)
        imageUrl (nullable: true)
    }
}
