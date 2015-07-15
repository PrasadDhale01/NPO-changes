package crowdera

import grails.plugin.springsecurity.annotation.Secured

import org.apache.poi.ss.usermodel.WorkbookFactory
import org.apache.poi.ss.usermodel.Workbook
import org.springframework.web.multipart.MultipartHttpServletRequest
import org.springframework.web.multipart.commons.CommonsMultipartFile

import groovy.json.JsonSlurper
import org.apache.http.HttpEntity
import org.apache.http.HttpResponse
import org.apache.http.client.HttpClient
import org.apache.http.client.methods.HttpPost
import org.apache.http.entity.StringEntity
import org.apache.http.impl.client.DefaultHttpClient
import org.apache.http.util.EntityUtils
import org.codehaus.groovy.grails.web.json.JSONObject

class ProjectController {
	def userService
	def excelImportService
	def rewardService
	def projectService
	def mandrillService
	def contributionService

	def FORMCONSTANTS = [
		/* Beneficiary */
		FIRSTNAME: 'firstName',
		LASTNAME: 'lastName',
		EMAIL: 'email',
		TELEPHONE: 'telephone',
		GENDER: 'gender',
		ADDRESSLINE1: 'addressLine1',
		ADDRESSLINE2: 'addressLine2',
		CITY: 'city',
		STATEORPROVINCE: 'stateOrProvince',
		POSTALCODE: 'postalCode',
		COUNTRY: 'country',
		CHARITABLE: 'charitableId',
		ORGANIZATIONNAME: 'organizationName',
		WEBADDRESS: 'webAddress',

		CATEGORY: 'category',
		DEFAULT_CATEGORY: Project.Category.EDUCATION,
		AMOUNT: 'amount',
		DAYS: 'days',
		TITLE: 'title',
		STORY: 'story',
		DESCRIPTION: 'description',
		THUMBNAIL: 'thumbnail',
		IMAGEURL: 'imageUrl',
		REWARDS: 'rewards',
		PROJECTSEXCEL: 'projectsExcel',
		VIDEO:'videoUrl',
		PAYPALEMAIL:'paypalEmail'
	]

	def list = {
		def projects = projectService.getValidatedProjects()
		def selectedCategory = "All Categories"
		if(projects.size<1) {
			flash.catmessage="There are no campaigns"
			render (view: 'list/index')
		}
		else {
			render (view: 'list/index', model: [projects: projects,selectedCategory: selectedCategory ])
		}
	}

	def listwidget = {
		def projects = projectService.getValidatedProjects()
		render (view: 'list/index', model: [projects: projects])
	}

	def search () {
		def query = params.q
		if(query) {
			List searchResults = projectService.search(query)
			if (searchResults.empty){
				flash.catmessage = "No Campaign found matching your input."
				redirect(action:"list")
			} else {
				searchResults.sort{x,y -> x.title<=>y.title ?: x.story<=>y.story}
				render(view: "list/index", model:[projects: searchResults])
			}
		} else {
			redirect(controller: "home", action: "index")
		}
	}

	def showCampaign() {
		def title = projectService.getVanityTitleFromId(params.id)
		def name = userService.getVanityNameFromUsername(params.fr, params.id)
		if(title && name){
			redirect (action:'show', params:['projectTitle':title,'fr':name])
		} else {
			render (view: '/error')
		}
	}

	def show() {
		def projectId
		def username
		if (params.projectTitle){
			projectId = projectService.getProjectIdFromVanityTitle(params.projectTitle)
			username = userService.getUsernameFromVanityName(params.fr)
		} else {
			projectId = params.id
			username = params.fr
		}
		Project project = projectService.getProjectById(projectId)
		if (project) {
			User user = userService.getUserByUsername(username)
			def currentUser = userService.getCurrentUser()
			def currentFundraiser = userService.getCurrentFundRaiser(user, project)
			Team currentTeam = projectService.getCurrentTeam(project,currentFundraiser)
			def totalContribution = contributionService.getTotalContributionForProject(project)
			def percentage = contributionService.getPercentageContributionForProject(totalContribution, project)

			def teamContribution = contributionService.getTotalContributionForUser(currentTeam.contributions)
			def teamPercentage = contributionService.getPercentageContributionForTeam(teamContribution, currentTeam)

			def isCrFrCampBenOrAdmin = userService.isCampaignBeneficiaryOrAdmin(project,currentFundraiser)
			def isCampaignAdmin = userService.isCampaignAdmin(project, username)
			def isEnabledTeamExist = userService.isTeamEnabled(project, currentFundraiser)
			def isCrUserCampBenOrAdmin
			def isTeamExist
			def CurrentUserTeam
			def projectComment
			def teamcomment

			List contributions = []

			if(project.user == currentTeam.user) {
				contributions = project.contributions.reverse();
			}else {
				contributions = currentTeam.contributions.reverse();
			}

			if (currentUser) {
				isCrUserCampBenOrAdmin = userService.isCampaignBeneficiaryOrAdmin(project,currentUser)
				isTeamExist = userService.isValidatedTeamExist(project, currentUser)
				CurrentUserTeam = userService.getTeamByUser(currentUser, project)
			}
			def teams = projectService.getEnabledAndValidatedTeamsForCampaign(project)

			boolean ended = projectService.isProjectDeadlineCrossed(project)
			boolean isFundingOpen = projectService.isFundingOpen(project)
			def rewards = rewardService.getSortedRewards(project);
			def day= projectService.getRemainingDay(project)
			def endDate = projectService.getProjectEndDate(project)
			def webUrl = projectService.getWebUrl(project)

			if (params.commentId) {
				projectComment = projectService.getProjectCommentById(params.long('commentId'))
			}
			if (params.teamCommentId) {
				teamcomment = projectService.getTeamCommentById(params.long('teamCommentId'))
			}

			def projectComments = projectService.getProjectComments(project)
			def teamComments = projectService.getTeamComments(currentTeam)

			render (view: 'show/index',
			model: [project: project, user: user,currentFundraiser: currentFundraiser, currentTeam: currentTeam, endDate: endDate, isCampaignAdmin: isCampaignAdmin, projectComments: projectComments,
				totalContribution: totalContribution, percentage:percentage, teamContribution: teamContribution, contributions: contributions, webUrl: webUrl, teamComments: teamComments,
				teamPercentage: teamPercentage, ended: ended, teams: teams, currentUser: currentUser, day: day, CurrentUserTeam: CurrentUserTeam, isEnabledTeamExist: isEnabledTeamExist,
				isCrUserCampBenOrAdmin: isCrUserCampBenOrAdmin, isCrFrCampBenOrAdmin: isCrFrCampBenOrAdmin, isFundingOpen: isFundingOpen, rewards: rewards, projectComment: projectComment, teamcomment: teamcomment,
				isTeamExist: isTeamExist, vanityTitle: params.projectTitle, vanityUsername: params.fr, FORMCONSTANTS: FORMCONSTANTS])
		} else {
			render (view: '/error')
		}
	}

