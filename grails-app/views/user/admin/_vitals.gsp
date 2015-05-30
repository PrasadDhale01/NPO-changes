    <g:set var="communityService" bean="communityService"/>
<g:set var="userService" bean="userService"/>
<g:set var="contributionService" bean="contributionService"/>
<g:set var="projectService" bean="projectService"/>
<%
	def amount = 123456789012345
	def length = projectService.getDataType(amount)
    def digitLen = length.toString().length()
%>
<div class="row">
    <div class="col-md-3">
        <div class="panel panel-info">
            <div class="panel-heading">
                <div class="row">
                    <div class="col-xs-2">
                        <i class="fa fa-tint fa-2x"></i>
                    </div>
                    <div class="col-xs-10 text-right">
                        <g:if test="${contributionService.getTotalContribution()}">
                            <g:if test="${digitLen >= 7 && digitLen <= 10}">
                                <p class="for-greaterseven">$${projectService.getDataType(amount)}</p>
                            </g:if>
                            <g:elseif test="${digitLen >= 11 && digitLen <= 13}">
                                <p class="for-greaterEleven">$${projectService.getDataType(amount)}</p>
                            </g:elseif>
                            <g:elseif test="${digitLen >= 14 && digitLen <= 16}">
                                <p class="for-greaterFourteen">$${projectService.getDataType(amount)}</p>
                            </g:elseif>
                            <g:else>
                                 <p class="announcement-heading">$${projectService.getDataType(amount)}</p>
                            </g:else>
                        </g:if>
                        <g:else>
                            <p class="announcement-heading">$0</p>
                        </g:else>
                    </div>
                </div>
            </div>
            <div class="panel-footer announcement-bottom">
                Total contributions
            </div>
        </div>
    </div>
    <div class="col-md-3">
        <div class="panel panel-success">
            <div class="panel-heading">
                <div class="row">
                    <div class="col-xs-2">
                        <i class="fa fa-user fa-2x"></i>
                    </div>
                    <div class="col-xs-10 text-right">
                        <p class="announcement-heading">${userService.getNumberOfUsers()}</p>
                    </div>
                </div>
            </div>
            <div class="panel-footer announcement-bottom">
                Total # of users
            </div>
        </div>
    </div>
    <div class="col-md-3">
        <div class="panel panel-info">
            <div class="panel-heading">
                <div class="row">
                    <div class="col-xs-2">
                        <i class="fa fa-leaf fa-2x"></i>
                    </div>
                    <div class="col-xs-10 text-right">
                        <p class="announcement-heading">${projectService.getNumberOfProjects()}</p>
                    </div>
                </div>
            </div>
            <div class="panel-footer announcement-bottom">
                Total # of campaigns
            </div>
        </div>
    </div>
    <div class="col-md-3">
        <div class="panel panel-warning">
            <div class="panel-heading">
                <div class="row">
                    <div class="col-xs-2">
                        <i class="fa fa-users fa-2x"></i>
                    </div>
                    <div class="col-xs-10 text-right">
                        <p class="announcement-heading">${communityService.getNumberOfCommunities()}</p>
                    </div>
                </div>
            </div>
            <div class="panel-footer announcement-bottom">
                Total # of communities
            </div>
        </div>
    </div>
</div>
