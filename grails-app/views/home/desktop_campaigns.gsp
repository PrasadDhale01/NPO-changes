<g:if test="${request.method=="POST" }">
<g:set var="projectService" bean="projectService"/>
<div class='container col-x-plf-0'>
    <div class='col-md-10 col-md-offset-1 col-xs-12 col-xs-offset-0'>
    
        <div class='row'>
            <div class='col-md-12 hm-mobile-title'>
                <h1 class='text-center headingtext'>Latest Campaigns Raising Free on Crowdera</h1><br>
            </div>
        </div>
        <div class='item active home-campaign-tile-container home-tile-mobile hidden-xs'>
            <div class='row'>
                <ul class='thumbnails list-unstyled home-campaign-tile'>
                    <% 
                        def index1 = 1
                        def currentEnv = projectService.getCurrentEnvironment()
                        def projects = projectService.getHomePageCampaignListByEnv(currentEnv)
                     %>
                    <g:each in='${projects}' var='project'>
                        <li class='<g:if test='${index1++ > 2}'>hidden-md col-lg-4 hidden-sm col-sm-6 col-xs-12</g:if><g:else>col-md-6 col-sm-6 col-lg-4 col-xs-12</g:else>'>
                            <g:render template='/layouts/tile' model='['project': project]'></g:render>
                        </li>
                    </g:each>
                </ul>
            </div>
        </div>
        <div class='text-center explorebtn hidden-xs'>
            <a href='${resource(dir: '/campaigns')}' class='btn btn-default hm-explorecampaign'>Explore Campaigns</a>
        </div>
    </div>
</div>
</g:if>