	@Secured(['ROLE_ADMIN'])
	def validateShowCampaign(){
		def title = projectService.getVanityTitleFromId(params.id)
		def name = userService.getVanityNameFromUsername(params.fr, params.id)
		if(title && name){
			redirect (action:'validateshow', params:['projectTitle':title,'fr':name])
		}else{
			render view:"/error"
		}
	}

	@Secured(['ROLE_ADMIN'])
	def validateshow() {
		def projectId
		if (params.projectTitle){
			projectId = projectService.getProjectIdFromVanityTitle(params.projectTitle)
		} else {
			projectId = params.id
		}
		def project = projectService.getProjectById(projectId)
		if (project) {
			User user = project.user
			def currentUser = userService.getCurrentUser()
			def currentFundraiser = project.user
			def currentTeam = projectService.getCurrentTeam(project,currentFundraiser)
			def totalContribution = contributionService.getTotalContributionForProject(project)
			def percentage = contributionService.getPercentageContributionForProject(totalContribution, project)

			def teamContribution = contributionService.getTotalContributionForUser(currentTeam.contributions)
			def teamPercentage = contributionService.getPercentageContributionForTeam(teamContribution, currentTeam)

			def isCrFrCampBenOrAdmin = userService.isCampaignBeneficiaryOrAdmin(project,currentFundraiser)
			def isCrUserCampBenOrAdmin
			def isTeamExist
			if (currentUser) {
				isCrUserCampBenOrAdmin = userService.isCampaignBeneficiaryOrAdmin(project,currentUser)
				isTeamExist = userService.isValidatedTeamExist(project, currentUser)
			}
			def teams = projectService.getEnabledAndValidatedTeamsForCampaign(project)

			boolean ended = projectService.isProjectDeadlineCrossed(project)
			boolean isFundingOpen = projectService.isFundingOpen(project)
			def rewards = rewardService.getSortedRewards(project);
			def day= projectService.getRemainingDay(project)
			def endDate = projectService.getProjectEndDate(project)
			def webUrl = projectService.getWebUrl(project)
			def validatedPage = true
			def projectComments = projectService.getProjectComments(project)
			def teamComments = projectService.getTeamComments(currentTeam)

			if(project.validated == false) {

				render (view: 'validate/validateshow',
				model: [project: project, user: user,currentFundraiser: currentFundraiser, currentTeam: currentTeam, endDate: endDate,projectComments: projectComments,
					totalContribution: totalContribution, percentage:percentage, teamContribution: teamContribution, webUrl: webUrl, teamComments: teamComments,
					teamPercentage: teamPercentage, ended: ended, teams: teams, currentUser: currentUser, day: day,
					isCrUserCampBenOrAdmin: isCrUserCampBenOrAdmin, isCrFrCampBenOrAdmin: isCrFrCampBenOrAdmin, isFundingOpen: isFundingOpen, rewards: rewards,
					validatedPage: validatedPage, isTeamExist: isTeamExist, FORMCONSTANTS: FORMCONSTANTS])
			}
		} else {
			render (view: '/error')
		}
	}

	@Secured(['ROLE_ADMIN'])
	def updateValidation() {
		if (params.id) {
			projectService.getUpdateValidationDetails(params)
		}
		flash.prj_validate_message= "Campaign validated successfully"
		redirect (action:'validateList')
	}

	@Secured(['ROLE_ADMIN'])
	def delete() {
		def project = projectService.getProjectById(params.id)
		if (project) {
			project.rejected = true
			flash.prj_validate_message= "Campaign discarded successfully"
			redirect (action:'validateList')
		} else {
			flash.prj_validate_err_message = 'Campaign Not Found'
			render (view: 'validate/validateerror', model: [project: project])
		}
	}

	@Secured(['IS_AUTHENTICATED_FULLY'])
	def deleteProjectImage(){
		def imageUrlId = projectService.getImageUrlById(request.getParameter("imgst"))
		def projectId = projectService.getProjectById(request.getParameter("projectId"))
		List imageUrl = projectId.imageUrl
		imageUrl.remove(imageUrlId)
		imageUrlId.delete()
		render ''
	}

	@Secured(['IS_AUTHENTICATED_FULLY'])
	def deleteTeamImage(){
		def imageUrlId = projectService.getImageUrlById(request.getParameter("imgst"))
		def teamId = projectService.getTeamById(request.getParameter("teamId"))
		List imageUrl = teamId.imageUrl
		imageUrl.remove(imageUrlId)
		imageUrlId.delete()
		render ''
	}

