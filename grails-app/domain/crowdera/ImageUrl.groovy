package crowdera

class ImageUrl {
	String url

	static belongsTo = Project, ProjectUpdate

	static hasMany = [projects: Project]

	static mapping = {
		
	}
    static constraints = {
    }
}
