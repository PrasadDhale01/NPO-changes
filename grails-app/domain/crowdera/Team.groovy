package crowdera

import java.util.List;

class Team {

    static hasMany = [contributions: Contribution, comments: TeamComment]
    
    static belongsTo = [user: User, project: Project]
    
    List contributions
	List comments
    Double amount
	
	Date joiningDate
    
    static constraints = {
        contributions nullable: true
		comments nullable: true
    }
    
}
