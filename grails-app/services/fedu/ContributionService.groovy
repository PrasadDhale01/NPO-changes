package fedu

class ContributionService {

    def getTotalContribution() {
        def c = Contribution.createCriteria()
        def totalContribution = c.get {
            projections {
                sum "amount"
            }
        }
        return totalContribution
    }

    def getTotalContributors (Project project){
        def user = []
        project.contributions.each { 
            user.add(it.userId)
        }
        return user
    }

    def getShippingPendingItems() {
        return Contribution.findAllWhere(shippingDone: false)
    }

    def getShippingDoneItems() {
        return Contribution.findAllWhere(shippingDone: true)
    }

    def isFundingAchievedForProject(Project project) {
        if (!project) {
            return null
        }

        return getPercentageContributionForProject(project) == 100
    }

    def getTotalContributionForProject(Project project) {
        if (!project) {
            return null
        }

        double total = 0
        project.contributions.each { contribution ->
            total += contribution.amount
        }
        return total
    }

    def getBackersForProjectByReward(Project project, Reward reward) {
        if (!project || !reward) {
            return null
        }

        return Contribution.findAllByProjectAndReward(project, reward).size()
    }

    def getPercentageContributionForProject(Project project) {
        if (!project) {
            return null
        }

        double totalContribution = getTotalContributionForProject(project)
        def percentage
        if (totalContribution == 0) {
            percentage = 0
        } else if (totalContribution == project.amount) {
            percentage = 100
        } else {
            percentage = totalContribution / project.amount * 100
            percentage = percentage.intValue()
        }
        return percentage
    }

    def getFundingAchievedDate(Project project) {
        if (!project) {
            return null
        }

        Contribution contribution = project.contributions.last()
        return contribution.date
    }
}
