<g:set var="projectService" bean="projectService"/>
<html>
<head>
    <meta name="layout" content="main" />
    <r:require modules="checkoutjs"/>

    <script type="text/javascript" src="https://js.stripe.com/v2/"></script>
    <script type="text/javascript">
        Stripe.setPublishableKey('${grailsApplication.config.grails.plugins.stripe.publishableKey}');

        if (window.location.protocol === 'file:') {
            alert("stripe.js does not work when included in pages served over file:// URLs.");
        }
    </script>
    <script id="credit-error-template" type="text/x-handlebars-template">
        <div class="alert alert-danger">
            {{message}}
        </div>
    </script>
</head>
<body>
<div class="feducontent">
    <div class="container">
        <div class="row">
            <div class="col-md-8">
                <div class="panel panel-default">
                    <div class="panel-body">
                        <h3>Your contribution: <span class="pull-right">$${amount}</span></h3>
                        <h4>Your reward: <span class="pull-right">${reward.title}</span></h4>
                    </div>
                </div>

                <g:form action="charge" method="POST" name="payment-form" role="form">
                    <span class="payment-errors"></span>

                    <g:hiddenField name="projectId" value="${project.id}"/>
                    <g:hiddenField name="rewardId" value="${reward.id}"/>
                    <g:hiddenField name="amount" value="${amount}"/>

                    <div class="form-group">
                        <div class="input-group">
                            <span class="input-group-addon"><span class="glyphicon glyphicon-credit-card"></span> </span>
                            <input type="text" class="card-number form-control" placeholder="Card Number" data-stripe="number">
                        </div>
                    </div>

                    <div class="form-group">
                        <div class="input-group">
                            <span class="input-group-addon"><span class="glyphicon glyphicon-lock"></span> </span>
                            <input class="form-control" type="text" placeholder="CVC" data-stripe="cvc">

                            <span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span> </span>
                            <input class="form-control" type="text" placeholder="MM" data-stripe="exp-month">

                            <span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span> </span>
                            <input class="form-control" type="text" placeholder="YYYY" data-stripe="exp-year">
                        </div>
                    </div>

                    <div class="help-block">Powered by Stripe</div>
                    <button type="submit" class="btn btn-primary btn-lg">Fund this project</button>
                </g:form>
            </div>
            <div class="col-md-4">
                <g:render template="rewardtile"/>
                <g:render template="/layouts/tile"/>
            </div>
        </div>
    </div>
</div>
</body>
</html>