	@Secured(['IS_AUTHENTICATED_FULLY'])
	def deleteOrganizationLogo(){
		def projectId = projectService.getProjectById(request.getParameter("projectId"))
		projectId.organizationIconUrl=null
		render ''
	}

	@Secured(['IS_AUTHENTICATED_FULLY'])
	def deleteCampaignAdmin(){
		def project = projectService.getProjectById(request.getParameter("projectId"))
		def username = request.getParameter("username")
		def projectAdmin = projectService.getProjectAdminByEmail(username)
		def projectAdmins = project.projectAdmins
		projectAdmins.remove(projectAdmin);
		projectAdmin.delete()
		render ''
	}

	@Secured(['IS_AUTHENTICATED_FULLY'])
	def validate() {
		Project project = projectService.getProjectById(params.id)
		if (project) {
			if(project.validated == true){
				redirect (action:'showCampaign', id:project.id)
			} else {
				render (view: 'validate/validateerror', model: [projects: project])
			}
		}
	}

	@Secured(['IS_AUTHENTICATED_FULLY'])
	def saveasdraft(){
		def project = projectService.getProjectById(params.id)
		def title = projectService.getVanityTitleFromId(params.id)
		if(project.draft) {
			project.draft = false
			flash.prj_mngprj_message="Campaign has been submitted for approval."
			redirect(action:'manageproject', params:['projectTitle':title])
		} else {
			flash.prj_mngprj_message="This Campaign has already been submitted for approval, and under review."
			redirect(action:'manageproject', params:['projectTitle':title])
		}
	}

	@Secured(['ROLE_ADMIN'])
	def validateList() {
		def projects = projectService.getNonValidatedProjects()
		render(view: 'validate/index', model: [projects: projects])
	}

	@Secured(['IS_AUTHENTICATED_FULLY'])
	def savecomment() {
		def title = projectService.getVanityTitleFromId(params.id)
		def name = userService.getVanityNameFromUsername(params.fr, params.id)
		if (params.id) {
			projectService.getCommentsDetails(params)
		} else {
			flash.sentmessage = "Something went wrong saving comment. Please try again later."
		}
		redirect (action: 'show', params:['projectTitle':title,'fr':name], fragment: 'comments')
	}

	@Secured(['IS_AUTHENTICATED_FULLY'])
	def updatecomment(){
		def checkid= request.getParameter('checkID')
		def proComment = projectService.getProjectCommentById(checkid)
		def status = request.getParameter('status')
		if(status=='false'){
			proComment.status=false
		}else{
			proComment.status=true
		}
		render ""
	}

	@Secured(['IS_AUTHENTICATED_FULLY'])
	def create() {
		def categoryOptions = projectService.getCategoryList()
		def country = projectService.getCountry()
		def state = projectService.getState()

		def genderOptions = [
			"MALE": (Beneficiary.Gender.MALE),
			"FEMALE": (Beneficiary.Gender.FEMALE),
			"UNSPECIFIED": (Beneficiary.Gender.UNSPECIFIED)
		]

		def rewardOptions = [:]
		def rewards = rewardService.getNonObsoleteRewards()
		rewards.each {
			rewardOptions.put(it.id, it)
		}

		render (view: 'create/index',
		model: [categoryOptions: categoryOptions,
			rewardOptions: rewardOptions,
			genderOptions: genderOptions,
			FORMCONSTANTS: FORMCONSTANTS,
			country:country,
			state:state])
	}

	@Secured(['IS_AUTHENTICATED_FULLY'])
	def editCampaign(){
		def title = projectService.getVanityTitleFromId(params.id)
		if(title){
			redirect (action : 'edit', params:['projectTitle':title])
		}else{
			render view:'/error'
		}
	}

	@Secured(['IS_AUTHENTICATED_FULLY'])
	def edit() {
		def project = projectService.getProjectFromVanityTitle(params.projectTitle)
		def categoryOptions = projectService.getCategoryList()
		if (project) {
			def beneficiary = project.beneficiary
			render (view: 'edit/index',
			model: [project: project,
				beneficiary: beneficiary,
				categoryOptions: categoryOptions,
				FORMCONSTANTS: FORMCONSTANTS])
		} else {
			flash.prj_edit_message = "Campaign not found."
			render (view: 'edit/editerror')
			return
		}
	}

	@Secured(['IS_AUTHENTICATED_FULLY'])
	def update() {
		def project = projectService.getProjectById(params.projectId)
		User user = userService.getCurrentUser()
		def title = projectService.getVanityTitleFromId(params.projectId)
		if(project) {
			def vanityTitle = projectService.getProjectUpdateDetails(params, request, project,user)
			flash.prj_mngprj_message = "Successfully saved the changes"
			if (vanityTitle){
				redirect (action: 'manageproject', params:['projectTitle':vanityTitle])
			}else{
				redirect (action: 'manageproject', params:['projectTitle':title])
			}
		} else {
			flash.prj_edit_message = "Campaign not found."
			render (view: 'edit/editerror')
			return
		}
	}

	@Secured(['ROLE_ADMIN'])
	def importprojects() {
		render view: 'import/index'
	}

	static Map CONFIG_BOOK_COLUMN_MAP = [
		sheet: 'Sheet1',
		startRow: 1,
		columnMap:  [
			'A': 'createdDate',
			'B': 'amount',
			'C': 'days',
			'D': 'description',
			'E': 'fundRaisingFor',
			'F': 'category',
			'G': 'title',
			'H': 'story',
			'I': 'validated',
			'J': 'imageUrl',
			'K': 'createdBy',
			'L': 'firstName',
			'M': 'lastName',
			'N': 'email',
			'O': 'telephone',
			'P': 'gender',
			'Q': 'addressLine1',
			'R': 'addressLine2',
			'S': 'city',
			'T': 'stateOrProvince',
			'U': 'postalCode',
			'V': 'country',
		]
	]

