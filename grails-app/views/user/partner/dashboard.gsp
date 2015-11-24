<g:set var="projectService" bean="projectService" />
<g:set var="contributionService" bean="contributionService"/>
<g:set var="userService" bean="userService"/>
<html>
<head>
    <meta name="layout" content="main" />
    <r:require module="partnerjs"/>
</head>
<body>
    <div class="partner-dashboard" id="wrapper">
        <g:hiddenField name="currentEnv" id="currentEnv" value="${currentEnv}"></g:hiddenField>
        <div class="navbar navbar-default navbar-fixed-top visible-xs" id="partner-sec-header">
            <div class="navbar-header">
                <span class="span-space"><a href="#userInfo" data-toggle="tab"><span class="glyphicon glyphicon-pencil"></span>User</a></span>
                <span class="span-space active"><a href="#myCampaigns" data-toggle="tab">Campaigns</a></span>
                <span class="span-space"><a href="#validate" data-toggle="tab"><span class="glyphicon glyphicon-ok"></span>Validate</a></span>
                <span class="span-space"><a href="#invite" data-toggle="tab"><span class="glyphicon glyphicon-envelope"></span>Invite </a></span>
                <span class="span-space"><a href="#promote" data-toggle="tab">Promote</a></span>
                <span class="span-space"><a href="#inbox" data-toggle="tab"><span class="glyphicon glyphicon-inbox"></span>Inbox</a></span>
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
                        <g:if test="${user.biography}"> 
                            <div class="user-biography hidden-xs">${user.biography}</div>
                        </g:if>
                    </div>
                </div>
                
                <ul id="side-menu">
                    <li>
                        <a href="${resource(dir: '/campaign/create')}" class="active">Create Campaign</a>
                    </li>
                    <li>
                        <a href="#userInfo" data-toggle="tab">Manage User</a>
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
                    <li>
                        <a href="#inbox" data-toggle="tab">INBOX</a>
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
				            <div class="col-lg-4 col-md-4 col-sm-6 col-xs-12">
												        <div class="panel panel-success">
												            <div class="panel-heading">
												                <div class="row">
												                    <div class="col-xs-2">
												                        <i class="fa fa-user fa-2x"></i>
												                    </div>
												                    <div class="col-xs-10 text-right">
												                        <p class="announcement-heading">
												                            <g:if test="${currentEnv == 'testIndia' || currentEnv == 'stagingIndia' || currentEnv == 'prodIndia'}"><span class="fa fa-inr"></span></g:if><g:else>$</g:else>${fundRaised.round()}
												                        </p>
												                    </div>
												                </div>
												            </div>
												            <div class="panel-footer announcement-bottom">
												                Amount Raised
												            </div>
												        </div>
												    </div>
												    <div class="col-lg-4 col-md-4 col-sm-6 col-xs-12">
												        <div class="panel panel-info">
												            <div class="panel-heading">
												                <div class="row">
												                    <div class="col-xs-2">
												                        <i class="fa fa-leaf fa-2x"></i>
												                    </div>
												                    <div class="col-xs-10 text-right">
												                        <p class="announcement-heading">${campaigns.size()}</p>
												                    </div>
												                </div>
												            </div>
												            <div class="panel-footer announcement-bottom">
												                Total # of campaigns
												            </div>
												        </div>
												    </div>
												    <div class="col-lg-4 col-md-4 col-sm-6 col-xs-12 hidden-xs hidden-sm">
												        <div class="panel panel-warning">
												            <div class="panel-heading">
												                <div class="row">
												                    <div class="col-xs-2">
												                        <i class="fa fa-users fa-2x"></i>
												                    </div>
												                    <div class="col-xs-10 text-right">
												                        <p class="announcement-heading">${numberOfInvites}</p>
												                    </div>
												                </div>
												            </div>
												            <div class="panel-footer announcement-bottom">
												                Total # of invites
												            </div>
												        </div>
												    </div>
								        
												    <div class="clear"></div>
												    <div class="col-md-12 col-sm-12 col-lg-12" id="vitalseperator">
												        <hr>
												    </div>
				            <div class="tab-content">
				                <div class="tab-pane tab-pane-active" id="validate">
				                    <div class="col-sm-12 text-center">
								                    <g:if test="${flash.prj_validate_message}">
								                        <div class="alert alert-success">
								                            ${flash.prj_validate_message}
								                        </div>
								                    </g:if>
								                </div>
				                    <div class="col-sm-12">
				                        <h4 class="green-heading"><img class="img-circle" src="//s3.amazonaws.com/crowdera/assets/icon-validated.png" alt="Campaigns to be validated"/>&nbsp;<b>Campaigns to be validated</b></h4><br>
				                    </div>
				                    <g:if test="${projects.size() > 0}">
																            <g:render template="/user/partner/validatetile"></g:render>
																				    </g:if>
																				    <g:else>
																				        <div class="col-sm-12">
																								        <div class="alert alert-info">
																								            No campaigns to validate.
																								        </div>
																				        </div>
																				    </g:else>
				                </div>
				                
				                <div class="tab-pane tab-pane-active hidden-xs" id="invite">
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
				                            <button type="submit" class="btn btn-primary pull-right" id="btnSendinvitation">Invite</button>
				                        </g:form>
				                    </div>
				                </div>
				                
				                <div class="tab-pane tab-pane-active active" id="myCampaigns">
				                     <g:render template="/user/partner/tile"/>
                    </div>
                    
				                <div class="tab-pane tab-pane-active" id="promote">
				                    <g:render template="/user/partner/promote"/>
				                </div>
				                
				                <div class="tab-pane tab-pane-active" id="track">
				                </div>
				                
				                <div class="tab-pane tab-pane-active" id="userInfo">
				                     <g:render template="/user/user/userprofile"/>
                    </div>
				                
				                <div class="tab-pane tab-pane-active hidden-xs" id="inbox">
				                </div>
				                
				            </div>
            </div>
        </div>
<%--    End of Dashboard Container   --%>
    </div>
</body>
</html>
