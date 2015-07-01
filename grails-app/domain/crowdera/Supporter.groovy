package crowdera

class Supporter {

    static belongsTo = [user: User, project: Project]
    
    static constraints = {
        
    }
}
