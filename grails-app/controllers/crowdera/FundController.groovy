package crowdera

import grails.plugin.springsecurity.annotation.Secured
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

import crowdera.Beneficiary;
import crowdera.Contribution;
import crowdera.PaykeyTemp;
import crowdera.Project;
import crowdera.Reward;
import crowdera.Team;
import crowdera.Transaction;
import crowdera.User;

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
		def fundraiserUsername = params.fundraiserUsername

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
            render view: 'fund/index', model: [project: project, user:user, fundraiserUsername:fundraiserUsername]
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
		
		User fundraiser = User.findByUsername(params.fundraiserUsername)

        def totalContribution= contributionService.getTotalContributionForProject(project)
        def contPrice = params.double(('amount'))
        def amt =project.amount
        def reqAmt=(999/100)*amt
        def remainAmt=reqAmt- totalContribution
        def percentage=((totalContribution + contPrice)/ amt)*100
        if(percentage>999)
        {
            flash.amt_message= "Amount should not exceed more than \$"+remainAmt.round()
             render view: 'fund/index', model: [project: project, user:user]
            
        }
        else{
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
            render view: 'checkout/index', model: [project: project, reward: reward, amount: amount, country:country, cardTypes:cardTypes, user:user, title:title, state:state, defaultCountry:defaultCountry, month:month, year:year, fundraiser:fundraiser]
        } else {
            render view: 'error', model: [message: 'This project or reward does not exist. Please try again.']
        }
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
		
		User fundraiser = User.findByUsername(params.fundraiserUsername)

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

        def totalContribution= contributionService.getTotalContributionForProject(project)
        def contPrice = params.double(('amount'))
        def amt =project.amount
        def reqAmt=(999/100)*amt
        def remainAmt=reqAmt- totalContribution
        def percentage=((totalContribution + contPrice)/ amt)*100
        if(percentage>999)
        {
            flash.amt_message= "Amount should not exceed more than \$"+remainAmt.round()
             render view: 'fund/index', model: [project: project, user:user]
            
        }
        else{
        if (project && reward) {
            if (project.paypalEmail){
                payByPaypal(params,project,reward,user,fundraiser)
                if(ack.equals("Success")){
                    render view: 'checkout/paypal', model: [project: project, reward: reward, amount:amount, paykey:paykey, fundraiser:fundraiser]
                }
            } else {
                payByFirstGiving(params,project,reward,user,fundraiser)
            }
        } else {
            render view: 'error', model: [message: 'This project or reward does not exist. Please try again.']
        }
        }
    }
    def acknowledge() {
        def contribution = Contribution.get(params.cb)
        def project = contribution.project
        def reward = contribution.reward
        def user = contribution.user
		def fundraiser = User.get(params.fr)
		
	    render view: 'acknowledge/acknowledge', model: [project: project, reward: reward,contribution: contribution, user: user, fundraiser:fundraiser]
    }

    def sendemail() {
        def project = Project.get(params.id)
        def contribution =Contribution.get(params.cb)
        def fundraiser =User.get(params.fr)
        String emails = params.emails
        String name = params.name
        String message = params.message
        
        def emailList = emails.split(',')
        emailList = emailList.collect { it.trim() }
        
        mandrillService.shareContribution(emailList, name, message,project,contribution,fundraiser)

        flash.sentmessage= "Email sent successfully."
        redirect(controller:'fund',action: 'acknowledge',id: project.id, params:[cb : contribution.id, fr:fundraiser.id])
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

    def payByFirstGiving(def params, Project project,Reward reward,User user,User fundraiser){
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

                userContribution(project,reward,amount,transactionId,user,fundraiser)
            }

            // response handler for a failure response code
            response.failure = { resp, reader ->
                result = false
                print reader
                render view: 'error', model: [message: 'There was an error charging. Don\'t worry, your card was not charged. Please try again.']
            }
        }
    }

    def payByPaypal(def params,Project project,Reward reward,User user,User fundraiser){
        String timestamp = UUID.randomUUID().toString()
        def successUrl = grailsApplication.config.crowdera.BASE_URL + "/fund/paypalReturn/paypalcallback?projectId=${project.id}&rewardId=${reward.id}&amount=${params.amount}&result=true&userId=${user.id}&timestamp=${timestamp}&fundraiser=${fundraiser.id}"
        def failureUrl = grailsApplication.config.crowdera.BASE_URL + "/fund/paypalReturn/paypalcallback?projectId=${project.id}&rewardId=${reward.id}&amount=${params.amount}&userId=${user.id}&timestamp=${timestamp}&fundraiser=${fundraiser.id}"

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
    
    def userContribution(Project project,Reward reward, def amount,String transactionId,User users,User fundraiser){
        Contribution contribution = new Contribution(
                date: new Date(),
                user: users,
                reward: reward,
                amount: amount
                )
        project.addToContributions(contribution).save(failOnError: true)
		
		if(project.teams) {
			Team team = Team.findByUserAndProject(fundraiser,project)
			team.addToContributions(contribution).save(failOnError: true)
		}

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

        def totalContribution = contributionService.getTotalContributionForProject(project)
        if(totalContribution >= project.amount){
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
		
		Transaction transaction = new Transaction(
			transactionId:transactionId,
			user:users,
			project:project,
			contribution:contribution
		)
		transaction.save(failOnError: true)
			
        redirect(controller: 'fund', action: 'acknowledge', id: project.id, params: [cb: contribution.id, fr:fundraiser.id])
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
		def fundraiserId = request.getParameter('fundraiser')

        Project project = Project.get(projectId)
        User user = User.get(userid)
		User fundraiser = User.get(fundraiserId)
        Reward reward = Reward.get(rewardId)

        PaykeyTemp paykeytemp = PaykeyTemp.findByTimestamp(timestamp)
        def payKey = paykeytemp.paykey
        paykeytemp.delete()
        
        if (result){
            userContribution(project,reward,amount,payKey,user,fundraiser)
        } else {
            render view: 'fund/index', model: [project: project]
        }
    }
    
    def makeUserAnonymous(){
        def user = User.findByUsername('anonymous@example.com')
        render user.id
    }
	
    @Secured(['ROLE_ADMIN'])
    def transaction(){
        def transaction = Transaction.list();
        render view: '/user/admin/transactionIndex', model: [transaction: transaction]
    }
}