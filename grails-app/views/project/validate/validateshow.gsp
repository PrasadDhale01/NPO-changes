<%@ page import="java.text.SimpleDateFormat"%>
<g:set var="contributionService" bean="contributionService" />
<g:set var="projectService" bean="projectService" />
<g:set var="userService" bean="userService" />
<%
    def percentage = contributionService.getPercentageContributionForProject(project)
    boolean ended = projectService.isProjectDeadlineCrossed(project)
%>
<html>
<head>
<meta name="layout" content="main" />
<r:require modules="projectshowjs" />
<r:require modules="rewardjs" />
</head>
<body>
	<div class="feducontent">
		<div class="container">
			<g:if test="${project}">
			    <div class="row">
					<div class="col-md-12">
					    <div class="col-md-8">
						<h1 class="green-heading text-center">
							<g:link controller="project" action="validateshow" id="${project.id}" title="${project.title}"> ${project.title} </g:link>
						</h1>
						</div>
						<div class="col-md-4">
							<div class="col-md-6 col-sm-6 col-xs-6">
								<g:link controller="project" action="updateValidation" id="${project.id}" class="btn-sm btn-primary validatebutton" role="button">
									<i class="glyphicon glyphicon-check" style="width: 175"></i>&nbsp;Validate
								</g:link>
							</div>
							<div class="col-md-6 col-sm-6 col-xs-6">
								<g:form action="delete" controller="project" id="${project.id}" method="post">
									<button class="validatebtn btn-sm btn-danger" name="_action_delete" value="Delete" onclick="return confirm(&#39;Are you sure you want to discard this campaign?&#39;);" style="width: 180">
										<i class="fa fa-trash-o"></i>&nbsp;Discard
									</button>
								</g:form>
							</div>
						</div>
					</div>
				</div><br/>
				<div class="row">
					<div class="col-md-8">
						<ul class="nav nav-tabs nav-justified" style="margin-bottom: 10px;">
							<li class="active"><a href="#essentials" data-toggle="tab">
									<span class="fa fa-leaf"></span><span class="tab-text"> Essentials</span>
							</a></li>
							<li><a href="#projectupdates" data-toggle="tab">
								<span class="glyphicon glyphicon-asterisk"></span><span class="tab-text"> Updates</span>
							</a></li>
							<li><a href="#manageTeam" data-toggle="tab">
                            	<span class="fa fa-users"></span><span class="tab-text"> Team</span>
 							</a></li>
							<li><a href="#contributions" data-toggle="tab"> <span
									class="fa fa-tint"></span><span class="tab-text"> Contributions</span>
							</a></li>
							<li><a href="#comments" data-toggle="tab"> <span
									class="fa fa-comments"></span><span class="tab-text"> Comments</span>
							</a></li>
						</ul>

						<!-- Tab panes -->
						<div class="tab-content">
							<div class="tab-pane active" id="essentials">
								<g:render template="/project/show/essentials" />
							</div>
							<div class="tab-pane" id="projectupdates">
                            	<g:render template="show/projectupdates"/>
                         	</div>
                         	<div class="tab-pane" id="manageTeam">
								<g:render template="manageproject/manageteam"/>
							</div>
							<div class="tab-pane" id="contributions">
								<g:render template="/project/manageproject/contributions" />
							</div>
							<div class="tab-pane" id="comments">
								<g:render template="/project/manageproject/comments" />
							</div>
						</div>

					</div>

					<div  class="col-md-4">
						<g:render template="/project/manageproject/tilesanstitle"/></div>
					</div>
				<%--
			<g:if test="${project.validated == false}">
                <div class="alert alert-warning">This Campaign is not yet published.</div>
			</g:if>
			--%>
			</g:if>
			<g:else>
				<h1>Project not found</h1>
				<div class="alert alert-danger">Oh snap! Looks like that
					Campaign doesn't exist.</div>
			</g:else>
		</div>
	</div>
</body>
</html>
