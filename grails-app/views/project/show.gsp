<html>
<head>
<meta name="layout" content="main" />
</head>
<body>
	<div class="container">
		<g:if test="${project}">
            <h1>
                <a href="${project.id}">${project.title}</a>
            </h1>
            <h4 class="lead">Beneficiary: ${project.name}</h4>
			<g:if test="${project.validated == false}">
                <div class="alert alert-warning">This project is not yet published.</div>
			</g:if>

		</g:if>
		<g:else>
            <h1>Project not found</h1>
			<div class="alert alert-danger">Oh snap! Looks like that project doesn't exist.</div>
		</g:else>
	</div>
</body>
</html>
