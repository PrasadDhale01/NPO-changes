package crowdera

class CrewReg {
	
	String firstName
	String lastName
	String email
	String letterDescription
	String crewDescription
	String resumeUrl
	String linkedIn
	String faceBook
	Date date
	boolean status = false
	
	static mapping = {
		letterDescription type:'text'
		crewDescription type: 'text'
	}

    static constraints = {
		firstName nullable: true
		lastName nullable: true
		email nullable: true
		letterDescription nullable: true
		crewDescription nullable: true
		resumeUrl nullable: true
		linkedIn nullable: true
		faceBook nullable: true
    }
}
