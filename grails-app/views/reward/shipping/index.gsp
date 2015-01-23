<html>
<head>
    <meta name="layout" content="main" />
    <r:require modules="rewardjs"/>
</head>
<body>
<div class="feducontent">
    <div class="container">
        <div class="row">
            <h1><i class="glyphicon glyphicon-list"></i>&nbsp;Shipping pending items</h1><br>
            <g:if test="${flash.reward_message}">
                <div class="alert alert-success">
                    ${flash.reward_message}&nbsp;<i class=" fa fa-exclamation-circle"></i>
                </div>
            </g:if>
            <table class="table table-bordered">
                <thead>
                    <tr class="danger">
                        <th>Contributor_Id</th>
                        <th>Contributor_Name</th>
                        <th>Email_Id</th>
                        <th>Address</th>
                        <th>Reward_Description</th>
                        <th>Shipping_Status</th>
                    </tr>
                </thead>
                <tbody>
                    <g:render template="shipping/shippinggrid" model="['contribution': shippingPendingItems]"></g:render>
                </tbody>
            </table>
        </div>
        <hr>
        <div class="row">
            <h1><i class="glyphicon glyphicon-list"></i>&nbsp;Shipping done items</h1><br>
            <table class="table table-bordered">
                <thead>
                    <tr class="success">
                        <th>Contributor_Id</th>
                        <th>Contributor_Name</th>
                        <th>Email_Id</th>
                        <th>Address</th>
                        <th>Reward_Description</th>
                        <th>Shipping_Status</th>
                    </tr>
                </thead>
                <tbody>
                    <g:render template="shipping/shippinggrid" model="['contribution': shippingDoneItems]"></g:render>
                </tbody>
            <table>
        </div>
    </div>
</div>	
</body>
</html>
