<g:set var="userService" bean="userService"/>
<%
    def userCommunities = userService.getCommunitiesUserIn()
    def request_url=request.getRequestURL().substring(0,request.getRequestURL().indexOf("/", 8))
    def base_url = (request_url.contains('www')) ? grailsApplication.config.crowdera.BASE_URL1 : grailsApplication.config.crowdera.BASE_URL
%>
<html>
<head>
    <meta name="layout" content="main" />
    <r:require modules="timelinecss, bootstrapsocialcss"/>
    <r:require modules="userjs"/>
</head>
<body>
<div class="feducontent">
    <g:if test="${user.email == 'campaignadmin@crowdera.co'}">
        <div class="container">
            <g:hiddenField name='currentEnv' value='${environment}' id='currentEnv'/>
            <g:hiddenField name='baseUrl' value='${base_url}' id='baseUrl'/>
            <div class="pull-right dashboard-sortByOptions" id="dashboard-sortByOptions">
                <g:select class="selectpicker text-center" name="sortByOptions" id="sortByOptions" from="${sortByOptions}" optionKey="value" optionValue="value" value="Pending" onchange="campaignsort()"/>
            </div>
            <div class="pull-right dashboard-sortByOptions">
                <g:if test="${environment == 'testIndia' || environment == 'stagingIndia' || environment == 'prodIndia'}">
                    <g:select class="selectpicker text-center" name="countryOpts" id="countryOpts" from="${countryOpts}" optionKey="value" optionValue="value" value="India" onchange="campaignsortByCountry()"/>
                </g:if>
                <g:else>
                    <g:select class="selectpicker text-center" name="countryOpts" id="countryOpts" from="${countryOpts}" optionKey="value" optionValue="value" value="USA" onchange="campaignsortByCountry()"/>
                </g:else>
            </div>
            <div class="clear"></div>
            <h2 class="text-center">Crowdera Admin</h2>
            <g:if test="${flash.user_message}">
                <div class="alert alert-success" align="center">
                    ${flash.user_message}
                </div>
            </g:if>
            <div class="row">
                <div class="col-md-12">
                    <ul class="nav nav-tabs nav-justified user-dashboard-style">
                        <li <g:if test="${activeTab == 'myprojects'}">class="active"</g:if>><a href="#myprojects" data-toggle="tab">
                            <span class="glyphicon glyphicon-leaf"></span><span class="hidden-xs"> My Campaigns
                        </span></a></li>
                        <li><a href="#my-contributions" data-toggle="tab">
                            <span class="glyphicon glyphicon-tint"></span><span class="hidden-xs"> My Contributions
                        </span></a></li>
                        <li <g:if test="${activeTab == 'account-settings'}">class="active"</g:if>><a href="#account-settings" data-toggle="tab">
                            <span class="fa fa-info-circle"></span><span class="hidden-xs"> My Profile
                        </span></a></li>
                        <g:if test="${userService.isCommunityManager()}">
                            <li><a href="#manage-community" data-toggle="tab">
                                <i class="fa fa-users"></i> Manage Community
                            </a></li>
                        </g:if>
                        <g:if test="${userCommunities}">
                            <li><a href="#my-community" data-toggle="tab">
                                <i class="fa fa-users"></i> My Community
                            </a></li>
                        </g:if>
                    </ul>

                    <!-- Tab panes -->
                    <div class="tab-content">
                        <div class="tab-pane <g:if test="${activeTab == 'myprojects'}">active</g:if>" id="myprojects">
                            <g:render template="user/myprojects"/>
                        </div>

                        <div class="tab-pane <g:if test="${activeTab == 'account-settings'}">active</g:if>" id="account-settings">
                            <g:render template="common/accountsettings"/>
                        </div>

                        <div class="tab-pane" id="my-contributions">
                            <g:render template="user/mycontributions"/>
                        </div>

                        <g:if test="${userService.isCommunityManager()}">
                            <div class="tab-pane" id="manage-community">
                                You are a community manager. Please go to <g:link controller="community" action="manage">Manage Communities</g:link>
                            </div>
                        </g:if>
                        <g:if test="${userCommunities}">
                            <div class="tab-pane" id="my-community">
                                <g:each in="${userCommunities}" var="community">
                                    <div class="panel panel-default">
                                        <div class="panel-heading">${community.title}</div>
                                        <div class="panel-body">
                                            <dl class="dl-horizontal">
                                                <dt>Description:</dt>
                                                <dd>${community.description}</dd>
                                                <dt>Manager:</dt>
                                                <dd>${userService.getFriendlyFullName(community.manager)}</dd>
                                                <dt>Community since:</dt>
                                                <dd>
                                                    <g:formatDate date="${community.dateCreated}" type="date" style="MEDIUM"/>
                                                </dd>
                                            </dl>
                                        </div>
                                    </div>
                                </g:each>
                            </div>
                        </g:if>

                     </div>
                 </div>
             </div>
         </div>
    </g:if>
    <g:else>
        <g:hiddenField name='currentEnv' value='${environment}' id='currentEnv'/>
        <g:if test="${activeTab == 'campaigns'}">
            <div class="my-campaign-heading text-center hidden-xs"><h1><b>My Campaigns</b></h1></div>
        </g:if>
        <g:elseif test="${activeTab == 'contributions'}">
            <div class="my-campaign-heading text-center hidden-xs"><h1><b>Campaigns Supported</b></h1></div>
        </g:elseif>
        
        <div class="container newUserdashboard dashboard-container">
            <div class="influencediv col-md-2 col-lg-2 col-sm-2 col-xs-6">
                <div class="updateprofilediv" class="blacknwhite">
                    <g:if test="${user.userImageUrl}">
                        <div id="userImageEditDeleteIcon">
                            <a id="userprofileavatar">
                                <img src="${user.userImageUrl}" alt="avatar">
                            </a>
                            <div class="userprofileeditimage">
                                <img src="//s3.amazonaws.com/crowdera/assets/userprofileedit.png" alt="edit icon">
                            </div>
                        </div>
                        <g:uploadForm controller="user" action="edit_avatar" id="${user.id}">
                            <button class="btn btn-primary btn-sm hidden" type="button" id="editavatarbutton">Edit Avatar</button>
                            <input class="hid-input-type-file hidden" type="file" name="profile" id="editavatar" accept="image/*"/>
                            <input type="submit" class="hidden buttons" value="Upload" id="editbutton"/>
                            <div class="clear"></div>
                            <label class="docfile-orglogo-css" id="editProfileImg">Please select image file only.</label>
                            <label class="docfile-orglogo-css" id="editProfilesize">The file you are attempting to upload is larger than the permitted size of 3MB.</label>
                        </g:uploadForm>
                    </g:if>
                    <g:else>
                        <div id="userAvatarUploadIcon">
                            <a id="useravatar">
                                <img class="dummyprofileimage" src="https://s3.amazonaws.com/crowdera/assets/profile_image.jpg" alt="' '">
                            </a>
                            <div class="defaultprofileimage">
                                <img class="plus-icon-over" src="https://s3.amazonaws.com/crowdera/assets/plus-icon-over.png" alt="avatar">
                            </div>
                        </div>
                        <g:uploadForm controller="user" action="upload_avatar" id="${user.id}">
                            <input class="hid-input-type-file hidden" type="file" name="avatar" id="avatar" accept="image/*"/>
                            <input type="submit" class="hidden buttons" value="Upload" id="uploadbutton"/>
                            <label class="docfile-orglogo-css" id="uploadProfileImg">Please select image file only.</label>
                            <label class="docfile-orglogo-css" id="uploadProfilesize">The file you are attempting to upload is larger than the permitted size of 3MB.</label>
                        </g:uploadForm>
                    </g:else>
                    <div class="user-information-bio text-center">
                        <b>${user.firstName}</b>
                        <g:if test="${user.biography}"> 
                            <div class="user-biography hidden-xs">${user.biography}</div>
                        </g:if>
                    </div>
                </div>
                
                <div class="connectsection hidden-xs">
                    <g:if test="${activeTab != 'myprojects' && activeTab != 'campaigns' && activeTab != 'account-settings'}">
                        <a href="/user/campaigns" class="campaigndashboardtab btn btn-primary btn-md hidden-xs">My Campaigns</a>
                    </g:if>
                    <g:if test="${activeTab != 'myprojects' && activeTab != 'contributions' && activeTab != 'account-settings'}">
                        <a href="/user/contributions" class="contributiondashboardtab btn btn-primary btn-md hidden-sm hidden-xs">Campaigns Supported</a>
                        <a href="/user/contributions" class="contributiondashboardtab btn btn-primary btn-md visible-sm">Campaigns<br>Supported</a>
                    </g:if>
                    <g:if test="${activeTab != 'editUserInfo'}">
                        <a href="/user/edit-userInfo" class="dashboardtabheading btn btn-primary btn-md btn-block">Edit User Info</a>
                   </g:if>
                   <div>
                       <g:link controller="user" action="userActivity1" id="${user.id}" class="dashboardtabheading btn btn-primary btn-md btn-block">User Profile</g:link>
                   </div>
                    
                    <a href="#" class="btn btn-block btn-social social-button btn-facebook hidden"><i class="fa fa-facebook"></i> Connect</a>
                    <a href="#" class="btn btn-block btn-social social-button btn-linkedin hidden"><i class="fa fa-linkedin"></i> Connect</a>
                    <a href="#" class="btn btn-block btn-social social-button btn-google-plus hidden"><i class="fa fa-google-plus"></i> Connect</a>
                    <a href="#" class="hidden"><img src="//s3.amazonaws.com/crowdera/assets/dashboardpaypal.png" alt="paypal"></a>
                </div>
                
                <div class="connectsection hidden-md hidden-lg hidden-xs hidden-sm">
                    <a href="#" class="btn btn-block btn-social social-button btn-facebook"><i class="fa fa-facebook"></i> Connect</a>
                    <a href="#" class="btn btn-block btn-social social-button btn-linkedin"><i class="fa fa-linkedin"></i> Connect</a>
                    <a href="#" class="btn btn-block btn-social social-button btn-google-plus"><i class="fa fa-google-plus"></i> Connect</a>
                    <a href="#" class=" hidden"><img src="//s3.amazonaws.com/crowdera/assets/dashboardpaypal.png" alt="paypal"></a>
                </div>
            </div>
            
            <div class="influencediv influencediv-xs col-md-2 col-lg-2 col-sm-6 col-xs-6 hidden-sm hidden-lg hidden-md">
                <div class="amountsection">
                    <span class="amountSection-Font"><g:if test="${environment == 'prodIndia' || environment == 'stagingIndia' || environment == 'testIndia'}"><span class="fa fa-inr"></span>${fundRaised.round()}</g:if><g:else>$${fundRaised.round()}</g:else></span>
                    <br/> 
                    <span>Raised</span>
                </div>
               <div class="amountsection">
                    <span class="amountSection-Font"><g:if test="${environment == 'prodIndia' || environment == 'stagingIndia' || environment == 'testIndia'}"><span class="fa fa-inr"></span>${contributedAmount.round() * multiplier}</g:if><g:else>$${contributedAmount.round()}</g:else></span>
                    <br/>
                    <span>Contributed</span>
               </div>
            </div>
            
            <div class="clear visible-xs"></div>
            <g:if test="${user.biography}">
                <div class="biography-mobile visible-xs">
                    ${user.biography}
                </div>
            </g:if>
            
            <div class="dashboard-mobile-section visible-xs">
                <div class="col-xs-6">
                    <a href="/user/campaigns" class="mob-campaigns-btn btn btn-primary text-center">My <br>Campaigns</a>
                </div>
                <div class="col-xs-6">
                    <a href="/user/contributions" class="mob-campaigns-btn btn btn-primary text-center">Campaigns <br>Supported</a>
                </div>
                <div class="col-xs-6">
                    <a href="/user/edit-userInfo" class="mob-campaigns-btn btn btn-primary">Edit <br> User Info</a>
                </div>
                <div class="col-xs-6">
                    <a class="btn btn-primary amountsectionfbicon">
                        <span class="col-xs-12">
                            <img alt="fbicon" src="//s3.amazonaws.com/crowdera/assets/dashboard-fb-icon.png">
                        </span>
                        <span class="col-xs-12">
                            Do More Good
                        </span>
                    </a>
                </div>
                <div class="col-xs-6">
                    <g:link controller="user" action="userActivity1" id="${user.id}" class="mob-campaigns-btn btn btn-primary">User Profile</g:link>
                </div>
            </div>
            
            <div class="col-desktop-padding col-md-8 col-lg-8 col-sm-8 col-xs-12 text-center userdashboardcontainer">
                <g:if test="${activeTab == 'campaigns'}">
                    <div class="my-campaign-heading text-center visible-xs"><h3><b>My Campaigns</b></h3></div>
                    <div id="userDashboardcampaigns">
                        <g:render template="user/myprojects" model="['dashboard': 'dashboard', 'activeTab': activeTab]"/>
                    </div>
                </g:if>
                <g:elseif test="${activeTab == 'contributions'}">
                    <div class="my-campaign-heading text-center visible-xs"><h3><b>Campaigns Supported</b></h3></div>
                    <div id="userDashboardcontributions">
                        <g:render template="/user/user/dashboardcontributiontile" model="['activeTab': activeTab]"></g:render>
                    </div>
                </g:elseif>
                <g:elseif test="${activeTab == 'editUserInfo'}">
                    <div class="col-lg-12">
                       <g:render template="user/userprofile" model="['userprofile': 'userprofile']"/>
                    </div>
                </g:elseif>
                <g:else>
                    <div class="col-desktop-padding-right col-lg-offset-1 col-md-offset-1 col-lg-5 col-md-5 col-sm-6 col-xs-12">
                        <a href="/user/campaigns" class="dashboardtab btn btn-primary btn-md hidden-xs">My Campaigns</a>
                        <div class="my-campaign-heading text-center visible-xs"><h3><b>My Campaigns</b></h3></div>
                        <div id="userDashboardcampaigns">
                            <g:render template="user/myprojects" model="['dashboard': 'dashboard']"/>
                        </div>
                        <g:if test="${projects.size() > 2}">
                            <a href="/user/campaigns" class="show-more-campaign-btn btn btn-primary btn-md">Show More</a>
                        </g:if>
                    </div>
                    <div class="col-desktop-padding-left col-lg-5 col-md-5 col-sm-6 col-xs-12 hidden-xs">
                        <a href="/user/contributions" class="dashboardtab btn btn-primary btn-md">Campaigns Supported</a>
                        <div id="userDashboardcontributions">
                           <g:render template="/user/user/dashboardcontributiontile"></g:render>
                        </div>
                        <g:if test="${contributions.size() > 2}">
                            <a href="/user/contributions" class="show-more-campaign-btn btn btn-primary btn-md">Show More</a>
                        </g:if>
                    </div>
                </g:else>
            </div>
            
            <div class="influencediv col-md-2 col-lg-2 col-sm-2 hidden-xs">
                <div class="givinginfluence text-center">Giving Influence</div>
                <div class="amountsection">
                    <span class="amountSection-Font"><g:if test="${environment == 'prodIndia' || environment == 'stagingIndia' || environment == 'testIndia'}"><span class="fa fa-inr"></span>${fundRaised.round()}</g:if><g:else>$${fundRaised.round()}</g:else></span>
                    <br/> 
                    <span>Raised</span>
               </div>
               <div class="amountsection">
                    <span class="amountSection-Font"><g:if test="${environment == 'prodIndia' || environment == 'stagingIndia' || environment == 'testIndia'}"><span class="fa fa-inr"></span>${contributedAmount.round() * multiplier}</g:if><g:else>$${contributedAmount.round()}</g:else></span>
                    <br/>
                    <span>Contributed</span>
                </div>
                <a class="btn btn-primary amountsectionfbicon">
                    <span class="col-md-2 col-sm-2">
                        <img alt="fbicon" src="//s3.amazonaws.com/crowdera/assets/dashboard-fb-icon.png">
                    </span>
                    <span class="col-md-9 col-sm-9">
                       <span>Do More</span><div class="clear"></div><span>Good</span>
                    </span>
                </a>
            </div>
        </div>
    </g:else>
</div>
</body>
</html>