	@Secured(['ROLE_ADMIN'])
	def bulkimport() {
		MultipartHttpServletRequest multipartRequest = request
		CommonsMultipartFile projectSpreadsheet = multipartRequest.getFile(FORMCONSTANTS.PROJECTSEXCEL)

		if (projectSpreadsheet.isEmpty()) {
			flash.prj_import_message = "Please choose a file and try again."
			redirect(action: 'importprojects')
			return
		}

		List projectParamsList
		try {
			Workbook workbook = WorkbookFactory.create(projectSpreadsheet.getInputStream())
			projectParamsList = excelImportService.columns(workbook, CONFIG_BOOK_COLUMN_MAP)
		} catch (Exception e) {
			flash.prj_import_message = "Error while importing file: " + e.getMessage()
			redirect(action: 'importprojects')
			return
		}

		/* Collect all the successfully created projects. */
		def projects = []

		projectParamsList.each { Map projectParams ->

			User createdBy = userService.getUserByUsername(projectParams.createdBy)
			if (!createdBy) {
				flash.projecterror = [
					'title': projectParams.title,
					'error': "Couldn't find user with email: " + projectParams.createdBy
				]
				render (view: 'import/importerror')
				return
			}

			Project project = projectService.getProjectByParams(projectParams)
			if (project.hasErrors()) {
				flash.projecterror = [
					'title': projectParams.title,
					'error': "Error mapping project: " + project.errors.toString()
				]
				redirect(action: 'importprojects')
				return
			}

			Beneficiary beneficiary = userService.getBeneficiaryByParams(projectParams)
			if (beneficiary.hasErrors()) {
				flash.projecterror = [
					'title': projectParams.title,
					'error': "Error mapping beneficiary: " + beneficiary.errors.toString()
				]
				redirect(action: 'importprojects')
				return
			}

			project.beneficiary = beneficiary
			project.user = createdBy

			try {
				project.created = projectParams.createdDate.toDate()
			} catch (Exception e) {
				flash.projecterror = [
					'title': projectParams.title,
					'error': "Error with createdDate: " + e.getMessage()
				]
				redirect(action: 'importprojects')
				return
			}


			if (project.validate()) {
				projects.add(project)
			} else {
				flash.projecterror = [
					'title': projectParams.title,
					'error': "Error validating project: " + project.errors.toString()
				]
				redirect(action: 'importprojects')
				return
			}
		}

		if (!projects.isEmpty()) {
			projects.each { Project project ->
				if (!project.save()) {
					flash.projecterror = [
						'title': project.title,
						'error': "Error while saving: " + project.errors.toString(),
						'note': "None of the Campaigns after this one would be imported."
					]
					redirect(action: 'importprojects')
					return
				}
			}

			flash.prj_import_message = "All Campaigns successfully imported"
			redirect(action: 'importprojects')
			return
		} else {
			flash.projecterror = "Nothing to import. Please make sure the file contains some valid rows."
			render (view: 'import/importerror')
			return
		}
	}

	def VALID_IMG_TYPES = ['image/png', 'image/jpeg']

	@Secured(['IS_AUTHENTICATED_FULLY'])
	def invalidateSession() {
		def status =request.getParameter("status")
		if(status==true)
			session.invalidate()
		render " "
	}


	@Secured(['IS_AUTHENTICATED_FULLY'])
	def save() {
		Project project
		Beneficiary beneficiary
		User user = userService.getCurrentUser()
		project = projectService.getProjectByParams(params)
		beneficiary = userService.getBeneficiaryByParams(params)
		def amount=project.amount
		def boolPerk=false

		def button = params.isSubmitButton
		if(button == 'true'){
			project.draft = true
		}

		if(params.(FORMCONSTANTS.COUNTRY) != "US"){
			beneficiary.stateOrProvince = params.otherstate
		}

		def rewardLength=Integer.parseInt(params.rewardCount)
		if(rewardLength >= 1) {
			def rewardTitle = new Object[rewardLength]
			def rewardPrice = new Object[rewardLength]
			def rewardDescription = new Object[rewardLength]
			def mailingAddress = new Object[rewardLength]
			def emailAddress = new Object[rewardLength]
			def twitter = new Object[rewardLength]
			def custom = new Object[rewardLength]

			for(def icount=0; icount< rewardLength; icount++){
				rewardTitle[icount] = params.("rewardTitle"+ (icount+1))
				rewardPrice[icount] = params.("rewardPrice"+(icount+1))
				rewardDescription[icount] = params.("rewardDescription"+(icount+1))
				mailingAddress[icount] = params.("mailingAddress"+(icount+1))
				emailAddress[icount] = params.("emailAddress"+(icount+1))
				twitter[icount] = params.("twitter"+(icount+1))
				custom[icount] = params.("custom"+(icount+1))
				if(rewardPrice[icount]==null || Double.parseDouble(rewardPrice[icount])>amount){
					boolPerk=true;
				}
				if(mailingAddress[icount]==null && emailAddress[icount]==null && twitter[icount]==null && custom[icount]==null){
					emailAddress[icount]=true
				}
			}
			if(boolPerk==true){
				flash.prj_mngprj_message = "Enter a perk price less than Campaign amount: ${amount}"
				render (view: 'manageproject/error')
				return
			}else{
				rewardService.getMultipleRewards(project, rewardTitle, rewardPrice, rewardDescription, mailingAddress, emailAddress, twitter, custom)
			}
		}

		def iconFile = request.getFile('iconfile')
		if(!iconFile.isEmpty()) {
			def uploadedFileUrl = projectService.getorganizationIconUrl(iconFile)
			project.organizationIconUrl = uploadedFileUrl
		}

		def imageFiles = request.getFiles('thumbnail[]')
		if(!imageFiles.isEmpty()) {
			projectService.getMultipleImageUrls(imageFiles, project)
		}

		String email1 = params.email1
		String email2 = params.email2
		String email3 = params.email3

		project.user = user

		def days = params.days
		projectService.getNumberofDays(days, project)

		project.beneficiary = beneficiary

		if (project.save()) {
			projectService.getYoutubeUrlChanged(params.videoUrl, project)
			projectService.getFundRaisersForTeam(project, user)
			projectService.getdefaultAdmin(project, user)
			projectService.getAdminForProjects(email1, project, user)
			projectService.getAdminForProjects(email2, project, user)
			projectService.getAdminForProjects(email3, project, user)
			def projectTitle = projectService.getProjectVanityTitle(project)
			userService.getProjectVanityUsername(user)

			if(button == 'true') {
				redirect(action:'draftProject', params:['projectTitle': projectTitle])
			} else {
				redirect(action:'saveProject', params:['projectTitle': projectTitle])
			}
		} else {
			render (view: 'create/createerror', model: [project: project])
		}
	}

