package fedu

class Blog {

	String title
	String author
	Date date
	String content
	String snippet
    boolean enabled = true

	static mapping = {
		content type: 'text'
		snippet type: 'text'
	}

	static constraints = {
	}
}
