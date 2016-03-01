<g:set var="projectService" bean="projectService"/>
<html>
<head>
    <meta name="layout" content="main"/>
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
		
		    <h6 class="error-description-font">
		      <g:if test="${facelogoutmsg}">
		         ${facelogoutmsg}
		     </g:if>
		     <g:if test="${flash.googlePlusErrorMessage}">
		         ${flash.googlePlusErrorMessage}
		     </g:if>
		     <g:if test="${message}">
<%--		        <div class="error-title-color">We're sorry, looks like something is broken</div>--%>
		         ${message}
		     </g:if>
		     Click <a href="${url}" id="previousUrl">here</a> to go back to previous page.</h6>
		</div>
    </g:if>
    <g:else>
        <h1>Error</h1>
        <g:if test="${facelogoutmsg}">
            <div class="alert alert-danger">
                ${facelogoutmsg}
            </div>
        </g:if>
        <g:if test="${flash.googlePlusErrorMessage}">
            <div class="alert alert-danger">
                ${flash.googlePlusErrorMessage}
            </div>
        </g:if>
        <g:if test="${message}">
            <div class="alert alert-danger">
                ${message}
            </div>
        </g:if>
    </g:else>
    </div>
</div>
</body>
</html>
