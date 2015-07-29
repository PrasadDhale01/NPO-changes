<!-- Fixed navbar -->
<g:set var="facebookAuthService" bean="facebookAuthService"/>
<g:set var="userService" bean="userService"/>
<%
    def user = userService.getCurrentUser()
	def userImage
	if (user) {
		if (user.userImageUrl) {
			userImage = user.userImageUrl
		} else {
			def imageobj = userService.getCurrentUserImage(user.firstName)
			userImage = imageobj.userImage
		}
	}
%>
<div class="navbar navbar-default navbar-fixed-top header-section" role="navigation">
    <div class="header-container">
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
            <ul class="nav navbar-nav nav-icon-bar">
                <li class="searchengine hidden-xs">
                    <form action="/campaign" onClick="searchList()" name="SearchForm">
                        <div class="inner-addon left-addon search-icon-header search-image-header">
                           <img src="//s3.amazonaws.com/crowdera/assets/search-icon.png" alt="search" class="trigger" id="trigger">
                           <input type="text" class="form-control search-box" name="q" value="${params.q}" id="search-bar" placeholder="Search....."/>
                           <input type="text" name="search" id="hiddensearch"/>  
                        </div>
                    </form>
                </li>
                <li class="hidden-lg hidden-md hidden-sm search-mob">
                    <form action="/campaign" onClick="searchMobList()" name="searchableForm">
                        <span class="form-group inner-addon left-addon">
                            <i class="glyphicon glyphicon-search search-glyph-icon"></i>
                            <input type="search" name="q" class="form-control search-box-xs" value="${params.q}" placeholder="Search.....">
                        </span>
                    </form>
                </li>
                <li class="discover"><a href="${resource(dir: '/campaigns')}" class="nav-text2">Discover</a></li>
                <li class="learn"><a href="${resource(dir: '/howitworks')}" class="nav-text3">Learn</a></li>
            </ul>
            <ul class="nav navbar-nav navbar-right nav-create-button">
                <li class="hidden-xs">
                    <g:link controller="project" action="create" class="nav-text1">
<%--                        <img src="//s3.amazonaws.com/crowdera/assets/create-Button-blue.jpg" alt="create" class="hidden-lg hidden-md hidden-sm" id="createButton">--%>
                        <img src="//s3.amazonaws.com/crowdera/assets/create-Button-blue-tab.jpg" alt="create" class="" id="createButton-sm">
                    </g:link> 
                </li>
                <li class="hidden-lg hidden-md hidden-sm">
                    <g:link controller="project" action="create" class="nav-item-1">Create</g:link>
                </li>
            </ul>
            
            <ul class="nav navbar-nav navbar-right <g:if test="${user}">navbar-right-logged-in</g:if>">
                <sec:ifNotLoggedIn>
                    <li class="hidden-xs hidden-sm headerFbButton">
                        <a href="${grailsApplication.config.grails.plugin.springsecurity.facebook.filter.redirect.redirectFromUrl}">
                            <img src="//s3.amazonaws.com/crowdera/assets/facebook-button-header.jpg" alt="Register with Facebook">
                        </a>
                    </li>
                    <li><g:link controller="login" action="auth" class="nav-item-2">Login</g:link></li>
                    <li><g:link controller="login" action="register" class="nav-item-3">Sign up</g:link></li>
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
                                    <img class="img-circle" src="//s3.amazonaws.com/crowdera/assets/dropdown-setting-icon.png" alt="setting"/>&nbsp; Dashboard
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
                                    <img class="img-circle" src="//s3.amazonaws.com/crowdera/assets/dropdown-Logout-icon.png" alt="Logout"/>&nbsp; Log out
                                </g:link></li>
                            </ul>
                        </g:if>
                        <g:else>
                            <ul class="dropdown-menu usr user-dropdown dropdown-menu-head user-selected-drop">
                                <li><g:link class="myprojects" controller="user" action="myproject">
                                    <img class="img-circle" src="//s3.amazonaws.com/crowdera/assets/dropdown-My-Campaigns-icon.png" alt="My-Campaigns"/>&nbsp;&nbsp;&nbsp;&nbsp; My Campaigns
                                </g:link></li>

                                <li><g:link class="mycontributions" controller="user" action="mycontribution">
                                    <img class="img-circle" src="//s3.amazonaws.com/crowdera/assets/dropdown-My-Contributions-icon.png" alt="My-Contributions"/>&nbsp;&nbsp;&nbsp;&nbsp; My Contributions
                                </g:link></li>
                                <li><g:link controller="user" action="dashboard">
                                    <img class="img-circle" src="//s3.amazonaws.com/crowdera/assets/dropdown-setting-icon.png" alt="setting"/>&nbsp;&nbsp;&nbsp;&nbsp; Settings
                                </g:link></li>
                                <sec:ifAllGranted roles="ROLE_AUTHOR">
                                    <li><g:link controller="blog" action="manage"><span class="glyphicon glyphicon-book"></span> Manage blogs</g:link></li>
                                </sec:ifAllGranted>
                                <sec:ifAllGranted roles="ROLE_COMMUNITY_MGR">
                                    <li><g:link controller="community" action="manage"><i class="fa fa-users"></i> Manage communities</g:link></li>
                                </sec:ifAllGranted>
                                <li class="divider"></li>
                                <li><g:link controller="logout">
                                    <img class="img-circle" src="//s3.amazonaws.com/crowdera/assets/dropdown-Logout-icon.png" alt="Logout"/>&nbsp;&nbsp;&nbsp;&nbsp; Log out
                                </g:link></li>
                            </ul>
                        </g:else>
                    </li>
                </sec:ifLoggedIn>
            </ul>
        </div>
    </div>
</div>
<script src="/js/main.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.min.js"></script>
<script src="/js/autohideheader/jquery.bootstrap-autohidingnavbar.min.js"></script>
<script>
	$(".navbar-fixed-top").autoHidingNavbar();
</script> 
