<%@ page import="java.text.SimpleDateFormat"%>
<g:set var="contributionService" bean="contributionService" />
<g:set var="projectService" bean="projectService" />
<g:set var="userService" bean="userService" />
<%
    def request_url=request.getRequestURL().substring(0,request.getRequestURL().indexOf("/", 8))
    def base_url = (request_url.contains('www')) ? grailsApplication.config.crowdera.BASE_URL1 : grailsApplication.config.crowdera.BASE_URL
    def user = project.user
    def username = user.username
	def projectTitle = project.title
	if (projectTitle) {
		projectTitle = projectTitle.toUpperCase(Locale.ENGLISH)
	}
	def imageUrl = project.imageUrl
	if (imageUrl) {
		imageUrl = project.imageUrl[0].getUrl()
	}
    def fbShareUrl = base_url+"/project/campaignShare?id="+project.id+"&fr="+username
   
    def fbShareUrlupdatePage = base_url+"/project/updateShare?id="+project.id+"&fr="+username
   
    def shareUrl = base_url+'/c/'+shortUrl

    def fundRaiser = userService.getCurrentUser()
    def fundRaiserName
    if (fundRaiser) {
        if (fundRaiser.email == project.beneficiary.email){
            if (project.beneficiary.lastName)
                fundRaiserName = (project.beneficiary.firstName + " " + project.beneficiary.lastName).toUpperCase()
            else 
                fundRaiserName = (project.beneficiary.firstName).toUpperCase()
        } else {
            fundRaiserName = (fundRaiser.firstName+" "+fundRaiser.lastName).toUpperCase()
        }
    }
%>
<html xmlns="http://www.w3.org/1999/xhtml" xmlns:og="http://ogp.me/ns#" xmlns:fb="https://www.facebook.com/2008/fbml">
<head>
    <title>Crowdera- ${project.title}</title>
	<meta property="og:title" content="Crowdera : ${project.title}" />
	<meta property="og:url" content="${fbShareUrl}" />
	<g:if test="${project.organizationIconUrl}">
	    <meta property="og:image" content="${project.organizationIconUrl}" />
	</g:if>
	<g:elseif test="${imageUrl}">
	     <meta property="og:image" content="${imageUrl}" />
	</g:elseif>
	<g:if test="${project.description}">
	     <meta property="og:description" content="${project.description}" />
	</g:if>
	<meta property="og:type" content="website" />
	<meta name="layout" content="main" />
	<r:require modules="projectshowjs" />
	<r:require modules="rewardjs" />
	
	<script>
        function submitCampaignShowForm(key,projectId, fr){
            $.ajax({
                type    :'post',
                url     : $("#b_url").val()+'/project/urlBuilder',
                data    : "projectId="+projectId+"&fr="+fr+"&pkey="+key,
                success : function(response){
                  $(location).attr('href', response);
                }
            }).error(function(){
            });
        }
    </script>
	
	
