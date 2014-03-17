package fedu

import grails.transaction.Transactional

import java.text.DateFormat
import java.text.SimpleDateFormat

@Transactional
class ProjectService {
    def userService

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
                date: dateFormat.parse("01/26/2014"),
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
                date: dateFormat.parse("01/26/2014"),
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
                date: dateFormat.parse("01/26/2014"),
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
                date: dateFormat.parse("01/26/2014"),
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
                date: dateFormat.parse("01/26/2014"),
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
                date: dateFormat.parse("01/26/2014"),
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
                date: dateFormat.parse("01/26/2014"),
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
                date: dateFormat.parse("01/26/2014"),
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
                date: dateFormat.parse("01/26/2014"),
                user: sampleContributor
        )).save(failOnError: true)
    }
}
