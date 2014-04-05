modules = {
    /* JS */
    lessjs {
        resource url: 'https://cdnjs.cloudflare.com/ajax/libs/less.js/1.7.0/less.min.js', disposition: 'head'
    }
    jquery {
        resource url: 'https://code.jquery.com/jquery-2.1.0.js'
    }
    handlebarsjs {
        resource url: 'https://cdnjs.cloudflare.com/ajax/libs/handlebars.js/2.0.0-alpha.2/handlebars.min.js'
    }
    underscorejs {
        resource url: 'https://cdnjs.cloudflare.com/ajax/libs/underscore.js/1.6.0/underscore-min.js'
        resource url: 'https://cdnjs.cloudflare.com/ajax/libs/underscore.string/2.3.3/underscore.string.min.js'
    }
    corejs {
        dependsOn 'jquery', 'handlebarsjs'
        resource url: 'https://netdna.bootstrapcdn.com/bootstrap/3.1.1/js/bootstrap.js'
    }
    jqueryvalidate {
        dependsOn 'corejs'
        resource url: 'https://ajax.aspnetcdn.com/ajax/jquery.validate/1.11.1/jquery.validate.js'
    }
    fedujs {
        dependsOn 'corejs', 'bootstrapselectjs', 'jqueryvalidate'
        resource url: 'js/fedu.js'
    }
    googleanalytics {
        resource url: 'js/ga.js'
    }
    bootstrapselectjs {
        resource url: 'https://silviomoreto.github.io/bootstrap-select/javascripts/bootstrap-select.js'
    }
    blacknwhitejs {
        dependsOn 'corejs'
        resource url: 'js/jquery.BlackAndWhite.js'
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
        dependsOn 'fedujs'
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
    communityjs {
        dependsOn 'fedujs'
        resource url: 'js/community.js'
    }

    /* CSS */
    fontawesomecss {
        resource url: 'https://netdna.bootstrapcdn.com/font-awesome/4.0.3/css/font-awesome.css'
    }
    feducss {
        dependsOn 'bootswatchyeticss', 'bootstrapselectcss', 'fontawesomecss'
        resource url: 'css/fedu.css'
    }
    bootstrapcss {
        resource url: 'https://netdna.bootstrapcdn.com/bootstrap/3.1.1/css/bootstrap.css'
    }
    bootstrapselectcss {
        resource url: 'https://silviomoreto.github.io/bootstrap-select/stylesheets/bootstrap-select.css'
    }
    tableclothcss {
        dependsOn 'bootswatchyeticss'
        resource url: 'tablecloth/css/bootstrap-tables.css'
        resource url: 'tablecloth/css/tablecloth.css'
    }

    /* Bootswatch themes; use any one. */
    bootswatchyeticss {
        dependsOn 'lessjs'
        resource url: 'bootswatch-yeti/bootstrap.css'
        resource url: 'bootswatch-yeti/variables.less', attrs: [rel: 'stylesheet/less', type: 'css']
        resource url: 'bootswatch-yeti/bootswatch.less', attrs: [rel: 'stylesheet/less', type: 'css']
    }
    /*
    bootswatchjournalcss {
        dependsOn 'lessjs'
        resource url: 'http://bootswatch.com/journal/bootstrap.css'
        resource url: 'http://bootswatch.com/journal/variables.less', attrs: [rel: 'stylesheet/less', type: 'css']
        resource url: 'http://bootswatch.com/journal/bootswatch.less', attrs: [rel: 'stylesheet/less', type: 'css']
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
    bootswatchsimplexcss {
        dependsOn 'lessjs'
        resource url: 'http://bootswatch.com/simplex/bootstrap.css'
        resource url: 'http://bootswatch.com/simplex/variables.less', attrs: [rel: 'stylesheet/less', type: 'css']
        resource url: 'http://bootswatch.com/simplex/bootswatch.less', attrs: [rel: 'stylesheet/less', type: 'css']
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
