<%@ page import="java.text.SimpleDateFormat" %>
<g:set var="contributionService" bean="contributionService"/>
<g:set var="projectService" bean="projectService"/>
<g:set var="userService" bean="userService"/>
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
    def currentUser = userService.getCurrentUser()
    def username = currentUser.username
    SimpleDateFormat dateFormat = new SimpleDateFormat("MMM d");
    def cents
    if(percentage >= 100) {
        cents = 100
    } else {
        cents = percentage
    }
%>
<g:render template="/layouts/organizationdetails" model="['currentFundraiser':currentUser,'username':username]"/>
<g:if test="${validatedPage}">
<g:render template="/layouts/personaldetails" model="['currentFundraiser':currentUser,'username':username, 'project':project]"/>
</g:if>
<div class="fedu thumbnail grow managedetails-edit">
<%--    <div style="height: 200px; overflow: hidden;" class="blacknwhite" onmouseover="showNavigation()" onmouseleave="hideNavigation()">--%>
<%--        <g:link controller="project" action="show" id="${project.id}" title="${project.title}">--%>
<%--            <div style="height: 200px; overflow: hidden; width: 100%;" class="blacknwhite" >--%>
<%--                <g:render template="/project/manageproject/projectimagescarousel"/>--%>
<%--            </div>--%>
<%--        </g:link>--%>
<%--    </div>--%>

    <div class="modal-footer tile-footer managedetails-footer">
        <div class="row tilepadding">
            <div class="col-md-5 col-md-offset-1 col-sm-4 col-sm-offset-2 col-xs-5 col-xs-offset-1 progress-pie-chart" data-percent="43">
				<div class="c100 p${cents} small text-center">
                    <span>${percentage}%</span>
                    <div class="slice">
                        <div class="bar"></div>
                        <div class="fill"></div>
                    </div>
                </div>
            </div>
            <g:if test="${isFundingAchieved}">
				<div class="col-md-6 col-xs-6">
					<h6 class="text-center managedetails-achived-raised">
						<span class="lead">$${contribution}</span><br />ACHIEVED
					</h6>
				</div>
			</g:if>
			<g:else>
			    <div class="col-md-6 col-xs-6">
					<h6 class="text-center  managedetails-achived-raised">
						<span class="lead">$${contribution}</span><br />RAISED
					</h6>
				</div>
			</g:else>
        </div>
    </div>
    <div class="modal-footer tile-footer managedetails-goal">
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
    </div>
    <div class="modal-footer tile-footer managedetails-nine-nine">
        <div class="row">
            <div class="fullwidth pull-right">
                <% if(percentage <= 999) { %>
                    <g:form controller="project" action="edit" method="post"  id="${project.id}">
                        <g:hiddenField name="projectId" value="${project.id}"/>               
                        <button class="projectedit close"  aria-label="Edit project" id="editproject">
                            <i class="glyphicon glyphicon-edit" ></i>
                        </button>
                    </g:form>
                <% } %>
                <g:if test="${!project.validated || username.equals('campaignadmin@crowdera.co') }">
                    <g:form controller="project" action="projectdelete" method="post"  id="${project.id}">
                        <button class="projectedit close" aria-label="Edit project" id="projectdelete" onclick="return confirm(&#39;Are you sure you want to discard this campaign?&#39;);">
                            <i class="glyphicon glyphicon-trash" ></i>
                        </button>
                    </g:form>
                </g:if>
            </div>
        </div>
    </div>
    
</div>
