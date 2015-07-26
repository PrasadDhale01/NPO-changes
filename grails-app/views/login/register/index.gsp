<%  
	def base_url = grailsApplication.config.crowdera.BASE_URL
%>
<html>
<head>
    <meta name="layout" content="main" />
    <r:require modules="bootstrapsocialcss, registrationjs"/>
</head>
<body>
<input type="hidden" id="b_url" value="<%=base_url%>" />
<div class="feducontent">
    <div class="container">

        <g:form class="form-signin regForm" controller="login" action="create" role="form" id="regForm">
            <h2 class="form-signin-heading register register-logo">Please sign up</h2>
            <%--
            <facebookAuth:connect/>
            --%>

            <a class="btn btn-block btn-social btn-facebook"
               href="${grailsApplication.config.grails.plugin.springsecurity.facebook.filter.redirect.redirectFromUrl}">
                <i class="fa fa-facebook fa-facebook-styles"></i> Register with Facebook
            </a><br>
            
            <oauth:connect class="btn btn-block btn-social btn-google-plus" provider="google" id="google-connect-link">
                <i class="fa fa-google-plus fa-facebook-styles"></i> Register with Google +
            </oauth:connect>

            <hr/>
            <div class="form-group">
                <input type="text" name="firstName" class="form-control" placeholder="First name" autofocus>
            </div>
            <div class="form-group">
                <input type="text" name="lastName" class="form-control" placeholder="Last name">
            </div>
            <div class="form-group">
                <input type="email" name="username" class="form-control subscriberEmail" placeholder="Email address">
            </div>
            <div class="form-group">
                <input type="password" id="password" name="password" class="form-control" placeholder="Password">
            </div>
            <div class="form-group">
                <input type="password" name="confirmPassword" class="form-control" placeholder="Confirm Password">
            </div>
            <div class="form-group newsletter-reg-div" id="newsletterDiv">
				<input type="checkbox" name="subscribe" id="subscribeReg" value="1" checked="checked"/>
				<label for="subscribeReg">Sign-up to our newsletter.</label>
			</div>
			<div id="test"></div>
            <button class="btn btn-primary btn-block" type="submit" id="btnSignUp">Sign me up!</button>
        </g:form>

    </div>
</div>
</body>
</html>
