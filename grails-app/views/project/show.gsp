<html>
<head>
<meta name="layout" content="main" />
</head>
<body>
<%@ page import="java.text.SimpleDateFormat" %>
<g:set var="contributionService" bean="contributionService"/>
<g:set var="projectService" bean="projectService"/>
<%
    def percentage = contributionService.getPercentageContributionForProject(project)
    def endDate = projectService.getProjectEndDate(project)
    boolean ended = projectService.isProjectEnded(project)

    SimpleDateFormat dateFormat = new SimpleDateFormat("MMM d");
%>
	<div class="container">
		<g:if test="${project}">
            <div class="row">
                <div class="col-md-8">
                    <h1>
                        <a href="${project.id}">${project.title}</a>
                    </h1>
                    <h4 class="lead">Beneficiary: ${project.name}</h4>
                    <p class="text-justify">${project.story}</p>
                </div>
                <div class="col-md-4">
                    <div class="panel panel-default" style="margin-top: 30px;">
                        <div class="panel-heading">
                            <h3 class="panel-title">Fund</h3>
                        </div>
                        <div class="panel-body">
                            <g:if test="${percentage}">
                                <button type="button" class="btn btn-success btn-block" disabled>SUCCESSFULLY FUNDED</button>
                            </g:if>
                            <g:elseif test="${ended}">
                                <button type="button" class="btn btn-warning btn-block" disabled>PROJECT ENDED!</button>
                                <h4>Ended on ${dateFormat.format(endDate.getTime())}</h4>
                            </g:elseif>
                            <g:else>
                                <button type="button" class="btn btn-primary btn-block">FUND THIS PROJECT</button>
                                <h4>Ends on ${dateFormat.format(endDate.getTime())}</h4>
                            </g:else>
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
</body>
</html>
