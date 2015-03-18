package crowdera

import java.util.List;

class Team {

    static hasMany = [contributions: Contribution, comments: TeamComment, imageUrl: ImageUrl]
    
    static belongsTo = [user: User, project: Project]
    
    List contributions
    List comments
    List imageUrl
    
    Double amount
	
	String description
    String story
    String videoUrl
	
    boolean enable = true
    boolean validated = false
	
    Date joiningDate
    
    static mapping = {
        description type: 'text'
        story type: 'text'
    }
    
    static constraints = {
        contributions nullable: true
		description nullable: true
	    comments nullable: true
	    imageUrl nullable: true
	    videoUrl nullable:true
	    story nullable: true
    }
    
}
