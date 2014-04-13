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
</head>
<body>
<div class="feducontent">
	<div class="container">
		<g:if test="${project}">
            <div class="row">
                <div class="col-md-8">
                    <h1>
                        <a href="${project.id}">${project.title}</a>
                    </h1>
                    <h4 class="lead">Beneficiary: ${project.name}</h4>

                    <ul class="nav nav-pills nav-justified" style="margin-bottom: 10px;">
                        <li class="active"><a href="#essentials" data-toggle="tab">
                            <span class="glyphicon glyphicon-leaf"></span> Essentials
                        </a></li>
                        <li><a href="#rewards" data-toggle="tab">
                            <i class="fa fa-gift fa-lg"></i> Rewards
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
                            <p class="text-justify">${project.story}</p>
                        </div>
                        <div class="tab-pane" id="rewards">
                            <g:render template="show/rewards"/>
                        </div>
                        <div class="tab-pane" id="contributions">
                            <g:render template="show/contributions"/>
                        </div>
                        <div class="tab-pane" id="comments">
                            <g:render template="show/comments"/>
                        </div>
                    </div>

                </div>
                <div class="col-md-4">
                    <g:if test="${percentage == 100}">
                        <button type="button" class="btn btn-success btn-lg btn-block" disabled>SUCCESSFULLY FUNDED</button>
                    </g:if>
                    <g:elseif test="${ended}">
                        <button type="button" class="btn btn-warning btn-lg btn-block" disabled>PROJECT ENDED!</button>
                    </g:elseif>
                    <g:else>
                        <a href="/projects/${project.id}/fund" class="btn btn-primary btn-lg btn-block" role="button">Fund this project</a>
                    </g:else>

                    <g:render template="/layouts/singletile"/>
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
