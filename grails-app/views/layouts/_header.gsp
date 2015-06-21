<!-- Fixed navbar -->
<g:set var="facebookAuthService" bean="facebookAuthService"/>
<g:set var="userService" bean="userService"/>
<%
    def userImage = userService.getCurrentUserImage()
    def user = userService.getCurrentUser()
%>
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
                <img src="//s3.amazonaws.com/crowdera/assets/crowdera-logo.png" alt="Crowdera"/>
            </a>
        </div>
        <div class="navbar-collapse collapse">
         <ul class="nav navbar-nav">
                <li><g:link controller="project" action="create" class="nav-text1">START</g:link></li>
                <li><a href="${resource(dir: '/campaigns')}" class="nav-text2">DISCOVER</a></li>
                <li><a href="${resource(dir: '/howitworks')}" class="nav-text3">LEARN</a></li>
            </ul>
            <ul class="nav navbar-nav navbar-right searchengine">
                <li class="dropdown searchengine-dropdown visible-md visible-lg visible-sm">
                    <a class="dropdown-toggle search-image glyphicon glyphicon-search" data-hover="dropdown" data-delay="2000" data-close-others="true"></a>
                    <ul class="dropdown-menu menu">
                        <li class="search-engine">
                            <form action="/home/searchOnHomePage" class="searchOnHomePage">
                                <span class="form-group">
                                    <input type="text" id="query"  name="query" class="form-control search-box-on-home-page" value="${params.query}" placeholder="Search">
                                </span>
                            </form>
                        </li>
                    </ul>
                </li>
                <li class="search-engine-mob visible-xs">
                    <form action="/home/searchOnHomePage" class="searchOnHomePageMob">
                        <span class="form-group inner-addon left-addon">
                            <i class="glyphicon glyphicon-search searchIconMob"></i>
                            <input type="search" name="query" class="form-control search-box-xs" value="${params.query}" placeholder="Search">
                        </span>
                    </form>
                </li>
            </ul>
            
            <ul class="nav navbar-nav navbar-right <g:if test="${user}">navbar-right-logged-in</g:if>">
                <sec:ifNotLoggedIn>
                    <li class="hidden-xs hidden-sm headerFbButton">
                        <a href="${grailsApplication.config.grails.plugin.springsecurity.facebook.filter.redirect.redirectFromUrl}">
                            <img src="//s3.amazonaws.com/crowdera/assets/facebook-button-header.jpg" alt="Register with Facebook">
                        </a>
                    </li>
                    <li><g:link controller="login" action="auth">Login</g:link></li>
                    <li><g:link controller="login" action="register">Sign up</g:link></li>
                </sec:ifNotLoggedIn>
                <sec:ifLoggedIn>
                    <li class="dropdown dropdown-head hover-dropdown home-dropdown drop imgs-all user-img">
                        <a href="#" class="dropdown-toggle login" data-hover="dropdown" data-delay="1500" data-close-others="true">
                            <g:if test="${userService.isFacebookUser()}">
                                <span><img class="user-img-header" src="${userImage}"></span>
                            </g:if>
                            <g:elseif test="${userService.isAdmin()}">
                                <span><img class="user-img-header" src="${userImage}"></span>
                            </g:elseif>
                            <g:elseif test="${userService.isAuthor()}">
                                <span><img class="user-img-header" src="${userImage}"></span>
                            </g:elseif>
                            <g:elseif test="${userService.isCommunityManager()}">
                                <span><img class="user-img-header" src="${userImage}"></span>
                            </g:elseif>
                            <g:else>
                                <span><img class="user-img-header" src="${userImage}"></span>
                            </g:else>
                            ${userService.getFriendlyName()}&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                            <span class="user-cl"></span>
                        </a>
                        <g:if test="${userService.isAdmin()}">
                            <ul class="dropdown-menu admin  admin-dropdown dropdown-menu-head admin-selected-drop">
                                <li><g:link controller="user" action="dashboard">
                                    <img class="img-circle" src="//s3.amazonaws.com/crowdera/assets/dropdown-setting.png" alt="setting"/>&nbsp; Dashboard
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
                                    <img class="img-circle" src="//s3.amazonaws.com/crowdera/assets/dropdown-Logout.png" alt="Logout"/>&nbsp; Log out
                                </g:link></li>
                            </ul>
                        </g:if>
                        <g:else>
                            <ul class="dropdown-menu usr user-dropdown dropdown-menu-head user-selected-drop">
                                <li><g:link class="myprojects" controller="user" action="myproject">
                                    <img class="img-circle" src="//s3.amazonaws.com/crowdera/assets/dropdown-My-Campaigns.png" alt="My-Campaigns"/>&nbsp;&nbsp;&nbsp;&nbsp; My Campaigns
                                </g:link></li>

                                <li><g:link class="mycontributions" controller="user" action="mycontribution">
                                    <img class="img-circle" src="//s3.amazonaws.com/crowdera/assets/dropdown-My-Contributions.png" alt="My-Contributions"/>&nbsp;&nbsp;&nbsp;&nbsp; My Contributions
                                </g:link></li>
                                <li><g:link controller="user" action="dashboard">
                                    <img class="img-circle" src="//s3.amazonaws.com/crowdera/assets/dropdown-setting.png" alt="setting"/>&nbsp;&nbsp;&nbsp;&nbsp; Settings
                                </g:link></li>
                                <sec:ifAllGranted roles="ROLE_AUTHOR">
                                    <li><g:link controller="blog" action="manage"><span class="glyphicon glyphicon-book"></span> Manage blogs</g:link></li>
                                </sec:ifAllGranted>
                                <sec:ifAllGranted roles="ROLE_COMMUNITY_MGR">
                                    <li><g:link controller="community" action="manage"><i class="fa fa-users"></i> Manage communities</g:link></li>
                                </sec:ifAllGranted>
                                <li class="divider"></li>
                                <li><g:link controller="logout">
                                    <img class="img-circle" src="//s3.amazonaws.com/crowdera/assets/dropdown-Logout.png" alt="Logout"/>&nbsp;&nbsp;&nbsp;&nbsp; Log out
                                </g:link></li>
                            </ul>
                        </g:else>
                    </li>
                </sec:ifLoggedIn>
            </ul>
        </div>
    </div>
</div>
