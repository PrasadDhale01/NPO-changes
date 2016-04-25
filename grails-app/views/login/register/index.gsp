<g:set var="projectService" bean="projectService"/>
<%
    def request_url=request.getRequestURL().substring(0,request.getRequestURL().indexOf("/", 8))
    def base_url = (request_url.contains('www')) ? grailsApplication.config.crowdera.BASE_URL1 : grailsApplication.config.crowdera.BASE_URL
    def currentEnv = projectService.getCurrentEnvironment()
%>
<html>
<head>
    <title>Crowdera- Registration</title>
    <meta name="layout" content="main" />
    <r:require modules="bootstrapsocialcss, registrationjs"/>
</head>
<body>
<input type="hidden" id="b_url" value="<%=base_url%>" />
<div class="feducontent">
    <div class="container registration-form" id="registration-form">

        <g:form class="form-signin regForm" controller="login" action="create" id="regForm">
            <h2 class="form-signin-heading register register-logo">Please sign up</h2>
            <g:if test="${currentEnv != 'prodIndia'}">
                <a class="btn btn-block btn-social btn-facebook" href="${grailsApplication.config.grails.plugin.springsecurity.facebook.filter.redirect.redirectFromUrl}">
                    <i class="fa fa-facebook fa-facebook-styles"></i> Register with Facebook
                </a><br>
            </g:if>
            
            <oauth:connect class="btn btn-block btn-social btn-google-plus" provider="google" id="google-connect-link">
                <i class="fa fa-google-plus fa-facebook-styles"></i> Register with Google +
            </oauth:connect>

            <hr/>
            <div class="form-group">
                <input type="text" name="firstName" class="form-control all-place" placeholder="First name" autofocus>
            </div>
            <div class="form-group">
                <input type="text" name="lastName" class="form-control all-place" placeholder="Last name">
            </div>
            <div class="form-group">
                <input type="email" name="username" class="form-control subscriberEmail all-place" placeholder="Email address">
            </div>
            <div class="form-group">
                <input type="password" id="password" name="password" class="form-control all-place" placeholder="Password">
            </div>
            <div class="form-group">
                <input type="password" name="confirmPassword" class="form-control all-place" placeholder="Confirm Password">
            </div>
            <div class="form-group newsletter-reg-div" id="newsletterDiv">
				<input type="checkbox" name="subscribe" id="subscribeReg" value="1" checked="checked"/>
				<label for="subscribeReg">Sign-up to our newsletter.</label>
			</div>
			<div id="test"></div>
            <button class="btn btn-primary btn-block" type="submit" id="btnSignUp">Sign me up!</button>
            <div class="form-group">
                By signing up you agree to our <a href="${resource(dir: '/termsofuse')}">Terms of Use</a> and <a href="${resource(dir: '/privacypolicy')}">Privacy Policy</a>
            </div>
        </g:form>

    </div>
</div>
</body>
</html>
