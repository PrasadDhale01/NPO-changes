<g:set var="projectService" bean="projectService"/>
<%
	def currentEnv = projectService.getCurrentEnvironment()
	def country_code = projectService.getCountryCodeForCurrentEnv(request);
	def isDeviceMobileOrTab = projectService.isDeviceMobileOrTab(request);
	def base_url = grailsApplication.config.crowdera.BASE_URL
%>
<html>
<head>
<meta name="layout" content="main" />
<title>Crowdera Customer Help</title>

    <!-------------- Open Graph Data  -------------->
	<meta property="og:site_name" content="GoCrowdera" />
	<meta property="og:type" content="website" />
	<meta property="og:title" content="Need help? Have Questions? Contact our champions! " />
	<meta property="og:url" content="${base_url}customer-service" />
	<meta property="og:image" content="//s3.amazonaws.com/crowdera/project-images/3288f33c-aed0-498b-8107-2e7e01029da4.jpg" />
	<meta name="description" content="We're here to help! Contact us with your query and we will get back to you quickly. "/>
	<meta name="keywords" content="Simple, secure and easy online fundraising website for all things that matter for individuals and non-profits. Get started for free now! " />
	
	<!-------------- Twitter Card Data  -------------->
	
	<meta name="twitter:card" content="summary_large_image" />
	<meta name="twitter:site" content="@gocrowdera" />
	<meta property="twitter:title" content="Need help? Have Questions? Contact our champions! " />
	<meta name="twitter:domain" content="${base_url}customer-service" />
	<meta property="twitter:description" content="We're here to help! Contact us with your query and we will get back to you quickly. " />
	<meta property="twitter:image" content="//s3.amazonaws.com/crowdera/project-images/3288f33c-aed0-498b-8107-2e7e01029da4.jpg" />
	<meta property="twitter:url" content="${base_url}customer-service" />
