modules = {
    /* JS */
    lessjs {
        resource url: 'https://cdnjs.cloudflare.com/ajax/libs/less.js/1.7.0/less.min.js', disposition: 'head'
    }
    jquery {
        resource url: 'https://code.jquery.com/jquery-2.1.0.js'
    }
    corejs {
        dependsOn 'jquery'
        resource url: 'https://netdna.bootstrapcdn.com/bootstrap/3.1.1/js/bootstrap.js'
    }
    jqueryvalidate {
        dependsOn 'corejs'
        resource url: 'https://ajax.aspnetcdn.com/ajax/jquery.validate/1.11.1/jquery.validate.js'
    }
    fedujs {
        dependsOn 'corejs', 'bootstrapselectjs'
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

    /* Page-specific JS */
    homejs {
        dependsOn 'fedujs', 'blacknwhitejs'
        resource url: 'js/home/home.js'
    }
    loginjs {
        dependsOn 'fedujs', 'jqueryvalidate'
        resource url: 'js/home/login.js'
    }
    registrationjs {
        dependsOn 'fedujs', 'jqueryvalidate'
        resource url: 'js/home/registration.js'
    }
    projectcreatejs {
        dependsOn 'fedujs', 'jqueryvalidate'
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

    /* CSS */
    feducss {
        dependsOn 'bootswatchyeticss', 'bootstrapselectcss'
        resource url: 'css/fedu.css'
    }
    bootstrapcss {
        resource url: 'https://netdna.bootstrapcdn.com/bootstrap/3.1.1/css/bootstrap.css'
    }
    bootstrapselectcss {
        resource url: 'https://silviomoreto.github.io/bootstrap-select/stylesheets/bootstrap-select.css'
    }

    /* Bootswatch themes; use any one. */
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
    bootswatchyeticss {
        dependsOn 'lessjs'
        resource url: 'bootswatch-yeti/bootstrap.css'
        resource url: 'bootswatch-yeti/variables.less', attrs: [rel: 'stylesheet/less', type: 'css']
        resource url: 'bootswatch-yeti/bootswatch.less', attrs: [rel: 'stylesheet/less', type: 'css']
    }
}
