<%@ page import="java.text.SimpleDateFormat" %>
<g:set var="projectService" bean="projectService"/>
<g:set var="userService" bean="userService"/>

<head>
	<meta name="layout" content="main" />
	<r:require modules="userjs"/>
</head>
<body>
    <div class="container domain-metrics">
        <div class="text-center">
            <h2><img class="img-circle" src="//s3.amazonaws.com/crowdera/assets/icon-admin.png" alt="metrics"/> Crowdera Metrics </h2>
        </div>
        <ul class="nav nav-tabs nav-justified">
            <li class="active"><a href="#domain" data-toggle="tab">
                <span class="glyphicon glyphicon-leaf hidden-xs"></span><span class="tab-text"> Crowdera </span>
            </a></li>
            <li><a href="#users" data-toggle="tab">
                <span class="fa fa-users hidden-xs"></span><span class="tab-text"> Users </span>
            </a></li>
            <li><a href="#campaigns" data-toggle="tab">
                <span class="glyphicon glyphicon-asterisk hidden-xs"></span><span class="tab-text"> Campaigns</span>
            </a></li>
        </ul>
        
        <!-- Tab panes -->
        <div class="tab-content">
            <div class="tab-pane active" id="domain">
                <g:render template="/user/metrics/domain"/>
            </div>
            <div class="tab-pane" id="users">
                <div id="domainusers">
                <g:render template="/user/metrics/users"/>
                </div>
            </div>
            <div class="tab-pane" id="campaigns">
                <div id="campaignstab">
                    <g:render template="/user/metrics/campaigns"/>
                </div>
            </div>
        </div>
    </div>
</body>
