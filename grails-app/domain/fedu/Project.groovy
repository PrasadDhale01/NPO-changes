package fedu

class Project {

	enum FundRaisingReason {
		/* Fund raising for self */
		VOCATIONAL_SCHOOL,
		TUITION_FEE,
		SCHOOL_SUPPLIES,
		STUDENT_LOAN,

		/* For raising for other... */
		SCHOOL_PROJECT,
		EDUCATE_POOR
	}

	enum FundRaisingFor {
		MYSELF,
		NON_PROFIT,
		SCHOOL,
	}

	String title
	String amount
	String email
	FundRaisingReason fundRaisingReason
	FundRaisingFor fundRaisingFor

    static constraints = {
		email (email: true)
    }
}
