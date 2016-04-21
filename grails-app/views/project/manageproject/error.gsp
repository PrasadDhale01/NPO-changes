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
            <div class="col-lg-3 col-md-3 col-sm-3 col-xs-12 mobile-img-error">
                <img alt="web-error" src="//s3.amazonaws.com/crowdera/assets/web-image-1.jpg">
            </div>
            <div class="col-lg-9 col-md-9 col-sm-9 col-xs-12 error-paddingtop">
                <div class="error-title-color">
                    <g:if test="${flash.session_message}">
                        ${flash.session_message}
                        <g:javascript>
                            alert('Session timeout, please login!');
                            window.location.href = '/logout';
                        </g:javascript>
                    </g:if>
                    <g:elseif test="${flash.prj_mngprj_message}">
                        ${flash.prj_mngprj_message}
                    </g:elseif>
                </div>
                Click here to go back to <a href="${url}">${previousPage}</a> page or send us a message.</h6>
            </div>
<%--            <div class="alert alert-danger">--%>
<%--                Oh snap! Something went wrong.--%>
<%--            </div>--%>

        <g:if env="development">
            <g:renderErrors bean="${project}"/>
        </g:if>
    </div>
</div>
</body>
</html>
