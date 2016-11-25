<g:set var="projectService" bean="projectService"/>
<%
	def country_code = projectService.getCountryCodeForCurrentEnv(request)
    def request_url=request.getRequestURL().substring(0,request.getRequestURL().indexOf("/", 8))
    def base_url = (request_url.contains('www')) ? grailsApplication.config.crowdera.BASE_URL1 : grailsApplication.config.crowdera.BASE_URL 
	def fbShareUrl = base_url +country_code +"/campaign/create"
	
    boolean isIndianCampaign = false
    if (currentEnv == 'test' || currentEnv == 'staging' || currentEnv == 'development' || currentEnv == 'production') {
		if(country_code == 'in'){
			isIndianCampaign = true
		}
    }
%>
<html>
<head>
    <title>Crowdera- Create campaign</title>
    <link rel="canonical" href="${base_url}/campaign/create"/>
    <meta name="layout" content="main"/>
    <meta property="og:site_name" content="Crowdera"/>
    <meta property="og:type" content="Crowdera:Campaign"/>
    <meta property="og:title" content="Create Campaign"/>
    <meta property="og:description" content="Crowdfunding is a practical and inspiring way to support the fundraising needs of a cause or community. Do some good. Create a Campaign Today!"/>
    <meta property="og:image" content="//s3.amazonaws.com/crowdera/assets/crowdera-logo.png"/>
    <meta property="og:url" content="${fbShareUrl}"/>
    
    <r:require modules="projectcreatejs" />
