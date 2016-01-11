<g:set var="projectService" bean="projectService" />
<g:set var="contributionService" bean="contributionService"/>
<g:set var="userService" bean="userService"/>
<%
    def partnerId = partner.id
%>
<g:if test="${projects.size() > 0}">
    <g:each in="${projects}" var="campaign">
    <%
        def amount = campaign.amount.round()
    %>
    <div class="col-lg-4 col-md-4 col-sm-6 col-xs-12 campaign-tile-seperator">
        <div class="thumbnail campaign-tile-width">
            <g:if test="${campaign.onHold}">
                <div class="over user-tile">
                    <img src="//s3.amazonaws.com/crowdera/assets/on-hold.png" alt="On Hold">
                </div>
            </g:if>
            <div class="blacknwhite">
                <g:link controller="project" action="validateShowCampaign" id="${campaign.id}" title="${campaign.title}">
                    <div class="userprofile-days">
                        Days Left
                        <g:if test="${projectService.getRemainingDay(campaign) > 0 && projectService.getRemainingDay(campaign) < 10 }">
                            <span>0${projectService.getRemainingDay(campaign)}</span>
                        </g:if>
                        <g:else>
                            <span>${projectService.getRemainingDay(campaign)}</span>
                        </g:else>
                    </div>
                    <img alt="${campaign.title}" class="campaign-img" src="${projectService.getProjectImageLink(campaign)}">
                </g:link>
            </div>
            <div class="campaign-tile-content">
                <div class="campaign-title-padding">
                    <g:link controller="project" action="validateShowCampaign" id="${campaign.id}" title="${campaign.title}">
                        ${campaign.title.toUpperCase()}
                    </g:link>
                </div>

                <div class="progress">
                    <div class="progress-bar progress-bar-success" aria-valuenow="0" aria-valuemin="0" aria-valuemax="100" style="width: 0%;"></div>
                </div>

                <div class="userprofilecaption">
                    <span class="pull-left">
                        <span class="userdashboard-caption-font">Raised</span>
                        <g:if test="${campaign.payuStatus}"><span class="fa fa-inr"></span><span class="lead">0</span></g:if><g:else><span class="lead">$0</span></g:else>
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
<div class="validatecampaignpaginate">
    <g:paginate controller="user" max="6" action="validatecampaigns" total="${totalprojects.size()}" params="['partnerId':partnerId]"/>
</div>

<script>
$("#validatecampaignpaginate").find('.validatecampaignpaginate a').click(function(event) {
    event.preventDefault();
    var url = $(this).attr('href');
    var grid = $(this).parents('#validatecampaignpaginate');

    $.ajax({
        type: 'GET',
        url: url,
        success: function(data) {
            $(grid).fadeOut('fast', function() {$(this).html(data).fadeIn('fast');});
        }
    });
});
</script>

</g:if>
<g:else>
<div class="col-sm-12">
    <div class="alert alert-info">
        No campaigns to validate.
    </div>
</div>
</g:else>
