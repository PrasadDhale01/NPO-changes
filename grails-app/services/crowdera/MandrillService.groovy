package crowdera

import grails.converters.JSON
import groovyx.net.http.ContentType
import groovyx.net.http.HTTPBuilder
import groovyx.net.http.Method
import grails.util.Environment

class MandrillService {
    def grailsApplication
    def grailsLinkGenerator

    def BASE_URL = "https://mandrillapp.com/api/1.0/"
    
    def getCdraDomain(def crowderaDomain){
        def currentEnv
        
        if(crowderaDomain == 'testIndia' || crowderaDomain == 'stagingIndia' || crowderaDomain == 'prodIndia'){
            currentEnv = 'http://www.crowdera.in'
        } else {
            currentEnv = 'https://crowdera.co'
        }
        
        return currentEnv
    }
    
    def sendTemplate(User user, String templateName, List globalMergeVars, List tags) {
        def query =  [
            key: grailsApplication.config.mandrill.apiKey,
            template_name: templateName,
            message: [
                tags: tags,
                to: [
                    [
                        email: user.email,
                        name: user.firstName + ' ' + user.lastName
                    ]
                ],
                global_merge_vars: globalMergeVars
            ],
            template_content: Collections.EMPTY_LIST
        ]

        def ret = null
        def http = new HTTPBuilder(BASE_URL)

        http.request(Method.POST, ContentType.TEXT) {
            uri.path = 'messages/send-template.json'
            body = new JSON(query)

            // response handler for a success response code
            response.success = { resp, reader ->
                ret = reader.getText()
                log.info('Successfully sent email via Mandrill to ' + user.email)
            }

            // response handler for a failure response code
            response.failure = { resp, reader ->
                ret = reader.getText()
                log.error('Failure sending email via Mandrill to ' + user.email)
            }
        }

        return ret
    }
    
    def sendThankYouTemplate(Contribution contribution, String templateName, List globalMergeVars, List tags) {
        def query =  [
            key: grailsApplication.config.mandrill.apiKey,
            template_name: templateName,
            message: [
                tags: tags,
                to: [
                    [
                        email: contribution.contributorEmail,
                        name: contribution.contributorName
                    ]
                ],
                global_merge_vars: globalMergeVars
            ],
            template_content: Collections.EMPTY_LIST
        ]

        def ret = null
        def http = new HTTPBuilder(BASE_URL)

        http.request(Method.POST, ContentType.TEXT) {
            uri.path = 'messages/send-template.json'
            body = new JSON(query)

            // response handler for a success response code
            response.success = { resp, reader ->
                ret = reader.getText()
                log.info('Successfully sent email via Mandrill to ' + contribution.contributorEmail)
            }

            // response handler for a failure response code
            response.failure = { resp, reader ->
                ret = reader.getText()
                log.error('Failure sending email via Mandrill to ' + contribution.contributorEmail)
            }
        }

        return ret
    }

    def sendMail(User user) {
        def link = grailsLinkGenerator.link(controller: 'login', action: 'confirmUser', id: user.inviteCode, absolute: true)

        def globalMergeVars = [
            [
                'name': 'LINK',
                'content': link
            ],
            [
                'name': 'NAME',
                'content': user.firstName + ' ' + user.lastName
            ],
            [
                'name': 'EMAIL',
                'content': user.email
            ]
        ]

        def tags = ['admin-invite']

        sendTemplate(user, 'admin_invitation', globalMergeVars, tags)
    }

    def sendBeneficiaryEmail(User user) {
        def link = grailsLinkGenerator.link(controller: 'project', action: 'create', absolute: true)
        def currentEnv = Environment.current.getName()
        def cdraDomain = getCdraDomain(currentEnv)
        
        def globalMergeVars = [
            [
                'name': 'LINK',
                'content': link
            ],
            [
                'name': 'NAME',
                'content': user.firstName + ' ' + user.lastName
            ],
            [
                'name': 'EMAIL',
                'content': user.email
            ],
            [
                'name': 'CDRADOMAIN',
                'content': cdraDomain
            ]
        ]

        def tags = ['fund-confirmation']

        sendTemplate(user, 'funding_confirmation', globalMergeVars, tags)

    }

    def sendContributorEmail(User user, Project project){

        def link = grailsLinkGenerator.link(controller: 'fund', action: 'thankingContributors',id:project.id ,absolute: true)
        def currentEnv = Environment.current.getName()
        def cdraDomain = getCdraDomain(currentEnv)
        
        def globalMergeVars = [
            [
                'name': 'LINK',
                'content': link
            ],
            [
                'name': 'NAME',
                'content': user.firstName + ' ' + user.lastName
            ],
            [
                'name': 'EMAIL',
                'content': user.email
            ],
	        [
                'name':'TITLE',
                'content':project.title
            ],
            [
                'name':'CDRADOMAIN',
                'content': cdraDomain
            ]
        ]

        def tags = ['thanking-contributors']

        sendTemplate(user, 'thanks_to_contributors', globalMergeVars, tags)
    }

   def sendResetPassword(User user) {
        def link = grailsLinkGenerator.link(controller: 'login', action: 'confirm_reset', id: user.resetCode, absolute: true)
        def createButton = grailsLinkGenerator.link(controller: 'project', action: 'create',absolute: true)
        def home = grailsLinkGenerator.link(controller: 'home', action: 'index', absolute: true)
        def currentEnv = Environment.current.getName()
        def cdraDomain = getCdraDomain(currentEnv)
        
        def globalMergeVars = [
            [
                'name': 'LINK',
                'content': link
            ],
            [
		'name': 'CREATELINK',
		'content': createButton
	    ],
            [
                'name': 'NAME',
                'content': user.firstName 
            ],
	        [
                'name': 'HOME',
                'content': home
            ],
            [
                'name': 'CDRADOMAIN',
                'content': cdraDomain
            ]
	]

        def tags = ['reset-password']

        sendTemplate(user, 'reset-password', globalMergeVars, tags)
    }

