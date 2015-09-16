<%@ page import="java.text.SimpleDateFormat" %>
<g:set var="contributionService" bean="contributionService"/>
<g:set var="projectService" bean="projectService"/>
<g:set var="userService" bean="userService"/>

<head>
	<meta name="layout" content="main" />
</head>
<body>
    <div class="container domain-metrics">
        <div class="text-center">
            <h2><img class="img-circle" src="//s3.amazonaws.com/crowdera/assets/icon-admin.png" alt="metrics"/> Crowdera Metrics </h2>
        </div>
        <ul class="nav nav-tabs nav-justified">
            <li class="active"><a href="#domain" data-toggle="tab">
                <span class="glyphicon glyphicon-leaf"></span><span class="tab-text"> Crowdera </span>
            </a></li>
            <li><a href="#users" data-toggle="tab">
                <span class="fa fa-users"></span><span class="tab-text"> Users </span>
            </a></li>
            <li><a href="#campaigns" data-toggle="tab">
                <span class="glyphicon glyphicon-asterisk"></span><span class="tab-text"> Campaigns</span>
            </a></li>
        </ul>
        
        <!-- Tab panes -->
        <div class="tab-content">
            <div class="tab-pane active" id="domain">
                <g:render template="/user/metrics/domain"/>
            </div>
            <div class="tab-pane" id="users">
                <g:render template="/user/metrics/users"/>
            </div>
            <div class="tab-pane" id="campaigns">
                <g:render template="/user/metrics/campaigns"/>
            </div>
        </div>
    </div>
</body>
