package crowdera

import groovy.json.JsonSlurper

import org.apache.http.HttpEntity
import org.apache.http.HttpResponse
import org.apache.http.client.HttpClient
import org.apache.http.client.methods.HttpGet
import org.apache.http.client.methods.HttpPost;
import org.apache.http.entity.StringEntity;
import org.apache.http.impl.client.DefaultHttpClient
import org.apache.http.util.EntityUtils
import org.hibernate.SessionFactory
import org.hibernate.criterion.Projections
import org.hibernate.criterion.Restrictions

import crowdera.ConstantUtil.PaymentState
/*Merging Master branch changes*/
class CampaignService {

	def contributionService
	def projectService
	def userService
	def mandrillService
	def rewardService

	SessionFactory sessionFactory;
	def grailsApplication

	public List<Project> getValidatedProjectsForCampaignAdmin(String condition, boolean payuStatus) {

		def raised = 0;
		def daysleft = 0;
		List<Project> projectList = new ArrayList<>();
		List<Project> activeProjectList = new ArrayList<>();
		List<Project> endedProjectList = new ArrayList<>();
		boolean isCampaignEnded = false;

		def criteria = Project.createCriteria();

		def result = criteria.list {
			resultTransformer(org.hibernate.transform.Transformers.ALIAS_TO_ENTITY_MAP)
			createAlias('user', 'user')
			projections {
				property('id', 'id')
				property('title', 'title')
				property('amount', 'amount')
				property('description', 'description')
				property('user.username', 'username')
				property('days', 'days')
				property('created', 'created')
			}
			switch (condition) {
				case 'Pending':
					eq("validated", false)
					eq("draft", false)
					eq("rejected", false)
					eq("inactive", false)
					break;
				case 'Homepage' || 'Deadline' || 'Current' || 'Ended':
					eq("validated", true)
					eq("draft", false)
					eq("rejected", false)
					eq("inactive", false)
					break;
				case 'Draft':
					eq("draft", true)
					eq("rejected", false)
					eq("inactive", false)
					break;
				case 'Rejected':
					eq("rejected", false)
					break;
				default :
					break;
			}
			eq("payuStatus", payuStatus)
		}

		if (condition == 'Current' || condition == 'Ended' || condition=="Homepage" || condition=='Deadline') {

			result.each { project ->
				raised = Contribution.createCriteria().get {
					createAlias('project', 'project')
					projections { sum "amount" }
					eq("project.id", project.id)
					isNotNull("")
				}

				if (project.days > (Calendar.instance - project.created.toCalendar()) ) {
					daysleft = project.days - (Calendar.instance - project.created.toCalendar());
					activeProjectList.add(project);
				} else {
					daysleft =  0;
					isCampaignEnded = true;
					endedProjectList.add(project);
				}
				project["daysleft"] = daysleft;
				project["raised"] = raised;
				project["isCampaignEnded"] = isCampaignEnded;
				projectList.add(project);
			}

			switch (condition) {
				case 'Current':
					projectList = activeProjectList;
					break;
				case 'Ended':
					projectList = endedProjectList;
					break;
				default :
					projectList = projectList;
			}
		} else if (condition == 'Rejected' || condition == 'Pending' || condition == 'Draft') {
			result.each { project ->
				project["daysleft"] = 0;
				project["raised"] = 0;
				project["isCampaignEnded"] = false;
				projectList.add(project);
			}
		}
		return projectList;
	}

	public boolean isTaxReceiptExist(String projectId) {
		String currentEnv = projectService.getCurrentEnvironment();
		Long rowCount = (Long) TaxReciept.createCriteria().add(Restrictions.eq("project.id", projectId))
				.createAlias("project", "project").setProjection(Projections.rowCount()).uniqueResult();
		return (rowCount.intValue() != 0) ? true : false;
	}