    def inviteToShare(String email, String templateName, List globalMergeVars, List tags) {
        def query =  [
            key: grailsApplication.config.mandrill.apiKey,
            template_name: templateName,
            message: [
                tags: tags,
                to: [
                    [
                        email: email
                    ]
                ],
                global_merge_vars: globalMergeVars
            ],
            template_content: Collections.EMPTY_LIST
        ]

        def ret = null
        def http = new HTTPBuilder(BASE_URL)

        http.request(Method.POST, ContentType.TEXT) {
            uri.path = 'messages/send-template.json'
            body = new JSON(query)

            // response handler for a success response code
            response.success = { resp, reader ->
                ret = reader.getText()
                log.info('Successfully sent email via Mandrill to ' + email)
            }

            // response handler for a failure response code
            response.failure = { resp, reader ->
                ret = reader.getText()
                log.error('Failure sending email via Mandrill to ' + email)
            }
        }

        return ret
    }

    def shareProject(def emailList, String name, String message, Project project, def fundRaiser) {
        def imageUrl = project.imageUrl
		def projectImageUrl
        if (imageUrl) {
            imageUrl = project.imageUrl[0].getUrl()
			if(imageUrl.startsWith("https") || imageUrl.startsWith("http")) {
				projectImageUrl = imageUrl
			} else {
			    projectImageUrl = "https:"+imageUrl
			}
        }
        def currentEnv = Environment.current.getName()
        def cdraDomain = getCdraDomain(currentEnv)
        emailList.each { email ->
            def link = grailsLinkGenerator.link(controller: 'project', action: 'showCampaign', id: project.id,params:[fr:fundRaiser], absolute: true)
            def globalMergeVars = [
                [
                    'name': 'LINK',
                    'content': link
                ],
                [
                    'name': 'NAME',
                    'content': name
                ],
                [
                    'name': 'EMAIL',
                    'content': email
                ],
                [
                    'name': 'TITLE',
                    'content': project.title
                ],
                [
                    'name': 'MESSAGE',
                    'content': message
                ],
                [
                    'name': 'IMAGEURL',
                    'content': projectImageUrl
                ],
                [
                    'name': 'CDRADOMAIN',
                    'content': cdraDomain
                ]
            ]

            def tags = ['invite-to-share']

            inviteToShare(email, 'invite-to-share', globalMergeVars, tags)
        }
    }
    
    def shareProjectupdate(def emaillist, String name, String message, Project project, def fundraiser, def projectUpdate){
        def imageUrl
        def imageurls = projectUpdate.imageUrls
        def projectImageUrl
        if (!imageurls.isEmpty()) {
            imageUrl = projectUpdate.imageUrls[0].getUrl()
            if(imageUrl.startsWith("https") || imageUrl.startsWith("http")) {
                projectImageUrl = imageUrl
            } else {
                projectImageUrl = "https:"+imageUrl
            }
        }
       
        emaillist.each { email ->
            def link = grailsLinkGenerator.link(controller: 'project', action: 'updateShare', id: project.id,params:[fr:fundraiser], absolute: true)
            def globalMergeVars = [
                [
                    'name': 'LINK',
                    'content': link
                ],
                [
                    'name': 'NAME',
                    'content': name
                ],
                [
                    'name': 'EMAIL',
                    'content': email
                ],
                [
                    'name': 'TITLE',
                    'content': project.title
                ],
                [
                    'name': 'UPDATETITLE',
                    'content': projectUpdate.title
                ],
                [
                    'name': 'MESSAGE',
                    'content': message
                ],
                [
                    'name': 'IMAGEURL',
                    'content': projectImageUrl
                ]
            ]

            def tags = ['updates-share']

            inviteToShare(email, 'updates-share', globalMergeVars, tags)
        }
    }

    def shareContribution(def emailList, String name, String message, Project project, User fundraiser) {
        def imageUrl = project.imageUrl
        def currentEnv = Environment.current.getName()
        def cdraDomain = getCdraDomain(currentEnv)
        def projectImageUrl
        if (imageUrl) {
            imageUrl = project.imageUrl[0].getUrl()
			if(imageUrl.startsWith("https") || imageUrl.startsWith("http")) {
				projectImageUrl = imageUrl
			} else {
				projectImageUrl = "https:"+imageUrl
			}
        }
        emailList.each { email ->
            def link = grailsLinkGenerator.link(controller: 'project', action: 'showCampaign', id: project.id, params:[fr:fundraiser.username], absolute: true)
            def globalMergeVars = [
                [
                    'name': 'LINK',
                    'content': link
                ],
                [
                    'name': 'NAME',
                    'content': name
                ],
                [
                    'name': 'EMAIL',
                    'content': email
                ],
                [
                    'name': 'TITLE',
                    'content': project.title
                ],
                [
                    'name': 'MESSAGE',
                    'content': message
                ],
                [
                    'name': 'IMAGEURL',
                    'content': projectImageUrl
                ],
                [
                    'name': 'CDRADOMAIN',
                    'content': cdraDomain
                ]
            ]

            def tags = ['share-contribution']

            inviteToShare(email, 'share-contribution', globalMergeVars, tags)
        }
    }

    private def inviteToAdmin(String email, String templateName, List globalMergeVars, List tags) {
        def query =  [
            key: grailsApplication.config.mandrill.apiKey,
            template_name: templateName,
            message: [
                tags: tags,
                to: [
                    [
                        email: email
                    ]
                ],
                global_merge_vars: globalMergeVars
            ],
            template_content: Collections.EMPTY_LIST
        ]

        def ret = null
        def http = new HTTPBuilder(BASE_URL)

        http.request(Method.POST, ContentType.TEXT) {
            uri.path = 'messages/send-template.json'
            body = new JSON(query)

            // response handler for a success response code
            response.success = { resp, reader ->
                ret = reader.getText()
                log.info('Successfully sent email via Mandrill to ' + email)
            }

            // response handler for a failure response code
            response.failure = { resp, reader ->
                ret = reader.getText()
                log.error('Failure sending email via Mandrill to ' + email)
            }
        }

        return ret
    }

