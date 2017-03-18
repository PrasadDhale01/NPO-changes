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
	
}
