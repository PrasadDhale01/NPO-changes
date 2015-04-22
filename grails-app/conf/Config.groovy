// locations to search for config files that get merged into the main config;
// config files can be ConfigSlurper scripts, Java properties files, or classes
// in the classpath in ConfigSlurper format

// grails.config.locations = [ "classpath:${appName}-config.properties",
//                             "classpath:${appName}-config.groovy",
//                             "file:${userHome}/.grails/${appName}-config.properties",
//                             "file:${userHome}/.grails/${appName}-config.groovy"]

// if (System.properties["${appName}.config.location"]) {
//    grails.config.locations << "file:" + System.properties["${appName}.config.location"]
// }

grails.project.groupId = appName // change this to alter the default package name and Maven publishing destination

// The ACCEPT header will not be used for content negotiation for user agents containing the following strings (defaults to the 4 major rendering engines)
grails.mime.disable.accept.header.userAgents = ['Gecko', 'WebKit', 'Presto', 'Trident']
grails.mime.types = [ // the first one is the default format
    all:           '*/*', // 'all' maps to '*' or the first available format in withFormat
    atom:          'application/atom+xml',
    css:           'text/css',
    csv:           'text/csv',
    form:          'application/x-www-form-urlencoded',
    html:          ['text/html','application/xhtml+xml'],
    js:            'text/javascript',
    json:          ['application/json', 'text/json'],
    multipartForm: 'multipart/form-data',
    rss:           'application/rss+xml',
    text:          'text/plain',
    hal:           ['application/hal+json','application/hal+xml'],
    xml:           ['text/xml', 'application/xml']
]

// URL Mapping Cache Max Size, defaults to 5000
//grails.urlmapping.cache.maxsize = 1000

// What URL patterns should be processed by the resources plugin
grails.resources.adhoc.patterns = ['/images/*', '/css/*', '/js/*', '/plugins/*']
grails.resources.adhoc.excludes = ['/WEB-INF/**']

// Legacy setting for codec used to encode data with ${}
grails.views.default.codec = "html"

// The default scope for controllers. May be prototype, session or singleton.
// If unspecified, controllers are prototype scoped.
grails.controllers.defaultScope = 'singleton'

grails.app.context = "/"

// GSP settings
grails {
    views {
        gsp {
            encoding = 'UTF-8'
            htmlcodec = 'xml' // use xml escaping instead of HTML4 escaping
            codecs {
                expression = 'html' // escapes values inside ${}
                scriptlet = 'html' // escapes output from scriptlets in GSPs
                taglib = 'none' // escapes output from taglibs
                staticparts = 'none' // escapes output from static template parts
            }
        }
        // escapes all not-encoded output at final stage of outputting
        // filteringCodecForContentType.'text/html' = 'html'
    }

    mail {
        host = "smtp.gmail.com"
        port = 465
        username = "info@fedu.org"
        password = "FundEdu@2014"
        props = ["mail.smtp.auth":"true",
                "mail.smtp.socketFactory.port":"465",
                "mail.smtp.socketFactory.class":"javax.net.ssl.SSLSocketFactory",
                "mail.smtp.socketFactory.fallback":"false"]
    }
}


grails.converters.encoding = "UTF-8"
// scaffolding templates configuration
grails.scaffolding.templates.domainSuffix = 'Instance'

// Set to false to use the new Grails 1.2 JSONBuilder in the render method
grails.json.legacy.builder = false
// enabled native2ascii conversion of i18n properties files
grails.enable.native2ascii = true
// packages to include in Spring bean scanning
grails.spring.bean.packages = []
// whether to disable processing of multi part requests
grails.web.disable.multipart=false

// request parameters to mask when logging exceptions
grails.exceptionresolver.params.exclude = ['password']

// configure auto-caching of queries by default (if false you can cache individual queries with 'cache: true')
grails.hibernate.cache.queries = false

grails.plugin.springsecurity.facebook.domain.classname = 'crowdera.FacebookUser'
grails.plugin.springsecurity.facebook.domain.appUserConnectionPropertyName = 'user'
grails.plugin.springsecurity.facebook.filter.redirect.failureHandler='facebookRedirectFailureHandler'