    def inviteAdmin(def email, String name, Project project) {
        def link = grailsLinkGenerator.link(controller: 'project', action: 'manageCampaign', id: project.id, absolute: true)
        def registerLink = grailsLinkGenerator.link(controller: 'login', action: 'register', id: project.id, absolute: true)
        def imageUrl = project.imageUrl
		def blogUrl = "http://crowdera.tumblr.com"
        def currentEnv = Environment.current.getName()
        def cdraDomain = getCdraDomain(currentEnv)
		def projectImageUrl
        if (imageUrl) {
            imageUrl = project.imageUrl[0].getUrl()
			if(imageUrl.startsWith("https") || imageUrl.startsWith("http")) {
				projectImageUrl = imageUrl
			} else {
				projectImageUrl = "https:"+imageUrl
			}
        }
        def globalMergeVars = [
            [
                'name': 'LINK',
                'content': link
            ],
	    [
		'name':'BLOG_LINK',
		'content':blogUrl
	    ],
	    [
		'name':'OWNER_NAME',
		'content':project.user.firstName + " " + project.user.lastName
	    ],
            [
                'name':'REGISTER_LINK',
                'content':registerLink
            ],
            [
                'name': 'NAME',
                'content': name
            ],
            [
                'name': 'EMAIL',
                'content': email
            ],
            [
                'name': 'TITLE',
                'content': project.title
            ],
            [
                'name': 'IMAGEURL',
                'content': projectImageUrl
            ],
            [
                'name': 'CDRADOMAIN',
                'content': cdraDomain
            ]
        ]

        def tags = ['invite-admin-for-project']

        inviteToAdmin(email, 'invite-admin-for-project', globalMergeVars, tags)
    }

    def sendUpdateEmailToAdmin(def email, String name, Project project) {
        def link = grailsLinkGenerator.link(controller: 'project', action: 'manageCampaign', id: project.id, absolute: true)
        def registerLink = grailsLinkGenerator.link(controller: 'login', action: 'register', absolute: true)
        def imageUrl = project.imageUrl
        def projectImageUrl
        if (imageUrl) {
            imageUrl = project.imageUrl[0].getUrl()
            if(imageUrl.startsWith("https") || imageUrl.startsWith("http")) {
                projectImageUrl = imageUrl
            } else {
                projectImageUrl = "https:"+imageUrl
            }
        }
        def currentEnv = Environment.current.getName()
        def cdraDomain = getCdraDomain(currentEnv)
        
        def globalMergeVars = [[
            'name': 'LINK',
            'content': link
        ], [
            'name':'REGISTER_LINK',
            'content':registerLink
        ],[
            'name': 'NAME',
            'content': name
        ], [
            'name': 'EMAIL',
            'content': email
        ], [
            'name':'STORY',
            'content':project.story
        ], [
            'name': 'TITLE',
            'content': project.title
        ], [
            'name': 'IMAGEURL',
            'content': projectImageUrl
        ], [
            'name': 'CDRADOMAIN',
            'content': cdraDomain
        ]]

        def tags = ['project-update-email']

        inviteToAdmin(email, 'project-update-email', globalMergeVars, tags)
    }
    
    def sendUpdateEmailsToContributors(Project project,ProjectUpdate projectUpdate, User currentUser, def title){
        def contributors=project.contributions
        
        contributors.each { contributor ->
            if(contributor.contributorEmail != "anonymous@example.com" && contributor.contributorEmail !=null){
                def contributorName = contributor.contributorName
                def contributorEmail = contributor.contributorEmail
                sendUpdateEmails(contributorName, contributorEmail, project, projectUpdate, currentUser, title)
            }
        }
        
        def supporters = project.supporters
        supporters.each { supporter ->
            def contributor = Contribution.findByUserAndProject(supporter.user, project)
            if (!contributor) {
                def name = supporter.user.firstName
                def email = supporter.user.email
                sendUpdateEmails( name, email, project, projectUpdate, currentUser, title)
            }
        }
        List teams = Team.findAllWhere(project : project,enable:true, validated: true);
        
        teams.each { team ->
            def contributor = Contribution.findByUserAndProject(team.user, project)
            def supporter = Supporter.findByUserAndProject(team.user, project)
            if (!contributor && (team.user != currentUser) && !supporter) {
                def name = team.user.firstName
                def email = team.user.email
                sendUpdateEmails( name, email, project, projectUpdate, currentUser, title)
            }
        }
    }
    
    def sendUpdateEmails(def name, def email, Project project, ProjectUpdate projectUpdate,User currentUser, def title) {
        def link = grailsLinkGenerator.link(controller: 'project', action: 'showCampaign', id: project.id, absolute: true)
        List imageUrls = projectUpdate.imageUrls
        def currentEnv = Environment.current.getName()
        def cdraDomain = getCdraDomain(currentEnv)
        def projectImageUrl
        def url
        if(imageUrls) {
            url = imageUrls[0].getUrl()
            if(url.startsWith("https") || url.startsWith("http")) {
                projectImageUrl = url
            } else {
                projectImageUrl = "https:"+url
            }
        }
        def globalMergeVars = [[
            'name': 'LINK',
            'content': link
         ],[
             'name': 'NAME',
             'content': name
         ],[
             'name': 'STORY',
             'content': projectUpdate.story
         ],[
             'name': 'userName',
             'content': currentUser.firstName+" "+currentUser.lastName
         ],[
             'name': 'EMAIL',
             'content': email
         ], [
             'name': 'TITLE',
             'content': project.title
         ], [
             'name': 'IMAGEURL',
             'content': projectImageUrl
         ],[
             'name': 'UPDATETITLE',
             'content': title
         ],[
             'name': 'CDRADOMAIN',
             'content': cdraDomain
         ]]
         
         def tags = ['campaign-update']
         
         inviteToAdmin(email, 'campaign-update', globalMergeVars, tags)
    }
	
	def sendCampaignDeleteEmailsToOwner(List emailList, Project project,User currentUser) {
        def currentEnv = Environment.current.getName()
        def cdraDomain = getCdraDomain(currentEnv)
		emailList.each{email ->
			if(email!=null){
				def link = grailsLinkGenerator.link(controller: 'project', action: 'showCampaign', id: project.id, absolute: true)
				def globalMergeVars = [[
					'name': 'LINK',
					'content': link
				],[
				 	'name': 'NAME',
					 'content': currentUser.firstName +" " + currentUser.lastName
				],[
				 	'name': 'EMAIL',
					 'content': email
				], [
				 	'name': 'TITLE',
					 'content': project.title
				],[
                     'name': 'CDRADOMAIN',
                     'content': cdraDomain
                ]]
			 
				def tags = ['campaign-delete']
			 
				inviteToAdmin(email, 'campaign-delete', globalMergeVars, tags)
			}
		}
	}
    