</head>
<body>
    <div class="feducontent">
        <div class="container ct-container-wid">
            <div class="row">
	            <div class="text-center">
		            <h3 class="ct-color">Contact Crowdera</h3>
		            <hr class="ct-hr-sizes">
		            <small class="ct-subtitle">We are here to help you</small>
	            </div>
            </div>
            <div class="row ct-padding">
                <div class="col-md-2 col-sm-2 text-center ct-width">
		            <div class="img-view-first">
		            	<a href="javascript: interaktchat();"><img alt="Chat" src="//s3.amazonaws.com/crowdera/project-images/1b51df47-1735-4eff-8fbb-03b49af909e1.png"></a>
		            </div>
		            <hr class="ct-hr-sizes">
						<a href="javascript: interaktchat();" style="text-decoration: none;"><b class="ct-menus-font">CHAT</b></a> 
		            <p class="ct-text-desp">Need to chat? Our team<br> will be happy to answer<br> all your questions</p>
		     	</div>
		        
		        <div class="col-md-2 col-sm-2 text-center ct-width">
		            <div class="img-view-secand">
		             <a href="javascript: interaktfb();">
		             	<img alt="Mail" src="//s3.amazonaws.com/crowdera/project-images/2e6fe2a4-9d03-47e2-a717-e09562ac0939.png">
		             </a>
		            </div>
		            <hr class="ct-hr-sizes">
					<a href="javascript: interaktfb();" style="text-decoration: none;"><b class="ct-menus-font">EMAIL</b></a> 
		            <p class="ct-text-desp">Drop us a detailed email.<br> We typically respond <br> in 1 to 12 hours</p>
		        </div>
		        
		        <div class="col-md-2 col-sm-2 text-center ct-width">
		            <div class="img-view-secand">
		                <a href="http://support.gocrowdera.com/#/"><img alt="Self Help" src="//s3.amazonaws.com/crowdera/project-images/f3f251b8-6bed-4bd1-9e9b-b50a266ca5b2.png"></a>
		            </div>
		            <hr class="ct-hr-sizes">
					<a href="http://support.gocrowdera.com/#/" style="text-decoration: none;"><b class="ct-menus-font">SELF HELP</b></a> 
		            <p class="ct-text-desp">Got a question?<br> Check out our FAQs<br> and Helpdesk</p>
		        </div>
		        
		         <div class="col-md-2 col-sm-2 text-center ct-width">
		             <div class="img-view-secand">
		             	<g:if test="${isDeviceMobileOrTab}">
		             		<g:if test="${'in'.equalsIgnoreCase(country_code)}">
			             		 <a class="scrollToComment" href="tel:+917219702234">
			             		 	<img alt="Call" src="//s3.amazonaws.com/crowdera/project-images/edbf7f90-dd5c-46cc-a832-9ad7a3f2cb70.png">
								</a>
							</g:if>
							<g:else>
								<a class="scrollToComment" href="tel:+16506902234">
			             		 	<img alt="Call" src="//s3.amazonaws.com/crowdera/project-images/edbf7f90-dd5c-46cc-a832-9ad7a3f2cb70.png">
								</a>
							</g:else>		             	
		             	</g:if>
		             	<g:else>
		             		<img alt="Call" src="//s3.amazonaws.com/crowdera/project-images/edbf7f90-dd5c-46cc-a832-9ad7a3f2cb70.png">
		             	</g:else>
		             </div>
		             <hr class="ct-hr-sizes">
		             <g:if test="${isDeviceMobileOrTab}">
		             	<g:if test="${'in'.equalsIgnoreCase(country_code)}">
	            			<a href="tel:+917219702234" style="text-decoration: none;"><b class="ct-menus-font">CALL</b></a>
		            	</g:if>
		            	<g:else>
		            		<a href="tel:+16506902234" style="text-decoration: none;"><b class="ct-menus-font">CALL</b></a>
		            	</g:else>
		            </g:if>
		            <g:else>
	            		<b class="ct-menus-font">CALL</b>
		            </g:else>
		             <p class="ct-text-desp">If it's urgent.<br> We're available on call<br> from 9am - 7pm</p>
		        </div>
		        
		         <div class="col-md-2 col-sm-2 text-center ct-width">
		             <div class="img-view-secand">
		                  <a href="https://gocrowdera.youcanbook.me"><img alt="Call" src="//s3.amazonaws.com/crowdera/project-images/0df5a972-7e4d-4c64-a563-6b258c1184e3.png"></a>
		             </div>
		             <hr class="ct-hr-sizes">
		             <a href="https://gocrowdera.youcanbook.me" style="text-decoration: none;"><b class="ct-menus-font">REQUEST A DEMO</b></a>
		             <p class="ct-text-desp">Got a Demo?<br> Check out our Request<br> a Demo</p>
		        </div>
            </div>
            
            <div class="row ct-contDetail-bottom ">
	            <div class="text-center">
		            <h4 class="ct-color-contact">Contact Details</h4>
		            <g:if test="${'in'.equalsIgnoreCase(country_code)}">
		                <label class="ct-contact-font">Phone number :</label>
		                <label class="ct-contact-font"><span>+91 721 970 2234</span></label><br>
		                <label class="ct-contact-font">Address :</label>
		                <label class="ct-contact-font">206, Sankalp Nagar, Wathoda Layout,</label><br>
		                <label class="ct-contact-font">Nagpur - 440009</label>
		             </g:if>
		             <g:else>
		                <label class="ct-contact-font">Phone number :</label>
		                <label class="ct-contact-font"><span>+1 (650) 690 2234</span></label><br>
		                <label class="ct-contact-font">Address :</label>
		                <label class="ct-contact-font">228 Hamilton Avenue, Floor 3, Palo Alto</label><br>
		                <label class="ct-contact-font">CA 94301</label><br>
		             </g:else>
	            </div>
            </div>
            
        </div>
    </div>
   					 <script>
					  function interaktchat() {
					  var interakt = document.createElement('script');
					  interakt.type = 'text/javascript'; interakt.async = true;
					  interakt.src = "//cdn.interakt.co/interakt/0d5f42147e9211929adc0170a61e129b.js";
					  var scrpt = document.getElementsByTagName('script')[0];
					  scrpt.parentNode.insertBefore(interakt, scrpt);
					  }
					</script>
</body>
</html>
