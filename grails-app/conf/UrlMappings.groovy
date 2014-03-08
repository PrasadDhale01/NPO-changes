class UrlMappings {

	static mappings = {
        "/$controller/$action?/$id?(.$format)?"{
            constraints {
                // apply constraints here
            }
        }

        "/"(controller: 'home', action: 'index')
        "500"(view:'/error')

		/* About Us */
		"/aboutus"(view:'/aboutus/index')

		/* How it Works */
		"/howitworks"(view:'/howitworks/index')

		/* Login */
		"/login"(view:'/login/index')

		/* Register */
		"/register"(view:'/register/index')

		/* FAQ */
		"/faq"(view:'/faq/index')

		/* Blogs */
		"/blogs"(controller:'blog', action:'list')
		"/blogs/$id"(controller:'blog', action:'show')

		/* Project */
		"/projects/create"(controller:'project', action:'create')
		"/projects"(controller:'project', action:'list')
		"/projects/$id"(controller:'project', action:'show')
	}
}