    def sendInvitationForTeam(def emailList, String name, String message, Project project) {
        emailList.each { email ->
            def link = grailsLinkGenerator.link(controller: 'project', action: 'showCampaign', id: project.id, absolute: true)
            def imageUrl = project.imageUrl
			def projectImageUrl
            if (imageUrl) {
                imageUrl = project.imageUrl[0].getUrl()
				if(imageUrl.startsWith("https") || imageUrl.startsWith("http")) {
					projectImageUrl = imageUrl
				} else {
					projectImageUrl = "https:"+imageUrl
				}
            }
            def currentEnv = Environment.current.getName()
            def cdraDomain = getCdraDomain(currentEnv)
            def globalMergeVars = [
                [
                    'name': 'LINK',
                    'content': link
                ],[
                    'name': 'NAME',
                    'content': name
                ],[
                    'name': 'EMAIL',
                    'content': email
                ],[
                    'name': 'TITLE',
                    'content': project.title
                ],[
                    'name': 'MESSAGE',
                    'content': message
                ],[
                    'name': 'IMAGEURL',
                    'content': projectImageUrl
                ],[
                    'name': 'CDRADOMAIN',
                    'content': cdraDomain
                ]
            ]

            def tags = ['invite-to-team']

            inviteToAdmin(email, 'invite-to-team', globalMergeVars, tags)
        }
    }
    
    def sendEmailToCustomer(def service) {
        def email = service.email
        def base_url = grailsApplication.config.crowdera.BASE_URL
        def link = base_url+"/howitworks"
        def blogUrl = "http://crowdera.tumblr.com"
        def date = new Date()
        def currentEnv = Environment.current.getName()
        def cdraDomain = getCdraDomain(currentEnv)
        def globalMergeVars = [
            [
                'name': 'LINK',
                'content': link
            ],[
                'name': 'NAME',
                'content': service.customername
            ],[
                'name': 'EMAIL',
                'content': email
            ],[
                'name': 'BLOG_URL',
                'content': blogUrl
            ],[
                'name': 'REQUEST',
                'content': service.subject
            ],[
                'name': 'DATE',
                'content': date.format("YYYY-MM-DD HH:mm:ss")
            ],[
                'name': 'CDRADOMAIN',
                'content': cdraDomain
            ]
        ]
        
        def tags = ['send-email-to-customer']

        inviteToAdmin(email, 'send-email-to-customer', globalMergeVars, tags)
    }
	
	def sendEmailToCrew(def crewrequest){
		def email = crewrequest.email
		def date = new Date()
		def globalMergeVars = [
			[
				'name': 'NAME',
				'content': crewrequest.firstName
			],[
				'name': 'EMAIL',
				'content': email
			],[
				'name': 'DATE',
				'content': date.format("YYYY-MM-DD HH:mm:ss")
			]
		]
		
		def tags = ['send-email-to-crew']

		inviteToAdmin(email, 'send-email-to-crew', globalMergeVars, tags)
	}
    
    def sendResponseToCustomer(def adminResponse, def service, def attachmentUrl) {
        def email = service.email
        def date = new Date()
        def base_url = grailsApplication.config.crowdera.BASE_URL
        def url = base_url+"/howitworks"
        def link = grailsLinkGenerator.link(controller: 'project', action: 'list', absolute: true)
        def create_url = grailsLinkGenerator.link(controller: 'project', action: 'create', absolute: true)
        def currentEnv = Environment.current.getName()
        def cdraDomain = getCdraDomain(currentEnv)
        def globalMergeVars = [
            [
                'name': 'LINK',
                'content': link
            ],[
                'name': 'CREATE_URL',
                'content': create_url
            ],[
                'name': 'URL',
                'content': url
            ],[
                'name': 'NAME',
                'content': service.customername
            ],[
                'name': 'EMAIL',
                'content': email
            ],[
                'name': 'RESPONSE',
                'content': adminResponse
            ],[
                'name': 'DATE',
                'content': date.format("YYYY-MM-DD HH:mm:ss")
            ],[
                'name': 'REQUEST',
                'content': service.subject
            ],[
                'name': 'ATTACHMENTURL',
                'content': attachmentUrl
            ],[
                'name': 'CDRADOMAIN',
                'content': cdraDomain
            ]
        ]

        def tags = ['send-response-to-customer']

        inviteToAdmin(email, 'send-response-to-customer', globalMergeVars, tags)
    }

    def sendResponseToCrews(def adminResponse, def crews, def attachmentUrl, def base_url) {
	def email = crews.email
	def date = new Date()
	def url = base_url+"/howitworks"
	def link = grailsLinkGenerator.link(controller: 'project', action: 'list', absolute: true)
	def create_url = grailsLinkGenerator.link(controller: 'project', action: 'create', absolute: true)
	def globalMergeVars = [
		[
			'name': 'LINK',
			'content': link
		],[
			'name': 'CREATE_URL',
			'content': create_url
		],[
			'name': 'URL',
			'content': url
		],[
			'name': 'NAME',
			'content': crews.firstName
		],[
			'name': 'EMAIL',
			'content': email
		],[
			'name': 'RESPONSE',
			'content': adminResponse
		],[
			'name': 'DATE',
			'content': date.format("YYYY-MM-DD HH:mm:ss")
		],[
			'name': 'ATTACHMENTURL',
			'content': attachmentUrl
		]
	]

	def tags = ['send-response-to-crews']

	inviteToAdmin(email, 'send-response-to-crews', globalMergeVars, tags)
    }
    
    public def sendMandrillEmail(User user) {
        def link = grailsLinkGenerator.link(controller: 'login', action: 'confirm', id: user.confirmCode, absolute: true)
        def currentEnv = Environment.current.getName()
        def cdraDomain = getCdraDomain(currentEnv)
        
        def globalMergeVars = [[
            'name': 'LINK',
            'content': link
        ], [
            'name': 'NAME',
            'content': user.firstName + ' ' + user.lastName
        ], [
            'name': 'EMAIL',
            'content': user.email
        ], [
            'name': 'CDRADOMAIN',
            'content': cdraDomain
        ]  ]

        def tags = ['registration']

        sendTemplate(user, 'new_user_confirmation', globalMergeVars, tags)
    } 
    
