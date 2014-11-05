<g:set var="projectService" bean="projectService"/>
<div class="blacknwhite" style="height: 100%; overflow: hidden; width: 100%;padding: 0; margin-top: 30px; background-color:#f0f0f0;">
	<label class="col-sm-12" style="margin-top:10px"><h3>PROJECT BY</h3></label>
   	<img alt="" src="${project.organizationIconUrl}" style="height:175px; width:175px; margin-left: 10px; border:2px">
    
    <label class="col-sm-12" style="margin-top:10px;"><h4><b>${project.organizationName}</b></h4></label>
    <label class="col-sm-12">WEB: <a href="${project.webAddress}">${project.webAddress}</a></label>
</div>
