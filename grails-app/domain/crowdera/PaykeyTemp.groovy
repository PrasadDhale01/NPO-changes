package crowdera

class PaykeyTemp {
    String paykey
    String timestamp

    static constraints = {
        paykey(nullable: true)
        timestamp(nullable: true,unique:true)
    }
}