    public def sendDraftInfoEmail(def prjTitle, User user, def domainName, def draftDate) {
        def emailList=['info@crowdera.co', 'minal@crowdera.co', 'himanchan@crowdera.co']
        if(domainName=='production'){
            domainName='crowdera.co'
        }else{
            domainName='crowdera.in'
        }
        emailList.each{ email ->
            def globalMergeVars = [[
                'name': 'TITLE',
                'content': prjTitle
            ], [
                'name': 'OWNER',
                'content': user.firstName + ' ' + user.lastName
            ], [
                'name': 'WEBSITE',
                'content': domainName
            ], [
                'name': 'CMPDATE',
                'content': draftDate
            ]]
    
            def tags = ['draft-info']
    
            inviteToShare(email, 'draft-info', globalMergeVars, tags)
        }
    }
	
    public def reSendConfirmationMail(User user) {
	def link = grailsLinkGenerator.link(controller: 'login', action: 'confirm', id: user.confirmCode, absolute: true)
    def currentEnv = Environment.current.getName()
    def cdraDomain = getCdraDomain(currentEnv)

	def globalMergeVars = [[
            'name': 'LINK',
	    'content': link
	], [
	    'name': 'NAME',
	    'content': user.firstName + ' ' + user.lastName
	], [
	    'name': 'EMAIL',
	    'content': user.email
	], [
	    'name':'DATE',
	    'content': user.dateCreated
	], [
        'name':'CDRADOMAIN',
        'content': cdraDomain
    ]]

	def tags = ['resend-confirmation-mail']

	sendTemplate(user, 'resend_confirmation_mail', globalMergeVars, tags)
    }

    public def sendUserResponseToUserRequest(User user) {
        def globalMergeVars = [[
            'name': 'NAME',
            'content': user.firstName + ' ' + user.lastName
        ], [
            'name': 'EMAIL',
            'content': user.email
        ]]

        def tags = ['userRequestToRegister']

        sendTemplate(user, 'userRequestToRegister', globalMergeVars, tags)
    }
    
    public def sendThankYouMailToContributors(Contribution contribution, Project project, def amount, User fundraiser) {
        def fundRaiserUserName = fundraiser.username
        def beneficiary = project.user
        def link = grailsLinkGenerator.link(controller: 'project', action: 'showCampaign', id: project.id, params:[fr:fundRaiserUserName], absolute: true)
        def currentEnv = Environment.current.getName()
        def cdraDomain = getCdraDomain(currentEnv)
        def fblink = "https://www.facebook.com"
        def currency
        def naamFoundationCampaign
        if(currentEnv == 'testIndia' || currentEnv == 'stagingIndia' || currentEnv == 'prodIndia'){
            currency = 'INR'
        } else {
            currency = 'USD'
        }

        if (project.id == '2c9f8f3b4feeeee0014fefed7fae0001'){
            naamFoundationCampaign = 'yes'
        }

        def globalMergeVars = [[
            'name': 'LINK',
            'content': link
        ],[
             'name': 'FBLINK',
             'content': fblink
        ],[
            'name': 'NAME',
            'content': contribution.contributorName
        ],[
            'name': 'BENEFICIARY',
            'content': beneficiary.firstName + ' ' + beneficiary.lastName
        ],[
            'name': 'AMOUNT',
            'content': amount
        ], [
		    'name':'TITLE',
		    'content':project.title
	    ], [
            'name': 'EMAIL',
            'content': fundraiser.email
        ], [
            'name': 'CURRENCY',
            'content': currency
        ], [
            'name' : 'NAAM_FOUNDATION_PROJECT',
            'content' : naamFoundationCampaign
        ], [
            'name' : 'CDRADOMAIN',
            'content': cdraDomain
        ]
	]

        def tags = ['thankYouEmailToContributor']

        sendThankYouTemplate(contribution, 'thankYouEmailToContributor', globalMergeVars, tags)
    }
    
    public def inviteMembersToCommunity(def invite, def community, def user) {
        def code = invite.inviteCode
        def link = grailsLinkGenerator.link(controller: 'community', action: 'accept_invite', id: code, absolute: true)
        def globalMergeVars = [[
            'name': 'LINK',
            'content': link
        ],[
            'name': 'NAME',
            'content': user.firstName + ' ' + user.lastName
        ],[
            'name': 'TITLE',
            'content': community.title
        ],[
            'name': 'EMAIL',
            'content': user.email
        ]]

        def tags = ['inviteToCommunity']

        sendTemplate(user, 'inviteToCommunity', globalMergeVars, tags)
    }
    
    public def sendEmailToDevGroup(def exception, def currentEnv) {
        
        def exceptionString = " "+ exception
        def devList = ['krishna.sahu@crowdera.co','tushar@crowdera.co','minal.ganatra@crowdera.co']
        def date = new Date()
        def site 
        if (currentEnv == 'prodIndia'){
            site = 'crowdera.in'
        }else{ 
            site = 'crowdera.co'
        }

        devList.each { email ->
            
            def globalMergeVars = [
                [
                    'name': 'EXCEPTION',
                    'content': exceptionString
                ],[
                    'name': 'EMAIL',
                    'content': email
                ],[
                    'name': 'DATE',
                    'content': date.format("YYYY-MM-DD HH:mm:ss")
                ],[
                     'name' : 'WEBSITE',
                     'content': site
                ]
            ]

            def tags = ['Exception-email-to-dev']

            inviteToAdmin(email, 'Exception-email-to-dev', globalMergeVars, tags)
        }
    }

