modules = {
    core {
        resource url: 'http://code.jquery.com/jquery-2.1.0.js'
        resource url: 'http://netdna.bootstrapcdn.com/bootstrap/3.1.1/js/bootstrap.js'
        resource url: 'http://cdnjs.cloudflare.com/ajax/libs/less.js/1.7.0/less.min.js'
    }
    app {
        dependsOn 'core'
        resource url: '/js/fedu.js'
    }
    create {
        dependsOn 'app'
        resource url: '/js/create.js'
    }
}
