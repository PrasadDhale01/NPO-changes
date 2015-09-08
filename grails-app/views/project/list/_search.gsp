<g:set var="projectService" bean="projectService"/>
<div class="row">
    <div class="col-sm-4 sortscamp sorts-dropdown">
        <g:form action="campaignsSorts" controller="project" name="sortsForm">
            <g:select class="selectpicker allCampaign-dropdown" name="sorts" from="${sortsOptions}"
		            optionKey="value" optionValue="value" value="${sorts}" onchange="selectedCampaigns()"/>
        </g:form>
    </div>
</div>
<br>
