<html>
<head>
    <meta name="layout" content="main" />
    <r:require modules="projectshowjs"/>
</head>
<body>
<g:set var="projectService" bean="projectService"/>
<div class="feducontent">
    <div class="container">
        <g:if test="${project}">
            <div class="row">
	            <div class="col-md-9">
                    <h1><a href="${project.id}">${project.title}</a></h1>
                    <table class="table table-bordered" style="width:100%">
                        <thead>
							<tr class="info">
							    <th>NAME</th>
							    <th>DESCRIPTION</th>
							    <th>STORY</th>
							    <th>CREATED AT</th>
							    <th>CATEGORY</th>
							</tr>
                        </thead>
                        <tbody>
							<tr class="active">	
							    <td class="text-justify">${projectService.getBeneficiaryName(project)}</td>
						             <td class="text-justify" style="word-break:break-all;">${raw(project.description)}</td>
						             <td class="text-justify" style="word-break:break-all;">${raw(project.story)}</td>
						             <td class="text-justify">${project.created}</td>
							    <td class="text-justify">${project.category}</td>
							</tr>
		                </tbody>
		            </table>
		            <div class="col-md-12">
	                    <div style="overflow: hidden; width: 100%;" class="blacknwhite" onmouseover="showNavigation()" onmouseleave="hideNavigation()">
                            <g:render template="/project/manageproject/projectimagescarousel"/>
                       </div>
                   </div>
                </div>
                <div class="col-md-3">
                     <div class="row">
            	        <div class="col-md-12">
		                    <g:render template="/project/manageproject/tilesanstitle"/>
		                </div>
		            </div>
		            <div class="row">
		                <div class="col-md-6">
		                    <g:link controller="project" action="updateValidation" id="${project.id}" class="btn btn-primary" role="button"><i class="glyphicon glyphicon-check" style="width:175"></i>&nbsp;Validate</g:link>
		                </div>
		                <div class="col-md-6">
		                    <g:form action="delete" controller="project" id="${project.id}" method="post" >
                                <button class="btn btn-danger" name="_action_delete" value="Delete" onclick="return confirm(&#39;Are you sure you want to discard this project?&#39;);" style="width:180"><i class="fa fa-trash-o" ></i>&nbsp;Discard
                	            </button>
           		            </g:form>
		                </div>
		            </div>
                </div>
            </div>
        </g:if>
 	    <g:else>
            <h1>Project not found</h1>
	        <div class="alert alert-danger">Oh snap! Looks like that project doesn't exist.</div>
	    </g:else>
	    <div class="col-md-9">
        	<g:if test="${project.videoUrl}">
            	<div id="youtubeVideoUrl">
                	${project.videoUrl}
	            </div>
	            <div class="video-container" id="youtube">
	            </div>
            </g:if>
        </div>
    </div>
</div>
</body>
</html> 
