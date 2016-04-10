<html>
<head>
    <meta name="layout" content="main" />
</head>
<body>
<g:if test="${flash.user_admin_message}">
    <div class="alert alert-info">
        ${flash.user_admin_message}
    </div>
</g:if>
<div class="feducontent">
    <div class="container admindashboard">

        <h2><img class="img-circle" src="//s3.amazonaws.com/crowdera/assets/icon-admin.png" alt="Admin Dashboard"/>Admin Dashboard</h2>

        <h4>Vital Stats</h4>
        <g:render template="/user/admin/vitals"/>

        <hr>

        <%--
        <div class="btn-group btn-toggle"> 
            <g:link class="btn btn-primary" action="invite" controller="login">Invite only mode</g:link>
            <g:link class="btn btn-default active" action="openRegister" controller="login">Open Registration</g:link>
        </div>
        <hr>
        --%>
        

        <h4>Control Panel</h4>
        <%--
        <div class="row">
            <div class="col-sm-4">
                <div class="panel panel-default">
                    <div class="panel-body">
                        <i class="fa fa-users"></i> Manage all the communities here.
                    </div>
                    <div class="panel-footer">
                        <g:link controller="community" action="manageall">
                            <button class="btn btn-block btn-primary"><i class="fa fa-users"></i> Manage Communities</button>
                        </g:link>
                    </div>
                </div>
            </div>
            <div class="col-sm-4">
                <div class="panel panel-default">
                    <div class="panel-body">
                        <i class="fa fa-gift fa-lg"></i> Manage all the rewards here.
                    </div>
                    <div class="panel-footer">
                        <g:link controller="reward" action="list">
                            <button class="btn btn-block btn-primary"><i class="fa fa-gift fa-lg"></i> Manage Rewards</button>
                        </g:link>
                    </div>
                </div>
            </div>
            <div class="col-sm-4">
                <div class="panel panel-default">
                    <div class="panel-body">
                        <i class="fa fa-gift fa-lg"></i> Manage all shipping pending items here.
                    </div>
                    <div class="panel-footer">
                        <g:link controller="reward" action="shipping">
                            <button class="btn btn-block btn-primary"><i class="fa fa-gift fa-lg"></i> Manage shipping pending items</button>
                        </g:link>
                    </div>
                </div>
            </div>
        </div>
        --%>

	    <div class="row">
            <div class="col-lg-4 col-md-4 col-sm-6 col-xs-12">
                <div class="panel panel-default">
                    <div class="panel-body text-center">
                        <i class="glyphicon glyphicon-check"></i> Manage Campaigns
                    </div>
                    <div class="panel-footer">
                        <g:link controller="project" action="getCampaignList" class="TW-text-decoration">
                            <button class="btn btn-block btn-primary"><i class="glyphicon glyphicon-check"></i> Manage Campaigns</button>
                        </g:link>
                    </div>
                </div>
            </div>
            <div class="col-lg-4 col-md-4 col-sm-6 col-xs-12">
                <div class="panel panel-default">
                    <div class="panel-body mng-text-size text-center">
                        <i class="glyphicon glyphicon-user"></i> Manage all the invite requests here.
                    </div>
                    <div class="panel-footer">
                        <g:link controller="login" action="list" class="TW-text-decoration">
                            <button class="btn btn-block btn-primary"><span class="fa fa-user fa-lg"></span> Manage Invites</button>
                        </g:link>
                    </div>
                </div>
            </div>
            <div class="col-lg-4 col-md-4 col-sm-6 col-xs-12">
                <div class="panel panel-default">
                    <div class="panel-body text-center">
                        <i class="fa fa-leaf fa-lg"></i> Bulk import Campaigns here.
                    </div>
                    <div class="panel-footer">
                        <g:link controller="project" action="importprojects" class="TW-text-decoration">
                            <button class="btn btn-block btn-primary btn-text-alignment"><i class="fa fa-gift fa-lg"></i> Bulk Import Campaigns</button>
                        </g:link>
                    </div>
                </div>
            </div>
        	<div class="col-lg-4 col-md-4 col-sm-6 col-xs-12">
                <div class="panel panel-default">
                    <div class="panel-body text-center">
                        <i class="fa fa-users"></i> Manage User
                    </div>
                    <div class="panel-footer">
                        <g:link controller="user" action="list" class="TW-text-decoration">
                            <button class="btn btn-block btn-primary"><i class="fa fa-users"></i> Manage User</button>
                        </g:link>
                    </div>
                </div>
            </div>
            <div class="col-lg-4 col-md-4 col-sm-6 col-xs-12">
                <div class="panel panel-default">
                    <div class="panel-body text-center">
                        <i class="fa fa-credit-card"></i> Manage Transactions
                    </div>
                    <div class="panel-footer">
                        <g:form controller="fund" action="transaction">
                            <g:hiddenField name="currency" value="${currency}"/>
                            <button class="btn btn-block btn-primary btn-text-alignment"><i class="fa fa-credit-card"></i> Manage Transactions</button>
                        </g:form>
                    </div>
                </div>
            </div>
            <div class="col-lg-4 col-md-4 col-sm-6 col-xs-12">
                <div class="panel panel-default">
                    <div class="panel-body text-center">
                        <i class="fa fa-user"></i> Manage User Questions
                    </div>
                    <div class="panel-footer">
                        <g:link controller="home" action="customerSupport" class="TW-text-decoration">
                            <button class="btn btn-block btn-primary btn-text-alignment"><i class="fa fa-user"></i> Manage User Questions</button>
                        </g:link>
                    </div>
                </div>
            </div>
            <div class="col-lg-4 col-md-4 col-sm-6 col-xs-12">
                <div class="panel panel-default">
                    <div class="panel-body text-center">
                        <i class="fa fa-user"></i> Manage Applicant
                    </div>
                    <div class="panel-footer">
                        <g:link controller="user" action="crewsList" class="TW-text-decoration">
                            <button class="btn btn-block btn-primary"><i class="fa fa-user"></i> Manage Applicant</button>
                        </g:link>
                    </div>
                </div>
            </div>
            <g:if test="${environment == 'testIndia' || environment == 'stagingIndia' || environment == 'prodIndia'}">
                <div class="col-lg-4 col-md-4 col-sm-6 col-xs-12">
                    <div class="panel panel-default">
                        <div class="panel-body text-center">
                            <i class="glyphicon glyphicon-tint"></i> Payment Details for Campaign.
                        </div>
                        <div class="panel-footer">
                            <g:link controller="project" action="paymentslist" class="TW-text-decoration">
                                <button class="btn btn-block btn-primary"><i class="glyphicon glyphicon-tint"></i> Payment Details</button>
                            </g:link>
                        </div>
                    </div>
                </div>
            </g:if>
            <div class="col-lg-4 col-md-4 col-sm-6 col-xs-12">
                <div class="panel panel-default">
                    <div class="panel-body text-center">
                        <i class="glyphicon glyphicon-tint"></i> Crowdera Metrics.
                    </div>
                    <div class="panel-footer">
                        <g:link controller="user" action="metrics" class="TW-text-decoration">
                            <button class="btn btn-block btn-primary"><i class="glyphicon glyphicon-tint"></i> Crowdera Metrics </button>
                        </g:link>
                    </div>
                </div>
            </div>
            <div class="col-lg-4 col-md-4 col-sm-6 col-xs-12">
                <div class="panel panel-default">
                    <div class="panel-body text-center">
                        <i class="glyphicon glyphicon-tint"></i> Manage Partners.
                    </div>
                    <div class="panel-footer">
                        <g:link controller="user" action="managePartner" class="TW-text-decoration">
                            <button class="btn btn-block btn-primary"><i class="glyphicon glyphicon-tint"></i> Manage Partners </button>
                        </g:link>
                    </div>
                </div>
            </div>
            <div class="col-lg-4 col-md-4 col-sm-6 col-xs-12">
                 <div class="panel panel-default">
                     <div class="panel-body text-center">
                         <i class="glyphicon glyphicon glyphicon-list-alt"></i> Feedbacks
                     </div>
                     <div class="panel-footer">
                         <g:link controller="user" action="feedback" class="TW-text-decoration">
                             <button class="btn btn-block btn-primary"><i class="glyphicon glyphicon glyphicon-list-alt"></i> Feedbacks </button>
                         </g:link>
                     </div>
                 </div>
            </div> 
            <div class="col-lg-4 col-md-4 col-sm-6 col-xs-12">
                 <div class="panel panel-default">
                     <div class="panel-body text-center">
                         <i class="glyphicon glyphicon glyphicon-list-alt"></i> Utilities
                     </div>
                     <div class="panel-footer">
                         <g:link controller="user" action="manageHomePageCampaigns" class="TW-text-decoration">
                             <button class="btn btn-block btn-primary"><i class="glyphicon glyphicon glyphicon-list-alt"></i> Utilities </button>
                         </g:link>
                     </div>
                 </div>
            </div>
        </div>

    </div>
</div>
</body>
</html>
