<html>
<head>
    <meta name='layout' content='main'/>
    <r:require modules="bootstrapsocialcss, loginjs"/>
</head>
<body>
<div class="feducontent">
    <div class="container">

        <form class="form-signin" role="form" action="${postUrl}" method="POST" id="loginForm">
            <h2 class="form-signin-heading signin login-logo">Please login</h2>
            <%--
            <facebookAuth:connect/>
            --%>
            <a class="btn btn-block btn-social btn-facebook"
               href="${grailsApplication.config.grails.plugin.springsecurity.facebook.filter.redirect.redirectFromUrl}">
                <i class="fa fa-facebook fa-facebook-styles"></i> Sign in with Facebook
            </a>
            <hr/>
            <g:if test='${flash.message}'>
                <div class="alert alert-danger">${flash.message}</div>
            </g:if>

            <div class="form-group">
                <input type="email" class="form-control" name="j_username" id="username" placeholder="Email address" autofocus>
            </div>

            <div class="form-group">
                <input type="password" class="form-control" placeholder="Password" name="j_password" id="password">
            </div>

<%--            <label class="checkbox">--%>
<%--                <input type="checkbox" value="remember-me" id="remember_me" name='${rememberMeParameter}' <g:if test='${hasCookie}'>checked='checked'</g:if> />--%>
<%--                Remember me--%>
<%--            </label>--%>
            <g:link controller="login" action="edit_reset">Forgot your password?</g:link><br><br>
            <button class="btn btn-primary btn-block" type="submit" id="submit">Sign in</button>

            <p>New to Crowdera? <g:link controller="login" action="register">Sign up</g:link> </p>
        </form>
        
    </div>
</div>
</body>
</html>
