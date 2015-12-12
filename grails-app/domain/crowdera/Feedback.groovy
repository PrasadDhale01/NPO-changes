package crowdera

import groovy.transform.EqualsAndHashCode
import groovy.transform.ToString

@ToString(includeNames = true, includeFields = true)
@EqualsAndHashCode

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
	String answer_9_y1
	String answer_9_y2
	String answer_9_y3
	String answer_9_y4
	String answer_9_y5
	String answer_9_y6
	String answer_9_n
	String rating
	
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
		answer_9_y1 nullable: true
		answer_9_y2 nullable: true
		answer_9_y3 nullable: true
		answer_9_y4 nullable: true
		answer_9_y5 nullable:true
		answer_9_y6 nullable: true
		answer_9_n	nullable: true
		rating nullable:true
    }
}
