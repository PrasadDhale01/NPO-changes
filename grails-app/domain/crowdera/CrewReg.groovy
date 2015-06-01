package crowdera

import groovy.transform.EqualsAndHashCode
import groovy.transform.ToString

@ToString(includeNames = true, includeFields = true, excludes = 'requestDate,adminDate')
@EqualsAndHashCode

class CrewReg {
	
	String firstName
	String lastName
	String email
	String phone
	String letterDescription
	String crewDescription
	String resumeUrl
	String linkedIn
	String faceBook
	String adminReply
	String docByAdmin
	Date requestDate
	Date adminDate
	boolean status = false
	
	static mapping = {
		letterDescription type:'text'
		crewDescription type: 'text'
	}

    static constraints = {
		firstName nullable: true
		lastName nullable: true
		email nullable: true
		phone nullable: true
		letterDescription nullable: true
		crewDescription nullable: true
		resumeUrl nullable: true
		linkedIn nullable: true
		faceBook nullable: true
		adminReply nullable: true
		docByAdmin nullable: true
    }
}