	def draftProject() {
		def project = projectService.getProjectFromVanityTitle(params.projectTitle)
		render (view: 'create/saveasdraft', model: [project: project])
	}

	@Secured(['IS_AUTHENTICATED_FULLY'])
	def saveProject() {
		def project = projectService.getProjectFromVanityTitle(params.projectTitle)
		render (view: 'create/justcreated', model: [project: project])
	}

	@Secured(['IS_AUTHENTICATED_FULLY'])
	def manageCampaign(){
		def title = projectService.getVanityTitleFromId(params.id)
		if(title){
			redirect (action:'manageproject', params:['projectTitle':title])
		}else{
			render view:'/error'
		}
	}

    @Secured(['IS_AUTHENTICATED_FULLY'])
    def manageproject() {
        def projectId = projectService.getProjectIdFromVanityTitle(params.projectTitle)
        Project project = projectService.getProjectById(projectId)
        User user = userService.getCurrentUser()
        if (project) {
            def isCampaignOwnerOrAdmin = userService.isCampaignBeneficiaryOrAdmin(project, user)
            def totalContribution = contributionService.getTotalContributionForProject(project)

            def projectimages = projectService.getProjectImageLinks(project)
            def validatedTeam = projectService.getValidatedTeam(project)
            def unValidatedTeam = projectService.getTeamToBeValidated(project)
            def discardedTeam = projectService.getDiscardedTeams(project)
            boolean ended = projectService.isProjectDeadlineCrossed(project)
            boolean isFundingOpen = projectService.isFundingOpen(project)
            def rewards = rewardService.getSortedRewards(project);
            def endDate = projectService.getProjectEndDate(project)
            def isCampaignAdmin = userService.isCampaignAdmin(project, user.username)
            def percentage = contributionService.getPercentageContributionForProject(totalContribution, project)
            Team currentTeam = projectService.getCurrentTeam(project,user)
            def isCrFrCampBenOrAdmin = isCampaignOwnerOrAdmin
            def webUrl = projectService.getWebUrl(project)
            def isEnabledTeamExist = userService.isTeamEnabled(project, user)

            if(project.user==user || isCampaignOwnerOrAdmin){
                render (view: 'manageproject/index',
                        model: [project: project, isCampaignOwnerOrAdmin: isCampaignOwnerOrAdmin, validatedTeam: validatedTeam, percentage: percentage, currentTeam: currentTeam,
                                discardedTeam : discardedTeam, totalContribution: totalContribution, projectimages: projectimages,isCampaignAdmin: isCampaignAdmin, webUrl: webUrl,
                                ended: ended, isFundingOpen: isFundingOpen, rewards: rewards, endDate: endDate, user : user, isCrFrCampBenOrAdmin: isCrFrCampBenOrAdmin,isEnabledTeamExist: isEnabledTeamExist,
                                unValidatedTeam: unValidatedTeam, vanityTitle: params.projectTitle, FORMCONSTANTS: FORMCONSTANTS])
            } else{
                flash.prj_mngprj_message = 'Campaign Not Found'
                render (view: 'manageproject/error', model: [project: project])
            }
        } else {
        render (view: '/error')
    }
}

	@Secured(['IS_AUTHENTICATED_FULLY'])
	def projectdelete() {
		def project = projectService.getProjectById(params.id)
		if (project) {
			project.inactive = true
			flash.user_message= "Campaign Discarded Successfully"
			redirect (action:'myproject' , controller:'user')
		} else {
			flash.prj_mngprj_message = 'Campaign Not Found'
			render (view: 'manageproject/error', model: [project: project])
		}
	}

	@Secured(['IS_AUTHENTICATED_FULLY'])
	def customrewardsave() {
		def reward = rewardService.getRewardByParams(params)
		RewardShipping shippingInfo = new RewardShipping(params)
		def title = projectService.getVanityTitleFromId(params.id)

		if(reward.save()) {
			def project= projectService.getProjectById(params.id)
			shippingInfo.reward = reward
			shippingInfo.save(failOnError: true)
			project.addToRewards(reward)
			reward.obsolete = true
			flash.prj_mngprj_message = 'Successfully created a new perk'
			redirect(controller: 'project', action: 'manageproject',fragment: 'rewards', params:['projectTitle':title])
		} else {
			render (view: 'manageproject/error', model: [reward: reward])
		}
	}

