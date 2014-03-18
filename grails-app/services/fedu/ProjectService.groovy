package fedu

import grails.transaction.Transactional

import java.text.DateFormat
import java.text.SimpleDateFormat

class ProjectService {
    def userService

    def isProjectEnded(Project project) {
        def startDate = getProjectStartDate(project)
        def endDate = getProjectEndDate(project)

        def today = Calendar.instance
        boolean ended = endDate.compareTo(today) < 0 ? true : false

        return ended
    }

    def getProjectStartDate(Project project) {
        def startDate = Calendar.instance
        startDate.setTime(project.created)

        return startDate
    }

    def getProjectEndDate(Project project) {
        def endDate = Calendar.instance
        endDate.setTime(project.created)
        endDate.add Calendar.DAY_OF_YEAR, project.days

        return endDate
    }

    @Transactional
    def bootstrap() {
        DateFormat dateFormat = new SimpleDateFormat("MM/dd/yyyy")

        User deepshikha = userService.bootstrapDeepshikha()
        User sampleContributor = User.findByUsername('user@fedu.org')

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
                user: deepshikha
        ).addToContributions(new Contribution(
                amount: '100.0',
                date: dateFormat.parse("01/16/2014"),
                user: sampleContributor
        )).save(failOnError: true)

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
                user: deepshikha
        ).addToContributions(new Contribution(
                amount: '100.0',
                date: dateFormat.parse("01/23/2014"),
                user: sampleContributor
        )).save(failOnError: true)

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
                user: deepshikha
        ).addToContributions(new Contribution(
                amount: '100.0',
                date: dateFormat.parse("01/21/2014"),
                user: sampleContributor
        )).save(failOnError: true)

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
                user: deepshikha
        ).addToContributions(new Contribution(
                amount: '100.0',
                date: dateFormat.parse("01/26/2014"),
                user: sampleContributor
        )).save(failOnError: true)

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
                user: deepshikha
        ).addToContributions(new Contribution(
                amount: '100.0',
                date: dateFormat.parse("01/18/2014"),
                user: sampleContributor
        )).save(failOnError: true)

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
                user: deepshikha
        ).addToContributions(new Contribution(
                amount: '100.0',
                date: dateFormat.parse("01/24/2014"),
                user: sampleContributor
        )).save(failOnError: true)

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
                user: deepshikha
        ).addToContributions(new Contribution(
                amount: '100.0',
                date: dateFormat.parse("01/29/2014"),
                user: sampleContributor
        )).save(failOnError: true)

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
                user: deepshikha
        ).addToContributions(new Contribution(
                amount: '100.0',
                date: dateFormat.parse("01/27/2014"),
                user: sampleContributor
        )).save(failOnError: true)

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
                user: deepshikha
        ).addToContributions(new Contribution(
                amount: '100.0',
                date: dateFormat.parse("01/22/2014"),
                user: sampleContributor
        )).save(failOnError: true)

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
                user: deepshikha
        ).addToContributions(new Contribution(
                amount: '100.0',
                date: dateFormat.parse("01/20/2014"),
                user: sampleContributor
        )).save(failOnError: true)
    }
}
