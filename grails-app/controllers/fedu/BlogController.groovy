package fedu

import grails.converters.JSON

class BlogController {

	def list() {
		[ blogs: Blog.list() ]
	}

	def show() {
		[blog: Blog.findById(params.id)]
	}
}
