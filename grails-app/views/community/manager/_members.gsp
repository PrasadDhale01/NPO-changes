<g:set var="userService" bean="userService"/>
<g:set var="communityService" bean="communityService"/>
<div class="panel panel-default">
    <div class="panel-heading">
        <h3 class="panel-title"><i class="fa fa-user"></i> Community Members</h3>
    </div>
    <div class="panel-body">
        <div class="list-group">
            <g:each in="${communityService.getMembersInCommunity(community)}" var="member">
                <g:if test="${member.enabled}">
                    <div class="list-group-item">
                        ${userService.getFriendlyFullName(member)}
                        <g:if test="${userService.getFriendlyFullName(member) != member.email}">
                            &nbsp;(${member.email})
                        </g:if>
                    </div>
                </g:if>
                <g:else>
                    <div class="list-group-item list-group-item-warning">
                        ${userService.getFriendlyFullName(member)}
                    </div>
                </g:else>
            </g:each>
        </div>
    </div>
</div>
