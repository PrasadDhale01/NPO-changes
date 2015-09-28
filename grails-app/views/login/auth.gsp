<html>
<g:set var="projectService" bean="projectService"/>
<%
	def currentEnv = projectService.getCurrentEnvironment()
    def loginSignUpCookie = g.cookie(name: 'loginSignUpCookie')
	def fundingAmountCookieValue = g.cookie(name: 'fundingAmountCookie')
	def campaignNameCookieValue = g.cookie(name: 'campaignNameCookie')
	def contributorNameCookieValue = g.cookie(name: 'contributorNameCookie')
%>
<head>
    <meta name='layout' content='main'/>
    <r:require modules="bootstrapsocialcss, loginjs, registrationjs"/>
</head>
<body>
<div class="campaignCreateUserLogin">
    <div class="container userLoginContainer">
        <g:if test="${loginSignUpCookie}">
            <div class="campaignloginheading text-center">
                <g:if test="${campaignNameCookieValue}">
                    <h4><b><p>Welcome ${contributorNameCookieValue},</p><p>Thank you for your compassionate contribution of ${fundingAmountCookieValue}<g:if test="${currentEnv == 'testIndia' || currentEnv == 'stagingIndia' || currentEnv == 'prodIndia'}"> INR</g:if><g:else> USD</g:else> to ${campaignNameCookieValue}. Please Sign Up or Sign In to track the progress of the campaign, share on social media and receive your receipt.</p></b></h4>
                </g:if>
                <g:else>
                    <h4><b class="campaignloginboldheading">Great!</b> <b class="campaignloginlightheading">You are almost there please sign up or sign in to complete your campaign & raise money free.</b></h4>
                </g:else>
            </div>
            <div class="clear"></div>
            <div class="campaignUserLoginSubHeading text-center hidden-lg hidden-xs hidden-md">
                <h3><b>Get Started Quickly</b></h3>
            </div>
            <div class="col-md-4 hidden-sm col-xs-12">
                <div class="campaignUserLoginSubHeading text-center">
                    <h3><b class="subBoldHeading">Get Started Quickly</b></h3>
                </div>
                <g:if test="${flash.googleFailureMessage}">
                    <div class="alert alert-danger">${flash.googleFailureMessage}</div>
                </g:if>
                <g:if test="${currentEnv != 'prodIndia'}">
                    <div class="facebookSignInBtn">
                        <a class="btn btn-block btn-social btn-facebook" href="${grailsApplication.config.grails.plugin.springsecurity.facebook.filter.redirect.redirectFromUrl}">
                            <i class="fa fa-facebook fa-facebook-styles"></i> Sign in with Facebook
                        </a><br>
                    </div>
                </g:if>
                <div class="googleSignInBtn">
                    <oauth:connect class="btn btn-block btn-social btn-google-plus" provider="google" id="google-connect-link">
                        <i class="fa fa-google-plus fa-facebook-styles"></i> Sign in with Google +
                    </oauth:connect>
                </div>
            </div>
            <div class="col-sm-6 hidden-lg hidden-xs hidden-md">
                <a class="btn btn-block btn-social btn-facebook" href="${grailsApplication.config.grails.plugin.springsecurity.facebook.filter.redirect.redirectFromUrl}">
                    <i class="fa fa-facebook fa-facebook-styles"></i> Sign in with Facebook
                </a>
            </div>
            <div class="col-sm-6 hidden-lg hidden-xs hidden-md">
                <oauth:connect class="btn btn-block btn-social btn-google-plus" provider="google" id="google-connect-link">
                    <i class="fa fa-google-plus fa-facebook-styles"></i> Sign in with Google +
                </oauth:connect>
            </div>
            <div class="col-md-4 col-sm-6 col-xs-12 signInAndUpTopSm" id="registration-form">
                <div class="campaignUserLoginSubHeading text-center">
                    <h3><b class="subBoldHeading">Sign Up</b></h3>
                </div>
                <g:if test="${signUpMessage}">
                    <div class="alert alert-danger">${signUpMessage}</div>
                </g:if>
                <g:form class="form-signin regForm" controller="login" action="create" id="regForm">
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
            <div class="col-md-4 col-sm-6 col-xs-12 signInAndUpTopSm">
                <form class="form-signin" action="${postUrl}" method="POST" id="loginForm" name="loginForm">
                    <div class="campaignUserLoginSubHeading text-center">
                        <h3><b class="subBoldHeading">Sign In</b></h3>
                    </div>
                    <div class="campaignCreateLoginSection">
                        <div class="form-group">
                            <input type="email" class="form-control all-place" name="j_username" id="username" placeholder="Email address" autofocus>
                        </div>
                        <div class="form-group">
                            <input type="password" class="form-control all-place" placeholder="Password" name="j_password" id="password">
                        </div>
                        <g:link controller="login" action="edit_reset">Forgot your password?</g:link><br><br>
                        <button class="btn btn-primary btn-block" type="submit" id="submit">Sign in</button>
                    </div>
                </form>
            </div>
        </g:if>
        <g:else>
            <div class="login-form">
                <form class="form-signin" action="${postUrl}" method="POST" id="loginForm" name="loginForm">
                    <h2 class="form-signin-heading signin login-logo">Please login</h2>
                    <g:if test="${currentEnv != 'prodIndia'}">
                        <a class="btn btn-block btn-social btn-facebook" href="${grailsApplication.config.grails.plugin.springsecurity.facebook.filter.redirect.redirectFromUrl}">
                            <i class="fa fa-facebook fa-facebook-styles"></i> Sign in with Facebook
                        </a><br>
                    </g:if>

                    <oauth:connect class="btn btn-block btn-social btn-google-plus" provider="google" id="google-connect-link">
                        <i class="fa fa-google-plus fa-facebook-styles"></i> Sign in with Google +
                    </oauth:connect>
                    <hr/>
                    <g:if test='${flash.message}'>
                        <div class="alert alert-danger">${flash.message}</div>
                    </g:if>
                    <g:if test="${flash.googleFailureMessage}">
                        <div class="alert alert-danger">${flash.googleFailureMessage}</div>
                    </g:if>

                    <div class="form-group">
                        <input type="email" class="form-control all-place" name="j_username" id="username" placeholder="Email address" autofocus>
                    </div>

                    <div class="form-group">
                        <input type="password" class="form-control all-place" placeholder="Password" name="j_password" id="password">
                    </div>

                    <g:link controller="login" action="edit_reset">Forgot your password?</g:link><br><br>
                    <button class="btn btn-primary btn-block" type="submit" id="submit">Sign in</button>

                    <p>New to Crowdera? <g:link controller="login" action="register">Sign up</g:link> </p>
                </form>
            </div>
        </g:else>
    </div>
</div>
</body>
</html>
