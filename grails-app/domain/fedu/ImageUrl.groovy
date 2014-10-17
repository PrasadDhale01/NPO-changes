package fedu

class ImageUrl {
	String url

	static belongsTo = Project

	static hasMany = [projects: Project]

	static mapping = {
		
	}
    static constraints = {
    }
}
