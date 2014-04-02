package fedu

class CreditService {

    def getAllCreditsForCommunity(Community community) {
        if (!community) {
            return null
        }

        return community.credits
    }

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
