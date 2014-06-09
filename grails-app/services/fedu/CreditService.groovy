package fedu

class CreditService {

    def getAllNonExpiredCreditsForCommunity(Community community) {
        def credits = Credit.findAllByCommunity(community)

        Date today = new Date()
        def creditsNonExpired = credits.findAll { Credit credit ->
            credit.date.getTime() + (credit.daysValid * 24 * 60 * 60 * 1000) < today.getTime()
        }

        return creditsNonExpired
    }

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

    def getRemainingCreditForCommunity(Community community) {
        if (!community) {
            return null
        }

        double total = 0
        double used = 0

        // A given community can have many credits added over time.
        // For each credit, there can be many contributions made over time from a given credit.
        // So for each credit belonging to a community, add all the contributions made from this credit.
        community.credits.each { credit ->
            total += credit.amount

            def contributions = Contribution.findAllByCredit(credit)

            contributions.each { Contribution contribution ->
                used += contribution.amount
            }
        }

        return total - used
    }
}
