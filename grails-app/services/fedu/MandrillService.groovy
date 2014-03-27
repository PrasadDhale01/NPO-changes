package fedu

import groovyx.net.http.ContentType
import groovyx.net.http.HTTPBuilder
import groovyx.net.http.Method
import grails.converters.JSON

class MandrillService {
    def grailsApplication

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
}
