<html>
<head>
<meta name="layout" content="main" />
<r:require modules="projectshowjs"/>
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
                            <h3 class="panel-title">Fund this project</h3>
                        </div>
                        <div class="panel-body">
                            <g:if test="${percentage == 100}">
                                <button type="button" class="btn btn-success btn-block" disabled>SUCCESSFULLY FUNDED</button>
                            </g:if>
                            <g:elseif test="${ended}">
                                <button type="button" class="btn btn-warning btn-block" disabled>PROJECT ENDED!</button>
                                <h4>Ended on ${dateFormat.format(endDate.getTime())}</h4>
                            </g:elseif>
                            <g:else>
                                <h4>Ends on ${dateFormat.format(endDate.getTime())}</h4>

                                <div class="list-group">
                                    <g:each in="${project.rewards}" var="reward">
                                        <a href="#" class="list-group-item">
                                            <h4 class="list-group-item-heading">${reward.title}</h4>
                                            <h5 class="list-group-item-heading lead">$${reward.price}</h5>
                                            <p class="list-group-item-text text-justify">${reward.description}</p>
                                        </a>
                                    </g:each>
                                </div>
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
            <!-- Comments -->
            <sec:ifLoggedIn>
                <g:if test="${flash.commentmessage}">
                    <div class="alert alert-danger">${flash.commentmessage}</div>
                </g:if>
                <h4 class="lead">Leave a comment</h4>
                <g:form controller="project" action="savecomment" role="form" id="${project.id}">
                    <div class="form-group">
                        <textarea class="form-control" name="comment" rows="4" required="true"></textarea>
                    </div>
                    <button type="submit" class="btn btn-default pull-right">Post comment</button>
                </g:form>
            </sec:ifLoggedIn>

            <g:if test="${!project.comments.empty}">
                <h4 class="lead">Comments</h4>
                <dl class="dl">
                    <g:each in="${project.comments}" var="comment">
                        <hr>
                        <dt>${comment.user.username}</dt>
                        <dd>${comment.comment}</dd>
                    </g:each>
                </dl>
            </g:if>
		</g:if>
		<g:else>
            <h1>Project not found</h1>
			<div class="alert alert-danger">Oh snap! Looks like that project doesn't exist.</div>
		</g:else>
	</div>
</body>
</html>
