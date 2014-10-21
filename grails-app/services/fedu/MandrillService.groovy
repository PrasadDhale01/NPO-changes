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
                to: [[
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

        def tags = ['admin-invite']

        sendTemplate(user, 'admin_invitation', globalMergeVars, tags)
    }

    private def sendEmail(User user) {
        def globalMergeVars = [[
            'name': 'NAME',
            'content': user.firstName + ' ' + user.lastName
        ], [
            'name': 'EMAIL',
            'content': user.email
        ]]
        
        def projects = Project.findAllByUser(user)
        
        if (projects.size()!= 0) {
            
            def tags = ['fund-confirmation']
            
            sendTemplate(user, 'funding_confirmation', globalMergeVars, tags)
            
        } else {
        
            def tags = ['thanking-contributors']
            
            sendTemplate(user, 'thanks_to_contributors', globalMergeVars, tags)
        }
       
        
   }
}
