package fedu

class CreditService {

    def getTotalCreditForCommunity(Community community) {
        if (!community) {
            return null
        }

        double total = 0
        community.credits.each { credit ->
            total += credit.amount
        }
        return total
    }
}
