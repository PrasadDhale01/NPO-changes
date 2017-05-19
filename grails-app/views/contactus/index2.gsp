<g:set var="projectService" bean="projectService"/>
<%
	def currentEnv = projectService.getCurrentEnvironment()
	def country_code = projectService.getCountryCodeForCurrentEnv(request);
%>
<html>
<head>
<meta name="layout" content="main" />
<title>Crowdera- Contact us</title>

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
		                <img alt="Chat" src="//s3.amazonaws.com/crowdera/project-images/1b51df47-1735-4eff-8fbb-03b49af909e1.png">
		            </div>
		            <hr class="ct-hr-sizes">
		            <b class="ct-menus-font">CHAT</b>
		            <p class="ct-text-desp">Need to chat? Our team<br> will be happy to anser<br> all your questions</p>
		        </div>
		        
		        <div class="col-md-2 col-sm-2 text-center ct-width">
		            <div class="img-view-secand">
		                <img alt="Mail" src="//s3.amazonaws.com/crowdera/project-images/2e6fe2a4-9d03-47e2-a717-e09562ac0939.png">
		            </div>
		            <hr class="ct-hr-sizes">
		            <b class="ct-menus-font">EMAIL</b>
		            <p class="ct-text-desp">Drop us a detailed email.<br> We typically respond <br> in 1 to 12 hours</p>
		        </div>
		        
		        <div class="col-md-2 col-sm-2 text-center ct-width">
		            <div class="img-view-secand">
		                <img alt="Self Help" src="//s3.amazonaws.com/crowdera/project-images/f3f251b8-6bed-4bd1-9e9b-b50a266ca5b2.png">
		            </div>
		            <hr class="ct-hr-sizes">
		            <b class="ct-menus-font">SELF HELP</b>
		            <p class="ct-text-desp">Got a question?<br> Check out our FAQs<br> and Helpdesk</p>
		        </div>
		        
		         <div class="col-md-2 col-sm-2 text-center ct-width">
		             <div class="img-view-secand">
		                 <img alt="Call" src="//s3.amazonaws.com/crowdera/project-images/edbf7f90-dd5c-46cc-a832-9ad7a3f2cb70.png">
		             </div>
		             <hr class="ct-hr-sizes">
		             <b class="ct-menus-font">CALL</b>
		             <p class="ct-text-desp">If it's urgent.<br> We're available on call<br> from 9am - 7pm</p>
		        </div>
		        
		         <div class="col-md-2 col-sm-2 text-center ct-width">
		             <div class="img-view-secand">
		                  <img alt="Call" src="//s3.amazonaws.com/crowdera/project-images/0df5a972-7e4d-4c64-a563-6b258c1184e3.png">
		             </div>
		             <hr class="ct-hr-sizes">
		             <b class="ct-menus-font">REQUEST A DEMO</b>
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
</body>
</html>