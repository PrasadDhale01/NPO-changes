<%@ page import="java.text.SimpleDateFormat" %>
<g:set var="contributionService" bean="contributionService"/>
<g:set var="projectService" bean="projectService"/>
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

    SimpleDateFormat dateFormat = new SimpleDateFormat("MMM d");
%>
<g:render template="/layouts/organizationdetails"/>
<div class="fedu thumbnail grow" style="padding: 0">
<%--    <div style="height: 200px; overflow: hidden;" class="blacknwhite" onmouseover="showNavigation()" onmouseleave="hideNavigation()">--%>
<%--        <g:link controller="project" action="show" id="${project.id}" title="${project.title}">--%>
<%--            <div style="height: 200px; overflow: hidden; width: 100%;" class="blacknwhite" >--%>
<%--                <g:render template="/project/manageproject/projectimagescarousel"/>--%>
<%--            </div>--%>
<%--        </g:link>--%>
<%--    </div>--%>

    <div class="modal-footer tile-footer" style="text-align: left; margin-top: 0; margin-bottom: 2px;">
        <div class="row">
            <div class="col-sm-5 col-sm-offset-1 progress-pie-chart" data-percent="43">
				<div class="c100 p${percentage} small text-center">
                    <span>${percentage}%</span>
                    <div class="slice">
                        <div class="bar"></div>
                        <div class="fill"></div>
                    </div>
                </div>
            </div>
            <div class="col-md-6">
                <h6 class="text-center" style="margin-top: 10px;"><span class="lead">$${contributedSoFar}</span><br/>ACHIEVED</h6>
            </div>
        </div>
    </div>
    <div class="modal-footer tile-footer" style="text-align: left; margin-top: 0; margin-bottom: 2px;">
        <div class="row">
            <div class="col-md-6">
                <h6 class="text-center"><span class="lead">$${project.amount}</span><br/>GOAL</h6>
            </div>
            <g:if test="${ended}">
                <g:if test="${isFundingAchieved}">
                    <!-- Funding achieved in time. -->
                    <div class="col-md-6">
                        <h6 class="text-center"><span class="lead">${dateFormat.format(achievedDate.getTime())}</span><br>ACHIEVED</h6>
                    </div>
                </g:if>
                <g:else>
                    <!-- Funding not achieved in time. -->
                    <div class="col-md-6">
                        <h6 class="text-center"><span class="lead">${dateFormat.format(endDate.getTime())}</span><br>ENDED</h6>
                    </div>
                </g:else>
            </g:if>
            <g:else>
                <!-- Time left till end date. -->
                <div class="col-md-6">
                    <h6 class="text-center"><span class="lead">${projectService.getRemainingDay()}</span><br>DAYS TO GO</h6>
                </div>
            </g:else>
        </div>
    </div>
    <div class="modal-footer tile-footer" style="text-align: left; margin-top: 0;">
        <div class="row">
            <div class="col-sm-10" align="right" style="right-padding: 0px">
                <% if(percentage <= 100) { %>
            	    <g:form controller="project" action="edit" method="post"  id="${project.id}">
                        <g:hiddenField name="projectId" value="${project.id}"/>               
                        <button class="projectedit close"  aria-label="Edit project" id="editproject">
                            <i class="glyphicon glyphicon-edit" ></i>
               	        </button>
                    </g:form>
                <% } %>
            </div>
            <div class="col-sm-2">
            <g:form controller="project" action="projectdelete" method="post"  id="${project.id}">
                <button class="projectedit close" aria-label="Edit project" id="projectdelete" onclick="return confirm(&#39;Are you sure you want to discard this project?&#39;);">
                    <i class="glyphicon glyphicon-trash" ></i>
                </button>
            </g:form>
            </div>
        </div>
    </div>
    
</div>
