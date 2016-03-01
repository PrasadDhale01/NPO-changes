<g:set var="projectService" bean="projectService"/>
<html>
<head>
    <meta name="layout" content="main"/>
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
                    <div class="error-title-color">
                        <g:if test="${message}">
                            ${message}
                        </g:if>
                        <g:else>
                            Looks like the page for which you are looking doesn't exist.
                        </g:else>
                    </div>
                    <h6 class="error-description-font"> Click <a href="${url}" id="previousUrl">here</a> to go back to previous page or send us a message.</h6>
               </div>
        </g:if>
        <g:else>
	        <h1>Error</h1>
	        <div class="alert alert-danger">
	            ${message}
	        </div>
	    </g:else>
    </div>
</div>

<script>
    $('#previousUrl').click(function(e) {
        e.preventDefault();
        window.history.back();
    })
</script>

</body>
</html>
