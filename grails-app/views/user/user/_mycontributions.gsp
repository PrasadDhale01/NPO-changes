<g:set var="projectService" bean="projectService" />
<%@ page import="java.text.SimpleDateFormat" %>
<%
    SimpleDateFormat dateFormat = new SimpleDateFormat("MMM d");
%>
<g:if test="${contributions.size() == 0}">
    <div class="alert alert-warning">
        You haven't contributed to any campaign yet. You can start contributing <g:link controller="project" action="list">here</g:link>.
    </div>
</g:if>
<g:else>
    <ul class="timeline">
        <%
            def index = 0
        %>
        <g:each in="${contributions}" var="contribution">
            <g:if test="${index++ % 2 == 0}">
                <li>
            </g:if>
            <g:else>
                <li class="timeline-inverted">
            </g:else>
                <div class="timeline-badge info"><i class="glyphicon glyphicon-credit-card"></i></div>
                <div class="timeline-panel">
                    <div class="timeline-heading">
                        <h4 class="timeline-title">You contributed <b>$${projectService.getDataType(contribution.amount)}</b></h4>
                        <p><small class="text-muted">
                            <i class="glyphicon glyphicon-time"></i> on ${dateFormat.format(contribution.date)}, towards
                        </small></p>
                    </div>
                    <div class="timeline-body setting-user-contributions">
                        <g:render template="/layouts/tile" model="['project': contribution.project]"></g:render>
                    </div>
                </div>
            </li>
        </g:each>
    </ul>
</g:else>
