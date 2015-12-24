<div class="row pull-right">
    <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
        <g:form controller="project" action="generateCampaignCSV">
            <g:hiddenField name="projectId" value="${project.id}"/>
            <button type="submit" class="btn btn-primary btn-sm">Export CSV</button><br>
        </g:form>
    </div>
</div>
<div class="clear"></div>
<div class="row">
    <div class="col-lg-4 col-md-6 col-sm-12 col-xs-12">
        <div class="panel panel-info">
            <div class="panel-heading">
                <div class="row">
                    <div class="col-xs-2">
                        <i class="fa fa-tint fa-2x"></i>
                    </div>
                    <div class="col-xs-10 text-right">
                        <p class="metrics-campaigns-heading">${project.amount.round()}</p>
                    </div>
                </div>
            </div>
            <div class="panel-footer announcement-bottom">
                Campaign Goal
            </div>
        </div>
    </div>
    <div class="col-lg-4 col-md-6 col-sm-12 col-xs-12">
        <div class="panel panel-success">
            <div class="panel-heading">
                <div class="row">
                    <div class="col-xs-2">
                        <i class="fa fa-tint fa-2x"></i>
                    </div>
                    <div class="col-xs-10 text-right">
                        <p class="metrics-campaigns-heading"><g:if test="${project.usedFor}">${project.usedFor}</g:if><g:else>IMPACT</g:else></p>
                    </div>
                </div>
            </div>
            <div class="panel-footer announcement-bottom">
                Raised Fund for
            </div>
        </div>
    </div>
    <div class="col-lg-4 col-md-6 col-sm-12 col-xs-12">
        <div class="panel panel-info">
            <div class="panel-heading">
                <div class="row">
                    <div class="col-xs-2">
                        <i class="fa fa-tint fa-2x"></i>
                    </div>
                    <div class="col-xs-10 text-right">
                        <p class="metrics-campaigns-heading">${numberOfContributions}</p>
                    </div>
                </div>
            </div>
            <div class="panel-footer announcement-bottom">
                Total # of contribution
            </div>
        </div>
    </div>
    <div class="col-lg-4 col-md-6 col-sm-12 col-xs-12">
        <div class="panel panel-info">
            <div class="panel-heading">
                <div class="row">
                    <div class="col-xs-2">
                        <i class="fa fa-tint fa-2x"></i>
                    </div>
                    <div class="col-xs-10 text-right">
                        <p class="metrics-campaigns-heading">${percentageContribution}%</p>
                    </div>
                </div>
            </div>
            <div class="panel-footer announcement-bottom">
                Percentage Goal Raised
            </div>
        </div>
    </div>
    <div class="col-lg-4 col-md-6 col-sm-12 col-xs-12">
        <div class="panel panel-warning">
            <div class="panel-heading">
                <div class="row">
                    <div class="col-xs-2">
                        <i class="fa fa-tint fa-2x"></i>
                    </div>
                    <div class="col-xs-10 text-right">
                        <p class="metrics-campaigns-heading">${numberOFPerks}</p>
                    </div>
                </div>
            </div>
            <div class="panel-footer announcement-bottom">
                Number of Perks offered
            </div>
        </div>
    </div>
    <div class="col-lg-4 col-md-6 col-sm-12 col-xs-12">
        <div class="panel panel-info">
            <div class="panel-heading">
                <div class="row">
                    <div class="col-xs-2">
                        <i class="fa fa-tint fa-2x"></i>
                    </div>
                    <div class="col-xs-10 text-right">
                        <p class="metrics-campaigns-heading"><g:if test="${numberOfContributions > 0}">${maxSelectedPerkAmount}</g:if><g:else>None</g:else></p>
                    </div>
                </div>
            </div>
            <div class="panel-footer announcement-bottom">
                Most Selected Perk Amount
            </div>
        </div>
    </div>
    
    <div class="col-lg-4 col-md-6 col-sm-12 col-xs-12">
        <div class="panel panel-info">
            <div class="panel-heading">
                <div class="row">
                    <div class="col-xs-2">
                        <i class="fa fa-tint fa-2x"></i>
                    </div>
                    <div class="col-xs-10 text-right">
                        <p class="metrics-campaigns-heading">${numberOfTeams}</p>
                    </div>
                </div>
            </div>
            <div class="panel-footer announcement-bottom">
                Total # of Enabled Teams
            </div>
        </div>
    </div>
    <div class="col-lg-4 col-md-6 col-sm-12 col-xs-12">
        <div class="panel panel-info">
            <div class="panel-heading">
                <div class="row">
                    <div class="col-xs-2">
                        <i class="fa fa-tint fa-2x"></i>
                    </div>
                    <div class="col-xs-10 text-right">
                        <p class="metrics-campaigns-heading">${disabledTeams}</p>
                    </div>
                </div>
            </div>
            <div class="panel-footer announcement-bottom">
                Total # of Disabled Teams
            </div>
        </div>
    </div>
    
    <div class="col-lg-4 col-md-6 col-sm-12 col-xs-12">
        <div class="panel panel-info">
            <div class="panel-heading">
                <div class="row">
                    <div class="col-xs-2">
                        <i class="fa fa-tint fa-2x"></i>
                    </div>
                    <div class="col-xs-10 text-right">
                        <p class="metrics-campaigns-heading">${numberOfComments}</p>
                    </div>
                </div>
            </div>
            <div class="panel-footer announcement-bottom">
                Total # of Comments
            </div>
        </div>
    </div>
    <div class="col-lg-4 col-md-6 col-sm-12 col-xs-12">
        <div class="panel panel-info">
            <div class="panel-heading">
                <div class="row">
                    <div class="col-xs-2">
                        <i class="fa fa-tint fa-2x"></i>
                    </div>
                    <div class="col-xs-10 text-right">
                        <p class="metrics-campaigns-heading">${numberOfUpdates}</p>
                    </div>
                </div>
            </div>
            <div class="panel-footer announcement-bottom">
                Total # of Updates 
            </div>
        </div>
    </div>
    
    <div class="col-lg-4 col-md-6 col-sm-12 col-xs-12">
        <div class="panel panel-info">
            <div class="panel-heading">
                <div class="row">
                    <div class="col-xs-2">
                        <i class="fa fa-tint fa-2x"></i>
                    </div>
                    <div class="col-xs-10 text-right">
                        <p class="metrics-campaigns-heading" id="ytViewcount"><g:if test="${project.videoUrl}">${ytViewCount}</g:if><g:else>0</g:else></p>
                    </div>
                </div>
            </div>
            <div class="panel-footer announcement-bottom">
                Number of video Viewers
            </div>
        </div>
    </div>
    
    <div class="col-lg-4 col-md-6 col-sm-12 col-xs-12">
        <div class="panel panel-info">
            <div class="panel-heading">
                <div class="row">
                    <div class="col-xs-2">
                        <i class="fa fa-tint fa-2x"></i>
                    </div>
                    <div class="col-xs-10 text-right">
                        <p class="metrics-campaigns-heading"><g:if test="${numberOfContributions > 0}">${highestContributionDay}</g:if><g:else>None</g:else></p>
                    </div>
                </div>
            </div>
            <div class="panel-footer announcement-bottom">
                Highest Contribution Day
            </div>
        </div>
    </div>
    <div class="col-lg-4 col-md-6 col-sm-12 col-xs-12">
        <div class="panel panel-info">
            <div class="panel-heading">
                <div class="row">
                    <div class="col-xs-2">
                        <i class="fa fa-tint fa-2x"></i>
                    </div>
                    <div class="col-xs-10 text-right">
                        <p class="metrics-campaigns-heading"><g:if test="${numberOfContributions > 0}">${highestContributionHour} hr</g:if><g:else>None</g:else></p>
                    </div>
                </div>
            </div>
            <div class="panel-footer announcement-bottom">
                Highest Contribution Hour
            </div>
        </div>
    </div>
    
    <div class="col-lg-4 col-md-6 col-sm-12 col-xs-12">
        <div class="panel panel-info">
            <div class="panel-heading">
                <div class="row">
                    <div class="col-xs-2">
                        <i class="fa fa-tint fa-2x"></i>
                    </div>
                    <div class="col-xs-10 text-right">
                        <p class="metrics-campaigns-heading" id="facebook-count"><g:if test="${facebookCount}">${facebookCount}</g:if><g:else>0</g:else></p>
                    </div>
                </div>
            </div>
            <div class="panel-footer announcement-bottom">
                Facebook Share Count
            </div>
        </div>
    </div>
    <div class="col-lg-4 col-md-6 col-sm-12 col-xs-12">
        <div class="panel panel-info">
            <div class="panel-heading">
                <div class="row">
                    <div class="col-xs-2">
                        <i class="fa fa-tint fa-2x"></i>
                    </div>
                    <div class="col-xs-10 text-right">
                        <p class="metrics-campaigns-heading" id="twitter-count">${twitterCount}</p>
                    </div>
                </div>
            </div>
            <div class="panel-footer announcement-bottom">
                Twitter Share Count
            </div>
        </div>
    </div>
    <div class="col-lg-4 col-md-6 col-sm-12 col-xs-12">
        <div class="panel panel-info">
            <div class="panel-heading">
                <div class="row">
                    <div class="col-xs-2">
                        <i class="fa fa-tint fa-2x"></i>
                    </div>
                    <div class="col-xs-10 text-right">
                        <p class="metrics-campaigns-heading" id="linkdin-count">${linkedinCount}</p>
                    </div>
                </div>
            </div>
            <div class="panel-footer announcement-bottom">
                Linkedin Share Count
            </div>
        </div>
    </div>
    <div class="col-lg-4 col-md-6 col-sm-12 col-xs-12">
        <div class="panel panel-info">
            <div class="panel-heading">
                <div class="row">
                    <div class="col-xs-2">
                        <i class="fa fa-tint fa-2x"></i>
                    </div>
                    <div class="col-xs-10 text-right">
                        <p class="metrics-campaigns-heading">${project.gmailShareCount}</p>
                    </div>
                </div>
            </div>
            <div class="panel-footer announcement-bottom">
                Email Share Count
            </div>
        </div>
    </div>
    <div class="col-lg-4 col-md-6 col-sm-12 col-xs-12">
        <div class="panel panel-info">
            <div class="panel-heading">
                <div class="row">
                    <div class="col-xs-2">
                        <i class="fa fa-tint fa-2x"></i>
                    </div>
                    <div class="col-xs-10 text-right">
                        <p class="metrics-campaigns-heading">${campaignSupporterCount}</p>
                    </div>
                </div>
            </div>
            <div class="panel-footer announcement-bottom">
                Total # of Supporters
            </div>
        </div>
    </div>
    
</div>
