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

		/* Contribute */
		"/contribute"(view:'/contribute/index')
	}
}
