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
		if(projects.size<1) {
            flash.message="There are no campaigns"
            render (view: 'list/index')
        }
        else {
            render (view: 'list/index', model: [projects: projects])
        }
	}

    def listwidget = {
        def projects = projectService.getValidatedProjects()
        render (view: 'list/index-no-headerfooter', model: [projects: projects])
    }

    def search () {
        def query = params.query
        if(query) {
            def searchResults = projectService.search(query)
            if (searchResults.size == 0){
                flash.message = "No Campaign found matching your input."
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
		if (params.id) {
			project = Project.findById(params.id)
		} else {
			project = null
		}

        render (view: 'show/index',
                model: [project: project,
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
        flash.message= "Campaign validated successfully"
        redirect (action:'validateList')
    }

    @Secured(['ROLE_ADMIN'])
    def delete() {
        def project = Project.get(params.id)
        if (project) {
            project.rejected = true
            flash.message= "Campaign discarded successfully"
            redirect (action:'validateList')
        } else {
            flash.message = 'Campaign Not Found'
            render (view: 'validate/validateerror', model: [project: project])
        }
    }

    @Secured(['ROLE_USER'])
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
    
    @Secured(['ROLE_USER'])
    def saveasdraft(){
        def project = Project.get(params.id)
        if(project.draft) {
            project.draft = false
            flash.message="Project has been submitted for approval."
            
            render (view: 'manageproject/index',
                    model: [project: project,
                            FORMCONSTANTS: FORMCONSTANTS])
        } else {
            flash.message="This project has already been submitted for approval, and under review."
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


    @Secured(['ROLE_USER'])
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
            flash.commentmessage = "Something went wrong saving comment. Please try again later."
        }

        redirect (action: 'show', id: params.id, fragment: 'comments')
    }

    @Secured(['ROLE_USER'])
	def create() {
        def categoryOptions = projectService.getCategoryList()

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
                        FORMCONSTANTS: FORMCONSTANTS])
	}

    @Secured(['ROLE_USER'])
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
            flash.message = "Campaign not found."
            render (view: 'edit/editerror')
            return
        }
    }

    @Secured(['ROLE_USER'])
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
            project.days = Integer.parseInt(params.days)
            project.category = params.category
            project.webAddress = params.webAddress
            project.videoUrl = params.videoUrl
            
            String email1 = params.email1
            String email2 = params.email2
            String email3 = params.email3

            projectService.updateAdminsForProjects(email1, email2, email3, project, user)

            projectService.sendEmailToAdminForProjectUpdate(project, user)
            
            flash.message = "Successfully saved the changes"
            render (view: 'manageproject/index',
                    model: [project: project,
                            FORMCONSTANTS: FORMCONSTANTS])
        } else {
            flash.message = "Campaign not found."
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
            flash.message = "Please choose a file and try again."
            redirect(action: 'importprojects')
            return
        }

        List projectParamsList
        try {
            Workbook workbook = WorkbookFactory.create(projectSpreadsheet.getInputStream())
            projectParamsList = excelImportService.columns(workbook, CONFIG_BOOK_COLUMN_MAP)
        } catch (Exception e) {
            flash.message = "Error while importing file: " + e.getMessage()
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

            flash.success = "All Campaigns successfully imported"
            redirect(action: 'importprojects')
            return
        } else {
            flash.message = "Nothing to import. Please make sure the file contains some valid rows."
            render (view: 'import/importerror')
            return
        }
    }

    def VALID_IMG_TYPES = ['image/png', 'image/jpeg']

    @Secured(['ROLE_USER'])
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
        
        def rewardTitle = params.rewardTitle
        def rewardPrice = params.rewardPrice
        def rewardDescription = params.rewardDescription
        
        if(rewardTitle) {
            rewardService.getMultipleRewards(project, rewardTitle, rewardPrice, rewardDescription)
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
        
        projectService.getAdminForProjects(email1, project, user)
        projectService.getAdminForProjects(email2, project, user)
        projectService.getAdminForProjects(email3, project, user)
        
        project.user = user
        project.created = new Date()
        project.beneficiary = beneficiary
        
        if (project.save()) {
            redirect(controller: 'project', action: 'saveRedirect', id: project.id, params: [button: button])
        } else {
            render (view: 'create/createerror', model: [project: project])
        }
	}

    @Secured(['ROLE_USER'])
    def saveRedirect() {
        def button = params.button
        def project = Project.get(params.id)
        
        if(button == 'draft'){
            render (view: 'create/saveasdraft', model: [project: project])
        } else {
            render (view: 'create/justcreated', model: [project: project])
        }
    }
    
    
    @Secured(['ROLE_USER'])
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
    
    @Secured(['ROLE_USER'])
    def projectdelete() {
        def project = Project.get(params.id)
        if (project) {
            project.inactive = true
            flash.message= "Campaign Discarded Successfully"
            redirect (action:'myproject' , controller:'user')
        } else {
            flash.message = 'Campaign Not Found'
            render (view: 'manageproject/error', model: [project: project])
        }
    }

    @Secured(['ROLE_USER'])
    def customrewardsave() {
        def reward = new Reward(params)
		int price = Integer.parseInt(params.price)
		int amount = Double.parseDouble(params.amount)
		if(price >= amount) {
			flash.message = "Enter a price less than Campaign amount: ${amount}"
			render (view: 'manageproject/error', model: [reward: reward])
			return
		}
		
        if(reward.save()) {
            def project= Project.get(params.id)
            project.addToRewards(reward)
            reward.obsolete = true
            flash.message = 'Successfully created a new reward'
            render (view: 'manageproject/index',
                    model: [project: project,
                            FORMCONSTANTS: FORMCONSTANTS])
        } else {
            render (view: 'manageproject/error', model: [reward: reward])
        }
    }
    
    def sendemail() {
        def project = Project.get(params.id)
        String emails = params.emails
        String name = params.name
        String message = params.message
        
        def emailList = emails.split(',')
        emailList = emailList.collect { it.trim() }
        
        mandrillService.shareProject(emailList, name, message, project)

        flash.sentmessage= "Email sent successfully."
        render (view: 'show/index',
                model: [project: project,
                        FORMCONSTANTS: FORMCONSTANTS])
    }
    
    @Secured(['ROLE_USER'])
    def projectupdate() {
        def project = Project.get(params.id)
        if(project) {
            render (view: 'update/index', model: [project: project, FORMCONSTANTS: FORMCONSTANTS])
        } else {
            render (view: 'manageproject/error', model: [project: project])
        }
    }
    
    @Secured(['ROLE_USER'])
    def updatesave() {
        def project = Project.get(params.id)
        def projectUpdate = new ProjectUpdate()

        if(project) {
            projectUpdate.story = params.story
            def imageFiles = request.getFiles('thumbnail[]')

            if(!imageFiles.empty) {
                projectService.getUpdatedImageUrls(imageFiles, projectUpdate)
            }
            project.addToProjectUpdates(projectUpdate)
            
            redirect (action:'updatesaverender' , controller:'project', id: project.id)
               
        } else {
            render (view: 'manageproject/error', model: [project: project])
        }
    }
    
    @Secured(['ROLE_USER'])
    def updatesaverender() {
        def project = Project.get(params.id)
        
        flash.message= "Updates added successfully."
        render (view: 'manageproject/index', model: [project: project, FORMCONSTANTS: FORMCONSTANTS])
    }
}
