package fedu

import grails.converters.JSON

class ProjectController {

	def list = {
		render (view: 'list/index', model: [projects: Project.list()])
	}

	def create = {
		
	}

	def publish = {
		new Project(params).save(failOnError: true)

		render params as JSON
	}
}
