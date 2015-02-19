package crowdera

class ProjectUpdate {
    
    static belongsTo = [project: Project]
    static hasMany = [imageUrls: ImageUrl]
    
    List imageUrls
    String story
    
    static constraints = {
        imageUrls (nullable: true)
        story (nullable: true)
    }
    
    static mapping = {
        story type: 'text'
    }
}
