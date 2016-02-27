<html>
<head>
<meta name="layout" content="main" />
</head>
<body>
<div class="feducontent">
    <div class="container success-error-container">
    <%
        def url = request.getHeader('referer')
    %>
        <g:if test="${currentEnv == 'development' || currentEnv == 'test' || currentEnv == 'testIndia'}">
              <div class="col-lg-3 col-md-3 col-sm-3 col-xs-12 mobile-img-error">
                  <img alt="web-error" src="//s3.amazonaws.com/crowdera/assets/web-image-1.jpg">
              </div>
              <div class="col-lg-9 col-md-9 col-sm-9 col-xs-12 error-paddingtop">
                    <div class="error-title-color">We're sorry, looks like something is broken</div>
                    <h6 class="error-description-font">We know you hate this and so do we! But our geeks will fix this issue in no time.
                        <br>
                        Click here to go back to <a href="${url}">${previousPage}</a> page or send us a message.</h6>
               </div>
        </g:if>
        <g:else>
            <div class="alert alert-danger">
                Oh snap! Something went wrong.
            </div>
        </g:else>
<%--        <div class="alert alert-danger">--%>
            <g:if test="${flash.session_message}">
                <ul>
                    <li>${flash.session_message}</li>
                </ul>
                <g:javascript>
                    alert('Session timeout, please login!');
                    window.location.href = '/logout';
                </g:javascript>
            </g:if>
            <g:elseif test="${flash.prj_mngprj_message}">
                <ul>
                    <li>${flash.prj_mngprj_message}</li>
                </ul>
            </g:elseif>
<%--        </div>--%>

        <g:if env="development">
            <g:renderErrors bean="${project}"/>
        </g:if>
    </div>
</div>
</body>
</html>
