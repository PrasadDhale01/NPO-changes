<g:if test="${recentActivity.isEmpty()}">
    <g:if test="${user == currentUser }">
        <div class="center-block col-xs-12 userprfl-warning">
           You haven't done any activity yet. You can start doing now.<br>
           <g:link controller="project" action="list" class="btn btn-default btn-sm btn-info">Activity</g:link>
        </div>
    </g:if>
    <g:else>
        <div class="center-block col-xs-12 otherprfl-warning">
           Not done any activity yet. Start doing now.<br>
        </div>
    </g:else>
</g:if>
<g:else>
   <ul class="timeline">
        <%
            def index = 0
        %>
        <g:each in="${recentActivity}" var="rctActivity">
        	
            <g:if test="${index++ % 2 == 0}">
           <li>
            </g:if>
            <g:else>
                <li class="timeline-inverted">
            </g:else>
            	<g:if test='${rctActivity.key.contains('project')}'><div class="timeline-badge info hidden-xs"><i class="fa fa-leaf"></i></div></g:if>
            	<g:if test='${rctActivity.key.contains('contribution')}'><div class="timeline-badge info hidden-xs"><i class="fa fa-credit-card"></i></div></g:if>
            	<g:if test='${rctActivity.key.contains('team')}'><div class="timeline-badge info hidden-xs"><i class="fa fa-users"></i></div></g:if>
            	<g:if test='${rctActivity.key.contains('comment')}'><div class="timeline-badge info hidden-xs"><i class="fa fa-comment"></i></div></g:if>
            	<g:if test='${rctActivity.key.contains('update')}'><div class="timeline-badge info hidden-xs"><i class="fa fa-asterisk"></i></div></g:if>
            	<g:if test='${rctActivity.key.contains('perk')}'><div class="timeline-badge info hidden-xs"><i class="fa fa-gift fa-lg"></i></div></g:if>
            	<g:if test='${rctActivity.key.contains('supporter')}'><div class="timeline-badge info hidden-xs"><i class="fa fa-heart"></i></div></g:if>
                <div class="timeline-panel">
                    <div class="timeline-heading">
                        <h4 class="timeline-title timeline-title-font">
                        	<g:if test='${rctActivity.key.contains('project')}'>Created campaign : <br> <span>${rctActivity.value.substring(0, rctActivity.value.indexOf(';'))}</span></g:if>
                        	<g:elseif test='${rctActivity.key.contains('update')}'>Updated a campaign : <span>${rctActivity.value.substring(0, rctActivity.value.indexOf(';'))}</span></g:elseif>
                        	<g:elseif test='${rctActivity.key.contains('contribution')}'>Contributed : 
                        	    <b>
                        	        <g:if test="${environment=='testIndia' || environment=='stagingIndia' || environment=='prodIndia'}">
                                        <span class="fa fa-inr"></span>
                                    </g:if>
                                    <g:else>$ </g:else>${rctActivity.value.substring(0, rctActivity.value.indexOf(';'))}
                                </b>
                             </g:elseif>
                        	<g:elseif test='${rctActivity.key.contains('perk')}'>Created perk : <br> <span>${rctActivity.value.substring(0, rctActivity.value.indexOf(';'))}</span></g:elseif>
                        	<g:elseif test='${rctActivity.key.contains('supporter')}'>Supported campaign : <br> <span>${rctActivity.value.substring(0, rctActivity.value.indexOf(';'))}</span></g:elseif>
                        	<g:elseif test='${rctActivity.key.contains('team')}'>Joined campaign : <br> <span>${rctActivity.value.substring(0, rctActivity.value.indexOf(';'))}</span></g:elseif>
                        	<g:elseif test='${rctActivity.key.contains('comment')}'>Comment : <br> <span>${rctActivity.value.substring(0, rctActivity.value.indexOf(';'))}</span></g:elseif>
                        </h4>
                        
                        <p><small class="text-muted">
                            <i class="glyphicon glyphicon-time"></i> On ${rctActivity.value.substring(rctActivity.value.indexOf(';') + 1 )}
                        </small></p>
                    </div>
                    <div class="timeline-body setting-user-contributions">
                    </div>
                </div>
            </li>
        </g:each>
    </ul>
</g:else>
