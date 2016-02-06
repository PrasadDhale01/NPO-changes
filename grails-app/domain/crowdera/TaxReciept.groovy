package crowdera

import groovy.transform.EqualsAndHashCode
import groovy.transform.ToString

@ToString(includeNames = true, includeFields = true, excludes = 'regDate,expiryDate,fcraRegDate')
@EqualsAndHashCode

class TaxReciept {

    String ein
    String city
    String name
    String taxRecieptHolderState
    String deductibleStatus
    String country
    String phone
    String panCardNumber
    String addressLine1
    String regNum
    String zip
    String addressLine2
    String fcraRegNum
    String signatureUrl

    Date regDate = new Date()
    Date expiryDate = new Date()
    Date fcraRegDate = new Date()

    static belongsTo = [project:Project]
    static hasMany = [files: ImageUrl]
    
    List files

    static constraints = {
        ein nullable:true
        city nullable:true
        name nullable:true
        taxRecieptHolderState nullable:true
        deductibleStatus nullable:true
        country nullable:true
        panCardNumber nullable:true
        phone nullable:true
        addressLine1 nullable:true
        regNum nullable:true
        zip nullable:true
        addressLine2 nullable:true
        fcraRegNum nullable:true
        signatureUrl nullable: true
    }
}