	def isUserProjectHavingContribution(User user, def projectAdmins, String environment){
		Boolean doProjectHaveAnyContribution = false

		List<Contribution> contributions = []

		if (environment == 'testIndia' || environment == 'stagingIndia' || environment == 'prodIndia') {
			List projects = Project.findAllWhere(user:user, validated:true, rejected:false, inactive:false, payuStatus:true, offeringTaxReciept:true)
			projects.each { project ->
				project.contributions?.each { contribution ->
					if (contribution.panNumber != null) {
						doProjectHaveAnyContribution = true
					}
				}
			}
			projectAdmins.each {
				def project = Project.findById(it.projectId)

				if (project.contributions && project.payuStatus) {
					project.contributions?.each { contribution ->
						if (contribution.panNumber != null) {
							doProjectHaveAnyContribution = true
						}
					}
				}
			}
		} else {
			List projects = Project.findAllWhere(user:user, validated:true, rejected:false, inactive:false, payuStatus:false, offeringTaxReciept:true)
			projects.each { project ->
				if (project.contributions) {
					doProjectHaveAnyContribution = true
				}
			}

			projectAdmins.each {
				def project = Project.findById(it.projectId)
				if (project.contributions && project.payuStatus == false) {
					doProjectHaveAnyContribution = true
				}
			}
		}

		return doProjectHaveAnyContribution;
	}

	def getAllProjectByUserHavingContribution(User user , def projectAdmins, def environment, def params){
		List activeProjects=[]
		List endedProjects=[]
		List sortedProjects = []
		def finalList
		boolean ended

		boolean doProjectHaveAnyContribution;
		boolean isProjectHaveAnyContribution;

		def projects = Project.findAllWhere(user:user, validated:true, rejected:false, inactive:false, offeringTaxReciept:true)

		projects.each { project->

			if (project.contributions) {

				if ("in".equalsIgnoreCase(project.country.countryCode)) {
					doProjectHaveAnyContribution = false;
				} else {
					doProjectHaveAnyContribution = true;
				}

				if (!doProjectHaveAnyContribution) {
					project.contributions?.each { contribution ->
						if (contribution.panNumber != null) {
							doProjectHaveAnyContribution = true;
						}
					}
				}

				if (doProjectHaveAnyContribution) {
					isProjectHaveAnyContribution = true;
					ended = projectService.isProjectDeadlineCrossed(project);
					if (ended) {
						endedProjects.add(project)
					} else if(project.validated && project.inactive == false) {
						activeProjects.add(project)
					}
				}
			}
		}

		projectAdmins?.each {
			Project project = Project.findById(it.projectId)

			if (project.contributions && project.offeringTaxReciept) {

				if ("in".equalsIgnoreCase(project.country.countryCode)) {
					doProjectHaveAnyContribution = false;
				} else {
					doProjectHaveAnyContribution = true;
				}

				if (!doProjectHaveAnyContribution) {
					project.contributions?.each { contribution ->
						if (contribution.panNumber != null) {
							doProjectHaveAnyContribution = true
						}
					}
				}

				if (doProjectHaveAnyContribution) {
					isProjectHaveAnyContribution = true;
					ended = projectService.isProjectDeadlineCrossed(project);

					if (ended) {
						endedProjects.add(project)
					} else if(project.validated && project.inactive == false){
						activeProjects.add(project)
					}
				}
			}
		}

		sortedProjects = activeProjects.sort{contributionService.getPercentageContributionForProject(it)}
		finalList = sortedProjects.reverse() + endedProjects.reverse()

		def campaigns = []
		if (!finalList.isEmpty()){
			def offset = params.offset ? params.int('offset') : 0
			def max = 6
			def count = finalList.size()
			def maxrange

			if(offset + max <= count) {
				maxrange = offset + max
			} else {
				maxrange = offset + (count - offset)
			}
			campaigns = finalList.reverse().subList(offset, maxrange)
		}
		return ['totalProjects' : finalList, 'projects' : campaigns, 'isProjectHaveAnyContribution': isProjectHaveAnyContribution]
	}