</head>
<body>
    <input type="hidden" name="url" value="${currentEnv}" id="currentEnv"/>
    
    <g:hiddenField name="vanityUrlStatus" id="vanityUrlStatus" value="true"/>
    <g:hiddenField name="baseUrl" value="${base_url}" id="b_url"/>
    <g:hiddenField name="isIndianCampaign" value="${isIndianCampaign}" id="isIndianCampaign"/>
    <g:hiddenField name="titleUniqueStatus" value="true" id="titleUniqueStatus"/>
    
    <div class="cr1-header-indx1">
        <h1 class="text-center cr1-headertitle-indx1">Create Campaign</h1>
        <h3 class="text-center cr1-subheading-indx1">Raise money for what matters to you</h3>
    </div>
    
    <div class="bg-color">
        <div class="container footer-container" id="campaigncreate">
            <g:uploadForm class="form-horizontal cr-top-spaces" controller="project" action="saveCampaign">
            
                <g:hiddenField name="fundsRecievedBy" value="" id="fundsRecievedBy"/>
                
                <div class="list-group campaign-entities">
                    <div class="col-sm-12 col-r-0 margin-bottom-20">
	                    <div class="col-sm-6 col-lr-0">
					        <a href="#" class="list-group-item text-center" data-fundraisedby="NON-PROFIT">
					            <label><b>Nonprofit</b></label>
                                <label>
	                                Crowdera helps you to raise money for charity and make a real-life impact. 
	                                You can run or organize a marathon, mobilize a large team of volunteers to raise for you and more
                                </label>
                                <label>
                                    <b>funds go to nonprofit</b>
                                </label>
					        </a>
				        </div>
				        <div class="col-sm-6 col-lr-0">
					        <a href="#" class="list-group-item text-center" data-fundraisedby="INDIVIDUAL">
						        <label><b>Individual</b></label>
						        <label>
		                            You can use Crowdera for funding anyone's creative passion, personal needs, 
		                            startup journey, impact & innovation driven projects, literally anything that matters to you.
		                        </label>
		                        <label>
	                               <b>funds directly go to you</b>
	                            </label>
					        </a>
				        </div>
			        </div>
			    </div>
                
                <g:hiddenField name="partnerInviteCode" value="${partnerInviteCode}"/>
                <g:hiddenField name="country_code" value="${country_code}"/>
                
                <%--Desktop code --%>
                <div class="form-group">
                    <%--Mobile-code --%>
                    <div class="form-group cr2-form-need visible-xs">
                        <div class="col-lg-3 col-md-3 col-sm-3 col-xs-7">
                            <span class="col-sm-12 cr-padding-index1">Fundraising Goal:</span>
                            <div class="cr-tops">
                            	<g:if test="${country_code == 'in'}">
                            		<span class="i-currency-label-indx1 fa fa-inr cr1-inr-indx1"></span>
                            	</g:if>
                            	<g:elseif test="${country_code == 'us'}">
                               		 <span class="i-currency-label-indx1">$</span>
                            	</g:elseif>
	                            
                                <input class="form-control form-control-no-border-amt cr-amt-indx1" name="amount1" id="amount2"> 
                                <span id="errormsg1"></span>
                            </div>
                        </div>
                        <g:if test="${country_code == 'us'}">
                            <div class="col-lg-1 col-md-1 col-sm-1 amount-popover cr1-mobile-padding-amt col-xs-1">
                                <img class="cr1-amountInfo-img cr1-guidence-us" src="//s3.amazonaws.com/crowdera/assets/Information-Icon.png" alt="Information icon">
                            </div>
                        </g:if>
                        <g:elseif test="${country_code == 'in'}">
                            <div class="col-lg-1 col-md-1 col-sm-1 amount-popover cr1-mobile-padding-amt col-xs-1">
                                <img class="cr1-amountInfo-img cr1-guidence-indo" src="//s3.amazonaws.com/crowdera/assets/Information-Icon.png" alt="Information icon">
                            </div>
                        </g:elseif>
                        <div class="col-lg-6 col-md-6 col-sm-6 col-xs-4 cr1-in-days">
                            <span class="col-lg-12 col-sm-12 col-md-12 cr-padding-index1 cr1-mobile">In Days</span>
                            <div class="cr1-font-list">
                                <g:select class="selectpicker cr-drop-color" name="days1" from="${inDays}" optionKey="value" optionValue="value" />
                            </div> 
                        </div>
                    </div>
                
                </div>
                
                <div class="form-group cr2-form-need hidden-xs">
                    <div class="col-lg-3 col-md-3 col-sm-3 col-xs-7">
                        <span class="col-sm-12 cr-padding-index1">Fundraising Goal:</span>
                        <div class="cr-tops">
                       		<g:if test="${country_code == 'in'}">
                            	<span class="i-currency-label-indx1 fa fa-inr cr1-inr-indx1"></span>
                            </g:if>
                            <g:elseif test="${country_code == 'us'}">
                            	<span class="i-currency-label-indx1">$</span>
                        	</g:elseif>  
                            <input class="form-control form-control-no-border-amt cr-amt-indx1" name="amount" id="amount3"> 
                            <span id="errormsg2"></span>
                        </div>
                    </div>
                    <g:if test="${country_code == 'us'}">
                        <div class="col-lg-1 col-md-1 col-sm-1 amount-popover cr1-mobile-padding-amt col-xs-1">
                            <img class="cr1-amountInfo-img amountInfo-img" src="//s3.amazonaws.com/crowdera/assets/Information-Icon.png" alt="Information icon">
                        </div>
                    </g:if>
                    <g:elseif test="${country_code == 'in'}">
                        <div class="col-lg-1 col-md-1 col-sm-1 amount-popover cr1-mobile-padding-amt col-xs-1">
                            <img class="cr1-amountInfo-img amountInfoInd-img" src="//s3.amazonaws.com/crowdera/assets/Information-Icon.png" alt="Information icon">
                        </div>
                    </g:elseif>
                    
                    <div class="col-lg-2 col-md-2 col-sm-2 col-xs-4 cr1-in-days">
                        <span class="col-lg-12 col-sm-12 col-md-12 cr-padding-index1 cr1-mobile">In Days</span>
                        <div class="cr1-font-list">
                            <g:select class="selectpicker cr-drop-color" name="${FORMCONSTANTS.DAYS}" from="${inDays}" optionKey="key" optionValue="value" />
                        </div> 
                    </div>
                    
                    <div class="col-lg-6 col-md-6 col-sm-6 campaignCustomVanityUrl">
	                   <label class="col-sm-12 text-color cr1-vanity-label-indx1 cr1-vanity-label-indx1 hidden-xs cr1-tabs-padding">My campaign web address</label>
	                   <label class="col-sm-12 text-color cr1-vanity-label-indx1 cr1-vanity-label-indx1 visible-xs">
	                       <g:if test="${currentEnv == 'testIndia' || currentEnv == 'stagingIndia' || currentEnv == 'prodIndia'}">
	                            crowdera.in/campaigns/
	                       </g:if>
	                       <g:elseif test="${currentEnv == 'staging'}">
	                            staging.gocrowdera.com/campaigns/
	                       </g:elseif>
	                       <g:else>
	                            gocrowdera.com/campaigns/
	                       </g:else>
	                   </label>
	                   <div class="col-lg-9 col-md-9 col-sm-9 col-xs-12 cr1-mobile-indx1 form-group">
	                       <div class="cr1-vanityUrl-indx1 cr1-url-lft hidden-xs">
	                           <g:if test="${currentEnv == 'testIndia' || currentEnv == 'stagingIndia' || currentEnv == 'prodIndia'}">
	                               crowdera.in/campaigns/
	                           </g:if>
	                           <g:elseif test="${currentEnv == 'staging'}">
	                                    staging.gocrowdera.com/campaigns/
	                             </g:elseif>
	                           <g:else>
	                               gocrowdera.com/campaigns/
	                           </g:else>
	                       </div>
	                       <input class="form-control form-control-no-border cr1-indx-mobile cr-placeholder cr-chrome-place text-color cr-marg-mobile customVanityUrlProd cr1-vanitypadding-in-co cr1-paddings-lft" name="customVanityUrl" id="customVanityUrl" maxlength="60" placeholder="Your-Campaign-Web-Url">
	                   </div>
	                   <div class="clear" id="vanityUrlClear"></div>
	                   <label class="pull-right" id="vanityUrlLength"></label>
	                </div>
                </div>
                
	            <div class="createTitleDiv col-lg-4 col-md-4 col-sm-4 cr1-indx1-mobileTpadding">
	                <label class="col-sm-12 text-color cr-padding-index1 cr1-myplane-padding">Fundraiser Title:</label>
	                <div class="col-sm-12 cr-padding-index1 cr1-width-inputs form-group">
	                    <input class="form-control form-control-no-border cr-myplan-indx1 text-color campaignTitle" name="${FORMCONSTANTS.TITLE}" placeholder="Create an impactful and actionable title. Helps donors find campaign." id="campaignTitle" maxlength="60">
                        <label class="pull-right " id="titleLength"></label>
	                </div>
	           </div>
	           
	           <div class="createTitleDiv col-lg-4 col-md-4 col-sm-4 col-xs-12 cr1-indx1-mobileTpadding">
                    <label class="col-sm-12 text-color cr-padding-index1 cr1-myplane-padding col-r-0">I am Based in:</label>
                    <div class="col-sm-12  form-group col-lr-0">
                        <select name="country" id="country" class="selectOption">
                            <option value="">Select One</option>
                            <g:each in="${countryList}" var="countryObj">
                                <option value="${countryObj.key}">${countryObj.value}</option>
                            </g:each>
                        </select>
                    </div>
               </div>
               
	           <div class="createTitleDiv col-lg-4 col-md-4 col-sm-4 col-xs-12 cr1-indx1-mobileTpadding col-lr-0">
                    <label class="col-sm-12 text-color cr-padding-index1 cr1-myplane-padding col-r-0">Fundraiser Category:</label>
                    <div class="col-sm-12  form-group col-lr-0">
                        <select name="category" id="category" class="selectOption">
                            <option value="">Select One</option>
                            <g:each in="${categoryOptions}" var="category">
                                <option value="${category.key}">${category.value}</option>
                            </g:each>
                        </select>
                    </div>
               </div>
               
                <div class="clear"></div><br>

                <div class="form-group createDescDiv">
                    <div class="col-sm-12 cr1-descriptions-indx1 col-r-0">
                        <textarea class="form-control form-control-no-border text-color" id="descarea" name="${FORMCONSTANTS.DESCRIPTION}" rows="2" placeholder="Campaign Description" maxlength="140"></textarea>
                        <label class="pull-right " id="desclength"></label>
                    </div>
                </div>
                <div class="text-center">
                    <button type="submit" class="btn  btn-default btn-colors cr1-indx1-bg-create-btn createsubmitbutton" name="button" id="campaigncreatebtn">Create Now</button>
                </div>
            </g:uploadForm>
        </div>
    </div>
    <script type="text/javascript">
	     var needToConfirm = true;
         window.onbeforeunload = confirmExit;
         function confirmExit() {
             if(needToConfirm){
        	     return "You have attempted to leave this page.  If you have made any changes to the fields without clicking the Save button, your changes will be lost.  Are you sure you want to exit this page?";
             }
         }
    </script>
</body>
</html>
