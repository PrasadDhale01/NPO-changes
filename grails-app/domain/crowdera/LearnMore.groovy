package crowdera

class LearnMore {
String articleTitle
String articleContent

    static constraints = {
		articleTitle nullable:true
		articleContent nullable:true
    }
	
	static mapping = {
		articleContent column: "article_content", sqlType: "text"
	}
}
