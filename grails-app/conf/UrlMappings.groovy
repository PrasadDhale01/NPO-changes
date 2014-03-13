class UrlMappings {

    static mappings = {
        "/$controller/$action?/$id?(.$format)?"{
            constraints {
                // apply constraints here
            }
        }

        "/"(controller: 'home', action: 'index')
        "500"(view:'/error')

        "/login/$action?"(controller: "login")
        "/logout/$action?"(controller: "logout")

        /* User Profile */
        "/users/show"(controller:'registration', action:'show')
        "/users/update"(controller:'registration', action:'update')

        /* About Us */
        "/aboutus"(view:'/aboutus/index')

        /* How it Works */
        "/howitworks"(view:'/howitworks/index')

        /* FAQ */
        "/faq"(view:'/faq/index')

        /* Blogs */
        "/blogs"(controller:'blog', action:'list')
        "/blogs/manage"(controller:'blog', action:'manage')
        "/blogs/create"(controller:'blog', action:'create')
        "/blogs/$id"(controller:'blog', action:'show')

        /* Project */
        "/projects/create"(controller:'project', action:'create')
        "/projects"(controller:'project', action:'list')
        "/projects/$id"(controller:'project', action:'show')
        "/projects/$id/thumbnail"(controller:'project', action:'thumbnail')
    }
}
