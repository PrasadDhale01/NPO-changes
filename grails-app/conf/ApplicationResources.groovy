environments{
	development {
		modules = {
			/* JS */
			lessjs {
				resource url: 'vendor/less/less.min.js', disposition: 'head'
			}
			jquery {
				resource url: 'vendor/jquery/jquery-2.1.0.js'
			}
			handlebarsjs {
				resource url: 'vendor/handlebars/handlebars.min.js'
			}
			underscorejs {
				resource url: 'vendor/underscore/underscore-min.js'
				resource url: 'vendor/underscore/underscore.string.min.js'
			}
			corejs {
				dependsOn 'jquery', 'handlebarsjs'
				resource url: 'vendor/bootstrap-3.2.0-dist/js/bootstrap.min.js'
				resource url: 'vendor/bootstrap-hover-dropdown-master/bootstrap-hover-dropdown.min.js'
			}
			jqueryvalidate {
				dependsOn 'corejs'
				resource url: 'vendor/jquery.validate/jquery.validate.js'
			}
			crowderajs {
				dependsOn 'corejs', 'bootstrapselectjs', 'bootstrapmultiselectjs', 'jqueryvalidate'
				resource url: 'js/crowdera.js'
				resource url: 'js/redactor/redactor.js'
				resource url: 'js/redactor/plugins/video.js'
			}
			googleanalytics {
				resource url: 'js/ga.js'
			}
			bootstrapselectjs {
				resource url: 'vendor/bootstrap-select/bootstrap-select.js'
			}
			bootstrapmultiselectjs {
				resource url: 'vendor/bootstrap-multiselect/bootstrap-multiselect.js'
			}
			blacknwhitejs {
				dependsOn 'corejs'
				resource url: 'js/external/jquery.BlackAndWhite.js'
			}
			tableclothjs {
				dependsOn 'corejs'
				resource url: 'tablecloth/js/jquery.metadata.js'
				resource url: 'tablecloth/js/jquery.tablesorter.js'
				resource url: 'tablecloth/js/jquery.tablecloth.js'
			}
		
			/* Page-specific JS */
			/* Home */
			homejs {
				dependsOn 'crowderajs', 'blacknwhitejs'
				resource url: 'js/home/home.js'
			}
			/* Login */
			loginjs {
				dependsOn 'crowderajs'
				resource url: 'js/home/login.js'
			}
			registrationjs {
				dependsOn 'crowderajs'
				resource url: 'js/home/registration.js'
			}
			/* Project */
			projectcreatejs {
				dependsOn 'crowderajs', 'handlebarsjs'
				resource url: 'js/project/create.js'
			}
			projectshowjs {
				dependsOn 'crowderajs'
				resource url: 'js/project/show.js'
			}
			projectlistjs {
				dependsOn 'crowderajs', 'blacknwhitejs'
				resource url: 'js/project/list.js'
			}
			projecteditjs {
				dependsOn 'crowderajs', 'blacknwhitejs'
				resource url: 'js/project/edit.js'
			}
			/* Fund */
			fundjs {
				dependsOn 'underscorejs', 'crowderajs'
				resource url: 'js/fund/fund.js'
			}
			checkoutjs {
				dependsOn 'crowderajs'
				resource url: 'js/fund/checkout.js'
			}
			/* Community */
			communitycreatejs {
				dependsOn 'crowderajs'
				resource url: 'js/community/create.js'
			}
			communitymanagejs {
				dependsOn 'crowderajs'
				resource url: 'js/community/manage.js'
			}
			/* Rewards */
			rewardjs {
				dependsOn 'crowderajs'
				resource url: 'js/reward.js'
			}
			/* User */
			userjs {
				dependsOn 'crowderajs'
				resource url: 'js/user.js'
			}
		
			/* CSS */
			fontawesomecss {
				resource url: 'vendor/font-awesome-4.2.0/css/font-awesome.min.css', attrs: [media: 'screen']
			}
			piecss {
				resource url: 'css/pie.css', attrs: [media: 'screen']
			}
			crowderacss {
				dependsOn 'bootswatchcss', 'bootstrapselectcss', 'bootstrapmultiselectcss', 'fontawesomecss', 'piecss', 'campaigncss', 'usercss', 'fundcss', 'showcss', 'mediacss'
				resource url: 'css/crowdera.css', attrs: [media: 'screen']
				resource url: 'js/redactor/redactor.css', attrs: [media: 'screen']
			}
			campaigncss {
				resource url: 'css/campaign.css', attrs: [media: 'screen']
			}
			usercss {
				resource url: 'css/user.css', attrs: [media: 'screen']
			}
			fundcss {
				resource url: 'css/fund.css', attrs: [media: 'screen']
			}
			showcss {
				resource url: 'css/show.css', attrs: [media: 'screen']
			}
			mediacss {
				resource url: 'css/media.css', attrs: [media: 'screen']
			}
			timelinecss {
				dependsOn 'crowderacss'
				resource url: 'css/timeline.css', attrs: [media: 'screen']
			}
			bootstrapcss {
				resource url: 'vendor/bootstrap-3.2.0-dist/css/bootstrap.min.css', attrs: [media: 'screen']
			}
			bootstrapselectcss {
				resource url: 'vendor/bootstrap-select/bootstrap-select.css', attrs: [media: 'screen']
			}
			bootstrapmultiselectcss {
				resource url: 'vendor/bootstrap-multiselect/bootstrap-multiselect.css', attrs: [media: 'screen']
			}
			bootstrapsocialcss {
				/* http://lipis.github.io/bootstrap-social/ */
				dependsOn 'bootswatchcss', 'fontawesomecss'
				resource url: 'vendor/bootstrap-social/bootstrap-social.min.css', attrs: [media: 'screen']
			}
			bootswatchcss {
				dependsOn 'bootswatchyeticss'
			}
			tableclothcss {
				dependsOn 'bootswatchcss'
				resource url: 'tablecloth/css/bootstrap-tables.css', attrs: [media: 'screen']
				resource url: 'tablecloth/css/tablecloth.css', attrs: [media: 'screen']
			}
		
			bootswatchyeticss {
				resource url: 'bootswatch-yeti/bootstrap.css', attrs: [media: 'screen']
			}
		}
	}
	
	test{
		modules = {
			lessjs {
				resource url: 'http://d1hsbjre03buja.cloudfront.net/vendor/less/less.min.js', disposition: 'head'
			}
			jquery {
				resource url: 'http://d1hsbjre03buja.cloudfront.net/vendor/jquery/jquery-2.1.0.js'
			}
			handlebarsjs {
				resource url: 'http://d1hsbjre03buja.cloudfront.net/vendor/handlebars/handlebars.min.js'
			}
			underscorejs {
				resource url: 'http://d1hsbjre03buja.cloudfront.net/vendor/underscore/underscore-min.js'
				resource url: 'http://d1hsbjre03buja.cloudfront.net/vendor/underscore/underscore.string.min.js'
			}
			corejs {
				dependsOn 'jquery', 'handlebarsjs'
				resource url: 'http://d1hsbjre03buja.cloudfront.net/vendor/bootstrap-3.2.0-dist/js/bootstrap.min.js'
				resource url: 'http://d1hsbjre03buja.cloudfront.net/vendor/bootstrap-hover-dropdown-master/bootstrap-hover-dropdown.min.js'
			}
			jqueryvalidate {
				dependsOn 'corejs'
				resource url: 'http://d1hsbjre03buja.cloudfront.net/vendor/jquery.validate/jquery.validate.js'
			}
			crowderajs {
				dependsOn 'corejs', 'bootstrapselectjs', 'bootstrapmultiselectjs', 'jqueryvalidate'
				resource url: 'http://d1hsbjre03buja.cloudfront.net/js/crowdera.js'
				resource url: 'http://d1hsbjre03buja.cloudfront.net/js/redactor/redactor.js'
				resource url: 'http://d1hsbjre03buja.cloudfront.net/js/redactor/plugins/video.js'
			}
			googleanalytics {
				resource url: 'http://d1hsbjre03buja.cloudfront.net/js/ga.js'
			}
			bootstrapselectjs {
				resource url: 'http://d1hsbjre03buja.cloudfront.net/vendor/bootstrap-select/bootstrap-select.js'
			}
			bootstrapmultiselectjs {
				resource url: 'http://d1hsbjre03buja.cloudfront.net/vendor/bootstrap-multiselect/bootstrap-multiselect.js'
			}
			blacknwhitejs {
				dependsOn 'corejs'
				resource url: 'http://d1hsbjre03buja.cloudfront.net/js/external/jquery.BlackAndWhite.js'
			}
			tableclothjs {
				dependsOn 'corejs'
				resource url: 'http://d1hsbjre03buja.cloudfront.net/tablecloth/js/jquery.metadata.js'
				resource url: 'http://d1hsbjre03buja.cloudfront.net/tablecloth/js/jquery.tablesorter.js'
				resource url: 'http://d1hsbjre03buja.cloudfront.net/tablecloth/js/jquery.tablecloth.js'
			}
		
			/* Page-specific JS */
			/* Home */
			homejs {
				dependsOn 'crowderajs', 'blacknwhitejs'
				resource url: 'http://d1hsbjre03buja.cloudfront.net/js/home/home.js'
			}
			/* Login */
			loginjs {
				dependsOn 'crowderajs'
				resource url: 'http://d1hsbjre03buja.cloudfront.net/js/home/login.js'
			}
			registrationjs {
				dependsOn 'crowderajs'
				resource url: 'http://d1hsbjre03buja.cloudfront.net/js/home/registration.js'
			}
			/* Project */
			projectcreatejs {
				dependsOn 'crowderajs', 'handlebarsjs'
				resource url: 'http://d1hsbjre03buja.cloudfront.net/js/project/create.js'
			}
			projectshowjs {
				dependsOn 'crowderajs'
				resource url: 'http://d1hsbjre03buja.cloudfront.net/js/project/show.js'
			}
			projectlistjs {
				dependsOn 'crowderajs', 'blacknwhitejs'
				resource url: 'http://d1hsbjre03buja.cloudfront.net/js/project/list.js'
			}
			projecteditjs {
				dependsOn 'crowderajs', 'blacknwhitejs'
				resource url: 'http://d1hsbjre03buja.cloudfront.net/js/project/edit.js'
			}
			/* Fund */
			fundjs {
				dependsOn 'underscorejs', 'crowderajs'
				resource url: 'http://d1hsbjre03buja.cloudfront.net/js/fund/fund.js'
			}
			checkoutjs {
				dependsOn 'crowderajs'
				resource url: 'http://d1hsbjre03buja.cloudfront.net/js/fund/checkout.js'
			}
			/* Community */
			communitycreatejs {
				dependsOn 'crowderajs'
				resource url: 'http://d1hsbjre03buja.cloudfront.net/js/community/create.js'
			}
			communitymanagejs {
				dependsOn 'crowderajs'
				resource url: 'http://d1hsbjre03buja.cloudfront.net/js/community/manage.js'
			}
			/* Rewards */
			rewardjs {
				dependsOn 'crowderajs'
				resource url: 'http://d1hsbjre03buja.cloudfront.net/js/reward.js'
			}
			/* User */
			userjs {
				dependsOn 'crowderajs'
				resource url: 'http://d1hsbjre03buja.cloudfront.net/js/user.js'
			}
		
			/* CSS */
			fontawesomecss {
				resource url: 'http://d1hsbjre03buja.cloudfront.net/vendor/font-awesome-4.2.0/css/font-awesome.min.css', attrs: [media: 'screen']
			}
			piecss {
				resource url: 'http://d1hsbjre03buja.cloudfront.net/css/pie.css', attrs: [media: 'screen']
			}
			crowderacss {
				dependsOn 'bootswatchcss', 'bootstrapselectcss', 'bootstrapmultiselectcss', 'fontawesomecss', 'piecss', 'campaigncss', 'usercss', 'fundcss', 'showcss', 'mediacss'
				resource url: 'http://d1hsbjre03buja.cloudfront.net/css/crowdera.css', attrs: [media: 'screen']
				resource url: 'http://d1hsbjre03buja.cloudfront.net/js/redactor/redactor.css', attrs: [media: 'screen']
			}
			campaigncss {
				resource url: 'http://d1hsbjre03buja.cloudfront.net/css/campaign.css', attrs: [media: 'screen']
			}
			usercss {
				resource url: 'http://d1hsbjre03buja.cloudfront.net/css/user.css', attrs: [media: 'screen']
			}
			fundcss {
				resource url: 'http://d1hsbjre03buja.cloudfront.net/css/fund.css', attrs: [media: 'screen']
			}
			showcss {
				resource url: 'http://d1hsbjre03buja.cloudfront.net/css/show.css', attrs: [media: 'screen']
			}
			mediacss {
				resource url: 'http://d1hsbjre03buja.cloudfront.net/css/media.css', attrs: [media: 'screen']
			}
			timelinecss {
				dependsOn 'crowderacss'
				resource url: 'http://d1hsbjre03buja.cloudfront.net/css/timeline.css', attrs: [media: 'screen']
			}
			bootstrapcss {
				resource url: 'http://d1hsbjre03buja.cloudfront.net/vendor/bootstrap-3.2.0-dist/css/bootstrap.min.css', attrs: [media: 'screen']
			}
			bootstrapselectcss {
				resource url: 'http://d1hsbjre03buja.cloudfront.net/vendor/bootstrap-select/bootstrap-select.css', attrs: [media: 'screen']
			}
			bootstrapmultiselectcss {
				resource url: 'http://d1hsbjre03buja.cloudfront.net/vendor/bootstrap-multiselect/bootstrap-multiselect.css', attrs: [media: 'screen']
			}
			bootstrapsocialcss {
				/* http://lipis.github.io/bootstrap-social/ */
				dependsOn 'bootswatchcss', 'fontawesomecss'
				resource url: 'http://d1hsbjre03buja.cloudfront.net/vendor/bootstrap-social/bootstrap-social.min.css', attrs: [media: 'screen']
			}
			bootswatchcss {
				dependsOn 'bootswatchyeticss'
			}
			tableclothcss {
				dependsOn 'bootswatchcss'
				resource url: 'http://d1hsbjre03buja.cloudfront.net/tablecloth/css/bootstrap-tables.css', attrs: [media: 'screen']
				resource url: 'http://d1hsbjre03buja.cloudfront.net/tablecloth/css/tablecloth.css', attrs: [media: 'screen']
			}
		
			bootswatchyeticss {
				resource url: 'http://d1hsbjre03buja.cloudfront.net/bootswatch-yeti/bootstrap.css', attrs: [media: 'screen']
			}
		}
	}
	
	staging{
		modules = {
			/* JS */
			lessjs {
				resource url: 'vendor/less/less.min.js', disposition: 'head'
			}
			jquery {
				resource url: 'vendor/jquery/jquery-2.1.0.js'
			}
			handlebarsjs {
				resource url: 'vendor/handlebars/handlebars.min.js'
			}
			underscorejs {
				resource url: 'vendor/underscore/underscore-min.js'
				resource url: 'vendor/underscore/underscore.string.min.js'
			}
			corejs {
				dependsOn 'jquery', 'handlebarsjs'
				resource url: 'vendor/bootstrap-3.2.0-dist/js/bootstrap.min.js'
				resource url: 'vendor/bootstrap-hover-dropdown-master/bootstrap-hover-dropdown.min.js'
			}
			jqueryvalidate {
				dependsOn 'corejs'
				resource url: 'vendor/jquery.validate/jquery.validate.js'
			}
			crowderajs {
				dependsOn 'corejs', 'bootstrapselectjs', 'bootstrapmultiselectjs', 'jqueryvalidate'
				resource url: 'js/crowdera.js'
				resource url: 'js/redactor/redactor.js'
				resource url: 'js/redactor/plugins/video.js'
			}
			googleanalytics {
				resource url: 'js/ga.js'
			}
			bootstrapselectjs {
				resource url: 'vendor/bootstrap-select/bootstrap-select.js'
			}
			bootstrapmultiselectjs {
				resource url: 'vendor/bootstrap-multiselect/bootstrap-multiselect.js'
			}
			blacknwhitejs {
				dependsOn 'corejs'
				resource url: 'js/external/jquery.BlackAndWhite.js'
			}
			tableclothjs {
				dependsOn 'corejs'
				resource url: 'tablecloth/js/jquery.metadata.js'
				resource url: 'tablecloth/js/jquery.tablesorter.js'
				resource url: 'tablecloth/js/jquery.tablecloth.js'
			}
		
			/* Page-specific JS */
			/* Home */
			homejs {
				dependsOn 'crowderajs', 'blacknwhitejs'
				resource url: 'js/home/home.js'
			}
			/* Login */
			loginjs {
				dependsOn 'crowderajs'
				resource url: 'js/home/login.js'
			}
			registrationjs {
				dependsOn 'crowderajs'
				resource url: 'js/home/registration.js'
			}
			/* Project */
			projectcreatejs {
				dependsOn 'crowderajs', 'handlebarsjs'
				resource url: 'js/project/create.js'
			}
			projectshowjs {
				dependsOn 'crowderajs'
				resource url: 'js/project/show.js'
			}
			projectlistjs {
				dependsOn 'crowderajs', 'blacknwhitejs'
				resource url: 'js/project/list.js'
			}
			projecteditjs {
				dependsOn 'crowderajs', 'blacknwhitejs'
				resource url: 'js/project/edit.js'
			}
			/* Fund */
			fundjs {
				dependsOn 'underscorejs', 'crowderajs'
				resource url: 'js/fund/fund.js'
			}
			checkoutjs {
				dependsOn 'crowderajs'
				resource url: 'js/fund/checkout.js'
			}
			/* Community */
			communitycreatejs {
				dependsOn 'crowderajs'
				resource url: 'js/community/create.js'
			}
			communitymanagejs {
				dependsOn 'crowderajs'
				resource url: 'js/community/manage.js'
			}
			/* Rewards */
			rewardjs {
				dependsOn 'crowderajs'
				resource url: 'js/reward.js'
			}
			/* User */
			userjs {
				dependsOn 'crowderajs'
				resource url: 'js/user.js'
			}
		
			/* CSS */
			fontawesomecss {
				resource url: 'vendor/font-awesome-4.2.0/css/font-awesome.min.css', attrs: [media: 'screen']
			}
			piecss {
				resource url: 'css/pie.css', attrs: [media: 'screen']
			}
			crowderacss {
				dependsOn 'bootswatchcss', 'bootstrapselectcss', 'bootstrapmultiselectcss', 'fontawesomecss', 'piecss', 'campaigncss', 'usercss', 'fundcss', 'showcss', 'mediacss'
				resource url: 'css/crowdera.css', attrs: [media: 'screen']
				resource url: 'js/redactor/redactor.css', attrs: [media: 'screen']
			}
			campaigncss {
				resource url: 'css/campaign.css', attrs: [media: 'screen']
			}
			usercss {
				resource url: 'css/user.css', attrs: [media: 'screen']
			}
			fundcss {
				resource url: 'css/fund.css', attrs: [media: 'screen']
			}
			showcss {
				resource url: 'css/show.css', attrs: [media: 'screen']
			}
			mediacss {
				resource url: 'css/media.css', attrs: [media: 'screen']
			}
			timelinecss {
				dependsOn 'crowderacss'
				resource url: 'css/timeline.css', attrs: [media: 'screen']
			}
			bootstrapcss {
				resource url: 'vendor/bootstrap-3.2.0-dist/css/bootstrap.min.css', attrs: [media: 'screen']
			}
			bootstrapselectcss {
				resource url: 'vendor/bootstrap-select/bootstrap-select.css', attrs: [media: 'screen']
			}
			bootstrapmultiselectcss {
				resource url: 'vendor/bootstrap-multiselect/bootstrap-multiselect.css', attrs: [media: 'screen']
			}
			bootstrapsocialcss {
				/* http://lipis.github.io/bootstrap-social/ */
				dependsOn 'bootswatchcss', 'fontawesomecss'
				resource url: 'vendor/bootstrap-social/bootstrap-social.min.css', attrs: [media: 'screen']
			}
			bootswatchcss {
				dependsOn 'bootswatchyeticss'
			}
			tableclothcss {
				dependsOn 'bootswatchcss'
				resource url: 'tablecloth/css/bootstrap-tables.css', attrs: [media: 'screen']
				resource url: 'tablecloth/css/tablecloth.css', attrs: [media: 'screen']
			}
		
			bootswatchyeticss {
				resource url: 'bootswatch-yeti/bootstrap.css', attrs: [media: 'screen']
			}
		}
	}
	
	production{
		modules = {
			/* JS */
			lessjs {
				resource url: 'https://d38k0frcj7wnf2.cloudfront.net/vendor/less/less.min.js', disposition: 'head'
			}
			jquery {
				resource url: 'https://d38k0frcj7wnf2.cloudfront.net/vendor/jquery/jquery-2.1.0.js'
			}
			handlebarsjs {
				resource url: 'https://d38k0frcj7wnf2.cloudfront.net/vendor/handlebars/handlebars.min.js'
			}
			underscorejs {
				resource url: 'https://d38k0frcj7wnf2.cloudfront.net/vendor/underscore/underscore-min.js'
				resource url: 'https://d38k0frcj7wnf2.cloudfront.net/vendor/underscore/underscore.string.min.js'
			}
			corejs {
				dependsOn 'jquery', 'handlebarsjs'
				resource url: 'https://d38k0frcj7wnf2.cloudfront.net/https://d38k0frcj7wnf2.cloudfront.net/vendor/bootstrap-3.2.0-dist/js/bootstrap.min.js'
				resource url: 'vendor/bootstrap-hover-dropdown-master/bootstrap-hover-dropdown.min.js'
			}
			jqueryvalidate {
				dependsOn 'corejs'
				resource url: 'https://d38k0frcj7wnf2.cloudfront.net/vendor/jquery.validate/jquery.validate.js'
			}
			crowderajs {
				dependsOn 'corejs', 'bootstrapselectjs', 'bootstrapmultiselectjs', 'jqueryvalidate'
				resource url: 'https://d38k0frcj7wnf2.cloudfront.net/js/crowdera.js'
				resource url: 'https://d38k0frcj7wnf2.cloudfront.net/js/redactor/redactor.js'
				resource url: 'https://d38k0frcj7wnf2.cloudfront.net/js/redactor/plugins/video.js'
			}
			googleanalytics {
				resource url: 'js/ga.js'
			}
			bootstrapselectjs {
				resource url: 'https://d38k0frcj7wnf2.cloudfront.net/vendor/bootstrap-select/bootstrap-select.js'
			}
			bootstrapmultiselectjs {
				resource url: 'https://d38k0frcj7wnf2.cloudfront.net/vendor/bootstrap-multiselect/bootstrap-multiselect.js'
			}
			blacknwhitejs {
				dependsOn 'corejs'
				resource url: 'https://d38k0frcj7wnf2.cloudfront.net/js/external/jquery.BlackAndWhite.js'
			}
			tableclothjs {
				dependsOn 'corejs'
				resource url: 'https://d38k0frcj7wnf2.cloudfront.net/tablecloth/js/jquery.metadata.js'
				resource url: 'https://d38k0frcj7wnf2.cloudfront.net/tablecloth/js/jquery.tablesorter.js'
				resource url: 'https://d38k0frcj7wnf2.cloudfront.net/tablecloth/js/jquery.tablecloth.js'
			}
		
			/* Page-specific JS */
			/* Home */
			homejs {
				dependsOn 'crowderajs', 'blacknwhitejs'
				resource url: 'https://d38k0frcj7wnf2.cloudfront.net/js/home/home.js'
			}
			/* Login */
			loginjs {
				dependsOn 'crowderajs'
				resource url: 'https://d38k0frcj7wnf2.cloudfront.net/js/home/login.js'
			}
			registrationjs {
				dependsOn 'crowderajs'
				resource url: 'https://d38k0frcj7wnf2.cloudfront.net/js/home/registration.js'
			}
			/* Project */
			projectcreatejs {
				dependsOn 'crowderajs', 'handlebarsjs'
				resource url: 'https://d38k0frcj7wnf2.cloudfront.net/js/project/create.js'
			}
			projectshowjs {
				dependsOn 'crowderajs'
				resource url: 'https://d38k0frcj7wnf2.cloudfront.net/js/project/show.js'
			}
			projectlistjs {
				dependsOn 'crowderajs', 'blacknwhitejs'
				resource url: 'https://d38k0frcj7wnf2.cloudfront.net/js/project/list.js'
			}
			projecteditjs {
				dependsOn 'crowderajs', 'blacknwhitejs'
				resource url: 'https://d38k0frcj7wnf2.cloudfront.net/js/project/edit.js'
			}
			/* Fund */
			fundjs {
				dependsOn 'underscorejs', 'crowderajs'
				resource url: 'https://d38k0frcj7wnf2.cloudfront.net/js/fund/fund.js'
			}
			checkoutjs {
				dependsOn 'crowderajs'
				resource url: 'https://d38k0frcj7wnf2.cloudfront.net/js/fund/checkout.js'
			}
			/* Community */
			communitycreatejs {
				dependsOn 'crowderajs'
				resource url: 'https://d38k0frcj7wnf2.cloudfront.net/js/community/create.js'
			}
			communitymanagejs {
				dependsOn 'crowderajs'
				resource url: 'https://d38k0frcj7wnf2.cloudfront.net/js/community/manage.js'
			}
			/* Rewards */
			rewardjs {
				dependsOn 'crowderajs'
				resource url: 'https://d38k0frcj7wnf2.cloudfront.net/js/reward.js'
			}
			/* User */
			userjs {
				dependsOn 'crowderajs'
				resource url: 'https://d38k0frcj7wnf2.cloudfront.net/js/user.js'
			}
		
			/* CSS */
			fontawesomecss {
				resource url: 'https://d38k0frcj7wnf2.cloudfront.net/vendor/font-awesome-4.2.0/css/font-awesome.min.css', attrs: [media: 'screen']
			}
			piecss {
				resource url: 'https://d38k0frcj7wnf2.cloudfront.net/css/pie.css', attrs: [media: 'screen']
			}
			crowderacss {
				dependsOn 'bootswatchcss', 'bootstrapselectcss', 'bootstrapmultiselectcss', 'fontawesomecss', 'piecss', 'campaigncss', 'usercss', 'fundcss', 'showcss', 'mediacss'
				resource url: 'https://d38k0frcj7wnf2.cloudfront.net/css/crowdera.css', attrs: [media: 'screen']
				resource url: 'https://d38k0frcj7wnf2.cloudfront.net/js/redactor/redactor.css', attrs: [media: 'screen']
			}
			campaigncss {
				resource url: 'https://d38k0frcj7wnf2.cloudfront.net/css/campaign.css', attrs: [media: 'screen']
			}
			usercss {
				resource url: 'https://d38k0frcj7wnf2.cloudfront.net/css/user.css', attrs: [media: 'screen']
			}
			fundcss {
				resource url: 'https://d38k0frcj7wnf2.cloudfront.net/css/fund.css', attrs: [media: 'screen']
			}
			showcss {
				resource url: 'https://d38k0frcj7wnf2.cloudfront.net/css/show.css', attrs: [media: 'screen']
			}
			mediacss {
				resource url: 'https://d38k0frcj7wnf2.cloudfront.net/css/media.css', attrs: [media: 'screen']
			}
			timelinecss {
				dependsOn 'crowderacss'
				resource url: 'https://d38k0frcj7wnf2.cloudfront.net/css/timeline.css', attrs: [media: 'screen']
			}
			bootstrapcss {
				resource url: 'https://d38k0frcj7wnf2.cloudfront.net/vendor/bootstrap-3.2.0-dist/css/bootstrap.min.css', attrs: [media: 'screen']
			}
			bootstrapselectcss {
				resource url: 'https://d38k0frcj7wnf2.cloudfront.net/vendor/bootstrap-select/bootstrap-select.css', attrs: [media: 'screen']
			}
			bootstrapmultiselectcss {
				resource url: 'https://d38k0frcj7wnf2.cloudfront.net/vendor/bootstrap-multiselect/bootstrap-multiselect.css', attrs: [media: 'screen']
			}
			bootstrapsocialcss {
				/* http://lipis.github.io/bootstrap-social/ */
				dependsOn 'bootswatchcss', 'fontawesomecss'
				resource url: 'https://d38k0frcj7wnf2.cloudfront.net/vendor/bootstrap-social/bootstrap-social.min.css', attrs: [media: 'screen']
			}
			bootswatchcss {
				dependsOn 'bootswatchyeticss'
			}
			tableclothcss {
				dependsOn 'bootswatchcss'
				resource url: 'https://d38k0frcj7wnf2.cloudfront.net/tablecloth/css/bootstrap-tables.css', attrs: [media: 'screen']
				resource url: 'https://d38k0frcj7wnf2.cloudfront.net/tablecloth/css/tablecloth.css', attrs: [media: 'screen']
			}
		
			bootswatchyeticss {
				resource url: 'https://d38k0frcj7wnf2.cloudfront.net/bootswatch-yeti/bootstrap.css', attrs: [media: 'screen']
			}
		}
	}
	
	testIndia{
		modules = {
			/* JS */
			lessjs {
				resource url: 'vendor/less/less.min.js', disposition: 'head'
			}
			jquery {
				resource url: 'vendor/jquery/jquery-2.1.0.js'
			}
			handlebarsjs {
				resource url: 'vendor/handlebars/handlebars.min.js'
			}
			underscorejs {
				resource url: 'vendor/underscore/underscore-min.js'
				resource url: 'vendor/underscore/underscore.string.min.js'
			}
			corejs {
				dependsOn 'jquery', 'handlebarsjs'
				resource url: 'vendor/bootstrap-3.2.0-dist/js/bootstrap.min.js'
				resource url: 'vendor/bootstrap-hover-dropdown-master/bootstrap-hover-dropdown.min.js'
			}
			jqueryvalidate {
				dependsOn 'corejs'
				resource url: 'vendor/jquery.validate/jquery.validate.js'
			}
			crowderajs {
				dependsOn 'corejs', 'bootstrapselectjs', 'bootstrapmultiselectjs', 'jqueryvalidate'
				resource url: 'js/crowdera.js'
				resource url: 'js/redactor/redactor.js'
				resource url: 'js/redactor/plugins/video.js'
			}
			googleanalytics {
				resource url: 'js/ga.js'
			}
			bootstrapselectjs {
				resource url: 'vendor/bootstrap-select/bootstrap-select.js'
			}
			bootstrapmultiselectjs {
				resource url: 'vendor/bootstrap-multiselect/bootstrap-multiselect.js'
			}
			blacknwhitejs {
				dependsOn 'corejs'
				resource url: 'js/external/jquery.BlackAndWhite.js'
			}
			tableclothjs {
				dependsOn 'corejs'
				resource url: 'tablecloth/js/jquery.metadata.js'
				resource url: 'tablecloth/js/jquery.tablesorter.js'
				resource url: 'tablecloth/js/jquery.tablecloth.js'
			}
		
			/* Page-specific JS */
			/* Home */
			homejs {
				dependsOn 'crowderajs', 'blacknwhitejs'
				resource url: 'js/home/home.js'
			}
			/* Login */
			loginjs {
				dependsOn 'crowderajs'
				resource url: 'js/home/login.js'
			}
			registrationjs {
				dependsOn 'crowderajs'
				resource url: 'js/home/registration.js'
			}
			/* Project */
			projectcreatejs {
				dependsOn 'crowderajs', 'handlebarsjs'
				resource url: 'js/project/create.js'
			}
			projectshowjs {
				dependsOn 'crowderajs'
				resource url: 'js/project/show.js'
			}
			projectlistjs {
				dependsOn 'crowderajs', 'blacknwhitejs'
				resource url: 'js/project/list.js'
			}
			projecteditjs {
				dependsOn 'crowderajs', 'blacknwhitejs'
				resource url: 'js/project/edit.js'
			}
			/* Fund */
			fundjs {
				dependsOn 'underscorejs', 'crowderajs'
				resource url: 'js/fund/fund.js'
			}
			checkoutjs {
				dependsOn 'crowderajs'
				resource url: 'js/fund/checkout.js'
			}
			/* Community */
			communitycreatejs {
				dependsOn 'crowderajs'
				resource url: 'js/community/create.js'
			}
			communitymanagejs {
				dependsOn 'crowderajs'
				resource url: 'js/community/manage.js'
			}
			/* Rewards */
			rewardjs {
				dependsOn 'crowderajs'
				resource url: 'js/reward.js'
			}
			/* User */
			userjs {
				dependsOn 'crowderajs'
				resource url: 'js/user.js'
			}
		
			/* CSS */
			fontawesomecss {
				resource url: 'vendor/font-awesome-4.2.0/css/font-awesome.min.css', attrs: [media: 'screen']
			}
			piecss {
				resource url: 'css/pie.css', attrs: [media: 'screen']
			}
			crowderacss {
				dependsOn 'bootswatchcss', 'bootstrapselectcss', 'bootstrapmultiselectcss', 'fontawesomecss', 'piecss', 'campaigncss', 'usercss', 'fundcss', 'showcss', 'mediacss'
				resource url: 'css/crowdera.css', attrs: [media: 'screen']
				resource url: 'js/redactor/redactor.css', attrs: [media: 'screen']
			}
			campaigncss {
				resource url: 'css/campaign.css', attrs: [media: 'screen']
			}
			usercss {
				resource url: 'css/user.css', attrs: [media: 'screen']
			}
			fundcss {
				resource url: 'css/fund.css', attrs: [media: 'screen']
			}
			showcss {
				resource url: 'css/show.css', attrs: [media: 'screen']
			}
			mediacss {
				resource url: 'css/media.css', attrs: [media: 'screen']
			}
			timelinecss {
				dependsOn 'crowderacss'
				resource url: 'css/timeline.css', attrs: [media: 'screen']
			}
			bootstrapcss {
				resource url: 'vendor/bootstrap-3.2.0-dist/css/bootstrap.min.css', attrs: [media: 'screen']
			}
			bootstrapselectcss {
				resource url: 'vendor/bootstrap-select/bootstrap-select.css', attrs: [media: 'screen']
			}
			bootstrapmultiselectcss {
				resource url: 'vendor/bootstrap-multiselect/bootstrap-multiselect.css', attrs: [media: 'screen']
			}
			bootstrapsocialcss {
				/* http://lipis.github.io/bootstrap-social/ */
				dependsOn 'bootswatchcss', 'fontawesomecss'
				resource url: 'vendor/bootstrap-social/bootstrap-social.min.css', attrs: [media: 'screen']
			}
			bootswatchcss {
				dependsOn 'bootswatchyeticss'
			}
			tableclothcss {
				dependsOn 'bootswatchcss'
				resource url: 'tablecloth/css/bootstrap-tables.css', attrs: [media: 'screen']
				resource url: 'tablecloth/css/tablecloth.css', attrs: [media: 'screen']
			}
		
			bootswatchyeticss {
				resource url: 'bootswatch-yeti/bootstrap.css', attrs: [media: 'screen']
			}
		}
	}
	
	stagingIndia{
		modules = {
			/* JS */
			lessjs {
				resource url: 'vendor/less/less.min.js', disposition: 'head'
			}
			jquery {
				resource url: 'vendor/jquery/jquery-2.1.0.js'
			}
			handlebarsjs {
				resource url: 'vendor/handlebars/handlebars.min.js'
			}
			underscorejs {
				resource url: 'vendor/underscore/underscore-min.js'
				resource url: 'vendor/underscore/underscore.string.min.js'
			}
			corejs {
				dependsOn 'jquery', 'handlebarsjs'
				resource url: 'vendor/bootstrap-3.2.0-dist/js/bootstrap.min.js'
				resource url: 'vendor/bootstrap-hover-dropdown-master/bootstrap-hover-dropdown.min.js'
			}
			jqueryvalidate {
				dependsOn 'corejs'
				resource url: 'vendor/jquery.validate/jquery.validate.js'
			}
			crowderajs {
				dependsOn 'corejs', 'bootstrapselectjs', 'bootstrapmultiselectjs', 'jqueryvalidate'
				resource url: 'js/crowdera.js'
				resource url: 'js/redactor/redactor.js'
				resource url: 'js/redactor/plugins/video.js'
			}
			googleanalytics {
				resource url: 'js/ga.js'
			}
			bootstrapselectjs {
				resource url: 'vendor/bootstrap-select/bootstrap-select.js'
			}
			bootstrapmultiselectjs {
				resource url: 'vendor/bootstrap-multiselect/bootstrap-multiselect.js'
			}
			blacknwhitejs {
				dependsOn 'corejs'
				resource url: 'js/external/jquery.BlackAndWhite.js'
			}
			tableclothjs {
				dependsOn 'corejs'
				resource url: 'tablecloth/js/jquery.metadata.js'
				resource url: 'tablecloth/js/jquery.tablesorter.js'
				resource url: 'tablecloth/js/jquery.tablecloth.js'
			}
		
			/* Page-specific JS */
			/* Home */
			homejs {
				dependsOn 'crowderajs', 'blacknwhitejs'
				resource url: 'js/home/home.js'
			}
			/* Login */
			loginjs {
				dependsOn 'crowderajs'
				resource url: 'js/home/login.js'
			}
			registrationjs {
				dependsOn 'crowderajs'
				resource url: 'js/home/registration.js'
			}
			/* Project */
			projectcreatejs {
				dependsOn 'crowderajs', 'handlebarsjs'
				resource url: 'js/project/create.js'
			}
			projectshowjs {
				dependsOn 'crowderajs'
				resource url: 'js/project/show.js'
			}
			projectlistjs {
				dependsOn 'crowderajs', 'blacknwhitejs'
				resource url: 'js/project/list.js'
			}
			projecteditjs {
				dependsOn 'crowderajs', 'blacknwhitejs'
				resource url: 'js/project/edit.js'
			}
			/* Fund */
			fundjs {
				dependsOn 'underscorejs', 'crowderajs'
				resource url: 'js/fund/fund.js'
			}
			checkoutjs {
				dependsOn 'crowderajs'
				resource url: 'js/fund/checkout.js'
			}
			/* Community */
			communitycreatejs {
				dependsOn 'crowderajs'
				resource url: 'js/community/create.js'
			}
			communitymanagejs {
				dependsOn 'crowderajs'
				resource url: 'js/community/manage.js'
			}
			/* Rewards */
			rewardjs {
				dependsOn 'crowderajs'
				resource url: 'js/reward.js'
			}
			/* User */
			userjs {
				dependsOn 'crowderajs'
				resource url: 'js/user.js'
			}
		
			/* CSS */
			fontawesomecss {
				resource url: 'vendor/font-awesome-4.2.0/css/font-awesome.min.css', attrs: [media: 'screen']
			}
			piecss {
				resource url: 'css/pie.css', attrs: [media: 'screen']
			}
			crowderacss {
				dependsOn 'bootswatchcss', 'bootstrapselectcss', 'bootstrapmultiselectcss', 'fontawesomecss', 'piecss', 'campaigncss', 'usercss', 'fundcss', 'showcss', 'mediacss'
				resource url: 'css/crowdera.css', attrs: [media: 'screen']
				resource url: 'js/redactor/redactor.css', attrs: [media: 'screen']
			}
			campaigncss {
				resource url: 'css/campaign.css', attrs: [media: 'screen']
			}
			usercss {
				resource url: 'css/user.css', attrs: [media: 'screen']
			}
			fundcss {
				resource url: 'css/fund.css', attrs: [media: 'screen']
			}
			showcss {
				resource url: 'css/show.css', attrs: [media: 'screen']
			}
			mediacss {
				resource url: 'css/media.css', attrs: [media: 'screen']
			}
			timelinecss {
				dependsOn 'crowderacss'
				resource url: 'css/timeline.css', attrs: [media: 'screen']
			}
			bootstrapcss {
				resource url: 'vendor/bootstrap-3.2.0-dist/css/bootstrap.min.css', attrs: [media: 'screen']
			}
			bootstrapselectcss {
				resource url: 'vendor/bootstrap-select/bootstrap-select.css', attrs: [media: 'screen']
			}
			bootstrapmultiselectcss {
				resource url: 'vendor/bootstrap-multiselect/bootstrap-multiselect.css', attrs: [media: 'screen']
			}
			bootstrapsocialcss {
				/* http://lipis.github.io/bootstrap-social/ */
				dependsOn 'bootswatchcss', 'fontawesomecss'
				resource url: 'vendor/bootstrap-social/bootstrap-social.min.css', attrs: [media: 'screen']
			}
			bootswatchcss {
				dependsOn 'bootswatchyeticss'
			}
			tableclothcss {
				dependsOn 'bootswatchcss'
				resource url: 'tablecloth/css/bootstrap-tables.css', attrs: [media: 'screen']
				resource url: 'tablecloth/css/tablecloth.css', attrs: [media: 'screen']
			}
		
			bootswatchyeticss {
				resource url: 'bootswatch-yeti/bootstrap.css', attrs: [media: 'screen']
			}
		}
	}
	
	prodIndia{
		modules = {
			/* JS */
			lessjs {
				resource url: 'http://dmymluhfmi0o3.cloudfront.net/vendor/less/less.min.js', disposition: 'head'
			}
			jquery {
				resource url: 'http://dmymluhfmi0o3.cloudfront.net/vendor/jquery/jquery-2.1.0.js'
			}
			handlebarsjs {
				resource url: 'http://dmymluhfmi0o3.cloudfront.net/vendor/handlebars/handlebars.min.js'
			}
			underscorejs {
				resource url: 'http://dmymluhfmi0o3.cloudfront.net/vendor/underscore/underscore-min.js'
				resource url: 'http://dmymluhfmi0o3.cloudfront.net/vendor/underscore/underscore.string.min.js'
			}
			corejs {
				dependsOn 'jquery', 'handlebarsjs'
				resource url: 'http://dmymluhfmi0o3.cloudfront.net/vendor/bootstrap-3.2.0-dist/js/bootstrap.min.js'
				resource url: 'http://dmymluhfmi0o3.cloudfront.net/vendor/bootstrap-hover-dropdown-master/bootstrap-hover-dropdown.min.js'
			}
			jqueryvalidate {
				dependsOn 'corejs'
				resource url: 'http://dmymluhfmi0o3.cloudfront.net/vendor/jquery.validate/jquery.validate.js'
			}
			crowderajs {
				dependsOn 'corejs', 'bootstrapselectjs', 'bootstrapmultiselectjs', 'jqueryvalidate'
				resource url: 'http://dmymluhfmi0o3.cloudfront.net/js/crowdera.js'
				resource url: 'http://dmymluhfmi0o3.cloudfront.net/js/redactor/redactor.js'
				resource url: 'http://dmymluhfmi0o3.cloudfront.net/js/redactor/plugins/video.js'
			}
			googleanalytics {
				resource url: 'http://dmymluhfmi0o3.cloudfront.net/js/ga.js'
			}
			bootstrapselectjs {
				resource url: 'http://dmymluhfmi0o3.cloudfront.net/vendor/bootstrap-select/bootstrap-select.js'
			}
			bootstrapmultiselectjs {
				resource url: 'http://dmymluhfmi0o3.cloudfront.net/vendor/bootstrap-multiselect/bootstrap-multiselect.js'
			}
			blacknwhitejs {
				dependsOn 'corejs'
				resource url: 'http://dmymluhfmi0o3.cloudfront.net/js/external/jquery.BlackAndWhite.js'
			}
			tableclothjs {
				dependsOn 'corejs'
				resource url: 'http://dmymluhfmi0o3.cloudfront.net/tablecloth/js/jquery.metadata.js'
				resource url: 'http://dmymluhfmi0o3.cloudfront.net/tablecloth/js/jquery.tablesorter.js'
				resource url: 'http://dmymluhfmi0o3.cloudfront.net/tablecloth/js/jquery.tablecloth.js'
			}
		
			/* Page-specific JS */
			/* Home */
			homejs {
				dependsOn 'crowderajs', 'blacknwhitejs'
				resource url: 'http://dmymluhfmi0o3.cloudfront.net/js/home/home.js'
			}
			/* Login */
			loginjs {
				dependsOn 'crowderajs'
				resource url: 'http://dmymluhfmi0o3.cloudfront.net/js/home/login.js'
			}
			registrationjs {
				dependsOn 'crowderajs'
				resource url: 'http://dmymluhfmi0o3.cloudfront.net/js/home/registration.js'
			}
			/* Project */
			projectcreatejs {
				dependsOn 'crowderajs', 'handlebarsjs'
				resource url: 'http://dmymluhfmi0o3.cloudfront.net/js/project/create.js'
			}
			projectshowjs {
				dependsOn 'crowderajs'
				resource url: 'http://dmymluhfmi0o3.cloudfront.net/js/project/show.js'
			}
			projectlistjs {
				dependsOn 'crowderajs', 'blacknwhitejs'
				resource url: 'http://dmymluhfmi0o3.cloudfront.net/js/project/list.js'
			}
			projecteditjs {
				dependsOn 'crowderajs', 'blacknwhitejs'
				resource url: 'http://dmymluhfmi0o3.cloudfront.net/js/project/edit.js'
			}
			/* Fund */
			fundjs {
				dependsOn 'underscorejs', 'crowderajs'
				resource url: 'http://dmymluhfmi0o3.cloudfront.net/js/fund/fund.js'
			}
			checkoutjs {
				dependsOn 'crowderajs'
				resource url: 'http://dmymluhfmi0o3.cloudfront.net/js/fund/checkout.js'
			}
			/* Community */
			communitycreatejs {
				dependsOn 'crowderajs'
				resource url: 'http://dmymluhfmi0o3.cloudfront.net/js/community/create.js'
			}
			communitymanagejs {
				dependsOn 'crowderajs'
				resource url: 'http://dmymluhfmi0o3.cloudfront.net/js/community/manage.js'
			}
			/* Rewards */
			rewardjs {
				dependsOn 'crowderajs'
				resource url: 'http://dmymluhfmi0o3.cloudfront.net/js/reward.js'
			}
			/* User */
			userjs {
				dependsOn 'crowderajs'
				resource url: 'http://dmymluhfmi0o3.cloudfront.net/js/user.js'
			}
		
			/* CSS */
			fontawesomecss {
				resource url: 'http://dmymluhfmi0o3.cloudfront.net/vendor/font-awesome-4.2.0/css/font-awesome.min.css', attrs: [media: 'screen']
			}
			piecss {
				resource url: 'http://dmymluhfmi0o3.cloudfront.net/css/pie.css', attrs: [media: 'screen']
			}
			crowderacss {
				dependsOn 'bootswatchcss', 'bootstrapselectcss', 'bootstrapmultiselectcss', 'fontawesomecss', 'piecss', 'campaigncss', 'usercss', 'fundcss', 'showcss', 'mediacss'
				resource url: 'http://dmymluhfmi0o3.cloudfront.net/css/crowdera.css', attrs: [media: 'screen']
				resource url: 'http://dmymluhfmi0o3.cloudfront.net/js/redactor/redactor.css', attrs: [media: 'screen']
			}
			campaigncss {
				resource url: 'http://dmymluhfmi0o3.cloudfront.net/css/campaign.css', attrs: [media: 'screen']
			}
			usercss {
				resource url: 'http://dmymluhfmi0o3.cloudfront.net/css/user.css', attrs: [media: 'screen']
			}
			fundcss {
				resource url: 'http://dmymluhfmi0o3.cloudfront.net/css/fund.css', attrs: [media: 'screen']
			}
			showcss {
				resource url: 'http://dmymluhfmi0o3.cloudfront.net/css/show.css', attrs: [media: 'screen']
			}
			mediacss {
				resource url: 'http://dmymluhfmi0o3.cloudfront.net/css/media.css', attrs: [media: 'screen']
			}
			timelinecss {
				dependsOn 'crowderacss'
				resource url: 'http://dmymluhfmi0o3.cloudfront.net/css/timeline.css', attrs: [media: 'screen']
			}
			bootstrapcss {
				resource url: 'http://dmymluhfmi0o3.cloudfront.net/vendor/bootstrap-3.2.0-dist/css/bootstrap.min.css', attrs: [media: 'screen']
			}
			bootstrapselectcss {
				resource url: 'http://dmymluhfmi0o3.cloudfront.net/vendor/bootstrap-select/bootstrap-select.css', attrs: [media: 'screen']
			}
			bootstrapmultiselectcss {
				resource url: 'http://dmymluhfmi0o3.cloudfront.net/vendor/bootstrap-multiselect/bootstrap-multiselect.css', attrs: [media: 'screen']
			}
			bootstrapsocialcss {
				/* http://lipis.github.io/bootstrap-social/ */
				dependsOn 'bootswatchcss', 'fontawesomecss'
				resource url: 'http://dmymluhfmi0o3.cloudfront.net/vendor/bootstrap-social/bootstrap-social.min.css', attrs: [media: 'screen']
			}
			bootswatchcss {
				dependsOn 'bootswatchyeticss'
			}
			tableclothcss {
				dependsOn 'bootswatchcss'
				resource url: 'http://dmymluhfmi0o3.cloudfront.net/tablecloth/css/bootstrap-tables.css', attrs: [media: 'screen']
				resource url: 'http://dmymluhfmi0o3.cloudfront.net/tablecloth/css/tablecloth.css', attrs: [media: 'screen']
			}
		
			bootswatchyeticss {
				resource url: 'http://dmymluhfmi0o3.cloudfront.net/bootswatch-yeti/bootstrap.css', attrs: [media: 'screen']
			}
		}
	}
}
