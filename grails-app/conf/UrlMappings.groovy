class UrlMappings {

    static mappings = {
        "/$controller/$action?/$id?(.$format)?"{
            constraints {
                // apply constraints here
            }
        }

        "/"(controller: 'home', action: 'index')
        "500"(controller: "error")
        "404"(view: '/404error')
        "401"(view:'/401error')
        "403"(view:'/401error')
        "/manager"(view:'/401error')
        "/manager/*"(view:'/401error')
        "/manager/*/*"(view:'/401error')
  
        "/logout/$action?"(controller: "logout")

        "/sitemap"(controller :'sitemap', action :'sitemap')

        /* About Us */
        "/aboutus"(view:'/aboutus/index')
        "/careers"(view:'/aboutus/careers')

		/* Ebook */
		"/crowdfunding-ebook"(view:'/ebook/index')

        /* How it Works */
        "/howitworks"(view:'/howitworks/index')

        /*Terms of Use*/
        "/termsofuse"(view:'/termsofuse/index')

        /*privacy policy*/
        "/privacypolicy"(view:'/privacypolicy/index')

        /* FAQ */
        "/faq"(view:'/faq/index')

        /*Url shortener*/
        "/c/$url"(controller: 'project', action:'getCampaignFromShortUrl')

        /* Contact Us */
        "/customer-service"(view:'/contactus/index')
        "/customer-support"(controller:'project', action:'customerSupport')

        /* Blogs */
        "/blogs"(controller:'blog', action:'list')
        "/blogs/$id"(controller:'blog', action:'show')

        /* Project */
        "/campaign/create"(controller:'project', action:'create')
        "/campaign/start/$title"(controller:'project', action:'redirectCreateNow')
        "/campaign/success/$title"(controller:'project', action:'launch')

        "/campaign/save/$projectTitle"(controller:'project', action:'saveProject')
        "/campaign/draft/$projectTitle"(controller:'project', action:'draftProject')
        "/campaign/managecampaign"(controller:'project', action:'manageCampaign')
        "/campaign/managecampaign/$projectTitle"(controller:'project', action:'manageproject')
		"/campaign/$projectTitle/$fr/preview"(controller:'project', action:'preview')
		"/campaign/$projectTitle/$fr/pre-view"(controller:'project', action:'previewTile')
		"/campaign/managecampaign/$projectTitle/$offset"(controller:'project', action:'manageproject')
		"/campaign/managecampaign/$projectTitle/$offset/$max"(controller:'project', action:'manageproject')
        "/campaign/edit/$projectTitle"(controller:'project', action:'edit')
        "/campaigns/addFundRaiser/$id"(controller:'project', action:'addFundRaiser')
        "/campaign/campaignupdate/$projectTitle"(controller:'project', action:'projectupdate')
        "/campaign/updatesaverender"(controller:'project', action:'updatesaverender')
        "/campaigns"(controller:'project', action:'list')
        "/campaigns-widget"(controller:'project', action:'listwidget')
        "/campaigns/$id"(controller:'project', action:'showCampaign')
        "/campaigns/$projectTitle/$fr"(controller:'project', action:'show')
		"/campaigns/$projectTitle/$fr/$offset"(controller:'project', action:'show')
		"/campaigns/$projectTitle/$fr/$offset/$max"(controller:'project', action:'show')
		"/campaigns/$projectTitle/$fr/$teamCommentId"(controller:'project', action:'show')
		"/campaigns/$projectTitle/$fr/$commentId"(controller:'project', action:'show')
        "/campaigns/$id/thumbnail"(controller:'project', action:'thumbnail')
        "/campaigns/$id/fund"(controller:'fund', action:'fund')
        "/campaign"(controller:'project' , action:'search')
        "/campaigns/country/$country"(controller:'project' , action:'categoryFilter')
        "/campaigns/category/$category"(controller:'project' , action:'categoryFilter')
        "/campaigns/usedfor/$usedfor"(controller:'project' , action:'categoryFilter')
        "/campaign/validateList"(controller:'project', action:'validateList')
        "/campaign/validateshow/$projectTitle/$fr"(controller:'project', action:'validateshow')
        "/campaign/sendemail"(controller:'project', action:'sendemail')
        "/campaign/sortby/$query"(controller:'project', action:'sortCampaign')
        "/campaign/$projectTitle/update/edit/$id"(controller:'project', action:'editUpdate')
        "/campaign/supporter/$projectId/$fundRaiser"(controller:'project', action:'addcampaignsupporter')
        "/campaign/$projectTitle/$fr/embed/tile"(controller:'project', action:'embedTile')

        /* Admin */
        "/admin/dashboard"(controller:'user', action:'admindashboard')
        "/admin/importcampaigns"(controller: 'project', action: 'importprojects')
        "/user/applicantsList"(controller: 'user', action: 'crewsList')

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
        "/fund/$projectTitle/acknowledge/comment/$fr/$id"(controller:'fund', action:'saveContributionComent')
        "/fund/$projectTitle/acknowledge/savecomment/$fr/$id/$commentId"(controller:'fund', action:'saveCommentRedirect')
        "/fund/$projectTitle/acknowledge/saveteamcomment/$fr/$id/$teamCommentId"(controller:'fund', action:'saveTeamCommentRedirect')
        
        /*User*/
        "/user/mycampaigns"(controller:'user', action:'myproject')
        "/users/dashboard"(controller:'user', action:'accountSetting')
		
        "/user/edituserprofile"(controller:'user', action:'edituserprofile')
        "/user/campaigns"(controller:'user', action:'mycampaigns')
        "/user/contributions"(controller:'user', action:'mycontributions')
        "/user/edit-userInfo"(controller:'user', action:'edituserinfo')
        "/user/edit-location"(controller:'user', action:'editlocation')
        
        /*Partner*/
        "/partner/dashboard"(controller:'user', action:'partnerdashboard')
    }
}
