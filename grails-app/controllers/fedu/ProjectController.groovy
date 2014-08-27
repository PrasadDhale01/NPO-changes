package fedu

import grails.plugin.springsecurity.annotation.Secured
import org.apache.poi.ss.usermodel.WorkbookFactory
import org.apache.poi.ss.usermodel.Workbook
import org.springframework.web.multipart.commons.CommonsMultipartFile
import org.grails.plugins.excelimport.ExcelImportService

class ProjectController {
    def userService
    def excelImportService

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

        FUNDRAISINGREASON: 'fundRaisingReason',
        FUNDRAISINGFOR: 'fundRaisingFor',
        CATEGORY: 'category',
        AMOUNT: 'amount',
        DAYS: 'days',
        TITLE: 'title',
        STORY: 'story',
        THUMBNAIL: 'thumbnail',
        IMAGEURL: 'imageUrl',
        REWARDS: 'rewards',
        PROJECTSEXCEL: 'projectsExcel'
    ]

    def list = {
		render (view: 'list/index', model: [projects: Project.list()])
	}

    def listwidget = {
        render (view: 'list/index-no-headerfooter', model: [projects: Project.list()])
    }

    def thumbnail() {
        Project project
        if (params.int('id')) {
            project = Project.findById(params.id)
        }
        if (!project || !project.image) {
            response.sendError(404)
            return
        }

        response.contentType = project.image.contentType
        response.contentLength = project.image.bytes.size()
        response.outputStream.write(project.image.bytes)
        response.outputStream.close()
    }

	def show() {
		Project project
		if (params.int('id')) {
			project = Project.findById(params.id)
		} else {
			project = null
		}

        render (view: 'show/index',
                model: [project: project,
                        FORMCONSTANTS: FORMCONSTANTS])
	}

    @Secured(['ROLE_USER'])
    def savecomment() {
        Project project
        if (params.int('id')) {
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
		def fundRaisingOptions = [
			(Project.FundRaisingReason.VOCATIONAL_SCHOOL): "Vocation school",
			(Project.FundRaisingReason.TUITION_FEE): "Tuition fee",
			(Project.FundRaisingReason.SCHOOL_SUPPLIES): "School supplies",
			(Project.FundRaisingReason.STUDENT_LOAN): "Student loan",

			/* For raising for other... */
			(Project.FundRaisingReason.SCHOOL_PROJECT): "School project",
			(Project.FundRaisingReason.EDUCATE_POOR): "Educating poor"
		]

		def raisingForOptions = [
            (Project.FundRaisingFor.OTHER): "Someone I know",
			(Project.FundRaisingFor.MYSELF): "Myself"
		]

        def categoryOptions = [
            (Project.Category.AGRICULTURE): "Agriculture",
            (Project.Category.TECHNOLOGY): "Technology",
            (Project.Category.ENTREPRENEURSHIP): "Entrepreneurship",
            (Project.Category.SCIENCE): "Science",
            (Project.Category.LITERACY_LANGUAGE): "Literacy & Language",
            (Project.Category.SPORTS): "Sports",
            (Project.Category.ARTS_CULTURE): "Arts & Culture",
            (Project.Category.PRIMARY_EDUCATION): "Primary Education",
            (Project.Category.COLLEGE_ACCESS): "College Access",
            (Project.Category.WOMEN_EMPOWERMENT): "Women Empowerment",
            (Project.Category.OTHER): "Other"
        ]

        def genderOptions = [
            "MALE": (Beneficiary.Gender.MALE),
            "FEMALE": (Beneficiary.Gender.FEMALE),
            "UNSPECIFIED": (Beneficiary.Gender.UNSPECIFIED)
        ]

        def rewardOptions = [:]
        Reward.list().each {
            rewardOptions.put(it.id, it)
        }

        render (view: 'create/index',
                model: [fundRaisingOptions: fundRaisingOptions,
                        raisingForOptions: raisingForOptions,
                        categoryOptions: categoryOptions,
                        rewardOptions: rewardOptions,
                        genderOptions: genderOptions,
                        FORMCONSTANTS: FORMCONSTANTS])
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
            'D': 'fundRaisingReason',
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
            'V': 'country'
        ]
    ]

    @Secured(['ROLE_ADMIN'])
    def bulkimport() {
        CommonsMultipartFile projectSpreadsheet = request.getFile(FORMCONSTANTS.PROJECTSEXCEL)

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
                redirect(action: 'importprojects')
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
                        'note': "None of the projects after this one would be imported."
                    ]
                    redirect(action: 'importprojects')
                    return
                }
            }

            flash.success = "All projects successfully imported"
            redirect(action: 'importprojects')
            return
        } else {
            flash.message = "Nothing to import. Please make sure the file contains some valid rows."
            redirect(action: 'importprojects')
            return
        }
    }

    def VALID_IMG_TYPES = ['image/png', 'image/jpeg']

    @Secured(['ROLE_USER'])
    def save() {
        Image thumbnail
        Project project
        Beneficiary beneficiary
        User user = userService.getCurrentUser()

        CommonsMultipartFile thumbnailFile = request.getFile(FORMCONSTANTS.THUMBNAIL)
        // List of OK mime-types
        if (!thumbnailFile.isEmpty()) {
            if (!thumbnailFile.isEmpty() && !VALID_IMG_TYPES.contains(thumbnailFile.getContentType())) {
                flash.message = "Image must be one of: ${VALID_IMG_TYPES}"
                render (view: 'create/createerror')
                return
            } else {
                thumbnail = new Image(bytes: thumbnailFile.bytes, contentType: thumbnailFile.getContentType()).save()
            }
        }

        project = new Project(params)
        beneficiary = new Beneficiary(params)

        if (project.fundRaisingFor == Project.FundRaisingFor.OTHER) {
            /* Nothing to do here. */
        } else if (project.fundRaisingFor == Project.FundRaisingFor.MYSELF) {
            beneficiary.firstName = user.firstName
            beneficiary.lastName = user.lastName
            beneficiary.email = user.email
        }

        project.user = user
        project.image = thumbnail
        project.created = new Date()
        project.beneficiary = beneficiary

        params.rewards.each() { rewardId ->
            project.addToRewards(Reward.findById(rewardId))
        }

        if (project.save()) {
            render (view: 'create/justcreated', model: [project: project])
        } else {
            render (view: 'create/createerror', model: [project: project])
        }
	}
}
