package crowdera

import grails.plugin.springsecurity.annotation.Secured
import groovy.json.JsonSlurper
import groovyx.net.http.ContentType
import groovyx.net.http.HTTPBuilder
import groovyx.net.http.Method

import org.apache.http.HttpEntity
import org.apache.http.HttpResponse
import org.apache.http.client.HttpClient
import org.apache.http.client.methods.HttpGet;
import org.apache.http.client.methods.HttpPost
import org.apache.http.entity.StringEntity
import org.apache.http.impl.client.DefaultHttpClient
import org.apache.http.util.EntityUtils
import grails.util.Environment
import org.codehaus.groovy.grails.web.json.JSONObject

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
        def fundraiser = userService.getUserFromVanityName(params.fr)
        def currentEnv = Environment.current.getName()
        def state = projectService.getState()
        def country = projectService.getCountry()

        def projectId = projectService.getProjectIdFromVanityTitle(params.projectTitle)
        if (projectId) {
            project = Project.findById(projectId)
        }

        def team = userService.getTeamByUser(fundraiser, project)
		def reward = (params.rewardId) ? rewardService.getRewardById(params.long('rewardId')) : rewardService.getNoReward()
		def perk = rewardService.getRewardById(params.long('rewardId'))

        def shippingInfo = rewardService.getShippingInfo(reward)

        boolean fundingAchieved = contributionService.isFundingAchievedForProject(project)
        boolean ended = projectService.isProjectDeadlineCrossed(project)

        if (!project) {
            def previousPage = 'campaign details'
            render (view: '/project/manageproject/error', model: [project: project, currentEnv:currentEnv, previousPage:previousPage])
        } else if (fundingAchieved || ended) {
            redirect(controller: 'project', action: 'showCampaign', id: project.id)
        } else {
        
            def request_url = request.getRequestURL().substring(0,request.getRequestURL().indexOf("/", 8))
            def base_url = (request_url.contains('www')) ? grailsApplication.config.crowdera.BASE_URL1 : grailsApplication.config.crowdera.BASE_URL
            
            if (project.payuStatus){
                def key = grailsApplication.config.crowdera.PAYU.KEY
                def salt = grailsApplication.config.crowdera.PAYU.SALT
                def service_provider = "payu_paisa"
                
                render view: 'fund/index', model: [team:team, project: project, state:state, country:country, perk:perk, user:user, currentEnv: currentEnv, fundraiser:fundraiser, vanityTitle:params.projectTitle, vanityUsername:params.fr, reward:reward, shippingInfo:shippingInfo, key:key, salt:salt, service_provider:service_provider]
            } else {
                render view: 'fund/index', model: [team:team, project: project, state:state, country:country, perk:perk, user:user, currentEnv: currentEnv, fundraiser:fundraiser, vanityTitle:params.projectTitle, vanityUsername:params.fr, reward:reward, shippingInfo:shippingInfo]
            }
        
        }
    }

    def checkout() {
        Project project
        Reward reward
        def vanityTitle

        def country = projectService.getCountry()
        def cardTypes = projectService.getcardtypes()
        def title = projectService.getTitle()
        def state = projectService.getState()
        def month = contributionService.getMonth()
        def year = contributionService.getYear()
        def defaultCountry = 'US'
        perk = rewardService.getRewardById(params.long('rewardId'))
        def user1 = userService.getUserByUsername(params.tempValue)
        
        def currentEnv = Environment.current.getName()

        def user = userService.getUserById(params.long('userId'))
        if (user == null){
            user = userService.getUserByUsername('anonymous@example.com')
        }
        if (params.projectId) {
            project = projectService.getProjectById(params.projectId)
            vanityTitle = projectService.getVanityTitleFromId(params.projectId)
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
        
        def vanityUserName = params.fr
        
        if(percentage>999) {
            flash.amt_message= "Amount should not exceed more than \$"+remainAmt.round()
            redirect action: 'fund', params:['fr': vanityUserName, 'rewardId': perk.id, 'projectTitle': vanityTitle]
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
                def previousPage = 'fund'
                render (view: '/project/manageproject/error', model: [project: project, currentEnv:currentEnv, previousPage:previousPage]) 
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
        
        def currentEnv = projectService.getCurrentEnvironment()

        if (params.campaignId) {
            project = projectService.getProjectById(params.campaignId)
            vanityTitle = projectService.getVanityTitleFromId(params.campaignId)
        }

        if (project) {
            def user = userService.getUserById(params.long('userId'))
            if (user == null){
                user = userService.getUserByUsername('anonymous@example.com')
            }
        
            User fundraiser = userService.getUserFromVanityName(params.fr)

            if (params.int('rewardId')) {
                reward = project.rewards.find {
                    it.id == params.int('rewardId')
                }
            } else {
                reward = rewardService.getNoReward()
            }

            def amount = params.double(('amount'))

            def totalContribution= contributionService.getTotalContributionForProject(project)
            def contPrice = params.double(('amount'))
            def amt =project.amount
            def reqAmt=(999/100)*amt
            def remainAmt=reqAmt- totalContribution
            def percentage=((totalContribution + contPrice)/ amt)*100
            perk = Reward.get(params.long('rewardId'))
            def vanityUserName = params.fr
            
            if(percentage > 999) {
                flash.amt_message= "Amount should not exceed more than \$"+remainAmt.round()
                redirect action: 'fund', params:['fr': vanityUserName, 'rewardId': perk.id, 'projectTitle': vanityTitle]
            } else {
                if (project && reward) {
                    if (project.paypalEmail){
                        paypalurl(params,fundraiser,user)
                    } else {
                        def address = projectService.getAddress(params)
                        payByFirstGiving(params,project,reward,user,fundraiser,address)
                    }
                } else {
                    render view: 'error', model: [message: 'This project or reward does not exist. Please try again.']
                }
            }
        } else {
            render (view: '/fund/error', model: [project: project, currentEnv: currentEnv])
        }
    }

    def acknowledge() {
        Contribution contribution = contributionService.getContributionById(params.long('cb'))
        
        def project = contribution?.project
        def reward = contribution?.reward
        def user = contribution?.user
        def fundraiser = userService.getUserById(params.long('fr'))
        def request_url=request.getRequestURL().substring(0,request.getRequestURL().indexOf("/", 8))
        def base_url = (request_url.contains('www')) ? grailsApplication.config.crowdera.BASE_URL1 : grailsApplication.config.crowdera.BASE_URL
        if (userService.getCurrentUser()){
            def vanityusername = userService.getVanityNameFromUsername(fundraiser?.username, project?.id)
            def shortUrl = projectService.getShortenUrl(project?.id, vanityusername)
            def twitterShareUrl = base_url+"/c"+shortUrl
            mandrillService.sendThankYouMailToContributors(contribution, project, contribution.amount, fundraiser)
            render view: 'acknowledge/acknowledge', model: [project: project, reward: reward,contribution: contribution, user: user, fundraiser:fundraiser, projectTitle:params.projectTitle, twitterShareUrl:twitterShareUrl]
        } else {
            def reqUrl = base_url+"/fund/sendEmail?cb=${params.cb}&fr=${params.fr}&projectTitle=${params.projectTitle}"
            def loginSignUpCookie = projectService.setLoginSignUpCookie()
            def campaignNameCookie = projectService.setCampaignNameCookie(project?.title)
            def fundingAmountCookie = projectService.setFundingAmountCookie(contribution?.amount)
            def contributorNameCookie = projectService.setContributorName(contribution?.contributorName)
            def setRequestUrlCookie = projectService.setRequestUrlCookie(reqUrl)

            if(setRequestUrlCookie){
                response.addCookie(setRequestUrlCookie)
            }
            if (loginSignUpCookie) {
                response.addCookie(loginSignUpCookie)
            }
            if (campaignNameCookie){
                response.addCookie(campaignNameCookie)
            }
            if (fundingAmountCookie){
                response.addCookie(fundingAmountCookie)
            }
            if (contributorNameCookie){
                response.addCookie(contributorNameCookie)
            }
            redirect (action:'sendEmail', params:params)
        }
    }

    @Secured(['IS_AUTHENTICATED_FULLY'])
    def sendEmail () {
        Contribution contribution = contributionService.getContributionById(params.long('cb'))

        if (contribution) {
            contribution.user = userService.getCurrentUser();
            contribution.save();

            def project = contribution.project
            def fundraiser = userService.getUserById(params.long('fr'))
            if (fundraiser){
                mandrillService.sendThankYouMailToContributors(contribution, project, contribution.amount, fundraiser)
            }

            def fundingAmountCookieValue = g.cookie(name: 'fundingAmountCookie')
            def campaignNameCookieValue = g.cookie(name: 'campaignNameCookie')
            def loginSignUpCookieValue = g.cookie(name: 'loginSignUpCookie')
            def contributorNameCookieValue = g.cookie(name: 'contributorNameCookie')
            def contributorEmailCookie = projectService.setContributorEmailCookie(contribution.contributorEmail)

            if (fundingAmountCookieValue){
                def cookie = projectService.deleteFundingAmountCookie(fundingAmountCookieValue)
                response.addCookie(cookie)
            }
            if (campaignNameCookieValue){
                def cookie = projectService.deleteCampaignNameCookie(campaignNameCookieValue)
                response.addCookie(cookie)
            }
            if(loginSignUpCookieValue){
                def cookie = projectService.deleteLoginSignUpCookie()
                response.addCookie(cookie)
            }
            if (contributorNameCookieValue){
                def cookie = projectService.deleteContributorName(contributorNameCookieValue)
                response.addCookie(cookie)
            }
            if(contributorEmailCookie){
                response.addCookie(contributorEmailCookie)
            }
                redirect (controller:'home', action:'index')
        } else {
            render view:'404error'
        }
    }

    def saveContributionComent(){
        Contribution contribution = contributionService.getContributionById(params.long('id'))
        def projectComment = projectService.getProjectCommentById(params.long('commentId'))
        def teamComment = projectService.getTeamCommentById(params.long('teamCommentId'))
        def projectId = projectService.getProjectIdFromVanityTitle(params.projectTitle)
        def project = projectService.getProjectById(projectId)
        def fundRaiser = userService.getUserById(params.long('fr'))
        
        if(contribution == null ){
           return false
        }
        
        def user = contribution?.user
        def reward = contribution?.reward

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
                def message = "Something went wrong saving comment. Please try again later."
                render view: 'error', model: [message: message]
            }
            
        }
    }
    
    def saveCommentRedirect() {
        Contribution contribution = contributionService.getContributionById(params.long('id'))
        def projectComment = projectService.getProjectCommentById(params.long('commentId'))
        def projectId = projectService.getProjectIdFromVanityTitle(params.projectTitle)
        def project = projectService.getProjectById(projectId)
        def fundRaiser = userService.getUserById(params.long('fr'))
        
        def user = contribution?.user
        def reward = contribution?.reward
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
        
        if(contribution ==null){
            return false    
        }
        
        if(Contribution){
            def project = contribution?.project
            def reward = contribution?.reward
            def user = contribution?.user
            def fundraiser = userService.getUserById(params.long('fr'))
            def value = 'value'
            def projectComment = projectService.getProjectCommentById(params.long('commentId'))
            def teamComment = projectService.getTeamCommentById(params.long('teamCommentId'))
            render view: 'acknowledge/acknowledge', model: [project: project, reward: reward,contribution: contribution, user: user, fundraiser:fundraiser,projectTitle:params.projectTitle, value: value, comment: projectComment, teamComment:teamComment]
        } else {
            def message = "Something went wrong saving comment. Please try again later."
            render view: 'error', model: [message: message]
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
        user = userService.getUserForContributors(params.billToEmail, user.id)
        
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

    def payByPaypal(def params,Project project,Reward reward,User user,User fundraiser,def shippingInfo){
        String timestamp = UUID.randomUUID().toString()
        def request_url=request.getRequestURL().substring(0,request.getRequestURL().indexOf("/", 8))
        def base_url = (request_url.contains('www')) ? grailsApplication.config.crowdera.BASE_URL1 : grailsApplication.config.crowdera.BASE_URL
        def successUrl = base_url + "/fund/paypalReturn/paypalcallback?projectTitle=${params.projectTitle}&rewardId=${reward.id}&amount=${params.amount}&result=true&userId=${user.id}&timestamp=${timestamp}&fundraiser=${fundraiser.id}&shippingEmail=${shippingInfo.email}&twitterHandle=${shippingInfo.twitter}&shippingCustom=${shippingInfo.custom}&tempValue=${params.tempValue}&name=${params.receiptName}&email=${params.receiptEmail}&address=${shippingInfo.address}&anonymous=${params.anonymous}"
        def failureUrl = base_url + "/fund/paypalReturn/paypalcallback?projectTitle=${params.projectTitle}&rewardId=${reward.id}&amount=${params.amount}&userId=${user.id}&timestamp=${timestamp}&fundraiser=${fundraiser.id}"

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
        if(json){
            ack = json?.responseEnvelope?.ack
            paykey = json?.payKey
        
            PaykeyTemp paykeytemp = new PaykeyTemp(
                timestamp: timestamp,
                paykey:paykey,
                )
           paykeytemp.save(failOnError: true)
        }
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

    def paypalurl(def params, User fundraiser, User user){
        Project project = projectService.getProjectById(params.projectId)
        Reward reward = (params.rewardId) ? rewardService.getRewardById(params.long('rewardId')) : rewardService.getNoReward()
        def shippingInfo = projectService.getShippingInfo(params)
        if (project && reward && fundraiser) {
            payByPaypal(params,project,reward,user,fundraiser,shippingInfo)
            if(ack.equals("Success")) {
                redirect (url:grailsApplication.config.crowdera.paypal.PAYPAL_URL+paykey)
            } else {
                flash.paypalFailureMessage = "Unable to connect to the paypal account."
                redirect action: 'fund', id: params.projectId, params:[fr: fundraiser.id]
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
        
        User user = userService.getUserForContributors(request.getParameter('email') , userid)
        
        User fundraiser = userService.getUserById(fundraiserId)
        Reward reward = rewardService.getRewardById(rewardId)

        def paykeytemp = projectService.getpayKeytempObject(timestamp)
        def payKey = paykeytemp?.paykey
        paykeytemp.delete()
        
        if (result) {
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
        def transactionSort = contributionService.transactionSort()
        def request_url=request.getRequestURL().substring(0,request.getRequestURL().indexOf("/", 8))
        def base_url = (request_url.contains('www')) ? grailsApplication.config.crowdera.BASE_URL1 : grailsApplication.config.crowdera.BASE_URL
        
        def multiplier = projectService.getCurrencyConverter();
        if (params.currency == 'INR'){
            def contributionINR = contributionService.getINRContributions(params)
            render view: '/user/admin/transactionIndex', model: [multiplier: multiplier, contribution: contributionINR.contributions, 
                                                         totalContributions: contributionINR.totalContributions, currency:'INR', transactionSort:transactionSort, url:base_url]
        } else {
            def contributionUSD = contributionService.getUSDContributions(params)
            render view: '/user/admin/transactionIndex', model: [multiplier: multiplier, contribution: contributionUSD.contributions,
                                                         totalContributions: contributionUSD.totalContributions, currency:'USD', transactionSort:transactionSort, url:base_url]
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
        def reward = Reward.get(params.rewardId)
        User fundraiser = userService.getUserFromVanityName(params.fr)
        def vanityUserName = params.fr
        def amount = params.amount
        def projectTitle = params.projectTitle
        def anonymous = params.anonymous
        def vanityTitle
        def country = projectService.getCountry()
        def state = projectService.getIndianState()

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
        def totalContribution = contributionService.getTotalContributionForProject(project)
        def contPrice = Double.parseDouble(amount)
        def amt = project.amount
        def reqAmt = (999/100) * amt
        def remainAmt = reqAmt- totalContribution
        def percentage = ((totalContribution + contPrice)/ amt)*100

        def key = grailsApplication.config.crowdera.PAYU.KEY
        def salt = grailsApplication.config.crowdera.PAYU.SALT
        def service_provider = "payu_paisa"

        if(percentage > 999) {
            flash.amt_message= "Amount should not exceed more than \$"+remainAmt.round()
            redirect action: 'fund', params:['fr': vanityUserName, 'rewardId': perk.id, 'projectTitle': vanityTitle]
        }
        render view:"checkout/payu" ,model:['service_provider': service_provider, 'key': key, 'salt': salt, 'amount':amount,'project':project, 'reward':reward, 'fundraiser':fundraiser, 'user':user,'projectTitle':projectTitle,'anonymous':anonymous, 'country':country, 'state':state]
    }

     def payupayment(){
        JSONObject json = new JSONObject();
        def request_url = request.getRequestURL().substring(0,request.getRequestURL().indexOf("/", 8))
        def base_url = (request_url.contains('www')) ? grailsApplication.config.crowdera.BASE_URL1 : grailsApplication.config.crowdera.BASE_URL
        json = projectService.getPayuInfo(params, base_url)
        render json
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
        User user = userService.getUserForContributors(request.getParameter('email'), userid)
        
        User fundraiser = User.get(fundraiserId)
        Reward reward = Reward.get(rewardId)
        if (result){
            userContribution(project,reward,amount,txnid,user,fundraiser,paramss,address)
        } else {
            render view: 'fund/index', model: [project: project]
        }
    }

    def getRewardShippingDetails(){
        def anonymous = request.getParameter('anonymous')
        def reward = rewardService.getRewardById(params.long('rewardId'));
        def shippingInfo = rewardService.getShippingInfo(reward);
        def state = projectService.getState()
        def country = projectService.getCountry()
        if(request.xhr){
            render(template: "fund/perkShippingDetails", model:[shippingInfo:shippingInfo, anonymous:anonymous, state:state, country:country])
        }
    }
    
    @Secured(['ROLE_ADMIN'])
    def getSortedContributions(){
        def sortedList = contributionService.getContributionSortedResult(params, params.selectedSortValue, params.currency)
        if(request.xhr){
            render(template:"/user/admin/transactionGrid", model: [contribution: sortedList.contributions, totalContributions: sortedList.totalContributions]);
        }
    }
    
    @Secured(['ROLE_ADMIN'])
    def sendEmailToContributors(){
        projectService.makeContributorsUser()
        flash.contributorUsernameAndPwdmessage = "Email has been send to the non-registered contributors with their username and password and registered contributors are now able to watch their contribution on their dashboard."
        redirect(action:'transaction')
    }
    
    @Secured(['ROLE_ADMIN'])
    def transactionList() {
        def request_url=request.getRequestURL().substring(0,request.getRequestURL().indexOf("/", 8))
        def base_url = (request_url.contains('www')) ? grailsApplication.config.crowdera.BASE_URL1 : grailsApplication.config.crowdera.BASE_URL
        
        def multiplier = projectService.getCurrencyConverter();
        def model
        if (params.currency == 'INR'){
            def contributionINR = contributionService.getINRContributions(params)
            model= [multiplier: multiplier, contribution: contributionINR.contributions, totalContributions: contributionINR.totalContributions, currency:'INR', url:base_url, offset: params.offset]
        } else {
            def contributionUSD = contributionService.getUSDContributions(params)
            model = [multiplier: multiplier, contribution: contributionUSD.contributions, totalContributions: contributionUSD.totalContributions, currency:'USD', url:base_url, offset: params.offset]
        }
        if (request.xhr) {
            render(template: "/user/admin/transactionGrid", model: model)
        } else {
            render ''
        }
    }
    
    
    def getSellerIdForCampaign() {
        def citrusBaseUrl = grailsApplication.config.crowdera.CITRUS.BASE_URL
        
        def sellerUrl = citrusBaseUrl + "/marketplace/seller/"
        
        def sellername = "John Smith"
        def address1 = "City Garden"
        def address2 = "Link Road"
        def city = "Mumbai"
        def state = "MH"
        def country = "India"
        def zip = "41234"
        def businessurl = "www.rediff.com"
        def sellermobile = "9422173793"
        def ifsccode = "ICIC0001206"
        def accountnumber = "123456"
        def payoutmode = "WALLET"
        def selleremail = "johnsmith@gmail.com"
        
        HttpClient httpclient = new DefaultHttpClient()
        HttpPost httppost = new HttpPost(sellerUrl)
        
        StringEntity input = new StringEntity("{\"sellername\":\"${sellername}\",\"address1\":\"${address1}\",\"address2\":\"${address2}\",\"city\":\"${city}\",\"state\":\"${state}\",\"country\":\"${country}\",\"zip\":\"${zip}\",\"businessurl\":\"${businessurl}\",\"sellermobile\":\"${sellermobile}\",\"ifsccode\":\"${ifsccode}\",\"accountnumber\":\"${accountnumber}\",\"active\":1,\"payoutmode\":\"${payoutmode}\",\"selleremail\":\"${selleremail}\"}")
        
        input.setContentType("application/json")
        httppost.setEntity(input)

        HttpResponse httpres = httpclient.execute(httppost)
        int status = httpres.getStatusLine().getStatusCode()
        def sellerId
        
        if (status == 200){
            HttpEntity entity = httpres.getEntity()
            if (entity != null){
                sellerId = EntityUtils.toString(entity)
            }
        }
        
        return sellerId
    }
    
    
    def citrusCheckout() {
        Project project
        Reward reward
        def vanityTitle

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
            vanityTitle = projectService.getVanityTitleFromId(params.projectId)
        }
        
        def anonymous = params.anonymous
        
        User fundraiser = userService.getUserFromVanityName(params.fr)
        def team = userService.getTeamByUser(fundraiser, project)

        def totalContribution= contributionService.getTotalContributionForProject(project)
        def contPrice = params.double(('amount'))
        def amt = project.amount
        def reqAmt = (999/100) * amt
        def remainAmt = reqAmt- totalContribution
        def percentage = ((totalContribution + contPrice)/ amt) * 100
        
        def vanityUserName = params.fr
        
        if(percentage > 999) {
            flash.amt_message= "Amount should not exceed more than \$"+remainAmt.round()
            redirect action: 'fund', params:['fr': vanityUserName, 'rewardId': perk.id, 'projectTitle': vanityTitle]
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
            String citrusAmount = ''+amount
            
            if (project && reward) {
                if(!team || ! project.user){
                    render view:"error", model: [message:'User not found']
                } else{
                    String txnID = String.valueOf(System.currentTimeMillis());
                    String secret_key = grailsApplication.config.crowdera.CITRUS.SECRETE_KEY
                    String access_Key = grailsApplication.config.crowdera.CITRUS.ACCESS_KEY
                    
                    def securitySignature = contributionService.getSecuritySignature(txnID, secret_key, access_Key, citrusAmount)
                    render view: 'checkout/citrus', 
                           model: [project: project, reward: reward, amount: amount, country:country, cardTypes:cardTypes, user:user, title:title,
                                   state:state, defaultCountry:defaultCountry, month:month, year:year, fundraiser:fundraiser, user1:user1, anonymous:anonymous, 
                                   projectTitle:params.projectTitle, username:params.fr, txnID: txnID, securitySignature: securitySignature]
                }
            } else {
                render view: 'error', model: [message: 'This project or reward does not exist. Please try again.']
            }
        }
    }
    
    
    def setCitrusInfo() {
        projectService.setCitrusInfo(session, params)
        render ''
    }
    
    
    def citrusreturn() {
        String secret_key = grailsApplication.config.crowdera.CITRUS.SECRETE_KEY
        def fr = session.getAttribute('fr');
        User fundraiser  = userService.getUserFromVanityName(fr)
        
        def contributionId = projectService.getCitrusTransactionDetails(secret_key, request, session, fundraiser)
        def projectTitle = session.getAttribute('projectTitle')
        
        if (contributionId && fundraiser) {
            redirect(controller: 'fund', action: 'acknowledge' , params: [cb: contributionId, fr:fundraiser.id, projectTitle: projectTitle])
        }
    }
    
    
    def payByCitrus() {
        def citrusBaseUrl = grailsApplication.config.crowdera.CITRUS.BASE_URL
        
        Date date = new Date()
        def transactionDate = date.format("YYYY-MM-DD HH:mm:ss")
        def contributorEmail = params.email;
        
        def project
        def reward
        def user
        def fundraiser
        
        def address = projectService.getAddress(params)
        def amount = params.amount
        
        def merchantOrderRef = "ABC123"
        def auth_token = contributionService.getAccessTokenForCitrus()
        def transactionUrl = citrusBaseUrl + "/marketplace/trans/"
        
        HttpClient httpclient = new DefaultHttpClient()
        HttpPost httppost = new HttpPost(transactionUrl)
        httppost.setHeader("auth_token","${auth_token}")
        
        StringEntity input = new StringEntity("{\"merc_order_ref\":\"${merchantOrderRef}\",\"trans_datetime\":\"${transactionDate}\", \"trans_amount\":${amount}, \"trans_paymode\":\"Credit Card\", \"trans_pay_source\":\"CITRUS\", \"trans_customer\":\"${contributorEmail}\", \"trans_note\":\"Sale Transaction\"}")
        
        input.setContentType("application/json")
        httppost.setEntity(input)

        HttpResponse httpres = httpclient.execute(httppost)
        int status = httpres.getStatusLine().getStatusCode()
        def transactionId
        
        if (status == 200){
            HttpEntity entity = httpres.getEntity()
            if (entity != null){
                transactionId = EntityUtils.toString(entity)
            }
        }
        
        render transactionId
        userContribution(project, reward, amount, transactionId, user, fundraiser, params, address)
    }
    
    def addCitrusTransaction() {
        def citrusBaseUrl = grailsApplication.config.crowdera.CITRUS.SPLITPAY_URL
        def url = citrusBaseUrl +"/marketplace/trans/"
        
        Date date = new Date()
        def mercOrderRef = '2gxvaj'
        def transactionDate = date.format("yyyy-MM-dd HH:mm:ss")
        def amount = 10000
        def paymode = 'Credit Card'
        def transCustomer = 'krishna.sahu@crowdera.co'
        
        HttpClient httpclient = new DefaultHttpClient()
        HttpPost httppost = new HttpPost(url)
        def auth_token = contributionService.getAccessTokenForCitrus()
        httppost.setHeader("auth_token","${auth_token}")
        
        StringEntity input = new StringEntity("{\"merc_order_ref\":\"${mercOrderRef}\",\"trans_datetime\":\"${transactionDate}\",\"merchant_split_ref\":\"abcddcjc\",\"trans_amount\": 1000,\"trans_paymode\":\"${paymode}\",\"trans_pay_source\":\"CITRUS\", \"trans_customer\":\"${transCustomer}\", \"trans_note\":\"Sale Transaction\"}")
        
        input.setContentType("application/json")
        httppost.setEntity(input)

        HttpResponse httpres = httpclient.execute(httppost)
        int status = httpres.getStatusLine().getStatusCode()
        def transactionId
        
        if (status == 200){
            HttpEntity entity = httpres.getEntity()
            if (entity != null){
                transactionId = EntityUtils.toString(entity)
            }
        }
        
        render transactionId
    }
    
    
    def getseller() {
        def citrusBaseUrl = grailsApplication.config.crowdera.CITRUS.SPLITPAY_URL
        String sellerId = params.sellerId
        def url = citrusBaseUrl +"/marketplace/seller/${sellerId}"
        HttpClient httpclient = new DefaultHttpClient()
        HttpGet httpGet = new HttpGet(url)
        def auth_token = contributionService.getAccessTokenForCitrus()
        def seller
        httpGet.setHeader("auth_token","${auth_token}")
        HttpResponse httpres = httpclient.execute(httpGet)
        
        int status = httpres.getStatusLine().getStatusCode()
        if (status == 200) {
            HttpEntity entity = httpres.getEntity();
            if (entity != null){
                def jsonString = EntityUtils.toString(entity)
                def slurper = new JsonSlurper()
                def json = slurper.parseText(jsonString)
                seller = json
            }
        }
        render seller
    }
    
    def getSellerAccountBalance() {
        def citrusBaseUrl = grailsApplication.config.crowdera.CITRUS.SPLITPAY_URL
        String sellerId = params.sellerId
        def url = citrusBaseUrl +"/marketplace/seller/getbalance/${sellerId}"
        HttpClient httpclient = new DefaultHttpClient()
        HttpGet httpGet = new HttpGet(url)
        def auth_token = contributionService.getAccessTokenForCitrus()
        def seller
        httpGet.setHeader("auth_token","${auth_token}")
        HttpResponse httpres = httpclient.execute(httpGet)
        
        int status = httpres.getStatusLine().getStatusCode()
        if (status == 200) {
            HttpEntity entity = httpres.getEntity();
            if (entity != null){
                def jsonString = EntityUtils.toString(entity)
                def slurper = new JsonSlurper()
                def json = slurper.parseText(jsonString)
                seller = json.account_balance
//                json.account_id
            }
        }
        render seller
    }
    
    def getSplitIdForTransactionId() {
        def citrusBaseUrl = grailsApplication.config.crowdera.CITRUS.SPLITPAY_URL
        def url = citrusBaseUrl +"/marketplace/split/"
        
        HttpClient httpclient = new DefaultHttpClient()
        HttpPost httppost = new HttpPost(url)
        
        def trans_id = 6908
        def seller_id = 623
        def merchant_split_ref = "65297"
        def split_amount = 900
        def fee_amount = 20
        def auto_payout = 1

        StringEntity input = new StringEntity("{\"trans_id\":${trans_id},\"seller_id\":${seller_id},\"merchant_split_ref\":\"${merchant_split_ref}\",\"split_amount\":${split_amount},\"fee_amount\":${fee_amount},\"auto_payout\":${auto_payout}}")
        input.setContentType("application/json")
        httppost.setEntity(input)

        def auth_token = contributionService.getAccessTokenForCitrus()
        httppost.setHeader("auth_token","${auth_token}")
        HttpResponse httpres = httpclient.execute(httppost)
        def splitId
        
        int status = httpres.getStatusLine().getStatusCode()
        if (status == 200){
            HttpEntity entity = httpres.getEntity()
            if (entity != null){
                def jsonString = EntityUtils.toString(entity)
                def slurper = new JsonSlurper()
                def json = slurper.parseText(jsonString)
                splitId = json.split_id
            }
        }
        
        render httpres.toString()
    }
    
    def releaseFundToSeller() {
        def citrusBaseUrl = grailsApplication.config.crowdera.CITRUS.SPLITPAY_URL
        def url = citrusBaseUrl +"marketplace/funds/release/"
        HttpClient httpclient = new DefaultHttpClient()
        HttpPost httppost = new HttpPost(url)
        
        def splitId

        StringEntity input = new StringEntity("{\"split_id\":\"${splitId}\"}")
        
        input.setContentType("application/json")
        httppost.setEntity(input)

        HttpResponse httpres = httpclient.execute(httppost)
        def releaseFundRef
        def payout
        int status = httpres.getStatusLine().getStatusCode()
        
        if (status == 200) {
            HttpEntity entity = httpres.getEntity();
            if (entity != null){
                def jsonString = EntityUtils.toString(entity)
                def slurper = new JsonSlurper()
                def json = slurper.parseText(jsonString)
                releaseFundRef = json.releasefund_ref
                payout = json.payout
            }
        }
        
        render message
    }
    
    @Secured(['ROLE_USER'])
    def moveContributions(){
            
        def project = Project.get(params.id)
        def title = projectService.getVanityTitleFromId(params.id)
        def fundraiser = params.contributionFR //from
        def contributor= params.contributorFR2 // to
        def contributorName = params.contributorName
        def amount= params.double('contributionAmount')
        def teamFundraiser
        def teamContributor

        def fundRaiserUserName = projectService.getFundraiserByFirstnameAndLastName(fundraiser, project.teams)
        def contributorUserName = projectService.getFundraiserByFirstnameAndLastName(contributor, project.teams)
        def contribution = contributionService.getContributionForMoving(contributorName, fundRaiserUserName, amount,contributorUserName, project)
        
        if(fundRaiserUserName){
            teamFundraiser = projectService.getTeamByUsernameAndProject(fundRaiserUserName, project)
        }

        if(contributorUserName){
            teamContributor = projectService.getTeamByUsernameAndProject(contributorUserName, project)
        }

        if((teamFundraiser!=teamContributor) && (contribution!=null)){
            teamFundraiser.removeFromContributions(contribution) //from
            teamContributor.addToContributions(contribution)  //to
            redirect(controller: 'project', action: 'manageproject',fragment: 'contributions', params:['projectTitle':title])
        }else{
            redirect(controller: 'project', action: 'manageproject',fragment: 'contributions', params:['projectTitle':title])
        }
        
    }

}
