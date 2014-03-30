<html>
<head>
    <meta name="layout" content="main" />
    <r:require modules="fundjs"/>

    <script type="text/javascript" src="https://js.stripe.com/v2/"></script>
    <script type="text/javascript">
        Stripe.setPublishableKey('${grailsApplication.config.grails.plugins.stripe.publishableKey}');

        if (window.location.protocol === 'file:') {
            alert("stripe.js does not work when included in pages served over file:// URLs.");
        }
    </script>
</head>
<body>
<div class="container">
    <div class="row">

        <div class="col-md-4">

            <%--
            <stripe:script formName="payment-form"/>
            --%>

            <h1>Payment details</h1>

            <g:form action="charge" method="POST" name="payment-form" role="form">
                <span class="payment-errors"></span>

                <g:hiddenField name="projectId" value="${project.id}"/>
                <%-- <g:hiddenField name="rewardId" value="${reward.id}"/> --%>

                <div class="input-group">
                    <span class="amount input-group-addon"><span class="glyphicon glyphicon-usd"></span> </span>
                    <input type="text" class="amount form-control" <%-- value="${reward.price}" --%> id="amount" name="amount">
                </div>

                <div class="input-group">
                    <span class="input-group-addon"><span class="glyphicon glyphicon-credit-card"></span> </span>
                    <input type="text" class="card-number form-control" placeholder="Card Number" data-stripe="number">
                </div>

                <div class="input-group">
                    <span class="input-group-addon"><span class="glyphicon glyphicon-lock"></span> </span>
                    <input class="card-cvc form-control" type="text"placeholder="CVC" data-stripe="cvc">

                    <span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span> </span>
                    <input class="card-expiry-month form-control" type="text" placeholder="MM" data-stripe="exp-month">

                    <span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span> </span>
                    <input class="card-expiry-year form-control" type="text" placeholder="YYYY" data-stripe="exp-year">
                </div>

                <div class="help-block">Powered by Stripe</div>
                <button type="submit" class="btn btn-primary btn-lg">Fund this project</button>
            </g:form>

        </div>

        <div class="col-md-4">
            <g:render template="rewards"/>
        </div>

        <div class="col-md-4" style="margin-top: 30px;">
            <g:render template="/layouts/tile"/>
        </div>
    </div>
</div>
</body>
</html>
