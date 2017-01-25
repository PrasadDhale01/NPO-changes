package crowdera
import groovy.transform.EqualsAndHashCode
import groovy.transform.ToString

@ToString(includeNames = true, includeFields = true)
@EqualsAndHashCode

class Currency {

	static belongsTo = [country:Country]
	
	String currency_name
	String currency_code
	String currency_value
    double dollar = 0;
		  
	  static constraints = {
		  currency_name (nullable: true)
		  currency_code (nullable: true)
		  currency_value (nullable: true)
	}
	
}
