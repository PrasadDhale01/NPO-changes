package fedu

class Project {

	enum FundRaisingReason {
		/* Fund raising for self */
		VOCATIONAL_SCHOOL,
		TUITION,
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

	FundRaisingReason fundRaisingReason
	int fundRaisingAmount
	FundRaisingFor fundRaisingFor


    static constraints = {
    }
}
