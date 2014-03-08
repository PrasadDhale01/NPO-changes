package fedu

import grails.converters.JSON
import grails.plugin.springsecurity.annotation.Secured

@Secured(['permitAll'])
class BlogController {

	def list() {
		return [blogs: Blog.list()]
	}

	def show() {
		Blog blog
		if (params.int('id')) {
			blog = Blog.findById(params.id)
		} else {
			blog = null
		}
		return [blog: blog]
	}
}
