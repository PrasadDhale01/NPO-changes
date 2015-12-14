package crowdera

import groovy.transform.EqualsAndHashCode
import groovy.transform.ToString

@ToString(includeNames = true, includeFields = true)
@EqualsAndHashCode
class SocialContacts {
	User user
	String gmail
	String constantContact
	String mailchimp
	
	static belongsTo =  [user: User]

    static constraints = {
		gmail maxSize:65535 ,nullable: true
		constantContact maxSize:65535 ,nullable:true
		mailchimp maxSize:65535 , nullable:true
    }
}
