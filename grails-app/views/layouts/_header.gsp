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
			<a class="navbar-brand" href="${resource(dir: '/')}">
			    <img src="/images/logo-small.png" alt="Crowdera"/>
			</a>
		</div>
		<div class="navbar-collapse collapse">
			<ul class="nav navbar-nav">
<%--			    <li><a href="/">Home</a></li>--%>
				<li><g:link controller="project" action="create" class="centerText"><b>CREATE</b><span>A CAMPAIGN</span></g:link></li>
                <li><a href="${resource(dir: '/campaigns')}" class="centerText"><b>EXPLORE</b> <span>CAMPAIGNS</span></a></li>
				<li><a href="${resource(dir: '/howitworks')}" class="centerText"><b>SEE HOW</b> <span>IT WORKS</span></a></li>
			</ul>
			<ul class="nav navbar-nav navbar-right">
			    <!-- Dont use form action here as its header file, it messes with other forms in the body part-->
			    <!--<div class="searchbox"><form name="" action="" method="post">
		          <input type="text" name="serach" />
		          <input type="image" src="images/serach-icon.jpg" />
		        </form></div>-->
                <sec:ifNotLoggedIn>
                    <li><g:link controller="login" action="auth">Login</g:link></li>
                    <li><g:link controller="login" action="register">Register</g:link></li>
                </sec:ifNotLoggedIn>
                <sec:ifLoggedIn>
                    <li class="dropdown dropdown-head hover-dropdown home-dropdown drop imgs-all user-img">
                        <a href="#" class="dropdown-toggle login" data-toggle="dropdown">
                            <g:if test="${userService.isFacebookUser()}">
                                <i class="fa fa-facebook-square"></i>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                            </g:if>
                            <g:elseif test="${userService.isAdmin()}">
                                <i class="fa fa-unlock"></i>
                            </g:elseif>
                            <g:elseif test="${userService.isAuthor()}">
                                <span class="glyphicon glyphicon-book"></span>
                            </g:elseif>
                            <g:elseif test="${userService.isCommunityManager()}">
                                <i class="fa fa-users"></i>
                            </g:elseif>
                            <g:else>
                                <span>&nbsp;&nbsp;&nbsp;&nbsp;</span> <%--note: Span is using in dropdown --%>
                            </g:else>
                            	${userService.getFriendlyName()}&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                            	<span class="user-cl"></span>
                        </a>
                            <g:if test="${userService.isAdmin()}">
                                <ul class="dropdown-menu admin  admin-dropdown dropdown-menu-head admin-selected-drop">
                                <li><g:link controller="user" action="dashboard">
                                       <img class="img-circle" src="/images/dropdown-setting.png" alt="setting"/>&nbsp; Settings
                                </g:link></li>
                                <sec:ifAllGranted roles="ROLE_AUTHOR">
                                    <li><g:link controller="blog" action="manage">
                                            <span class="glyphicon glyphicon-book"></span> Manage blogs</g:link></li>
                                </sec:ifAllGranted>
                                <sec:ifAllGranted roles="ROLE_COMMUNITY_MGR">
                                    <li><g:link controller="community" action="manage">
                                            <i class="fa fa-users"></i> Manage communities</g:link></li>
                                </sec:ifAllGranted>
                                <li class="divider"></li>
                                <li><g:link controller="logout">
                                        <img class="img-circle" src="/images/dropdown-Logout.png" alt="Logout"/>&nbsp; Log out
                            </g:link></li>
                            </ul>
                            </g:if>
                            <g:else>
                            <ul class="dropdown-menu usr user-dropdown dropdown-menu-head user-selected-drop">
                            <li><g:link class="myprojects" controller="user"
                                    action="myproject">
                                   <img class="img-circle" src="/images/dropdown-My-Campaigns.png" alt="My-Campaigns"/>&nbsp;&nbsp;&nbsp;&nbsp; My Campaigns
                            </g:link></li>

                            <li><g:link class="mycontributions" controller="user"
                                    action="mycontribution">
                                   <img class="img-circle" src="/images/dropdown-My-Contributions.png" alt="My-Contributions"/>&nbsp;&nbsp;&nbsp;&nbsp; My Contributions
                            </g:link></li>
                            <li><g:link controller="user" action="dashboard">
                               <img class="img-circle" src="/images/dropdown-setting.png" alt="setting"/>&nbsp;&nbsp;&nbsp;&nbsp; Settings
                            </g:link></li>
                            <sec:ifAllGranted roles="ROLE_AUTHOR">
                                <li><g:link controller="blog" action="manage"><span class="glyphicon glyphicon-book"></span> Manage blogs</g:link></li>
                            </sec:ifAllGranted>
                            <sec:ifAllGranted roles="ROLE_COMMUNITY_MGR">
                                <li><g:link controller="community" action="manage"><i class="fa fa-users"></i> Manage communities</g:link></li>
                            </sec:ifAllGranted>
                            <li class="divider"></li>
                            <li><g:link controller="logout">
                                <img class="img-circle" src="/images/dropdown-Logout.png" alt="Logout"/>&nbsp;&nbsp;&nbsp;&nbsp; Log out
                            </g:link></li>
                            </ul>
                            </g:else>
                        </ul>
                    </li>
                </sec:ifLoggedIn>
			</ul>
		</div>
	</div>
</div>