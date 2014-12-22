<g:set var="projectService" bean="projectService"/>
<html>
<head>
<meta name="layout" content="main" />
<r:require module="projectlistjs"/>

</head>
<body>
<div class="feducontent">
	<div class="container">
	<% def category = projectService.getCategoryList() %>
		<div class="row">
		    <div class="col-md-6">
		        <h1> <span class="glyphicon glyphicon-tint"></span> Contribute</h1>
		    </div>
            <!-- Search -->
            <g:render template="list/search"></g:render>
		</div>
		<div class="row">
			<div class="col-sm-2">
				<h4>Categories</h4><br>
				<a href="/project/categoyFilter/All" <g:if test="${selectedCategory == "All"}">class="categorylink"</g:if>>All Categories</a><br>
				<g:each in="${category}" var="categories">
					<a href="/project/categoyFilter/${categories.value}"<g:if test="${selectedCategory == categories.value}">class="categorylink"</g:if>>${categories.value}</a><br>
				</g:each>
			</div>
			<div class="col-sm-10">
				<h4>Explore
					<g:if test="${selectedCategory != "All"}">${selectedCategory}</g:if>
				</h4><br>
        		<g:if test="${flash.message}">
            		<div class="alert alert-danger">
                		${flash.message}
            		</div>
        		</g:if>
        		<g:else>
        			<!-- Carousel -->
					<g:render template="list/grid" model="['projects': projects]"></g:render>
				</g:else>
			</div>
		</div>
	</div>
</div>
</body>
</html>
