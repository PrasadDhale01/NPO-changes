<%@ page import="fedu.CommunityInvite" %>
<g:set var="userService" bean="userService"/>
<g:set var="communityInviteService" bean="communityInviteService"/>
<div class="panel panel-default">
    <div class="panel-heading">
        <h3 class="panel-title"><i class="fa fa-user"></i> Pending Invites</h3>
    </div>
    <div class="panel-body">
        <div class="list-group">
            <%
                List<CommunityInvite> invitees = communityInviteService.getPendingInviteesForCommunity(community)
            %>
            <g:if test="${invitees.isEmpty()}">
                <div class="list-group-item">No pending invites</div>
            </g:if>
            <g:else>
                <g:each in="${invitees}" var="invitee">
                    <g:if test="${!invitee.accepted}">
                        <div class="list-group-item">
                            ${userService.getFriendlyFullName(invitee.user)}
                            <g:if test="${userService.getFriendlyFullName(invitee.user) != invitee.user.email}">
                                &nbsp;(${invitee.user.email})
                            </g:if>
                        </div>
                    </g:if>
                </g:each>
            </g:else>
        </div>
        <div>
            <g:form method="POST" role="form" action="invite">
                <g:hiddenField name="communityId" value="${community.id}"/>

                <div class="form-group">
                    <label for="emails">Enter comma-separated emails to invite existing users to community:</label>
                    <textarea name="emails" class="form-control" rows="3" id="emails" placeholder="Emails (comma-separated)"></textarea>
                </div>
                <g:if test="${flash.invalidemails}">
                    <div class="alert alert-danger">
                        Some emails are invalid. Please fix and try again: <br>
                        ${flash.invalidemails}
                    </div>
                </g:if>
                <g:if test="${flash.nonexistentusers}">
                    <div class="alert alert-warning">
                        Users with these emails do not exist yet. Make sure all the emails are registered: <br>
                        ${flash.nonexistentusers}
                    </div>
                </g:if>
                <g:if test="${flash.existingmembers}">
                    <div class="alert alert-success">
                        These users are already members of this community: <br>
                        ${flash.existingmembers}
                    </div>
                </g:if>
                <button type="submit" class="btn btn-default">Invite users to community</button>
            </g:form>
        </div>
    </div>
</div>
