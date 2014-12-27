package fedu

import groovy.json.JsonSlurper
import groovyx.net.http.ContentType
import groovyx.net.http.HTTPBuilder
import groovyx.net.http.Method

import org.apache.http.HttpEntity
import org.apache.http.HttpResponse
import org.apache.http.client.HttpClient
import org.apache.http.client.methods.HttpPost
import org.apache.http.entity.StringEntity
import org.apache.http.impl.client.DefaultHttpClient
import org.apache.http.util.EntityUtils

class FundController {
    def contributionService
    def projectService
    def userService
    def mailService
    def rewardService
    def mandrillService

    def ack
    def paykey
    def userId
    String str

    def fund() {
        Project project
        User user = userService.getCurrentUser()

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
            render view: 'fund/index', model: [project: project, user:user]
        }
    }

    def checkout() {
        Project project
        Reward reward

        def country = projectService.getCountry()
        def cardTypes = projectService.getcardtypes()
        def title = projectService.getTitle()
        def state = projectService.getState()
        def month = contributionService.getMonth()
        def year = contributionService.getYear()
        def defaultCountry = 'US'
        def user = User.get(params.userId)
        if (user == null){
            user = User.findByUsername('anonymous@example.com')
        }

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
            render view: 'checkout/index', model: [project: project, reward: reward, amount: amount, country:country, cardTypes:cardTypes, user:user, title:title, state:state, defaultCountry:defaultCountry, month:month, year:year]
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
        
        def user = User.get(params.userId)
        if (user == null){
            user = User.findByUsername('anonymous@example.com')
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
            if (project.paypalEmail){
                payByPaypal(params,project,reward,user)
                if(ack.equals("Success")){
                    render view: 'checkout/paypal', model: [project: project, reward: reward, amount:amount, paykey:paykey]
                }
            } else {
                payByFirstGiving(params,project,reward,user)
            }
        } else {
            render view: 'error', model: [message: 'This project or reward does not exist. Please try again.']
        }
    }
    def acknowledge() {
        def project = Project.get(params.id)
        def reward = Reward.get(params.reward)
        def user = User.get(params.user)
        def contribution = Contribution.get(params.contribution)
        render view: 'acknowledge/acknowledge', model: [project: project, reward: reward,contribution: contribution, user: user]
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

    def payByFirstGiving(def params, Project project,Reward reward,User user){
        def BASE_URL = grailsApplication.config.crowdera.firstgiving.BASE_URL

        def http = new HTTPBuilder(BASE_URL)
        def amount = params.double('amount')
        
        String ipAddress =  request.getRemoteAddr();
        
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

                remoteAddr:ipAddress,
                amount:params.amount,
                currencyCode:params.currencyCode,
                charityId:project.charitableId,
                description:'Donating towards project : ' + project.title,
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

                userContribution(project,reward,amount,transactionId,user)
            }

            // response handler for a failure response code
            response.failure = { resp, reader ->
                result = false
                print reader
                render view: 'error', model: [message: 'There was an error charging. Don\'t worry, your card was not charged. Please try again.']
            }
        }
    }

    def payByPaypal(def params,Project project,Reward reward,User user){
        String timestamp = UUID.randomUUID().toString()
        def successUrl = grailsApplication.config.crowdera.BASE_URL + "/fund/paypalReturn/paypalcallback?projectId=${project.id}&rewardId=${reward.id}&amount=${params.amount}&result=true&userId=${user.id}&timestamp=${timestamp}"
        def failureUrl = grailsApplication.config.crowdera.BASE_URL + "/fund/paypalReturn/paypalcallback?projectId=${project.id}&rewardId=${reward.id}&amount=${params.amount}&userId=${user.id}&timestamp=${timestamp}"

        def BASE_URL = grailsApplication.config.crowdera.paypal.BASE_URL

        HttpClient httpclient = new DefaultHttpClient()
        HttpPost httppost = new HttpPost(BASE_URL)

        httppost.setHeader("X-PAYPAL-SECURITY-USERID","${grailsApplication.config.crowdera.paypal.X_PAYPAL_SECURITY_USERID}")
        httppost.setHeader("X-PAYPAL-SECURITY-PASSWORD","${grailsApplication.config.crowdera.paypal.X_PAYPAL_SECURITY_PASSWORD}")
        httppost.setHeader("X-PAYPAL-SECURITY-SIGNATURE","${grailsApplication.config.crowdera.paypal.X_PAYPAL_SECURITY_SIGNATURE}")
        // Global Sandbox Application ID
        httppost.setHeader("X-PAYPAL-APPLICATION-ID","${grailsApplication.config.crowdera.paypal.X_PAYPAL_APPLICATION_ID}")
        // Input and output formats
        httppost.setHeader("X-PAYPAL-REQUEST-DATA-FORMAT","${grailsApplication.config.crowdera.paypal.X_PAYPAL_REQUEST_DATA_FORMAT}")
        httppost.setHeader("X-PAYPAL-RESPONSE-DATA-FORMAT","${grailsApplication.config.crowdera.paypal.X_PAYPAL_RESPONSE_DATA_FORMAT}")

        StringEntity input = new StringEntity("{\"actionType\":\"PAY\",\"currencyCode\":\"USD\",\"receiverList\":{\"receiver\":[{\"amount\":\"${params.amount}\",\"email\":\"${project.paypalEmail}\"}]},\"returnUrl\":\"${successUrl}\",\"cancelUrl\"\"${failureUrl}\",\"requestEnvelope\":{\"errorLanguage\":\"en_US\",\"detailLevel\":\"ReturnAll\" }}")
        input.setContentType("application/json")

        httppost.setEntity(input)

        HttpResponse httpres = httpclient.execute(httppost)
        int status = httpres.getStatusLine().getStatusCode()
        if (status == 200){
            HttpEntity entity = httpres.getEntity()
            if (entity != null){
                str = EntityUtils.toString(entity)
            }
        }
        if(!str.equals("")){
            paypalSecondCall(params, project, str ,reward, timestamp)
        }
    }

    def paypalSecondCall(def params,Project project,String str,Reward reward,String timestamp){
        //After fetching response paykey will be fetched by this method
        def json = new JsonSlurper().parseText(str)

        ack = json.responseEnvelope.ack
        paykey = json.payKey
        
        PaykeyTemp paykeytemp = new PaykeyTemp(
                timestamp: timestamp,
                paykey:paykey,
                )
        paykeytemp.save(failOnError: true)
    }
    
    def userContribution(Project project,Reward reward, def amount,String transactionId,User users){
        Contribution contribution = new Contribution(
                date: new Date(),
                user: users,
                reward: reward,
                amount: amount
                )
        project.addToContributions(contribution).save(failOnError: true)

        Transaction transaction = new Transaction(
                transactionId:transactionId,
                user:users,
                project:project
                )
        transaction.save(failOnError: true)

        def email = users.email
        if (email) {
            mailService.sendMail {
                async true
                to users.email
                from "info@fedu.org"
                subject "Crowdera - Thank you for funding"
                html g.render(template: 'acknowledge/ackemailtemplate', model: [project: project, reward: reward, amount: amount, users:users])
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
        redirect(controller: 'fund', action: 'acknowledge', id: project.id, params: [project: project, reward: reward.id, contribution: contribution.id, user:users.id])
    }

    def paypalurl(){
        redirect (url:grailsApplication.config.crowdera.paypal.PAYPAL_URL+paykey)
    }

    def paypalReturn(){
        def result = (boolean)request.getParameter('result')
        def rewardId = request.getParameter('rewardId')
        def projectId = request.getParameter('projectId')
        def amount = request.getParameter('amount')
        def timestamp = request.getParameter('timestamp')
        def userid = request.getParameter('userId')

        Project project = Project.get(projectId)
        User user = User.get(userid)
        Reward reward = Reward.get(rewardId)

        PaykeyTemp paykeytemp = PaykeyTemp.findByTimestamp(timestamp)
        def payKey = paykeytemp.paykey
        paykeytemp.delete()
        
        if (result){
            userContribution(project,reward,amount,payKey,user)
        } else {
            render view: 'fund/index', model: [project: project]
        }
    }
    
    def makeUserAnonymous(){
        def user = User.findByUsername('anonymous@example.com')
        render user.id
    }
	
    def transaction(){
        def transaction = Transaction.list();
        render view: '/user/admin/transactionIndex', model: [transaction: transaction]
    }
}
