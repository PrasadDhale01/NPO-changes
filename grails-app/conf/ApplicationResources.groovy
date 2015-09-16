modules = {
	/* JS */
	lessjs {
		resource url: 'vendor/less/less.min.js', disposition: 'head', attrs:[type:'js']
	}
	jquery {
		resource url: 'vendor/jquery/jquery-2.1.0.js'
	}
	handlebarsjs {
		resource url: 'vendor/handlebars/handlebars.min.js', attrs:[type:'js']
	}
	underscorejs {
		resource url: 'vendor/underscore/underscore-min.js', attrs:[type:'js']
		resource url: 'vendor/underscore/underscore.string.min.js', attrs:[type:'js']
	}
	corejs {
		dependsOn 'jquery', 'handlebarsjs'
		resource url: 'vendor/bootstrap-3.2.0-dist/js/bootstrap.min.js', attrs:[type:'js']
		resource url: 'vendor/bootstrap-hover-dropdown-master/bootstrap-hover-dropdown.min.js', attrs:[type:'js']
	}
	jqueryvalidate {
		dependsOn 'corejs'
		resource url: 'vendor/jquery.validate/jquery.validate.js', attrs:[type:'js']
	}
	crowderajs {
		dependsOn 'corejs', 'bootstrapselectjs', 'bootstrapmultiselectjs', 'jqueryvalidate'
		resource url: 'js/crowdera.js', attrs:[type:'js']
	}
	googleanalytics {
		resource url: 'js/ga.js', attrs:[type:'js']
	}
	bootstrapselectjs {
		resource url: 'vendor/bootstrap-select/bootstrap-select.js', attrs:[type:'js']
	}
	bootstrapmultiselectjs {
		resource url: 'vendor/bootstrap-multiselect/bootstrap-multiselect.js', attrs:[type:'js']
	}
	blacknwhitejs {
		dependsOn 'corejs'
		resource url: 'js/external/jquery.BlackAndWhite.js', attrs:[type:'js']
	}
	tableclothjs {
		dependsOn 'corejs'
		resource url: 'tablecloth/js/jquery.metadata.js', attrs:[type:'js']
		resource url: 'tablecloth/js/jquery.tablesorter.js', attrs:[type:'js']
		resource url: 'tablecloth/js/jquery.tablecloth.js', attrs:[type:'js']
	}

	/* Page-specific JS */
	/* Home */
	homejs {
		dependsOn 'crowderajs', 'blacknwhitejs'
		resource url: 'js/home/home.js', attrs:[type:'js']
	}
	/* Login */
	loginjs {
		dependsOn 'crowderajs'
		resource url: 'js/home/login.js', attrs:[type:'js']
	}
	registrationjs {
		dependsOn 'crowderajs'
		resource url: 'js/home/registration.js', attrs:[type:'js']
	}
	/* Project */
	projectcreatejs {
		dependsOn 'crowderajs', 'handlebarsjs'
		resource url: 'js/project/create.js', attrs:[type:'js']
        resource url: 'js/redactor/redactor.js', attrs:[type:'js']
        resource url: 'js/redactor/plugins/video.js', attrs:[type:'js']
	}
	projectshowjs {
		dependsOn 'crowderajs'
		resource url: 'js/project/show.js', attrs:[type:'js']
        resource url: 'js/redactor/redactor.js', attrs:[type:'js']
        resource url: 'js/redactor/plugins/video.js', attrs:[type:'js']
	}
	projectlistjs {
		dependsOn 'crowderajs', 'blacknwhitejs'
		resource url: 'js/project/list.js', attrs:[type:'js']
	}
	projecteditjs {
		dependsOn 'crowderajs', 'blacknwhitejs'
		resource url: 'js/project/edit.js', attrs:[type:'js']
        resource url: 'js/redactor/redactor.js', attrs:[type:'js']
        resource url: 'js/redactor/plugins/video.js', attrs:[type:'js']
	}
	/* Fund */
	fundjs {
		dependsOn 'underscorejs', 'crowderajs'
		resource url: 'js/fund/fund.js', attrs:[type:'js']
	}
	checkoutjs {
		dependsOn 'crowderajs'
		resource url: 'js/fund/checkout.js', attrs:[type:'js']
	}
	/* Community */
	communitycreatejs {
		dependsOn 'crowderajs'
		resource url: 'js/community/create.js', attrs:[type:'js']
	}
	communitymanagejs {
		dependsOn 'crowderajs'
		resource url: 'js/community/manage.js', attrs:[type:'js']
	}
	/* Rewards */
	rewardjs {
		dependsOn 'crowderajs'
		resource url: 'js/reward.js', attrs:[type:'js']
	}
	/* User */
	userjs {
		dependsOn 'crowderajs'
		resource url: 'js/user.js', attrs:[type:'js']
	}

	/* CSS */
	fontawesomecss {
		resource url: 'vendor/font-awesome-4.2.0/css/font-awesome.min.css', attrs: [media: 'screen', type:'css']
	}
	piecss {
		resource url: 'css/pie.css', attrs: [media: 'screen', type:'css']
	}
	crowderacss {
		dependsOn 'bootswatchcss', 'bootstrapselectcss', 'bootstrapmultiselectcss', 'fontawesomecss', 'piecss', 'campaigncss', 'usercss', 'fundcss', 'showcss', 'mediacss'
		resource url: 'css/crowdera.css', attrs: [media: 'screen', type:'css']
		resource url: 'js/redactor/redactor.css', attrs: [media: 'screen', type:'css']
	}
	campaigncss {
		resource url: 'css/campaign.css', attrs: [media: 'screen', type:'css']
	}
	usercss {
		resource url: 'css/user.css', attrs: [media: 'screen', type:'css']
	}
	fundcss {
		resource url: 'css/fund.css', attrs: [media: 'screen', type:'css']
	}
	showcss {
		resource url: 'css/show.css', attrs: [media: 'screen', type:'css']
	}
	mediacss {
		resource url: 'css/media.css', attrs: [media: 'screen', type:'css']
	}
	timelinecss {
		dependsOn 'crowderacss'
		resource url: 'css/timeline.css', attrs: [media: 'screen', type:'css']
	}
	bootstrapcss {
		resource url: 'vendor/bootstrap-3.2.0-dist/css/bootstrap.min.css', attrs: [media: 'screen', type:'css']
	}
	bootstrapselectcss {
		resource url: 'vendor/bootstrap-select/bootstrap-select.css', attrs: [media: 'screen', type:'css']
	}
	bootstrapmultiselectcss {
		resource url: 'vendor/bootstrap-multiselect/bootstrap-multiselect.css', attrs: [media: 'screen', type:'css']
	}
	bootstrapsocialcss {
		/* http://lipis.github.io/bootstrap-social/ */
		dependsOn 'bootswatchcss', 'fontawesomecss'
		resource url: 'vendor/bootstrap-social/bootstrap-social.min.css', attrs: [media: 'screen', type:'css']
	}
	bootswatchcss {
		dependsOn 'bootswatchyeticss'
	}
	tableclothcss {
		dependsOn 'bootswatchcss'
		resource url: 'tablecloth/css/bootstrap-tables.css', attrs: [media: 'screen', type:'css']
		resource url: 'tablecloth/css/tablecloth.css', attrs: [media: 'screen', type:'css']
	}

	bootswatchyeticss {
		resource url: 'bootswatch-yeti/bootstrap.css', attrs: [media: 'screen', type:'css']
	}
}
	