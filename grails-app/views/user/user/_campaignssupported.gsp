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
	    <div class="col-md-4 col-sm-6 col-xs-12">
	        <div class="contributiontimeline">
	            <div class="timeline-panel">
	                <div class="timeline-body setting-user-contributions">
	                    <g:render template="/user/user/dashboardtile" model="['project': contribution.project, 'usercontributions': 'usercontributions', 'fbShareUrl': fbShareUrl, 'index': index]"></g:render>
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

<div class="clear"></div>
<div class="usersContributionsPagination text-center" id="usersContributionsPagination">
    <g:paginate controller="user" max="6" maxsteps= "5" action="contributionspagination" params="['userId': user.id]" total="${contributions.size()}"/>
</div>
<script>
    $('#usercontributionpaginate').find('#usersContributionsPagination a').click(function(event) {
        event.preventDefault();
        var url = $(this).attr('href');
        var grid = $(this).parents('#usercontributionpaginate');
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