</head>
<body>
    <g:hiddenField id="projectamount" name="projectamount" value="${project.amount.round()}"/>
    <g:hiddenField id="payuStatus" name="payuStatus" value="${project.payuStatus}"/>
	<g:hiddenField id="b_url" name="b_url" value="${base_url}"/>
	<g:hiddenField name="fbShareUrlupdatePage" value="${fbShareUrlupdatePage}" id="fbShareUrlupdatePage"/>
	
	<div class="feducontent">
		<div class="container manage-container-page show-css">
			<g:if test="${project}">
				<div class="row">
					<g:if test="${flash.prj_mngprj_message}">
						<div class="alert alert-success" align="center">
							${flash.prj_mngprj_message}
						</div>
					</g:if>
					<g:if test="${project.rejected}">
						<div class="alert alert-info">
							<h2 class="text-center">Sorry, but this project is not
								validated by admin</h2>
						</div>
					</g:if>
					<g:if test="${flash.teamvalidationmessage}">
						<div class="alert alert-success text-center">
							${flash.teamvalidationmessage}
						</div>
					</g:if>
					<g:if test="${flash.teamdiscardedmessage}">
						<div class="alert alert-success text-center">
							${flash.teamdiscardedmessage}
						</div>
					</g:if>
					<g:if test="${flash.perkupdate}">
						<div class="alert alert-success text-center">
							${flash.perkupdate}
						</div>
					</g:if>
					<g:if test="${flash.saveEditUpdateSuccessMsg}">
					    <div class="alert alert-success text-center">
							${flash.saveEditUpdateSuccessMsg}
						</div>
					</g:if>
                    <div class="col-md-12">
                        <g:if test="${!project.validated}">
                            <div class="mange-campaigntitle-mobile">
                                <h1 class="green-heading text-center"><a href="javascript:void(0)">${projectTitle}</a></h1>
                            </div>
                        </g:if>
                        <g:else>
                            <div class="mange-campaigntitle-mobile">
                                <h1 class="green-heading text-center"><a href="javascript:void(0)">${project.title}</a></h1>
                            </div>
                        </g:else>
					</div>
					<g:if test="${fundRaiser}">
                        <div class="col-md-12 col-sm-12 col-xs-12 text-center campaignFundRaiser">
                            <h4 class="green-heading"> by ${fundRaiserName}</h4>
                        </div>
                    </g:if>
                    
                    <%-- Primary-Header--%>
                     <div class="hidden-xs navbar navbar-default manage-headers-A-one">
                       <div class="navbar-header">
                           <div class="">        
                               <a href="/" class="manage-header-logo manage-header-logoimage">
                                   <img alt="Crowdera" src="//s3.amazonaws.com/crowdera/assets/crowdera-logo.png" class="sh-safari2header-padding">
                               </a>
                           </div>
                       </div>
                       <div class="collapse navbar-collapse col-lg-8 col-sm-8 col-md-8 manage-alltabs">
                           <ul class="nav nav-pills nav-justified nav-justi sh-tabs manage-headerstabs-height">
                               <li class="active show-tabs"><span class="manage-tbs-right-borders ">
                                       <a href="#essentials" data-toggle="tab" class="show-tabs-text essentials show-all-icons-header-tabs"><span class="hidden-xs">STORY</span> 
                                       </a>
                                   </span>
                               </li>
                               <li><span class="manage-tbs-right-borders ">
                                       <a href="#projectupdates" data-toggle="tab" class="show-tabs-text projectupdates show-all-icons-header-tabs"><span class="hidden-xs">UPDATES</span> 
                                       </a>
                                       <span class="show-tabs-count hidden-xs"><g:if test="${project.projectUpdates.size() > 0}">${project.projectUpdates.size()}</g:if></span>
                                   </span>
                               </li>
                               <li><span class="manage-tbs-right-borders ">
                                       <a href="#manageTeams" data-toggle="tab" class="show-tabs-text manageTeams show-all-icons-header-tabs"><span class="hidden-xs">TEAMS</span>
                                       </a> 
                                   </span>
                               </li>
                               <li><span class="manage-tbs-right-borders ">
                                       <a href="#rewards" data-toggle="tab" class="show-tabs-text rewards show-all-icons-header-tabs"><span class="hidden-xs">PERKS</span>
                                       </a>
                                   </span>
                               </li>
                               <g:if test="${project.payuStatus}">
                                   <li><span class="manage-tbs-right-borders ">
                                           <a href="#payments" data-toggle="tab" class="show-tabs-text payments show-all-icons-header-tabs"><span class="hidden-xs">PAYMENTS</span>
                                           </a>
                                       </span>
                                   </li>
                               </g:if>
                               <li><span class="manage-tbs-right-borders ">
                                       <a href="#contributions" data-toggle="tab" class="show-tabs-text contributions show-all-icons-header-tabs"><span class="hidden-xs">CONTRIBUTIONS</span>
                                       </a> 
                                       <span class="show-tabs-count hidden-xs"><g:if test="${project.contributions.size() > 0}">${project.contributions.size()}</g:if></span>
                                   </span>
                               </li>
                               <li><span class="manage-comit-lft">
                                       <a href="#comments" data-toggle="tab" class="show-tabs-text comments show-all-icons-header-tabs"><span class="hidden-xs">COMMENTS</span>
                                       </a> 
                                   </span>
                               </li>
                           </ul>
                        </div>
                        <g:if test="${project.draft}">
                            <ul class="nav navbar-nav navbar-right col-lg-6 col-md-6 <g:if test="${project.payuStatus}">hidden-sm manage-submitapprov-india</g:if><g:else>col-sm-6 manage-submitapprove-edit</g:else>">
                                <li>
                                    <div class="submitForApprovalSectionbtn">
                                        <g:if test="${project.organizationIconUrl && project.webAddress && (project.charitableId || project.paypalEmail || project.payuEmail) && (!project.imageUrl.isEmpty()) && project.organizationName && project.beneficiary.country && (projectService.getRemainingDay(project) > 0)}">
                                            <g:form controller="project" action="saveasdraft" id="${project.id}">
                                                <button class="btn btn-block btn-primary manage-submitaprroval mange-btnsubmitapprov-size"><i class="glyphicon glyphicon-check"></i>&nbsp;SUBMIT FOR APPROVAL</button>
                                            </g:form>
                                        </g:if>
                                        <g:else>
                                            <button class="btn btn-block btn-primary manage-submitaprroval mange-btnsubmitapprov-size" id="submitForApprovalBtnright"><i class="glyphicon glyphicon-check"></i>&nbsp;SUBMIT FOR APPROVAL</button>
                                        </g:else>
                                    </div>
                                </li>
                            </ul>
                        </g:if>
                    </div>
                    
                    <%-- Primary-Header-Social-icons--%>
                     <g:if test="${project.validated}">
                         <div class="hidden-xs navbar navbar-default col-lg-12 hidden-sm manage-social-mB mange-fb-hideshow manage-tabs-hide manage-social-hidesm manage-socials-icons">
                             <div class="col-lg-6 col-lg-push-3  col-md-push-3 col-md-6 mange-social-all">
                                 <%-- Social features --%>
                                 <a class="share-mail pull-left social" href="#" data-toggle="modal" data-target="#sendmailmodal" target="_blank">
                                     <img src="///s3.amazonaws.com/crowdera/assets/0fea8e3c-7e84-4369-a5a0-451585c06492.png" class="show-email" alt="Email Share">
                                 </a>
                                 <a class="twitter-share pull-left social" target="_blank">
                                     <img src="//s3.amazonaws.com/crowdera/assets/543485b8-21d6-4144-9c30-c0e49c95c4e6.png" class="show-twitter" alt="Twitter Share">
                                 </a>
                                 <a class="social share-linkedin pull-left" href="https://www.linkedin.com/cws/share?url=${shareUrl}" onclick="javascript:window.open(this.href,'', 'menubar=no,toolbar=no,resizable=yes,scrollbars=yes,height=600,width=600');return false;">
                                     <img src="//s3.amazonaws.com/crowdera/assets/0d661ddc-4d08-4ad9-a707-cf2e22349989.png" class="show-linkedin" alt="LinkedIn Share">
                                 </a>
                                 <a class="social google-plus-share pull-left" href="https://plus.google.com/share?url=${shareUrl}" onclick="javascript:window.open(this.href,'', 'menubar=no,toolbar=no,resizable=yes,scrollbars=yes,height=600,width=600');return false;">
                                     <img src="//s3.amazonaws.com/crowdera/assets/0c536e08-376d-4965-a901-ca42a4b6c4d5.png" class="show-google" alt="Google+ Share">
                                 </a>
                                 <a href="#" data-toggle="modal" data-target="#embedTilemodal" target="_blank" class="pull-left embedIcon-manage-left social hidden-xs">
                                      <img src="//s3.amazonaws.com/crowdera/assets/75ed76bc-3275-4b00-a534-9c4a324cc04e.png" class="show-embedIcon" alt="embedicon">
                                 </a>
                                 <div class="popoverClass">
                                     <span data-title="Copy this short url and share &nbsp;&nbsp;&nbsp;" class="shortUrlglyphiconheader glyphicon glyphicon-link glyphicon-show-design glyphicon-show-link-color manage-urlshort"></span>
                                     <div class="hidden popoverConent">
                                         <button type="button" class="close">&times;</button>
                                         <p>${shareUrl}</p>
                                     </div>
                                 </div>
                             </div>
                             <div class="col-lg-6 col-md-6 col-sm-6 manage-fbheader-size">
                                 <span class="btn btn-default fbShareForLargeDevices manage-fb-color manage-fb-btn-width fbshare-header">
                                     <i class="fa fa-facebook manage-fb-padding"></i> SHARE ON FACEBOOK
                                 </span>
                             </div>
                         </div>
                     </g:if>
                     
                     <%--Tab code for whatsapp, facebook and twitter css-same-as-it-is-on-show-page-social --%>
                     <g:if test="${project.validated}">
                         <div class="visible-sm visible-xs sh-tabs-social sh-shareicons-Fixedtophead">
                             <div class="col-sm-4 col-md-4 col-xs-4 show-tabs">
                                 <a class="btn btn-block btn-social btn-facebook sh-head-fb-over show-Allsocialtabs-size fbshare-header show-whats-paddingmobile" href="#">
                                     <i class="fa fa-facebook show-tabsfooter-fb"></i> 
                                 </a>
                             </div>
                             <div class="col-sm-4 col-md-4 col-xs-4 show-tabs">
                                 <g:if test="${isDeviceMobileOrTab}">
                                     <a href="whatsapp://send?text=${shareUrl}" data-action="share/whatsapp/share" class="btn btn-block btn-social btn-facebook sh-head-fb-over shTabs-whatsapp-color show-Allsocialtabs-size show-whats-paddingmobile">
                                         <img src="//s3.amazonaws.com/crowdera/assets/show-tabs-whatsapp-icons.png" class=" show-tabsfooter-fb show-small-whatsappmobile" alt="whatsapp"> 
                                     </a>
                                 </g:if>
                                 <g:else>
                                     <a href="#" data-toggle="modal" data-target="#sendmailmodal" target="_blank" class="btn btn-block btn-social btn-facebook sh-head-fb-over shTabs-whatsapp-color show-Allsocialtabs-size show-whats-paddingmobile" >
                                         <img src="//s3.amazonaws.com/crowdera/assets/show-tabs-whatsapp-icons.png" class=" show-tabsfooter-fb show-small-whatsappmobile" alt="whatsapp"> 
                                     </a>
                                 </g:else>
                             </div>
	
                             <div class="col-sm-4 col-md-4 col-xs-4 show-tabs">
                                 <a class="btn btn-block btn-social twitter-share btn-facebook sh-head-fb-over <g:if test="${ended}">shTabs-twitter-color-b</g:if><g:else>shTabs-twitter-color</g:else> show-Allsocialtabs-size show-whats-paddingmobile" data-url="${shareUrl}" target="_blank">
                                     <i class="fa fa-fw fa-twitter show-tabsfooter-fb"></i> 
                                 </a>
                             </div>
                         </div>
                     </g:if>
                     <g:else>
                         <div class="visible-sm visible-xs sh-tabs-social sh-shareicons-Fixedtophead">
                             <div class="col-sm-4 col-md-4 col-xs-4 show-tabs">
                                 <a class="btn btn-block btn-social btn-facebook sh-head-fb-over show-Allsocialtabs-size show-pointer-not show-whats-paddingmobile">
                                     <i class="fa fa-facebook show-tabsfooter-fb"></i> 
                                 </a>
                              </div>
                              <div class="col-sm-4 col-md-4 col-xs-4 show-tabs">
                                  <g:if test="${isDeviceMobileOrTab}">
                                      <a class="btn btn-block btn-social btn-facebook sh-head-fb-over show-pointer-not shTabs-whatsapp-color show-Allsocialtabs-size show-whats-paddingmobile">
                                          <img src="//s3.amazonaws.com/crowdera/assets/show-tabs-whatsapp-icons.png" class=" show-tabsfooter-fb show-small-whatsappmobile" alt="whatsapp"> 
                                      </a>
                                  </g:if>
                                  <g:else>
                                      <a class="btn btn-block btn-social btn-facebook sh-head-fb-over show-pointer-not shTabs-whatsapp-color show-Allsocialtabs-size show-whats-paddingmobile" >
                                          <img src="//s3.amazonaws.com/crowdera/assets/show-tabs-whatsapp-icons.png" class=" show-tabsfooter-fb show-small-whatsappmobile" alt="whatsapp"> 
                                      </a>
                                  </g:else>
                              </div>

                              <div class="col-sm-4 col-md-4 col-xs-4 show-tabs">
                                  <a class="btn btn-block btn-social btn-facebook show-pointer-not sh-head-fb-over <g:if test="${ended}">shTabs-twitter-color-b</g:if><g:else>shTabs-twitter-color</g:else> show-Allsocialtabs-size show-whats-paddingmobile">
                                      <i class="fa fa-fw fa-twitter show-tabsfooter-fb"></i> 
                                  </a>
                              </div>
                         </div>
                    </g:else>              
				
                    
                    <div class="col-xs-12">
                        <div class="col-xs-12 mange-borders">
                            <ul class="nav nav-pills">
                             <li id="manage-tabs-one"></li> 
                         </ul>
                            <ul class="nav nav-pills manage-projects nav-justified mobile-justified sh-tabs nav-justi mng-safari-mobile mng-safari-tabs <g:if test="${!project.payuStatus}"> manage-bottom-top</g:if><g:else>mange-tabs-payu</g:else>">
                                <li class="active show-tabs">
                                    <span class="manage-tbs-right-borders ">
                                        <a href="#essentials" data-toggle="tab" class="show-tabs-text essentials"><span class="hidden-xs">STORY</span> 
                                            <span class="glyphicon glyphicon-leaf visible-xs show-tab-right-border"></span>
                                        </a>
                                         <span class="show-ids-header"></span>
                                    </span>
                                </li>
                                <li>
                                    <span class="manage-tbs-right-borders ">
                                        <a href="#projectupdates" data-toggle="tab" class="show-tabs-text projectupdates"><span class="hidden-xs">UPDATES</span> 
                                            <span class="glyphicon glyphicon-asterisk visible-xs"></span>
                                        </a>
                                         <span class="show-ids-header"></span>
                                        <span class="show-tabs-count hidden-xs"><g:if test="${project.projectUpdates.size() > 0}">${project.projectUpdates.size()}</g:if></span>
                                    </span>
                                </li>
                                <li>
                                    <span class="manage-tbs-right-borders ">
                                        <a href="#manageTeams" data-toggle="tab" class="show-tabs-text manageTeams"><span class="hidden-xs">TEAMS</span>
                                             <span class="fa fa-users visible-xs"></span>
                                        </a>
                                         <span class="show-ids-header"></span>
                                    </span>
                                </li>
                                <li>
                                    <span class="manage-tbs-right-borders ">
                                        <a href="#rewards" data-toggle="tab" class="show-tabs-text rewards"><span class="hidden-xs">PERKS</span>
                                            <span class="fa fa-gift fa-lg visible-xs"></span>
                                        </a>
                                         <span class="show-ids-header"></span>
                                    </span>
                                </li>
                                <g:if test="${project.payuStatus}">
                                    <li>
                                        <span class="manage-tbs-right-borders ">
                                            <a href="#payments" data-toggle="tab" class="show-tabs-text payments"><span class="hidden-xs">PAYMENTS</span>
                                                <span class="glyphicon glyphicon-credit-card visible-xs"></span>
                                            </a>
                                             <span class="show-ids-header"></span>
                                        </span>
                                    </li>
                                </g:if>
                                <li>
                                    <span class="manage-tbs-right-borders ">
                                        <a href="#contributions" data-toggle="tab" class="show-tabs-text contributions"><span class="hidden-xs">CONTRIBUTIONS</span>
                                            <span class="glyphicon glyphicon-tint visible-xs"></span>
                                        </a> 
                                        <span class="show-tabs-count hidden-xs"><g:if test="${project.contributions.size() > 0}">${project.contributions.size()}</g:if></span>
                                         <span class="show-ids-header"></span>
                                    </span>
                                </li>
                                <li>
                                    <span class="manage-comit-lft">
                                        <a href="#comments" data-toggle="tab" class="show-tabs-text comments"><span class="hidden-xs">COMMENTS</span>
                                            <span class="glyphicon glyphicon-comment visible-xs"></span>
                                        </a>
                                         <span class="show-ids-header"></span> 
                                    </span>
                                </li>
                            </ul>
                        </div>
                    </div>
                    
                    <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12 manage-Top-tabs-mobile ">
                        <!-- Tab panes -->
                        <div class="tab-content">
                            <div class="tab-pane active mange-pane-active row" id="essentials">
                                <g:render template="/project/manageproject/essentials" />
                            </div>
                            <div class="tab-pane mange-pane-active row" id="projectupdates">
                                <g:render template="/project/manageproject/projectupdates" />
                            </div>
                            <div class="tab-pane mange-pane-active" id="manageTeams">
                                <g:render template="/project/manageproject/manageteam" />
                            </div>
                            <div class="tab-pane mange-pane-active" id="rewards">
                                <g:render template="/project/manageproject/rewards" />
                            </div>
                            <g:if test="${project.payuStatus}">
                                <div class="tab-pane mange-pane-active" id="payments">
                                    <g:render template="/project/manageproject/payments"/>
                                </div>
                            </g:if>
                            <div class="tab-pane mange-pane-active" id="contributions">
                                <g:render template="/project/manageproject/contributions" />
                            </div>
                            <div class="tab-pane mange-pane-active" id="comments">
                                <g:render template="/project/manageproject/comments" />
                            </div>
                        </div>

                    </div>
                </div>
            </g:if>
            <g:else>
                <h1>Project not found</h1>
                <div class="alert alert-danger">Oh snap! Looks like that
                    project doesn't exist.</div>
            </g:else>
        </div>
    </div>
</body>
</html>
             