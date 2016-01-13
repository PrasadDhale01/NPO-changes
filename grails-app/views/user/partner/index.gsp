<html>
<head>
    <meta name="layout" content="main" />
    <r:require module="userjs"/>
</head>
<body>
<div class="feducontent">
    <div class="container dashboard-container" id="partner-container">
        <%
            def partnersOpts = ['Verified':'Verified', 'Non-Verified': 'Non-Verified', 'Pending':'Pending', 'Draft': 'Draft']
        %>
        <h1 class="text-center green-heading"><span class="fa fa-users"></span>&nbsp;&nbsp;<b>Partners</b></h1>

        <div class="col-xs-12 invitepartner">
            <div class="partner-verification pull-right">
	            <a href="#" class="btn btn-primary btn-sm pull-right managecontribution" data-toggle="modal" data-target="#invitePartnerModal">Invite Partner</a>
	            <div class="partnerOpts pull-right">
	                <g:select class="selectpicker text-center" name="partnersOpts" id="partnersOpts" from="${partnersOpts}" optionKey="value" optionValue="value"/>
	            </div>
	        </div>
        </div>
        
        <div class="clear"></div>
        <g:if test="${flash.alreadyExistMsg}">
            <div class="col-md-12 text-center">
                <div class="alert alert-info">${flash.alreadyExistMsg}</div>
            </div>
        </g:if>
        <g:elseif test="${flash.invitesuccessmsg}">
            <div class="col-md-12 text-center">
                <div class="alert alert-success">${flash.invitesuccessmsg}</div>
            </div>
        </g:elseif>
        <g:elseif test="${flash.discardmsg}">
            <div class="col-md-12 text-center">
                <div class="alert alert-success">${flash.discardmsg}</div>
            </div>
        </g:elseif>
        <g:elseif test="${flash.discardfailmsg}">
            <div class="col-md-12 text-center">
                <div class="alert alert-success">${flash.discardfailmsg}</div>
            </div>
        </g:elseif>
        <g:elseif test="${flash.validationSuccessMsg}">
            <div class="col-md-12 text-center">
                <div class="alert alert-success">${flash.validationSuccessMsg}</div>
            </div>
        </g:elseif>
        
        <div class="tab-content" id="partners-list">
            <div class="active tab-pane tab-pane-active" id="verified">
                <g:if test="${partners.size > 0}">
                    <g:render template="/user/partner/verifiedlist"/>
                </g:if>
                <g:else>
		            <div class="alert alert-info">
		                No such partner yet.
		            </div>
		        </g:else>
            </div>
            
	        <div class="tab-pane tab-pane-active" id="nonVerified">
	            <g:if test="${nonVerified.size() > 0}">
                    <g:render template="/user/partner/nonverifiedlist"/>
                </g:if>
                <g:else>
                    <div class="alert alert-info">
                        No such partner yet.
                    </div>
                </g:else>
	        </div>
	        
	        <div class="tab-pane tab-pane-active" id="pending">
	            <g:if test="${pendingList.size() > 0}">
                    <g:render template="/user/partner/pendinglist"/>
                </g:if>
                <g:else>
                    <div class="alert alert-info">
                        No such partner yet.
                    </div>
                </g:else>
	        </div>
	        
	        <div class="tab-pane tab-pane-active" id="draft">
	            <g:if test="${draftList.size() > 0}">
                    <g:render template="/user/partner/draftlist"/>
                </g:if>
                <g:else>
                    <div class="alert alert-info">
                        No such partner yet.
                    </div>
                </g:else>
            </div>
	    </div>
        
        <!-- invitePartnerModal -->
        <div class="modal fade" id="invitePartnerModal" tabindex="-1">
            <g:form name="invite-partner-form" action="addpartner" controller="user" role="form">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-body">
                            <div class="col-sm-12">
                                <button type="button" class="close" data-dismiss="modal"><span>&times;</span><span class="sr-only">Close</span></button>
                                <h2 class="text-center"><b>Invite Partner</b></h2>
                            </div>
                            <div class="col-md-12">
                                <div class="form-group">
                                    <label class="text" for="title"><b>FirstName</b></label>
                                    <input type="text" class="form-control contributioninput" name="firstName"/>
                                </div>
                            </div>
                            <div class="col-md-12">
                                <div class="form-group">
                                    <label class="text" for="title"><b>LastName</b></label>
                                    <input type="text" class="form-control contributioninput" name="lastName"/>
                                </div>
                            </div>
                            <div class="col-md-12">
                                <div class="form-group">
                                    <label for="title" class="text"><b>Email</b></label>
                                    <input type="email" class="form-control contributioninput offlineAmount" name="email"/>
                                </div>
                            </div>
                        </div>
                        <div class="clear"></div>
                        <div class="modal-footer">
                            <div class="col-md-12">
                                <button data-dismiss="modal" class="btn btn-primary">Close</button>
                                <button class="btn btn-primary" type="submit" id="saveButton">Invite</button>
                            </div>
                        </div>
                    </div>
                </div>
            </g:form>
        </div>
								
    </div>
</div>
</body>
</html>
