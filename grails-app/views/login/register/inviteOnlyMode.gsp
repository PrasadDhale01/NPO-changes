<html>
<head>
    <meta name="layout" content="main" />
    <r:require modules="bootstrapsocialcss, registrationjs"/>
</head>
<body>
<div class="feducontent">
    <div class="container">

        <g:form class="form-signin" controller="login" action="user_request" role="form">
            <h2 class="form-signin-heading">Registration Request</h2>
            
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
                <input type="hidden" name="password" class="form-control" value="password">
            </div>
            <button class="btn btn-primary btn-block" type="submit">Submit</button>
        </g:form>

    </div>
</div>
</body>
</html>