	def getContributionsList(int paymentState) {

		List<Contribution> contributions = new ArrayList<Contribution>();
		contributions = Contribution.createCriteria().list {
			eq("currency", "INR")
			eq("payout", false)
			isNotNull("splitId")
			if (paymentState == PaymentState.SPLIT_STATE.getId()) {
				isNull("settlementId")
				isNull("releaseFundRef")
			} else if (paymentState == PaymentState.SETTLEMENT_STATE.getId()) {
				isNotNull("settlementId")
				isNull("releaseFundRef")
			} else if (paymentState == PaymentState.RELEASED_STATE.getId()) {
				isNotNull("settlementId")
				isNotNull("releaseFundRef")
			}
		}
		return contributions;
	}

	def getSettlementStatus() {

		try {
			List<Contribution> contributions = getContributionsList(PaymentState.SPLIT_STATE.getId());
	
			def citrusBaseUrl = grailsApplication.config.crowdera.CITRUS.SPLITPAY_URL
			def url = citrusBaseUrl +"/marketplace/search/pgsettlement/"
	
			def settlementRef;
			def settlementAmount;
			def feeAmount;
			def settlementId;
			def json;
			int status;
	
			def slurper = new JsonSlurper()
			
			def auth_token;
			if (contributions.size() > 0) {
				auth_token = contributionService.getAccessTokenForCitrus();
			}
	
			for (Contribution contribution : contributions) {
				def httpUrl= url + contribution.merchantTxId
	
				HttpClient httpClient = new DefaultHttpClient()
				HttpGet httpGet = new HttpGet(httpUrl)
	
				httpGet.setHeader("auth_token","${auth_token}")
	
				HttpResponse httpResponse = httpClient.execute(httpGet)
				status = httpResponse.getStatusLine().getStatusCode()
	
				if (status == 200) {
	
					HttpEntity entity = httpResponse.getEntity();
	
					if (entity != null){
						def jsonString = EntityUtils.toString(entity)
						json = slurper.parseText(jsonString)
	
						settlementId = json.settlement_id;
	
						if (settlementId != null && (json.trans_id == contribution.merchantTxId)) {
							contribution.settlementId = settlementId;
							contribution.settlementDate = json.settlement_date_time;
							contribution.save();
						}
	
					}
				}
			}
			
		} catch(Exception e) {
		}
	}
	
	def releaseContributions() {
		
		try {
			def payout = false;
			
			List<Contribution> contributions = getContributionsList(PaymentState.SETTLEMENT_STATE.getId());
			def citrusBaseUrl = grailsApplication.config.crowdera.CITRUS.SPLITPAY_URL
			def url = citrusBaseUrl +"/marketplace/funds/release/"
			def splitId;
			def auth_token;
			
			if (contributions.size() > 0) {
				auth_token = contributionService.getAccessTokenForCitrus();
			}
			
			for (Contribution contribution : contributions) {
				
				HttpClient httpclient = new DefaultHttpClient()
				HttpPost httppost = new HttpPost(url)
				splitId = contribution.splitId
				
				StringEntity input = new StringEntity("{\"split_id\":${splitId}}")
				input.setContentType("application/json")
				httppost.setEntity(input)
	
				httppost.setHeader("auth_token","${auth_token}")
	
				HttpResponse httpres = httpclient.execute(httppost)
				int status = httpres.getStatusLine().getStatusCode()
	
				if (status == 200) {
					HttpEntity entity = httpres.getEntity();
					if (entity != null){
						def jsonString = EntityUtils.toString(entity)
						def slurper = new JsonSlurper()
						def json = slurper.parseText(jsonString)
						
						payout = json.payout
						if (payout == true || payout == "true") {
							contribution.payout = true;
							contribution.releaseFundRef = json.releasefund_ref
							contribution.save();
						}
					}
				}
	
			}
			
		} catch(Exception e) {
		}
	}
	
	/*WePay APIS CALL*/
	
	def getIpAddress(def request) {
		def currentEnv = projectService.getCurrentEnvironment();
		if ("staging".equalsIgnoreCase(currentEnv) || "production".equalsIgnoreCase(currentEnv)) {
			def ipAddress = request.getHeader("CF-Connecting-IP");
			log.info("ipAddress == "+ ipAddress)
			return ipAddress;
		} else {
			return "127.0.0.1"
		}
	}
	
