class UrlMappings {

    static mappings = {
        "/$controller/$action?/$id?(.$format)?"{
            constraints {
                // apply constraints here
            }
        }

        "/"(controller: 'home', action: 'index')
        "500"(controller: "error")
        "404"(view: '/error')

        "/logout/$action?"(controller: "logout")

        /* About Us */
        "/aboutus"(view:'/aboutus/index')

        /* How it Works */
        "/howitworks"(view:'/howitworks/index')
        
        /*Terms of Use*/
        "/termsofuse"(view:'/termsofuse/index')
        
        /*privacy policy*/
        "/privacypolicy"(view:'/privacypolicy/index')

        /* FAQ */
        "/faq"(view:'/faq/index')
        
        /* Contact Us */
        "/customer-service"(view:'/contactus/index')

        /* Blogs */
        "/blogs"(controller:'blog', action:'list')
        "/blogs/$id"(controller:'blog', action:'show')

        /* Project */
        "/campaigns/create"(controller:'project', action:'create')
        "/campaign/save/$projectTitle"(controller:'project', action:'saveProject')
        "/campaign/draft/$projectTitle"(controller:'project', action:'draftProject')
        "/campaign/managecampaign"(controller:'project', action:'manageCampaign')
        "/campaign/managecampaign/$projectTitle"(controller:'project', action:'manageproject')
        "/campaign/edit/$projectTitle"(controller:'project', action:'edit')
        "/campaigns/addFundRaiser/$id"(controller:'project', action:'addFundRaiser')
        "/campaign/campaignupdate/$projectTitle"(controller:'project', action:'projectupdate')
        "/campaign/updatesaverender"(controller:'project', action:'updatesaverender')
        "/campaigns"(controller:'project', action:'list')
        "/campaigns-widget"(controller:'project', action:'listwidget')
        "/campaigns/$id"(controller:'project', action:'showCampaign')
        "/campaigns/$projectTitle/$fr"(controller:'project', action:'show')
        "/campaigns/$id/thumbnail"(controller:'project', action:'thumbnail')
        "/campaigns/$id/fund"(controller:'fund', action:'fund')
        "/campaign/query"(controller:'project' , action:'search')
        "/campaign"(controller:'project' , action:'categoryFilter')
        "/campaign/validateList"(controller:'project', action:'validateList')
        "/campaign/validateshow/$projectTitle/$fr"(controller:'project', action:'validateshow')
        "/campaign/sendemail"(controller:'project', action:'sendemail')
        "/campaign/sortby"(controller:'project', action:'sortCampaign')
        "/campaign/$projectTitle/update/edit/$id"(controller:'project', action:'editUpdate')

        /* Admin */
        "/admin/dashboard"(controller:'user', action:'admindashboard')
        "/admin/importcampaigns"(controller: 'project', action: 'importprojects')

        /* Community */
        "/community/$communityId/manage"(controller: 'community', action: 'manage')

        /* Facebook login */
        "/facebookauthfailure"(controller:'login', action:'facebook_user_denied')
        
        "/facebookauthsuccess"(controller:'login', action:'facebook_user_login')
        
        /*fund*/
        "/fund"(controller: 'fund', action: 'paypalReturn')
        "/campaign/$projectTitle/fund/$fr"(controller:'fund', action: 'fund')
        "/funds/$projectTitle/acknowledge/$fr/$id"(controller: 'fund', action: 'editContributionComment')
        "/fund/$projectTitle/acknowledge/$fr/$cb"(controller: 'fund', action:'acknowledge')
		
        /*User*/
        "/user/mycampaigns"(controller:'user', action:'myproject')
        "/users/dashboard"(controller:'user', action:'accountSetting')
    }
}
