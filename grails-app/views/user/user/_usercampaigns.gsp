<g:if test="${supporters == 0 }">
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
        <g:each in="${recentActivity}" var="project">
            <g:if test='${project.key.contains('supporter')}'>
            <g:if test="${index++ % 2 == 0}">
           <li>
            </g:if>
            <g:else>
                <li class="timeline-inverted">
            </g:else>
                <div class="timeline-badge info"><i class="glyphicon glyphicon-credit-card"></i></div>
                <div class="timeline-panel">
                    <div class="timeline-heading">
                        <h4 class="timeline-title">
                        	<g:if test='${project.key.contains('supporter')}'>You supported : <br> <h5>${project.value.substring(0, project.value.indexOf(';'))}</h5></g:if>
                        </h4>
                        
                        <p><small class="text-muted">
                            <i class="glyphicon glyphicon-time"></i>${i} On ${project.value.substring(project.value.indexOf(';') + 1 )}
                        </small></p>
                    </div>
                    <div class="timeline-body setting-user-contributions">
                    </div>
                </div>
            </li>
           </g:if>
        </g:each>
    </ul>
</g:else>