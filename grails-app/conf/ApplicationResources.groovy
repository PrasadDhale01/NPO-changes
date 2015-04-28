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
        resource url: 'vendor/font-awesome-4.2.0/css/font-awesome.min.css'
    }
    piecss {
        resource url: 'css/pie.css'
    }
    crowderacss {
        dependsOn 'bootswatchcss', 'bootstrapselectcss', 'bootstrapmultiselectcss', 'fontawesomecss', 'piecss', 'campaigncss', 'usercss', 'fundcss', 'showcss', 'mediacss'
        resource url: 'css/crowdera.css'
    }
    campaigncss {
        resource url: 'css/campaign.css'
    }
    usercss {
        resource url: 'css/user.css'
    }
    fundcss {
        resource url: 'css/fund.css'
    }
    showcss {
        resource url: 'css/show.css'
    }
    mediacss {
        resource url: 'css/media.css'
    }
    timelinecss {
        dependsOn 'crowderacss'
        resource url: 'css/timeline.css'
    }
    bootstrapcss {
        resource url: 'vendor/bootstrap-3.2.0-dist/css/bootstrap.min.css'
    }
    bootstrapselectcss {
        resource url: 'vendor/bootstrap-select/bootstrap-select.css'
    }
    bootstrapmultiselectcss {
        resource url: 'vendor/bootstrap-multiselect/bootstrap-multiselect.css'
    }
    bootstrapsocialcss {
        /* http://lipis.github.io/bootstrap-social/ */
        dependsOn 'bootswatchcss', 'fontawesomecss'
        resource url: 'vendor/bootstrap-social/bootstrap-social.min.css'
    }
    bootswatchcss {
        dependsOn 'bootswatchyeticss'
    }
    tableclothcss {
        dependsOn 'bootswatchcss'
        resource url: 'tablecloth/css/bootstrap-tables.css'
        resource url: 'tablecloth/css/tablecloth.css'
    }

    bootswatchyeticss {
        resource url: 'bootswatch-yeti/bootstrap.css'
    }
}
