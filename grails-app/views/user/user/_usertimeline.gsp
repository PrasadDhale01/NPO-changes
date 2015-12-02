<g:if test="${recentActivity.isEmpty()}">
    <div class="center-block col-xs-12 userprfl-warning">
        You haven't done any activity yet. You can start doing now.<br>
        <g:link controller="project" action="list" class="btn btn-default btn-sm btn-info">Activity</g:link>
    </div>
</g:if>
<g:else>
   <ul class="timeline">
        <%
            def index = 0
        %>
        <g:each in="${recentActivity}" var="project">
        	
            <g:if test="${index++ % 2 == 0}">
           <li>
            </g:if>
            <g:else>
                <li class="timeline-inverted">
            </g:else>
                <div class="timeline-badge info hidden-xs"><i class="glyphicon glyphicon-credit-card"></i></div>
                <div class="timeline-panel">
                    <div class="timeline-heading">
                        <h4 class="timeline-title">
                        	<g:if test='${project.key=='project' }'>Created campaign : <br> <h5>${project.value.substring(0, project.value.indexOf(';'))}</h5></g:if>
                        	<g:elseif test='${project.key.contains('update')}'>Updated a campaign : <h5>${project.value.substring(0, project.value.indexOf(';'))}</h5></g:elseif>
                        	<g:elseif test='${project.key.contains('contribution')}'>Contributed : 
                        	    <h5>
                        	        <g:if test="${environment=='testIndia' || environment=='stagingIndia' || environment=='prodIndia'}">
                                        <span class="mycontribution fa fa-inr"></span>
                                    </g:if>
                                    <g:else>$</g:else>${project.value.substring(0, project.value.indexOf(';'))}
                                </h5>
                             </g:elseif>
                        	<g:elseif test='${project.key.contains('perk')}'>Created perk : <br> <h5>${project.value.substring(0, project.value.indexOf(';'))}</h5></g:elseif>
                        	<g:elseif test='${project.key.contains('supporter')}'>Supported campaign : <br> <h5>${project.value.substring(0, project.value.indexOf(';'))}</h5></g:elseif>
                        </h4>
                        
                        <p><small class="text-muted">
                            <i class="glyphicon glyphicon-time"></i>${i} On ${project.value.substring(project.value.indexOf(';') + 1 )}
                        </small></p>
                    </div>
                    <div class="timeline-body setting-user-contributions">
                    </div>
                </div>
            </li>
        </g:each>
    </ul>
                       
</g:else>