	def sendemail() {
		def fundRaiser = params.fr
		projectService.shareCampaignOrTeamByEmail(params,fundRaiser)
		flash.prj_mngprj_message= "Email sent successfully."
		if (params.ismanagepage) {
			redirect(controller: 'project', action: 'manageproject', params:['projectTitle': params.vanityTitle])
		} else {
			redirect (action: 'show', params:[fr: params.vanityUsername, 'projectTitle': params.vanityTitle])
		}
	}

	@Secured(['IS_AUTHENTICATED_FULLY'])
	def projectupdate() {
		def projectId = projectService.getProjectIdFromVanityTitle(params.projectTitle)
		def project = projectService.getProjectById(projectId)
		def currentUser =userService.getCurrentUser()
		def isCampaignOwnerOrAdmin = userService.isCampaignBeneficiaryOrAdmin(project,currentUser)
		if(project) {
			if(!isCampaignOwnerOrAdmin){
				render view:"manageproject/error", model: [project: project]
			}else{
				render (view: 'update/index', model: [project: project, FORMCONSTANTS: FORMCONSTANTS])
			}
		} else {
			render (view: 'manageproject/error', model: [project: project])
		}
	}

	@Secured(['IS_AUTHENTICATED_FULLY'])
	def editCampaignUpdate(){
		def title = projectService.getVanityTitleFromId(params.projectId)
		if(title){
			redirect (action : 'editUpdate', id:params.id, params:['projectTitle':title])
		}else{
			render view:'/error'
		}
	}

	@Secured(['IS_AUTHENTICATED_FULLY'])
	def editUpdate() {
		def projectUpdate = projectService.getProjectUpdateById(params.id)
		def project = projectService.getProjectFromVanityTitle(params.projectTitle)
		def projectUpdates = project.projectUpdates
		if (projectUpdates.contains(projectUpdate)) {
			flash.editUpdateSuccessMsg = "Campaign Update Edited Successfully"
			render (view:'editupdate/index', model:[projectUpdate: projectUpdate, project: project, FORMCONSTANTS: FORMCONSTANTS])
		} else {
			render (view: 'manageproject/error')
		}
	}

	@Secured(['IS_AUTHENTICATED_FULLY'])
	def saveEditUpdate() {
		def project = projectService.getProjectById(params.projectId)
		def imageFiles = request.getFiles('thumbnail[]')
		projectService.editCampaignUpdates(params, project, imageFiles)
		def title = projectService.getVanityTitleFromId(params.projectId)

		flash.saveEditUpdateSuccessMsg = "Campaign Update Edited Successfully!"
		redirect(controller: 'project', action: 'manageproject', params:['projectTitle':title], fragment: 'projectupdates')
	}

	@Secured(['IS_AUTHENTICATED_FULLY'])
	def deleteProjectUpdateImage() {
		def imageUrl = ImageUrl.get(request.getParameter("imageId"))
		def projectUpdate = ProjectUpdate.get(request.getParameter("projectUpdateId"))
		List imageUrls = projectUpdate.imageUrls
		imageUrls.remove(imageUrl)
		imageUrl.delete()
		render ''
	}

	@Secured(['IS_AUTHENTICATED_FULLY'])
	def updatesave() {
		def project = projectService.getProjectById(params.id)
		def imageFiles = request.getFiles('thumbnail[]')
		def story = params.story
		def isImageFileEmpty = projectService.isImageFileEmpty(imageFiles)
		def title = projectService.getVanityTitleFromId(params.id)

		if(project ) {
			if (!isImageFileEmpty || !story.isAllWhitespace()) {

				def projectUpdate = new ProjectUpdate()
				User user = userService.getCurrentUser()

				projectUpdate.story = story
				projectService.getUpdatedImageUrls(imageFiles, projectUpdate)

				project.addToProjectUpdates(projectUpdate)
				mandrillService.sendUpdateEmailsToContributors(project,projectUpdate,user)

				flash.prj_mngprj_message= "Update added successfully."
				redirect (action: 'manageproject', controller:'project', params:['projectTitle':title], fragment: 'projectupdates')
			} else {
				flash.prj_mngprj_message= "No Updates added."
				redirect (action: 'manageproject', controller:'project', params:['projectTitle':title], fragment: 'projectupdates')
			}
		} else {
			render (view: 'manageproject/error', model: [project: project])
		}
	}

	def category (){
		def category = params.category
		redirect(action: 'categoryFilter', controller:'project',params:[category: category])
	}

	def categoryFilter() {
		def category = params.category
		def project
		if (category == "Social Innovation"){
			project = projectService.filterByCategory("SOCIAL_INNOVATION")
		} else if (category == "All Categories"){
			project = projectService.filterByCategory("All")
		} else {
			project = projectService.filterByCategory(category)
		}
		if(!project){
			flash.catmessage="No campaign found."
			render (view: 'list/index', model: [projects: project,selectedCategory:category])
		}else{
			flash.catmessage=""
			render (view: 'list/index', model: [projects: project,selectedCategory:category])
		}
	}

	@Secured(['IS_AUTHENTICATED_FULLY'])
	def addFundRaiser(){
		def project = projectService.getProjectById(params.id)
		User user = userService.getCurrentUser()
		def fundraiser = project.user.username
		def iscampaignAdmin = userService.isCampaignBeneficiaryOrAdmin(project, user)
		def message = projectService.getFundRaisersForTeam(project, user)
		def title = projectService.getVanityTitleFromId(params.id)
		def name = userService.getVanityNameFromUsername(fundraiser, params.id)

		if (iscampaignAdmin) {
			flash.prj_mngprj_message = message
			redirect (action: 'manageproject', params:['projectTitle':title])
		} else {
			flash.prj_mngprj_message = message
			redirect (action: 'show', params:['projectTitle':title,'fr':name])
		}
	}

