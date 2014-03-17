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

	/* Who */
	String name
	String email
	String telephone
    Date created

	/* Why */
	FundRaisingReason fundRaisingReason
	FundRaisingFor fundRaisingFor

	/* How much & when */
	double amount
	int days
    List contributions

	/* How */
	String title
	String story

	boolean validated = false

	static mapping = {
		story type: 'text'
	}

    static constraints = {
		email (email: true)
        image (nullable: true)
    }
}
