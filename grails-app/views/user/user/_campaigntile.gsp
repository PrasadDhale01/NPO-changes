<g:set var="projectService" bean="projectService" />
<g:set var="contributionService" bean="contributionService"/>
<g:set var="userService" bean="userService"/>

<g:if test="${totalCampaings.size() > 0}">
<g:each in="${totalCampaings}" var="campaign">
    <% 
        def isFundingOpen = projectService.isFundingOpen(campaign)
        def contribution = contributionService.getTotalContributionForProject(campaign)
        def percentage = contributionService.getPercentageContributionForProject(campaign)
        def amount= campaign.amount.round()
        def iscampaignAdmin = userService.isCampaignBeneficiaryOrAdmin(campaign, user)
        def isTeamAdmin = projectService.isTeamAdmin(campaign)
        
        def username = campaign.user.username
        boolean ended = projectService.isProjectDeadlineCrossed(campaign)
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
                <g:elseif test="${campaign.onHold}">
                    <div class="over user-tile">
                        <img src="//s3.amazonaws.com/crowdera/assets/on-hold.png" alt="On Hold">
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
                <g:elseif test="${campaign.onHold}">
                    <div class="over user-tile">
                        <img src="//s3.amazonaws.com/crowdera/assets/on-hold.png" alt="On Hold">
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
                <g:if test="${iscampaignAdmin}">
                    <a href="javascript:void(0);" onclick="submitCampaignShowForm('manage','${campaign.id}','${username}');">
                        <img alt="${campaign.title}" class="campaign-img" src="${projectService.getProjectImageLink(campaign)}">
                    </a>
                </g:if>
                <g:else>
                    <a href="javascript:void(0);" onclick="submitCampaignShowForm('show','${campaign.id}','${username}');" id="${campaign.id}">
                        <img alt="${campaign.title}" class="campaign-img" src="${projectService.getProjectImageLink(campaign)}">
                    </a>
                </g:else>
            </div>
            <div class="campaign-tile-content">
                <div class="campaign-title-padding">
                    <g:if test="${iscampaignAdmin}">
                        <a href="javascript:void(0)" onclick="submitCampaignShowForm('manage','${campaign.id}','${username}');" id="${campaign.id}" >
                            ${campaign.title.toUpperCase()}
                        </a>
                    </g:if>
                    <g:else>
                        <a href="javascript:void(0)" onclick="submitCampaignShowForm('show','${campaign.id}','${username}');" id="${campaign.id}">
                            ${campaign.title.toUpperCase()}
                        </a>
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
    <div class="usersCampaignsPagination text-center" id="userCampaignsPagination">
        <g:paginate controller="user" max="6" maxsteps= "5" action="campaignpagination"  total="${totalprojects.size()}"/>
    </div>

    <script>
        $('#usercampaignpaginate').find('#userCampaignsPagination a').click(function(event) {
            event.preventDefault();
            var url = $(this).attr('href');
            var grid = $(this).parents('#usercampaignpaginate');
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
</g:if>
<g:else>
    <div class="col-sm-12">
        <div class="alert alert-info">
            You haven't created any campaigns yet. You can create one <g:link controller="project" action="create">here</g:link>.
        </div>
    </div>
</g:else>
