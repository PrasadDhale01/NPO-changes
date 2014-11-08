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
    fedujs {
        dependsOn 'corejs', 'bootstrapselectjs', 'bootstrapmultiselectjs', 'jqueryvalidate'
        resource url: 'js/fedu.js'
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
        dependsOn 'fedujs', 'blacknwhitejs'
        resource url: 'js/home/home.js'
    }
    /* Login */
    loginjs {
        dependsOn 'fedujs'
        resource url: 'js/home/login.js'
    }
    registrationjs {
        dependsOn 'fedujs'
        resource url: 'js/home/registration.js'
    }
    /* Project */
    projectcreatejs {
        dependsOn 'fedujs', 'handlebarsjs'
        resource url: 'js/project/create.js'
    }
    projectshowjs {
        dependsOn 'fedujs'
        resource url: 'js/project/show.js'
    }
    projectlistjs {
        dependsOn 'fedujs', 'blacknwhitejs'
        resource url: 'js/project/list.js'
    }
    /* Fund */
    fundjs {
        dependsOn 'underscorejs', 'fedujs'
        resource url: 'js/fund/fund.js'
    }
    checkoutjs {
        dependsOn 'fedujs'
        resource url: 'js/fund/checkout.js'
    }
    /* Community */
    communitycreatejs {
        dependsOn 'fedujs'
        resource url: 'js/community/create.js'
    }
    communitymanagejs {
        dependsOn 'fedujs'
        resource url: 'js/community/manage.js'
    }
    /* Rewards */
    rewardjs {
        dependsOn 'fedujs'
        resource url: 'js/reward.js'
    }
    /* User */
    userjs {
        dependsOn 'fedujs'
        resource url: 'js/user.js'
    }

    /* CSS */
    fontawesomecss {
        resource url: 'vendor/font-awesome-4.2.0/css/font-awesome.min.css'
    }
    feducss {
        dependsOn 'bootswatchcss', 'bootstrapselectcss', 'bootstrapmultiselectcss', 'fontawesomecss'
        resource url: 'css/fedu.css'
    }
    timelinecss {
        dependsOn 'feducss'
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
        dependsOn 'lessjs'
        resource url: 'bootswatch-yeti/bootstrap.css'
        resource url: 'bootswatch-yeti/variables.less', attrs: [rel: 'stylesheet/less', type: 'css']
        resource url: 'bootswatch-yeti/bootswatch.less', attrs: [rel: 'stylesheet/less', type: 'css']
    }
    /* Bootswatch themes; use any one. */
    /*
    bootswatchsimplexcss {
        dependsOn 'lessjs'
        resource url: 'http://bootswatch.com/simplex/bootstrap.css'
        resource url: 'http://bootswatch.com/simplex/variables.less', attrs: [rel: 'stylesheet/less', type: 'css']
        resource url: 'http://bootswatch.com/simplex/bootswatch.less', attrs: [rel: 'stylesheet/less', type: 'css']
    }
    bootswatchjournalcss {
        dependsOn 'lessjs'
        resource url: 'http://bootswatch.com/journal/bootstrap.css'
        resource url: 'http://bootswatch.com/journal/variables.less', attrs: [rel: 'stylesheet/less', type: 'css']
        resource url: 'http://bootswatch.com/journal/bootswatch.less', attrs: [rel: 'stylesheet/less', type: 'css']
    }
    bootswatchceruleancss {
        dependsOn 'lessjs'
        resource url: 'http://bootswatch.com/cerulean/bootstrap.css'
        resource url: 'http://bootswatch.com/cerulean/variables.less', attrs: [rel: 'stylesheet/less', type: 'css']
        resource url: 'http://bootswatch.com/cerulean/bootswatch.less', attrs: [rel: 'stylesheet/less', type: 'css']
    }
    bootswatchdarklycss {
        dependsOn 'lessjs'
        resource url: 'http://bootswatch.com/darkly/bootstrap.css'
        resource url: 'http://bootswatch.com/darkly/variables.less', attrs: [rel: 'stylesheet/less', type: 'css']
        resource url: 'http://bootswatch.com/darkly/bootswatch.less', attrs: [rel: 'stylesheet/less', type: 'css']
    }
    bootswatchflatlycss {
        dependsOn 'lessjs'
        resource url: 'http://bootswatch.com/flatly/bootstrap.css'
        resource url: 'http://bootswatch.com/flatly/variables.less', attrs: [rel: 'stylesheet/less', type: 'css']
        resource url: 'http://bootswatch.com/flatly/bootswatch.less', attrs: [rel: 'stylesheet/less', type: 'css']
    }
    bootswatchspacelabcss {
        dependsOn 'lessjs'
        resource url: 'http://bootswatch.com/spacelab/bootstrap.css'
        resource url: 'http://bootswatch.com/spacelab/variables.less', attrs: [rel: 'stylesheet/less', type: 'css']
        resource url: 'http://bootswatch.com/spacelab/bootswatch.less', attrs: [rel: 'stylesheet/less', type: 'css']
    }
    bootswatchunitedcss {
        dependsOn 'lessjs'
        resource url: 'http://bootswatch.com/united/bootstrap.css'
        resource url: 'http://bootswatch.com/united/variables.less', attrs: [rel: 'stylesheet/less', type: 'css']
        resource url: 'http://bootswatch.com/united/bootswatch.less', attrs: [rel: 'stylesheet/less', type: 'css']
    }
    */
}
