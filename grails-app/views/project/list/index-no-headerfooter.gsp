<html>
<head>
<meta name="layout" content="main-no-headerfooter" />
<r:require module="projectlistjs"/>

</head>
<body>
<div class="feducontent">
	<div class="container">
		<h1> <span class="glyphicon glyphicon-tint"></span> Contribute</h1>

        <!-- Search -->
        <%-- <g:render template="list/search"></g:render> --%>

        <!-- Carousel -->
		<g:render template="list/grid" model="['projects': projects]"></g:render>
	</div>
</div>
</body>
</html>
