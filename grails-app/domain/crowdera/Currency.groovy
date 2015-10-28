package crowdera
import groovy.transform.EqualsAndHashCode
import groovy.transform.ToString

@ToString(includeNames = true, includeFields = true)
@EqualsAndHashCode

class Currency {

    double currencyUSA
    
    static constraints = {
    }
}
