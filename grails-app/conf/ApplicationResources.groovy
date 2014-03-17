modules = {
    /* JS */
    lessjs {
        resource url: 'http://cdnjs.cloudflare.com/ajax/libs/less.js/1.7.0/less.min.js', disposition: 'head'
    }
    corejs {
        resource url: 'http://code.jquery.com/jquery-2.1.0.js'
        resource url: 'http://netdna.bootstrapcdn.com/bootstrap/3.1.1/js/bootstrap.js'
    }
    appjs {
        dependsOn 'corejs'
        resource url: 'js/fedu.js'
    }
    createjs {
        dependsOn 'appjs'
        resource url: 'js/create.js'
    }
    googleanalytics {
        resource url: 'js/ga.js'
    }

    /* CSS */
    feducss {
        dependsOn 'bootswatchcss'
        resource url: 'css/fedu.css'
    }
    bootstrapcss {
        resource url: 'http://netdna.bootstrapcdn.com/bootstrap/3.1.1/css/bootstrap.css'
    }
    bootswatchcss {
        dependsOn 'lessjs'
        resource url: 'http://bootswatch.com/journal/bootstrap.css'
        resource url: 'http://bootswatch.com/journal/variables.less', attrs: [rel: 'stylesheet/less', type: 'css']
        resource url: 'http://bootswatch.com/journal/bootswatch.less', attrs: [rel: 'stylesheet/less', type: 'css']
    }
}
