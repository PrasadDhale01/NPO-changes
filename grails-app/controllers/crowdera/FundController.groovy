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
    def perk
    def conId
    def frId
    String str

    def fund() {
        Project project
        User user = userService.getCurrentUser()
        def fundraiser = userService.getUsernameFromVanityName(params.fr)

        def projectId = projectService.getProjectIdFromVanityTitle(params.projectTitle)
        if (projectId) {
            project = Project.findById(projectId)
        }
		
        perk = rewardService.getRewardById(params.long('rewardId'))

        boolean fundingAchieved = contributionService.isFundingAchievedForProject(project)
        boolean ended = projectService.isProjectDeadlineCrossed(project)

        if (!project) {
            render(view: 'error', model: [message: 'This project does not exist.'])
        } else if (fundingAchieved || ended) {
            redirect(controller: 'project', action: 'showCampaign', id: project.id)
        } else {
            render view: 'fund/index', model: [project: project, user:user, fundraiser:fundraiser, perk:perk, vanityTitle:params.projectTitle, vanityUsername:params.fr]
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
        perk = rewardService.getRewardById(params.long('rewardId'))
        def user1 = userService.getUserByUsername(params.tempValue)

        def user = userService.getUserById(params.long('userId'))
        if (user == null){
            user = userService.getUserByUsername('anonymous@example.com')
        }
        if (params.projectId) {
            project = projectService.getProjectById(params.projectId)
        }
        
        def anonymous = params.anonymous
		
	    User fundraiser = userService.getUserFromVanityName(params.fr)
        def team = userService.getTeamByUser(fundraiser, project)

        def totalContribution= contributionService.getTotalContributionForProject(project)
        def contPrice = params.double(('amount'))
        def amt =project.amount
        def reqAmt=(999/100)*amt
        def remainAmt=reqAmt- totalContribution
        def percentage=((totalContribution + contPrice)/ amt)*100
        if(percentage>999) {
            flash.amt_message= "Amount should not exceed more than \$"+remainAmt.round()
            redirect action: 'fund', id: project.id, params:[fr: params.fr, rewardId:perk.id]
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
            if(!team || ! project.user){
                render view:"error", model: [message:'User not found']     
            }else{
                render view: 'checkout/index', model: [project: project, reward: reward, amount: amount, country:country, cardTypes:cardTypes, user:user, title:title, state:state, defaultCountry:defaultCountry, month:month, year:year, fundraiser:fundraiser, user1:user1, anonymous:anonymous, projectTitle:params.projectTitle, username:params.fr]
            }
        } else {
            render view: 'error', model: [message: 'This project or reward does not exist. Please try again.']
        }
        }   
    }

    def charge() {
        Project project
        Reward reward
        def vanityTitle

        if (params.projectId) {
            project = projectService.getProjectById(params.projectId)
            vanityTitle = projectService.getVanityTitleFromId(params.projectId)
        }
        
        def user1 = userService.getUserById(params.long('tempValue'))
        def user = userService.getUserById(params.long('userId'))
        if (user == null){
            user = userService.getUserByUsername('anonymous@example.com')
        }
        
        def address = projectService.getAddress(params)
        def state = projectService.getState()
        def country = projectService.getCountry()
		
        User fundraiser = userService.getUserFromVanityName(params.fr)
        def anonymous = params.anonymous

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
        perk = Reward.get(params.long('rewardId'))
        def vanityUserName = params.fr
		
        if(percentage>999) {
            flash.amt_message= "Amount should not exceed more than \$"+remainAmt.round()
            redirect action: 'fund', params:['fr': vanityUserName, 'rewardId': perk.id, 'projectTitle': vanityTitle]
        } else {
            if (project && reward) {
                if (project.paypalEmail){
                    render view: 'checkout/paypal', model: [project: project, reward: reward, amount:amount, user:user, fundraiser:fundraiser, user1:user1, state:state, country:country, anonymous:anonymous, projectTitle:params.projectTitle]
                } else {
                    payByFirstGiving(params,project,reward,user,fundraiser,address)
                }
            } else {
                render view: 'error', model: [message: 'This project or reward does not exist. Please try again.']
            }
        }
    }
    
    def acknowledge() {
        def contribution = contributionService.getContributionById(params.long('cb'))
        def project = contribution.project
        def reward = contribution.reward
        def user = contribution.user
        def fundraiser = userService.getUserById(params.long('fr'))
	    render view: 'acknowledge/acknowledge', model: [project: project, reward: reward,contribution: contribution, user: user, fundraiser:fundraiser, projectTitle:params.projectTitle]
    }
    
    def saveContributionComent(){
        Contribution contribution = contributionService.getContributionById(params.long('id'))
        def projectComment = projectService.getProjectCommentById(params.long('commentId'))
        def teamComment = projectService.getTeamCommentById(params.long('teamCommentId'))
        def projectId = projectService.getProjectIdFromVanityTitle(params.projectTitle)
        def project = projectService.getProjectById(projectId)
        def fundRaiser = userService.getUserById(params.long('fr'))

        def user = contribution.user
        def reward = contribution.reward
   
        if (projectComment || teamComment) {
            if (projectComment) {
                projectComment.comment = params.comment
            }
            if (teamComment) {
                teamComment.comment = params.comment
            }
            render view: 'acknowledge/acknowledge', model: [project: project, reward: reward,contribution: contribution, user: user, fundraiser:fundRaiser,projectTitle:params.projectTitle, comment: projectComment, teamComment:teamComment]
        } else {
            def commentObj
            if(project && params.comment){
                commentObj = projectService.setContributorsComment(project, params.comment, fundRaiser, contribution)
                teamComment = commentObj.teamComment
                projectComment = commentObj.projectComment
                if(teamComment) {
                    redirect (action:'saveTeamCommentRedirect', controller:'fund', id: params.id, params:[ fr: params.fr, projectTitle: params.projectTitle, teamCommentId: teamComment.id])
                }
                if(projectComment) {
                    redirect (action:'saveCommentRedirect', controller:'fund', id: params.id, params:[fr: params.fr, projectTitle: params.projectTitle, commentId: projectComment.id])
                }
            } else {
                flash.sentmessage = "Something went wrong saving comment. Please try again later."
            }
            
        }
    }
    
    def saveCommentRedirect() {
        Contribution contribution = contributionService.getContributionById(params.long('id'))
        def projectComment = projectService.getProjectCommentById(params.long('commentId'))
        def projectId = projectService.getProjectIdFromVanityTitle(params.projectTitle)
        def project = projectService.getProjectById(projectId)
        def fundRaiser = userService.getUserById(params.long('fr'))

        def user = contribution.user
        def reward = contribution.reward
        render view: 'acknowledge/acknowledge', model: [project: project, reward: reward,contribution: contribution, user: user, fundraiser:fundRaiser,projectTitle:params.projectTitle, comment: projectComment]
    }
    
    def saveTeamCommentRedirect() {
        Contribution contribution = contributionService.getContributionById(params.long('id'))
        def teamComment = projectService.getTeamCommentById(params.long('teamCommentId'))
        def projectId = projectService.getProjectIdFromVanityTitle(params.projectTitle)
        def project = projectService.getProjectById(projectId)
        def fundRaiser = userService.getUserById(params.long('fr'))

        def user = contribution.user
        def reward = contribution.reward
        render view: 'acknowledge/acknowledge', model: [project: project, reward: reward,contribution: contribution, user: user, fundraiser:fundRaiser,projectTitle:params.projectTitle, teamComment:teamComment]
    }
    
    def editContributionComment(){
        Contribution contribution = contributionService.getContributionById(params.long('id'))
        if(Contribution){
            def project = contribution.project
            def reward = contribution.reward
            def user = contribution.user
            def fundraiser = userService.getUserById(params.long('fr'))
            def value = 'value'
            def projectComment = projectService.getProjectCommentById(params.long('commentId'))
            def teamComment = projectService.getTeamCommentById(params.long('teamCommentId'))
            render view: 'acknowledge/acknowledge', model: [project: project, reward: reward,contribution: contribution, user: user, fundraiser:fundraiser,projectTitle:params.projectTitle, value: value, comment: projectComment, teamComment:teamComment]
        } else {
            flash.sentmessage = "Something went wrong saving comment. Please try again later."
        }
        
    }
    
    def deleteContributionComment() {
        def projectComment = projectService.getProjectCommentById(params.long('commentId'))
        def teamComment = projectService.getTeamCommentById(params.long('teamCommentId'))
        def projectId = projectService.getProjectIdFromVanityTitle(params.projectTitle)
        def project = projectService.getProjectById(projectId)
        
        def fundraiser = userService.getUserById(params.long('fr'))
        Team team = projectService.getTeamByUserAndProject(project, fundraiser)
        if(params.id) {
            projectService.deleteContributorsComment(projectComment, teamComment, project, team)
        } else {
            flash.sentmessage = "Something went wrong saving comment. Please try again later."
        }
        redirect (action:"acknowledge", params:[cb : params.id, fr : params.fr, projectTitle:params.projectTitle])
    }
    
    def sendemail() {
        projectService.getEmailDetails(params)
        
		flash.sentmessage= "Email sent successfully."
        redirect(controller:'fund',action: 'acknowledge', params:[cb : params.cb, fr: params.fr, projectTitle: params.projectTitle])
    }

    def fundingConfirmation(){
        User users = userService.getUserById(params.long('id'))
        if (!users) {
            render(view: 'error', model: [message: 'Problem activating account. Please check your activation link.'])
        } else {
            redirect(controller: 'user', action: 'dashboard')
        }
    }

    def thankingContributors(){
        def project = projectService.getProjectById(params.id)
        if (!project) {
            render(view: 'error', model: [message: 'Problem activating account. Please check your activation link.'])
        } else {
            redirect(controller: 'project', action: 'show', id: project.id)
        }
    }

    def payByFirstGiving(def params, Project project,Reward reward,User user,User fundraiser,def address){
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
                    if(reader[key]) {
                        responseXML =key +":"+reader[key]
                    }
                }
                def firstGivingXML = responseXML.substring(responseXML.indexOf('<firstGivingResponse'),responseXML.indexOf('</firstGivingResponse>')+22)
                def xmlParsef=  new XmlParser().parseText(firstGivingXML)
                transactionId = xmlParsef.transactionId.text()

                userContribution(project,reward,amount,transactionId,user,fundraiser,params,address)
            }

            // response handler for a failure response code
            response.failure = { resp, reader ->
                result = false
                render view: 'error', model: [message: 'There was an error charging. Don\'t worry, your card was not charged. Please try again.']
            }
        }
    }

    def payByPaypal(def params,Project project,Reward reward,User user,User fundraiser,def address){
        String timestamp = UUID.randomUUID().toString()
        def successUrl = grailsApplication.config.crowdera.BASE_URL + "/fund/paypalReturn/paypalcallback?projectTitle=${params.projectTitle}&rewardId=${reward.id}&amount=${params.amount}&result=true&userId=${user.id}&timestamp=${timestamp}&fundraiser=${fundraiser.id}&physicalAddress=${params.physicalAddress}&shippingEmail=${params.shippingEmail}&twitterHandle=${params.twitterHandle}&shippingCustom=${params.shippingCustom}&tempValue=${params.tempValue}&name=${params.receiptName}&email=${params.receiptEmail}&address=${address}&anonymous=${params.anonymous}"
        def failureUrl = grailsApplication.config.crowdera.BASE_URL + "/fund/paypalReturn/paypalcallback?projectTitle=${params.projectTitle}&rewardId=${reward.id}&amount=${params.amount}&userId=${user.id}&timestamp=${timestamp}&fundraiser=${fundraiser.id}"

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
            paypalSecondCall(str ,timestamp)
        }
    }

    def paypalSecondCall(String str,String timestamp){
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
    
    def userContribution(Project project,Reward reward, def amount,String transactionId,User users,User fundraiser,def params, def address){
		def contributionId = projectService.getUserContributionDetails(project, reward, amount, transactionId, users, fundraiser, params,  address, request)
		conId = contributionId
		frId = fundraiser.id
        def projectTitle
        if (project.charitableId) {
            projectTitle = params.projectTitle
        } else {
            projectTitle = request.getParameter('projectTitle')
        }
		redirect(controller: 'fund', action: 'acknowledge' , params: [cb: contributionId, fr:fundraiser.id, projectTitle: projectTitle])
    }

    def paypalurl(){
        Project project = projectService.getProjectById(params.id)
        Reward reward = rewardService.getRewardById(params.long('rewardId'))
        User user = userService.getUserById(params.long('userId'))
        User fundraiser = userService.getUserById(params.long('fr'))
        def address = projectService.getAddress(params)
        
        if (project && reward && fundraiser) {
            payByPaypal(params,project,reward,user,fundraiser,address)
            if(ack.equals("Success")) {
                redirect (url:grailsApplication.config.crowdera.paypal.PAYPAL_URL+paykey)
            } else {
                flash.paypalFailureMessage = "Unable to connect to the paypal account."
                redirect action: 'fund', id: project.id, params:[fr: params.fr]
            }
        } else {
            render view: 'error', model: [message: 'This project,reward or fundraiser does not exist. Please try again.']
        }
    }

    def paypalReturn(){
        def result = (boolean)request.getParameter('result')
        def rewardId = request.getParameter('rewardId')
        def projectTitle  = request.getParameter('projectTitle')
        def amount = request.getParameter('amount')
        def timestamp = request.getParameter('timestamp')
        def userid = request.getParameter('userId')
		def fundraiserId = request.getParameter('fundraiser')
        def address = request.getParameter('address')

        Project project = projectService.getProjectFromVanityTitle(projectTitle)
        User user = userService.getUserById(userid)
		User fundraiser = userService.getUserById(fundraiserId)
        Reward reward = rewardService.getRewardById(rewardId)

        def paykeytemp = projectService.getpayKeytempObject(timestamp)
        def payKey = paykeytemp.paykey
        paykeytemp.delete()
        
        if (result){
            userContribution(project,reward,amount,payKey,user,fundraiser,request,address)
        } else {
            render view: 'fund/index', model: [project: project]
        }
    }
    
    def getOnlyTwitterHandlerRewards(){
        def project = projectService.getProjectById(request.getParameter('projectId'))
        def reward = rewardService.getOnlytwitterHandlerReward(project)
        def rewardId = reward.id
        render rewardId
    }
    
    def getRewardsHavingTwitterHandler(){
        def project = projectService.getProjectById(request.getParameter('projectId'))
        def reward = rewardService.getTwitterHandlerReward(project)
        def rewardId = reward.id
        render rewardId
    }
	
    @Secured(['ROLE_ADMIN'])
    def transaction(){
        def transactionINR = contributionService.getINRTransactions()
        def transactionUSD = contributionService.getUSDTransactions()
        if (params.currency == 'INR'){
            render view: '/user/admin/transactionIndex', model: [transaction: transactionINR, currency:'INR']
        } else {
            render view: '/user/admin/transactionIndex', model: [transaction: transactionUSD, currency:'USD']
        }
    }

    @Secured(['IS_AUTHENTICATED_FULLY'])
    def generateCSV(){
        def result = projectService.generateCSV(response, params)          
        render (contentType:"text/csv", text:result)
    }
    
    @Secured(['IS_AUTHENTICATED_FULLY'])
    def saveOfflineContribution() {
		def fundRaiser = userService.getCurrentUser()
        def title = projectService.getVanityTitleFromId(params.id)
        def name = userService.getVanityNameFromUsername(fundRaiser.username, params.id)
        projectService.getOfflineDetails(params)
        flash.offlineContributionMsg = "Offline Contribution Added Successfully."
        if (params.manageCampaign) {
            redirect(controller: 'project', action: 'manageproject',fragment: 'contributions', params:['projectTitle':title])
        } else {
            redirect (controller: 'project', action: 'show' ,fragment: 'contributions', params:['projectTitle':title,'fr':name])
        }
    }
	
	def payByPayUmoney(){
		
		def project= Project.get(params.projectId)
		def user = User.get(params.userId)
		def reward=Reward.get(params.rewardId)
		User fundraiser = userService.getUserFromVanityName(params.fr)
		def vanityUserName = params.fr
		def amount=params.amount
		def projectTitle=params.projectTitle
		def anonymous=params.anonymous
		def vanityTitle
		
		if (params.projectId) {
			vanityTitle = projectService.getVanityTitleFromId(params.projectId)
		}
		
		if (user == null){
			user = userService.getUserByUsername('anonymous@example.com')
		}
		
		if (Double.parseDouble(amount) < reward.price) {
			render view: 'error', model: [message: 'Funding amount cannot be smaller than reward price. Please choose a smaller reward, or increase the funding amount.']
			return false
		}
		
		perk = rewardService.getRewardById(params.long('rewardId'))
		def totalContribution= contributionService.getTotalContributionForProject(project)
		def contPrice =Double.parseDouble(amount)
		def amt =project.amount
		def reqAmt=(999/100)*amt
		def remainAmt=reqAmt- totalContribution
		def percentage=((totalContribution + contPrice)/ amt)*100
		
		if(percentage>999) {
			flash.amt_message= "Amount should not exceed more than \$"+remainAmt.round()
			redirect action: 'fund', params:['fr': vanityUserName, 'rewardId': perk.id, 'projectTitle': vanityTitle]
		}
		render view:"checkout/payu" ,model:['amount':amount,'project':project, 'reward':reward, 'fundraiser':fundraiser, 'user':user,'projectTitle':projectTitle,'anonymous':anonymous]
	}
	
	def payupayment(){
	   def project= Project.get(params.projectId)
	   def user = User.get(params.userId)
	   def reward=Reward.get(params.rewardId)
	   User fundraiser = User.findByEmail(params.fr)
	   def anonymous=params.anonymous
		 
	   if (user == null){
		   user = userService.getUserByUsername('anonymous@example.com')
	   }
		 
	   def key=grailsApplication.config.crowdera.PAYU.KEY
	   def salt=grailsApplication.config.crowdera.PAYU.SALT
	   def amount=params.amount
	   def firstname= params.firstname
	   def email=params.email
	   def phone= params.phone
	   def productinfo=params.productinfo
	   def surl = grailsApplication.config.crowdera.PAYU.BASE_URL + "/fund/payureturn?projectId=${project.id}&rewardId=${reward.id}&amount=${params.amount}&result=true&userId=${user.id}&fundraiser=${fundraiser.id}&physicalAddress=${params.physicalAddress}&shippingCustom=${params.shippingCustom}&shippingEmail=${params.shippingEmail}&shippingTwitter=${params.twitterHandle}&name=${params.firstname} ${params.lastname}&email=${params.email}&anonymous=${params.anonymous}&projectTitle=${params.projectTitle}"
		
	   def furl= grailsApplication.config.crowdera.PAYU.BASE_URL + "/error"
	   def service_provider="payu_paisa"
	   def txnid=projectService.generateTransId()
	   String hashstring= key + "|" + txnid + "|" + amount + "|" + productinfo + "|" + firstname + "|" + email + "|||||||||||" + salt;
	   def hash = projectService.generateHash("SHA-512",hashstring)
		 
	   render view:"checkout/payupay" ,model:['key':key,'txnid':txnid,'amount':amount,'project':project, 'reward':reward, 'fundraiser':fundraiser, 'email':email, 'phone':phone, 'user':user, 'surl':surl, 'furl':furl, 'hash':hash,'service_provider': service_provider, "params":params,'anonymous':anonymous]
	}
	
	def payureturn(){
		def result = (boolean)request.getParameter('result')
		def paramss = request.getParameter('params')
		def rewardId = request.getParameter('rewardId')
		def projectId = request.getParameter('projectId')
		def amount = request.getParameter('amount')
		def userid = request.getParameter('userId')
		def fundraiserId = request.getParameter('fundraiser')
		def address=request.getParameter("physicalAddress")
		def txnid = request.getParameter('txnid')
			
		Project project = Project.get(projectId)
		User user = User.get(userid)
		User fundraiser = User.get(fundraiserId)
		Reward reward = Reward.get(rewardId)
		if (result){
			userContribution(project,reward,amount,txnid,user,fundraiser,paramss,address)
		} else {
			render view: 'fund/index', model: [project: project]
		}
	}
}
