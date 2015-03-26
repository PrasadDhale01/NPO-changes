package crowdera

import crowdera.Contribution;
import crowdera.Project;
import crowdera.ProjectUpdate;
import crowdera.User;
import grails.converters.JSON
import groovyx.net.http.ContentType
import groovyx.net.http.HTTPBuilder
import groovyx.net.http.Method

class MandrillService {
    def grailsApplication
    def grailsLinkGenerator

    def BASE_URL = "https://mandrillapp.com/api/1.0/"

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

    private def sendMail(User user) {
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

    private def sendBeneficiaryEmail(User user) {
        def link = grailsLinkGenerator.link(controller: 'fund', action: 'fundingConfirmation',id:user.id, absolute: true)

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

        def tags = ['fund-confirmation']

        sendTemplate(user, 'funding_confirmation', globalMergeVars, tags)

    }

    private def sendContributorEmail(User user, Project project){

        def link = grailsLinkGenerator.link(controller: 'fund', action: 'thankingContributors',id:project.id ,absolute: true)

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

        def tags = ['thanking-contributors']

        sendTemplate(user, 'thanks_to_contributors', globalMergeVars, tags)
    }

    private def sendResetPassword(User user) {
        def link = grailsLinkGenerator.link(controller: 'login', action: 'confirm_reset', id: user.resetCode, absolute: true)
	def createButton = grailsLinkGenerator.link(controller: 'project', action: 'create',absolute: true)
	def home = grailsLinkGenerator.link(controller: 'home', action: 'index', absolute: true)

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
	    ]
	]

        def tags = ['reset-password']

