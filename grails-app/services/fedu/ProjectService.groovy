package fedu

import grails.transaction.Transactional

import java.text.DateFormat
import java.text.SimpleDateFormat

class ProjectService {
    def userService
    def contributionService
    def grailsLinkGenerator

    def getNumberOfProjects() {
        return Project.count()
    }

    def getProjectImageLink(Project project) {
        if (project.imageUrl) {
            if (project.imageUrl.startsWith('http')) {
                return project.imageUrl
            } else {
                return grailsLinkGenerator.resource(file: project.imageUrl)
            }
        } else if (project.image) {
            return grailsLinkGenerator.link(controller: 'project', action: 'thumbnail', id: project.id)
        } else {
            return 'http://lorempixel.com/400/400/abstract'
        }
    }

    def isFundingOpen(Project project) {
        if (isProjectDeadlineCrossed(project) || contributionService.isFundingAchievedForProject(project)) {
            return false
        } else {
            return true
        }
    }

    def isProjectDeadlineCrossed(Project project) {
        if (!project) {
            return null
        }

        def startDate = getProjectStartDate(project)
        def endDate = getProjectEndDate(project)

        def today = Calendar.instance
        boolean ended = endDate.compareTo(today) < 0 ? true : false

        return ended
    }

    def getProjectStartDate(Project project) {
        if (!project) {
            return null
        }

        def startDate = Calendar.instance
        startDate.setTime(project.created)

        return startDate
    }

    def getProjectEndDate(Project project) {
        if (!project) {
            return null
        }

        def endDate = Calendar.instance
        endDate.setTime(project.created)
        endDate.add Calendar.DAY_OF_YEAR, project.days

        return endDate
    }

