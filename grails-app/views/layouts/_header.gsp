<!-- Fixed navbar -->
<g:set var="userService" bean="userService"/>
<g:set var="projectService" bean="projectService"/>
<%
def country_code = projectService.getCountryCodeForCurrentEnv(request)
%>
<input type="hidden" id="currentEnvironment" value="${currentEnv}" />
<input type="text" name="search" id="hiddensearch"/>
<div class="hidden-xs navbar navbar-default navbar-fixed-top header-default-height show-header-heights header-section home-header-section noScrollHeader" role="navigation">
    <div class="header-container">
        <g:if test="${currentEnv == 'test' || currentEnv== 'staging' || currentEnv=='production' || currentEnv== 'development'}">
            <%--<div class="info-banner">Doing good from India? Visit <a href="http://crowdera.in" class="banner-link">www.crowdera.in</a><a href="#" class="banner-close" id="banner-close" onclick="bannerClose();">Close</a>
            </div>
        --%></g:if>
        <div class="navbar-header">
            <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#TW-navbar-collapse" id="hamburger-toggle">
                <span class="sr-only">Toggle navigation</span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
            </button>
            <a class="navbar-brand" href="${resource(dir: '/')}">
                <img src="//s3.amazonaws.com/crowdera/assets/crowdera-logo.png" class="nav-lineHeigh" alt="Crowdera">
            </a>
        </div>
        <div class="navbar-collapse collapse" id="TW-navbar-collapse">
            <ul class="nav navbar-nav nav-icon-bar newHeaderbar">
                <li class="discover nav-lineHeight">
				  	<g:link mapping="listCampaigns" params="[country_code: country_code]" class="nav-text2 hm-back-width hed-font-sizes newHeaferfont">
				  	<img class="hidden-sm hidden-lg hidden-md" src="//s3.amazonaws.com/crowdera/assets/icon-discover-new.png" alt="discover">&nbsp;&nbsp;&nbsp;&nbsp;DISCOVER
					</g:link>	
				</li>
                <li class="learn newHowit  nav-lineHeight"><a href="${resource(dir: '/howitworks')}" class="learnNewheader nav-text3 hm-back-width hed-font-sizes newHeaferfont"><img class="hidden-sm hidden-lg hidden-md" src="//s3.amazonaws.com/crowdera/assets/learn-icon-dropdowns.png" alt="learn">&nbsp;&nbsp;&nbsp;&nbsp;HOW IT WORKS</a></li>
                <li class="searchengine searchPadding hidden-xs nav-lineHeight">
                    <form action="/campaign" name="SearchForm">
                        <div class="inner-addon left-addon search-icon-header search-image-header">
                           <img src="//s3.amazonaws.com/crowdera/assets/search-icon.png" alt="search" class="trigger  nav-lineHeight" id="trigger" onclick="toggleSearch();">
                           <input type="search" class="form-control form-control-no-border search-box" name="q" value="${params.q}" id="search-bar" placeholder="Search....."/>
                        </div>
                    </form>
                </li>
                
                <li class="hidden-lg hidden-md hidden-sm search-mob  nav-lineHeight">
                    <form action="/campaign"  name="searchableForm">
                        <span class="form-group inner-addon left-addon">
                            <i class="glyphicon glyphicon-search search-glyph-icon"></i>
                            <input type="search" name="q" class="form-control form-control-no-border search-box-xs" value="${params.q}" placeholder="Search.....">
                        </span>
                    </form>
                </li>
            </ul>
            <ul class="nav navbar-nav navbar-right nav-create-button no-margin-top">
            <li class="hidden-xs noscrollHeaderHelpLink createBtn-height nav-lineHeight hidden-sm">
 	<%--                    <g:link controller="project" action="create" class=" btn btn-info nav-text1 TW-header-helpLinkLogged">--%>
                     <g:link mapping="createCampaign" params="[country_code: country_code]" class="btn btn-info nav-text1 newCreatebtn TW-header-helpLinkLogged">
                         <span class="TW-header-helpTxtLogged btnSpan">CREATE A CAMPAIGN</span>
                    </g:link>
                 </li> 
                  <li class="hidden-xs noscrollHeaderHelpLink createBtn-height nav-lineHeight visible-sm">
