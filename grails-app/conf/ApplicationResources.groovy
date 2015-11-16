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
        resource url: 'js/redactor/redactor.js'
        resource url: 'js/redactor/plugins/video.js'
        resource url: 'js/redactor/plugins/fontsize.js'
        resource url: 'js/redactor/plugins/fontfamily.js'
        resource url: 'js/redactor/plugins/fontcolor.js'
    }
    projectshowjs {
        dependsOn 'crowderajs'
        resource url: 'js/project/show.js'
        resource url: 'js/redactor/redactor.js'
        resource url: 'js/redactor/plugins/video.js'
        resource url: 'js/redactor/plugins/fontsize.js'
        resource url: 'js/redactor/plugins/fontfamily.js'
        resource url: 'js/redactor/plugins/fontcolor.js'
    }
    projectlistjs {
        dependsOn 'crowderajs', 'blacknwhitejs'
        resource url: 'js/project/list.js'
    }
    projecteditjs {
        dependsOn 'crowderajs', 'blacknwhitejs'
        resource url: 'js/project/edit.js'
        resource url: 'js/redactor/redactor.js'
        resource url: 'js/redactor/plugins/video.js'
        resource url: 'js/redactor/plugins/fontsize.js'
        resource url: 'js/redactor/plugins/fontfamily.js'
        resource url: 'js/redactor/plugins/fontcolor.js'
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
	
	/*Ebook*/
	ebookjs{
		dependsOn 'crowderajs'
		resource url: 'js/ebook/ebook.js'
	}
    
    partnerjs {
        dependsOn 'crowderajs'
        resource url: 'js/partner.js'
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
    
    sidebarcss {
        resource url: 'css/sidebar.css', attrs: [media: 'screen']
    }
}
