<html>
<head>
<meta name="layout" content="main" />
</head>
<body>
<div class="feducontent">
	<div class="container">
		<h1>FEDU Blog</h1>

		<g:each in='${blogs}'>
			<g:render template="/blog/blogsnippet" bean="${it}"></g:render>
		</g:each>

	</div>
</div>
</body>
</html>
