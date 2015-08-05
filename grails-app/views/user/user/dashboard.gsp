<g:set var="userService" bean="userService"/>
<%
    def userCommunities = userService.getCommunitiesUserIn()
%>
<html>
<head>
    <meta name="layout" content="main" />
    <r:require module="timelinecss"/>
    <r:require modules="userjs"/>
</head>
<body>
<div class="feducontent">
    <div class="container">
        <g:hiddenField name='currentEnv' value='${environment}' id='currentEnv'/>
        <h2>User Profile</h2>
        <g:if test="${flash.user_message}">
            <div class="alert alert-success" align="center">
                ${flash.user_message}
            </div>
        </g:if>
        <div class="row">
            <div class="col-md-12">
                <ul class="nav nav-tabs nav-justified user-dashboard-style">
                    <li <g:if test="${activeTab == 'myprojects'}">class="active"</g:if>><a href="#myprojects" data-toggle="tab">
                        <span class="glyphicon glyphicon-leaf"></span><span class="hidden-xs"> My Campaigns
                    </span></a></li>
                    <li><a href="#my-contributions" data-toggle="tab">
                        <span class="glyphicon glyphicon-tint"></span><span class="hidden-xs"> My Contributions
                    </span></a></li>
                    <li <g:if test="${activeTab == 'account-settings'}">class="active"</g:if>><a href="#account-settings" data-toggle="tab">
                        <span class="fa fa-info-circle"></span><span class="hidden-xs"> My Profile
                    </span></a></li>
                    <g:if test="${userService.isCommunityManager()}">
                        <li><a href="#manage-community" data-toggle="tab">
                            <i class="fa fa-users"></i></span> Manage Community
                        </a></li>
                    </g:if>
                    <g:if test="${userCommunities}">
                        <li><a href="#my-community" data-toggle="tab">
                            <i class="fa fa-users"></i></span> My Community
                        </a></li>
                    </g:if>
                </ul>

                <!-- Tab panes -->
                <div class="tab-content">
                    <div class="tab-pane <g:if test="${activeTab == 'myprojects'}">active</g:if>" id="myprojects">
                        <g:render template="user/myprojects"/>
                    </div>

                    <div class="tab-pane <g:if test="${activeTab == 'account-settings'}">active</g:if>" id="account-settings">
                        <g:render template="common/accountsettings"/>
                    </div>

                    <div class="tab-pane" id="my-contributions">
                        <g:render template="user/mycontributions"/>
                    </div>

                    <g:if test="${userService.isCommunityManager()}">
                        <div class="tab-pane" id="manage-community">
                            You are a community manager. Please go to <g:link controller="community" action="manage">Manage Communities</g:link>
                        </div>
                    </g:if>
                    <g:if test="${userCommunities}">
                        <div class="tab-pane" id="my-community">
                            <g:each in="${userCommunities}" var="community">
                                <div class="panel panel-default">
                                    <div class="panel-heading">${community.title}</div>
                                    <div class="panel-body">
                                        <dl class="dl-horizontal">
                                            <dt>Description:</dt>
                                            <dd>${community.description}</dd>
                                            <dt>Manager:</dt>
                                            <dd>${userService.getFriendlyFullName(community.manager)}</dd>
                                            <dt>Community since:</dt>
                                            <dd>
                                                <g:formatDate date="${community.dateCreated}" type="date" style="MEDIUM"/>
                                            </dd>
                                        </dl>
                                    </div>
                                </div>
                            </g:each>
                        </div>
                    </g:if>

                </div>
            </div>
        </div>
    </div>
</div>
</body>
</html>
