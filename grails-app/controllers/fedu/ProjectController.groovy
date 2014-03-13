package fedu

import grails.plugin.springsecurity.annotation.Secured
import org.springframework.web.multipart.commons.CommonsMultipartFile

class ProjectController {
    def FORMCONSTANTS = [
            NAME: 'name',
            EMAIL: 'email',
            TELEPHONE: 'telephone',
            FUNDRAISINGREASON: 'fundRaisingReason',
            FUNDRAISINGFOR: 'fundRaisingFor',
            AMOUNT: 'amount',
            DAYS: 'days',
            TITLE: 'title',
            STORY: 'story',
            THUMBNAIL: 'thumbnail'
    ]

    def springSecurityService

	def list = {
		render (view: 'list/index', model: [projects: Project.list()])
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


		[fundRaisingOptions: fundRaisingOptions, raisingForOptions: raisingForOptions, FORMCONSTANTS: FORMCONSTANTS]
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
            render (view: 'createerror')
            return
        } else {
            thumbnail = new Image(bytes: thumbnailFile.bytes, contentType: thumbnailFile.getContentType())
        }

        project = new Project(params)
        project.user = user
        project.image = thumbnail

        if (project.save()) {
            render (view: 'justcreated', model: [project: project])
        } else {
            render (view: 'createerror', model: [project: project])
        }
	}
}
