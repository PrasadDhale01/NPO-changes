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
        resource url: '/js/fedu.js'
    }
    createjs {
        dependsOn 'appjs'
        resource url: '/js/create.js'
    }

    /* CSS */
    feducss {
        resource url: 'css/fedu.css'
    }
}
