package crowdera

class ImageUrl {
	String url

	static belongsTo = Project, ProjectUpdate, CustomerService

	static hasMany = [projects: Project]

	static mapping = {
		
	}
    static constraints = {
    }
}
