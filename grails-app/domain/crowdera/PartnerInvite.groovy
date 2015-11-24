package crowdera

class PartnerInvite {
    
    static belongsTo = [partner: Partner]

    String email
    
    static constraints = {
        email blank: false, nullable: true
    }
}
