<%@ page import="java.text.SimpleDateFormat"%>
<g:set var="contributionService" bean="contributionService" />
<g:set var="projectService" bean="projectService" />
<%
    def isFundingAchieved = contributionService.isFundingAchievedForProject(project)
    def percentage = contributionService.getPercentageContributionForProject(project)
    def achievedDate
    if (isFundingAchieved) {
        achievedDate = contributionService.getFundingAchievedDate(project)
    }
    def endDate = projectService.getProjectEndDate(project)
    boolean ended = projectService.isProjectDeadlineCrossed(project)
    def isFundingOpen = projectService.isFundingOpen(project)
    def contributedSoFar = contributionService.getTotalContributionForProject(project)
    def contribution = projectService.getDataType(contributedSoFar)
    def amount = projectService.getDataType(project.amount)

    def user = userService.getCurrentUser()
    def username = user.username
    def iscampaignAdmin = userService.isCampaignBeneficiaryOrAdmin(project, user)
	def team = project.teams
	def isTeamAdmin = projectService.isTeamAdmin(project)
    
    SimpleDateFormat dateFormat = new SimpleDateFormat("MMM d");
    def cents
    if(percentage >= 100) {
        cents = 100
    } else {
        cents = percentage
    }
%>
<div class="fedu thumbnail grow user-tiles-style">
	<div class="blacknwhite tile">
	    <g:if test="${iscampaignAdmin}">
			<g:form controller="project" action="manageproject" title="${project.title}" class="manageProjectForm" params="['fundraiser': user.firstName,'projectTitle':project.title.replaceAll(' ', '-')]">
				<g:hiddenField name="id" value="${project.id}"/>
                <g:hiddenField name="fr" value="${username}"/>
				<div class="imageWithTag">
					<div class="under">
						<img alt="${project.title}" onclick="manageProjectImageClickable(this)" class="project-img" src="${projectService.getProjectImageLink(project)}"/>
					</div>
					<g:if test="${project.draft}">
						<div class="over user-tiles-widths">
							<img src="//s3.amazonaws.com/crowdera/assets/draft.png" alt="draft"/>
						</div>
					</g:if>
					<g:elseif test="${project.rejected}">
						<div class="over user-tiles-widths">
							<img src="//s3.amazonaws.com/crowdera/assets/rejected.png"  alt="rejected"/>
						</div>
					</g:elseif>
					<g:elseif test="${!project.validated}">
						<div class="over user-tiles-widths">
							<img src="//s3.amazonaws.com/crowdera/assets/PENDING.png" alt="PENDING"/>
						</div>
					</g:elseif>
					<g:elseif test="${ended}">
					    <div class="over user-tiles-widths">
							<img src="//s3.amazonaws.com/crowdera/assets/ended.png" alt="ended"/>
						</div>
					</g:elseif>
					<g:elseif test="${percentage >= 75}">
				    	<div class="over user-tiles-widths">
							<img src="//s3.amazonaws.com/crowdera/assets/funded1.png" alt="Funded"/>
						</div>
					</g:elseif>
					<g:elseif test="${project.validated}">
						<g:if test="${user == project.user}">
						    <div class="over user-tiles-widths">
								<img src="//s3.amazonaws.com/crowdera/assets/OWNER.png" alt="Owner"/>
							</div>
						</g:if>
						<g:elseif test="${isTeamAdmin}">
						    <div class="over user-tiles-widths">
                                <img src="//s3.amazonaws.com/crowdera/assets/Co-Owner1.png" alt="co-owner"/>
                            </div>
                        </g:elseif>
						<g:else>
							<div class="over user-tiles-widths">
								<img src="//s3.amazonaws.com/crowdera/assets/PENDING.png" alt="Pending"/>
							</div>
						</g:else>
					</g:elseif>
					<g:elseif test="${isTeamAdmin}">
					    <div class="over user-tiles-widths">
							<img src="//s3.amazonaws.com/crowdera/assets/OWNER.png" alt="Owner"/>
						</div>
					</g:elseif>
					<g:else>
					    <div class="over user-tiles-widths">
							<img src="//s3.amazonaws.com/crowdera/assets/teamTop.png" alt="Team top"/>
						</div>
					</g:else>
				</div>
			</g:form>
		</g:if>
		<g:else>
		    <g:form controller="project" action="show" class="teamsMangageForm" params="['fundraiser': user.firstName,'projectTitle':project.title.replaceAll(' ', '-')]" title="${project.title}">
				<g:hiddenField name="id" value="${project.id}"/>
                <g:hiddenField name="fr" value="${username}"/>
				<div class="imageWithTag">
					<div class="under">
						<img alt="${project.title}" class="project-img" src="${projectService.getProjectImageLink(project)}"/>
					</div>
					<g:if test="${project.draft}">
						<div class="over user-tiles-widths">
							<img src="//s3.amazonaws.com/crowdera/assets/draft.png" onclick="teamsClickableImage(this)" alt="draft"/>
						</div>
					</g:if>
					<g:elseif test="${project.rejected}">
						<div class="over user-tiles-widths">
							<img src="//s3.amazonaws.com/crowdera/assets/rejected.png" alt="rejected"/>
						</div>
					</g:elseif>
					<g:elseif test="${!project.validated}">
						<div class="over user-tiles-widths">
							<img src="//s3.amazonaws.com/crowdera/assets/PENDING.png" alt="Pending"/>
						</div>
					</g:elseif>
					<g:elseif test="${ended}">
					    <div class="over user-tiles-widths">
							<img src="//s3.amazonaws.com/crowdera/assets/ended.png" alt="ended"/>
						</div>
					</g:elseif>
					<g:elseif test="${percentage >= 75}">
				    	<div class="over user-tiles-widths">
							<img src="//s3.amazonaws.com/crowdera/assets/funded1.png" alt="Funded"/>
						</div>
					</g:elseif>
					<g:if test="${isTeamAdmin}">
					    <div class="over teamtile-banner">
							<img src="//s3.amazonaws.com/crowdera/assets/OWNER.png" alt="Owner"/>
						</div>
					</g:if>
					<g:else>
					    <div class="over teamtile-banner">
							<img src="//s3.amazonaws.com/crowdera/assets/teamTop.png" alt="Team top"/>
						</div>
					</g:else>
				</div>
			</g:form>
		</g:else>
	</div>

	<div class="caption">
		<div class="project-title">
		    <g:if test="${iscampaignAdmin}">
				<g:form controller="project" action="manageproject" class="teamsManageProjectForm" params="['fundraiser': user.firstName,'projectTitle':project.title.replaceAll(' ', '-')]" title="${project.title}">
			        <g:hiddenField name="id" value="${project.id}"/>
                    <g:hiddenField name="fr" value="${username}"/>
			        <a onclick="teamsManageProjectTitleClickable(this)">${project.title}</a>
			    </g:form>
		    </g:if>
		    <g:else>
		        <g:form controller="project" action="show" class="manageProjectTitleForm" params="['fundraiser': user.firstName,'projectTitle':project.title.replaceAll(' ', '-')]" title="${project.title}">
			        <g:hiddenField name="id" value="${project.id}"/>
                    <g:hiddenField name="fr" value="${username}"/>
			        <a onclick="manageProjectTitleClickable(this)">${project.title}</a>
			    </g:form>
		    </g:else>
		</div>
		<hr class="tile-separator">
		<div class="project-story-span">
			${project.description}
		</div>
	</div>

	<div class="modal-footer tile-footer"
		style="text-align: left; margin-bottom: 2px;">
		<div class="row tilepadding">
			<div class="col-sm-5 col-sm-offset-1 col-xs-5 col-xs-offset-1 progress-pie-chart" data-percent="43">
				<div class="c100 p${cents} small text-center">
					<span> ${percentage}%
					</span>
					<div class="slice">
						<div class="bar"></div>
						<div class="fill"></div>
					</div>
				</div>
			</div>
			<g:if test="${isFundingAchieved}">
				<div class="col-md-6 col-xs-6">
					<h6 class="text-center user-achived-raised">
						<span class="lead">$${contribution}</span><br />ACHIEVED
					</h6>
				</div>
			</g:if>
			<g:else>
			    <div class="col-md-6 col-xs-6">
					<h6 class="text-center user-achived-raised">
						<span class="lead">$${contribution}</span><br />RAISED
					</h6>
				</div>
			</g:else>
		</div>
	</div>
	<div class="modal-footer tile-footer user-goal">
		<div class="row tilepadding">
			<div class="col-md-6 col-xs-6">
                <h6 class="text-center"><span class="lead">$${amount}</span><br/>GOAL</h6>
            </div>
            <g:if test="${ended}">
                <div class="col-md-6 col-xs-6">
                    <h6 class="text-center"><span class="lead">0</span><br>DAYS TO GO</h6>
                </div>
            </g:if>
            <g:else>
                <!-- Time left till end date. -->
                <div class="col-md-6 col-xs-6">
                    <h6 class="text-center"><span class="lead">${projectService.getRemainingDay(project)}</span><br>DAYS TO GO</h6>
                </div>
            </g:else>
		</div>

		<div class="modal-footer tile-footer user-footer-icon">
			<div class="row">
                <g:if test="${!project.validated || username.equals('campaignadmin@crowdera.co') }">
                    <g:form controller="project" action="projectdelete" method="post" params="['fundraiser': user.firstName,'projectTitle':project.title.replaceAll(' ', '-')]">
                        <g:hiddenField name="id" value="${project.id}"/>
                        <g:hiddenField name="fr" value="${username}"/>
                        <button class="projectedit close pull-right" id="projectdelete"
                         onclick="return confirm(&#39;Are you sure you want to discard this campaign?&#39;);">
                            <i class="glyphicon glyphicon-trash"></i>
                        </button>
                    </g:form>
                </g:if>
                <g:if test="${isTeamAdmin || (user==project.user)}">
                	<g:form controller="project" action="edit" method="post" params="['fundraiser': user.firstName,'projectTitle':project.title.replaceAll(' ', '-')]">
                    	<g:hiddenField name="projectId" value="${project.id}" />
                        <g:hiddenField name="fr" value="${username}"/>
                    	<button class="projectedit close pull-right" id="editproject">
                        	<i class="glyphicon glyphicon-edit"></i>
                    	</button>
                	</g:form>
                	<g:form controller="project" action="manageproject" method="post" params="['fundraiser': user.firstName,'projectTitle':project.title.replaceAll(' ', '-')]">
                    	<g:hiddenField name="id" value="${project.id}"/>
                        <g:hiddenField name="fr" value="${username}"/>
                    	<button class="projectedit close pull-right" id="projectpreview">
                        	<i class="glyphicon glyphicon-picture"></i>
                    	</button>
                	</g:form>
                </g:if>
                <g:else>
                	<button class="projectedit close pull-right" id="editproject" name="editproject"
               	   	 data-toggle="popover">
                       	<i class="glyphicon glyphicon-edit"></i>
                   	</button>
                   	<button class="projectedit close pull-right" id="projectpreview" name="projectpreview"
                   	 data-toggle="popover">
                       	<i class="glyphicon glyphicon-picture"></i>
                   	</button>
                </g:else>
			</div>
		</div>
	</div>
</div>
