package crowdera

import groovy.transform.EqualsAndHashCode;
import groovy.transform.ToString

@ToString(includeNames = true, includeFields = true)
@EqualsAndHashCode
class Country {
	
	static hasMany = [projects:Project,currencies:Currency]
	
	String  countryCode;
	String countryName;
	Currency currency;


    static constraints = {
		countryCode (nullable: true)
		countryName (nullable: true)
		currency (nullable: true)
	
    }
}
