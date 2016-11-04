<g:set var="userService" bean="userService"/>
<div role="navigation" class="navbar  navbar-fixed-top hidden-lg hidden-md header-section home-header-section scrollHeader header-scrolled hm-headeropicity">
    <div id="opacityremove" class="header-container TW-scrollHeaderBackColor navbar-default ">
  
   <div class="info-banner">
    Doing good from India? Visit <a class="banner-link" href="http://crowdera.in">www.crowdera.in</a>
    <a class="banner-close" href="javascript:void(0);" onclick="bannerClose();">Close</a>
   </div>
  
        <div class="navbar-header">
            <button data-target="#TW-navbar-collapsed" data-toggle="collapse" class="navbar-toggle collapsed TW-scrollHeader-hamBurger burger" type="button">
                <span class="sr-only">Toggle navigation</span>
                <span class="icon-bar icon-bar-xs" id="icon-bar-1"></span>
                <span class="icon-bar icon-bar-xs" id="icon-bar-2"></span>
                <span class="icon-bar icon-bar-xs" id="icon-bar-3"></span>
                
            </button>
            <a href="/" class="navbar-brand scrollHeaderLogo hidden-xs">
                <img alt="Crowdera" src="//s3.amazonaws.com/crowdera/assets/crowdera-logo.png" class="hidden-xs">
                <img class="mobile-scrollCrwdLogo hidden-lg hidden-xs hidden-md hidden-sm visible-xs center-block" alt="Crowdera" src="//s3.amazonaws.com/crowdera/assets/Crowdera-logo.png" >
            </a>
            
            <div class="searchengine pull-right visible-xs">
               <form name="SearchForm" action="/campaign">
                   <div class="inner-addon left-addon search-icon-header search-image-header mobile-searchengin-header">
                      <img id="scrolltrigger" class="trigger-mob scrolltrigger" alt="search" src="https://s3.amazonaws.com/crowdera/assets/search-icon.png" onclick="toggleSearch();">
                      <input type="text" placeholder="Search....." id="search-barr1" value="" name="q" class="search-barr form-control form-control-no-border search-box">
                   </div>
               </form>
            </div>
        </div>
        <!-- Hidden in mobile -->
        <div id="TW-navbar-collapsed-hidden-xs" class="navbar-collapse collapse TW-scrollHeaderBackColor">
            <ul class="nav navbar-nav nav-icon-bar">
                <li class="searchengine hidden-xs">
                    <form name="SearchForm" action="/campaign">
                        <div class="inner-addon left-addon search-icon-header search-image-header">
                           <img id="scrolltrigger1" class="trigger scrolltrigger" alt="search" src="https://s3.amazonaws.com/crowdera/assets/header-search-icon.png">
                           <input type="text" placeholder="Search....." id="search-barr2" value="" name="q" class="search-barr form-control form-control-no-border search-box">
                        </div>
                    </form>
                </li>
                
                <li class="hidden-lg hidden-md hidden-sm search-mob">
                    <form name="searchableForm" action="/campaign">
                        <span class="form-group inner-addon left-addon">
                            <i class="glyphicon glyphicon-search search-glyph-icon"></i>
                            <input type="search" placeholder="Search....." value="" class="form-control form-control-no-border search-box-xs search-on-header" name="q">
                        </span>
                    </form>
                </li>
                <li class="discover scrollHeaderMenu"><a class="nav-text2 hm-back-width hed-font-sizes" href="/campaigns"><img alt="discover" src="//s3.amazonaws.com/crowdera/assets/icon-discover-new.png" class="hidden-sm hidden-lg hidden-md">&nbsp;&nbsp;&nbsp;&nbsp;Discover</a></li>
                <li class="learn scrollHeaderMenu"><a class="nav-text3 hm-back-width hed-font-sizes" href="/howitworks"><img alt="learn" src="//s3.amazonaws.com/crowdera/assets/learn-icon-dropdowns.png" class="hidden-sm hidden-lg hidden-md">&nbsp;&nbsp;&nbsp;&nbsp;Learn</a></li>
            </ul>
            <ul class="nav navbar-nav navbar-right nav-create-button">
                <li class="hidden-xs">
                    <a class=" btn btn-info nav-text1 TW-header-helpLink" href="/campaign/create">
                     <span class="TW-header-helpTxt">Create</span>
                    </a> 
                </li>
                <li class="hidden-lg hidden-md hidden-sm hed-font-sizes">
                    <a class="nav-item-1" href="/campaign/create"><img alt="create" src="//s3.amazonaws.com/crowdera/assets/create-icon-dropdown.png" class="hidden-sm hidden-lg hidden-md">&nbsp;&nbsp;&nbsp;&nbsp;Create</a>
                </li>
            </ul>
            
            <ul class="nav navbar-nav navbar-right navbar-right-logged-in">
                <sec:ifNotLoggedIn>
                    <g:if test="${currentEnv != 'prodIndia'}">
                        <li class="hidden-xs hidden-sm headerFbButton scrollHeaderMenu">
                            <a href="${grailsApplication.config.grails.plugin.springsecurity.facebook.filter.redirect.redirectFromUrl}">
                                <img src="//s3.amazonaws.com/crowdera/assets/facebook-button-header.jpg" alt="Register with Facebook">
                            </a>
                        </li>
                    </g:if>
                    <li class="scrollHeaderMenu"><g:link controller="login" action="auth" class="nav-item-2"><img class="hidden-sm hidden-lg hidden-md" src="//s3.amazonaws.com/crowdera/assets/login-reg-dropdowns.png" alt="login">&nbsp;&nbsp;&nbsp;&nbsp;Login</g:link></li>
                    <li class="scrollHeaderMenu"><g:link controller="login" action="register" class="nav-item-3"><img class="hidden-sm hidden-lg hidden-md" src="//s3.amazonaws.com/crowdera/assets/sign-in-icon-register-dropsowns.png" alt="signup">&nbsp;&nbsp;&nbsp;&nbsp;Sign up</g:link></li>
                </sec:ifNotLoggedIn>
                <sec:ifLoggedIn>
                    <li class="dropdown dropdown-head hover-dropdown home-dropdown drop imgs-all user-img scrollHeaderMenu toggleImages">
                        <a href="#" class="dropdown-toggle login" data-toggle="dropdown">
                            <g:if test="${userService.isFacebookUser()}">
                                <span><img class="user-img-scrollheader" src="${userImage}" alt="userImage"></span>
                            </g:if>
                            <g:elseif test="${userService.isAdmin()}">
                                <span><img class="user-img-scrollheader" src="${userImage}" alt="userImage"></span>
                            </g:elseif>
                            <g:elseif test="${userService.isAuthor()}">
                                <span><img class="user-img-scrollheader" src="${userImage}" alt="userImage"></span>
                            </g:elseif>
                            <g:elseif test="${userService.isCommunityManager()}">
                                <span><img class="user-img-scrollheader" src="${userImage}" alt="userImage"></span>
                            </g:elseif>
                            <g:else>
                                <span><img class="user-img-scrollheader" src="${userImage}" alt="userImage"></span>
                            </g:else>
                            ${userService.getFriendlyName()}&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                            <span class="user-cl-scrollHeader"></span>
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
        
        <!-- Visible in mobile -->
        <div id="TW-navbar-collapsed" class="hidden-lg hidden-md hidden-sm collapse TW-scrollHeaderBackColor navbar-collapse">
            <div class="scrollHeaderMenu hidden-lg hidden-md hidden-sm">
            <ul>
                <li><a href="/campaigns">Discover</a></li>
                <li><g:link controller="project" action="create">Start a campaign</g:link></li>
                <li><a href="/howitworks">How it works</a></li>
                <sec:ifNotLoggedIn>
                    <li><g:link controller="login" action="auth">Login</g:link>&nbsp; or&nbsp; <g:link controller="login" action="register">Signup</g:link></li>
                </sec:ifNotLoggedIn>
                <li><a href="/customer-service">Support</a></li>
                <sec:ifNotLoggedIn>
                    <g:if test="${currentEnv != 'prodIndia'}">
                        <li class="hidden-xs hidden-sm headerFbButton scrollHeaderMenu">
                            <a href="${grailsApplication.config.grails.plugin.springsecurity.facebook.filter.redirect.redirectFromUrl}">
                                <img src="//s3.amazonaws.com/crowdera/assets/facebook-button-header.jpg" alt="Register with Facebook">
                            </a>
                        </li>
                    </g:if>
                </sec:ifNotLoggedIn>
                <sec:ifLoggedIn>
                        <g:if test="${userService.isAdmin()}">
                                <li><g:link controller="user" action="dashboard">
                                     Dashboard
                                </g:link></li>
                                <sec:ifAllGranted roles="ROLE_AUTHOR">
                                    <li><g:link controller="blog" action="manage">
                                    <span class="glyphicon glyphicon-book"></span> Manage blogs</g:link></li>
                                </sec:ifAllGranted>
                                <sec:ifAllGranted roles="ROLE_COMMUNITY_MGR">
                                    <li><g:link controller="community" action="manage">
                                    <i class="fa fa-users"></i> Manage communities</g:link></li>
                                </sec:ifAllGranted>
                                <li><g:link controller="logout">
                                    Log out
                                </g:link></li>
                        </g:if>
                        <g:else>
                                <li><g:link controller="user" action="dashboard">
                                     Dashboard
                                </g:link></li>
                                <sec:ifAllGranted roles="ROLE_AUTHOR">
                                    <li><g:link controller="blog" action="manage"><span class="glyphicon glyphicon-book"></span> Manage blogs</g:link></li>
                                </sec:ifAllGranted>
                                <sec:ifAllGranted roles="ROLE_COMMUNITY_MGR">
                                    <li><g:link controller="community" action="manage"><i class="fa fa-users"></i> Manage communities</g:link></li>
                                </sec:ifAllGranted>
                                <li><g:link controller="logout">
                                    Log out
                                </g:link></li>
                        </g:else>
                </sec:ifLoggedIn> 
          </ul>
         </div>
        </div>
    </div>
</div>
