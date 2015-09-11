import grails.util.Environment

def currentEnv = Environment.current.getName()
def cdn
switch (currentEnv) {
    case 'production':
        cdn = 'https://d38k0frcj7wnf2.cloudfront.net/'
        break;
    case 'prodIndia':
        cdn = 'http://dmymluhfmi0o3.cloudfront.net/'
        break;
    case 'test':
        cdn = 'http://d1hsbjre03buja.cloudfront.net/'
        break;
    default:
        cdn = ''
}

modules = {
    /* JS */
    lessjs {
        resource url: cdn+'vendor/less/less.min.js', disposition: 'head'
    }
    jquery {
        resource url: cdn+'vendor/jquery/jquery-2.1.0.js'
    }
    handlebarsjs {
        resource url: cdn+'vendor/handlebars/handlebars.min.js'
    }
    underscorejs {
        resource url: cdn+'vendor/underscore/underscore-min.js'
        resource url: cdn+'vendor/underscore/underscore.string.min.js'
    }
    corejs {
        dependsOn 'jquery', 'handlebarsjs'
        resource url: cdn+'vendor/bootstrap-3.2.0-dist/js/bootstrap.min.js'
        resource url: cdn+'vendor/bootstrap-hover-dropdown-master/bootstrap-hover-dropdown.min.js'
    }
    jqueryvalidate {
        dependsOn 'corejs'
        resource url: cdn+'vendor/jquery.validate/jquery.validate.js'
    }
    crowderajs {
        dependsOn 'corejs', 'bootstrapselectjs', 'bootstrapmultiselectjs', 'jqueryvalidate'
        resource url: 'js/crowdera.js'
        resource url: 'js/redactor/redactor.js'
        resource url: cdn+'js/redactor/plugins/video.js'
    }
    googleanalytics {
        resource url: cdn+'js/ga.js'
    }
    bootstrapselectjs {
        resource url: cdn+'vendor/bootstrap-select/bootstrap-select.js'
    }
    bootstrapmultiselectjs {
        resource url: cdn+'vendor/bootstrap-multiselect/bootstrap-multiselect.js'
    }
    blacknwhitejs {
        dependsOn 'corejs'
        resource url: cdn+'js/external/jquery.BlackAndWhite.js'
    }
    tableclothjs {
        dependsOn 'corejs'
        resource url: cdn+'tablecloth/js/jquery.metadata.js'
        resource url: cdn+'tablecloth/js/jquery.tablesorter.js'
        resource url: cdn+'tablecloth/js/jquery.tablecloth.js'
    }

    /* Page-specific JS */
    /* Home */
    homejs {
        dependsOn 'crowderajs', 'blacknwhitejs'
        resource url: cdn+'js/home/home.js'
    }
    /* Login */
    loginjs {
        dependsOn 'crowderajs'
        resource url: cdn+'js/home/login.js'
    }
    registrationjs {
        dependsOn 'crowderajs'
        resource url: cdn+'js/home/registration.js'
    }
    /* Project */
    projectcreatejs {
        dependsOn 'crowderajs', 'handlebarsjs'
        resource url: cdn+'js/project/create.js'
    }
    projectshowjs {
        dependsOn 'crowderajs'
        resource url: cdn+'js/project/show.js'
    }
    projectlistjs {
        dependsOn 'crowderajs', 'blacknwhitejs'
        resource url: cdn+'js/project/list.js'
    }
    projecteditjs {
        dependsOn 'crowderajs', 'blacknwhitejs'
        resource url: cdn+'js/project/edit.js'
    }
    /* Fund */
    fundjs {
        dependsOn 'underscorejs', 'crowderajs'
        resource url: cdn+'js/fund/fund.js'
    }
    checkoutjs {
        dependsOn 'crowderajs'
        resource url: cdn+'js/fund/checkout.js'
    }
    /* Community */
    communitycreatejs {
        dependsOn 'crowderajs'
        resource url: cdn+'js/community/create.js'
    }
    communitymanagejs {
        dependsOn 'crowderajs'
        resource url: cdn+'js/community/manage.js'
    }
    /* Rewards */
    rewardjs {
        dependsOn 'crowderajs'
        resource url: cdn+'js/reward.js'
    }
    /* User */
    userjs {
        dependsOn 'crowderajs'
        resource url: cdn+'js/user.js'
    }

    /* CSS */
    fontawesomecss {
        resource url: cdn+'vendor/font-awesome-4.2.0/css/font-awesome.min.css', attrs: [media: 'screen']
    }
    piecss {
        resource url: cdn+'css/pie.css', attrs: [media: 'screen']
    }
    crowderacss {
        dependsOn 'bootswatchcss', 'bootstrapselectcss', 'bootstrapmultiselectcss', 'fontawesomecss', 'piecss', 'campaigncss', 'usercss', 'fundcss', 'showcss', 'mediacss'
        resource url: cdn+'css/crowdera.css', attrs: [media: 'screen']
        resource url: cdn+'js/redactor/redactor.css', attrs: [media: 'screen']
    }
    campaigncss {
        resource url: cdn+'css/campaign.css', attrs: [media: 'screen']
    }
    usercss {
        resource url: cdn+'css/user.css', attrs: [media: 'screen']
    }
    fundcss {
        resource url: cdn+'css/fund.css', attrs: [media: 'screen']
    }
    showcss {
        resource url: cdn+'css/show.css', attrs: [media: 'screen']
    }
    mediacss {
        resource url: cdn+'css/media.css', attrs: [media: 'screen']
    }
    timelinecss {
        dependsOn 'crowderacss'
        resource url: cdn+'css/timeline.css', attrs: [media: 'screen']
    }
    bootstrapcss {
        resource url: cdn+'vendor/bootstrap-3.2.0-dist/css/bootstrap.min.css', attrs: [media: 'screen']
    }
    bootstrapselectcss {
        resource url: cdn+'vendor/bootstrap-select/bootstrap-select.css', attrs: [media: 'screen']
    }
    bootstrapmultiselectcss {
        resource url: cdn+'vendor/bootstrap-multiselect/bootstrap-multiselect.css', attrs: [media: 'screen']
    }
    bootstrapsocialcss {
        /* http://lipis.github.io/bootstrap-social/ */
        dependsOn 'bootswatchcss', 'fontawesomecss'
        resource url: cdn+'vendor/bootstrap-social/bootstrap-social.min.css', attrs: [media: 'screen']
    }
    bootswatchcss {
        dependsOn 'bootswatchyeticss'
    }
    tableclothcss {
        dependsOn 'bootswatchcss'
        resource url: cdn+'tablecloth/css/bootstrap-tables.css', attrs: [media: 'screen']
        resource url: cdn+'tablecloth/css/tablecloth.css', attrs: [media: 'screen']
    }

    bootswatchyeticss {
        resource url: cdn+'bootswatch-yeti/bootstrap.css', attrs: [media: 'screen']
    }
}
