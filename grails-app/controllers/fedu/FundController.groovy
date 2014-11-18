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

        def user = userService.getCurrentUser()
        def country = projectService.getCountry()
        def cardTypes = projectService.getcardtypes()
        def title = projectService.getTitle()
        def state = projectService.getState()
        def defaultCountry = 'US'

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
            render view: 'checkout/index', model: [project: project, reward: reward, amount: amount, country:country, cardTypes:cardTypes, user:user, title:title, state:state, defaultCountry:defaultCountry]
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
            def BASE_URL = grailsApplication.config.crowdera.firstgiving.BASE_URL

            def http = new HTTPBuilder(BASE_URL)
            def amount = params.double('amount');

            def transactionId = null
            def result = null
            def state

            if(params.billToState == 'other'){
                state = params.otherState
            } else {
                state = params.billToState
            }

            http.request(Method.POST, ContentType.URLENC) {
                uri.path = grailsApplication.config.crowdera.firstgiving.uriPath
                headers.JG_APPLICATIONKEY = grailsApplication.config.crowdera.firstgiving.JG_APPLICATIONKEY
                headers.JG_SECURITYTOKEN = grailsApplication.config.crowdera.firstgiving.JG_SECURITYTOKEN
                body =  [ccNumber:params.ccNumber,
                    ccType:params.ccType,
                    ccExpDateYear:params.ccExpDateYear,
                    ccExpDateMonth:params.ccExpDateMonth,
                    ccCardValidationNum:params.ccCardValidationNum,
                    billToTitle:params.billToTitle,
                    billToFirstName:params.billToFirstName,
                    billToLastName:params.billToLastName,
                    billToAddressLine1:params.billToAddressLine1,
                    billToAddressLine2:params.billToAddressLine2,
                    billToAddressLine3:params.billToAddressLine3,
                    billToCity:params.billToCity,

                    billToZip:params.billToZip,
                    billToCountry:params.billToCountry,
                    billToEmail:params.billToEmail,
                    billToPhone:params.billToPhone,

                    remoteAddr:params.remoteAddr,
                    amount:params.amount,
                    currencyCode:params.currencyCode,
                    charityId:project.charitableId,
                    description:params.description,
                    billToState:state]

                // response handler for a success response code
                response.success = { resp, reader ->
                    result = true
                    //TODO: fix this logic
                    def responseXML
                    reader.each{ key, value ->
                        print key;
                        if(reader[key]) {
                            responseXML =key +":"+reader[key]
                        }
                    }
                    def firstGivingXML = responseXML.substring(responseXML.indexOf('<firstGivingResponse'),responseXML.indexOf('</firstGivingResponse>')+22)
                    def xmlParsef=  new XmlParser().parseText(firstGivingXML)
                    transactionId = xmlParsef.transactionId.text()

                    Transaction transaction = new Transaction(
                            transactionId:transactionId,
                            user:userService.getCurrentUser(),
                            project:project
                            )
                    transaction.save(failOnError: true)

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

                def projectAmount = params.double('projectAmount')
                def totalContribution = contributionService.getTotalContributionForProject(project)
                if(totalContribution >= projectAmount){
                    if(project.send_mail == false){
                        def contributor = contributionService.getTotalContributors(project)
                        contributor.each {
                            def user = User.get(it)
                            mandrillService.sendContributorEmail(user, project)
                        }
                        def beneficiaryId = projectService.getBeneficiaryId(project)
                        def beneficiary = Beneficiary.get(beneficiaryId)
                        def user = User.list()
                        user.each{
                            if(it.email == beneficiary.email){
                                mandrillService.sendBeneficiaryEmail(it)
                            }
                        }
                        project.send_mail = true
                    }
                }

                redirect(controller: 'fund', action: 'acknowledge', id: project.id, params: [project: project, reward: reward.id, contribution: contribution.id])
            } else {
                render view: 'error', model: [message: 'There was an error charging. Don\\\'t worry, your card was not charged. Please try again.']
            }
        } else {
            render view: 'error', model: [message: 'This project or reward does not exist. Please try again.']
        }
    }
    def acknowledge() {
        def project = Project.get(params.id)
        def reward = Reward.get(params.reward)
        def contribution = Contribution.get(params.contribution)
        render view: 'acknowledge/acknowledge', model: [project: project, reward: reward,contribution: contribution]
    }

    def fundingConfirmation(){
        User users = User.get(params.id)
        if (!users) {
            render(view: 'error', model: [message: 'Problem activating account. Please check your activation link.'])
        } else {
            redirect(controller: 'user', action: 'dashboard')
        }
    }

    def thankingContributors(){
        def project = Project.get(params.id)
        if (!project) {
            render(view: 'error', model: [message: 'Problem activating account. Please check your activation link.'])
        } else {
            
            redirect(controller: 'project', action: 'show', id: project.id)
        }
    }
}
