<%@ page import="java.text.SimpleDateFormat" %>
<g:set var="contributionService" bean="contributionService"/>
<g:set var="projectService" bean="projectService"/>
<g:set var="userService" bean="userService"/>
<%
    def percentage = contributionService.getPercentageContributionForProject(project)
    boolean ended = projectService.isProjectDeadlineCrossed(project)
%>
<html>
<head>
<meta name="layout" content="main" />
<r:require modules="projectshowjs"/>
<r:require modules="rewardjs"/>
</head>
<body>
<div class="feducontent">
	<div class="container">
		<g:if test="${project}">
            <div class="row">
                <div class="col-md-12">
                	<h1>
                        <g:link controller="project" action="show" id="${project.id}" title="${project.title}">${project.title}</g:link>
                    </h1>
                    <h4 class="lead">Beneficiary: ${projectService.getBeneficiaryName(project)}</h4>
                    <g:if test="${flash}">
                        <div class="alert alert-success">
                            <li>${flash.message}</li>
                        </div>
                    </g:if>

                    <ul class="nav nav-tabs nav-justified" style="margin-bottom: 10px;">
                        <li class="active"><a href="#essentials" data-toggle="tab">
                            <span class="fa fa-leaf"></span> Essentials
                        </a></li>
                        <li><a href="#rewards" data-toggle="tab">
                            <i class="fa fa-gift fa-lg"></i> Manage rewards
                        </a></li>
                        <li><a href="#contributions" data-toggle="tab">
                            <span class="fa fa-tint"></span> Contributions
                        </a></li>
                        <li><a href="#comments" data-toggle="tab">
                            <span class="fa fa-comments"></span> Comments
                        </a></li>
                    </ul>

                    <!-- Tab panes -->
                    <div class="tab-content">
                        <div class="tab-pane active" id="essentials">
                            <g:render template="/project/manageproject/essentials"/>
                        </div>
                        <div class="tab-pane" id="rewards">
                            <g:render template="/project/manageproject/rewards"/>
                        </div>
                        <div class="tab-pane" id="contributions">
                            <g:render template="/project/manageproject/contributions"/>
                        </div>
                        <div class="tab-pane" id="comments">
                            <g:render template="/project/manageproject/comments"/>
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
			<div class="alert alert-danger">Oh snap! Looks like that project doesn't exist.</div>
		</g:else>
	</div>
</div>
</body>
</html>
