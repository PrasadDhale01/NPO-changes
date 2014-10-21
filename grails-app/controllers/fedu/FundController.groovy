package fedu

import grails.plugin.springsecurity.annotation.Secured
import groovyx.net.http.ContentType
import groovyx.net.http.HTTPBuilder
import groovyx.net.http.Method
import groovy.util.XmlParser

import com.stripe.model.Charge

class FundController {
    def contributionService
    def projectService
    def userService
    def mailService
    def rewardService
    def mandrillService

    def fund() {
        Project project

        if (params.projectId) {
            project = Project.findById(params.projectId)
        }

        boolean fundingAchieved = contributionService.isFundingAchievedForProject(project)
        boolean ended = projectService.isProjectDeadlineCrossed(project)

        if (!project) {
            render(view: 'error', model: [message: 'This project does not exist.'])
        } else if (fundingAchieved || ended) {
            redirect(controller: 'project', action: 'show', id: project.id)
        } else {
            render view: 'fund/index', model: [project: project]
        }
    }

    def checkout() {
        Project project
        Reward reward

        if (params.projectId) {
            project = Project.findById(params.projectId)
        }
        if (project) {
            if (params.int('rewardId')) {
                reward = project.rewards.find {
                    it.id == params.int('rewardId')
                }
            } else {
                reward = rewardService.getNoReward()
            }
        }

        def amount = params.double(('amount'))
        if (amount < reward.price) {
            render view: 'error', model: [message: 'Funding amount cannot be smaller than reward price. Please choose a smaller reward, or increase the funding amount.']
            return
        }

        if (project && reward) {
            render view: 'checkout/index', model: [project: project, reward: reward, amount: amount]
        } else {
            render view: 'error', model: [message: 'This project or reward does not exist. Please try again.']
        }

    }

    def charge(String stripeToken) {
        Project project
        Reward reward

        if (params.projectId) {
            project = Project.findById(params.projectId)
        }

        if (project) {
            if (params.int('rewardId')) {
                reward = project.rewards.find {
                    it.id == params.int('rewardId')
                }
            } else {
                reward = rewardService.getNoReward()
            }
        }
        if (project && reward) {
            def BASE_URL = "http://usapisandbox.fgdev.net"

            def http = new HTTPBuilder(BASE_URL)
            def amount = 10;

            def result = null
            def transactionId = null
            def projectAmount = params.double('projectAmount')

            http.request(Method.POST, ContentType.URLENC) {
                uri.path = '/donation/creditcard'
                headers.JG_APPLICATIONKEY = 'b1d5db6b-1368-49cc-917c-e98758f28b36'
                headers.JG_SECURITYTOKEN = '277ce2dd-7d4e-4bf2-978d-f91af2624fad'
                body =  [ccNumber:params.ccNumber,
                         ccType:params.ccType,
                         ccExpDateYear:params.ccExpDateYear,
                         ccExpDateMonth:params.ccExpDateMonth,
                         ccCardValidationNum:params.ccCardValidationNum,
                         billToFirstName:params.billToFirstName,
                         billToLastName:params.billToLastName,
                         billToAddressLine1:params.billToAddressLine1,
                         billToCity:params.billToCity,

                         billToZip:params.billToZip,
                         billToCountry:params.billToCountry,
                         billToEmail:params.billToEmail,

                         remoteAddr:params.remoteAddr,
                         amount:params.amount,
                         currencyCode:params.currencyCode,
                         charityId:"dummyid",
                         description:params.description,
                         billToState:params.billToState]

                // response handler for a success response code
                response.success = { resp, reader ->
                    result = true
                    //TODO: fix this logic
                    def responseXML
                    reader.each{
                        key, value -> print key;
                            if(reader[key]) {
                                responseXML =key +":"+reader[key]
                            }
                    }
                    def firstGivingXML = responseXML.substring(responseXML.indexOf('<firstGivingResponse'),responseXML.indexOf('</firstGivingResponse>')+22)
                    def xmlParsef=  new XmlParser().parseText(firstGivingXML)
                    transactionId = xmlParsef.transactionId.text()
                }

                // response handler for a failure response code
                response.failure = { resp, reader ->
                    result = false
                    print reader
                }
            }

            if(result){
                Contribution contribution = new Contribution(
                        date: new Date(),
                        user: userService.getCurrentUser(),
                        reward: reward,
                        amount: amount
                )
                project.addToContributions(contribution).save(failOnError: true)

                def email = userService.getEmail()
                if (email) {
                    mailService.sendMail {
                        async true
                        to userService.getCurrentUser().email
                        from "info@fedu.org"
                        subject "Crowdera - Thank you for funding"
                        html g.render(template: 'acknowledge/ackemailtemplate', model: [project: project, reward: reward, amount: amount])
                    }
                }

                def totalContribution = contributionService.getTotalContributionForProject(project)
                if(totalContribution >= projectAmount){
                    if(project.send_mail == false){
                        def contributor = contributionService.getTotalContributors(project)
                        contributor.each {
                            def user = User.get(it)
                            mandrillService.sendEmail(user)
                        }
                        def beneficiaryId = projectService.getBeneficiaryId(project)
                        def beneficiary = Beneficiary.get(beneficiaryId)
                        def user = User.list()
                        user.each{
                            if(it.email == beneficiary.email){
                                mandrillService.sendEmail(it)
                            }
                        }
                        project.send_mail = true
                    }
                }

                render view: 'acknowledge/acknowledge', model: [project: project, reward: reward, contribution: contribution]
            } else {
                render view: 'error', model: [message: 'There was an error charging. Don\\\'t worry, your card was not charged. Please try again.']
            }
        } else {
            render view: 'error', model: [message: 'This project or reward does not exist. Please try again.']
        }
    }
}
