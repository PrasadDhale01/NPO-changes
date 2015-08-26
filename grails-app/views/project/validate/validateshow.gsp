<%@ page import="java.text.SimpleDateFormat"%>
<g:set var="contributionService" bean="contributionService" />
<g:set var="projectService" bean="projectService" />
<g:set var="userService" bean="userService" />
<%
    def projectTitle = project.title
    if (projectTitle) {
	    projectTitle = projectTitle.toUpperCase(Locale.ENGLISH)
    }
    def currentTeamAmount = currentTeam.amount
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
							<g:link controller="project" action="validateshow" id="${project.id}" title="${project.title}"> ${projectTitle} </g:link>
						</h1>
						</div>
						<div class="col-md-4">
							<div class="col-md-6 col-sm-6 col-xs-6">
								<g:link controller="project" action="updateValidation" id="${project.id}" class="btn-sm btn-primary validatebutton TW-text-decoration" role="button">
									<i class="glyphicon glyphicon-check validateshow-validate"></i>&nbsp;Validate
								</g:link>
							</div>
							<div class="col-md-6 col-sm-6 col-xs-6">
								<g:form action="delete" controller="project" id="${project.id}" method="post">
									<button class="validatebtn btn-sm btn-danger validateshow-discard" name="_action_delete" value="Delete" onclick="return confirm(&#39;Are you sure you want to discard this campaign?&#39;);" style="width: 180">
										<i class="fa fa-trash-o"></i>&nbsp;Discard
									</button>
								</g:form>
							</div>
						</div>
					</div>
				</div><br/>
				<div class="row">
					<div class="col-md-8">
						<ul class="nav nav-tabs nav-justified validateshow-details-story mng-safari-mobile admin-vali-show">
							<li class="active"><a href="#essentials" data-toggle="tab">
									<span class="fa fa-leaf"></span><span class="tab-text hidden-xs"> Story</span>
							</a></li>
							<li><a href="#projectupdates" data-toggle="tab">
								<span class="glyphicon glyphicon-asterisk"></span><span class="tab-text hidden-xs"> Updates</span>
							</a></li>
							<li><a href="#manageTeam" data-toggle="tab">
                            	<span class="fa fa-users"></span><span class="tab-text hidden-xs"> Team</span>
 							</a></li>
							<li><a href="#contributions" data-toggle="tab"> <span
									class="fa fa-tint"></span><span class="tab-text hidden-xs"> Contributions</span>
							</a></li>
							<li><a href="#comments" data-toggle="tab"> <span
									class="fa fa-comments"></span><span class="tab-text hidden-xs"> Comments</span>
							</a></li>
						</ul>

						<!-- Tab panes -->
						<div class="tab-content">
							<div class="tab-pane active" id="essentials">
								<g:render template="/project/show/essentials"  params="['user':project.user]"/>
							</div>
							<div class="tab-pane" id="projectupdates">
                            	<g:render template="show/projectupdates"/>
                         	</div>
                         	<div class="tab-pane" id="manageTeam">
								<g:render template="manageproject/manageteam"/>
							</div>
							<div class="tab-pane" id="contributions">
								<g:render template="manageproject/contributions" model="['team':currentTeam]"/>
							</div>
							<div class="tab-pane" id="comments">
								<g:render template="show/comments"/>
							</div>
						</div>
					</div>

                    <div  class="col-xs-12 col-md-4">
                       <g:render template="/layouts/organizationdetails"/>
                       <g:render template="/layouts/tilesanstitle" model="['currentTeamAmount':currentTeamAmount]"/>
                    </div>
				</div>
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
