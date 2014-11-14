<html>
<head>
<meta name="layout" content="main" />
</head>
<body>
<div class="feducontent">
    <div class="container">
	<g:if test="${project}">
	    <div>
	        <h2>
	        <g:link controller="project" action="manageproject" id="${project.id}" title="${project.title}">
		        ${project.title}
		    </g:link>
		  	</h2>
		<div class="alert alert-success">Your Project has been saved as draft.</div>
		<!-- <div class="alert alert-warning">This project is not yet published.</div> -->
	    </div>
	    <div class="panel panel-default">
		<div class="panel-heading">
		    <h3 class="panel-title">Next steps</h3>
		</div>
		<div class="panel-body">
		    <ul>
			<li>It is now not send to admin for approval</li>
			<li>When you want you can send it for admin approval from User setting page.</li>
		    </ul>
		</div>
	    </div>
	</g:if>
	<g:else>
	    <h2>Error</h2>
	    <div class="alert alert-danger">Oh snap! Looks like that project doesn't exist.</div>
	</g:else>
    </div>
</div>
</body>
</html>
