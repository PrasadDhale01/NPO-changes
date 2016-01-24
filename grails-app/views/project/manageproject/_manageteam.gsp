<g:set var="contributionService" bean="contributionService" />
<g:set var="projectService" bean="projectService" />
<g:set var="userService" bean="userService"/>
<%
    def userName = user.firstName +" "+ user.lastName
    def teams = project.teams
%>
<div class="col-md-12 col-sm-12 col-xs-12"></div>
<div class="pill-buttons">
<g:if test="${project.validated}">
    <g:if test="${!teams.isEmpty()}">
        <g:if test="${isCampaignOwnerOrAdmin}">
		    <ul class="nav nav-pills nav-pills-manageteam  mange-active-teams-mobile">
                <li data-toggle="tab" class="active team-footer col-md-3 col-sm-4 col-xs-12 manage-team-btn-tabsmargin">
                    <a href="#manageTeams" class="text-center teammembers" id="loadTeamPage">
                        ${totalteams.size()}&nbsp;&nbsp;Teams <g:if test="${discardedTeam.size() > 0}">&nbsp;&nbsp;(${discardedTeam.size()}&nbsp;&nbsp;Disabled)</g:if>
                    </a>
                </li>
                <li data-toggle="tab" class="col-md-3 col-sm-4 col-xs-12 button-team-footer manage-mobile-btn">
                    <a class="col-md-12 col-sm-12 col-xs-12 btn btn-default btn-md inviteteammember activitydropdown dropdown-toggle" data-toggle="dropdown" aria-expanded="false">
                        Activity <span class="caret"></span>
                    </a>
                    <ul class="dropdown-menu" role="menu">
                        <li><a class="list" href="#teamValidation"><span class="fa fa-users"></span> &nbsp;&nbsp;Validate Team</a></li>
                        <li><a class="list" href="#campaignStatistics"><span class="glyphicon glyphicon-list-alt"></span> &nbsp;&nbsp;Campaign Statistics </a></li>
                        <li>
                            <g:if test="${!ended}">
                                <a class="list" href="#" onclick="javascript:window.open('/project/redirectToInviteMember?projectId=${project.id}&page=manage','', 'menubar=no,toolbar=no,resizable=no,scrollbars=yes,height=500,width=786');return false;" data-toggle="modal"><span class="glyphicon glyphicon-user"></span> &nbsp;&nbsp;Invite Members </a>
                            </g:if>
                            <g:else>
                                <a class="list"><span class="glyphicon glyphicon-user"></span> &nbsp;&nbsp;Invite Members </a>
                            </g:else>
				        </li>
			        </ul>
                </li>
		    </ul>
		</g:if>
		<div class="teamtileseperator"></div>

        <div class="tab-content">
            <div class="tab-pane active col-md-12 col-sm-12 col-xs-12 col-xs-p-0" id="manageTeam">
                <div class="teamList" id="teamList">
                    <g:render template="manageproject/teamgrid"/>
                </div>
            </div>
            <div class="tab-pane col-md-12 col-sm-12 col-xs-12" id="teamValidation">
                <g:render template="manageproject/teamvalidationIndex"/>
            </div>
            <div class="tab-pane col-md-12 col-sm-12 col-xs-12" id="campaignStatistics">
                <g:render template="manageproject/campaignStatisticsIndex" model="[teams:totalteams]"/>
            </div>
        </div>
    </g:if>
</g:if>
<g:else>
    <div class="col-md-12 col-sm-12 col-xs-12 alert alert-info">You can manage your team once the campaign is published.</div>
</g:else>
</div>

<%-- Modal --%>
<%--<div class="modal fade" id="inviteTeamMember" tabindex="-1" role="dialog" aria-hidden="true">--%>
<%--    <g:form action="inviteTeamMember" id="${project.id}" class="mng-inviteTeamMember">--%>
<%--        <div class="modal-dialog">--%>
<%--            <div class="modal-content">--%>
<%--                <div class="modal-header">--%>
<%--                    <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>--%>
<%--                    <h4 class="modal-title">Invite Team Members</h4>--%>
<%--                </div>--%>
<%--                <div class="modal-body">--%>
<%--                    <g:hiddenField name="amount" value="${project.amount}"/>--%>
<%--                    <g:hiddenField name="ismanagepage" value="managepage" />--%>
<%--                    <div class="form-group">--%>
<%--                        <label>Name</label>--%>
<%--                        <input type="text" class="form-control all-place" name="username" value="${userName}" placeholder="Name">--%>
<%--                    </div>--%>
<%--                    <div class="form-group">--%>
<%--                        <label>Email ID's (separated by comma)</label>--%>
<%--                        <textarea class="form-control all-place" name="emailIds" rows="4" placeholder="Email ID's"></textarea>--%>
<%--                    </div>--%>
<%--                    <div class="form-group">--%>
<%--                        <label>Message (Optional)</label>--%>
<%--                        <textarea class="form-control all-place" name="teammessage" rows="4" placeholder="Message"></textarea>--%>
<%--                    </div>--%>
<%--                </div>--%>
<%--                <div class="modal-footer">--%>
<%--                    <button type="submit" class="btn btn-primary btn-block" id="btnSendInvitationMng">Send Invitation</button>--%>
<%--                </div>--%>
<%--            </div>--%>
<%--        </div>--%>
<%--    </g:form>--%>
<%--</div>--%>
