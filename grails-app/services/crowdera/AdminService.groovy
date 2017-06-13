package crowdera

import static java.util.Calendar.*
import grails.transaction.Transactional
import grails.util.Environment
import groovy.json.JsonSlurper
import groovyx.net.http.ContentType
import groovyx.net.http.HTTPBuilder
import groovyx.net.http.Method

import java.security.MessageDigest
import java.text.DateFormat
import java.text.SimpleDateFormat

import javax.servlet.http.Cookie
import javax.websocket.Session;
import javax.servlet.http.HttpServletRequest;

import org.springframework.web.context.request.RequestContextHolder
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.commons.CommonsMultipartFile
import org.apache.http.HttpEntity
import org.apache.http.HttpRequest;
import org.apache.http.HttpResponse
import org.apache.http.client.HttpClient
import org.apache.http.client.methods.HttpPost
import org.apache.http.entity.StringEntity
import org.apache.http.impl.client.DefaultHttpClient
import org.grails.datastore.mapping.query.Query.IsNotNull;
import org.hibernate.Session
import org.hibernate.SessionFactory
import org.hibernate.criterion.Projections;
import org.hibernate.criterion.Restrictions;
import org.jets3t.service.impl.rest.httpclient.RestS3Service
import org.jets3t.service.model.*

import grails.util.Environment
import groovy.json.JsonSlurper
import static java.util.Calendar.*

import org.apache.http.util.EntityUtils
import org.jets3t.service.security.AWSCredentials
import org.hibernate.SessionFactory;

import grails.transaction.Transactional

class AdminService {
	def userService
	def contributionService
	def grailsLinkGenerator
	def imageFile
	def imageUrlService
	def mandrillService
	def rewardService
	def grailsApplication
	def socialAuthService
	def roleService
	def projectService
	
	SessionFactory sessionFactory;
	
	def getsortedcampaignsforstatistics(sortval){
		List projects = new ArrayList();
		
		if (sortval == 'LIVE'){
			projects = Project.findAllWhere(validated: true, inactive: false)
		}else if (sortval == 'REJECTED'){
			projects = Project.findAllWhere(rejected: true)
		}else if (sortval == 'DRAFT'){
			projects = Project.findAllWhere(validated: false, draft: true )
		}else if (sortval == 'PENDING'){
			projects = Project.findAllWhere(touAccepted: true,validated: false, draft: false )
		}else if (sortval == 'IN'){
			projects = Project.findAllWhere(payuStatus: true)
		}else if (sortval == 'US'){
			projects = Project.findAllWhere(payuStatus: false)
		}
		
		List projectlist= new ArrayList();
		
		projects.each{
							ProjectDTO projectDTO = new ProjectDTO();
								
							//Title
							  projectDTO.title = it.title
							
							//Country
							  if(it.beneficiary.country != null && it.beneficiary.country != "null"){
								  projectDTO.country = it.beneficiary.country
							  }
							  else{
								  projectDTO.country = 'NA'
							  }
							  
							
							//Fundraiser Name
							  projectDTO.fundraiserName = it.user.firstName +" "+ it.user.lastName
							
							//telephone
								if(it.beneficiary.telephone != null && it.beneficiary.telephone != "null" && it.beneficiary.telephone != "")	{
									projectDTO.telephone = it.beneficiary.telephone
								}else{
									projectDTO.telephone = 'NA'
								}
								
							//status
								if(sortval == 'LIVE'){
									projectDTO.status = 'LIVE'
								}else if(sortval == 'DRAFT'){
									projectDTO.status = 'DRAFT'
								}else if(sortval == 'PENDING'){
									projectDTO.status = 'PENDING'
								}else if(sortval == 'REJECTED'){
									projectDTO.status = 'REJECTED'
								}else{
									projectDTO.status = 'ONHOLD'
								}
								
							//
								
							//foreignfunding
								if ((it.payuEmail && it.paypalEmail) || (it.citrusEmail && it.paypalEmail))
									 {
										projectDTO.foreignContribution = 'YES'
								}else{
										projectDTO.foreignContribution = 'NO'
								}
								
							//WebAddress
								if(it.webAddress != null && it.webAddress != "null"){
									projectDTO.webAddress = it.webAddress
								}else{
									projectDTO.webAddress = 'NA'
								}
								
							//Email
								if(it.user.email != null && it.user.email != "null"){
									projectDTO.fundraiserEmail = it.user.email
								}
								else{
									projectDTO.fundraiserEmail = 'NA'
								}
									
							
							//created
								projectDTO.dateOfCreation = it.created
							
							//transaction email && payment gateway opted
								if(it.payuEmail != null && it.payuEmail != "null"){
									projectDTO.transactionEmail = it.payuEmail
									projectDTO.paymentGateway = 'PayU'
								}else if(it.paypalEmail != null && it.paypalEmail != "null"){
									projectDTO.transactionEmail = it.paypalEmail
									projectDTO.paymentGateway = 'PayPal'
								}else if(it.citrusEmail != null && it.citrusEmail != "null"){
									projectDTO.transactionEmail = it.citrusEmail
									projectDTO.paymentGateway = 'Citrus'
								}else if(it.wepayEmail != null && it.wepayEmail != "null"){
									projectDTO.transactionEmail = it.wepayEmail
									projectDTO.paymentGateway = 'WePay'
								}else if(it.charitableId != null && it.charitableId != "null"){
									projectDTO.transactionEmail = it.charitableId
									projectDTO.paymentGateway = 'FirstGiving'
								}else{
									projectDTO.transactionEmail = 'NA'
									projectDTO.paymentGateway = 'PayU'
								}
								
								projectlist.add(projectDTO)
					}
		return projectlist
	}
	
	def generateCSVofcampaignstatistics(projectlist, response){
		response.setHeader("Content-disposition", "attachment; filename= Crowdera_Campaign_Statistics"+".csv")
		def results = []
		def title
		def country
		def createdTime
		def createdDate
		def status
		def fundraiser
		def fundraiserEmail
		def telephone
		def foreignFunding
		def paymentgateway
		def webAddress
		def transactionEmail
		
		DateFormat newTime = new SimpleDateFormat("HH:mm:ss");
		DateFormat newDate  = new SimpleDateFormat("dd:MM:YYYY");
		
		def result
		
		projectlist.each {
			Date date = it.dateOfCreation;
			String timeOnly = newTime.format(date);
			String dateOnly = newDate.format(date);
			title = it.title.replaceAll("[,;\\s]",'_')
			country = it.country
			createdDate = dateOnly
			createdTime = timeOnly
			status = it.status
			fundraiser = it.fundraiserName
			fundraiserEmail = it.fundraiserEmail
			telephone = it.telephone
			foreignFunding = it.foreignContribution
			paymentgateway = it.paymentGateway
			webAddress = it.webAddress
			transactionEmail = it.transactionEmail
			
			def rows = [title, country, createdDate, createdTime, status, fundraiser, fundraiserEmail, telephone, foreignFunding, paymentgateway, webAddress, transactionEmail]
			results << rows
		}
		
		result = 'TITLE, COUNTRY, CREATED_DATE, CREATED_TIME, STATUS, FUNDRAISER_NAME, FUNDRAISER_EMAIL, TELEPHONE, FOREIGN_FUNDING, PAYMENT_GATEWAY, WEB_ADDRESS, TRANSACTION_EMAIL \n'
		
		results.each{ row->
			row.each{
				col -> result+=col +','
			}
			result = result[0..-2]
			result+="\n"
		}
		
		return result
		
	}
   
}
