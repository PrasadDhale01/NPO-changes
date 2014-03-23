package fedu

import grails.transaction.Transactional

class ContributionService {

    def isFundingAchievedForProject(Project project) {
        return getPercentageContributionForProject(project) == 100
    }

    def getTotalContributionForProject(Project project) {
        if (!project) {
            return null
        }

        double total = 0
        project.contributions.each { contribution ->
            total += contribution.reward.price
        }
        return total
    }

    def getBackersForProjectByReward(Project project, Reward reward) {
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