<%--                    <g:link controller="project" action="create" class=" btn btn-info nav-text1 TW-header-helpLinkLogged">--%>
                    <g:link mapping="createCampaign" params="[country_code: country_code]" class="btn btn-info nav-text1 newCreatebtn TW-header-helpLinkLogged">
                        <span class="TW-header-helpTxtLogged btnSpan">CREATE</span>
                    </g:link>
                </li> 
                <li class="hidden-lg hidden-md hidden-sm hed-font-sizes  nav-lineHeight">
					<g:link controller="createCampaign" params="[country_code: country_code]" class="nav-item-1">
                    	<img class="hidden-sm hidden-lg hidden-md" src="//s3.amazonaws.com/crowdera/assets/create-icon-dropdown.png" alt="create">&nbsp;&nbsp;&nbsp;&nbsp;CREATE  A CAMPAIGN
                    </g:link>       
                 </li>
            </ul>
            
            <ul class="nav navbar-nav navbar-right <g:if test="${user}">navbar-right-logged-in</g:if>">
                <sec:ifNotLoggedIn>
                    <li  class="nav-lineHeig"><g:link controller="login" action="auth" params="[country_code: country_code]" class="nav-item-2 newHeaferfont  nav-lineHeight"><img class="hidden-sm hidden-lg hidden-md" src="//s3.amazonaws.com/crowdera/assets/login-reg-dropdowns.png" alt="login">&nbsp;&nbsp;&nbsp;&nbsp;LOGIN</g:link></li>
<%--                    <li><g:link controller="login" action="register" class="nav-item-3"><img class="hidden-sm hidden-lg hidden-md newHeaferfont" src="//s3.amazonaws.com/crowdera/assets/sign-in-icon-register-dropsowns.png" alt="signup">&nbsp;&nbsp;&nbsp;&nbsp;SIGN UP</g:link></li>--%>
                </sec:ifNotLoggedIn>
                <sec:ifLoggedIn>
                    <li class="dropdown dropdown-head hover-dropdown home-dropdown drop imgs-all user-img nav-lineHeig">
                        <a href="#" class="dropdown-toggle login" data-toggle="dropdown">
                            <g:if test="${userService.isFacebookUser()}">
                                <span><img class="user-img-header" src="${userImage}" alt="userImage"></span>
                            </g:if>
                            <g:elseif test="${userService.isAdmin()}">
                                <span><img class="user-img-header" src="${userImage}" alt="userImage"></span>
                            </g:elseif>
                            <g:elseif test="${userService.isAuthor()}">
                                <span><img class="user-img-header" src="${userImage}" alt="userImage"></span>
                            </g:elseif>
                            <g:elseif test="${userService.isCommunityManager()}">
                                <span><img class="user-img-header" src="${userImage}" alt="userImage"></span>
                            </g:elseif>
                            <g:else>
                                <span><img class="user-img-header" src="${userImage}" alt="userImage"></span>
                            </g:else>
                            ${userService.getFriendlyName()}&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                            <i class="user-cl-caret glyphicon glyphicon-chevron-down"></i>
                        </a>
                        <g:if test="${userService.isAdmin()}">
                            <ul class="dropdown-menu admin  admin-dropdown dropdown-menu-head admin-selected-drop">
                                <li><g:link controller="user" action="dashboard">
                                    <img class="img-circle" src="//s3.amazonaws.com/crowdera/assets/dropdown-setting-icon.png" alt="setting">&nbsp; Dashboard
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
                                    <img class="img-circle" src="//s3.amazonaws.com/crowdera/assets/dropdown-Logout-icon.png" alt="Logout">&nbsp; Log out
                                </g:link></li>
                            </ul>
                        </g:if>
                        <g:else>
                            <ul class="dropdown-menu usr user-dropdown dropdown-menu-head user-selected-drop">
                                <li><g:link controller="user" action="dashboard">
                                    <img class="img-circle" src="//s3.amazonaws.com/crowdera/assets/dropdown-setting-icon.png" alt="setting">&nbsp;&nbsp;&nbsp;&nbsp; Dashboard
                                </g:link></li>
                                <sec:ifAllGranted roles="ROLE_AUTHOR">
                                    <li><g:link controller="blog" action="manage"><span class="glyphicon glyphicon-book"></span> Manage blogs</g:link></li>
                                </sec:ifAllGranted>
                                <sec:ifAllGranted roles="ROLE_COMMUNITY_MGR">
                                    <li><g:link controller="community" action="manage"><i class="fa fa-users"></i> Manage communities</g:link></li>
                                </sec:ifAllGranted>
                                <li class="divider"></li>
                                <li><g:link controller="logout">
                                    <img class="img-circle" src="//s3.amazonaws.com/crowdera/assets/dropdown-Logout-icon.png" alt="Logout">&nbsp;&nbsp;&nbsp;&nbsp; Log out
                                </g:link></li>
                            </ul>
                        </g:else>
                    </li>
                </sec:ifLoggedIn>
            </ul>
        </div>
    </div>
</div>
