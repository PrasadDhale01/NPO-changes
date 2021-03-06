<g:set var="projectService" bean="projectService" />
<g:set var="contributionService" bean="contributionService"/>
<g:set var="userService" bean="userService"/>
<%
    def partnerId = partner.id
    def userId = user.id
    def multiplier = conversionMultiplier
%>
<html>
<head>
    <meta name="layout" content="main" />
    <r:require module="showpartnerjs"/>
    <script>
        function submitCampaignShowForm(pkey, projectId, fr){
            $.ajax({
                type    :'post',
                url     : $("#b_url").val()+'/project/urlBuilder',
                data    : "projectId="+projectId+"&fr="+fr+"&pkey="+pkey,
                success : function(response){
                    $(location).attr('href', response);
                }
            }).error(function(){
                console.log("Error in redirecting");
            });
        }
    </script>
</head>
<body>
    <div class="partner-dashboard" id="wrapper">
        <g:hiddenField name="currentEnv" id="currentEnv" value="${currentEnv}"></g:hiddenField>
        <g:hiddenField name="partnerId" id="partnerId" value="${partnerId}"></g:hiddenField>
        <g:hiddenField name="baseUrl" value="${baseUrl}" id="baseUrl"></g:hiddenField>
        <g:hiddenField name="userId" value="${userId}"></g:hiddenField>
        <g:hiddenField name="clientId" value="${grailsApplication.config.crowdera.Client_Id}"></g:hiddenField>
        <g:hiddenField name="apikey" value="${grailsApplication.config.crowdera.api_key}"></g:hiddenField>
        <g:hiddenField name="alphanumericId" value="${grailsApplication.config.crowdera.Client_Id_alphanumeric}"></g:hiddenField>
        
        <div class="navbar navbar-default navbar-fixed-top visible-xs" id="partner-sec-header">
            <div class="navbar-header">
                <span class="span-space"><a href="#userInfo" data-toggle="tab"><span class="glyphicon glyphicon-pencil"></span>User</a></span>
                <span class="span-space active"><a href="#myCampaigns" data-toggle="tab">Campaigns</a></span>
                <span class="span-space"><a href="#validate" data-toggle="tab"><span class="glyphicon glyphicon-ok"></span>Validate</a></span>
                <span class="span-space"><a href="#invite" data-toggle="tab"><span class="glyphicon glyphicon-envelope"></span>Invite </a></span>
                <span class="span-space"><a href="#promote" data-toggle="tab">Promote</a></span>
                <span class="span-space"><a href="#docs" data-toggle="tab"><span class="glyphicon glyphicon-inbox"></span>Docs</a></span>
            </div>
        </div>
        <div class="navbar navbar-default navbar-fixed-top visible-xs" id="partner-third-header">
            <div class="navbar-header">
                <span class="span-space"><span class="header-text">Raised</span> <g:if test="${currentEnv == 'testIndia' || currentEnv == 'stagingIndia' || currentEnv == 'prodIndia'}"><span class="fa fa-inr"></span></g:if><g:else>$</g:else>${fundRaised.round()}</span>
                <span class="span-space"><span class="header-text">Contributed</span> <g:if test="${currentEnv == 'prodIndia' || currentEnv == 'stagingIndia' || currentEnv == 'testIndia'}"><span class="fa fa-inr"></span>${contributedAmount.round() * multiplier}</g:if><g:else>$${contributedAmount.round()}</g:else></span>
                <span class="span-space"><span class="header-text">Campaigns</span> ${totalUserCampaigns.size()}</span>
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
                            <g:if test="${!isAdmin}">
                                <div class="partnerprofileeditimage">
                                    <img src="//s3.amazonaws.com/crowdera/assets/userprofileedit.png" alt="edit icon">
                                </div>
                            </g:if>
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
                            <g:if test="${!isAdmin}">
                                <div class="partneruploadprofileimage">
                                    <img class="plus-icon-over" src="https://s3.amazonaws.com/crowdera/assets/plus-icon-over.png" alt="avatar">
                                </div>
                            </g:if>
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
                <ul id="side-menu">
                    <g:if test="${!isAdmin}">
                        <li>
                            <a href="${resource(dir: '/campaign/create')}" class="active">Create Campaign</a>
                        </li>
                    </g:if>
                    <li>
                        <a href="#userInfo" data-toggle="tab">Manage Profile</a>
                    </li>
                    <li class="<g:if test="${!isInviteTrue}">active</g:if>">
                        <a href="#myCampaigns" data-toggle="tab"> My Campaigns</a>
                    </li>
                    <li>
                        <a href="#mycontributions" data-toggle="tab">Campaigns Supported</a>
                    </li>
                    <li class="<g:if test="${isInviteTrue}">active</g:if>">
                        <a href="#invite" data-toggle="tab"> Invite Campaign Owner</a>
                    </li>
                    <li>
                        <a href="#validate" data-toggle="tab">Validate Campaigns</a>
                    </li>
                    <li>
                        <a href="#docs" data-toggle="tab">Manage Docs</a>
                    </li>
                    <g:if test="${(isUserProjectHavingContribution && userHasContributedToNonProfitOrNgo) && (currentEnv == 'test' || currentEnv == 'testIndia' || currentEnv == 'development')}">
                        <li>
                            <a href="#taxReceipt" data-toggle="tab">Donation Receipts</a>
                        </li>
                    </g:if>
                    <g:elseif test="${isUserProjectHavingContribution && !userHasContributedToNonProfitOrNgo && (currentEnv == 'test' || currentEnv == 'testIndia' || currentEnv == 'development')}">
                        <li>
                            <a href="#sendtaxReceipt" data-toggle="tab">Donation Receipts</a>
                        </li>
                    </g:elseif>
                    <g:elseif test="${!isUserProjectHavingContribution && userHasContributedToNonProfitOrNgo && (currentEnv == 'test' || currentEnv == 'testIndia' || currentEnv == 'development')}">
						<li>
                            <a href="#exporttaxReceipt" data-toggle="tab">Donation Receipts</a>
						</li>
                    </g:elseif>
                    <li>
                        <a href="#promote" data-toggle="tab">Promote</a>
                    </li>
                    <li class="hidden">
                        <a href="#inbox" data-toggle="tab">Inbox</a>
                    </li>
                    <li class="hidden">
                        <a href="#track" data-toggle="tab">Track Growth</a>
                    </li>
                    <g:if test="${currentEnv == 'testIndia' || currentEnv == 'development' || currentEnv == 'test'}">
                        <li>
                            <a href="#upgrade" data-toggle="tab">Upgrade Plans</a>
                        </li>
                    </g:if>
                    <g:if test="${isAdmin}">
                        <li>
                            <a href="/user/deletePartner?userId=${user.id}&partnerId=${partnerId}" class="active" id="deletePartner">Delete</a>
                        </li>
                    </g:if>
                </ul>
            </div>
        </div>
        