environments {
    development {
        crowdera.facebook.appId = '863349917018657'
        crowdera.facebook.secret = '821d52781c6ff719df996c2540fe2f5e'

        grails.plugin.springsecurity.facebook.appId = '${crowdera.facebook.appId}'
        grails.plugin.springsecurity.facebook.secret = '${crowdera.facebook.secret}'

        crowdera.BASE_URL = 'http://localhost:8080'

        grails.logging.jul.usebridge = true
        grails.dbconsole.urlRoot = '/secured/dbconsole'

        /* Stripe test keys */
        grails.plugins.stripe.secretKey = 'sk_test_38mNpPorbf5rPTQstcSvurUK'
        grails.plugins.stripe.publishableKey = 'pk_test_AygHVMpXYROmU9H9hvz7HY3p'

        /* FirstGiving Details */
        crowdera.firstgiving.BASE_URL= 'http://usapisandbox.fgdev.net'
        crowdera.firstgiving.uriPath= '/donation/creditcard'
        crowdera.firstgiving.JG_APPLICATIONKEY = 'b1d5db6b-1368-49cc-917c-e98758f28b36'
        crowdera.firstgiving.JG_SECURITYTOKEN = '277ce2dd-7d4e-4bf2-978d-f91af2624fad'
        
        /* Paypal Details */
        crowdera.paypal.PAYPAL_URL='https://www.sandbox.paypal.com/cgi-bin/webscr?cmd=_ap-payment&paykey='
        crowdera.paypal.BASE_URL= 'https://svcs.sandbox.paypal.com/AdaptivePayments/Pay'
        crowdera.paypal.X_PAYPAL_SECURITY_USERID= 'info-facilitator_api1.crowdera.co'
        crowdera.paypal.X_PAYPAL_SECURITY_PASSWORD= 'ZSD7Z9TJ4BLP8DBT'
        crowdera.paypal.X_PAYPAL_SECURITY_SIGNATURE= 'AYDVpnDtJwzfma0uPoGG8ZXKdkDlAhPPZoBbxVRwh93AGi3eiDDGIznY'
        crowdera.paypal.X_PAYPAL_APPLICATION_ID= 'APP-80W284485P519543T'
        crowdera.paypal.X_PAYPAL_REQUEST_DATA_FORMAT= 'JSON'
        crowdera.paypal.X_PAYPAL_RESPONSE_DATA_FORMAT= 'JSON'

        mandrill {
            apiKey = "R28ZHu6_5IkJWLFunpsJbw"
        }
    }
    test {
        /*  */
        crowdera.facebook.appId = '554475128028127'
        crowdera.facebook.secret = 'f1991f7bf85d445a346821967e2b1251'

        grails.plugin.springsecurity.facebook.appId = '${crowdera.facebook.appId}'
        grails.plugin.springsecurity.facebook.secret = '${crowdera.facebook.secret}'

        crowdera.BASE_URL = 'http://staging.crowdera.co'

        grails.logging.jul.usebridge = false
        grails.dbconsole.enabled = true
        grails.dbconsole.urlRoot = '/secured/dbconsole'

        /* Stripe test keys */
        grails.plugins.stripe.secretKey = 'sk_test_38mNpPorbf5rPTQstcSvurUK'
        grails.plugins.stripe.publishableKey = 'pk_test_AygHVMpXYROmU9H9hvz7HY3p'

        /* FirstGiving Details */
        crowdera.firstgiving.BASE_URL= 'http://usapisandbox.fgdev.net'
        crowdera.firstgiving.uriPath= '/donation/creditcard'
        crowdera.firstgiving.JG_APPLICATIONKEY = 'b1d5db6b-1368-49cc-917c-e98758f28b36'
        crowdera.firstgiving.JG_SECURITYTOKEN = '277ce2dd-7d4e-4bf2-978d-f91af2624fad'
        
        /* Paypal Details */
        crowdera.paypal.PAYPAL_URL='https://www.sandbox.paypal.com/cgi-bin/webscr?cmd=_ap-payment&paykey='
        crowdera.paypal.BASE_URL= 'https://svcs.sandbox.paypal.com/AdaptivePayments/Pay'
        crowdera.paypal.X_PAYPAL_SECURITY_USERID= 'info-facilitator_api1.crowdera.co'
        crowdera.paypal.X_PAYPAL_SECURITY_PASSWORD= 'ZSD7Z9TJ4BLP8DBT'
        crowdera.paypal.X_PAYPAL_SECURITY_SIGNATURE= 'AYDVpnDtJwzfma0uPoGG8ZXKdkDlAhPPZoBbxVRwh93AGi3eiDDGIznY'
        crowdera.paypal.X_PAYPAL_APPLICATION_ID= 'APP-80W284485P519543T'
        crowdera.paypal.X_PAYPAL_REQUEST_DATA_FORMAT= 'JSON'
        crowdera.paypal.X_PAYPAL_RESPONSE_DATA_FORMAT= 'JSON'

        mandrill {
            apiKey = "R28ZHu6_5IkJWLFunpsJbw"
        }
    }
    production {
        crowdera.facebook.appId = '354215177926850'
        crowdera.facebook.secret = '24ee39e963145cee9d49fe1707e0a214'

        grails.plugin.springsecurity.facebook.appId = '${crowdera.facebook.appId}'
        grails.plugin.springsecurity.facebook.secret = '${crowdera.facebook.secret}'

        crowdera.BASE_URL = 'https://crowdera.co'

        grails.logging.jul.usebridge = false
        grails.dbconsole.enabled = true
        grails.dbconsole.urlRoot = '/secured/dbconsole'
        // TODO: grails.serverURL = "http://www.changeme.com"

        /* Stripe test keys */
        grails.plugins.stripe.secretKey = 'sk_test_38mNpPorbf5rPTQstcSvurUK'
        grails.plugins.stripe.publishableKey = 'pk_test_AygHVMpXYROmU9H9hvz7HY3p'

        /* FirstGiving Details */
        crowdera.firstgiving.BASE_URL= 'https://api.firstgiving.com'
        crowdera.firstgiving.uriPath= '/donation/creditcard'
        crowdera.firstgiving.JG_APPLICATIONKEY = '7d2ba10c-b005-4115-a6e4-8336c5071c9d'
        crowdera.firstgiving.JG_SECURITYTOKEN = '8724ab81-a4ba-4d52-8374-1e2f6f2311ca'
        
        /* Paypal Details */
        crowdera.paypal.PAYPAL_URL='https://www.paypal.com/cgi-bin/webscr?cmd=_ap-payment&paykey='
        crowdera.paypal.BASE_URL= 'https://svcs.paypal.com/AdaptivePayments/Pay'
        crowdera.paypal.X_PAYPAL_SECURITY_USERID= 'info_api1.crowdera.co'
        crowdera.paypal.X_PAYPAL_SECURITY_PASSWORD= 'AHEFPRUXWJFMCCDE'
        crowdera.paypal.X_PAYPAL_SECURITY_SIGNATURE= 'AFcWxV21C7fd0v3bYYYRCpSSRl31AZyNu3X6Z3O2eTTYLGFEQuwRsUm2'
        crowdera.paypal.X_PAYPAL_APPLICATION_ID= 'APP-4SR18911AP980871P'
        crowdera.paypal.X_PAYPAL_REQUEST_DATA_FORMAT= 'JSON'
        crowdera.paypal.X_PAYPAL_RESPONSE_DATA_FORMAT= 'JSON'


        /* Stripe live keys */
        /*
        grails.plugins.stripe.secretKey = 'sk_live_UJc8cRZYdv4AasXP3whR6xfX'
        grails.plugins.stripe.publishableKey = 'pk_live_dABB1ahq9wrYlnUl1fN5wl1j'
        */

        mandrill {
            apiKey = "R28ZHu6_5IkJWLFunpsJbw"
        }
    }
}

