<html>
   <body>
   
  <div id="fb-root"></div>
    <script>(function(d, s, id) {
        var js, fjs = d.getElementsByTagName(s)[0];
        if (d.getElementById(id)) return;
        js = d.createElement(s); js.id = id;
        js.src = "//connect.facebook.net/en_US/sdk.js#xfbml=1&version=v2.0";
        fjs.parentNode.insertBefore(js, fjs);
        }(document, 'script', 'facebook-jssdk'));
    </script>

<%@ page import="java.text.SimpleDateFormat" %>
<g:set var="contributionService" bean="contributionService"/>
<g:set var="projectService" bean="projectService"/>
<%
    def percentage = contributionService.getPercentageContributionForProject(project)
    def achievedDate
    if (percentage == 100) {
        achievedDate = contributionService.getFundingAchievedDate(project)
    }
    def endDate = projectService.getProjectEndDate(project)
    boolean ended = projectService.isProjectDeadlineCrossed(project)
    def isFundingOpen = projectService.isFundingOpen(project)

    SimpleDateFormat dateFormat = new SimpleDateFormat("MMM d");
%>
    <div class="fedu thumbnail" style="padding: 0; margin-top: 30px;">
        <div style="height: 200px; overflow: hidden;" class="blacknwhite">
            <img alt="${project.title}" style="width: 100%;" src="${projectService.getProjectImageLink(project)}">
        </div>

        <div class="modal-footer" style="text-align: left; margin-top: 0;">
            <div class="row">
                <div class="col-md-6">
                    <h5 class="text-center">GOAL<br/><span class="lead">$${project.amount}</span></h5>
                </div>
                <g:if test="${ended}">
                    <g:if test="${percentage == 100}">
                        <div class="col-md-6">
                            <h5 class="text-center">ACHIEVED<br><span class="lead">${dateFormat.format(achievedDate.getTime())}</span></h5>
                        </div>
                    </g:if>
                    <g:else>
                        <div class="col-md-6">
                            <h5 class="text-center">ENDED<br><span class="lead">${dateFormat.format(endDate.getTime())}</span></h5>
                        </div>
                    </g:else>
                </g:if>
                <g:else>
                    <div class="col-md-6">
                        <h5 class="text-center">ENDING<br><span class="lead">${dateFormat.format(endDate.getTime())}</span></h5>
                    </div>
                </g:else>
            </div>
        </div>
        <g:if test="${isFundingOpen}">
            <div class="progress progress-striped active">
                <div class="progress-bar progress-bar-success" role="progressbar" aria-valuenow="${percentage}" aria-valuemin="0" aria-valuemax="100" style="width: ${percentage}%;">
                    ${percentage}%
                </div>
            </div>
        </g:if>
        <g:else>
            <div class="progress">
                <div class="progress-bar progress-bar-success" role="progressbar" aria-valuenow="${percentage}" aria-valuemin="0" aria-valuemax="100" style="width: ${percentage}%;">
                    ${percentage}%
                </div>
            </div>
        </g:else>
            <div class="fb-like" data-href="http://beta.fedu.org/projects/${project.id}"  data-layout="standard" data-action="like" data-show-faces="false" data-share="true">
           </div>
      </div>
   </body>
</html>
