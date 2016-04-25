<g:set var="userService" bean="userService"/>
<%
    def userCommunities = userService.getCommunitiesUserIn()
    def request_url=request.getRequestURL().substring(0,request.getRequestURL().indexOf("/", 8))
    def base_url = (request_url.contains('www')) ? grailsApplication.config.crowdera.BASE_URL1 : grailsApplication.config.crowdera.BASE_URL
%>
<html>
<head>
    <title>Crowdera- Dashboard</title>
    <meta name="layout" content="main" />
    <r:require modules="timelinecss, bootstrapsocialcss"/>
    <r:require modules="userjs"/>
</head>
<body>
<g:if test="${user?.email == 'campaignadmin@crowdera.co'}">
    <div class="feducontent">
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
    </div>
</g:if>
<g:else>
    <div class="partner-dashboard user-dashboard" id="wrapper">
        <g:hiddenField name='currentEnv' value='${environment}' id='currentEnv'/>
        <g:hiddenField name='baseUrl' value='${base_url}' id='baseUrl'/>
        
        <div class="navbar navbar-default navbar-fixed-top visible-xs" id="partner-sec-header">
            <div class="navbar-header user-dashboard-header">
                <span class="span-space"><a href="#userInfo" data-toggle="tab"><span class="glyphicon glyphicon-pencil"></span>User</a></span>
                <span class="span-space active"><a href="#myCampaigns" data-toggle="tab">Campaigns</a></span>
                <span class="span-space"><a href="#mycontributions" data-toggle="tab"><span class="glyphicon glyphicon-ok"></span>contributions</a></span>
            </div>
        </div>
        <div class="navbar navbar-default navbar-fixed-top visible-xs" id="partner-third-header">
            <div class="navbar-header">
                <span class="span-space"><span class="header-text">Raised</span> <g:if test="${environment == 'prodIndia' || environment == 'stagingIndia' || environment == 'testIndia'}"><span class="fa fa-inr"></span>${fundRaised.round()}</g:if><g:else>$${fundRaised.round()}</g:else></span>
                <span class="span-space"><span class="header-text">Contributed</span> <g:if test="${environment == 'prodIndia' || environment == 'stagingIndia' || environment == 'testIndia'}"><span class="fa fa-inr"></span>${contributedAmount.round() * multiplier}</g:if><g:else>$${contributedAmount.round()}</g:else></span>
                <span class="span-space"><span class="header-text">Campaigns</span> ${projects.size()}</span>
            </div>
        </div>
        
        <div class="col-lg-2 col-md-3 col-sm-3 col-xs-12 pd-container-width hidden-xs" id="sidebar">
            <div class="sidebar-nav">
                <div class="partnerprofilediv automargin blacknwhite">
                    <g:if test="${user.userImageUrl}">
                        <div id="partnerImageEditDeleteIcon">
                            <span id="partnerprofileavatar">
                                <img src="${user.userImageUrl}" alt="avatar">
                            </span>
                            <div class="partnerprofileeditimage">
                                <img src="//s3.amazonaws.com/crowdera/assets/userprofileedit.png" alt="edit icon">
                            </div>
                        </div>
                        
                        <g:uploadForm controller="user" action="edit_avatar" id="${user.id}">
                            <button class="btn btn-primary btn-sm hidden" type="button" id="editavatarbutton">Edit Avatar</button>
                            <input class="hid-input-type-file hidden" type="file" name="profile" id="editavatar" accept="image/*"/>
                            <input type="submit" class="hidden buttons" value="Upload" id="editbutton"/>
                            <div class="clear"></div>
                            <div class="partner-information-bio">
                                <label class="docfile-orglogo-css" id="editProfileImg">Please select image file only.</label>
                                <label class="docfile-orglogo-css" id="editProfilesize">The file you are attempting to upload is larger than the permitted size of 3MB.</label>
                            </div>
                        </g:uploadForm>
                    </g:if>
                    <g:else>
                        <div id="userAvatarUploadIcon">
                            <span id="useravatar">
                                <img class="partnerdummyprofileimage" src="https://s3.amazonaws.com/crowdera/assets/profile_image.jpg" alt="' '">
                            </span>
                            <div class="partneruploadprofileimage">
                                <img class="plus-icon-over" src="https://s3.amazonaws.com/crowdera/assets/plus-icon-over.png" alt="avatar">
                            </div>
                        </div>
                        <g:uploadForm controller="user" action="upload_avatar" id="${user.id}">
                            <input class="hid-input-type-file hidden" type="file" name="avatar" id="avatar" accept="image/*"/>
                            <input type="submit" class="hidden buttons" value="Upload" id="uploadbutton"/>
                            <div class="partner-information-bio">
                                <label class="docfile-orglogo-css" id="uploadProfileImg">Please select image file only.</label>
                                <label class="docfile-orglogo-css" id="uploadProfilesize">The file you are attempting to upload is larger than the permitted size of 3MB.</label>
                            </div>
                        </g:uploadForm>
                    </g:else>
                </div>
                <div class="partnerprofilediv automargin">
                    <div class="partner-information-bio text-center">
                        <b>${user.firstName}</b>
                    </div>
                </div>
                <g:if test="${user.biography}">
                    <div class="partnerprofilediv automargin">
                        <div class="partner-information-bio text-center"> 
                            <div class="user-biography hidden-xs">${user.biography}</div>
                        </div>
                    </div>
                </g:if>
                <%
                    boolean ispartnerdraft = false
                    if (partner) {
                        ispartnerdraft = partner.draft
                    }
                %>
                <ul id="side-menu">
                    <li>
                        <a href="${resource(dir: '/campaign/create')}" class="active">Create Campaign</a>
                    </li>
                    <g:if test="${partner && ispartnerdraft}">
                        <li>
                            <a href="${resource(dir: '/partner/edit')}" class="active">Edit Partner Page</a>
                        </li>
                    </g:if>
                    <g:if test="${environment == 'testIndia' || environment == 'test' || environment == 'development'}">
                        <li>
                            <g:link controller="user" action="userActivity1" id="${user.id}" class="active">User Profile</g:link>
                        </li>
                    </g:if>
                    <li>
                        <a href="#userInfo" data-toggle="tab">Manage Profile</a>
                    </li>
                    <li class="active">
                        <a href="#myCampaigns" data-toggle="tab"> My Campaigns</a>
                    </li>
                    <li>
                        <a href="#mycontributions" data-toggle="tab"> Campaigns Supported</a>
                    </li>
                    <g:if test="${(isUserProjectHavingContribution && userHasContributedToNonProfitOrNgo) && (currentEnv == 'test' || currentEnv == 'testIndia' || currentEnv == 'development')}">
                        <li>
                            <a href="#taxReceipt" data-toggle="tab">Tax Receipt</a>
                        </li>
                    </g:if>
                    <g:elseif test="${isUserProjectHavingContribution && !userHasContributedToNonProfitOrNgo && (currentEnv == 'test' || currentEnv == 'testIndia' || currentEnv == 'development')}">
                        <li>
                            <a href="#sendtaxReceipt" data-toggle="tab">Send Tax Receipt</a>
                        </li>
                    </g:elseif>
                    <g:elseif test="${!isUserProjectHavingContribution && userHasContributedToNonProfitOrNgo && (currentEnv == 'test' || currentEnv == 'testIndia' || currentEnv == 'development')}">
                        <li>
                            <a href="#exporttaxReceipt" data-toggle="tab">Export Tax Receipt</a>
                        </li>
                    </g:elseif>
                    <li class="hidden">
                        <a href="#track" data-toggle="tab">Track Growth</a>
                    </li>
                </ul>
            </div>
        </div>
        <div class="col-lg-10 col-md-9 col-sm-9 col-xs-12 pd-container-width">
            <div class="pd-container">
                <div class="col-xs-12 userdashboardstats hidden-xs">
                    <div class="col-lg-4 col-md-4 col-sm-4 col-xs-12 userdashboardstatstile">
                        <div class="panel panel-info">
                            <div class="panel-heading">
                                <div class="row">
                                    <div class="col-xs-2 col-md-2 hidden-sm">
                                        <i class="fa fa-leaf fa-3x"></i>
                                    </div>
                                    <div class="col-xs-10 col-sm-12 col-md-10 text-right">
                                        <p class="announcement-heading">
                                            <span class="amountSection-Font"><g:if test="${environment == 'prodIndia' || environment == 'stagingIndia' || environment == 'testIndia'}"><span class="fa fa-inr"></span>${fundRaised.round()}</g:if><g:else>$${fundRaised.round()}</g:else></span>
                                        </p>
                                    </div>
                                </div>
                            </div>
                            <div class="panel-footer announcement-bottom">
                                Raised
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-4 col-md-4 col-sm-4 col-xs-12 userdashboardstatstile">
                        <div class="panel panel-success">
                            <div class="panel-heading">
                                <div class="row">
                                    <div class="col-xs-2 col-md-2 hidden-sm">
                                        <i class="fa fa-leaf fa-3x"></i>
                                    </div>
                                    <div class="col-xs-10 col-sm-12 col-md-10 text-right">
                                        <p class="announcement-heading">
                                            <span class="amountSection-Font"><g:if test="${environment == 'prodIndia' || environment == 'stagingIndia' || environment == 'testIndia'}"><span class="fa fa-inr"></span>${contributedAmount.round() * multiplier}</g:if><g:else>$${contributedAmount.round()}</g:else></span>
                                        </p>
                                    </div>
                                </div>
                            </div>
                            <div class="panel-footer announcement-bottom">
                                Contributed
                            </div>
                        </div>
                    </div>

                    <div class="col-lg-4 col-md-4 col-sm-4 col-xs-12 userdashboardstatstile">
                        <div class="panel panel-warning">
                            <div class="panel-heading">
                                <div class="row">
                                    <div class="col-xs-2 col-md-2 hidden-sm">
                                        <i class="fa fa-leaf fa-3x"></i>
                                    </div>
                                    <div class="col-xs-10 col-sm-12 col-md-10 text-right">
                                        <p class="announcement-heading">${totalprojects.size()}</p>
                                    </div>
                                </div>
                            </div>
                            <div class="panel-footer announcement-bottom">
                                Campaigns
                            </div>
                        </div>
                    </div>
                </div>
                
                <div class="clear"></div>
                <g:if test="${flash.prj_validate_message}">
                    <div class="col-sm-12 text-center success-message">
                        <div class="alert alert-success">
                            ${flash.prj_validate_message}
                        </div>
                    </div>
                </g:if>
				
                <div class="col-md-12 col-sm-12 col-lg-12" id="vitalseperator">
                    <hr>
                </div>
                <div class="tab-content" id="partner-tab-content">
                    <div class="tab-pane tab-pane-active" id="mycontributions">
                        <div id="usercontributionpaginate">
                            <g:render template="/user/user/campaignssupported"/>
                        </div>
                    </div>
                    
                    <div class="tab-pane tab-pane-active" id="userInfo">
                        <g:render template="/user/user/userprofile"/>
                    </div>
                    
                    <div class="active tab-pane tab-pane-active" id="myCampaigns">
                        <div id="usercampaignpaginate">
                            <g:render template="user/campaigntile"/>
                        </div>
                    </div>

                    <g:if test="${(isUserProjectHavingContribution && userHasContributedToNonProfitOrNgo) && (currentEnv == 'test' || currentEnv == 'testIndia' || currentEnv == 'development')}">
                        <div class="tab-pane tab-pane-active" id="taxReceipt">
                            <div class="col-sm-12">
                                <g:render template="/user/partner/receiptBoard"/>
                            </div>
                        </div>
                    </g:if>
                    <g:elseif test="${(isUserProjectHavingContribution && !userHasContributedToNonProfitOrNgo) && (currentEnv == 'test' || currentEnv == 'testIndia' || currentEnv == 'development')}">
                        <div class="tab-pane tab-pane-active" id="sendtaxReceipt">
                            <div class="col-sm-12 sendTaxReceiptBoard"><br>
                                <g:if test="${contributionList}">
                                    <div class="send-tax-receipt-to-contributors">
                                        <g:render template="/user/user/sendTaxReceipt" model="[sort:'All', isBackRequired: 'No', selectpicker: 'hide']"/>
                                    </div>
                                </g:if>
                                <g:else>
                                    <div class="campaignTilePaginate send-tax-receipt-to-contributors">
                                        <g:render template="/user/user/userCampaignTile"/>
                                    </div>
                                </g:else>
                            </div>
                        </div>
                    </g:elseif>
                    <g:elseif test="${(!isUserProjectHavingContribution && userHasContributedToNonProfitOrNgo) && (currentEnv == 'test' || currentEnv == 'testIndia' || currentEnv == 'development')}">
                        <div class="tab-pane tab-pane-active exportTaxReceiptThumbnail" id="exporttaxReceipt">
                            <div class="col-sm-12">
                                <br><g:render template="/user/user/exportTaxReceipt"/>
                            </div>
                        </div>
                    </g:elseif>
                 </div>
                    
             </div>
          
         </div>
     </div>
     <div class="loadingfilegif text-center" id="loadingfilegif">
         <img src="//s3.amazonaws.com/crowdera/assets/loading.gif" alt="'loadingImage'" id="loading-file-gif-img">
     </div>
</g:else>
</body>
</html>
