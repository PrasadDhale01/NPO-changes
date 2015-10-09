<g:set var="projectService" bean="projectService"/>
    <div class="col-sm-4 col-lg-2 col-sm-2 TW-dis-tab-padding panel-body  categoryList TW-discover-select-width right-select-margin">
        <g:form action="campaignsSorts" controller="project" name="sortsForm" method="POST">
            <g:select class="selectpicker allCampaign-dropdown"  name="sorts" from="${sortsOptions}" value="${sorts}" 
            optionKey="value" optionValue="value" noSelection="['Sort by':'Sort By']" onchange="selectedCampaigns()"/>
        </g:form>
    </div>
<br>
