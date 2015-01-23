<%@ page import="java.text.SimpleDateFormat"%>
<g:set var="contributionService" bean="contributionService" />
<g:set var="projectService" bean="projectService" />
<g:set var="userService" bean="userService" />
<%
    def percentage = contributionService.getPercentageContributionForProject(project)
    boolean ended = projectService.isProjectDeadlineCrossed(project)
    def base_url = grailsApplication.config.crowdera.BASE_URL
    def user = userService.getCurrentUser()
    def username = user.username
%>
<html>
<head>
<meta name="layout" content="main" />
<r:require modules="projectshowjs" />
<r:require modules="rewardjs" />
<ckeditor:resources />
</head>
<body>
	<input type="hidden" id="b_url" value="<%=base_url%>" />
	<div class="feducontent">
		<div class="container">
			<g:if test="${project}">
				<div class="row">
					<g:if test="${flash.prj_mngprj_message}">
						<div class="alert alert-success" align="center">
							${flash.prj_mngprj_message}
						</div>
					</g:if>
					<g:if test="${project.rejected}">
						<div class="alert alert-info">
							<h2 class="text-center">Sorry, but this project is not
								validated by admin</h2>
						</div>
					</g:if>
					
					<g:if test="${!project.validated}">
					    <h1 class="green-heading text-center">
							<g:link controller="project" action="manageproject" id="${project.id}" title="${project.title}">${project.title}</g:link>
						</h1>
					</g:if>
					<g:else>
					    <h1 class="green-heading text-center">
						    <g:link controller="project" action="show" id="${project.id}" title="${project.title}" params="['fundRaiser': username]">${project.title}</g:link>
					    </h1>
					</g:else>
					
					<div class="col-md-12">
						<ul class="nav nav-tabs manage-projects nav-justified"
							style="margin-bottom: 10px;">
							<li class="active"><a href="#essentials" data-toggle="tab">
									<span class="glyphicon glyphicon-leaf"></span> <span class="tab-text"> Essentials</span>
							</a></li>
							<li><a href="#projectupdates" data-toggle="tab"> <span
									class="glyphicon glyphicon-asterisk"></span> <span class="tab-text">Manage Updates</span>
							</a></li>
							<li><a href="#manageTeam" data-toggle="tab"> <span class="fa fa-users"></span><span class="tab-text"> Manage Team</span>
 							</a></li>
 							<li><a href="#rewards" data-toggle="tab"> <i
									class="fa fa-gift fa-lg"></i> <span class="tab-text">Manage Rewards</span>
							</a></li>
							<li><a href="#contributions" data-toggle="tab"> <span
									class="glyphicon glyphicon-tint"></span> <span class="tab-text"> Contributions</span>
							</a></li>
							<li><a href="#comments" data-toggle="tab"> <span
									class="glyphicon glyphicon-comment"></span> <span class="tab-text"> Comments</span>
							</a></li>
						</ul>

						<!-- Tab panes -->
						<div class="tab-content">
							<div class="tab-pane active row" id="essentials">
								<g:render template="/project/manageproject/essentials" />
							</div>
							<div class="tab-pane row" id="projectupdates">
								<g:render template="/project/manageproject/projectupdates" />
							</div>
							<div class="tab-pane" id="manageTeam">
								<g:render template="/project/manageproject/manageteam" />
							</div>
							<div class="tab-pane" id="rewards">
								<g:render template="/project/manageproject/rewards" />
							</div>
							<div class="tab-pane" id="contributions">
								<g:render template="/project/manageproject/contributions" />
							</div>
							<div class="tab-pane" id="comments">
								<g:render template="/project/manageproject/comments" />
							</div>
						</div>

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
				<div class="alert alert-danger">Oh snap! Looks like that
					project doesn't exist.</div>
			</g:else>
		</div>
	</div>
</body>
</html>
