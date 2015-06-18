<g:set var="projectService" bean="projectService"/>
<%
	def sortsOptions = projectService.getSorts()
%>
<div class="row">
    <div class="col-sm-4 sortscamp sorts-dropdown">
        <g:form action="campaignsSorts" controller="project" name="sortsForm">
            <g:select class="selectpicker" name="sorts" from="${sortsOptions}"
		            optionKey="value" optionValue="value" value="${sorts}" onchange="selectedCampaigns()"/>
        </g:form>
    </div>
    <!-- /btn-group -->
</div>
<!--<div class="col-md-4">
    <g:render template="list/pagination"></g:render>
</div> -->
<br>
