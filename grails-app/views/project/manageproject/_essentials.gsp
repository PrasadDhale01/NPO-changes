<!-- Comments -->

<div class="col-md-12">
	<div style="overflow: hidden; width: 100%;" class="blacknwhite" onmouseover="showNavigation()" onmouseleave="hideNavigation()">
        <g:render template="/project/manageproject/projectimagescarousel"/>
    </div>
</div>
<div class="col-md-8">
    <div class="row">
        <div class="panel panel-default campaign-description">
            <div class="panel-heading">
                <h3 class="panel-title">Campaign Description</h3>
            </div>
            <div class="panel-body">
                <span class="text-left">${raw(project.description)}</span>
            </div>
        </div>
        <div class="panel panel-default" style="margin-top: 30px;">
            <div class="panel-heading">
                <h3 class="panel-title">Project Story</h3>
            </div>
            <div class="panel-body">
                <span class="text-centre project-story-span">${raw(project.story)}</span>
            </div>
        </div>  
    </div>
</div>
<div class="col-md-4">
    <g:if test="${percentage == 100}">
        <button type="button" class="btn btn-success btn-lg btn-block" disabled>SUCCESSFULLY FUNDED</button>
    </g:if>
    <g:elseif test="${ended}">
        <button type="button" class="btn btn-warning btn-lg btn-block" disabled>PROJECT ENDED!</button>
    </g:elseif>
    <div class="essentials-tiles">
    	<g:render template="/project/manageproject/tilesanstitle"/>
    </div>
    
    <g:if test="${project.draft}">
    	<g:form controller="project" action="saveasdraft">
    		<g:hiddenField name="projectId" value="${project.id}"/>
        	<button class="btn btn-block btn-primary"><i class="glyphicon glyphicon-check"></i>&nbsp;Submit for approval</button>
        </g:form>
    </g:if><br>
</div>