	def getDeviceFromRequestHeader(def request) {
		def device = request.getHeader("User-Agent");
		return device;
	}
	
	def registerUser(String email, String firstName, String lastName, def request) {
		
		def wepayBaseUrl = grailsApplication.config.crowdera.wepay.BASE_URL
		def clientId = grailsApplication.config.crowdera.wepay.CLIENT_ID;
		def clientSecrete = grailsApplication.config.crowdera.wepay.CLIENT_SECRET;
		
		def originalId= getIpAddress(request)
		def device = getDeviceFromRequestHeader(request);
		
		def acceptanceTime = System.currentTimeMillis();
		def scope = "manage_accounts,collect_payments,view_user,send_money,preapprove_payments";
		def url = wepayBaseUrl+"/user/register"
		HttpClient httpclient = new DefaultHttpClient()
		HttpPost httppost = new HttpPost(url)
		
		// Ref#CIT615829206695 Ref#CIT61153280367
		StringEntity input = new StringEntity("{\"client_id\": ${clientId},\"client_secret\": \"${clientSecrete}\" ,\"email\": \"${email}\", \"scope\": \"${scope}\", \"first_name\" : \"${firstName}\",\"last_name\" : \"${lastName}\", \"original_ip\" : \"${originalId}\" , \"original_device\": \"${device}\", \"tos_acceptance_time\" : \"${acceptanceTime}\" }")
		input.setContentType("application/json")
		httppost.setEntity(input)
		
		HttpResponse httpres = httpclient.execute(httppost)
		
		def json
		int status = httpres.getStatusLine().getStatusCode()
		int wepayUserId;
		String accessToken;
		
		if (status == 200) {
			HttpEntity entity = httpres.getEntity();
			if (entity != null){
				def jsonString = EntityUtils.toString(entity)
				def slurper = new JsonSlurper()
				json = slurper.parseText(jsonString)
				
				wepayUserId = json.user_id
				accessToken = json.access_token
				/*println "result  ===== "+ json*/
			}
		}
		println "status  == "+ status
		/*'token_type':'BEARER'*/
		return [wepayUserId: wepayUserId, accessToken: accessToken, status: status]
	}
	
	
	def getWePayAccountId(String accessToken, String name, String email, Project project) {
		/*def name = "crowdfunding";
        def description = "this is a test app";*/
		
		def wepayBaseUrl = grailsApplication.config.crowdera.wepay.BASE_URL
        def url = wepayBaseUrl +"/account/create"
		String projectTitle = project.title;
		
        HttpClient httpclient = new DefaultHttpClient()
        HttpPost httppost = new HttpPost(url)
		/*STAGE_5fe2214cb89aecdb2c567d5fd58080d048cc0c5afad52a65738101beab47d94c*/
        httppost.setHeader("Authorization","Bearer "+accessToken);
		
		def receiveTime = 1367958263;
		log.info("callBackUri = "+ callBackUri)
		
		def rbits = "[{\"receive_time\": ${receiveTime}, \"type\": \"person\", \"source\": \"user\", \"properties\": {\"name\": \"${name}\"}},{\"receive_time\": ${receiveTime}, \"type\": \"email\", \"source\": \"user\", \"properties\": {\"email\": \"${email}\"}}, {\"receive_time\": ${receiveTime}, \"type\": \"phone\", \"source\": \"user\", \"properties\": {\"phone\": \"${project.beneficiary.telephone}\", \"phone_type\" : \"mobile\"}}, {\"receive_time\": ${receiveTime}, \"type\": \"fundraising_campaign\", \"source\": \"user\", \"properties\": {\"description\": \"${projectTitle}\"}}, {\"receive_time\": ${receiveTime}, \"type\": \"business_description\", \"source\": \"user\", \"properties\": {\"business_description\": \"${project.description}\"}}]";
		
        StringEntity input = new StringEntity("{\"name\": \"${name}\",\"description\": \"${projectTitle}\",\"callback_uri\": \"${callBackUri}\", \"rbits\": ${rbits}}")
        input.setContentType("application/json")
        httppost.setEntity(input)

        HttpResponse httpres = httpclient.execute(httppost)

        def json;
        int status = httpres.getStatusLine().getStatusCode();
		int accountId;

        if (status == 200) {
            /*println "status preview"*/
            HttpEntity entity = httpres.getEntity();
            if (entity != null){
                def jsonString = EntityUtils.toString(entity)
                def slurper = new JsonSlurper()
                json = slurper.parseText(jsonString)
				
				accountId = json.account_id
            }
        }
		
        return accountId;
	}
	
	
	def getWepayAccountStatus(def wepayAccountId, def accessToken) {
		
		try {
			def wepayBaseUrl = grailsApplication.config.crowdera.wepay.BASE_URL
			def httpUrl = wepayBaseUrl +"/account"
			
			HttpClient httpclient = new DefaultHttpClient()
			
			HttpClient httpClient = new DefaultHttpClient()
			HttpPost httppost = new HttpPost(httpUrl)
			
			httppost.setHeader("Authorization","Bearer "+accessToken);
			
			StringEntity input = new StringEntity("{\"account_id\": ${wepayAccountId}}")
			input.setContentType("application/json")
			httppost.setEntity(input)
			HttpResponse httpResponse = httpClient.execute(httppost)
			
			def status = httpResponse.getStatusLine().getStatusCode()
			def json; def state;
			
			if (status == 200) {
				HttpEntity entity = httpResponse.getEntity();

				if (entity != null){
					def jsonString = EntityUtils.toString(entity)
					def slurper = new JsonSlurper()
					
					json = slurper.parseText(jsonString)
					state = json.state
				}
			}
			
			return state;
		} catch(Exception e) {
		}
	}
	
	
	def getWePayAuthToken(String email, String firstName, String lastName, def request) {
		def wepayBaseUrl = grailsApplication.config.crowdera.wepay.BASE_URL
		def clientId = grailsApplication.config.crowdera.wepay.CLIENT_ID
		def clientSecrete = grailsApplication.config.crowdera.wepay.CLIENT_SECRET
		
		def originalId= getIpAddress(request)
		def device = getDeviceFromRequestHeader(request);
		def acceptanceTime = System.currentTimeMillis();
		
		def scope = "manage_accounts,collect_payments,view_user,send_money,preapprove_payments";
		
		def url = wepayBaseUrl+"/user/register"
		HttpClient httpclient = new DefaultHttpClient()
		HttpPost httppost = new HttpPost(url)
		
		StringEntity input = new StringEntity("{\"client_id\": \"${clientId}\",\"client_secret\": \"${clientSecrete}\" ,\"email\": \"${email}\", \"scope\": \"${scope}\", \"first_name\" : \"${firstName}\",\"last_name\" : \"${lastName}\", \"original_ip\" : \"${originalId}\" , \"original_device\": \"${device}\", \"tos_acceptance_time\" : \"${acceptanceTime}\" }")
		input.setContentType("application/json")
		httppost.setEntity(input)

		HttpResponse httpres = httpclient.execute(httppost)
		def accessToken
		
		int status = httpres.getStatusLine().getStatusCode()
		if (status == 200){
			HttpEntity entity = httpres.getEntity()
			if (entity != null){
				def jsonString = EntityUtils.toString(entity)
				def slurper = new JsonSlurper()
				def json = slurper.parseText(jsonString)
				accessToken =json.access_token
			}
		}
		/*println"access token status == " +status
		println "access token result  == "+ accessToken*/
		
		return accessToken;
	}
	
