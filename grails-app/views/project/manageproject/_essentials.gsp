<!-- Comments -->

<div class="col-md-8">
    <div class="row">
        <div class="panel panel-default" style="margin-top: 30px;">
            <div class="panel-heading">
                <h3 class="panel-title">Project Description</h3>
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
                <span class="text-centre">${raw(project.story)}</span>
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
    
    <g:render template="/project/manageproject/tilesanstitle"/>
</div>
