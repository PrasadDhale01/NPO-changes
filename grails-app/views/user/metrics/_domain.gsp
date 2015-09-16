<g:set var="communityService" bean="communityService"/>
<g:set var="userService" bean="userService"/>
<g:set var="contributionService" bean="contributionService"/>
<g:set var="projectService" bean="projectService"/>
<%
	def length = projectService.getDataType(amount)
	def digitLen = length.toString().length()
%>
<div class="row metricsTabTop">
    <div class="col-lg-3 col-md-4 col-sm-6 col-xs-12">
        <div class="panel panel-info">
            <div class="panel-heading">
                <div class="row">
                    <div class="col-xs-2">
                        <i class="fa fa-tint fa-2x"></i>
                    </div>
                    <div class="col-xs-10 text-right">
                        <p class="announcement-heading">${LiveProjects}</p>
                    </div>
                </div>
            </div>
            <div class="panel-footer announcement-bottom">
                Total # of live campaigns
            </div>
        </div>
    </div>
    <div class="col-lg-3 col-md-4 col-sm-6 col-xs-12">
        <div class="panel panel-success">
            <div class="panel-heading">
                <div class="row">
                    <div class="col-xs-2">
                        <i class="fa fa-tint fa-2x"></i>
                    </div>
                    <div class="col-xs-10 text-right">
                        <p class="announcement-heading">${endedProjects}</p>
                    </div>
                </div>
            </div>
            <div class="panel-footer announcement-bottom">
                Total # of Ended campaigns
            </div>
        </div>
    </div>
    <div class="col-lg-3 col-md-4 col-sm-6 col-xs-12">
        <div class="panel panel-info">
            <div class="panel-heading">
                <div class="row">
                    <div class="col-xs-2">
                        <i class="fa fa-tint fa-2x"></i>
                    </div>
                    <div class="col-xs-10 text-right">
                        <p class="announcement-heading">${totalProjects}</p>
                    </div>
                </div>
            </div>
            <div class="panel-footer announcement-bottom">
                Total # of campaigns
            </div>
        </div>
    </div>
    <div class="col-lg-3 col-md-4 col-sm-6 col-xs-12">
        <div class="panel panel-warning">
            <div class="panel-heading">
                <div class="row">
                    <div class="col-xs-2">
                        <i class="fa fa-tint fa-2x"></i>
                    </div>
                    <div class="col-xs-10 text-right">
                        <g:if test="${mostSelectedCategory == 'Social_innovation'}">
                            <span class="socialInnovationCategory">${mostSelectedCategory}&nbsp;</span>
                            <span class="otherCategory">(${mostSelectedCategoryCount})</span>
                        </g:if>
                        <g:else>
                            <span class="otherCategory">${mostSelectedCategory}&nbsp;</span>
                            <span class="otherCategory">(${mostSelectedCategoryCount})</span>
                        </g:else>
                        
                    </div>
                </div>
            </div>
            <div class="panel-footer announcement-bottom">
                Most Selected Category
            </div>
        </div>
    </div>
    <div class="clear hidden-md"></div>
    <div class="col-lg-3 col-md-4 col-sm-6 col-xs-12">
        <div class="panel panel-info">
            <div class="panel-heading">
                <div class="row">
                    <div class="col-xs-2">
                        <i class="fa fa-tint fa-2x"></i>
                    </div>
                    <div class="col-xs-10 text-right">
                        <p class="announcement-heading">${avgNumberOFPerk}</p>
                    </div>
                </div>
            </div>
            <div class="panel-footer announcement-bottom">
                Average Perks for a Campaign
            </div>
        </div>
    </div>
    
</div>
