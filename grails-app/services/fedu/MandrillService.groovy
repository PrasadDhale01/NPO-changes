package fedu

import groovyx.net.http.ContentType
import groovyx.net.http.HTTPBuilder
import groovyx.net.http.Method
import grails.converters.JSON

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

    def shareProject(def emailList, String name, String message, Project project) {
        emailList.each { email ->
            def link = grailsLinkGenerator.link(controller: 'project', action: 'show', id: project.id, absolute: true)
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
                    'content': project.imageUrl[0].getUrl()
                ]
            ]

            def tags = ['invite-to-share']

            inviteToShare(email, 'invite-to-share', globalMergeVars, tags)
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
        def link = grailsLinkGenerator.link(controller: 'project', action: 'show', id: project.id, absolute: true)
        def registerLink = grailsLinkGenerator.link(controller: 'login', action: 'register', id: project.id, absolute: true)
        def imageUrl
        if(project.imageUrl[0].getUrl()) {
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
        def imageUrl
        if(project.imageUrl[0].getUrl()) {
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
}
