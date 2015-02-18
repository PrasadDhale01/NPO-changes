package crowdera

class ProjectAdmin {

    static belongsTo = [project: Project]
    
    String email
    
    static constraints = {
        email email: true, nullable: true
    }
}