<%--    Start of dashboard Container             --%>

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
                                            <span class="amountSection-Font"><g:if test="${currentEnv == 'testIndia' || currentEnv == 'stagingIndia' || currentEnv == 'prodIndia'}"><span class="fa fa-inr"></span></g:if><g:else>$</g:else>${fundRaised.round()}</span>
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
                        <div class="panel panel-warning">
                            <div class="panel-heading">
                                <div class="row">
                                    <div class="col-xs-2 col-md-2 hidden-sm">
                                        <i class="fa fa-leaf fa-3x"></i>
                                    </div>
                                    <div class="col-xs-10 col-sm-12 col-md-10 text-right">
                                        <p class="announcement-heading">
                                            <span class="amountSection-Font"><g:if test="${currentEnv == 'prodIndia' || currentEnv == 'stagingIndia' || currentEnv == 'testIndia'}"><span class="fa fa-inr"></span>${contributedAmount.round() * multiplier}</g:if><g:else>$${contributedAmount.round()}</g:else></span>
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
                        <div class="panel panel-success">
                            <div class="panel-heading">
                                <div class="row">
                                    <div class="col-xs-2 col-md-2 hidden-sm">
                                        <i class="fa fa-leaf fa-3x"></i>
                                    </div>
                                    <div class="col-xs-10 col-sm-12 col-md-10 text-right">
                                        <p class="announcement-heading">
                                            <span class="amountSection-Font">${totalUserCampaigns.size()}</span>
                                        </p>
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
                <g:elseif test="${flash.invite_message}">
                    <div class="col-sm-12 text-center success-message">
                        <div class="alert alert-success">
                            ${flash.invite_message}
                        </div>
                    </div>
                </g:elseif>
                <g:elseif test="${flash.receipt_sent_msg}">
                    <div class="col-sm-12 text-center success-message">
                        <div class="alert alert-success">
                            ${flash.receipt_sent_msg}
                        </div>
                    </div>
                </g:elseif>
                <g:elseif test="${!partner.enabled}">
                    <div class="col-sm-12 partner-confirmation">
                        <div class="alert alert-info">
                            Your account is yet to confirm. Kindly click <g:link controller="user" target="tab" action= "confirmPartner" id= "${partner.confirmCode}">here</g:link> to confirm your account.
                        </div>
                    </div>
                </g:elseif>
                
                <div class="col-md-12 col-sm-12 col-lg-12" id="vitalseperator">
                    <hr>
                </div>

                <div class="tab-content" id="partner-tab-content">
                    <div class="tab-pane tab-pane-active" id="validate">
                        <div class="col-sm-12">
                            <h4 class="green-heading"><img class="img-circle" src="//s3.amazonaws.com/crowdera/assets/icon-validated.png" alt="Campaigns to be validated"/>&nbsp;<b>Campaigns to be validated</b></h4><br>
                        </div>
                        <div id="validatecampaignpaginate">
                        </div>
                    </div>
                    
                    <div class="tab-pane tab-pane-active <g:if test="${isInviteTrue}">active</g:if>" id="invite">
                        <div id="inviteCampaignOwner">
                             <g:render template="/user/partner/invitecampaignmember"/>
                         </div>
                    </div>
                    
                    <div class="tab-pane tab-pane-active" id="mycontributions">
                        <div id="usercontributionpaginate">
                            <g:render template="/user/user/campaignssupported"/>
                        </div>
                    </div>
                    
                    <div class="<g:if test="${!isInviteTrue}">active tab-pane tab-pane-active</g:if>" id="myCampaigns">
                         <div id="partnercampaignpaginate">
                             <g:render template="/user/partner/tile"/>
                         </div>
                    </div>
                    
                    <div class="tab-pane tab-pane-active" id="promote">
                        <div id="promotecampaignpaginate">
                            <g:render template="/user/partner/promote"/>
                        </div>
                    </div>
                    
                    <div class="tab-pane tab-pane-active" id="userInfo">
                         <g:render template="/user/user/userprofile"/>
                    </div>
                    
                    <div class="tab-pane tab-pane-active" id="docs">
                        <div class="col-sm-12">
                            <g:render template="/user/partner/docs"/>
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

                    <g:if test="${currentEnv == 'testIndia' || currentEnv == 'development' || currentEnv == 'test'}">
                        <div class="tab-pane tab-pane-active" id="upgrade">
                            <div class="col-sm-12">
                                <div class="alert alert-info">
                                    This feature is yet to implement.
                                </div>
                            </div>
                        </div>
                    </g:if>
                </div>
            </div>
        </div>
<%--    End of Dashboard Container   --%>
    </div>
    <div class="loadinggif text-center" id="loading-gif">
        <img src="//s3.amazonaws.com/crowdera/documents/loading.gif" alt="'loadingImage'" id="loading-gif-img">
    </div>
    <div class="loadingfilegif text-center" id="loadingfilegif">
        <img src="//s3.amazonaws.com/crowdera/assets/loading.gif" alt="'loadingImage'" id="loading-file-gif-img">
    </div>
    <script src="/js/filepicker.js" ></script>
    <script>
        function initPicker() {
            var picker = new FilePicker({
            apiKey: $('#apikey').val(),
            clientId: $('#clientId').val(),
            buttonEl: document.getElementById('pick'),
            onSelect: function(file) {
                     }
            });
        }
    </script>
    <%
        def loadApiUrl = 'https://www.google.com/jsapi?key='+ grailsApplication.config.crowdera.api_key
    %>
    <script src="${loadApiUrl}"></script>
    <script src="https://apis.google.com/js/client.js?onload=initPicker"></script>
</body>
</html>
