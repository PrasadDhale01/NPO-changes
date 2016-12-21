<g:set var="projectService" bean="projectService" />
<g:set var="contributionService" bean="contributionService"/>
<g:set var="userService" bean="userService"/>
<g:if test="${projects.size() > 0}">
<g:each in="${projects}" var="campaign">
    <% 
        def isFundingOpen = projectService.isFundingOpen(campaign)
        def contribution = contributionService.getTotalContributionForProject(campaign)
        def percentage = contributionService.getPercentageContributionForProject(campaign)
        def amount= campaign.amount.round()
        def iscampaignAdmin = userService.isCampaignBeneficiaryOrAdmin(campaign, user)
        def isTeamAdmin = projectService.isTeamAdmin(campaign)
        
        def username = campaign.user.username
        boolean ended = projectService.isProjectDeadlineCrossed(campaign)
        def vanityTitle = projectService.getVanityTitleFromId(campaign.id)
		def country_code = projectService.getCountryCodeForCurrentEnv(request)
    %>
    <div class="col-lg-4 col-md-4 col-sm-6 col-xs-12 campaign-tile-seperator">
        <div class="thumbnail campaign-tile-width">
            <g:if test="${iscampaignAdmin}">
                <g:if test="${campaign.draft}">
                    <div class="over user-tile">
                        <img src="//s3.amazonaws.com/crowdera/assets/Draft-tag.png" alt="draft">
                    </div>
                </g:if>
                <g:elseif test="${campaign.rejected}">
                    <div class="over user-tile">
                        <img src="//s3.amazonaws.com/crowdera/assets/Rejected-tag.png"  alt="rejected">
                    </div>
                </g:elseif>
                <g:elseif test="${!campaign.validated}">
                    <div class="over user-tile">
                        <img src="//s3.amazonaws.com/crowdera/assets/Pending-tag.png" alt="PENDING">
                    </div>
                </g:elseif>
                <g:elseif test="${ended}">
                    <div class="over user-tile">
                        <img src="//s3.amazonaws.com/crowdera/assets/ended-tag.png" alt="ended">
                    </div>
                </g:elseif>
                <g:elseif test="${percentage >= 75}">
                    <div class="over user-tile">
                        <img src="//s3.amazonaws.com/crowdera/assets/Funded-Tag.png" alt="Funded">
                    </div>
                </g:elseif>
                <g:elseif test="${campaign.validated}">
                    <g:if test="${user == campaign.user}">
                        <div class="over user-tile">
                            <img src="//s3.amazonaws.com/crowdera/assets/owner-tag.png" alt="Owner">
                        </div>
                    </g:if>
                    <g:elseif test="${isTeamAdmin}">
                        <div class="over user-tile">
                            <img src="//s3.amazonaws.com/crowdera/assets/Co-owner-tag.png" alt="co-owner">
                        </div>
                    </g:elseif>
                </g:elseif>
                <g:elseif test="${isTeamAdmin}">
                    <div class="over user-tile">
                        <img src="//s3.amazonaws.com/crowdera/assets/owner-tag.png" alt="Owner">
                    </div>
                </g:elseif>
                <g:else>
                    <div class="over user-tile">
                        <img src="//s3.amazonaws.com/crowdera/assets/Team-tag.png" alt="Team top"/>
                    </div>
                </g:else>
            </g:if>
            <g:else>
                <g:if test="${campaign.draft}">
                    <div class="over user-tile">
                        <img src="//s3.amazonaws.com/crowdera/assets/Draft-tag.png" alt="draft">
                    </div>
                </g:if>
                <g:elseif test="${campaign.rejected}">
                    <div class="over user-tile">
                        <img src="//s3.amazonaws.com/crowdera/assets/Rejected-tag.png" alt="rejected">
                    </div>
                </g:elseif>
                <g:elseif test="${!campaign.validated}">
                    <div class="over user-tile">
                        <img src="//s3.amazonaws.com/crowdera/assets/Pending-tag.png" alt="Pending">
                    </div>
                </g:elseif>
                <g:elseif test="${ended}">
                    <div class="over user-tile">
                        <img src="//s3.amazonaws.com/crowdera/assets/ended-tag.png" alt="ended">
                    </div>
                </g:elseif>
                <g:elseif test="${percentage >= 75}">
                    <div class="over user-tile">
                        <img src="//s3.amazonaws.com/crowdera/assets/Funded-Tag.png" alt="Funded">
                    </div>
                </g:elseif>
                <g:elseif test="${campaign.validated}">
                    <g:if test="${isTeamAdmin}">
                        <div class="over user-tile">
                            <img src="//s3.amazonaws.com/crowdera/assets/owner-tag.png" alt="Owner"/>
                        </div>
                    </g:if>
                    <g:else>
                        <div class="over user-tile">
                            <img src="//s3.amazonaws.com/crowdera/assets/Team-tag.png" alt="Team top"/>
                        </div>
                    </g:else>
                </g:elseif>
            </g:else>
 
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
                <div title="${campaign.title}" data-vanitytitle="${vanityTitle}" class="campaignTileClick">
                    <img alt="${campaign.title}" class="campaign-img img-size" src="${projectService.getProjectImageLink(campaign)}">
                </div>
            </div>
            <div class="campaign-tile-content">
                <div class="campaign-title-padding">
                    <div title="${campaign.title}" data-vanityTitle="${vanityTitle}" class="campaignTileClick">
                        ${campaign.title.toUpperCase()}
                    </div>
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
                        <g:if test="${country_code == 'in'}">
                            <span class="fa fa-inr"></span><g:if test="${campaign.payuStatus}"><span class="lead">${contribution}</span></g:if><g:else><span class="lead">${contribution * conversionMultiplier}</span></g:else>
                        </g:if>
                        <g:else>
                            <span class="lead">$${contribution}</span>
                        </g:else>
                    </span>
    
                    <span class="pull-right">
                        <span class="userdashboard-caption-font">Goal</span>
                        <g:if test="${country_code == 'in'}">
                            <span class="fa fa-inr"></span><g:if test="${campaign.payuStatus}"><span class="lead">${amount}</span></g:if><g:else><span class="lead">${amount * conversionMultiplier}</span></g:else>
                        </g:if>
                        <g:else>
                            <span class="lead">$${amount}</span>
                        </g:else>
                    </span>
                </div>
            </div>
        </div>
    </div>
    
