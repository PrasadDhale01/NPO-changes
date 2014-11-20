    <g:set var="communityService" bean="communityService"/>
<g:set var="userService" bean="userService"/>
<g:set var="contributionService" bean="contributionService"/>
<g:set var="projectService" bean="projectService"/>

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
                            <p class="announcement-heading">$${contributionService.getTotalContribution()}</p>
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
                Total # of projects
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
