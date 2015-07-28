<g:set var="userService" bean="userService" />
<g:set var="contributionService" bean="contributionService"/>
<g:set var="projectService" bean="projectService"/>
<% def user = userService.getCurrentUser() 
if(user==null){
	user= userService.getUserByUsername('anonymous@example.com')
}
def base_url = grailsApplication.config.crowdera.BASE_URL
%>
<html>
<head>
<meta name="layout" content="main" />
<r:require modules="projectcreatejs" />
<link rel="stylesheet" href="/bootswatch-yeti/bootstrap.css">
<link rel="stylesheet" href="/css/datepicker.css">
<script src="//tinymce.cachefly.net/4.1/tinymce.min.js"></script>
<script src="/js/main.js"></script>
<script src="/js/bootstrap-datepicker.js"></script>
</head>
<body>
<input type="hidden" name="uuid" id="uuid" />
<input type="hidden" name="charity_name" id="charity_name" />
<input type="hidden" name="url" value="${currentEnv}" id="currentEnv"/>
<div class="">
    <div class="cr-headerA">
        <h1 class="text-center cr-header-name">
            Create Campaign
        </h1>
         <h3 class="text-center cr-sub-name">Raise money for what matters to you</h3>
     </div>
     <div class="bg-color">
	     <div class="container footer-container" id="campaigncreate">
	        <g:uploadForm class="form-horizontal cr-top-spaces" controller="project" action="createNow" role="form">
	             <input type="hidden" value="${user.id}" name="userid">
	                <div class="form-group">
						<label class="col-sm-12">My Name is...</label>
						<div class="col-sm-12">
							<input class="form-control"
								name="${FORMCONSTANTS.FIRSTNAME}" placeholder="Display Name">
						</div>
	                </div>
	                
	                    <div class="form-group">
	                        <div class="col-sm-6">
		                         <div class="form-group">
		                            <div class="col-sm-12">
					                    <span class="cr-need">I need</span><img class="cr-ineed-icons" src="//s3.amazonaws.com/crowdera/assets/i-need-Icon.png" alt="Ineed">
					                </div>
					                <div class="clear"></div>
						            <div class="col-sm-5 tops">
						            <g:if test="${currentEnv == 'testIndia' || currentEnv == 'stagingIndia' || currentEnv == 'prodIndia'}">
							            <span class="i-currency-label fa fa-inr"></span>
							         </g:if>
							         <g:else>
							             <span class="i-currency-label">$</span>
				                     </g:else>   
				                            <input class="form-control cr-amt" name="amount" id="${FORMCONSTANTS.AMOUNT}"> 
						                    <span id="errormsg"></span>
			                         </div>
		                         </div>
	                         </div>
	                         <div class="col-sm-6">
	                         </div>
	                    </div>
	                    
	                    <div class="form-group">
	                        <label class="col-sm-12">My plan is...</label>
	                        <div class="col-sm-12">
	                            <textarea class="form-control" name="title" rows="2" placeholder="Campaign title is the gateway to view your campaign, create an impactful and actionable title." id="campaignTitle" maxlength="55"></textarea>
	                            <label class="pull-right " id="titleLength"></label>
	                        </div>
	                    </div>
	                
	                
	                    <div class="form-group">
	                        <div class="col-sm-12">
	                            <textarea class="form-control" id="descarea" name="${FORMCONSTANTS.DESCRIPTION}" rows="2" placeholder="Campaign Description" maxlength="140"></textarea>
	                            <label class="pull-right " id="desclength"></label>
	                        </div>
	                    </div>
	            
	            <div class="text-center">
	                <button type="submit" class="btn  btn-primary btn-colors cr-bg-create-btn" name="button" value="" id="campaigncreatebtn"></button>
	            </div>
	        </g:uploadForm>
	     </div>
     </div>
</div>
</body>
</html>