	@Secured(['IS_AUTHENTICATED_FULLY'])
	def inviteTeamMember() {
		def project = projectService.getProjectById(params.id)
		String emails = params.emailIds
		String name = params.username
		String message = params.teammessage
		User user = userService.getCurrentUser()
		def fundraiser =user.username
		def title = projectService.getVanityTitleFromId(params.id)
		def username = userService.getVanityNameFromUsername(fundraiser, params.id)

		if (params.ismanagepage) {
			sendEmailToTeam(emails, name, message, project)
			redirect (action: 'manageproject', params:['projectTitle':title], fragment: 'manageTeam')
		} else {
			sendEmailToTeam(emails, name, message, project)
			redirect (action: 'show', params:['projectTitle':title,'fr':username], fragment: 'manageTeam')
		}
	}

	@Secured(['IS_AUTHENTICATED_FULLY'])
	def editFundraiser(){
		def team = projectService.getTeamById(params.long('id'))
		def fundRaiser = team.user.username
		def title = projectService.getVanityTitleFromId(params.project)
		def username = userService.getVanityNameFromUsername(fundRaiser, params.project)
		if(params) {
			def message = projectService.getEditedFundraiserDetails(params, team, request)
			flash.teamUpdatemessage = message
		}
		redirect (action: 'show', params:['projectTitle':title,'fr':username], fragment: 'manageTeam')
	}

	@Secured(['IS_AUTHENTICATED_FULLY'])
	def sendEmailToTeam(def emails, def name, def message, Project project){
		def emailList = emails.split(',')
		emailList = emailList.collect { it.trim() }
		mandrillService.sendInvitationForTeam(emailList, name, message, project)
		flash.prj_mngprj_message= "Email sent successfully."
	}

	@Secured(['IS_AUTHENTICATED_FULLY'])
	def saveteamcomment() {
		def message = projectService.getTeamCommentsDetails(params)
		def title = projectService.getVanityTitleFromId(params.id)
		def username = userService.getVanityNameFromUsername(params.fr, params.id)
		flash.prj_mngprj_message = message

		if (!params.ismanagepage) {
			redirect (action: 'show', params:['projectTitle':title,'fr':username], fragment: 'comments')
		} else {
			redirect (action: 'manageproject', params:['projectTitle':title], fragment: 'manageTeam')
		}
	}

	@Secured(['IS_AUTHENTICATED_FULLY'])
	def enableOrDisableTeam() {
		def teamId= request.getParameter('teamId')
		def team = projectService.getTeamById(teamId)
		if(team.enable){
			team.enable = false
		}else{
			team.enable = true
		}
		render ""
	}

	@Secured(['IS_AUTHENTICATED_FULLY'])
	def deletecustomrewards() {
		def reward = rewardService.getRewardById(params.long('id'))
		def project = projectService.getProjectById(params.projectId)
		def shippingInfo = RewardShipping.findByReward(reward)
		def title = projectService.getVanityTitleFromId(params.projectId)
		if(reward){
			project.rewards.remove(reward)
			shippingInfo.reward = null
			shippingInfo.delete()
			reward.delete()
			flash.prj_mngprj_message = 'Successfully deleted a Perk'
		}
		redirect(controller: 'project', action: 'manageproject',fragment: 'rewards', params:['projectTitle':title])
	}

	@Secured(['IS_AUTHENTICATED_FULLY'])
	def contributiondelete() {
		projectService.getContributionDeleteDetails(params)

		if (params.manageCampaign) {
			redirect(controller: 'project', action: 'manageCampaign',fragment: 'contributions', id: params.projectId)
		} else {
			redirect (controller: 'project', action: 'showCampaign',fragment: 'contributions', id: params.projectId, params:[fr: params.fr])
		}
	}

	@Secured(['IS_AUTHENTICATED_FULLY'])
	def commentdelete() {
		projectService.getCommentDeletedDetails(params)
		if (params.manageCampaign) {
			redirect(controller: 'project', action: 'manageCampaign',fragment: 'comments', id: params.projectId)
		} else {
			redirect (controller: 'project', action: 'showCampaign',fragment: 'comments', id: params.projectId, params:[fr: params.fr])
		}
	}

	@Secured(['IS_AUTHENTICATED_FULLY'])
	def contributionedit() {
		projectService.getContributionEditedDetails(params)
		if (params.manageCampaign) {
			redirect(controller: 'project', action: 'manageCampaign',fragment: 'contributions', id: params.projectId)
		} else {
			redirect (controller: 'project', action: 'showCampaign',fragment: 'contributions', id: params.projectId, params:[fr: params.fr])
		}
	}

	@Secured(['IS_AUTHENTICATED_FULLY'])
	def generateCSV(){
		def result = projectService.getCSVDetails(params, response)
		render (contentType:"text/csv", text:result)
	}

	@Secured(['IS_AUTHENTICATED_FULLY'])
	def validateteam() {
		def project = projectService.getProjectById(params.id);
		def team = projectService.getTeamById(params.long('teamId'))
		def title = projectService.getVanityTitleFromId(params.id)
		team.validated = true
		mandrillService.sendTeamValidatedConfirmation(project,team.user)
		flash.teamvalidationmessage = "Team validated Successfully."
		redirect(controller: 'project', action: 'manageproject',fragment: 'manageTeam', params:['projectTitle':title])
	}

	@Secured(['IS_AUTHENTICATED_FULLY'])
	def discardteam() {
		def project = projectService.discardTeam(params)
		def title = projectService.getVanityTitleFromId(project.id)
		if(project && title){
			flash.teamdiscardedmessage = "Team Discarded Successfully."
			redirect(controller: 'project', action: 'manageproject',fragment: 'manageTeam', params:['projectTitle':title])
		}else{
			render view:'/error'
		}
	}

