<g:set var="projectService" bean="projectService"/>
    <div class="col-sm-4 col-lg-2 col-sm-2 TW-dis-tab-padding panel-body  categoryList TW-discover-select-width right-select-margin">
        <g:form action="campaignsSorts" controller="project" name="sortsForm">
            <g:select class="selectpicker allCampaign-dropdown" name="sorts" from="${sortsOptions}"
		            optionKey="value" optionValue="value" value="${sorts}" onchange="selectedCampaigns()"/>
        </g:form>
    </div>
<br>
