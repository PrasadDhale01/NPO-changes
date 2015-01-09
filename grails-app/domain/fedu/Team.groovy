package fedu

import java.util.List;

class Team {

    static hasMany = [contributions: Contribution]
    
    static belongsTo = [user: User, project: Project]
    
    List contributions
    Double amount
    
    static constraints = {
        contributions nullable: true
    }
    
}
