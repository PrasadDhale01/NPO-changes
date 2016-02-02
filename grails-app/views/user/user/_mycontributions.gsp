<%--<g:set var="projectService" bean="projectService" />--%>
<%--<%@ page import="java.text.SimpleDateFormat" %>--%>
<%--<%--%>
<%--    SimpleDateFormat dateFormat = new SimpleDateFormat("MMM d");--%>
<%--%>--%>
<%--<g:if test="${contributions.size() == 0}">--%>
<%--    <div class="alert alert-warning">--%>
<%--        You haven't contributed to any campaign yet. You can start contributing <g:link controller="project" action="list">here</g:link>.--%>
<%--    </div>--%>
<%--</g:if>--%>
<%--<g:else>--%>
<%--    <ul class="timeline">--%>
<%--        <%--%>
<%--            def index = 0--%>
<%--        %>--%>
<%--        <g:each in="${contributions}" var="contribution">--%>
<%--            <g:if test="${index++ % 2 == 0}">--%>
<%--                <li>--%>
<%--            </g:if>--%>
<%--            <g:else>--%>
<%--                <li class="timeline-inverted">--%>
<%--            </g:else>--%>
<%--                <div class="timeline-badge info"><i class="glyphicon glyphicon-credit-card"></i></div>--%>
<%--                <div class="timeline-panel">--%>
<%--                    <div class="timeline-heading">--%>
<%--                        <h4 class="timeline-title">You contributed &nbsp;&nbsp;&nbsp;<b><g:if test="${contribution.project.payuStatus}"><span class="mycontribution fa fa-inr"></span></g:if><g:else>$</g:else>${projectService.getDataType(contribution.amount)}</b></h4>--%>
<%--                        <p><small class="text-muted">--%>
<%--                            <i class="glyphicon glyphicon-time"></i> on ${dateFormat.format(contribution.date)}, towards--%>
<%--                        </small></p>--%>
<%--                    </div>--%>
<%--                    <div class="timeline-body setting-user-contributions">--%>
<%--                        <g:render template="/layouts/tile" model="['project': contribution.project]"></g:render>--%>
<%--                    </div>--%>
<%--                </div>--%>
<%--            </li>--%>
<%--        </g:each>--%>
<%--    </ul>--%>
<%--</g:else>--%>

<g:set var="projectService" bean="projectService" />
<%
    def index = 1;
    def base_url = grailsApplication.config.crowdera.BASE_URL
%>
<g:if test="${totalCampaignSupported.size() == 0}">
    <div class="col-sm-12">
        <div class="alert alert-info">
            You haven't contributed to any campaign yet. You can start contributing <g:link controller="project" action="list">here</g:link>.
        </div>
    </div>
</g:if>
<g:else>
    <g:each in="${totalCampaignSupported}" var="project">
        <% 
            def username = project.user.username
            def fbShareUrl = base_url+"/campaigns/"+project.id+"?fr="+username
        %>
        <div class="col-lg-3 col-md-4 col-sm-6 col-xs-12">
            <div class="contributiontimeline">
                <div class="timeline-panel">
                    <div class="timeline-body setting-user-contributions">
                        <g:render template="/user/user/dashboardtile" model="['project': project, 'usercontributions': 'usercontributions', 'fbShareUrl': fbShareUrl, 'index': index]"></g:render>
                    </div>
                </div>
            </div>
        </div>
        
        <script>
            $("a.fbshareUrl").click(function(){
                var url = $(this).attr('href');
                window.open(url, 'Share on FaceBook', 'left=20,top=20,width=600,height=500,toolbar=0,menubar=0,scrollbars=0,location=0,resizable=1');
                return false;
            });
        </script>
        
    </g:each>
</g:else>