    public def contributionEmailToCampaignOwnerOrTeam(def fundRaiser, def project, def contribution) {
        def username = fundRaiser.username
        def link
        if (project.user == fundRaiser) {
            link = grailsLinkGenerator.link(controller: 'project', action: 'manageCampaign', id: project.id, params:[fr:username], absolute: true, fragment: 'contributions')
        } else {
            link = grailsLinkGenerator.link(controller: 'project', action: 'showCampaign', id: project.id, params:[fr:username], absolute: true, fragment: 'contributions')
        }
        def currentEnv = Environment.current.getName()
        def cdraDomain = getCdraDomain(currentEnv)
        def currency
        if(currentEnv == 'testIndia' || currentEnv == 'stagingIndia' || currentEnv == 'prodIndia'){
            currency = 'INR'
        } else {
            currency = 'USD'
        }
        def globalMergeVars = [
            [
                'name': 'LINK',
                'content': link
            ],[
                'name': 'NAME',
                'content': fundRaiser.firstName + ' ' + fundRaiser.lastName
            ],[
                'name': 'AMOUNT',
                'content': contribution.amount
            ],[
                'name': 'CONTRIBUTOR',
                'content': contribution.contributorName
            ],[
                'name': 'CONTRIBUTOREMAIL',
                'content': contribution.contributorEmail
            ], [
                'name': 'CURRENCY',
                'content': currency
            ], [
                'name': 'CDRADOMAIN',
                'content': cdraDomain
            ]
        ]

        def tags = ['contributionEmailToCampaignOwnerOrTeam']

        sendTemplate(fundRaiser,'contributionEmailToCampaignOwnerOrTeam', globalMergeVars, tags)
    }
    
    public def sendTeamInvitation(Project project, User fundRaiser) {
        def user = project.user
        def username = user.username
        def link = grailsLinkGenerator.link(controller: 'project', action: 'manageCampaign', id: project.id, params:[fr:username], absolute: true, fragment: 'manageTeam')
        def currentEnv = Environment.current.getName()
        def cdraDomain = getCdraDomain(currentEnv)
        
        def globalMergeVars = [
            [
                'name': 'LINK',
                'content': link
            ],[
                'name': 'NAME',
                'content': fundRaiser.firstName + ' ' + fundRaiser.lastName
            ],[
                'name': 'OWNER',
                'content': user.firstName+' '+user.lastName
            ],[
                'name': 'TITLE',
                'content': project.title
            ],[
                'name': 'CDRADOMAIN',
                'content': cdraDomain
            ]
        ]

        def tags = ['team-validation-request']

        sendTemplate(user,'team-validation-request', globalMergeVars, tags)
    }
    
    public def sendTeamValidatedConfirmation(Project project, User fundRaiser) {
        def username = fundRaiser.username
        def link = grailsLinkGenerator.link(controller: 'project', action: 'showCampaign', id: project.id, params:[fr:username], absolute: true)
		def imageUrl = project.organizationIconUrl
		def projectImageUrl
		if (imageUrl) {
			if(imageUrl.startsWith("https") || imageUrl.startsWith("http")) {
				projectImageUrl = imageUrl
			} else {
				projectImageUrl = "https:"+imageUrl
			}
		}
        def currentEnv = Environment.current.getName()
        def cdraDomain = getCdraDomain(currentEnv)
		
        def globalMergeVars = [
            [
                'name': 'LINK',
                'content': link
            ],[
                'name': 'NAME',
                'content': fundRaiser.firstName + ' ' + fundRaiser.lastName
            ],[
                'name': 'IMAGEURL',
                'content': projectImageUrl
            ],[
                'name': 'TITLE',
                'content': project.title
            ],[
                'name': 'CDRADOMAIN',
                'content': cdraDomain
            ]
        ]

        def tags = ['team-validated-confirmation']

        sendTemplate(fundRaiser,'team-validated-confirmation', globalMergeVars, tags)
    }
    
    public def sendTeamUpdationEmail(Project project,Team team) {
        def teamUser = team.user
        def username = teamUser.username
        def link = grailsLinkGenerator.link(controller: 'project', action: 'showCampaign', id: project.id, params:[fr:username], absolute: true)
		def imageUrl = project.organizationIconUrl
		def projectImageUrl
		if (imageUrl) {
			if(imageUrl.startsWith("https") || imageUrl.startsWith("http")) {
				projectImageUrl = imageUrl
			} else {
				projectImageUrl = "https:"+imageUrl
			}
		}
        def currentEnv = Environment.current.getName()
        def cdraDomain = getCdraDomain(currentEnv)
        
        def globalMergeVars = [
            [
                'name': 'LINK',
                'content': link
            ],[
                'name': 'NAME',
                'content': teamUser.firstName + ' ' + teamUser.lastName
            ],[
                'name': 'IMAGEURL',
                'content': projectImageUrl
            ],[
                'name': 'TITLE',
                'content': project.title
            ],[
                'name': 'OWNER',
                'content': project.user.firstName +' '+ project.user.lastName
            ], [
                'name': 'CDRADOMAIN',
                'content': cdraDomain
            ]
        ]

        def tags = ['team-updation-email']

        sendTemplate(teamUser,'team-updation-email', globalMergeVars, tags)
    }
    
    public def sendEmailToCampaignOwner(Project project, Contribution contribution) {
        def beneficiary = project.beneficiary
        def user = project.user
        def name = beneficiary.firstName
        if (!name) {
            name = user.firstName + ' ' + user.lastName
        }
        def link = grailsLinkGenerator.link(controller: 'project', action: 'manageCampaign', fragment:'payments', id: project.id, absolute: true)
        def currentEnv = Environment.current.getName()
        def cdraDomain = getCdraDomain(currentEnv)
        def currency
        if(currentEnv == 'testIndia' || currentEnv == 'stagingIndia' || currentEnv == 'prodIndia'){
            currency = 'INR'
        } else {
            currency = 'USD'
        }
        def globalMergeVars = [
            [
                'name': 'LINK',
                'content': link
            ],[
                'name': 'NAME',
                'content': name
            ],[
                'name': 'TITLE',
                'content': project.title
            ],[
                'name': 'AMOUNT',
                'content': contribution.amount
            ],[
                'name': 'CONTRIBUTOR',
                'content': contribution.contributorName
            ],[
                'name': 'CONTRIBUTOREMAIL',
                'content': contribution.contributorEmail
            ], [
                'name': 'CURRENCY',
                'content': currency
            ], [
                'name': 'CDRADOMAIN',
                'content': cdraDomain
            ]
        ]
        
        def tags = ['payments-info-email']
        
        sendTemplate(user,'payments-info-email', globalMergeVars, tags)
    }
	
