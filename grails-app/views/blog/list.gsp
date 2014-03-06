<html>
<head>
<meta name="layout" content="main" />
</head>
<body>
	<div class="container">
		<h1>Blog</h1>

		<g:each in='${blogs}'>
			<g:render template="/blog/blogsnippet" bean="${it}"></g:render>
		</g:each>

	</div>
</body>
</html>
