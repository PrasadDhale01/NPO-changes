package crowdera

class Feedback {
	User user
	String answer_1
	String answer_2_y1
	String answer_2_y2
	String answer_2_n
	String answer_3
	String answer_4_y
	String answer_4_n
	String answer_5
	String answer_6
	String answer_7
	String answer_8
	String answer_9
	String answer_10
	
	static belongTo=User
	
    static constraints = {
		answer_1 nullable:true
		answer_2_y1 nullable:true
		answer_2_y2 nullable:true
		answer_2_n nullable:true
		answer_3 nullable:true
		answer_4_y nullable:true
		answer_4_n nullable:true
		answer_5 nullable:true
		answer_6 nullable:true
		answer_7 nullable:true
		answer_8 nullable:true
		answer_9 nullable:true
		answer_10 nullable:true
    }
}
