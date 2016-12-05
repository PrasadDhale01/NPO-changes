<html>
<head>
<meta name="layout" content="main" />
</head>
<body>
<input type="hidden" name="url" value="${currentEnv}" id="currentEnv"/>
<div class="feducontent">
    <div class="container success-error-container">
	<g:if test="${project.id}">
	    <div class="wrap">
	        <h2>
	        <g:link controller="project" action="manageproject" id="${project.id}" title="${project.title}" params="['country_code': country_code]">
		        ${project.title}
		    </g:link>
		</h2>
		<div class="alert alert-success">Awesome. You have successfully created the Campaign.</div>
		<!-- <div class="alert alert-warning">This project is not yet published.</div> -->
	    </div>
	    <div class="panel panel-default">
		<div class="panel-heading">
		    <h3 class="panel-title">Next steps</h3>
		</div>
		<div class="panel-body">
			Your campaign has been submitted for review and will be published within 24 hours. Once published, share your campaign with family and friends across your social networks and get funded!		</div>
	    </div>
	</g:if>
	<g:else>
	    <div class="alert alert-danger">
               Oh snap! Looks like that Campaign doesn't exist Oh snap! Looks like that Campaign doesn't exist
	    </div>
	</g:else>
    </div>
</div>
</body>
</html>
