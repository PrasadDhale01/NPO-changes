package crowdera

import groovy.transform.EqualsAndHashCode
import groovy.transform.ToString
 
@ToString(includeNames = true, includeFields = true)
@EqualsAndHashCode
 
class PaypalIPNData {
 
    String firstName
    String lastName
    String addressZip
    String addressState
    String addressName
    String addressStreet
    String addressCountry
    String addressCity
    String residenceCountry
    String receiverEmail
    String paymentType
    String paymentDate
    String paymentStatus
    String payerId
    String payerEmail
    String payerStatus
    String itemNumber
    String invoice
    String shipping
    String txnId
    String txnType
    String mcGross
    String mcCurrency
    String itemName
    String receiverId
      
    static constraints = {
        itemNumber nullable: true
        residenceCountry nullable: true
        invoice nullable: true
        addressCountry nullable: true
        addressCity nullable: true
        paymentStatus nullable: true
        payerId nullable: true
        firstName nullable: true
        shipping nullable: true
        payerEmail nullable: true
        txnId nullable: true
        receiverEmail nullable: true
        txnType nullable: true
        mcGross nullable: true
        mcCurrency nullable: true
        payerStatus nullable: true
        paymentDate nullable: true
        addressZip nullable: true
        addressState nullable: true
        itemName nullable: true
        addressName nullable: true
        lastName nullable: true
        paymentType nullable: true
        addressStreet nullable: true
        receiverId nullable: true
    }
 }
