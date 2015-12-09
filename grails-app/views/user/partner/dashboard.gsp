<g:set var="projectService" bean="projectService" />
<g:set var="contributionService" bean="contributionService"/>
<g:set var="userService" bean="userService"/>
<%
    def partnerId = partner.id
    def userId = user.id
%>
<html>
<head>
    <meta name="layout" content="main" />
    <r:require module="partnerjs"/>
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
                <span class="span-space"><a href="#files" data-toggle="tab"><span class="glyphicon glyphicon-inbox"></span>Drive</a></span>
            </div>
        </div>
        <div class="navbar navbar-default navbar-fixed-top visible-xs" id="partner-third-header">
            <div class="navbar-header">
                <span class="span-space"><span class="header-text">Raised</span> <g:if test="${currentEnv == 'testIndia' || currentEnv == 'stagingIndia' || currentEnv == 'prodIndia'}"><span class="fa fa-inr"></span></g:if><g:else>$</g:else>${fundRaised.round()}</span>
                <span class="span-space"><span class="header-text">Invites</span> ${numberOfInvites}</span>
                <span class="span-space"><span class="header-text">Campaigns</span> ${totalUserCampaigns.size()}</span>
            </div>
        </div>
        <div class="col-lg-2 col-md-3 col-sm-3 col-xs-12 pd-container-width hidden-xs" id="sidebar">
            <div class="sidebar-nav">
                <div class="partnerprofilediv automargin" class="blacknwhite">
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
                        <g:if test="${user.biography}"> 
                            <div class="user-biography hidden-xs">${user.biography}</div>
                        </g:if>
                    </div>
                </div>
                
                <ul id="side-menu">
                    <g:if test="${!isAdmin}">
                        <li>
                            <a href="${resource(dir: '/campaign/create')}" class="active">Create Campaign</a>
                        </li>
                    </g:if>
                    <li>
                        <a href="#userInfo" data-toggle="tab">Manage Profile</a>
                    </li>
                    <li class="active">
                        <a href="#myCampaigns" data-toggle="tab"> My Campaigns</a>
                    </li>
                    <li>
                        <a href="#validate" data-toggle="tab"> Validate Campaigns</a>
                    </li>
                    <li>
                        <a href="#invite" data-toggle="tab"> Invite Campaign Owner</a>
                    </li>
                    <li>
                        <a href="#promote" data-toggle="tab">PROMOTE</a>
                    </li>
                    <li class="hidden">
                        <a href="#inbox" data-toggle="tab">INBOX</a>
                    </li>
                    <li>
                        <a href="#files" data-toggle="tab">Manage Google Drive</a>
                    </li>
                    <li class="hidden">
                        <a href="#track" data-toggle="tab">Track Growth</a>
                    </li>
                </ul>
            </div>
        </div>
        
<%--    Start of dashboard Container             --%>

        <div class="col-lg-10 col-md-9 col-sm-9 col-xs-12 pd-container-width">
            <div class="pd-container">
                <div class="col-lg-4 col-md-4 col-sm-4 hidden-xs partner-stats">
                    <div class="panel panel-info">
                        <div class="panel-footer announcement-bottom">
                            Raised <b><g:if test="${currentEnv == 'testIndia' || currentEnv == 'stagingIndia' || currentEnv == 'prodIndia'}"><span class="fa fa-inr"></span></g:if><g:else>$</g:else>${fundRaised.round()}</b>
                        </div>
                    </div>
                </div>
                <div class="col-lg-4 col-md-4 col-sm-4 hidden-xs partner-stats">
                    <div class="panel panel-info">
                        <div class="panel-footer announcement-bottom">
                            Campaigns <b>${totalUserCampaigns.size()}</b>
                        </div>
                    </div>
                </div>
                <div class="col-lg-4 col-md-4 col-sm-4 hidden-xs partner-stats">
                    <div class="panel panel-info">
                        <div class="panel-footer announcement-bottom">
                            Invites <b>${numberOfInvites}</b>
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
                    
                    <div class="tab-pane tab-pane-active" id="invite">
                        <div class="col-lg-offset-2 col-lg-8 col-md-offset-1 col-md-10 col-sm-offset-0 col-sm-12 col-xs-12" id="invite-campaign-owner">
                            <g:form action="invite" controller="user">
                                <h4 class="green-heading"><b>Recipient Email ID's</b></h4>
                                <div class="form-group">
                                    <label><b>Your Name</b></label> 
                                    <input type="text" class="form-control all-place" name="name" placeholder="Name" value="${user.firstName}"/>
                                </div>
                                <div class="form-group">
                                    <label><b>Email ID's (separated by comma)</b></label>
                                    <textarea class="form-control all-place" name="emails" rows="4" placeholder="Email ID's"></textarea>
                                </div>
                                <div class="form-group">
                                    <label><b>Message (Optional)</b></label>
                                    <textarea class="form-control all-place" name="message" rows="4" placeholder="Message"></textarea>
                                </div>
                                <g:if test="${!isAdmin}">
                                    <button type="submit" class="btn btn-primary pull-right hidden-xs" id="btnSendinvitation">Invite</button>
                                    <button type="submit" class="btn btn-block btn-sm btn-primary visible-xs" id="mobBtnSendinvitation">Invite</button>
                                </g:if>
                            </g:form>
                        </div>
                    </div>
                    
                    <div class="tab-pane tab-pane-active active" id="myCampaigns">
                         <div id="partnercampaignpaginate">
                             <g:render template="/user/partner/tile"/>
                         </div>
                    </div>
                    
                    <div class="tab-pane tab-pane-active" id="promote">
                        <div id="promotecampaignpaginate">
                            <g:render template="/user/partner/promote"/>
                        </div>
                    </div>
                    
<%--                    <div class="tab-pane tab-pane-active" id="track">--%>
<%--                    </div>--%>
                    
                    <div class="tab-pane tab-pane-active" id="userInfo">
                         <g:render template="/user/user/userprofile"/>
                    </div>
                    
<%--                    <div class="tab-pane tab-pane-active hidden-xs" id="inbox">--%>
<%--                    </div>--%>
                    <div class="tab-pane tab-pane-active" id="files">
                        <div class="col-sm-12">
                            <g:if test="${!isAdmin}">
                                <button type="button" class="btn btn-sm btn-primary pull-right" id="pick">Load File</button>
                            </g:if>
                            <div id="driveFiles">
                            </div>
                        </div>
                    </div>
                    <div class="tab-pane tab-pane-active" id="docs">
                        
                    </div>
                </div>
            </div>
        </div>
<%--    End of Dashboard Container   --%>
    </div>
    <script src="/js/filepicker.js" ></script>
    <script>
        function initPicker() {
            var picker = new FilePicker({
            apiKey: $('#apikey').val(),
            clientId: $('#clientId').val(),
            buttonEl: document.getElementById('pick'),
            onSelect: function(file) {
                    console.log(file);
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
