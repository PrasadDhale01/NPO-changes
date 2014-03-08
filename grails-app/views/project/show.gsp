<html>
<head>
<meta name="layout" content="main" />
</head>
<body>
	<div class="container">
		<g:if test="${project}">
			<div class="row">
				<div class="col-sm-8">
					<h2>
						<a href="${project.id}">
							${project.title}
						</a>
					</h2>
				</div>
				<div class="col-sm-4"></div>
			</div>
			<g:if test="${project.validated == false}">
                <div class="alert alert-warning">This project is not yet published.</div>
			</g:if>

		</g:if>
		<g:else>
			<p>
			<div class="alert alert-danger">Oh snap! Looks like that project doesn't exist.</div>
			</p>
		</g:else>
	</div>
</body>
</html>