	def sendFeedBackLinkToOwner(def owner, def base_url){
		def goodLink = base_url+'/survey?rating=good'
		def badLink = base_url+'/survey?rating=bad'
		def awesomeLink = base_url+'/survey?rating=awesome'
		def goodImgLink = "https://s3.amazonaws.com/crowdera/assets/good.png"
		def badImgLink = "https://s3.amazonaws.com/crowdera/assets/sad.png"
		def awesomeImgLink = "https://s3.amazonaws.com/crowdera/assets/awesome.png"
        def currentEnv = Environment.current.getName()
        def cdraDomain = getCdraDomain(currentEnv)
        
		def globalMergeVars = [
		    [
		        'name': 'GOODLINK',
		        'content': goodLink
		    ],
		    [
		        'name': 'BADLINK',
		        'content': badLink
		    ],
		    [
		       'name': 'AWESOMELINK',
		       'content': awesomeLink
		    ],
		    [
		       'name': 'AWESOMEIMAGE',
		       'content': awesomeImgLink
		   ],
		   [
		      'name': 'GOODIMAGE',
		      'content': goodImgLink
		   ],
		   [
		      'name': 'BADIMAGE',
		      'content': badImgLink
		   ],
		   [
		      'name': 'NAME',
		      'content': owner.firstName + ' ' + owner.lastName
		  ],
          [
              'name': 'CDRADOMAIN',
              'content': cdraDomain
          ]
		]

        def tags = ['feedback-email']

        sendTemplate(owner, 'feedback_email', globalMergeVars, tags)
		
	}
    def sendEmailToNonUserContributors(List nonUserContributors){
        def beneficiaryName
        def link = grailsLinkGenerator.link(controller: 'login', action: 'register', absolute: true)
        nonUserContributors.each{
            beneficiaryName = (it.project.beneficiary.lastName) ? it.project.beneficiary.firstName + ' ' + it.project.beneficiary.lastName : it.project.beneficiary.firstName;
            def globalMergeVars = [
            [
                'name': 'CURRENCY',
                'content': it.currency
            ], [
                'name': 'CONTRIBUTORNAME',
                'content': it.contributorName
            ], [
                'name': 'AMOUNT',
                'content':it.amount
            ], [
                'name': 'CAMPAIGNTITLE',
                'content':it.project.title
            ], [
                'name':'BENEFICIARYNAME',
                'content':beneficiaryName
            ], [
                'name':'DATE',
                'content' :it.date.format("dd MMMM, YYYY")
            ], [
                'name':'LINK',
                'content':link
            ]
            ]

            def tags = ['sendEmailToNonUserContributors']

            sendThankYouTemplate(it,'sendEmailToNonUserContributors', globalMergeVars, tags)
        }
    }
	
    def sendValidationEmailToOWnerAndAdmins(Project project){
        def link = grailsLinkGenerator.link(controller: 'project', action: 'showCampaign', id: project.id, absolute: true)
        def registerLink = grailsLinkGenerator.link(controller: 'login', action: 'register', id: project.id, absolute: true)
        List emailMemberList = []
        emailMemberList.add(project.user)
        project.projectAdmins.each {
            if (it.email != 'campaignadmin@crowdera.co'){
                emailMemberList.add(it)
            }
        }
        def tags
        def beneficiaryName = (project.beneficiary.lastName) ? project.beneficiary.firstName + ' ' + project.beneficiary.lastName : project.beneficiary.firstName
        def imageUrl = project.organizationIconUrl
        def projectImageUrl
        if (imageUrl) {
            if(imageUrl.startsWith("https") || imageUrl.startsWith("http")) {
                projectImageUrl = imageUrl
            } else {
                projectImageUrl = "https:"+imageUrl
            }
        }
        def currentEnv = Environment.current.getName()
        def cdraDomain = getCdraDomain(currentEnv)

        emailMemberList.each{

            def globalMergeVars = [
            [
                'name': 'TITLE',
                'content': project.title
            ],[
                 'name': 'LINK',
                 'content': link
            ],[
                 'name': 'IMAGEURL',
                 'content': projectImageUrl
            ],[
                 'name': 'BENEFICIARY',
                 'content': beneficiaryName
            ],[
                 'name':'REGISTER_LINK',
                 'content':registerLink
            ],[
                 'name':'CDRADOMAIN',
                 'content': cdraDomain
            ] ]

            if (it.email == project.user.email){
                tags = ['sendCampaignValidationEmailToOwner']
                inviteToShare(it.email, 'sendCampaignValidationEmailToOwner', globalMergeVars, tags)
            } else {
                tags = ['sendCampaignValidationEmailToAdmins']
                inviteToShare(it.email, 'sendCampaignValidationEmailToAdmins', globalMergeVars, tags)
            }
        }

    }
    
    public def sendEmailToPartner(User user, Partner partner, def password) {
        def link = grailsLinkGenerator.link(controller: 'user', action: 'confirmPartner', id: partner.confirmCode, absolute: true)
        def currentEnv = Environment.current.getName()
        def cdraDomain = getCdraDomain(currentEnv)
        
        def globalMergeVars = [[
            'name': 'LINK',
            'content': link
        ], [
            'name': 'NAME',
            'content': user.firstName + ' ' + user.lastName
        ], [
            'name': 'EMAIL',
            'content': user.email
        ], [
            'name': 'PASSWORD',
            'content': password
        ], [
            'name':'CDRADOMAIN',
            'content': cdraDomain
        ]  ]

        def tags = ['partner-invitation']

        sendTemplate(user, 'partner-invitation', globalMergeVars, tags)
    }
    
    public def sendReInvitationEmailToPartner(Partner partner) {
        User user = partner.user
        def link = grailsLinkGenerator.link(controller: 'user', action: 'confirmPartner', id: partner.confirmCode, absolute: true)

        def globalMergeVars = [[
            'name': 'LINK',
            'content': link
        ], [
            'name': 'NAME',
            'content': user.firstName + ' ' + user.lastName
        ], [
            'name': 'EMAIL',
            'content': user.email
        ]]

        def tags = ['partner-re-invitation']

        sendTemplate(user, 'partner-re-invitation', globalMergeVars, tags)
    }
    
