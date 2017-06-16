import java.net.Authenticator.RequestorType;

class UrlMappings {
	
		static mappings = {
		"/$controller/$action?/$id?(.$format)?"{
			constraints {
				// apply constraints here
			}
		}
		/*Changes made to prefix country_code in all the URL's displayed in the browser*/
		name showCampaign: "/$country_code/$category/$projectTitle?/$fr?" {
			controller = 'project'
			action = 'showCampaign'
		}

		"/"(controller: 'home', action: 'indexToRedirect')
		"/$country_code"(controller: 'home', action: 'index')
		"/campaigns/$projectTitle/$teamtitle?"(controller : 'project',action :'displayProjectFromCustomUrl')
		"/$country_code/login/auth"(controller: 'login', action: 'auth')
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
		
		/* Feedback/Survey*/
		"/survey" (view:'/survey/index')
		
		/* Ebook */
		"/crowdfunding-ebook"(view:'/ebook/index')

		/* How it Works */
		"/howitworks"(view:'/howitworks/index')
		
		/*****Home page campaigns******/
		"/desktop_campaigns"(view:'/home/desktop_campaigns')
		"/mobile_campaigns"(view:'/home/mobile_campaigns')
		"/carouseltemplate"(view:'/project/validate/carouseltemplate')

		/*Terms of Use*/
		"/termsofuse"(view:'/termsofuse/index')
		"/in/tos"(view:'/termsofuse/india-tos')
		

		/*privacy policy*/
		"/privacypolicy"(view:'/privacypolicy/index')

		/* FAQ */
		"/faq"(view:'/faq/index')
		
		/* Learn More */
		"/Creating-Campaign"(view: '/learnMore/creating_campaign')
		"/Perks"(view: '/learnMore/perks')
		"/Contributor"(view: '/learnMore/contributor')
		"/Managing-Campaign"(view:'learnMore/managingCampaign')
		"/Learning-Center"(view: 'learnMore/learningCenter')
		"/Learning-Center/${question}"(controller:"home", action:'getLearnMore')
		
		/*Transaction Fee Details*/
		"/Fee-and-Pricing-Information"(view: '/transactionFee/pricingPage')

		/*Url shortener*/
		"/c/$url"(controller: 'project', action:'getCampaignFromShortUrl')

		/* Contact Us */
		"/customer-service"(view:'/contactus/index')
		"/customer-support"(controller:'project', action:'customerSupport')

		/* Blogs */
		"/blogs"(controller:'blog', action:'list')
		"/blogs/$id"(controller:'blog', action:'show')

		/* Project */
		name createCampaign: "/$country_code/campaign/create" {
			controller = 'project'
			action = 'create'
		}
		"/$country_code/project/createNow"(controller:'project', action:'createNow')
		"/$country_code/campaign/start/$title"(controller:'project', action:'redirectCreateNow')
		"/$country_code/$category/campaign/success/$title"(controller:'project', action:'launch')

        "/$country_code/project/campaignOnDraftAndLaunch"(controller:'project', action:'campaignOnDraftAndLaunch')
        
		"/campaign/save/$projectTitle"(controller:'project', action:'saveProject')
		"/campaign/draft/$projectTitle"(controller:'project', action:'draftProject')
		name managecampaign: "/$country_code/campaign/managecampaign" {
			controller = 'project'
			action = 'manageCampaign'
		}
		"/$country_code/campaign/managecampaign/$projectTitle"(controller:'project', action:'manageproject')
		"/$country_code/campaign/$projectTitle/$fr/preview"(controller:'project', action:'preview')
		"/$country_code/campaign/$projectTitle/$fr/pre-view"(controller:'project', action:'previewTile')
		"/$country_code/campaign/managecampaign/$projectTitle/$offset"(controller:'project', action:'manageproject')
		"/$country_code/campaign/managecampaign/$projectTitle/$offset/$max"(controller:'project', action:'manageproject')
		name editCampaign: "/$country_code/campaign/editCampaign" {
			controller = 'project'
			action = 'editCampaign'
		}
		"/$country_code/campaign/edit/$projectTitle"(controller:'project', action:'edit')
		
		
		"/campaigns/addFundRaiser/$id"(controller:'project', action:'addFundRaiser')
		"/campaign/campaignupdate/$projectTitle"(controller:'project', action:'projectupdate')
		"/campaign/updatesaverender"(controller:'project', action:'updatesaverender')
		name listCampaigns :  "/$country_code/campaigns"{
			controller = 'project'
			action = 'list'
		}
		"/campaigns-widget"(controller:'project', action:'listwidget')
		
//        "/campaigns/$id"(controller:'project', action:'showCampaign')
		 "/$country_code/$category/$projectTitle?/$fr?"(controller:'project', action:'show')
		"/$country_code/campaigns/$projectTitle/$fr/$teamCommentId"(controller:'project', action:'show')
		"/$country_code/campaigns/$projectTitle/$fr/$commentId"(controller:'project', action:'show')
		"/$country_code/campaigns/$projectTitle"(controller:'project', action:'show')
		
			   
		"/campaigns/$id/thumbnail"(controller:'project', action:'thumbnail')
		"/campaigns/$id/fund"(controller:'fund', action:'fund')
		"/campaign"(controller:'project' , action:'search')
		"/campaigns/country/$country"(controller:'project' , action:'categoryFilter')
		"/campaigns/category/$category"(controller:'project' , action:'categoryFilter')
		"/campaigns/usedfor/$usedfor"(controller:'project' , action:'categoryFilter')
		"/campaign/validateList"(controller:'project', action:'validateList')
		"/campaign/validateshow/$projectTitle/$fr"(controller:'project', action:'validateshow')
		"/campaign/sendemail"(controller:'project', action:'sendemail')
		"/$country_code/campaign/sortby/$query"(controller:'project', action:'sortCampaign')
		"/campaign/$projectTitle/update/edit/$id"(controller:'project', action:'editUpdate')
		"/campaign/supporter/$projectId/$fundRaiser"(controller:'project', action:'addcampaignsupporter')
		"/campaign/$projectTitle/$fr/embed/tile"(controller:'project', action:'embedTile')
		"/campaign/$btnparam/$vanityTitle/$fr/embed/donatetile"(controller:'project', action:'embedDonationButton')
		
		"/campaign/inviteMember/$projectId/$page?"(controller:'project', action:'inviteMember')
		
		"/campaigns/updateShare"(controller:'project', action:'updateShare')
		"/campaigns/campaignshare"(controller:'project', action:'campaignShare')
		
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
		"/fund/getOfflineContribution/$id"(controller:'fund', action:'getOfflineContribution')
		
		/*User*/
		"/user/mycampaigns"(controller:'user', action:'myproject')
		"/users/dashboard"(controller:'user', action:'accountSetting')
		
		"/user/edituserprofile"(controller:'user', action:'edituserprofile')
		"/user/campaigns"(controller:'user', action:'mycampaigns')
		"/user/contributions"(controller:'user', action:'mycontributions')
		"/user/edit-userInfo"(controller:'user', action:'edituserinfo')
		"/user/edit-location"(controller:'user', action:'editlocation')
		"/user/userprofile/$id"(controller:'user', action:'userActivity1')
		"/user/userprofile/$amount/$id"(controller:'user', action:'userActivity')
		"/user/$vanityTitle/contributors"(controller:'user', action:'showContributor')

		/*Partner*/
		"/partner/dashboard"(controller:'user', action:'partnerdashboard')
		"/partner/dashboard/$id"(controller:'user', action:'partnerdashboard')
		"/partners"(controller:'user', action:'partners')
		"/partnering-with-crowdera"(controller:'user', action:'partnerFaq')
		"/partner/new"(controller:'user', action:'createpartner')
		"/partner/edit"(controller:'user', action:'editpartner')
		
		/*Tax Receipt*/
		"/user/exportTaxReceiptPdf/$id" (controller:'user', action:'exportTaxReceiptPdf')
	}
}
