package fedu

import grails.transaction.Transactional

@Transactional
class ContributionService {

    def getTotalContributionForProject(Project project) {
        double total = 0
        project.contributions.each {
            total += it.amount
        }
        return total
    }

    def getPercentageContributionForProject(Project project) {
        double totalContribution = getTotalContributionForProject(project)
        def percentage
        if (totalContribution == 0) {
            percentage = 0
        } else if (totalContribution == project.amount) {
            percentage = 100
        } else {
            percentage = totalContribution / project.amount * 100
        }
        return percentage
    }

    def getFundingCompletedDate(Project project) {
        Contribution contribution = project.contributions.last()
        return contribution.date
    }
}
