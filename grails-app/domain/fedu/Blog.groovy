package fedu

class Blog {

	String title
	String author
	String date
	String content
	String snippet

	static mapping = {
		content type: 'text'
		snippet type: 'text'
	}

	static constraints = {
	}
}
