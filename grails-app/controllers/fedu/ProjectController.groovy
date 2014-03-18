package fedu

import grails.plugin.springsecurity.annotation.Secured
import org.springframework.web.multipart.commons.CommonsMultipartFile

class ProjectController {
    def springSecurityService

    def FORMCONSTANTS = [
        NAME: 'name',
        EMAIL: 'email',
        TELEPHONE: 'telephone',
        FUNDRAISINGREASON: 'fundRaisingReason',
        FUNDRAISINGFOR: 'fundRaisingFor',
        CATEGORY: 'category',
        AMOUNT: 'amount',
        DAYS: 'days',
        TITLE: 'title',
        STORY: 'story',
        THUMBNAIL: 'thumbnail',
        IMAGEURL: 'imageUrl'
    ]

	def list = {
		render (view: 'list/index', model: [projects: Project.list()])
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

        return [project: project]
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
			(Project.FundRaisingFor.MYSELF): "Myself",
			(Project.FundRaisingFor.NON_PROFIT): "Non-profit",
			(Project.FundRaisingFor.SCHOOL): "School"
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

        render (view: 'create/index', model: [
                fundRaisingOptions: fundRaisingOptions,
                raisingForOptions: raisingForOptions,
                categoryOptions: categoryOptions,
                FORMCONSTANTS: FORMCONSTANTS])
	}

    def VALID_IMG_TYPES = ['image/png', 'image/jpeg']

    @Secured(['ROLE_USER'])
    def save() {
        Image thumbnail
        Project project
        User user = springSecurityService.getCurrentUser()

        CommonsMultipartFile thumbnailFile = request.getFile(FORMCONSTANTS.THUMBNAIL)
        // List of OK mime-types
        if (!thumbnailFile.isEmpty() && !VALID_IMG_TYPES.contains(thumbnailFile.getContentType())) {
            flash.message = "Image must be one of: ${VALID_IMG_TYPES}"
            render (view: 'create/createerror')
            return
        } else {
            thumbnail = new Image(bytes: thumbnailFile.bytes, contentType: thumbnailFile.getContentType())
        }

        project = new Project(params)
        project.user = user
        project.image = thumbnail
        project.created = new Date()

        if (project.save()) {
            render (view: 'create/justcreated', model: [project: project])
        } else {
            render (view: 'create/createerror', model: [project: project])
        }
	}
}