	def campaignsSorts(){
		def sorts = params.sorts
		redirect(action:'sortCampaign', controller: 'project',params:[query: sorts])
	}

	def sortCampaign(){
		def sorts = params.query
		def campaignsorts = projectService.isCampaignsorts(sorts)
		if(!campaignsorts){
			flash.catmessage="No campaign found."
			render (view: 'list/index', model: [projects: campaignsorts,sorts: sorts])
		}else{
			render (view: 'list/index', model: [projects: campaignsorts,sorts: sorts])
		}
	}

	@Secured(['IS_AUTHENTICATED_FULLY'])
	def customrewardedit() {
		def isPerkPriceLess = rewardService.editCustomReward(params)
		def amount = params.amount
		def title = projectService.getVanityTitleFromId(params.projectId)
		if (isPerkPriceLess) {
			flash.perkupdate = 'Perk Updated Successfully!!'
			redirect(controller: 'project', action: 'manageproject',fragment: 'rewards', params:['projectTitle':title])
		} else {
			flash.perkupdate = 'Perk price should be less than campaign amount '+amount
			redirect(controller: 'project', action: 'manageproject',fragment: 'rewards', params:['projectTitle':title])
		}
	}

	@Secured(['IS_AUTHENTICATED_FULLY'])
	def addcampaignsupporter() {
		def project = projectService.getProjectById(params.projectId)
		if (project) {
			def message = userService.getCampaignSupporter(project)
			flash.add_campaign_supporter = message

			def title = projectService.getVanityTitleFromId(params.projectId)
			def name = userService.getVanityNameFromUsername(params.fundRaiser, params.projectId)
			if(title && name){
				redirect (action:'show', params:['projectTitle':title,'fr':name])
			} else {
				render (view: '/error')
			}
		} else {
			render (view: '/error')
		}
	}

	def paypalEmailVerification (){
		def email = request.getParameter("email")
		String str
		String ack

		def BASE_URL = grailsApplication.config.crowdera.paypal.GetVerifiedStatus_URL

		HttpClient httpclient = new DefaultHttpClient()
		HttpPost httppost = new HttpPost(BASE_URL)

		httppost.setHeader("X-PAYPAL-SECURITY-USERID","${grailsApplication.config.crowdera.paypal.X_PAYPAL_SECURITY_USERID}")
		httppost.setHeader("X-PAYPAL-SECURITY-PASSWORD","${grailsApplication.config.crowdera.paypal.X_PAYPAL_SECURITY_PASSWORD}")
		httppost.setHeader("X-PAYPAL-SECURITY-SIGNATURE","${grailsApplication.config.crowdera.paypal.X_PAYPAL_SECURITY_SIGNATURE}")
		// Global Sandbox Application ID
		httppost.setHeader("X-PAYPAL-APPLICATION-ID","${grailsApplication.config.crowdera.paypal.X_PAYPAL_APPLICATION_ID}")
		// Input and output formats
		httppost.setHeader("X-PAYPAL-REQUEST-DATA-FORMAT","${grailsApplication.config.crowdera.paypal.GetVerifiedStatus_REQUEST_DATA_FORMAT}")
		httppost.setHeader("X-PAYPAL-RESPONSE-DATA-FORMAT","${grailsApplication.config.crowdera.paypal.X_PAYPAL_RESPONSE_DATA_FORMAT}")

		StringEntity input = new StringEntity("emailAddress="+email+"&matchCriteria=NONE")

		httppost.setEntity(input)

		HttpResponse httpres = httpclient.execute(httppost)
		int status = httpres.getStatusLine().getStatusCode()
		if (status == 200){
			HttpEntity entity = httpres.getEntity()
			if (entity != null){
				str = EntityUtils.toString(entity)
				def json = new JsonSlurper().parseText(str)
				ack = json.responseEnvelope.ack
			}
		}
		render ack
	}

	@Secured(['IS_AUTHENTICATED_FULLY'])
	def getRedactorImage() {
		def imageFile= params.file
		def fileUrl = projectService.getRedactorImageUrl(imageFile)
		JSONObject json = new JSONObject();
		json.put("filelink",fileUrl);
		render json
	}

	@Secured(['IS_AUTHENTICATED_FULLY'])
	def editComment() {
		def vanityUserName = userService.getVanityNameFromUsername(params.fr, params.projectId)
		if (params.commentId || params.teamCommentId) {
			if (params.commentId) {
				redirect (action:'show', controller:'project', fragment: 'comments', params:[projectTitle:params.projectTitle, fr: vanityUserName, commentId: params.commentId])
			}
			if (params.teamCommentId) {
				redirect (action:'show', controller:'project', fragment: 'comments', params:[projectTitle:params.projectTitle, fr: vanityUserName, teamCommentId: params.teamCommentId])
			}
		} else {
			render view:'error'
		}
	}

	@Secured(['IS_AUTHENTICATED_FULLY'])
	def editCommentSave() {
		ProjectComment projectComment
		TeamComment teamcomment
		def vanityUserName = userService.getVanityNameFromUsername(params.fr, params.projectId)

		if (params.commentId) {
			projectComment = projectService.getProjectCommentById(params.long('commentId'))
			if (projectComment) {
				projectComment.comment = params.comment
			}
		}
		if (params.teamCommentId) {
			teamcomment = projectService.getTeamCommentById(params.long('teamCommentId'))
			if (teamcomment) {
				teamcomment.comment = params.comment
			}
		}
		redirect (action:'show', controller:'project', fragment: 'comments', params:[projectTitle:params.projectTitle, fr:vanityUserName])
	}
}
