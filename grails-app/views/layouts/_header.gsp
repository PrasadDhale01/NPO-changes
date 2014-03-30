<!-- Fixed navbar -->
<g:set var="facebookAuthService" bean="facebookAuthService"/>
<g:set var="userService" bean="userService"/>

<div class="navbar navbar-default navbar-fixed-top" role="navigation">
	<div class="container">
		<div class="navbar-header">
			<button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
				<span class="sr-only">Toggle navigation</span>
				<span class="icon-bar"></span>
				<span class="icon-bar"></span>
				<span class="icon-bar"></span>
			</button>
			<a class="navbar-brand" href="${resource(dir: '/')}"></a>
		</div>
		<div class="navbar-collapse collapse">
			<ul class="nav navbar-nav">
				<li><g:link controller="project" action="create">Create Project</g:link></li>
                <li><a href="${resource(dir: '/projects')}">Contribute</a></li>
				<li><a href="${resource(dir: '/howitworks')}">How it works</a></li>
			</ul>
			<ul class="nav navbar-nav navbar-right">
                <sec:ifNotLoggedIn>
                    <li><g:link controller="login" action="auth">Login</g:link></li>
                    <li><a href="${resource(dir: '/login/register')}">Register</a></li>
                </sec:ifNotLoggedIn>
                <sec:ifLoggedIn>
                    <li class="dropdown">
                        <a href="#" class="dropdown-toggle" data-toggle="dropdown">
                            <g:if test="${userService.isFacebookUser()}">
                                <i class="fa fa-facebook-square"></i>
                            </g:if>
                            <g:else>
                                <span class="glyphicon glyphicon-user"></span>
                            </g:else>
                            ${userService.getFriendlyName(userService.getCurrentUser())}
                            <b class="caret"></b>
                        </a>
                        <ul class="dropdown-menu">
                            <li><g:link controller="user" action="profile">Profile</g:link></li>
                            <sec:ifAllGranted roles="ROLE_AUTHOR">
                                <li><g:link controller="blog" action="manage">Manage blogs</g:link></li>
                            </sec:ifAllGranted>
                            <li class="divider"></li>
                            <li><g:link controller="logout">Log out</g:link></li>
                        </ul>
                    </li>
                </sec:ifLoggedIn>
			</ul>
		</div>
	</div>
</div>
