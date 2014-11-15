<html>
<head>
    <meta name="layout" content="main" />
    <r:require modules="bootstrapsocialcss, registrationjs"/>
</head>
<body>
<div class="feducontent">
    <div class="container">

        <g:form class="form-signin" controller="login" action="create" role="form">
            <h2 class="form-signin-heading">Please register</h2>
            <%--
            <facebookAuth:connect/>
            --%>

            <a class="btn btn-block btn-social btn-facebook"
               href="${grailsApplication.config.grails.plugin.springsecurity.facebook.filter.redirect.redirectFromUrl}">
                <i class="fa fa-facebook" style="padding-top: 10px;"></i> Register with Facebook
            </a>

            <hr/>
            <div class="form-group">
                <input type="fn" name="firstName" class="form-control" placeholder="First name" autofocus>
            </div>
            <div class="form-group">
                <input type="ln" name="lastName" class="form-control" placeholder="Last name">
            </div>
            <div class="form-group">
                <input type="email" name="username" class="form-control" placeholder="Email address">
            </div>
            <div class="form-group">
                <input type="password" id="password" name="password" class="form-control" placeholder="Password">
            </div>
            <div class="form-group">
                <input type="password" name="confirmPassword" class="form-control" placeholder="Confirm-Password">
            </div>
            <button class="btn btn-primary btn-block" type="submit">Register</button>
        </g:form>

    </div>
</div>
</body>
</html>
