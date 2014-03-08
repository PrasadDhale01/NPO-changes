package fedu

import grails.converters.JSON

class ProjectController {

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
		return [project: project, model: [justcreated: params.justcreated]]
	}

	def create = {
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

		[fundRaisingOptions: fundRaisingOptions, raisingForOptions: raisingForOptions]
	}

	def publish = {
		Project project

		try {
			project = new Project(params).save(failOnError: true)
		} catch (Exception e) {
			project = null
		}

		if (project) {
			render (view: 'justcreated', model: [project: project])
		} else {
			render (view: 'createerror')
		}
	}
}
