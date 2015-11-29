<g:set var="projectService" bean="projectService" />
<g:set var="contributionService" bean="contributionService"/>
<g:set var="userService" bean="userService"/>
<r:require module="bootstrapsocialcss"/>
<div class="col-xs-12" id="promote-social-media">
    <div class="col-lg-3 col-md-3 col-sm-3 col-xs-3">
        <span class="btn btn-block btn-social social-button btn-facebook" id="fbshare"><i class="fa fa-facebook"></i></span>
    </div>
    <div class="col-lg-3 col-md-3 col-sm-3 col-xs-3">
        <span class="btn btn-block btn-social social-button btn-linkedin" id="linkedinShareUrl"><i class="fa fa-linkedin"></i></span>
    </div>
    <div class="col-lg-3 col-md-3 col-sm-3 col-xs-3">
        <span class="btn btn-block btn-social social-button btn-google-plus" id="googlePlusShareUrl"><i class="fa fa-google-plus"></i></span>
    </div>
    <div class="col-lg-3 col-md-3 col-sm-3 col-xs-3">
        <span class="btn btn-block btn-social social-button btn-linkedin" id="twitterShare"><i class="fa fa-twitter"></i></span>
    </div>
    <div class="clear"></div>
    <div class="col-xs-12">
        <div class="alert alert-info" id="campaign-select-alert">
            Kindly select a campaign to share.
        </div>
    </div>
</div>
<%
    def partnerId = partner.id
%>
<div class="list-group" id="promote-campaigns">
    <g:each in="${campaigns}" var="campaign">
        <% 
            def shareUrl = baseUrl+"/campaigns/"+campaign.id+"?fr="+campaign.user.username
            def isFundingOpen = projectService.isFundingOpen(campaign)
            def contribution = contributionService.getTotalContributionForProject(campaign)
            def percentage = contributionService.getPercentageContributionForProject(campaign)
            def amount= campaign.amount.round()
            def shortUrl = projectService.getShortenUrl(campaign.id, campaign.user.username)
            def twitterShareUrl = baseUrl+'/c/'+shortUrl
        %>
        <div class="col-lg-4 col-md-4 col-sm-6 col-xs-12 campaign-tile-seperator">
            <div class="list-group-item campaign-tile-width" id="${twitterShareUrl}" data-campaignurl="${shareUrl}">
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
                    <img alt="${campaign.title}" class="campaign-img" src="${projectService.getProjectImageLink(campaign)}"/>
                </div>
                <div class="campaign-tile-content">
                    <div class="campaign-title-padding">
                        ${campaign.title.toUpperCase()}
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
</div>
<div class="clear"></div>
<div class="promotecampaignpaginate">
    <g:paginate controller="user" max="6" action="promotecampaigns" total="${totalCampaigns.size()}" params="['partnerId':partnerId]"/>
</div>
<script>
    $("#promotecampaignpaginate").find('.promotecampaignpaginate a').click(function(event) {
        event.preventDefault();
        var url = $(this).attr('href');
        var grid = $(this).parents('#promotecampaignpaginate');

        $.ajax({
            type: 'GET',
            url: url,
            success: function(data) {
                $(grid).fadeOut('fast', function() {$(this).html(data).fadeIn('fast');});
            }
        });
    });
</script>
