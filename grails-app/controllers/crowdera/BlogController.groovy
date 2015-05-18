package crowdera

import grails.plugin.springsecurity.annotation.Secured

import java.text.SimpleDateFormat

class BlogController {

	def list() {
		return [blogs: Blog.findAllByEnabled(true)]
	}

	def show() {
		Blog blog
		if (params.int('id')) {
			blog = Blog.findByIdAndEnabled(params.id, true)
		} else {
			blog = null
		}
		return [blog: blog]
	}

    @Secured(['ROLE_AUTHOR', 'ROLE_ADMIN'])
    def manage() {
        return [blogs: Blog.list()]
    }

    @Secured(['ROLE_AUTHOR', 'ROLE_ADMIN'])
    def togglestatus() {
        if (params.int('id')) {
            Blog blog = Blog.findById(params.id)
            blog.enabled = !blog.enabled
            blog.save(failOnError: true)
        }

        redirect (action: 'manage')
    }

    @Secured(['ROLE_AUTHOR', 'ROLE_ADMIN'])
    def publish() {
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd")
        params.date = dateFormat.parse(params.date)
        new Blog(params).save(failOnError: true)
        redirect(action: 'manage')
    }
}
