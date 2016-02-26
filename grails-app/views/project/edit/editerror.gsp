<html>
<head>
<meta name="layout" content="main" />
</head>
<body>
<div class="feducontent">
    <%
        def url = request.getHeader('referer')
    %>
    <div class="container success-error-container">
        <g:if test="${currentEnv == 'development' || currentEnv == 'test' || currentEnv == 'testIndia'}">
             <div class="col-lg-3 col-md-3 col-sm-3 col-xs-12 mobile-img-error">
              <img alt="web-error" src="//s3.amazonaws.com/crowdera/assets/web-image-1.jpg">
          </div>
          <div class="col-lg-9 col-md-9 col-sm-9 col-xs-12 error-paddingtop">
                <h2 class="error-title-color">We're sorry, looks like something is broken</h2>
                <h6 class="error-description-font">We know you hate this and so do we! But our geeks will fix this issue in no time.
                    you can continue
                    Click here to return to go back to <a href="${url}">${previousPage}</a> page or send us a message.</h6>
           </div>
        </g:if>
        <g:else>
         <g:if test="${flash.prj_edit_message}">
             <ul>
                 <li>${flash.prj_edit_message}</li>
             </ul>
         </g:if>
        </g:else>

        <g:if env="development">
            <g:renderErrors bean="${project}"/>
        </g:if>
    </div>
</div>
</body>
</html>
