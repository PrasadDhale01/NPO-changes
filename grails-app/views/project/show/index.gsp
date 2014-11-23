<%@ page import="java.text.SimpleDateFormat" %>
<g:set var="contributionService" bean="contributionService"/>
<g:set var="projectService" bean="projectService"/>
<g:set var="userService" bean="userService"/>
<%
    def percentage = contributionService.getPercentageContributionForProject(project)
    boolean ended = projectService.isProjectDeadlineCrossed(project)
    def base_url = grailsApplication.config.crowdera.BASE_URL
%>
<html>
<head>
<meta name="layout" content="main" />
<r:require modules="projectshowjs"/>
</head>
<body>
<div class="feducontent">
	<div class="container">
		<g:if test="${project}">
            <div class="row">
	            <div class="col-md-12 text-center">
	            	<h1 class="green-heading">
	                	<a href="${project.id}">${project.title}</a>
	                </h1>
	            </div>
                <div class="col-md-8">
<%--                    <h4 class="lead">Beneficiary: ${projectService.getBeneficiaryName(project)}</h4>--%>
                    <g:if test="${flash.sentmessage}">
                        <div class="alert alert-success">
                            ${flash.sentmessage}
                        </div>
                    </g:if>

                    <ul class="nav nav-tabs nav-justified" style="margin-bottom: 10px;">
                        <li class="active"><a href="#essentials" data-toggle="tab">
                            <span class="glyphicon glyphicon-leaf"></span> Essentials
                        </a></li>
                        <li><a href="#contributions" data-toggle="tab">
                            <span class="glyphicon glyphicon-tint"></span> Contributions
                        </a></li>
                        <li><a href="#comments" data-toggle="tab">
                            <span class="glyphicon glyphicon-comment"></span> Comments
                        </a></li>
                    </ul>

                    <!-- Tab panes -->
                    <div class="tab-content">
                        <div class="tab-pane active" id="essentials">
                            <g:render template="show/essentials"/>
                        </div>
                        <div class="tab-pane" id="contributions">
                            <g:render template="show/contributions"/>
                        </div>
                        <div class="tab-pane" id="comments">
                            <g:render template="show/comments"/>
                        </div>
                    </div>
                    
                    <%-- Social features --%>
                    <div class="row">
				        <div class="col-sm-12">
				            <a class="share-mail pull-right" href="#" data-toggle="modal" data-target="#sendmailmodal" target="_blank" id="share-mail" data-url="${base_url}/projects/${project.id}" data-name="${project.title}">
				                <img src="${resource(dir: 'images', file: 'mail-share@2x.png')}" style="padding: 0; width:30px; bottom-margin:4px; margin:2px;" alt="Mail Share"/>
				            </a>
				            <a class="twitter-share pull-right" href="https://twitter.com/share?text=Hey check this project at crowdera.co!"  data-url="${base_url}/projects/${project.id}" target="_blank">
				                <img src="${resource(dir: 'images', file: 'tw-share@2x.png')}" style="padding: 0; width:30px; bottom-margin:4px; margin:2px;" alt="Twitter Share"/>
				            </a>
				            <a class="fb-like pull-right" href="http://www.facebook.com/sharer.php?s=100&p[url]=${base_url}/projects/${project.id}&p[title]=${project.title} &p[summary]=${project.story}" data-url="${base_url}/projects/${project.id}" data-share="true">
				                <img src="${resource(dir: 'images', file: 'fb-share@2x.png')}" style="padding: 0; width:30px; bottom-margin:4px; margin:2px;" alt="Facebook Share"/>
				            </a>
				            <span style="float:right; margin:5px;"><label>Share this project</label></span>
				        </div>
				        
				        <!-- Modal -->
				        <div class="modal fade" id="sendmailmodal" tabindex="-1" role="dialog" aria-hidden="true">
				            <g:form action="sendemail" id="${project.id}" role="form">
				                <div class="modal-dialog">
				                    <div class="modal-content">
				                        <div class="modal-header">
				                            <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
				                            <h4 class="modal-title">Recipient Email ID's</h4>
				                        </div>
				                        <div class="modal-body">
				                            <g:hiddenField name="amount" value="${project.amount}"/>
				                            <div class="form-group">
				                                <label>Your Name</label>
				                                <input type="text" class="form-control" name="name" placeholder="Name"/>
				                            </div>
				                            <div class="form-group">
				                                <label>Email ID's (separated by comma)</label>
				                                <textarea class="form-control" name="emails" rows="4" placeholder="Email ID's"></textarea>
				                            </div>
				                            <div class="form-group">
				                                <label>Message (Optional)</label>
				                                <textarea class="form-control" name="message" rows="4" placeholder="Message"></textarea>
				                            </div>
				                        </div>
				                        <div class="modal-footer">
				                            <button type="submit" class="btn btn-primary btn-block">Send Email</button>
				                        </div>
				                    </div>
				                </div>
				            </g:form>
				        </div>
				    </div>
				    
                </div>
                <div class="col-md-4">
					<g:render template="/layouts/organizationdetails"/>
                    <g:render template="/layouts/tilesanstitle"/>
                    <g:if test="${percentage == 100}">
                        <button type="button" class="btn btn-success btn-lg btn-block" disabled>SUCCESSFULLY FUNDED</button>
                    </g:if>
                    <g:elseif test="${ended}">
                        <button type="button" class="btn btn-warning btn-lg btn-block" disabled>PROJECT ENDED!</button>
                    </g:elseif>
                    <g:else>
                        <a href="/projects/${project.id}/fund" class="btn btn-success btn-lg btn-block" role="button">Fund this project</a>
                    </g:else>
                    <g:if test="${project.rewards.size()>1}">
                    	<g:render template="show/rewards"/>
                    </g:if>
                </div>
            </div>
            <%--
			<g:if test="${project.validated == false}">
                <div class="alert alert-warning">This project is not yet published.</div>
			</g:if>
			--%>
		</g:if>
		<g:else>
            <h1>Project not found</h1>
			<div class="alert alert-danger">Oh snap! Looks like that project doesn't exist.</div>
		</g:else>
	</div>
</div>
</body>
</html>
