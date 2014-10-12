<html>
<head>
<meta name="layout" content="main" />
<r:require module="projectlistjs"/>

</head>
<body>
<div class="feducontent">
	<div class="container">
		<h1> <span class="glyphicon glyphicon-tint"></span> Contribute</h1>

        <!-- Search -->
        <g:render template="list/search"></g:render>

        <g:if test="${flash.message}">
            <div class="alert alert-danger">
                ${flash.message}
            </div>
        </g:if>

        <!-- Carousel -->
		<g:render template="list/grid" model="['projects': projects]"></g:render>
	</div>
</div>
</body>
</html>