	def confirmUser(String email, String firstName, String lastName, String accessToken, def request) {
		
		if (accessToken == null) {
			accessToken = getWePayAuthToken(email, firstName, lastName, request)
		}
		
		if (accessToken != null) {
			def wepayBaseUrl = grailsApplication.config.crowdera.wepay.BASE_URL
			
			def emailMsg = "Thank you for selecting WePay as your preferred payment method. Please confirm your account to start receiving funds and to ensure all the funds are promptly transferred to your bank account, we recommend completing the wepay account setup right away."
			def emailSubject = "WePay Account Confirmation"
			def emailButton  = "Confirm WePay Account "
			
			def url = wepayBaseUrl+"/user/send_confirmation"
			HttpClient httpclient = new DefaultHttpClient()
			HttpPost httppost = new HttpPost(url)
			
			httppost.setHeader("Authorization","Bearer ${accessToken}");
			StringEntity input = new StringEntity("{\"email_message\": \"${emailMsg}\",\"email_subject\": \"${emailSubject}\" ,\"email_button_text\": \"${emailButton}\"}")
			input.setContentType("application/json")
			httppost.setEntity(input)
			HttpResponse httpres = httpclient.execute(httppost)
			
			def json
			int status = httpres.getStatusLine().getStatusCode()
			
			if (status == 200) {
				
				HttpEntity entity = httpres.getEntity();
				if (entity != null){
					def jsonString = EntityUtils.toString(entity)
					def slurper = new JsonSlurper()
					json = slurper.parseText(jsonString)
				/*println "result  ===== "+ json*/
				}
			}
			return [state: json?.state, userId: json?.user_id]
		} else {
			return -99;
		}
	}
	
	
	def chargeWepayCard(Project project, def creditCardId, def amount, def feePayer, def appFee, def params) {
		
		def wepayBaseUrl = grailsApplication.config.crowdera.wepay.BASE_URL
		def account_id = project.wepayAccountId;
		def short_description= "Crowdfunding"
		def type = "donation"
		def currency = "USD"
		
		def creditCard = "{\"id\": ${creditCardId}}"
		def payment_method = "{\"type\" : \"credit_card\", \"credit_card\": ${creditCard}}"
		def feeStructure = "{\"app_fee\": ${appFee}, \"fee_payer\" : \"${feePayer}\"}"
		
		def url = wepayBaseUrl+"/checkout/create"
		HttpClient httpclient = new DefaultHttpClient()
		HttpPost httppost = new HttpPost(url)
		
		log.info("Checkout callBackUri = "+ callBackUri)
		
		// npo_information -- Information Structure  If the payee is a non profit entity, 
		// the structure contains information about non profit organization. Otherwise, this is null
		def receiveTime = System.currentTimeMillis();
		def payerRbits = "[{\"receive_time\": ${receiveTime}, \"type\": \"phone\", \"source\": \"user\", \"properties\": {\"phone\": \"${params.mobileNumber}\"}}, {\"receive_time\": ${receiveTime}, \"type\": \"email\",\"source\": \"user\",\"properties\": {\"email\": \"${params.contributorEmail}\"}}, {\"receive_time\":${receiveTime},\"type\":\"person\",\"source\":\"user\",\"properties\":{\"name\":\"${params.contributorName}\"}}, {\"receive_time\": ${receiveTime},\"type\": \"address\",\"source\": \"user\",\"properties\": {\"address\": {\"address1\": \"${params.address1}\",\"address2\": \"${params.address2}\",\"city\": \"${params.city}\",\"state\": \"${params.state}\",\"zip\": \"${params.zip}\",\"country\": \"${params.country}\"} }}]"
		
		String stringEntity = "{\"account_id\": ${account_id},\"short_description\": \"${short_description}\" ,\"type\": \"${type}\", \"amount\": \"${amount}\", \"currency\" : \"${currency}\", \"auto_release\" : true, \"payment_method\" : ${payment_method}, \"unique_id\" : \"${params.uniqueId}\", \"fee\": ${feeStructure}, \"callback_uri\": \"${callBackUri}\", \"payer_rbits\" : ${payerRbits}}"
 		
		httppost.setHeader("Authorization","Bearer "+ project.wepayAccessToken);
		StringEntity input = new StringEntity(stringEntity)
		input.setContentType("application/json")
		httppost.setEntity(input)
		
		HttpResponse httpres = httpclient.execute(httppost)
		
		def json
		int status = httpres.getStatusLine().getStatusCode()
		int checkoutId;
		
		if (status == 200) {
		    HttpEntity entity = httpres.getEntity();
			if (entity != null){
		        def jsonString = EntityUtils.toString(entity)
		        def slurper = new JsonSlurper()
		       
				json = slurper.parseText(jsonString)
				println "json == "+ json
				checkoutId = json.checkout_id
		    }
		}
	    
		log.info("Transaction status = "+status)
		return [checkoutId : checkoutId, status : status]
	}
	
	
	def getWepayTransactionDetails(def transactionId, def request, def session, def fundraiser) {
		def amount    = session.getAttribute('contributionAmount')
		
		def emailId   = session.getAttribute('shippingEmail')
		def twitter   = session.getAttribute('twitterHandle')
		def custom    = session.getAttribute('shippingCustom')
		def userId    = session.getAttribute('tempValue')
		def anonymous = session.getAttribute('anonymous')
		def address   = session.getAttribute('address')
		def fr        = session.getAttribute('fr')
		
		Project project  = Project.get(session.getAttribute('campaignId'))
		Reward reward    = rewardService.getRewardById(session.getAttribute('rewardId'));
		User contributor = userService.getUserForContributors(request.getParameter('contributorEmail') , session.getAttribute('userId'))
		
		if (contributor == null) {
			contributor = userService.getUserByUsername('anonymous@example.com')
		}
		
		def shippingDetail = projectService.checkShippingDetail(emailId,twitter,address, custom)
		def name
		def username

		if (userId == null || userId == 'null' || userId.isAllWhitespace()) {
			name = request.getParameter("contributorFirstName") +" "+ request.getParameter("contributorLastName");
			username = request.getParameter('contributorEmail')
		} else {
			def orgUser = User.get(userId)
			name = orgUser.firstName + " " + orgUser.lastName
			username = orgUser.email
		}
		
		Contribution contribution = new Contribution(
			date             : new Date(),
			user             : contributor,
			reward           : reward,
			amount           : amount,
			email            : shippingDetail.emailid,
			twitterHandle    : shippingDetail.twitter,
			custom           : shippingDetail.custom,
			contributorName  : name,
			contributorEmail : username,
			physicalAddress  : shippingDetail.address,
			currency         : 'USD'
		)
		
		project.addToContributions(contribution).save(failOnError: true)
		 
		Team team = Team.findByUserAndProject(fundraiser,project)
		if (team) {
			contribution.fundRaiser = fundraiser.username
			team.addToContributions(contribution).save(failOnError: true)
		}
		def country_code = project.country.countryCode
		contribution.isAnonymous = anonymous.toBoolean()
		
		if (project.payuStatus && project.contributions.size() == 1) {
			mandrillService.sendEmailToCampaignOwner(project, contribution,country_code) //Send Email to Campaign Owner when first contribution is done for INR
		}
		 
		userService.contributionEmailToOwnerOrTeam(fundraiser, project, contribution)
		
		def totalContribution = contributionService.getTotalContributionForProject(project)
		
		if (totalContribution >= project.amount) {
			
			if(project.send_mail == false) {
				List contributorEmails = []
				def contributors = contributionService.getTotalContributors(project)
				contributors.each {
					def user = User.get(it)
					if (user.email != 'anonymous@example.com' && !contributorEmails.contains(user.email)) {
						contributorEmails.add(user.email)
						mandrillService.sendContributorEmail(user, project)
					}
				}
				
				def beneficiaryId = projectService.getBeneficiaryId(project)
				def beneficiary = Beneficiary.get(beneficiaryId)
				def user = User.findByEmail(beneficiary.email)
				
				if (user) {
					mandrillService.sendBeneficiaryEmail(user, projectService.getCountryCodeForCurrentEnv(request))
				}
				project.send_mail = true
			}
			
		}
		
		
		// In case of Wepay unique checkout Id will saved as transaction Id
		Transaction transaction = new Transaction(
			transactionId: transactionId,
			user         : contributor,
			project      : project,
			contribution : contribution,
			currency     : 'USD'
		)
		
		transaction.save(failOnError: true)
		return contribution.id
	}
	
}
