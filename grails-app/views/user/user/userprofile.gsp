<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1"/>
<meta name="layout" content="main"/>
 <r:require module="timelinecss"/>
   <r:require modules="userjs"/>
</head>
<body>
  <div class="feducontent body bg-color">
  	<div class="container  feedback-container " >
  		<div class="row TW-usrPrfl-header bg-color-white ">
  			<g:if test="${page}">
  				<div class="userprofile-back"><a href="/user/dashboard" >Back</a></div>
  			</g:if>
  			<div class="col-lg-3 col-sm-3 bg-color-white">
                    <g:if test="${user.userImageUrl}">
                        <div id="userImage" class="TW-userprofile-img">
                            <a id="userprofileImage">
                                <img src="${user.userImageUrl}" alt="avatar" class="center-usrprfl-img">
                            </a>
                            <div class="userprofile-caption center-usrprfl-img">
            					<p>${username}</p>
        					</div>
                        </div>
                    </g:if>
                    <g:else>
                        <div id="userDefaultImage" class="TW-userprofile-img">
                            <a id="userprofileImage-dflt">
                                <img alt="Default image" src="https://s3.amazonaws.com/crowdera/assets/profile_image.jpg" class="center-usrprfl-img">
                            </a>
                            <div class="userprofile-caption center-usrprfl-img">
            					<p>${username}</p>
        					</div>
                        </div>
                    </g:else>
  			</div>
			<div class="col-lg-9 col-sm-9">
				<div class="row">
					<div class="col-lg-4 col-md-4 col-sm-4 col-xs-12">
				    	<div class="panel panel-info userprofile-panel-border">
            				<div class="panel-heading TW-usrprfl-heading">
                				<div class="row">
                    				<div class="col-xs-2">
                        				<i class="fa fa-tint fa-2x"></i>
                    				</div>
                    				<div class="col-xs-9 text-right">
                                 		<p class="usr-prfl-amt">
                                 			<g:if test="${environment=='testIndia' || environment=='stagingIndia' || environment=='prodIndia'}">
                                   				<span class="fa fa-inr"></span>
                              				</g:if>
                              				<g:else>$</g:else>
                                 			${fundraised.round()}
                                 		</p>
                    				</div>
                				</div>
            				</div>
            				<div class="panel-footer TW-userprofile-panel-text-Size">
                				Total raised
            				</div>
        				</div>
		            </div>
				    <div class="col-lg-4 col-md-4 col-sm-4 col-xs-12">
				    	<div class="panel panel-info userprofile-panel-border">
            				<div class="panel-heading TW-usrprfl-heading">
                				<div class="row">
                    				<div class="col-xs-2">
                        				<i class="fa fa-tint fa-2x"></i>
                    				</div>
                    				<div class="col-xs-9 text-right">
                                 		<p class="usr-prfl-amt">
                                 			<g:if test="${environment=='testIndia' || environment=='stagingIndia' || environment=='prodIndia'}">
                                   				<span class="fa fa-inr"></span>
                              				</g:if>
                              				<g:else>$</g:else>
                                 			${userContribution}
                                 		</p>
                    				</div>
                				</div>
            				</div>
            				<div class="panel-footer TW-userprofile-panel-text-Size">
                				Total contributions
            				</div>
        				</div>
		            </div>
		            <div class="col-lg-4 col-md-4 col-sm-4 col-xs-12">
				    	<div class="panel panel-info userprofile-panel-border">
            				<div class="panel-heading TW-usrprfl-heading">
                				<div class="row">
                    				<div class="col-xs-2">
                        				<i class="fa fa-heart fa-2x"></i>
                    				</div>
                    				<div class="col-xs-9 text-right">
                                 		<p class="usr-prfl-amt">${supporters}</p>
                    				</div>
                				</div>
            				</div>
            				<div class="panel-footer TW-userprofile-panel-text-Size">
                				Supported campaigns
            				</div>
        				</div>
		            </div>
				</div>
			</div>
  		</div>
  		<div class="row TW-user-tabs bg-color-white">
  			<div class="col-lg-12">
  				
                              <ul class="nav nav-tabs nav-justified">
                                  <li class="TW-userTimeline active" id="TW-usrPrfl-li">
                                      <a data-toggle="tab" href="#timeline">
                                          <i class="icon-home"></i>
                                         Timeline
                                      </a>
                                  </li>
                                  <li class="TW-userCamapaign" id="TW-usrPrfl-li">
                                      <a data-toggle="tab" href="#campaigns">
                                          <i class="icon-envelope"></i>
                                          Campaign Supported
                                      </a>
                                  </li>
                                  <li class="TW-userContribution" id="TW-usrPrfl-li">
                                      <a data-toggle="tab" href="#contribution">
                                          <i class="icon-envelope"></i>
                                          Contribution
                                      </a>
                                  </li>
                              </ul>
                     <section class="panel">
                          <div class="panel-body">
                              <div class="tab-content">
                              	<!-- user timeline -->
                                  <div id="timeline" class="tab-pane active">
                                    <div class="row">
            							<div class="col-md-12">
               								<g:render template="/user/user/usertimeline"></g:render>
            							</div>
	        						</div>
                                  </div>
                                  <!-- campaigns -->
                                  <div id="campaigns" class="tab-pane">
                                    <div class="row">
            							<div class="col-md-12">
               								<g:render template="/user/user/usercampaigns"></g:render>
            							</div>
	        						</div>
                                  </div>
                                   <!-- Contribution -->
                              	  <div id="contribution" class="tab-pane">
                              	  	<div class="row">
            							<div class="col-md-12">
               								<g:render template="/user/user/usercontributions"></g:render>
            							</div>
	        						</div>
                              	  </div>
                              	   <!-- Shares -->
<%--                              	  <div id="shares" class="tab-pane">--%>
<%--                              	  	<div class="row">--%>
<%--            							<div class="col-md-12">--%>
<%--               								<g:render template="/user/user/usershares"></g:render>--%>
<%--            							</div>--%>
<%--	        						</div>--%>
<%--                              	  </div>--%>
                              </div>
                          </div>
                      </section>
  			</div>
  			
  		</div>
  	</div>	  
  </div>
</body>
</html>