    @Transactional
    def bootstrap() {
        DateFormat dateFormat = new SimpleDateFormat("MM/dd/yyyy")

        User deepshikha = userService.bootstrapDeepshikha()
        User sampleUser = User.findByUsername('user@example.com')

        new Project(
                name: 'Machine learning enthusiast',
                email: 'info@deepshikha.org',
                created: dateFormat.parse("01/15/2014"),
                telephone: '+91 12345678',
                amount: '600.0',
                days: '100',
                fundRaisingReason: Project.FundRaisingReason.TUITION_FEE,
                fundRaisingFor: Project.FundRaisingFor.MYSELF,
                category: Project.Category.TECHNOLOGY,
                title: 'Machine Learning',
                story: 'Maching learning is going to change the world for ever.',
                validated: true,
                imageUrl: 'https://1.bp.blogspot.com/-tn9GwuoC45w/TvtQvP6_UFI/AAAAAAAAAHI/ECpLGjyH6AI/s1600/machine_learning_course.png',
                user: sampleUser
        ).addToRewards(
                Reward.findById(1)
        ).addToRewards(
                Reward.findById(2)
        ).addToRewards(
                Reward.findById(3)
        ).addToRewards(
                Reward.findById(4)
        ).addToRewards(
                Reward.findById(5)
        ).addToRewards(
                Reward.findById(6)
        ).addToContributions(
                date: dateFormat.parse("01/16/2014"),
                user: sampleUser,
                reward: Reward.findById(3)
        ).addToContributions(
                date: dateFormat.parse("01/20/2014"),
                user: sampleUser,
                reward: Reward.findById(2)
        ).save(failOnError: true)

        new Project(
                name: 'Anasuya',
                email: 'info@deepshikha.org',
                created: dateFormat.parse("01/15/2014"),
                telephone: '+91 12345678',
                amount: '100.0',
                days: '15',
                fundRaisingReason: Project.FundRaisingReason.VOCATIONAL_SCHOOL,
                fundRaisingFor: Project.FundRaisingFor.NON_PROFIT,
                category: Project.Category.WOMEN_EMPOWERMENT,
                title: 'Cooperative dairy farming',
                story: 'These women are from extremely impoverished and  rural areas of Maharashtra, India. Their husbands are farm owners or workers who are dependent upon the monsoon season to cultivate their produce. Inflation and poverty is making their lives unpredictable, unstable and strenuous. These women want to help their families by getting trained in cooperative dairy farming by Deepshikha and start their micro business.',
                validated: true,
				imageUrl: 'images/projects/Deepshikha/Anusuya.png',
                user: deepshikha
        ).addToRewards(
                Reward.findById(1)
        ).addToRewards(
                Reward.findById(2)
        ).addToRewards(
                Reward.findById(3)
        ).addToRewards(
                Reward.findById(4)
        ).addToRewards(
                Reward.findById(5)
        ).addToRewards(
                Reward.findById(6)
        ).addToContributions(
                reward: Reward.findById(5),
                date: dateFormat.parse("01/16/2014"),
                user: sampleUser
        ).addToContributions(
                reward: Reward.findById(5),
                date: dateFormat.parse("01/17/2014"),
                user: sampleUser
        ).addToContributions(
                reward: Reward.findById(5),
                date: dateFormat.parse("01/20/2014"),
                user: sampleUser
        ).addToContributions(
                reward: Reward.findById(5),
                date: dateFormat.parse("01/22/2014"),
                user: sampleUser
        ).save(failOnError: true)

        new Project(
                name: 'Roshanbai',
                email: 'info@deepshikha.org',
                created: dateFormat.parse("01/15/2014"),
                telephone: '+91 12345678',
                amount: '100.0',
                days: '15',
                fundRaisingReason: Project.FundRaisingReason.VOCATIONAL_SCHOOL,
                fundRaisingFor: Project.FundRaisingFor.NON_PROFIT,
                category: Project.Category.WOMEN_EMPOWERMENT,
                title: 'Cooperative dairy farming',
                story: 'These women are from extremely impoverished and  rural areas of Maharashtra, India. Their husbands are farm owners or workers who are dependent upon the monsoon season to cultivate their produce. Inflation and poverty is making their lives unpredictable, unstable and strenuous. These women want to help their families by getting trained in cooperative dairy farming by Deepshikha and start their micro business.',
                validated: true,
				imageUrl: 'images/projects/Deepshikha/Roshanbai.png',
                user: deepshikha
        ).addToRewards(
                Reward.findById(1)
        ).addToRewards(
                Reward.findById(3)
        ).addToRewards(
                Reward.findById(5)
        ).addToRewards(
                Reward.findById(7)
        ).addToRewards(
                Reward.findById(9)
        ).addToRewards(
                Reward.findById(4)
        ).addToContributions(
                reward: Reward.findById(7),
                date: dateFormat.parse("01/23/2014"),
                user: sampleUser
        ).save(failOnError: true)

        new Project(
                name: 'Vandana',
                email: 'info@deepshikha.org',
                created: dateFormat.parse("01/15/2014"),
                telephone: '+91 12345678',
                amount: '100.0',
                days: '15',
                fundRaisingReason: Project.FundRaisingReason.VOCATIONAL_SCHOOL,
                fundRaisingFor: Project.FundRaisingFor.NON_PROFIT,
                category: Project.Category.WOMEN_EMPOWERMENT,
                title: 'Cooperative dairy farming',
                story: 'These women are from extremely impoverished and  rural areas of Maharashtra, India. Their husbands are farm owners or workers who are dependent upon the monsoon season to cultivate their produce. Inflation and poverty is making their lives unpredictable, unstable and strenuous. These women want to help their families by getting trained in cooperative dairy farming by Deepshikha and start their micro business.',
                validated: true,
				imageUrl: 'images/projects/Deepshikha/Vandana.png',
                user: deepshikha
        ).addToRewards(
                Reward.findById(2)
        ).addToRewards(
                Reward.findById(3)
        ).addToRewards(
                Reward.findById(5)
        ).addToRewards(
                Reward.findById(7)
        ).addToRewards(
                Reward.findById(9)
        ).addToRewards(
                Reward.findById(10)
        ).addToContributions(
                reward: Reward.findById(10),
                date: dateFormat.parse("01/21/2014"),
                user: sampleUser
        ).save(failOnError: true)

        new Project(
                name: 'Pushpa',
                email: 'info@deepshikha.org',
                created: dateFormat.parse("01/15/2014"),
                telephone: '+91 12345678',
                amount: '100.0',
                days: '15',
                fundRaisingReason: Project.FundRaisingReason.VOCATIONAL_SCHOOL,
                fundRaisingFor: Project.FundRaisingFor.NON_PROFIT,
                category: Project.Category.WOMEN_EMPOWERMENT,
                title: 'Cooperative dairy farming',
                story: 'These women are from extremely impoverished and  rural areas of Maharashtra, India. Their husbands are farm owners or workers who are dependent upon the monsoon season to cultivate their produce. Inflation and poverty is making their lives unpredictable, unstable and strenuous. These women want to help their families by getting trained in cooperative dairy farming by Deepshikha and start their micro business.',
                validated: true,
				imageUrl: 'images/projects/Deepshikha/Pushpa.png',
                user: deepshikha
        ).addToRewards(
                Reward.findById(1)
        ).addToRewards(
                Reward.findById(4)
        ).addToRewards(
                Reward.findById(5)
        ).addToRewards(
                Reward.findById(6)
        ).addToRewards(
                Reward.findById(9)
        ).addToRewards(
                Reward.findById(10)
        ).addToContributions(
                reward: Reward.findById(9),
                date: dateFormat.parse("01/26/2014"),
                user: sampleUser
        ).save(failOnError: true)

        new Project(
                name: 'Sangita',
                email: 'info@deepshikha.org',
                created: dateFormat.parse("01/15/2014"),
                telephone: '+91 12345678',
                amount: '100.0',
                days: '15',
                fundRaisingReason: Project.FundRaisingReason.VOCATIONAL_SCHOOL,
                fundRaisingFor: Project.FundRaisingFor.NON_PROFIT,
                category: Project.Category.WOMEN_EMPOWERMENT,
                title: 'Cooperative dairy farming',
                story: 'These women are from extremely impoverished and  rural areas of Maharashtra, India. Their husbands are farm owners or workers who are dependent upon the monsoon season to cultivate their produce. Inflation and poverty is making their lives unpredictable, unstable and strenuous. These women want to help their families by getting trained in cooperative dairy farming by Deepshikha and start their micro business.',
                validated: true,
				imageUrl: 'images/projects/Deepshikha/Sangita.png',
                user: deepshikha
        ).addToRewards(
                Reward.findById(2)
        ).addToRewards(
                Reward.findById(3)
        ).addToRewards(
                Reward.findById(4)
        ).addToRewards(
                Reward.findById(5)
        ).addToRewards(
                Reward.findById(6)
        ).addToRewards(
                Reward.findById(7)
        ).addToContributions(
                reward: Reward.findById(5),
                date: dateFormat.parse("01/18/2014"),
                user: sampleUser
        ).save(failOnError: true)

        new Project(
                name: 'Sunanda',
                email: 'info@deepshikha.org',
                created: dateFormat.parse("01/15/2014"),
                telephone: '+91 12345678',
                amount: '100.0',
                days: '15',
                fundRaisingReason: Project.FundRaisingReason.VOCATIONAL_SCHOOL,
                fundRaisingFor: Project.FundRaisingFor.NON_PROFIT,
                category: Project.Category.WOMEN_EMPOWERMENT,
                title: 'Cooperative dairy farming',
                story: 'These women are from extremely impoverished and  rural areas of Maharashtra, India. Their husbands are farm owners or workers who are dependent upon the monsoon season to cultivate their produce. Inflation and poverty is making their lives unpredictable, unstable and strenuous. These women want to help their families by getting trained in cooperative dairy farming by Deepshikha and start their micro business.',
                validated: true,
				imageUrl: 'images/projects/Deepshikha/Sunanda.png',
                user: deepshikha
        ).addToRewards(
                Reward.findById(1)
        ).addToRewards(
                Reward.findById(2)
        ).addToRewards(
                Reward.findById(3)
        ).addToRewards(
                Reward.findById(4)
        ).addToRewards(
                Reward.findById(8)
        ).addToRewards(
                Reward.findById(10)
        ).addToContributions(
                reward: Reward.findById(4),
                date: dateFormat.parse("01/24/2014"),
                user: sampleUser
        ).save(failOnError: true)

        new Project(
                name: 'Tarabai',
                email: 'info@deepshikha.org',
                created: dateFormat.parse("01/15/2014"),
                telephone: '+91 12345678',
                amount: '100.0',
                days: '15',
                fundRaisingReason: Project.FundRaisingReason.VOCATIONAL_SCHOOL,
                fundRaisingFor: Project.FundRaisingFor.NON_PROFIT,
                category: Project.Category.WOMEN_EMPOWERMENT,
                title: 'Cooperative dairy farming',
                story: 'These women are from extremely impoverished and  rural areas of Maharashtra, India. Their husbands are farm owners or workers who are dependent upon the monsoon season to cultivate their produce. Inflation and poverty is making their lives unpredictable, unstable and strenuous. These women want to help their families by getting trained in cooperative dairy farming by Deepshikha and start their micro business.',
                validated: true,
				imageUrl: 'images/projects/Deepshikha/Tarabai.png',
                user: deepshikha
        ).addToRewards(
                Reward.findById(1)
        ).addToRewards(
                Reward.findById(2)
        ).addToRewards(
                Reward.findById(3)
        ).addToRewards(
                Reward.findById(5)
        ).addToRewards(
                Reward.findById(8)
        ).addToRewards(
                Reward.findById(10)
        ).addToContributions(
                reward: Reward.findById(8),
                date: dateFormat.parse("01/29/2014"),
                user: sampleUser
        ).save(failOnError: true)

        new Project(
                name: 'Asha',
                email: 'info@deepshikha.org',
                created: dateFormat.parse("01/15/2014"),
                telephone: '+91 12345678',
                amount: '100.0',
                days: '15',
                fundRaisingReason: Project.FundRaisingReason.VOCATIONAL_SCHOOL,
                fundRaisingFor: Project.FundRaisingFor.NON_PROFIT,
                category: Project.Category.WOMEN_EMPOWERMENT,
                title: 'Cooperative dairy farming',
                story: 'These women are from extremely impoverished and  rural areas of Maharashtra, India. Their husbands are farm owners or workers who are dependent upon the monsoon season to cultivate their produce. Inflation and poverty is making their lives unpredictable, unstable and strenuous. These women want to help their families by getting trained in cooperative dairy farming by Deepshikha and start their micro business.',
                validated: true,
				imageUrl: 'images/projects/Deepshikha/Asha.png',
                user: deepshikha
        ).addToRewards(
                Reward.findById(1)
        ).addToRewards(
                Reward.findById(2)
        ).addToRewards(
                Reward.findById(3)
        ).addToRewards(
                Reward.findById(4)
        ).addToRewards(
                Reward.findById(5)
        ).addToRewards(
                Reward.findById(6)
        ).addToContributions(
                reward: Reward.findById(4),
                date: dateFormat.parse("01/27/2014"),
                user: sampleUser
        ).save(failOnError: true)

        new Project(
                name: 'Sunita',
                email: 'info@deepshikha.org',
                created: dateFormat.parse("01/15/2014"),
                telephone: '+91 12345678',
                amount: '100.0',
                days: '15',
                fundRaisingReason: Project.FundRaisingReason.VOCATIONAL_SCHOOL,
                fundRaisingFor: Project.FundRaisingFor.NON_PROFIT,
                category: Project.Category.WOMEN_EMPOWERMENT,
                title: 'Cooperative dairy farming',
                story: 'These women are from extremely impoverished and  rural areas of Maharashtra, India. Their husbands are farm owners or workers who are dependent upon the monsoon season to cultivate their produce. Inflation and poverty is making their lives unpredictable, unstable and strenuous. These women want to help their families by getting trained in cooperative dairy farming by Deepshikha and start their micro business.',
                validated: true,
				imageUrl: 'images/projects/Deepshikha/Sunita.png',
                user: deepshikha
        ).addToRewards(
                Reward.findById(1)
        ).addToRewards(
                Reward.findById(2)
        ).addToRewards(
                Reward.findById(3)
        ).addToRewards(
                Reward.findById(4)
        ).addToRewards(
                Reward.findById(5)
        ).addToRewards(
                Reward.findById(6)
        ).addToContributions(
                reward: Reward.findById(5),
                date: dateFormat.parse("01/22/2014"),
                user: sampleUser
        ).save(failOnError: true)

        new Project(
                name: 'Yeshula',
                email: 'info@deepshikha.org',
                created: dateFormat.parse("01/15/2014"),
                telephone: '+91 12345678',
                amount: '100.0',
                days: '15',
                fundRaisingReason: Project.FundRaisingReason.VOCATIONAL_SCHOOL,
                fundRaisingFor: Project.FundRaisingFor.NON_PROFIT,
                category: Project.Category.WOMEN_EMPOWERMENT,
                title: 'Cooperative dairy farming',
                story: 'These women are from extremely impoverished and  rural areas of Maharashtra, India. Their husbands are farm owners or workers who are dependent upon the monsoon season to cultivate their produce. Inflation and poverty is making their lives unpredictable, unstable and strenuous. These women want to help their families by getting trained in cooperative dairy farming by Deepshikha and start their micro business.',
                validated: true,
				imageUrl: 'images/projects/Deepshikha/Yeshula.png',
                user: deepshikha
        ).addToRewards(
                Reward.findById(1)
        ).addToRewards(
                Reward.findById(2)
        ).addToRewards(
                Reward.findById(3)
        ).addToRewards(
                Reward.findById(4)
        ).addToRewards(
                Reward.findById(5)
        ).addToRewards(
                Reward.findById(6)
        ).addToContributions(
                reward: Reward.findById(6),
                date: dateFormat.parse("01/20/2014"),
                user: sampleUser
        ).save(failOnError: true)
    }
}
