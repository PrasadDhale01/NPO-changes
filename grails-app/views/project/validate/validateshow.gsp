<html>
<head>
    <meta name="layout" content="main" />
    <r:require modules="projectshowjs"/>
</head>
<body>
<g:set var="projectService" bean="projectService"/>
<div class="feducontent">
    <div class="container">
        <g:if test="${projects}">
            <div class="row">
	            <div class="col-md-8">
		            <h1><a href="${projects.id}">${projects.title}</a></h1>
		            <table class="table table-bordered" style="width:100%">
		                <thead>
			            <tr class="info">
			                <th>NAME</th>
			                <th>DESCRIPTION</th>
			                <th>STORY</th>
			                <th>CREATED AT</th>
			                <th>FOR</th>
			                <th>REASON</th>
			                <th>CATEGORY</th>
			            </tr>	
		                </thead>
		                <tbody>
			            <tr class="active">	
			                <td class="text-justify">${projectService.getBeneficiaryName(projects)}</td>
				            <td class="text-justify">${projects.sstory}</td>
				            <td class="text-justify">${projects.story}</td>
				            <td class="text-justify">${projects.created}</td>  
				            <td class="text-justify">${projects.fundRaisingFor}</td>
				            <td class="text-justify">${projects.fundRaisingReason}</td>  
				            <td class="text-justify">${projects.category}</td>
			            </tr>
		                </tbody>
		            </table>
                </div>  
                <div class="col-md-4">
                    <div class="row">
            	        <div class="col-md-12">
		                    <g:render template="validate/validatetile"/>
		                </div>
		            </div>
		            <div class="row">
		                <div class="col-md-6">
		                    <g:link controller="project" action="update" id="${projects.id}" class="btn btn-primary btn-lg btn-block" role="button"><i class="glyphicon glyphicon-check" style="width:175"></i>&nbsp;Validate</g:link>  
		                </div>
		                <div class="col-md-6">
		                    <g:form action="delete" controller="project" id="${projects.id}" method="post" >
                                <button class="btn btn-danger btn-lg btn-block" name="_action_delete" value="Delete" onclick="return confirm(&#39;Are you sure you want to Delete this project?&#39;);" style="width:180"><i class="fa fa-trash-o" ></i>&nbsp;Discard
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
    </div>
</div>
</body>
</html> 