    public def sendInvitationToCampaignOwner(def email, User user, def confirmCode, def message) {
        def link = grailsLinkGenerator.link(controller: 'project', action: 'createCampaign', id: confirmCode, absolute: true)
        def globalMergeVars = [[
            'name': 'LINK',
            'content': link
        ], [
            'name': 'NAME',
            'content': user.firstName + ' ' + user.lastName
        ], [
            'name': 'EMAIL',
            'content': email
        ], [
            'name': 'MESSAGE',
            'content': message
        ]]

        def tags = ['partnerInvitationToCampaignOwner']

        inviteToShare(email, 'partnerInvitationToCampaignOwner', globalMergeVars, tags)
    }
	
    public def sendReceipt(def params, def docUrl) {
        def url = "https:"+ docUrl
        def email = params.email
        def globalMergeVars = [[
            'name': 'LINK',
            'content': url
        ], [
            'name': 'NAME',
            'content': params.name
        ], [
            'name': 'EMAIL',
            'content': email
        ], [
            'name': 'MESSAGE',
            'content': params.message
        ]]

        def tags = ['sendReceipt']

        inviteToShare(email, 'sendReceipt', globalMergeVars, tags)
    }
    
    public def sendEmailToPartner(User user) {
        def globalMergeVars = [[
            'name': 'NAME',
            'content': user.firstName + ' '+ user.lastName
        ]]

        def tags = ['partner-discard']

        inviteToShare(user.email, 'partner-discard', globalMergeVars, tags)
    }
    
    def sendTaxReceiptToContributors(def idList){
        Contribution contribution;
        def link;
        idList.each{
            contribution = Contribution.get(it);
            link = grailsLinkGenerator.link(controller: 'user', action: 'exportTaxReceiptPdf', id: contribution.id, absolute: true);
            def globalMergeVars = [[
                'name': 'NAME',
                'content': contribution.contributorName
            ], [
                'name': 'EMAIL',
                'content': contribution.contributorEmail
            ],[
                'name': 'AMOUNT',
                'content': contribution.amount
            ],[
                'name':'CURRENCY',
                'content':(contribution.currency == 'USD') ? '$' : 'Rs. '
            ],[
                'name' : 'DATE',
                'content':contribution.date.format("dd MMMM, YYYY")
            ],[
                'name': 'CAMPAIGNTITLE',
                'content': contribution.project.title
            ], [
                'name':'BENEFICIARYNAME',
                'content': contribution.project.beneficiary.firstName + ((contribution.project.beneficiary.lastName) ? (' ' + contribution.project.beneficiary.lastName) : '')
            ], [
                 'name':'USEDFOR',
                 'content':contribution.project.usedFor
            ], [
                 'name':'IDENTITY',
                 'content': (contribution.isAnonymous) ? 'Anonymous' : 'Non-Anonymous'
            ], [
                  'name':'MODE',
                  'content': (contribution.isContributionOffline) ? 'Offline' : 'Online'
            ], [
                  'name':'FUNDRAISER',
                  'content':contribution.fundRaiser
            ], [
                  'name':'LINK',
                  'content':link
            ]
        
        ]

        def tags = ['sendTaxReceiptToContributors']

        inviteToShare(contribution.contributorEmail, 'sendTaxReceiptToContributors', globalMergeVars, tags)
        contribution.receiptSent = true;
        }
    }

    def sendEmailToContributors(Contribution contribution, def password){
        def globalMergeVars = [[
                'name': 'NAME',
                'content': contribution.contributorName
            ], [
                'name': 'USERNAME',
                'content': contribution.contributorEmail
            ], [
                'name':'PASSWORD',
                'content' : password
            ], [
                'name': 'AMOUNT',
                'content': contribution.amount
            ],[
                'name':'CURRENCY',
                'content':(contribution.currency == 'USD') ? '$' : 'Rs. '
            ],[
                'name' : 'DATE',
                'content':contribution.date.format("dd MMMM, YYYY")
            ],[ 
                'name': 'CAMPAIGNTITLE',
                'content': contribution.project.title
            ], [
                'name':'BENEFICIARYNAME',
                'content': contribution.project.beneficiary.firstName + ((contribution.project.beneficiary.lastName) ? (' ' + contribution.project.beneficiary.lastName) : '')
            ]
        ]

        def tags = ['sendContributorUsernameAndPassword']

        inviteToShare(contribution.contributorEmail, 'sendContributorUsernameAndPassword', globalMergeVars, tags)
    }
    
    def sendEmailOnValidation(def environment, def emails, Project project) {
        def link = grailsLinkGenerator.link(controller: 'project', action: 'showCampaign', id: project.id, params:[fr:project.user.username], absolute: true)
        def currentEnv = Environment.current.getName()
        def cdraDomain = getCdraDomain(currentEnv)
        
        if (environment != 'development') {
            emails.each { email ->
                if (email)  {
                    def globalMergeVars = [[
                            'name': 'TITLE',
                            'content': project.title
                        ], [
                            'name': 'CATEGORY',
                            'content': project.category
                        ], [
                            'name':'Email',
                            'content' : email
                        ], [
                            'name':'LINK',
                            'content' : link
                        ], [
                            'name': 'CDRADOMAIN',
                            'content': cdraDomain
                        ]
                    ]
    
                    def tags = ['recommendation-engine']
    
                    inviteToShare(email,'recommendation-engine', globalMergeVars, tags)
                }
            }
        }
    }
    
    def sendIntimationEmailToCampaignOwner(Project project, ProjectUpdate projectUpdate, User campaignOwner) {
        def title = projectUpdate.title
        Date scheduledDate = projectUpdate.scheduledDate

        def link = grailsLinkGenerator.link(controller: 'project', action: 'showCampaign', id: project.id, absolute: true)
        
        def globalMergeVars = [[
            'name': 'LINK',
            'content': link
        ], [
            'name': 'NAME',
            'content': campaignOwner.firstName + ' ' + campaignOwner.lastName
        ], [
            'name': 'UPDATETITLE',
            'content': title
        ], [
            'name': 'CAMPAIGNTITLE',
            'content': project.title
        ], [
            'name': 'DATE',
            'content': scheduledDate.format("YYYY-MM-DD HH:mm:ss")
        ]]

        def tags = ['update-scheduled-info']

        sendTemplate(campaignOwner, 'update-scheduled-info', globalMergeVars, tags)
    }
    
}