        sendTemplate(user, 'reset-password', globalMergeVars, tags)
    }

    private def inviteToShare(String email, String templateName, List globalMergeVars, List tags) {
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
        if (imageUrl) {
            imageUrl = project.imageUrl[0].getUrl()
        }
        emailList.each { email ->
            def link = grailsLinkGenerator.link(controller: 'project', action: 'show', id: project.id,params:[fr:fundRaiser], absolute: true)
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
                    'content': imageUrl
                ]
            ]

            def tags = ['invite-to-share']

            inviteToShare(email, 'invite-to-share', globalMergeVars, tags)
        }
    }

    def shareContribution(def emailList, String name, String message, Project project,Contribution contribution, User fundraiser) {
        def imageUrl = project.imageUrl
        if (imageUrl) {
            imageUrl = project.imageUrl[0].getUrl()
        }
        emailList.each { email ->
            def link = grailsLinkGenerator.link(controller: 'fund', action: 'acknowledge', id: project.id,params:[ cb:contribution.id, fr:fundraiser.id], absolute: true)
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
                    'content': imageUrl
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
        def link = grailsLinkGenerator.link(controller: 'project', action: 'manageproject', id: project.id, absolute: true)
        def registerLink = grailsLinkGenerator.link(controller: 'login', action: 'register', id: project.id, absolute: true)
        def imageUrl = project.imageUrl
        if (imageUrl) {
            imageUrl = project.imageUrl[0].getUrl()
        }
        def globalMergeVars = [
            [
                'name': 'LINK',
                'content': link
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
                'content': imageUrl
            ]
        ]

        def tags = ['invite-admin-for-project']

        inviteToAdmin(email, 'invite-admin-for-project', globalMergeVars, tags)
    }

    def sendUpdateEmailToAdmin(def email, String name, Project project) {
        def link = grailsLinkGenerator.link(controller: 'project', action: 'manageproject', id: project.id, absolute: true)
        def registerLink = grailsLinkGenerator.link(controller: 'login', action: 'register', absolute: true)
        def imageUrl = project.imageUrl
        if (imageUrl) {
            imageUrl = project.imageUrl[0].getUrl()
        }
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
            'name': 'TITLE',
            'content': project.title
        ], [
            'name': 'IMAGEURL',
            'content': imageUrl
        ]]

        def tags = ['project-update-email']

        inviteToAdmin(email, 'project-update-email', globalMergeVars, tags)
    }
    
    def sendUpdateEmailsToContributors(Project project,ProjectUpdate projectUpdate, User currentUser){
        def contributors=project.contributions
        def link = grailsLinkGenerator.link(controller: 'project', action: 'show', id: project.id, absolute: true)
        List imageUrls = projectUpdate.imageUrls
        def url
        if(imageUrls) {
            url = imageUrls[0].getUrl()            
        }
        contributors.each {contributor ->
            def user = contributor.user
            if (!user.email.equalsIgnoreCase('anonymous@example.com')) {
                def globalMergeVars = [[
                   'name': 'LINK',
                   'content': link
                ],[
                    'name': 'NAME',
                    'content': user.firstName+" "+user.lastName
                ],[
                    'name': 'STORY',
                    'content': projectUpdate.story
                ],[
                    'name': 'userName',
                    'content': currentUser.firstName+" "+currentUser.lastName
                ],[
                    'name': 'EMAIL',
                    'content': user.email
                ], [
                    'name': 'TITLE',
                    'content': project.title
                ], [
                    'name': 'IMAGEURL',
                    'content': url
                ]]
                
                def tags = ['campaign-update']
                
                inviteToAdmin(user.email, 'campaign-update', globalMergeVars, tags)
            }
        }
    }
    
    def sendInvitationForTeam(def emailList, String name, String message, Project project) {
        emailList.each { email ->
            def link = grailsLinkGenerator.link(controller: 'project', action: 'show', id: project.id, absolute: true)
            def imageUrl = project.imageUrl
            if (imageUrl) {
                imageUrl = project.imageUrl[0].getUrl()
            }
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
                    'content': imageUrl
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
            ]
        ]
        
        def tags = ['send-email-to-customer']

        inviteToAdmin(email, 'send-email-to-customer', globalMergeVars, tags)
    }
    
    def sendResponseToCustomer(def adminResponse, def service, def attachmentUrl) {
        def email = service.email
        def date = new Date()
        def base_url = grailsApplication.config.crowdera.BASE_URL
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
            ]
        ]

        def tags = ['send-response-to-customer']

        inviteToAdmin(email, 'send-response-to-customer', globalMergeVars, tags)
    }
    
    public def sendMandrillEmail(User user) {
        def link = grailsLinkGenerator.link(controller: 'login', action: 'confirm', id: user.confirmCode, absolute: true)

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

        def tags = ['registration']

        sendTemplate(user, 'new_user_confirmation', globalMergeVars, tags)
    } 
	
    public def reSendConfirmationMail(User user) {
	def link = grailsLinkGenerator.link(controller: 'login', action: 'confirm', id: user.confirmCode, absolute: true)

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
    
    public def sendThankYouMailToContributors(User user, Project project, def amount, User fundraiser) {
        def fundRaiserUserName = fundraiser.username
        def beneficiary = project.user
        def link = grailsLinkGenerator.link(controller: 'project', action: 'show', id: project.id, params:[fr:fundRaiserUserName], absolute: true)
        def globalMergeVars = [[
            'name': 'LINK',
            'content': link
        ],[
            'name': 'NAME',
            'content': user.firstName + ' ' + user.lastName
        ],[
            'name': 'BENEFICIARY',
            'content': beneficiary.firstName + ' ' + beneficiary.lastName
        ],[
            'name': 'AMOUNT',
            'content': amount
        ], [
            'name': 'EMAIL',
            'content': user.email
        ]]

        def tags = ['thankYouEmailToContributor']

        sendTemplate(user, 'thankYouEmailToContributor', globalMergeVars, tags)
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
    
    public def sendEmailToDevGroup(def exception) {
        
        def exceptionString = " "+ exception
        def devList = ['kartiki.sahu@crowdera.co','krishna.sahu@crowdera.co','tushar@crowdera.co','prasad.dhale@crowdera.co','minal.ganatra@crowdera.co','roshan.mahant@crowdera.co']
        def date = new Date()
        
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
                ]
            ]

            def tags = ['Exception-email-to-dev']

            inviteToAdmin(email, 'Exception-email-to-dev', globalMergeVars, tags)
        }
    }
    
    public def contributionEmailToCampaignOwnerOrTeam(def fundRaiser, def project, def contribution) {
        def username = fundRaiser.username
        def contributor = contribution.user
        def link = grailsLinkGenerator.link(controller: 'project', action: 'show', id: project.id, params:[fr:username], absolute: true, fragment: 'contributions')

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
                'content': contributor.firstName
            ]
        ]

        def tags = ['contributionEmailToCampaignOwnerOrTeam']

        sendTemplate(fundRaiser,'contributionEmailToCampaignOwnerOrTeam', globalMergeVars, tags)
    }
    
    public def sendTeamInvitation(Project project, User fundRaiser) {
        def user = project.user
        def username = user.username
        def link = grailsLinkGenerator.link(controller: 'project', action: 'manageproject', id: project.id, params:[fr:username], absolute: true, fragment: 'manageTeam')

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
            ]
        ]

        def tags = ['team-validation-request']

        sendTemplate(user,'team-validation-request', globalMergeVars, tags)
    }
    
    public def sendTeamValidatedConfirmation(Project project, User fundRaiser) {
        def username = fundRaiser.username
        def link = grailsLinkGenerator.link(controller: 'project', action: 'show', id: project.id, params:[fr:username], absolute: true)

        def globalMergeVars = [
            [
                'name': 'LINK',
                'content': link
            ],[
                'name': 'NAME',
                'content': fundRaiser.firstName + ' ' + fundRaiser.lastName
            ],[
                'name': 'IMAGEURL',
                'content': project.organizationIconUrl
            ],[
                'name': 'TITLE',
                'content': project.title
            ]
        ]

        def tags = ['team-validated-confirmation']

        sendTemplate(fundRaiser,'team-validated-confirmation', globalMergeVars, tags)
    }
    
    public def sendTeamUpdationEmail(Project project,Team team) {
        def teamUser = team.user
        def username = teamUser.username
        def link = grailsLinkGenerator.link(controller: 'project', action: 'show', id: project.id, params:[fr:username], absolute: true)

        def globalMergeVars = [
            [
                'name': 'LINK',
                'content': link
            ],[
                'name': 'NAME',
                'content': teamUser.firstName + ' ' + teamUser.lastName
            ],[
                'name': 'IMAGEURL',
                'content': project.organizationIconUrl
            ],[
                'name': 'TITLE',
                'content': project.title
            ],[
                'name': 'OWNER',
                'content': project.user.firstName +' '+ project.user.lastName
            ]
        ]

        def tags = ['team-updation-email']

        sendTemplate(teamUser,'team-updation-email', globalMergeVars, tags)
    }
    
}
