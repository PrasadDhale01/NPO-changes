<html>
<head>
    <meta name="layout" content="main" />
    <r:require module="partnerjs"/>
</head>
<body>
<div class="feducontent">
    <div class="container dashboard-container" id="partner-container">
        <h1 class="text-center"><b>Partners</b></h1>

        <div class="col-sm-12 invitepartner">
            <a href="#" class="btn btn-primary btn-sm pull-right managecontribution" data-toggle="modal" data-target="#invitePartnerModal">Invite Partner</a>
        </div>
        <div class="clear"></div>
        <g:if test="${flash.alreadyExistMsg}">
            <div class="col-md-12">
                <div class="alert alert-info">${flash.alreadyExistMsg}</div>
            </div>
        </g:if>
        
        <g:if test="${flash.error}">
            <label class="bg-danger">${flash.error}</label>
        </g:if>
        <g:if test="${flash.community_message}">
            <label class="bg-success">${flash.community_message}</label>
        </g:if>
        <%
            indexcount = 1;
        %>
        <div class="col-md-12 invitepartner">
            <div class="panel-body partner-panel">
				            <ul class="thumbnails list-unstyled">
												        <g:each in="${partners}" var="partner">
				                    <li class="col-md-3 col-lg-3 col-sm-4 col-xs-12">
				                        <div class="partner-tile thumbnail">
				                            <g:link action="partnerdashboard" controller="user" id="${partner.id}">
				                                <g:if test="${partner.user.userImageUrl}">
				                                    <img src="${partner.user.userImageUrl}" alt="''">
				                                </g:if>
				                                <g:else>
				                                    <img  src="//s3.amazonaws.com/crowdera/assets/profile_image.jpg" alt="''">
				                                </g:else>
				                            </g:link>
				                            
				                            <div class="text-center">
				                                <label><b>${partner.user.firstName}</b></label>
				                            </div>
				                        </div>
				                    </li>
												        </g:each>
												    </ul>
								    </div>
								</div>
								
								<div class="col-md-12">
								<div class="table-responsive">
            <table class="table table-bordered">
                <thead>
				                <tr class="alert alert-title ">
				                    <th>Sr No.</th>
				                    <th>FirstName</th>
				                    <th>LastName</th>
				                    <th>Email</th>
				                    <th>Status</th>
				                </tr>
                </thead>
                <tbody>
                    <g:each in="${partners}" var="partner">
                    <tr>
                        <td>${indexcount++}</td>
                        <td>${partner.user.firstName}</td>
                        <td>${partner.user.lastName}</td>
                        <td>${partner.user.email}</td>
                        <td>
                            <g:if test="${partner.enabled}">
                                <a href="#" class="btn btn-primary btn-sm">Confirmed</a>
                            </g:if>
                            <g:else>
                                <a href="#" class="btn btn-default btn-sm">Pending</a>
                            </g:else>
                        </td>
                    </tr>
                    </g:each>
                </tbody>
            </table>
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
