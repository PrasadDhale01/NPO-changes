<g:set var="projectService" bean="projectService" />
<%@ page import="java.text.SimpleDateFormat" %>
<%
				SimpleDateFormat dateFormat = new SimpleDateFormat("MMM d, YYYY");
				def index = 1;
				def base_url = grailsApplication.config.crowdera.BASE_URL
%>
<g:if test="${contributions.size() == 0}">
    <div class="col-sm-12">
        <div class="alert alert-info">
            You haven't contributed to any campaign yet. You can start contributing <g:link controller="project" action="list">here</g:link>.
        </div>
    </div>
</g:if>
<g:else>
				<g:each in="${totalContributions}" var="contribution">
								<% 
											def project = contribution.project
											def username = project.user.username
											def fbShareUrl = base_url+"/campaigns/"+project.id+"?fr="+username
								%>
        <g:if test="${activeTab == 'contributions'}">
            <g:if test="${ index % 2 == 0}">
                <div class="contribution-col-padding-left col-md-5 col-lg-5 col-sm-6 col-xs-12">
                    <div class="contributiontimeline">
                        <div class="timeline-panel">
                            <div class="timeline-body setting-user-contributions">
                                <g:render template="/user/user/dashboardtile" model="['project': contribution.project, 'usercontributions': 'usercontributions', 'fbShareUrl': fbShareUrl, 'index': index]"></g:render>
                            </div>
                        </div>
                    </div>
                </div>
           </g:if>
            <g:else>
                <div class="contribution-col-padding-left col-md-offset-1 col-lg-offset-1 col-md-5 col-lg-5 col-sm-6 col-xs-12">
                    <div class="contributiontimeline">
                        <div class="timeline-panel">
                            <div class="timeline-body setting-user-contributions">
                                <g:render template="/user/user/dashboardtile" model="['project': contribution.project, 'usercontributions': 'usercontributions', 'fbShareUrl': fbShareUrl, 'index': index]"></g:render>
                            </div>
                        </div>
                    </div>
                </div>
            </g:else>
        </g:if>
        <g:else>
            <div class="contribution-col-padding-left col-md-12 col-lg-12 sol-sm-12 col-xs-12">
                <div class="contributiontimeline">
                    <div class="timeline-panel">
                        <div class="timeline-body setting-user-contributions">
                            <g:render template="/user/user/dashboardtile" model="['project': contribution.project, 'usercontributions': 'usercontributions', 'fbShareUrl': fbShareUrl, 'index': index]"></g:render>
                        </div>
                    </div>
                </div>
            </div>
        </g:else>
        
        <script>
            $("a.fbshareUrl").click(function(){
                var url = $(this).attr('href');
                window.open(url, 'Share on FaceBook', 'left=20,top=20,width=600,height=500,toolbar=0,menubar=0,scrollbars=0,location=0,resizable=1');
                return false;
            });
        </script>
        <% index++ %>
    </g:each>
    <g:if test="${activeTab == 'contributions'}">
        <div class="clear"></div>
        <div class="usersContributionsPagination pull-right" id="usersContributionsPagination">
            <g:paginate controller="user" max="4" maxsteps= "5" action="contributionspagination" total="${contributions.size()}"/>
        </div>
        <script>
            $('#usersContributionsPagination a').click(function(event) {
                event.preventDefault();
                var url = $(this).attr('href');
                var grid = $(this).parents('#userDashboardcontributions');
                ajaxCall(url, grid);
            });
        
            function ajaxCall(url, grid) {
                $.ajax({
                    type: 'GET',
                    url: url,
                    success: function(data) {
                        $(grid).fadeOut('fast', function() {$(this).html(data).fadeIn('fast');});
                    }
                });
            }
        </script>
        
    </g:if>
</g:else>
