package fedu

class Project {

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

	/* Why */
	FundRaisingReason fundRaisingReason
	FundRaisingFor fundRaisingFor

	/* How much & when */
	int amount
	int days

	/* How */
	String title
	String story

	boolean validated = false

	static mapping = {
		story type: 'text'
	}

    static constraints = {
		email (email: true)
    }
}
