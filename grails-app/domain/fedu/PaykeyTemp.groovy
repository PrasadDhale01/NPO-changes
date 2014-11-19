package fedu

class PaykeyTemp {
    String paykey
    String paypalEmail

    static constraints = {
        paykey(nullable: true)
        paypalEmail(nullable: true)
    }
}
