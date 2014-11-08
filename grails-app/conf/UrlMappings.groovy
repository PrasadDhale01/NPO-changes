class UrlMappings {

    static mappings = {
        "/$controller/$action?/$id?(.$format)?"{
            constraints {
                // apply constraints here
            }
        }

        "/"(controller: 'home', action: 'index')
        "500"(view:'/error')

        "/logout/$action?"(controller: "logout")

        /* About Us */
        "/aboutus"(view:'/aboutus/index')

        /* How it Works */
        "/howitworks"(view:'/howitworks/index')
        
        /*Terms of Use*/
        "/termsofuse"(view:'/termsofuse/index')

        /* FAQ */
        "/faq"(view:'/faq/index')

        /* Blogs */
        "/blogs"(controller:'blog', action:'list')
        "/blogs/$id"(controller:'blog', action:'show')

        /* Project */
        "/projects/create"(controller:'project', action:'create')
        "/projects"(controller:'project', action:'list')
        "/projects-widget"(controller:'project', action:'listwidget')
        "/projects/$id"(controller:'project', action:'show')
        "/projects/$id/thumbnail"(controller:'project', action:'thumbnail')
        "/projects/$projectId/fund"(controller:'fund', action:'fund')

        /* Admin */
        "/admin/dashboard"(controller:'user', action:'admindashboard')
        "/admin/importprojects"(controller: 'project', action: 'importprojects')

        /* Community */
        "/community/$communityId/manage"(controller: 'community', action: 'manage')

        /* Facebook login */
        "/facebookauthfailure"(controller:'login', action:'facebook_user_denied')
    }
}
