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

//To accept the header information
grails.mime.use.accept.header = true // Default value is true.
grails.mime.disable.accept.header.userAgents = []

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
grails.plugin.springsecurity.facebook.filter.redirect.successHandler='facebookRedirectSuccessHandler'
grails.facebook.api.url = "https://graph.facebook.com/me?fields=id,name,verified,age_range,email"

environments {
	development {
		crowdera.facebook.appId = '1327912437266577'//'333909376820194'
		crowdera.facebook.secret = 'feeebd852cc9b6dbe374cb4a2d413532'//'0965e3232aafa265ff319903efa4c6a5'

		grails.plugin.springsecurity.facebook.appId = '${crowdera.facebook.appId}'
		grails.plugin.springsecurity.facebook.secret = '${crowdera.facebook.secret}'

		/*Addition of an extra forward slash to all the base URL's to accommodate country_code*/
		crowdera.BASE_URL = 'http://localhost:8080/'

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
		crowdera.paypal.GetVerifiedStatus_URL = 'https://svcs.sandbox.paypal.com/AdaptiveAccounts/GetVerifiedStatus'
		crowdera.paypal.GetVerifiedStatus_REQUEST_DATA_FORMAT = 'NV'
		
		/* FreshDesk Details */
		crowdera.freshDesk.LOGIN_NAME = 'Crowdera Team'
		crowdera.freshDesk.LOGIN_EMAIL = 'info@crowdera.co'
		crowdera.freshDesk.sharedSecret = '9073b71999fbe30aa3967720181d3eab'
		crowdera.freshDesk.BASE_URL = 'https://crowdera.freshdesk.com/login/sso'
		
		/*MailChimp details*/
		crowdera.MAILCHIMP.SUBSCRIBE_URL="http://crowdera.us3.list-manage.com/subscribe/post"
		crowdera.MAILCHIMP.USERID="41c633b30eeabc78e88bd090d"
		crowdera.MAILCHIMP.LISTID="e37aea1b78"
		crowdera.MAILCHIMP.CLIENT_ID='591589688835'
		crowdera.MAILCHIMP.CLIENT_SECRET='d7078ea09570384facf269d821845078'
		crowdera.MAILCHIMP.TOKEN_ENDPOINT="https://login.mailchimp.com/oauth2/token"
		crowdera.MAILCHIMP.OAUTH_URL='https://login.mailchimp.com/oauth2/authorize'
		crowdea.MAILCHIMP.DC_URL ='https://login.mailchimp.com/oauth2/metadata'
		crowdera.MAILCHIMP.MEMBER_URL ='.api.mailchimp.com/3.0/lists'
		
		/*PayUMoney details*/
		crowdera.PAYU.BASE_URL = 'http://localhost:8080'
		crowdera.PAYU.TEST_URL='https://test.payu.in/_payment.php'
		crowdera.PAYU.KEY='czBDue'
		crowdera.PAYU.SALT='g57jz4Cw'
		
		/*Citrus Credentials*/
		crowdera.CITRUS.SPLITPAY_URL = "https://splitpaysbox.Citruspay.com"
		crowdera.CITRUS.BASE_URL = "https://splitpay.citruspay.com"
		crowdera.CITRUS.ACCESS_KEY = "VVXKH02XVEWHUGWJHAMI"
		crowdera.CITRUS.SECRETE_KEY = "4c86cabfc7fb68d2261f35087a8edece44f856bd"
		crowdera.CITRUS.VANITYURL = "8wqhvmq506"
        
        /* Wepay Details */
        crowdera.wepay.BASE_URL= 'https://stage.wepayapi.com/v2'
        crowdera.wepay.CLIENT_ID= '181922'
        crowdera.wepay.CLIENT_SECRET= 'd6f70985bc'
        crowdera.wepay.ACCESS_TOKEN = 'STAGE_5fe2214cb89aecdb2c567d5fd58080d048cc0c5afad52a65738101beab47d94c'
        crowdera.wepay.account_id = '1456620204'
		
		/*ConstantContact details*/
		crowdera.cc.OAUTH_URL='https://oauth2.constantcontact.com/oauth2/oauth/siteowner/authorize?response_type=code&display=page&'
		crowdera.cc.TOKEN_URL='https://oauth2.constantcontact.com/oauth2/oauth/token?'
		crowdera.cc.CONTACT_URL='https://api.constantcontact.com/v2/contacts?status=ALL&limit=50&api_key='
		crowdera.cc.CLIENT_KEY='u9jc9nmmmtptyyz2y75cspry'
		crowdera.cc.CLIENT_SECRET='fRGDUHAf8tuS74upJgXhctTw'
		
		/*Gmail details*/
		crowdera.gmail.OAUTH_URL='https://accounts.google.com/o/oauth2/auth?'
		crowdera.gmail.TOKEN_URL='https://accounts.google.com/o/oauth2/token?'
		crowdera.gmail.CONTACT_URL='https://www.google.com/m8/feeds/contacts/'
		crowdera.gmail.CLIENT_KEY='264232108471-98vs4ujo7vtsf9tsqhhrurlbnobc2c1a.apps.googleusercontent.com'
		crowdera.gmail.CLIENT_SECRET='LrTLoWIgcQYaw0MmclzCG0Zi'
		crowdera.gmail.SCOPE='profile https://www.google.com/m8/feeds'
		
		/*Google client details*/
		crowdera.Client_Id = '837867811198'
		crowdera.Client_Id_alphanumeric = '-pjgbmmqbalu9ddqtq6ijtk54u8f6kiuu.apps.googleusercontent.com'
		crowdera.api_key = 'AIzaSyA6USGi0-RoCLFCDWhnYz8CUa-pF93Z0r4'
		
		mandrill {
			apiKey = "R28ZHu6_5IkJWLFunpsJbw"
		}
		
		/*google plus login*/
		oauth {
			 providers {
				 google {
					 api = org.grails.plugin.springsecurity.oauth.GoogleApi20
					 key = '837867811198-pjgbmmqbalu9ddqtq6ijtk54u8f6kiuu.apps.googleusercontent.com'
					 secret = 'xxwHTgLUigJ9BdHFl4c3iouA'
					 successUri = '/login/googleSuccess'
					 failureUri = '/login/googleFailure'
					 callback = "http://localhost:8080/oauth/google/callback"
					 scope = 'profile https://www.google.com/m8/feeds https://www.googleapis.com/auth/plus.me https://www.googleapis.com/auth/userinfo.profile https://www.googleapis.com/auth/userinfo.email'
				}
				 facebook {
					 api = org.scribe.builder.api.FacebookApi
					 scope = 'email'
					 key = '1023231227691905'
					 secret = '62799ed033c94866b84d718053ebaff2'
					 successUri = '/login/facebookSuccess'
					 failureUri = '/login/facebookFailure'
					 callback = "http://localhost:8080/oauth/facebook/callback"
					 scopes = "['public_profile','email','name','user']"
				   }
			}
		}
	}
	test {
		/*  */
		crowdera.facebook.appId = '1984579665110362'
		crowdera.facebook.secret = 'd616d5adc8dd3f2b290252b2b7fd15f6'

		grails.plugin.springsecurity.facebook.appId = '${crowdera.facebook.appId}'
		grails.plugin.springsecurity.facebook.secret = '${crowdera.facebook.secret}'

		/*Addition of an extra forward slash to all the base URL's to accommodate country_code*/
		crowdera.BASE_URL = 'http://test.gocrowdera.com/'

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
		crowdera.paypal.GetVerifiedStatus_URL = 'https://svcs.sandbox.paypal.com/AdaptiveAccounts/GetVerifiedStatus'
		crowdera.paypal.GetVerifiedStatus_REQUEST_DATA_FORMAT = 'NV'
        
        /*PayUMoney details*/
        crowdera.PAYU.BASE_URL = 'http://test.gocrowdera.com'
        crowdera.PAYU.TEST_URL='https://test.payu.in/_payment.php'
        crowdera.PAYU.KEY='czBDue'
        crowdera.PAYU.SALT='g57jz4Cw'
        
        
        /*Citrus Credentials*/
        crowdera.CITRUS.SPLITPAY_URL = "https://splitpaysbox.Citruspay.com"
        crowdera.CITRUS.BASE_URL = "https://splitpay.citruspay.com"
        crowdera.CITRUS.ACCESS_KEY = "VVXKH02XVEWHUGWJHAMI"
        crowdera.CITRUS.SECRETE_KEY = "4c86cabfc7fb68d2261f35087a8edece44f856bd"
        crowdera.CITRUS.VANITYURL = "8wqhvmq506"
		
		/* FreshDesk Details */
		crowdera.freshDesk.LOGIN_NAME = 'Crowdera Team'
		crowdera.freshDesk.LOGIN_EMAIL = 'info@crowdera.co'
		crowdera.freshDesk.sharedSecret = '9073b71999fbe30aa3967720181d3eab'
		crowdera.freshDesk.BASE_URL = 'https://crowdera.freshdesk.com/login/sso'
		
		/*MailChimp details*/
		crowdera.MAILCHIMP.SUBSCRIBE_URL="http://crowdera.us3.list-manage.com/subscribe/post"
		crowdera.MAILCHIMP.USERID="41c633b30eeabc78e88bd090d"
		crowdera.MAILCHIMP.LISTID="e37aea1b78"
		crowdera.MAILCHIMP.CLIENT_ID='834416564833'
		crowdera.MAILCHIMP.CLIENT_SECRET='15cdf65ede4a7af282f3055625051bf5'
		crowdera.MAILCHIMP.TOKEN_ENDPOINT="https://login.mailchimp.com/oauth2/token"
		crowdera.MAILCHIMP.OAUTH_URL='https://login.mailchimp.com/oauth2/authorize'
		crowdea.MAILCHIMP.DC_URL ='https://login.mailchimp.com/oauth2/metadata'
		crowdera.MAILCHIMP.MEMBER_URL ='.api.mailchimp.com/3.0/lists'
		
		/*ConstantContact details*/
		crowdera.cc.OAUTH_URL='https://oauth2.constantcontact.com/oauth2/oauth/siteowner/authorize?response_type=code&display=page&'
		crowdera.cc.TOKEN_URL='https://oauth2.constantcontact.com/oauth2/oauth/token?'
		crowdera.cc.CONTACT_URL='https://api.constantcontact.com/v2/contacts?status=ALL&limit=50&api_key='
		crowdera.cc.CLIENT_KEY='nkge6ryhs6wnwwbjw9rvtzb6'
		crowdera.cc.CLIENT_SECRET='QCqxhYP7ZHtG6MyCKSqAnNjT'
		
		/*Gmail details*/
		crowdera.gmail.OAUTH_URL='https://accounts.google.com/o/oauth2/auth?'
		crowdera.gmail.TOKEN_URL='https://accounts.google.com/o/oauth2/token?'
		crowdera.gmail.CONTACT_URL='https://www.google.com/m8/feeds/contacts/'
		//crowdera.gmail.CLIENT_KEY='264232108471-98vs4ujo7vtsf9tsqhhrurlbnobc2c1a.apps.googleusercontent.com'
		//crowdera.gmail.CLIENT_SECRET='LrTLoWIgcQYaw0MmclzCG0Zi'
		crowdera.gmail.CLIENT_KEY='481175145484-09jo1l0n1g655suod0d1656m2fdl6965.apps.googleusercontent.com'
		crowdera.gmail.CLIENT_SECRET='MglGUHRlBGREPZ2lH8QfEL9T'
		crowdera.gmail.SCOPE='profile https://www.google.com/m8/feeds https://www.googleapis.com/auth/contacts'
		
		/*Google client details*/
		crowdera.Client_Id = '837867811198'
		crowdera.Client_Id_alphanumeric = '-t23m00r907r9o4ubsdr3dlsse38gooqd.apps.googleusercontent.com'
		crowdera.api_key = 'AIzaSyA6USGi0-RoCLFCDWhnYz8CUa-pF93Z0r4'

		mandrill {
			apiKey = "R28ZHu6_5IkJWLFunpsJbw"
		}
		
		/*google plus login*/
		oauth {
			providers {
				google {
					api = org.grails.plugin.springsecurity.oauth.GoogleApi20
					//key = '837867811198-t23m00r907r9o4ubsdr3dlsse38gooqd.apps.googleusercontent.com'
					//secret = '0fE42pditvlL8Yzgw9Jw1PhL'
					key = '481175145484-09jo1l0n1g655suod0d1656m2fdl6965.apps.googleusercontent.com'
					secret = 'MglGUHRlBGREPZ2lH8QfEL9T'
					successUri = '/login/googleSuccess'
					failureUri = '/login/googleFailure'
					callback = "http://test.gocrowdera.com/oauth/google/callback"
					scope = 'profile https://www.google.com/m8/feeds https://www.googleapis.com/auth/plus.me https://www.googleapis.com/auth/userinfo.profile https://www.googleapis.com/auth/userinfo.email https://www.googleapis.com/auth/plus.login https://www.googleapis.com/auth/contacts'
				}
				
				facebook {
					api = org.scribe.builder.api.FacebookApi
					key = '1984579665110362'
					secret = 'd616d5adc8dd3f2b290252b2b7fd15f6'
					successUri = '/login/facebookSuccess'
					failureUri = '/login/facebookFailure'
					callback = "http://test.gocrowdera.com/oauth/facebook/callback"
					scopes = "['public_profile','email','name','user']"
				  }
			}
		}
		
		/*grails {
			assets {
				cdn {
					provider = 's3'
					directory = 'crowdera'
					accessKey = 'AKIAIAZDDDNXF3WLSRXQ'
					secretKey = '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'
					storagePath = "cdn-assets"
					expires = 365 // Expires in 1 year (value in days)
					gzip = true
				}
			}
		}

		grails.assets.url = "http://d1hsbjre03buja.cloudfront.net/crowdera/cdn-assets"*/

	}
	staging {
		crowdera.facebook.appId = '554475128028127'
		crowdera.facebook.secret = 'f1991f7bf85d445a346821967e2b1251'

		grails.plugin.springsecurity.facebook.appId = '${crowdera.facebook.appId}'
		grails.plugin.springsecurity.facebook.secret = '${crowdera.facebook.secret}'

		crowdera.BASE_URL = 'https://staging.gocrowdera.com/'
		crowdera.COUNTRY_CODE = 'US'

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
		crowdera.paypal.GetVerifiedStatus_URL = 'https://svcs.paypal.com/AdaptiveAccounts/GetVerifiedStatus'
		crowdera.paypal.GetVerifiedStatus_REQUEST_DATA_FORMAT = 'NV'
        
        /*PayUMoney details*/
        crowdera.PAYU.BASE_URL = 'https://staging.gocrowdera.com'
        crowdera.PAYU.TEST_URL='https://secure.payu.in/_payment.php'
        crowdera.PAYU.KEY='5geKCB'
        crowdera.PAYU.SALT='Gtr6fF9A'
        
        
        /*Citrus Credentials*/
        crowdera.CITRUS.SPLITPAY_URL = "https://splitpay.citruspay.com"
        crowdera.CITRUS.BASE_URL = "https://splitpay.citruspay.com"
        crowdera.CITRUS.ACCESS_KEY = "0OPFFQDNQ9WEZM9UVIMZ"
        crowdera.CITRUS.SECRETE_KEY = "54912af376b8c3463b59a188551a1236fb2fb5c1"
        crowdera.CITRUS.VANITYURL = "c5vrgwoucm"
		
		/* Wepay Details */
		crowdera.wepay.BASE_URL= 'https://wepayapi.com/v2'
		crowdera.wepay.CLIENT_ID= '90022'
		crowdera.wepay.CLIENT_SECRET= '0ddf8eed29'
		crowdera.wepay.ACCESS_TOKEN = 'PRODUCTION_d775cee394530216fe3bdaf33c45548e12834e6c2c33fd6f0071230b4643c168'
		crowdera.wepay.account_id = '400367523'
		
		/* FreshDesk Details */
		crowdera.freshDesk.LOGIN_NAME = 'Crowdera Team'
		crowdera.freshDesk.LOGIN_EMAIL = 'info@crowdera.co'
		crowdera.freshDesk.sharedSecret = '9073b71999fbe30aa3967720181d3eab'
		crowdera.freshDesk.BASE_URL = 'https://crowdera.freshdesk.com/login/sso'
		
		/*MailChimp details*/
		crowdera.MAILCHIMP.SUBSCRIBE_URL="http://crowdera.us3.list-manage.com/subscribe/post"
		crowdera.MAILCHIMP.USERID="41c633b30eeabc78e88bd090d"
		crowdera.MAILCHIMP.LISTID="e37aea1b78"
		crowdera.MAILCHIMP.CLIENT_ID='834416564833'
		crowdera.MAILCHIMP.CLIENT_SECRET='15cdf65ede4a7af282f3055625051bf5'
		crowdera.MAILCHIMP.TOKEN_ENDPOINT="https://login.mailchimp.com/oauth2/token"
		crowdera.MAILCHIMP.OAUTH_URL='https://login.mailchimp.com/oauth2/authorize'
		crowdea.MAILCHIMP.DC_URL ='https://login.mailchimp.com/oauth2/metadata'
		crowdera.MAILCHIMP.MEMBER_URL ='.api.mailchimp.com/3.0/lists'
		
		/*ConstantContact details*/
		crowdera.cc.OAUTH_URL='https://oauth2.constantcontact.com/oauth2/oauth/siteowner/authorize?response_type=code&display=page&'
		crowdera.cc.TOKEN_URL='https://oauth2.constantcontact.com/oauth2/oauth/token?'
		crowdera.cc.CONTACT_URL='https://api.constantcontact.com/v2/contacts?status=ALL&limit=50&api_key='
		crowdera.cc.CLIENT_KEY='u9jc9nmmmtptyyz2y75cspry'
		crowdera.cc.CLIENT_SECRET='fRGDUHAf8tuS74upJgXhctTw'
		
		/*Gmail details*/
		crowdera.gmail.OAUTH_URL='https://accounts.google.com/o/oauth2/auth?'
		crowdera.gmail.TOKEN_URL='https://accounts.google.com/o/oauth2/token?'
		crowdera.gmail.CONTACT_URL='https://www.google.com/m8/feeds/contacts/'
		//crowdera.gmail.CLIENT_KEY='264232108471-98vs4ujo7vtsf9tsqhhrurlbnobc2c1a.apps.googleusercontent.com'
		//crowdera.gmail.CLIENT_SECRET='LrTLoWIgcQYaw0MmclzCG0Zi'
		crowdera.gmail.CLIENT_KEY='481175145484-4sd4fn0pj9kgc7rap0poh4uq8i8j8irb.apps.googleusercontent.com'
		crowdera.gmail.CLIENT_SECRET='Lsh29YP-_fWfwBH6AUmZnzAW'
		crowdera.gmail.SCOPE='profile https://www.google.com/m8/feeds https://www.googleapis.com/auth/contacts'
		 
		mandrill {
			apiKey = "R28ZHu6_5IkJWLFunpsJbw"
		}
		
		/*google plus login*/
		oauth {
			providers {
				google {
					api = org.grails.plugin.springsecurity.oauth.GoogleApi20
					//key = '1049378830663-cr6s49lmtiuo29b0rkpj015irpls5rsf.apps.googleusercontent.com'
					//secret = '_8Zx6cP4s8Iv4_4VyiRifxUw'
					key = '481175145484-4sd4fn0pj9kgc7rap0poh4uq8i8j8irb.apps.googleusercontent.com'
					secret = 'Lsh29YP-_fWfwBH6AUmZnzAW'
					successUri = '/login/googleSuccess'
					failureUri = '/login/googleFailure'
					callback = "https://staging.gocrowdera.com/oauth/google/callback"
					scope = 'profile https://www.google.com/m8/feeds https://www.googleapis.com/auth/plus.me https://www.googleapis.com/auth/userinfo.profile https://www.googleapis.com/auth/userinfo.email https://www.googleapis.com/auth/plus.login https://www.googleapis.com/auth/contacts'
					//scope = 'https://www.googleapis.com/auth/plus.me https://www.googleapis.com/auth/userinfo.profile https://www.googleapis.com/auth/userinfo.email'
				}
				facebook {
					api = org.scribe.builder.api.FacebookApi
					scope = 'email'
					key = '554475128028127'
					secret = 'f1991f7bf85d445a346821967e2b1251'
					successUri = '/login/facebookSuccess'
					failureUri = '/login/facebookFailure'
					callback = "https://staging.gocrowdera.com/oauth/facebook/callback"
					scopes = "['public_profile','email','name','user']"
				  }
					
			}
		}
		
	}
	production {
		crowdera.facebook.appId = '354215177926850'
		crowdera.facebook.secret = '24ee39e963145cee9d49fe1707e0a214'

		grails.plugin.springsecurity.facebook.appId = '${crowdera.facebook.appId}'
		grails.plugin.springsecurity.facebook.secret = '${crowdera.facebook.secret}'

		crowdera.BASE_URL = 'https://gocrowdera.com/'
		crowdera.BASE_URL1 = 'https://www.gocrowdera.com/'

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
		crowdera.paypal.GetVerifiedStatus_URL = 'https://svcs.paypal.com/AdaptiveAccounts/GetVerifiedStatus'
		crowdera.paypal.GetVerifiedStatus_REQUEST_DATA_FORMAT = 'NV'
        
        /*PayUMoney details*/
        crowdera.PAYU.BASE_URL = 'https://gocrowdera.com'
        crowdera.PAYU.TEST_URL='https://secure.payu.in/_payment.php'
        crowdera.PAYU.KEY='5geKCB'
        crowdera.PAYU.SALT='Gtr6fF9A'
        
        
        /*Citrus Credentials*/
        crowdera.CITRUS.SPLITPAY_URL = "https://splitpay.citruspay.com"
        crowdera.CITRUS.BASE_URL = "https://splitpay.citruspay.com"
        crowdera.CITRUS.ACCESS_KEY = "0OPFFQDNQ9WEZM9UVIMZ"
        crowdera.CITRUS.SECRETE_KEY = "54912af376b8c3463b59a188551a1236fb2fb5c1"
        crowdera.CITRUS.VANITYURL = "c5vrgwoucm"
		
		/* Wepay Details */
		crowdera.wepay.BASE_URL= 'https://wepayapi.com/v2'
		crowdera.wepay.CLIENT_ID= '90022'
		crowdera.wepay.CLIENT_SECRET= '0ddf8eed29'
		crowdera.wepay.ACCESS_TOKEN = 'PRODUCTION_d775cee394530216fe3bdaf33c45548e12834e6c2c33fd6f0071230b4643c168'
		crowdera.wepay.account_id = '400367523'
		
		/* FreshDesk Details */
		crowdera.freshDesk.LOGIN_NAME = 'Crowdera Team'
		crowdera.freshDesk.LOGIN_EMAIL = 'info@crowdera.co'
		crowdera.freshDesk.sharedSecret = '9073b71999fbe30aa3967720181d3eab'
		crowdera.freshDesk.BASE_URL = 'https://crowdera.freshdesk.com/login/sso'
		
		/*MailChimp details*/
		crowdera.MAILCHIMP.SUBSCRIBE_URL="https://crowdera.us3.list-manage.com/subscribe/post"
		crowdera.MAILCHIMP.USERID="41c633b30eeabc78e88bd090d"
		crowdera.MAILCHIMP.LISTID="e37aea1b78"
		crowdera.MAILCHIMP.CLIENT_ID='906881120149'
		crowdera.MAILCHIMP.CLIENT_SECRET='fec01a52a52ff6c0af693d4a201dc79b'
		crowdera.MAILCHIMP.TOKEN_ENDPOINT="https://login.mailchimp.com/oauth2/token"
		crowdera.MAILCHIMP.OAUTH_URL='https://login.mailchimp.com/oauth2/authorize'
		crowdea.MAILCHIMP.DC_URL ='https://login.mailchimp.com/oauth2/metadata'
		crowdera.MAILCHIMP.MEMBER_URL ='.api.mailchimp.com/3.0/lists'

		/* Stripe live keys */
		/*
		grails.plugins.stripe.secretKey = 'sk_live_UJc8cRZYdv4AasXP3whR6xfX'
		grails.plugins.stripe.publishableKey = 'pk_live_dABB1ahq9wrYlnUl1fN5wl1j'
		*/
		
		/*ConstantContact details*/
		crowdera.cc.OAUTH_URL='https://oauth2.constantcontact.com/oauth2/oauth/siteowner/authorize?response_type=code&display=page&'
		crowdera.cc.TOKEN_URL='https://oauth2.constantcontact.com/oauth2/oauth/token?'
		crowdera.cc.CONTACT_URL='https://api.constantcontact.com/v2/contacts?status=ALL&limit=50&api_key='
		crowdera.cc.CLIENT_KEY='s2wnhy3ez6wp6czjaeb7e7q8'
		crowdera.cc.CLIENT_SECRET='C4Hh6sQQmpvdF27KBUb3mrWe'
		
		/*Gmail details*/
		crowdera.gmail.OAUTH_URL='https://accounts.google.com/o/oauth2/auth?'
		crowdera.gmail.TOKEN_URL='https://accounts.google.com/o/oauth2/token?'
		crowdera.gmail.CONTACT_URL='https://www.google.com/m8/feeds/contacts/'
		//crowdera.gmail.CLIENT_KEY='264232108471-98vs4ujo7vtsf9tsqhhrurlbnobc2c1a.apps.googleusercontent.com'
		//crowdera.gmail.CLIENT_SECRET='LrTLoWIgcQYaw0MmclzCG0Zi'
		crowdera.gmail.CLIENT_KEY='481175145484-hrjfk834gis1n5kfk4pfdllchkti0g9c.apps.googleusercontent.com'
		crowdera.gmail.CLIENT_SECRET='vJjZKqYjwosa4fQZTMWa0Q2Q'
		crowdera.gmail.SCOPE='profile https://www.google.com/m8/feeds'
		
		mandrill {
			apiKey = "R28ZHu6_5IkJWLFunpsJbw"
		}
		
		/*google plus login*/
		oauth {
			providers {
				google {
					api = org.grails.plugin.springsecurity.oauth.GoogleApi20
					//key = '1049378830663-jqkmicdbahs4rgr7er4013re8mjkd0rd.apps.googleusercontent.com'
					//secret = 'zIubdLkqqwlATWRESK6BYssK'
					key='481175145484-hrjfk834gis1n5kfk4pfdllchkti0g9c.apps.googleusercontent.com'
					secret ='vJjZKqYjwosa4fQZTMWa0Q2Q'
					successUri = '/login/googleSuccess'
					failureUri = '/login/googleFailure'
					callback = "https://gocrowdera.com/oauth/google/callback"
					scope = 'https://www.googleapis.com/auth/plus.me https://www.googleapis.com/auth/userinfo.profile https://www.googleapis.com/auth/userinfo.email'
				}
				facebook {
					api = org.scribe.builder.api.FacebookApi
					key = '354215177926850'
					secret = '24ee39e963145cee9d49fe1707e0a214'
					successUri = '/login/facebookSuccess'
					failureUri = '/login/facebookFailure'
					callback = "https://gocrowdera.com/oauth/facebook/callback"
					scopes = "['public_profile','email','name','user']"
				  }
			}
		}
		
		/*grails {
			assets {
				cdn {
					provider = 's3'
					directory = 'crowdera'
					accessKey = 'AKIAIAZDDDNXF3WLSRXQ'
					secretKey = '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'
					storagePath = "production-cdn-assets"
					expires = 365 // Expires in 1 year (value in days)
					gzip = true
				}
			}
		}
		
		grails.assets.url = "http://d38k0frcj7wnf2.cloudfront.net/crowdera/cdn-assets"*/

	}

	testIndia {
		/*  */
		crowdera.facebook.appId = '554475128028127'
		crowdera.facebook.secret = 'f1991f7bf85d445a346821967e2b1251'

		grails.plugin.springsecurity.facebook.appId = '${crowdera.facebook.appId}'
		grails.plugin.springsecurity.facebook.secret = '${crowdera.facebook.secret}'

		crowdera.BASE_URL = 'https://gocrowdera.com/'

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
	   crowdera.paypal.GetVerifiedStatus_URL = 'https://svcs.sandbox.paypal.com/AdaptiveAccounts/GetVerifiedStatus'
	   crowdera.paypal.GetVerifiedStatus_REQUEST_DATA_FORMAT = 'NV'

		/* FreshDesk Details */
		crowdera.freshDesk.LOGIN_NAME = 'Crowdera Team'
		crowdera.freshDesk.LOGIN_EMAIL = 'info@crowdera.co'
		crowdera.freshDesk.sharedSecret = '9073b71999fbe30aa3967720181d3eab'
		crowdera.freshDesk.BASE_URL = 'https://crowdera.freshdesk.com/login/sso'
		
		/*MailChimp details*/
		crowdera.MAILCHIMP.SUBSCRIBE_URL="http://crowdera.us3.list-manage.com/subscribe/post"
		crowdera.MAILCHIMP.USERID="41c633b30eeabc78e88bd090d"
		crowdera.MAILCHIMP.LISTID="e37aea1b78"
		crowdera.MAILCHIMP.CLIENT_ID='834416564833'
		crowdera.MAILCHIMP.CLIENT_SECRET='15cdf65ede4a7af282f3055625051bf5'
		crowdera.MAILCHIMP.TOKEN_ENDPOINT="https://login.mailchimp.com/oauth2/token"
		crowdera.MAILCHIMP.OAUTH_URL='https://login.mailchimp.com/oauth2/authorize'
		crowdea.MAILCHIMP.DC_URL ='https://login.mailchimp.com/oauth2/metadata'
		crowdera.MAILCHIMP.MEMBER_URL ='.api.mailchimp.com/3.0/lists'
		
		/*PayUMoney details*/
		crowdera.PAYU.BASE_URL = 'http://test.crowdera.in'
		crowdera.PAYU.TEST_URL='https://test.payu.in/_payment.php'
		crowdera.PAYU.KEY='czBDue'
		crowdera.PAYU.SALT='g57jz4Cw'
		
		
		/*Citrus Credentials*/
		crowdera.CITRUS.SPLITPAY_URL = "https://splitpaysbox.Citruspay.com"
		crowdera.CITRUS.BASE_URL = "https://splitpay.citruspay.com"
		crowdera.CITRUS.ACCESS_KEY = "VVXKH02XVEWHUGWJHAMI"
		crowdera.CITRUS.SECRETE_KEY = "4c86cabfc7fb68d2261f35087a8edece44f856bd"
		crowdera.CITRUS.VANITYURL = "8wqhvmq506"
		
		
		/*ConstantContact details*/
		crowdera.cc.OAUTH_URL='https://oauth2.constantcontact.com/oauth2/oauth/siteowner/authorize?response_type=code&display=page&'
		crowdera.cc.TOKEN_URL='https://oauth2.constantcontact.com/oauth2/oauth/token?'
		crowdera.cc.CONTACT_URL='https://api.constantcontact.com/v2/contacts?status=ALL&limit=50&api_key='
		crowdera.cc.CLIENT_KEY='nkge6ryhs6wnwwbjw9rvtzb6'
		crowdera.cc.CLIENT_SECRET='QCqxhYP7ZHtG6MyCKSqAnNjT'
		
		/*Gmail details*/
		crowdera.gmail.OAUTH_URL='https://accounts.google.com/o/oauth2/auth?'
		crowdera.gmail.TOKEN_URL='https://accounts.google.com/o/oauth2/token?'
		crowdera.gmail.CONTACT_URL='https://www.google.com/m8/feeds/contacts/'
		crowdera.gmail.CLIENT_KEY='264232108471-98vs4ujo7vtsf9tsqhhrurlbnobc2c1a.apps.googleusercontent.com'
		crowdera.gmail.CLIENT_SECRET='LrTLoWIgcQYaw0MmclzCG0Zi'
		crowdera.gmail.SCOPE='profile https://www.google.com/m8/feeds'
		
		/*Google client details*/
		crowdera.Client_Id = '837867811198'
		crowdera.Client_Id_alphanumeric = '-l7ajlniufpo6vovi53ujcrfvq8u86fba.apps.googleusercontent.com'
		crowdera.api_key = 'AIzaSyA6USGi0-RoCLFCDWhnYz8CUa-pF93Z0r4'

		mandrill {
			apiKey = "R28ZHu6_5IkJWLFunpsJbw"
		}
		
		/*google plus login*/
		oauth {
			providers {
				google {
					api = org.grails.plugin.springsecurity.oauth.GoogleApi20
					key = '837867811198-l7ajlniufpo6vovi53ujcrfvq8u86fba.apps.googleusercontent.com'
					secret = 'ErukSE0YqIHfHfXdLEcM8n5p'
					successUri = '/login/googleSuccess'
					failureUri = '/login/googleFailure'
					callback = "http://test.crowdera.in/oauth/google/callback"
					scope = 'https://www.googleapis.com/auth/plus.me https://www.googleapis.com/auth/userinfo.profile https://www.googleapis.com/auth/userinfo.email'
				}
			}
		}
	}
	
	stagingIndia {
		crowdera.facebook.appId = '813336405432098'
		crowdera.facebook.secret = '84e6f667ea73b59ed42fa0b531a1e22a'

		grails.plugin.springsecurity.facebook.appId = '${crowdera.facebook.appId}'
		grails.plugin.springsecurity.facebook.secret = '${crowdera.facebook.secret}'

		crowdera.BASE_URL = 'https://staging.gocrowdera.com/'

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
		crowdera.paypal.GetVerifiedStatus_URL = 'https://svcs.paypal.com/AdaptiveAccounts/GetVerifiedStatus'
		crowdera.paypal.GetVerifiedStatus_REQUEST_DATA_FORMAT = 'NV'

		/* FreshDesk Details */
		crowdera.freshDesk.LOGIN_NAME = 'Crowdera Team'
		crowdera.freshDesk.LOGIN_EMAIL = 'info@crowdera.co'
		crowdera.freshDesk.sharedSecret = '9073b71999fbe30aa3967720181d3eab'
		crowdera.freshDesk.BASE_URL = 'https://crowdera.freshdesk.com/login/sso'

		/*MailChimp details*/
		crowdera.MAILCHIMP.SUBSCRIBE_URL="http://crowdera.us3.list-manage.com/subscribe/post"
		crowdera.MAILCHIMP.USERID="41c633b30eeabc78e88bd090d"
		crowdera.MAILCHIMP.LISTID="e37aea1b78"
		crowdera.MAILCHIMP.CLIENT_ID='834416564833'
		crowdera.MAILCHIMP.CLIENT_SECRET='15cdf65ede4a7af282f3055625051bf5'
		crowdera.MAILCHIMP.TOKEN_ENDPOINT="https://login.mailchimp.com/oauth2/token"
		crowdera.MAILCHIMP.OAUTH_URL='https://login.mailchimp.com/oauth2/authorize'
		crowdea.MAILCHIMP.DC_URL ='https://login.mailchimp.com/oauth2/metadata'
		crowdera.MAILCHIMP.MEMBER_URL ='.api.mailchimp.com/3.0/lists'

		/*PayUMoney details*/
		crowdera.PAYU.BASE_URL = 'http://staging.crowdera.in'
		crowdera.PAYU.TEST_URL='https://secure.payu.in/_payment.php'
		crowdera.PAYU.KEY='5geKCB'
		crowdera.PAYU.SALT='Gtr6fF9A'
		
		
		/*Citrus Credentials*/
		crowdera.CITRUS.SPLITPAY_URL = "https://splitpaysbox.Citruspay.com"
		crowdera.CITRUS.BASE_URL = "https://splitpay.citruspay.com"
		crowdera.CITRUS.ACCESS_KEY = "VVXKH02XVEWHUGWJHAMI"
		crowdera.CITRUS.SECRETE_KEY = "4c86cabfc7fb68d2261f35087a8edece44f856bd"
		crowdera.CITRUS.VANITYURL = "8wqhvmq506"
		
		
		/*ConstantContact details*/
		crowdera.cc.OAUTH_URL='https://oauth2.constantcontact.com/oauth2/oauth/siteowner/authorize?response_type=code&display=page&'
		crowdera.cc.TOKEN_URL='https://oauth2.constantcontact.com/oauth2/oauth/token?'
		crowdera.cc.CONTACT_URL='https://api.constantcontact.com/v2/contacts?status=ALL&limit=50&api_key='
		crowdera.cc.CLIENT_KEY='u9jc9nmmmtptyyz2y75cspry'
		crowdera.cc.CLIENT_SECRET='fRGDUHAf8tuS74upJgXhctTw'
		
		/*Gmail details*/
		crowdera.gmail.OAUTH_URL='https://accounts.google.com/o/oauth2/auth?'
		crowdera.gmail.TOKEN_URL='https://accounts.google.com/o/oauth2/token?'
		crowdera.gmail.CONTACT_URL='https://www.google.com/m8/feeds/contacts/'
		crowdera.gmail.CLIENT_KEY='264232108471-98vs4ujo7vtsf9tsqhhrurlbnobc2c1a.apps.googleusercontent.com'
		crowdera.gmail.CLIENT_SECRET='LrTLoWIgcQYaw0MmclzCG0Zi'
		crowdera.gmail.SCOPE='profile https://www.google.com/m8/feeds'

		mandrill {
			apiKey = "R28ZHu6_5IkJWLFunpsJbw"
		}
		
		oauth {
			providers {
				google {
					api = org.grails.plugin.springsecurity.oauth.GoogleApi20
					key = '1049378830663-joskj39vnpba4ju66dvah4q969g6c5ch.apps.googleusercontent.com'
					secret = '7h9_YkP2UhVcVxt6OsFYGjxG'
					successUri = '/login/googleSuccess'
					failureUri = '/login/googleFailure'
					callback = "http://staging.crowdera.in/oauth/google/callback"
					scope = 'https://www.googleapis.com/auth/plus.me https://www.googleapis.com/auth/userinfo.profile https://www.googleapis.com/auth/userinfo.email'
				}
			}
		}
	}

	prodIndia {
		crowdera.facebook.appId = '354215177926850'
		crowdera.facebook.secret = '24ee39e963145cee9d49fe1707e0a214'

		grails.plugin.springsecurity.facebook.appId = '${crowdera.facebook.appId}'
		grails.plugin.springsecurity.facebook.secret = '${crowdera.facebook.secret}'

		crowdera.BASE_URL = 'https://gocrowdera.com/'
		crowdera.BASE_URL1 = 'https://gocrowdera.com/'

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
		crowdera.paypal.GetVerifiedStatus_URL = 'https://svcs.paypal.com/AdaptiveAccounts/GetVerifiedStatus'
		crowdera.paypal.GetVerifiedStatus_REQUEST_DATA_FORMAT = 'NV'

		/* FreshDesk Details */
		crowdera.freshDesk.LOGIN_NAME = 'Crowdera Team'
		crowdera.freshDesk.LOGIN_EMAIL = 'info@crowdera.co'
		crowdera.freshDesk.sharedSecret = '9073b71999fbe30aa3967720181d3eab'
		crowdera.freshDesk.BASE_URL = 'https://crowdera.freshdesk.com/login/sso'

		/*MailChimp details*/
		crowdera.MAILCHIMP.SUBSCRIBE_URL="https://crowdera.us3.list-manage.com/subscribe/post"
		crowdera.MAILCHIMP.USERID="41c633b30eeabc78e88bd090d"
		crowdera.MAILCHIMP.LISTID="e37aea1b78"
		crowdera.MAILCHIMP.CLIENT_ID='877301010861'
		crowdera.MAILCHIMP.CLIENT_SECRET='8aa2b9eddc9042a83c3d559003cebb40'
		crowdera.MAILCHIMP.TOKEN_ENDPOINT="https://login.mailchimp.com/oauth2/token"
		crowdera.MAILCHIMP.OAUTH_URL='https://login.mailchimp.com/oauth2/authorize'
		crowdea.MAILCHIMP.DC_URL ='https://login.mailchimp.com/oauth2/metadata'
		crowdera.MAILCHIMP.MEMBER_URL ='.api.mailchimp.com/3.0/lists'

		/*PayUMoney details*/
		crowdera.PAYU.BASE_URL = 'http://crowdera.in'
		crowdera.PAYU.TEST_URL='https://secure.payu.in/_payment.php'
		crowdera.PAYU.KEY='5geKCB'
		crowdera.PAYU.SALT='Gtr6fF9A'
		
		
		/*Citrus Credentials*/
		crowdera.CITRUS.SPLITPAY_URL = "https://splitpaysbox.Citruspay.com"
		crowdera.CITRUS.BASE_URL = "https://splitpay.citruspay.com"
		crowdera.CITRUS.ACCESS_KEY = "VVXKH02XVEWHUGWJHAMI"
		crowdera.CITRUS.SECRETE_KEY = "4c86cabfc7fb68d2261f35087a8edece44f856bd"
		crowdera.CITRUS.VANITYURL = "8wqhvmq506"
		
		
		/*ConstantContact details*/
		crowdera.cc.OAUTH_URL='https://oauth2.constantcontact.com/oauth2/oauth/siteowner/authorize?response_type=code&display=page&'
		crowdera.cc.TOKEN_URL='https://oauth2.constantcontact.com/oauth2/oauth/token?'
		crowdera.cc.CONTACT_URL='https://api.constantcontact.com/v2/contacts?status=ALL&limit=50&api_key='
		crowdera.cc.CLIENT_KEY='d2583zc7nq5x9swv7erbnqy3'
		crowdera.cc.CLIENT_SECRET='kyXpPReQyx2DPwhhkVMThEvM'
		
		/*Gmail details*/
		crowdera.gmail.OAUTH_URL='https://accounts.google.com/o/oauth2/auth?'
		crowdera.gmail.TOKEN_URL='https://accounts.google.com/o/oauth2/token?'
		crowdera.gmail.CONTACT_URL='https://www.google.com/m8/feeds/contacts/'
		crowdera.gmail.CLIENT_KEY='264232108471-98vs4ujo7vtsf9tsqhhrurlbnobc2c1a.apps.googleusercontent.com'
		crowdera.gmail.CLIENT_SECRET='LrTLoWIgcQYaw0MmclzCG0Zi'
		crowdera.gmail.SCOPE='profile https://www.google.com/m8/feeds'
		
		mandrill {
			apiKey = "R28ZHu6_5IkJWLFunpsJbw"
		}
		
		oauth {
			providers {
				google {
					api = org.grails.plugin.springsecurity.oauth.GoogleApi20
					key = '1049378830663-juk0psg991qlapckdegi2pfhieo33gjc.apps.googleusercontent.com'
					secret = 'nweSovW1WxgeJ5EHKLPnYi7W'
					successUri = '/login/googleSuccess'
					failureUri = '/login/googleFailure'
					callback = "http://crowdera.in/oauth/google/callback"
					scope = 'https://www.googleapis.com/auth/plus.me https://www.googleapis.com/auth/userinfo.profile https://www.googleapis.com/auth/userinfo.email'
				}
			}
		}
		
	/*	grails {
			assets {
				cdn {
					provider = 's3'
					directory = 'crowdera'
					accessKey = 'AKIAIAZDDDNXF3WLSRXQ'
					secretKey = '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'
					storagePath = "prodIndia-cdn-assets"
					expires = 365 // Expires in 1 year (value in days)
					gzip = true
				}
			}
		}

		grails.assets.url = "http://dmymluhfmi0o3.cloudfront.net/crowdera/cdn-assets"*/

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
	autoStartup = true
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
