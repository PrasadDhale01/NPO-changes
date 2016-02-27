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
            <div class="error-img">
              <div class="col-lg-3 col-md-3 col-sm-3 col-xs-12 mobile-img-error">
                  <img alt="web-error" src="//s3.amazonaws.com/crowdera/assets/web-image-1.jpg">
              </div>
              <div class="col-lg-9 col-md-9 col-sm-9 col-xs-12 error-paddingtop">
                    <g:if test="${message}">
                        <div class="error-title-color404">${message}<br> Click <a href="${url}" id="previousUrl">here</a> to go back to previous page</div>
                    </g:if>
                    <g:else>
                         <h2 class="error-title-color404">This campaign does not exist. <br>Click <a href="${url}" id="previousUrl">here</a> to go back to previous page</h2>
                    </g:else>
<%--                    <h6 class="error-description-font">We know you hate this and so do we! But our geeks will fix this issue in no time.--%>
<%--                        you can continue--%>
<%--                        Click <a href="${url}" id="previousUrl">here</a> go back to previous page or send us a message.</h6>--%>
               </div>
            </div>
        </g:if>
        <g:else>
            <h1>Error</h1>
            <div class="alert alert-danger">
                Page not found.
            </div>
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