</g:each>
<div class="clear"></div>
<div class="pull-right campaignpaginate filespaginate">
    <g:paginate controller="user" max="6" action="loadCampaignTile" total="${totalProjects.size()}"/>
</div>
<script>
    var baseUrl = $('#baseUrl').val();

    /*Pagination logic*/
    $(".campaignTilePaginate").find('.campaignpaginate a').click(function(event) {
        event.preventDefault();
        var url = $(this).attr('href');
        var grid = $(this).parents('.campaignTilePaginate');

        $.ajax({
            type: 'GET',
            url: url,
            success: function(data) {
                $(grid).fadeOut('fast', function() {$(this).html(data).fadeIn('fast');});
            }
        });
    });

    /*Renders contributor list on campaign tile click*/
    $('.campaignTileClick').click(function (){
        var vanityTitle = $(this).data('vanitytitle');
        var grid = $(".campaignTilePaginate");
        $('#loading-gif').show();
        $.ajax({
            type: 'post',
            url:baseUrl+'/user/loadContributors',
            data:'vanityTitle='+vanityTitle+'&sort=All',
            success: function(data) {
                $(grid).fadeOut('fast', function() {$(this).html(data).fadeIn('fast');});
                $('#loading-gif').hide();
            }
        }).error(function(e){
           $('#loading-gif').hide();
           console.log('Error occured while showing contributor list of '+vanityTitle);
        });
    });

</script>
</g:if>
