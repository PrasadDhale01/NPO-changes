<g:set var="projectService" bean="projectService" />
<g:set var="contributionService" bean="contributionService"/>
<g:set var="userService" bean="userService"/>
<% 
    def partnerId = partner.id
%>
<g:each in="${userCampaigns}" var="campaign">
    <% 
        def isFundingOpen = projectService.isFundingOpen(campaign)
        def contribution = contributionService.getTotalContributionForProject(campaign)
        def percentage = contributionService.getPercentageContributionForProject(campaign)
        def amount= campaign.amount.round()
        def iscampaignAdmin = userService.isCampaignBeneficiaryOrAdmin(campaign, user)
        def isTeamAdmin = projectService.isTeamAdmin(campaign)
        
        def username = campaign.user.username
    %>
    <div class="col-lg-4 col-md-4 col-sm-6 col-xs-12 campaign-tile-seperator">
        <div class="list-group-item campaign-tile-width">
            <div class="blacknwhite">
                <div class="userprofile-days">
                    Days Left
                    <g:if test="${projectService.getRemainingDay(campaign) > 0 && projectService.getRemainingDay(campaign) < 10 }">
                        <span>0${projectService.getRemainingDay(campaign)}</span>
                    </g:if>
                    <g:else>
                        <span>${projectService.getRemainingDay(campaign)}</span>
                    </g:else>
                </div>
                <g:if test="${iscampaignAdmin}">
                    <g:link controller="project" action="manageCampaign" id="${campaign.id}" title="${campaign.title}">
                        <img alt="${campaign.title}" class="campaign-img" src="${projectService.getProjectImageLink(campaign)}">
                    </g:link>
                </g:if>
                <g:else>
                    <g:link controller="project" action="showCampaign" id="${campaign.id}" params="['fr': username]" title="${campaign.title}">
                        <img alt="${campaign.title}" class="campaign-img" src="${projectService.getProjectImageLink(campaign)}">
                    </g:link>
                </g:else>
            </div>
            <div class="campaign-tile-content">
                <div class="campaign-title-padding">
                    <g:if test="${iscampaignAdmin}">
                        <g:link controller="project" action="manageCampaign" id="${campaign.id}" title="${campaign.title}">
                            ${campaign.title.toUpperCase()}
                        </g:link>
                    </g:if>
                    <g:else>
                        <g:link controller="project" action="showCampaign" id="${campaign.id}" params="['fr': username]" title="${campaign.title}">
                            ${campaign.title.toUpperCase()}
                        </g:link>
                    </g:else>
                </div>
                <g:if test="${isFundingOpen}">
                    <div class="progress progress-striped active">
                        <div class="progress-bar progress-bar-success" role="progressbar" aria-valuenow="${percentage}" aria-valuemin="0" aria-valuemax="100" style="width: ${percentage}%;"></div>
                    </div>
                </g:if>
                <g:else>
                    <div class="progress">
                        <div class="progress-bar progress-bar-success" role="progressbar" aria-valuenow="${percentage}" aria-valuemin="0" aria-valuemax="100" style="width: ${percentage}%;"></div>
                    </div>
                </g:else>
                
                <div class="userprofilecaption">
                    <span class="pull-left">
                        <span class="userdashboard-caption-font">Raised</span>
                        <g:if test="${campaign.payuStatus}"><span class="fa fa-inr"></span><span class="lead">${contribution}</span></g:if><g:else><span class="lead">$${contribution}</span></g:else>
                    </span>
    
                    <span class="pull-right">
                        <span class="userdashboard-caption-font">Goal</span>
                        <g:if test="${campaign.payuStatus}"><span class="fa fa-inr"></span><span class="lead">${amount}</span></g:if><g:else><span class="lead">$${amount}</span></g:else>
                    </span>
                </div>
            </div>
        </div>
    </div>
    
</g:each>
<div class="clear"></div>
<div class="partnercampaignpaginate">
    <g:paginate controller="user" max="6" action="partnercampaigns" total="${totalUserCampaigns.size()}" params="['partnerId':partnerId]"/>
</div>
<script>
    $("#partnercampaignpaginate").find('.partnercampaignpaginate a').click(function(event) {
        event.preventDefault();
        var url = $(this).attr('href');
        var grid = $(this).parents('#partnercampaignpaginate');

        $.ajax({
            type: 'GET',
            url: url,
            success: function(data) {
                $(grid).fadeOut('fast', function() {$(this).html(data).fadeIn('fast');});
            }
        });
    });
</script>
