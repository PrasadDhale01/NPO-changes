<html>
	<head>
		<title>
            <g:if env="development">Grails Runtime Exception</g:if>
            <g:else>Error</g:else>
        </title>
		<meta name="layout" content="main"/>
		<g:if env="development">
            <link rel="stylesheet" href="${resource(dir: 'css', file: 'errors.css')}" type="text/css">
        </g:if>
	</head>
	<body>
        <div class="feducontent">
            <div class="container">
                <g:if env="development" test="${exception}">
                    <g:renderException exception="${exception}" />
                </g:if>
                <g:else>
                    <h2>Error</h2>
                    <g:if test="${flash.error}">
                        <div class="alert alert-danger">
                            ${flash.error}
                        </div>
                    </g:if>
                    <g:else>
                        <div class="alert alert-danger">
                            Oh snap! Something went wrong. Please try again.
                        </div>
                    </g:else>
                </g:else>
            </div>
        </div>
	</body>
</html>
