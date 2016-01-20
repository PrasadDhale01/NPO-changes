package crowdera

import groovy.json.JsonSlurper

import org.apache.http.HttpResponse
import org.apache.http.client.HttpClient
import org.apache.http.client.methods.HttpGet
import org.apache.http.client.methods.HttpPost
import org.apache.http.entity.StringEntity
import org.apache.http.impl.client.DefaultHttpClient
import org.apache.http.util.EntityUtils


class SocialAuthService {

    def getAccessToken(def code,def endpoint, def clientSecret, def redirectUri, def clientId, def provider) {
        HttpClient client = new DefaultHttpClient()
        HttpPost httprequest = new HttpPost(endpoint)
        httprequest.addHeader("Content-type", "application/x-www-form-urlencoded")
        String requestBody
        if(provider.equals('constant')){
            requestBody = "grant_type=authorization_code&client_id="+clientId+"&client_secret="+clientSecret+"&code="+code+"&redirect_uri="+ redirectUri;
        }else{
            requestBody = "code="+code+"&client_secret="+clientSecret+"&redirect_uri="+redirectUri+"&client_id="+clientId+"&grant_type=authorization_code";
        }
        httprequest.setEntity(new StringEntity(requestBody))
        HttpResponse httpresponse = client.execute(httprequest)
        def token = EntityUtils.toString(httpresponse.getEntity())
        return token
    }
	
    def getRequestData(def token,def url){
          HttpClient client = new DefaultHttpClient()
          HttpGet httpGet= new HttpGet(url)
          httpGet.setHeader("Content-type","application/json")
          httpGet.addHeader("Authorization", "Bearer "+ token)
          HttpResponse httpresponse = client.execute(httpGet)
          def contacts = EntityUtils.toString(httpresponse.getEntity())
          return contacts
    }
	
    def getJsonStringObject(def json){
          def jsonString = null
          if(json){
                jsonString = new JsonSlurper().parseText(json)
          }
          return jsonString
    }

    def getSocialContactsByUser(User user){
          def socialContacts =SocialContacts.findAllWhere(user)
          return socialContacts
    }

    def setSocailContactsByUser(def socialContacts, def contactList, def provider){
          switch(provider){
                case 'constant':
                      socialContacts.constantContact= contactList
                break;
                case 'google':
                      socialContacts.gmail= contactList
                break;
                case 'mailchimp':
                     socialContacts.mailchimp= contactList
                break;
                case 'csv':
                    socialContacts.csvContact= contactList
                break;
                case 'facebook':
                    socialContacts.facebook= contactList
                break;
          }
    }

    def getMailchimpContactsByListId(def token,def listId, def url){
          HttpClient client = new DefaultHttpClient()
          List contacts = []
          listId.each{
               //HttpGet httpGet= new HttpGet('https://'+dc+'.api.mailchimp.com/3.0/lists/'+it+'/members')
               HttpGet httpGet= new HttpGet(url + "/"+ it +'/members')
               httpGet.setHeader("Content-type","application/json")
               httpGet.addHeader("Authorization", "Bearer "+ token)
               HttpResponse httpresponse = client.execute(httpGet)
               def rawContact = EntityUtils.toString(httpresponse.getEntity())
               def jsonContact = getJsonStringObject(rawContact)
               def contactsList
               if(jsonContact.error){
                    contacts=null
               }else{
                    contactsList = jsonContact.members.email_address.toString().replace('[', " ").replace(']',' ')
               }
               contacts.add(contactsList)
          }
          return contacts
    }
}
