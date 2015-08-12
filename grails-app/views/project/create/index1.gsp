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
						<label class="col-sm-12 text-color">My Name is...</label>
						<div class="col-sm-12">
							<input class="form-control form-control-no-border text-color box-size" id="name"
								name="${FORMCONSTANTS.FIRSTNAME}" placeholder="Display Name">
						</div>
	                </div>
	                
	                    <div class="form-group">
	                       <div class="col-sm-3">
					           <span class="cr-need">I need</span><img class="cr-ineed-icons" src="//s3.amazonaws.com/crowdera/assets/i-need-Icon.png" alt="Ineed">
						       <div class="tops">
						            <g:if test="${currentEnv == 'testIndia' || currentEnv == 'stagingIndia' || currentEnv == 'prodIndia'}">
							            <span class="i-currency-label fa fa-inr"></span>
							         </g:if>
							         <g:else>
							             <span class="i-currency-label">$</span>
				                     </g:else>   
				                     <input class="form-control form-control-no-border-amt cr-amt" name="amount" id="${FORMCONSTANTS.AMOUNT}"> 
						             <span id="errormsg"></span>
	                           </div>
	                       </div>
   	                       <g:if test="${currentEnv == 'development' || currentEnv == 'test' || currentEnv == 'production' || currentEnv == 'staging'}">
	                           <div class="col-sm-1 amount-popover">
	                               <img class="amountInfo-img" src="//s3.amazonaws.com/crowdera/assets/Information-Icon.png" alt="Information icon">
	                           </div>
	                       </g:if>
	                       <g:else>
	                           <div class="col-sm-1 amount-popover">
	                               <img class="amountInfoInd-img" src="//s3.amazonaws.com/crowdera/assets/Information-Icon.png" alt="Information icon">
	                           </div>
	                       </g:else>
	                       <div class="col-sm-8">
	                           <div class="btn-group col-sm-12 cr1-radio-tab cr1-mob-tb" data-toggle="buttons">
	                                    <div class="cr1-tab-title">and I will be using it for</div>
										<label class="btn btn-default cr1-check-btn cr1-tb-color cr1-mob-tb-pd col-sm-3 col-xs-12 " id="impact"> <input type="radio" value="yes"><span class="cr1-tb-text-sm">Making an</span><br><span class="cr1-tb-text-lg">Impact</span></label> 
										<label class="btn btn-default cr1-check-btn cr1-tb-color cr1-mob-tb-pd  col-sm-3 col-xs-12" id="passion"> <input type="radio" value="no"><span class="cr1-tb-text-sm">Following my</span><br><span class="cr1-tb-text-lg">Passion</span></label>
										<label class="btn btn-default cr1-check-btn cr1-tb-color cr1-mob-tb-pd  col-sm-3 col-xs-12"  id="innovating"> <input type="radio" value="no"><span class="cr1-tb-text-lg">Innovating</span><br><span class="cr1-tb-text-sm">for Social Goal</span></label>
										<label class="btn btn-default cr1-check-btn cr1-tb-color cr1-mob-tb-pd  col-sm-3 col-xs-12" id="personal"> <input type="radio" value="no"><span class="cr1-tb-text-lg">Personal</span><br><span class="cr1-tb-text-sm">needs</span></label>
                                        <g:hiddenField name="usedFor" id="usedFor"/>
						       </div>
	                       </div>
	                    </div>
	                    
	                    <div class="form-group createTitleDiv">
	                        <label class="col-sm-12 text-color">My plan is...</label>
	                        <div class="col-sm-12">
	                            <textarea class="form-control form-control-no-border text-color" name="title" rows="2" placeholder="Campaign title is the gateway to view your campaign, create an impactful and actionable title." id="campaignTitle" maxlength="55"></textarea>
	                            <label class="pull-right " id="titleLength"></label>
	                        </div>
	                    </div>
	                
	                
	                    <div class="form-group createDescDiv">
	                        <div class="col-sm-12">
	                            <textarea class="form-control form-control-no-border text-color" id="descarea" name="${FORMCONSTANTS.DESCRIPTION}" rows="2" placeholder="Campaign Description" maxlength="140"></textarea>
	                            <label class="pull-right " id="desclength"></label>
	                        </div>
	                    </div>
	            
	            <div class="text-center">
	                <button type="submit" class="btn  btn-primary btn-colors cr-bg-create-btn createsubmitbutton hidden-xs" name="button" value="" id="campaigncreatebtn"></button>
	                <button type="submit" class="btn  btn-primary btn-colors cr-bg-xs-create-btn createsubmitbutton visible-xs" name="button" value="" id="campaigncreatebtn"></button>
	            </div>
	        </g:uploadForm>
	     </div>
     </div>
</div>
<script type="text/javascript">
	var needToConfirm = true;
    window.onbeforeunload = confirmExit;
    function confirmExit()
    {
        if(needToConfirm){
        	return "You have attempted to leave this page.  If you have made any changes to the fields without clicking the Save button, your changes will be lost.  Are you sure you want to exit this page?";
        }
    }
</script>
</body>
</html>
