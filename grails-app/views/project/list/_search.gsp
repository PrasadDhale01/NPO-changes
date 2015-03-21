<g:set var="projectService" bean="projectService"/>
<%
	def sortsOptions = projectService.getSorts()
%>
<div class="row">
    <div class="col-sm-4 sortscamp">
        <g:form action="campaignsSorts" controller="project" name="sortsForm">
            <g:select class="selectpicker" name="sorts" from="${sortsOptions}"
		            optionKey="value" optionValue="value" value="${sorts}" onchange="selectedCampaigns()"/>
        </g:form>
    </div>
    <!-- /btn-group -->
    <div class="input-group">
        <form action="/campaign/query" onClick="searchList()" name="searchableForm">
            <div class="inner-addon right-addon">
                <i class="glyphicon glyphicon-search"></i>
                <input type="search" class="search" id="q"  name="q" value="${params.q}" placeholder="Search">
            </div>
        </form>
    </div>
</div>
<!--<div class="col-md-4">
    <g:render template="list/pagination"></g:render>
</div> -->
<br>
