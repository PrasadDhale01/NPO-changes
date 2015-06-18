<g:set var="projectService" bean="projectService"/>
<% 
    def categoryOptions = projectService.getCategory() 
	def base_url = grailsApplication.config.crowdera.BASE_URL
	def base = "/campaign?"
%>
<html>
<head>
<meta name="layout" content="main" />
<r:require module="projectlistjs"/>
</head>
<body>
    <div class="feducontent">
	<div class="container">
	    <div class="row">
		<div class="col-md-6">
		<h1><img class="img-circle" src="//s3.amazonaws.com/crowdera/assets/icon-contribution.png" alt="contribution"/> Contribute</h1>
		</div>
                <!-- Search -->
                <g:render template="list/search"></g:render>
            </div>
	    <div class="row">
	        <label class="col-sm-11"><h3>Explore <g:if test="${selectedCategory != "All"}">${selectedCategory}</g:if></h3></label><br>
	    </div><br>
	    <div class="row">
		<div class="col-md-2 col-lg-2 col-sm-0 categoryList list-category">
                    <g:form action="category" controller="project" name="categoryForm">
                        <g:select class="selectpicker" name="category" from="${categoryOptions}" id="category"
		            optionKey="value" optionValue="value" value="${params.category}" onchange="selectedCategory()"/>
		     </g:form>
		</div>
		<div class="col-md-10 col-lg-10 col-sm-12">
        	    <g:if test="${flash.catmessage}">
            	       <div class="alert alert-danger">
                           ${flash.catmessage}
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
