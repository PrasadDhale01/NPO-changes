<html>
<head>
<meta name="layout" content="main" />
<r:require modules="projectshowjs"/>
</head>
<body>
	<div class="container">
		<g:if test="${project}">
            <div class="row">
                <div class="col-md-8">
                    <h1>
                        <a href="${project.id}">${project.title}</a>
                    </h1>
                    <h4 class="lead">Beneficiary: ${project.name}</h4>
                    <p class="text-justify">${project.story}</p>
                </div>
                <div class="col-md-4">
                    <g:render template="/layouts/singletile"/>
                    <g:render template="show/rewards"/>
                </div>
            </div>
            <%--
			<g:if test="${project.validated == false}">
                <div class="alert alert-warning">This project is not yet published.</div>
			</g:if>
			--%>
            <g:render template="show/comments"/>
		</g:if>
		<g:else>
            <h1>Project not found</h1>
			<div class="alert alert-danger">Oh snap! Looks like that project doesn't exist.</div>
		</g:else>
	</div>
</body>
</html>
