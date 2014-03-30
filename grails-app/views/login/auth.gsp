<html>
<head>
    <meta name='layout' content='main'/>
    <r:require modules="loginjs"/>
</head>
<body>
<div class="feducontent">
    <div class="container">

        <form class="form-signin" role="form" action="${postUrl}" method="POST" id="loginForm">
            <h2 class="form-signin-heading">Please sign in</h2>
            <facebookAuth:connect/>
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

            <label class="checkbox">
                <input type="checkbox" value="remember-me" id="remember_me" name='${rememberMeParameter}' <g:if test='${hasCookie}'>checked='checked'</g:if> />
                Remember me
            </label>
            <button class="btn btn-primary btn-block" type="submit" id="submit">Sign in</button>
            <g:link controller="login" action="edit_reset">Forgot your password?</g:link>
        </form>

    </div>
</div>
</body>
</html>
