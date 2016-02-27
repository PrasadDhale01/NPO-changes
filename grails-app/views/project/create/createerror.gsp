<g:set var="projectService" bean="projectService"/>
<html>
<head>
<meta name="layout" content="main" />
</head>
<body>
<div class="feducontent">
    <div class="container success-error-container">
	    <%
	        def url = request.getHeader('referer')
            def currentEnv = projectService.getCurrentEnvironment()
	    %>
        <g:if test="${currentEnv == 'development' || currentEnv == 'test' || currentEnv == 'testIndia'}">
			<div class="col-lg-3 col-md-3 col-sm-3 col-xs-12 mobile-img-error">
			    <img alt="web-error" src="//s3.amazonaws.com/crowdera/assets/web-image-1.jpg">
			</div>
			<div class="col-lg-9 col-md-9 col-sm-9 col-xs-12 error-paddingtop">
			      <h2 class="error-title-color">We're sorry, looks like something is broken</h2>
			      <h6 class="error-description-font">We know you hate this and so do we! But our geeks will fix this issue in no time.
			          you can continue
			          Click here to go back to <a href="${url}">${previousPage}</a> page or send us a message.</h6>
			</div>
        </g:if>
        <g:else>
			<h2>Error</h2>
			<div class="alert alert-danger">
			    Oh snap! Something went wrong creating the Campaign.
			    <g:if test="${flash}">
			        <ul>
			            <li>${flash.message}</li>
			        </ul>
			    </g:if>
			</div>
        </g:else>
        <g:if env="development">
            <g:renderErrors bean="${project}"/>
        </g:if>
    </div>
</div>
</body>
</html>
