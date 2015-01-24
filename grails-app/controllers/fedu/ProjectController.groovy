package fedu

import grails.plugin.springsecurity.annotation.Secured
import org.apache.poi.ss.usermodel.WorkbookFactory
import org.apache.poi.ss.usermodel.Workbook
import org.springframework.web.multipart.MultipartHttpServletRequest
import org.springframework.web.multipart.commons.CommonsMultipartFile
import org.grails.plugins.excelimport.ExcelImportService

import org.springframework.web.multipart.MultipartFile;
import org.jets3t.service.impl.rest.httpclient.RestS3Service
import org.jets3t.service.model.S3Bucket
import org.jets3t.service.model.S3Object
import org.jets3t.service.security.AWSCredentials

class ProjectController {
    def userService
    def excelImportService
    def rewardService
    def projectService
    def mandrillService

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
            def searchResults = projectService.search(query)
            if (searchResults.size == 0){
                flash.catmessage = "No Campaign found matching your input."
                redirect(action:list)
            } else {
                searchResults.sort{x,y -> x.title<=>y.title ?: x.story<=>y.story}
                render(view: "list/index", model:[projects: searchResults])
            }
        } else {
            redirect(action: "list")
        }
     }

	def show() {
		Project project
        User user = User.findByUsername(params.fundRaiser)
		if (params.id) {
			project = Project.findById(params.id)
		} else {
			project = null
		}

        render (view: 'show/index',
                model: [project: project, user: user,
                        FORMCONSTANTS: FORMCONSTANTS])
	}

    @Secured(['ROLE_ADMIN'])
    def validateshow() {
        def projects = params.id
        if (params.id) {         
            projects = Project.findById(params.id)
            if(projects.validated == false) {
                render (view: 'validate/validateshow', model: [project: projects])
            }
        }
    }

    @Secured(['ROLE_ADMIN'])
    def updateValidation() {
        if (params.id) {
            def id = params.id
            def project = Project.get(id)
            project.validated = true
        }   
        flash.prj_validate_message= "Campaign validated successfully"
        redirect (action:'validateList')
    }

    @Secured(['ROLE_ADMIN'])
    def delete() {
        def project = Project.get(params.id)
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
        def imageUrlId = ImageUrl.get(request.getParameter("imgst"))
        def projectId = Project.get(request.getParameter("projectId"))
        List imageUrl = projectId.imageUrl
        imageUrl.remove(imageUrlId)
        imageUrlId.delete()
        render ''
    }

    @Secured(['IS_AUTHENTICATED_FULLY'])
    def deleteOrganizationLogo(){
        
        def projectId = Project.get(request.getParameter("projectId"))
        projectId.organizationIconUrl=null
        render '' 
    }

    @Secured(['IS_AUTHENTICATED_FULLY'])
    def validate() {
        Project project
        if (params.id) {
            project = Project.findById(params.id)
            if(project.validated == true){
                redirect (action:'show')
            } else {
                render (view: 'validate/validateerror', model: [projects: project])
            }       
        }
    }
    
    @Secured(['IS_AUTHENTICATED_FULLY'])
    def saveasdraft(){
        def project = Project.get(params.id)
        if(project.draft) {
            project.draft = false
            flash.prj_mngprj_message="Project has been submitted for approval."
            
            render (view: 'manageproject/index',
                    model: [project: project,
                            FORMCONSTANTS: FORMCONSTANTS])
        } else {
            flash.prj_mngprj_message="This project has already been submitted for approval, and under review."
            render (view: 'manageproject/index',
                    model: [project: project,
                            FORMCONSTANTS: FORMCONSTANTS])
        }
    }
    
    @Secured(['ROLE_ADMIN'])
    def validateList() {
        def projects = projectService.getNonValidatedProjects()
        render(view: 'validate/index', model: [projects: projects])
    }


    @Secured(['IS_AUTHENTICATED_FULLY'])
    def savecomment() {
        Project project
        if (params.id) {
            project = Project.findById(params.id)
            if (project && params.comment) {
                new ProjectComment(
                    comment: params.comment,
                    user: userService.getCurrentUser(),
                    project: project,
                    date: new Date()).save(failOnError: true)
            }
        } else {
            flash.sentmessage = "Something went wrong saving comment. Please try again later."
        }

        redirect (action: 'show', id: params.id, fragment: 'comments')
    }

    @Secured(['IS_AUTHENTICATED_FULLY'])
    def updatecomment(){
        def checkid= request.getParameter('checkID')
        def proComment=ProjectComment.get(checkid)
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
    def edit() {
        def project = Project.get(params.projectId)
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
        def project = Project.get(params.projectId)
        User user = userService.getCurrentUser()
        
        if(project) {
            
            def iconFile = request.getFile('iconfile')
            if(!iconFile.isEmpty()) {
                def uploadedFileUrl = projectService.getorganizationIconUrl(iconFile)
                project.organizationIconUrl = uploadedFileUrl
            }
            
            def imageFiles = request.getFiles('thumbnail[]')
            if(!imageFiles.isEmpty()) {
                projectService.getMultipleImageUrls(imageFiles, project)
            }
            
            project.description = params.description
            project.story = params.story
            project.amount = Double.parseDouble(params.amount)
            project.title = params.title
            project.category = params.category
            project.webAddress = params.webAddress
            project.videoUrl = params.videoUrl

            def days = params.days
            projectService.getUpdatedNumberofDays(days, project)
            
            String email1 = params.email1
            String email2 = params.email2
            String email3 = params.email3

            projectService.updateAdminsAndSendUpdateEmail(email1, email2, email3, project, user)

            //projectService.sendEmailToAdminForProjectUpdate(project, user)
            
            flash.prj_mngprj_message = "Successfully saved the changes"
            render (view: 'manageproject/index',
                    model: [project: project,
                            FORMCONSTANTS: FORMCONSTANTS])
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

            User createdBy = User.findByUsername(projectParams.createdBy)
            if (!createdBy) {
                flash.projecterror = [
                    'title': projectParams.title,
                    'error': "Couldn't find user with email: " + projectParams.createdBy
                ]
                render (view: 'import/importerror')
                return
            }

            Project project = new Project(projectParams)
            if (project.hasErrors()) {
                flash.projecterror = [
                    'title': projectParams.title,
                    'error': "Error mapping project: " + project.errors.toString()
                ]
                redirect(action: 'importprojects')
                return
            }

            Beneficiary beneficiary = new Beneficiary(projectParams)
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
    def save() {
        Project project
        Beneficiary beneficiary
        User user = userService.getCurrentUser()
        project = new Project(params)
        beneficiary = new Beneficiary(params)
        ProjectAdmin projectAdmin = new ProjectAdmin()
        
        def button = params.button
        if(button == 'draft'){
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
            }
            
            rewardService.getMultipleRewards(project, rewardTitle, rewardPrice, rewardDescription, mailingAddress, emailAddress, twitter, custom)
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
            projectService.getdefaultAdmin(project, user)
            projectService.getAdminForProjects(email1, project, user)
            projectService.getAdminForProjects(email2, project, user)
            projectService.getAdminForProjects(email3, project, user)
            redirect(controller: 'project', action: 'saveRedirect', id: project.id, params: [button: button])
        } else {
            render (view: 'create/createerror', model: [project: project])
        }
	}

    @Secured(['IS_AUTHENTICATED_FULLY'])
    def saveRedirect() {
        def button = params.button
        def project = Project.get(params.id)
        
        if(button == 'draft'){
            render (view: 'create/saveasdraft', model: [project: project])
        } else {
            render (view: 'create/justcreated', model: [project: project])
        }
    }
    
    
    @Secured(['IS_AUTHENTICATED_FULLY'])
    def manageproject() {
        Project project
        if (params.id) {
            project = Project.findById(params.id)
        } else {
            project = null
        }

        render (view: 'manageproject/index',
                model: [project: project,
                        FORMCONSTANTS: FORMCONSTANTS])
    }
    
    @Secured(['IS_AUTHENTICATED_FULLY'])
    def projectdelete() {
        def project = Project.get(params.id)
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
        def reward = new Reward(params)
		int price = Double.parseDouble(params.price)
		int amount = Double.parseDouble(params.amount)
        RewardShipping shippingInfo = new RewardShipping(params)
		if(price >= amount) {
			flash.prj_mngprj_message = "Enter a price less than Campaign amount: ${amount}"
			render (view: 'manageproject/error', model: [reward: reward])
			return
		}
		
        if(reward.save()) {
            def project= Project.get(params.id)
            shippingInfo.reward = reward
            shippingInfo.save(failOnError: true)
            project.addToRewards(reward)
            reward.obsolete = true
            flash.prj_mngprj_message = 'Successfully created a new reward'
            redirect(controller: 'project', action: 'redirectReward',fragment: 'rewards', id: project.id)
        } else {
            render (view: 'manageproject/error', model: [reward: reward])
        }
    }

    def redirectReward(){
        def project = Project.get(params.id)
        render (view: 'manageproject/index', 
                model: [project: project,
                        FORMCONSTANTS: FORMCONSTANTS])
    }
    
    def sendemail() {
        def project = Project.get(params.id)
        String emails = params.emails
        String name = params.name
        String message = params.message
        
        def emailList = emails.split(',')
        emailList = emailList.collect { it.trim() }
        
        mandrillService.shareProject(emailList, name, message, project)

        flash.prj_mngprj_message= "Email sent successfully."
        if (params.ismanagepage) {
            render (view: 'manageproject/index',
                    model: [project: project,
                            FORMCONSTANTS: FORMCONSTANTS])
        } else {
            render (view: 'show/index',
                    model: [project: project,
                            FORMCONSTANTS: FORMCONSTANTS])
        }
    }
    
    @Secured(['IS_AUTHENTICATED_FULLY'])
    def projectupdate() {
        def project = Project.get(params.id)
        if(project) {
            render (view: 'update/index', model: [project: project, FORMCONSTANTS: FORMCONSTANTS])
        } else {
            render (view: 'manageproject/error', model: [project: project])
        }
    }
    
    @Secured(['IS_AUTHENTICATED_FULLY'])
    def updatesave() {
        def project = Project.get(params.id)
        def projectUpdate = new ProjectUpdate()
        User user = userService.getCurrentUser()
        if(project) {
            projectUpdate.story = params.story
            def imageFiles = request.getFiles('thumbnail[]')
            projectService.getUpdatedImageUrls(imageFiles, projectUpdate)
            
            project.addToProjectUpdates(projectUpdate)
            
            mandrillService.sendUpdateEmailsToContributors(project,projectUpdate,user)
            
            redirect (action:'updatesaverender' , controller:'project', id: project.id)
        } else {
            render (view: 'manageproject/error', model: [project: project])
        }
    }
    
    @Secured(['IS_AUTHENTICATED_FULLY'])
    def updatesaverender() {
        def project = Project.get(params.id)
        
        flash.prj_mngprj_message= "Update added successfully."
        render (view: 'manageproject/index', model: [project: project, FORMCONSTANTS: FORMCONSTANTS])
    }
    
    def categoryFilter (){
		def category = request.getParameter("category")
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
        def project = Project.get(params.id)
        User user = userService.getCurrentUser()
        def iscampaignAdmin = userService.isCampaignBeneficiaryOrAdmin(project, user)
        def message = projectService.getFundRaisersForTeam(project, user)
        flash.prj_mngprj_message = message
        if (iscampaignAdmin) {
            render (view: 'manageproject/index', model: [project: project, FORMCONSTANTS: FORMCONSTANTS])
        } else {
            render (view: 'show/index', model: [project: project, user: user, FORMCONSTANTS: FORMCONSTANTS])
        }
    }

    @Secured(['IS_AUTHENTICATED_FULLY'])
    def inviteTeamMember() {
        def project = Project.get(params.id)
        String emails = params.emailIds
        String name = params.username
        String message = params.message
        User user = userService.getCurrentUser()
                       
        if (params.ismanagepage) {
            sendEmailToTeam(emails, name, message, project)
            redirect (action: 'manageproject', id: project.id, params:[fundRaiser: user], fragment: 'manageTeam')
        } else {
            sendEmailToTeam(emails, name, message, project)
            redirect (action: 'show', id: project.id, params:[fundRaiser: user], fragment: 'manageTeam')
        }
    }

    def sendEmailToTeam(def emails, def name, def message, Project project)
    {
        def emailList = emails.split(',')
        emailList = emailList.collect { it.trim() }
        mandrillService.sendInvitationForTeam(emailList, name, message, project)
        flash.prj_mngprj_message= "Email sent successfully."
    }
	
	@Secured(['IS_AUTHENTICATED_FULLY'])
	def saveteamcomment() {
		def fundRaiser = params.fundRaiser
		User user = User.findByUsername(fundRaiser)
		Project project = Project.get(params.id)
		Team team = Team.findByUser(user, project)
		if (team) {
			TeamComment teamComment = new TeamComment(
				comment: params.comment,
				user: userService.getCurrentUser(),
				team: team,
				date: new Date())
	        team.addToComments(teamComment).save(failOnError: true)
		} else {
			flash.prj_mngprj_message = "Something went wrong saving comment. Please try again later."
		}
        
        if (!params.ismanagepage) {
		    redirect (action: 'show', id: params.id, params:[fundRaiser: fundRaiser], fragment: 'manageTeam')
        } else {
            redirect (action: 'manageproject', id: params.id, params:[fundRaiser: fundRaiser], fragment: 'manageTeam')
        }
	}

    def deletecustomrewards() {
        def rewardId = Reward.get(params.id)
        def project = Project.get(params.projectId)
        def shippingInfo = RewardShipping.findByReward(rewardId)
        if(rewardId){
            project.rewards.remove(rewardId)
            shippingInfo.reward = null
            shippingInfo.delete()
            rewardId.delete()
            flash.prj_mngprj_message = 'Successfully deleted a Reward'
            render (controller: 'project',fragment: 'rewards', view: 'manageproject/index',model: [project: project,FORMCONSTANTS: FORMCONSTANTS])
            
        }else{
             render (view: 'manageproject/index', fragment: 'rewards',
                model: [project: project,
                        FORMCONSTANTS: FORMCONSTANTS])
        }
    }
}
