package crowdera

import groovy.transform.EqualsAndHashCode
import groovy.transform.ToString

@ToString(includeNames = true, includeFields = true, excludes = 'date')
@EqualsAndHashCode

class CustomerService {

    static hasMany = [attachments: ImageUrl]
    
    List attachments
    
    String category
    String customername
    String description
    String email
    String subject
    Date date
    boolean status = false
	
	static mapping = {
		description type: 'text'
	}
    
    static constraints = {
        category nullable: true
        customername nullable: true
        description nullable: true
        email nullable: true
        subject nullable: true
        attachments nullable: true
    }

}
