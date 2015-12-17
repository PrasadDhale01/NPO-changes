<g:if test="${supporterList.isEmpty()}">
    <div class="center-block col-xs-12 userprfl-warning">
        You haven't supported to any campaign yet. You can start supporting now.<br>
        <g:link controller="project" action="list" class="btn btn-default btn-sm btn-info">Support</g:link>
    </div>
</g:if>
<g:else>
    <ul class="timeline">
        <%
            def index = 0
        %>
        <g:each in="${supporterList}" var="supportList">
            <g:if test="${index++ % 2 == 0}">
                <li>
            </g:if>
            <g:else>
                <li class="timeline-inverted">
            </g:else>
                <g:if test='${supportList.key.contains('project')}'><div class="timeline-badge info hidden-xs"><i class="fa fa-leaf"></i></div></g:if>
            	<g:if test='${supportList.key.contains('co-owner')}'><div class="timeline-badge info hidden-xs"><i class="fa fa-user"></i></div></g:if>
            	<g:if test='${supportList.key.contains('team')}'><div class="timeline-badge info hidden-xs"><i class="fa fa-users"></i></div></g:if>
            	<g:if test='${supportList.key.contains('supporter')}'><div class="timeline-badge info hidden-xs"><i class="fa fa-heart"></i></div></g:if>
                <div class="timeline-panel">
                    <div class="timeline-heading">
                        <h4 class="timeline-title">
                        	<g:if test='${supportList.key.contains('supporter')}'>Supported campaign : <br> <h5>${supportList.value.substring(0, supportList.value.indexOf(';'))}</h5></g:if>
                        	<g:elseif test='${supportList.key.contains('project')}'>Created campaign : <br> <h5>${supportList.value.substring(0, supportList.value.indexOf(';'))}</h5></g:elseif>
                        	<g:elseif test='${supportList.key.contains('team')}'>Joined campaign : <br> <h5>${supportList.value.substring(0, supportList.value.indexOf(';'))}</h5></g:elseif>
                        	<g:elseif test='${supportList.key.contains('co-owner')}'>Campaign co-owner : <br> <h5>${supportList.value.substring(0, supportList.value.indexOf(';'))}</h5></g:elseif>
                        </h4>
                        
                        <p><small class="text-muted">
                            <i class="glyphicon glyphicon-time"></i> On ${supportList.value.substring(supportList.value.indexOf(';') + 1 )}
                        </small></p> 
                    </div>
                    <div class="timeline-body setting-user-contributions">
                    </div>
                </div>
            </li>
        </g:each>
    </ul>
</g:else>
