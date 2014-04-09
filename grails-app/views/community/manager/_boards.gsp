<g:set var="communityService" bean="communityService"/>
<g:set var="creditService" bean="creditService"/>
<div class="row">
    <div class="col-md-4">
        <div class="panel panel-info">
            <div class="panel-heading">
                <div class="row">
                    <div class="col-xs-4">
                        <i class="fa fa-money fa-5x"></i>
                    </div>
                    <div class="col-xs-8 text-right">
                        <p class="announcement-heading">$${creditService.getTotalCreditForCommunity(community)}</p>
                    </div>
                </div>
            </div>
            <div class="panel-footer announcement-bottom">
                Outstanding credit
            </div>
        </div>
    </div>
    <div class="col-md-4">
        <div class="panel panel-success">
            <div class="panel-heading">
                <div class="row">
                    <div class="col-xs-6">
                        <i class="fa fa-user fa-5x"></i>
                    </div>
                    <div class="col-xs-6 text-right">
                        <p class="announcement-heading">${communityService.getNumberofMembersInCommunity(community)}</p>
                    </div>
                </div>
            </div>
            <div class="panel-footer announcement-bottom">
                # of members
            </div>
        </div>
    </div>
    <div class="col-md-4">
        <div class="panel panel-warning">
            <div class="panel-heading">
                <div class="row">
                    <div class="col-xs-6">
                        <i class="fa fa-question fa-5x"></i>
                    </div>
                    <div class="col-xs-6 text-right">
                        <p class="announcement-heading">${communityService.getNumberofPendingMembersInCommunity(community)}</p>
                    </div>
                </div>
            </div>
            <div class="panel-footer announcement-bottom">
                # of pending members
            </div>
        </div>
    </div>
</div>
