<g:set var="projectService" bean="projectService"/>
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
            <div class="container success-error-container">
            <%
                def currentEnv = projectService.getCurrentEnvironment()
                def url = request.getHeader('referer')
            %>
	           <g:if test="${currentEnv == 'development' || currentEnv == 'test' || currentEnv == 'testIndia'}">
	               <div class="col-lg-3 col-md-3 col-sm-3 col-xs-12 mobile-img-error">
			      <img alt="web-error" src="//s3.amazonaws.com/crowdera/assets/web-image-1.jpg">
	               </div>
	               <div class="col-lg-9 col-md-9 col-sm-9 col-xs-12 error-paddingtop">
	                   <h2 class="error-title-color">We're sorry, looks like something is broken</h2>
	                   <h6 class="error-description-font">We know you hate this and so do we! But our geeks will fix this issue in no time.
	                   <br/>
	                   Click <a href="${url}" id="previousUrl">here</a> to go back to previous page or send us a message.</h6>
	               </div>
	           </g:if>
	           <g:else>
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
	           </g:else>
            </div>
        </div>
        <script>
			$('#previousUrl').click(function(e) {
			    e.preventDefault();
			    window.history.back();
			});
        </script>
	</body>
</html>
