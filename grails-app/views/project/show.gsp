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
    <h3>
        <a href="${project.id}">${project.title}</a>
    </h3>
    <g:if test="${project.validated == false}">
        <div class="alert alert-warning">This project is not yet published.</div>
    </g:if>
    <g:else>
        <div class="row">
            <div class="col-xs-12 col-sm-6 col-md-8">
                <div class="well well-sm">
                    <div class="row">
                        <div class="col-sm-6 col-md-4">
                            <img src="http://lorempixel.com/300/250/abstract" alt="" class="img-rounded img-responsive" />
                        </div>
                        <div class="col-sm-6 col-md-8">
                            <h4>${project.name}</h4>
                            <cite title="${project.city}, ${project.country}">${project.city}, ${project.country}</cite>
                            <p>
                                <br />
                                <i class="glyphicon glyphicon-chevron-right"></i>Title: ${project.title}
                                <br />
                                <i class="glyphicon glyphicon-chevron-right"></i>Email: ${project.email}
                                <br />
                                <i class="glyphicon glyphicon-chevron-right"></i>Telephone: ${project.telephone}
                                <br />
                                <i class="glyphicon glyphicon-chevron-right"></i>Amount: $${project.amount}
                                <br />
                                <i class="glyphicon glyphicon-chevron-right"></i>Days: ${project.days}
                                <br />
                                <i class="glyphicon glyphicon-chevron-right"></i>Story: ${project.story}
                            </p>
                            <!-- Split button -->
                            %{--<div class="btn-group">--}%
                                %{--<button type="button" class="btn btn-primary">--}%
                                    %{--Social</button>--}%
                                %{--<button type="button" class="btn btn-primary dropdown-toggle" data-toggle="dropdown">--}%
                                    %{--<span class="caret"></span><span class="sr-only">Social</span>--}%
                                %{--</button>--}%
                                %{--<ul class="dropdown-menu" role="menu">--}%
                                    %{--<li><a href="https://twitter.com/fundedu">Twitter</a></li>--}%
                                    %{--<li><a href="https://plus.google.com/116179241374753157553/posts">Google +</a></li>--}%
                                    %{--<li><a href="https://www.facebook.com/FundEdu">Facebook</a></li>--}%
                                %{--</ul>--}%
                            %{--</div>--}%
                        </div>
                    </div>
                </div>
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
    </g:else>

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
