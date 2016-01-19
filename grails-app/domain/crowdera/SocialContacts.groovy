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
     String csvContact
     String facebook
     
     static belongsTo =  [user: User]

     static constraints = {
         gmail  nullable: true
         constantContact nullable:true
         mailchimp nullable:true
         csvContact nullable:true
         facebook nullable:true
    }
     
    static mapping = {
         gmail type:'text'
         constantContact type:'text'
         mailchimp type:'text'
         csvContact type:'text'
         facebook type:'text'    
    }
}