// log4j configuration
log4j = {
    // Example of changing the log pattern for the default console appender:

    appenders {
        console name: 'stdout', layout: pattern(conversionPattern: '%c{2} %m%n')
        file name: 'file', file: 'crowdera.log'
    }

    root {
        info 'stdout', 'file'
    }

    info   'crowdera'

    error  'org.codehaus.groovy.grails.web.servlet',        // controllers
           'org.codehaus.groovy.grails.web.pages',          // GSP
           'org.codehaus.groovy.grails.web.sitemesh',       // layouts
           'org.codehaus.groovy.grails.web.mapping.filter', // URL mapping
           'org.codehaus.groovy.grails.web.mapping',        // URL mapping
           'org.codehaus.groovy.grails.commons',            // core / classloading
           'org.codehaus.groovy.grails.plugins',            // plugins
           'org.codehaus.groovy.grails.orm.hibernate',      // hibernate integration
           'org.springframework',
           'org.hibernate',
           'net.sf.ehcache.hibernate'
}

quartz {
    autoStartup = false
    jdbcStore = false
}

aws {
    domain = "s3.amazonaws.com"
    accessKey = "AKIAIAZDDDNXF3WLSRXQ"
    secretKey = "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"
    bucketName = "crowdera"
}

// Added by the Spring Security Core plugin:
grails.plugin.springsecurity.logout.postOnly = false
grails.plugin.springsecurity.userLookup.userDomainClassName = 'crowdera.User'
grails.plugin.springsecurity.userLookup.authorityJoinClassName = 'crowdera.UserRole'
grails.plugin.springsecurity.authority.className = 'crowdera.Role'
grails.plugin.springsecurity.controllerAnnotations.staticRules = [
    '/secured/**':                    ['ROLE_ADMIN'],
	'/**':                            ['permitAll']
//	'/index':                         ['permitAll'],
//	'/index.gsp':                     ['permitAll'],
//	'/**/js/**':                      ['permitAll'],
//	'/**/css/**':                     ['permitAll'],
//	'/**/images/**':                  ['permitAll'],
//	'/**/favicon.ico':                ['permitAll'],
//	'/dbconsole':                     ['permitAll']
]
