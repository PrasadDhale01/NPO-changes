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

    def getGoogleAccessToken(def code, def clientSecret, def redirectUri, def clientId) {
       def token=null;
	   HttpClient client = new DefaultHttpClient();
	   HttpPost httprequest = new HttpPost("https://accounts.google.com/o/oauth2/token?" );

	   httprequest.addHeader("Content-type", "application/x-www-form-urlencoded");

	   String requestBody = "code="+code+"&client_secret="+clientSecret+"&redirect_uri="+redirectUri+"&client_id="+clientId+"&grant_type=authorization_code";
	   try {
		   httprequest.setEntity(new StringEntity(requestBody));
	   } catch (UnsupportedEncodingException e) {
		   e.printStackTrace();  
	   }

	   /* Checking response */
	   try {
		   HttpResponse httpresponse = client.execute(httprequest);
		   token = EntityUtils.toString(httpresponse.getEntity());
	   } catch (IOException e) {
		   e.printStackTrace(); 
	   }
	   
	   return token
    }
	
	def getGmailContactsByAccessToken(def token, def email){
		def result=null;
		HttpClient client = new DefaultHttpClient()
		HttpGet httpGet= new HttpGet('https://www.google.com/m8/feeds/contacts/'+email+'/full?alt=json')
		httpGet.setHeader("Content-type","application/json")
		
  	    httpGet.addHeader("Authorization", "Bearer "+ token)
		  
		/* Checking response */
		try {
			HttpResponse httpresponse = client.execute(httpGet);
			result = EntityUtils.toString(httpresponse.getEntity());
		} catch (IOException e) {
			e.printStackTrace(); 
		}
		
		return result
	}
	
	def getConstantContactToken(def code){
	   def results=null;
		
	   HttpClient client = new DefaultHttpClient();
	   HttpPost httprequest = new HttpPost("https://oauth2.constantcontact.com/oauth2/oauth/token?" );

	   httprequest.addHeader("Content-type", "application/x-www-form-urlencoded");

	   String requestBody = "grant_type=authorization_code&client_id=u9jc9nmmmtptyyz2y75cspry&client_secret=fRGDUHAf8tuS74upJgXhctTw&code="+code+"&redirect_uri=http://localhost:8080/project/getSocialContactsCode";
	   try {
		   httprequest.setEntity(new StringEntity(requestBody));
	   } catch (UnsupportedEncodingException e) {
		   e.printStackTrace();  //To change body of catch statement use File | Settings | File Templates.
	   }

	   /* Checking response */
		try {
			HttpResponse httpresponse = client.execute(httprequest);
			results = EntityUtils.toString(httpresponse.getEntity());
		} catch (IOException e) {
			e.printStackTrace();  //To change body of catch statement use File | Settings | File Templates.
		}
	   return results
	}
	
	def sendConstantContactHTTPGetRequest(def accessToken){
		
		HttpClient client = new DefaultHttpClient()
		HttpGet httpGet= new HttpGet('https://api.constantcontact.com/v2/contacts?status=ALL&limit=50&api_key=u9jc9nmmmtptyyz2y75cspry')
		httpGet.setHeader("Content-type","application/json")
		
		httpGet.addHeader("Authorization", "Bearer "+ accessToken)
		
		/* Checking response */
		def results
		try {
			HttpResponse httpresponse = client.execute(httpGet);
			results = EntityUtils.toString(httpresponse.getEntity())
		} catch (IOException e) {
			e.printStackTrace();  //To change body of catch statement use File | Settings | File Templates.
		}
		return results
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
	def setSocailContactsByUser(def socialContatcs, def contactList, def provider){
		switch(provider){
			case 'constant':
				socialContatcs.constantContact= contactList
			break;
			case 'google':
			    socialContatcs.gmail= contactList
			break;
		}
	}
}
