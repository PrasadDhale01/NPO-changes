<g:set var="communityService" bean="communityService"/>
<g:set var="userService" bean="userService"/>
<g:set var="contributionService" bean="contributionService"/>
<g:set var="projectService" bean="projectService"/>

<div class="row">
    <div class="col-lg-3">
        <div class="panel panel-info">
            <div class="panel-heading">
                <div class="row">
                    <div class="col-xs-4">
                        <i class="fa fa-tint fa-5x"></i>
                    </div>
                    <div class="col-xs-8 text-right">
                        <p class="announcement-heading">$${contributionService.getTotalContribution()}</p>
                    </div>
                </div>
            </div>
            <div class="panel-footer announcement-bottom">
                Total contributions
            </div>
        </div>
    </div>
    <div class="col-lg-3">
        <div class="panel panel-success">
            <div class="panel-heading">
                <div class="row">
                    <div class="col-xs-6">
                        <i class="fa fa-user fa-5x"></i>
                    </div>
                    <div class="col-xs-6 text-right">
                        <p class="announcement-heading">${userService.getNumberOfUsers()}</p>
                    </div>
                </div>
            </div>
            <div class="panel-footer announcement-bottom">
                Total # of users
            </div>
        </div>
    </div>
    <div class="col-lg-3">
        <div class="panel panel-info">
            <div class="panel-heading">
                <div class="row">
                    <div class="col-xs-6">
                        <i class="fa fa-leaf fa-5x"></i>
                    </div>
                    <div class="col-xs-6 text-right">
                        <p class="announcement-heading">${projectService.getNumberOfProjects()}</p>
                    </div>
                </div>
            </div>
            <div class="panel-footer announcement-bottom">
                Total # of projects
            </div>
        </div>
    </div>
    <div class="col-lg-3">
        <div class="panel panel-success">
            <div class="panel-heading">
                <div class="row">
                    <div class="col-xs-6">
                        <i class="fa fa-users fa-5x"></i>
                    </div>
                    <div class="col-xs-6 text-right">
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
