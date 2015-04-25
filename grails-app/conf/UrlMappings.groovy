class UrlMappings {

    static mappings = {
        "/$controller/$action?/$id?(.$format)?"{
            constraints {
                // apply constraints here
            }
        }

        "/"(controller: 'home', action: 'index')
        "500"(controller: "error")

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
	"/campaign/saveRedirect/$id"(controller:'project', action:'saveRedirect')
	"/campaigns/managecampaign/$projectTitle/$fundraiser"(controller:'project', action:'manageproject')
	"/campaign/managecampaign/$projectTitle/$fundraiser"(controller:'project', action:'updatesave')
	"/campaigns/managecampaigns/$projectTitle/$fundraiser"(controller:'project', action:'validateteam')
	"/campaign/managecampaigns/$projectTitle/$fundraiser"(controller:'project', action:'customrewardsave')
	"/campaign/managecampaigns/offlineContibution/$projectTitle/$fundraiser"(controller:'fund', action:'saveOfflineContribution')
	"/campaign/managecampaigns/editContibution/$projectTitle/$fundraiser"(controller:'project', action:'contributionedit')
	"/campaign/managecampaigns/deleteContibution/$projectTitle/$fundraiser"(controller:'project', action:'contributiondelete')
	"/campaign/managecampaigns/commentDelete/$projectTitle/$fundraiser"(controller:'project', action:'commentdelete')
	"/campaign/edit/$projectTitle/$fundraiser"(controller:'project', action:'edit')
	"/campaigns/request/$projectTitle/$fundraiser"(controller:'project', action:'addFundRaiser')
	"/campaigns/edit/$projectTitle/$fundraiser"(controller:'project', action:'editFundraiser')
	"/campaign/campaignupdate/$projectTitle/$fundraiser"(controller:'project', action:'projectupdate')
	"/campaign/updatesaverender"(controller:'project', action:'updatesaverender')
        "/campaigns"(controller:'project', action:'list')
        "/campaigns-widget"(controller:'project', action:'listwidget')
        "/campaigns/$projectTitle/$fundraiser"(controller:'project', action:'show')
		"/campaigns/invite/$projectTitle/$fundraiser"(controller:'project', action:'inviteTeamMember')
		"/campaign/$projectTitle/$fundraiser/"(controller:'project', action:'saveComment')
        "/campaigns/$id/thumbnail"(controller:'project', action:'thumbnail')
        "/campaigns/$id/fund"(controller:'fund', action:'fund')
        "/campaign/query"(controller:'project' , action:'search')
        "/campaign"(controller:'project' , action:'categoryFilter')
	"/campaign/validateList"(controller:'project', action:'validateList')
	"/campaign/validateshow"(controller:'project', action:'validateshow')
	"/campaign/sendemail"(controller:'project', action:'sendemail')
	"/campaign/sortby"(controller:'project', action:'sortCampaign')

        /* Admin */
        "/admin/dashboard"(controller:'user', action:'admindashboard')
        "/admin/importcampaigns"(controller: 'project', action: 'importprojects')

        /* Community */
        "/community/$communityId/manage"(controller: 'community', action: 'manage')

        /* Facebook login */
        "/facebookauthfailure"(controller:'login', action:'facebook_user_denied')
        
        /*Paypal*/
        "/fund/paypalReturn"(controller: 'fund', action: 'paypalReturn')
		
	/*User*/
	"/user/mycampaigns"(controller:'user', action:'myproject')
       "/users/dashboard"(controller:'user', action:'accountSetting')
       
    /*contributionComments*/
    "/funds/acknowledge"(controller: 'fund', action: 'editContributionComment')
    }
}
