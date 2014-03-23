<html>
<head>
    <meta name="layout" content="main" />
</head>
<body>
<div class="container">
    <div class="row">

        <div class="col-md-6">
            <h1>Please review ...</h1>
            <table class="table table-bordered table-hover table-condensed">
                <tbody>
                <tr>
                    <td>Project</td>
                    <td><g:link controller="project" action="show" id="${project.id}">${project.title}</g:link></td>
                </tr>
                <tr>
                    <td>Beneficiary</td>
                    <td>${project.name}</td>
                </tr>
                <tr>
                    <td>Amount</td>
                    <td>$${reward.price}</td>
                </tr>
                </tbody>
            </table>

            <stripe:script formName="payment-form"/>

            <h1>... and provide payment details</h1>

            <g:form action="charge" method="POST" name="payment-form" role="form">
                <g:hiddenField name="projectId" value="${project.id}"/>
                <g:hiddenField name="rewardId" value="${reward.id}"/>

                <div class="form-group">

                    <fieldset disabled>
                        <div class="input-group">
                            <span class="amount input-group-addon"><span class="glyphicon glyphicon-usd"></span> </span>
                            <input type="text" class="amount form-control" value="${reward.price}" id="amount" name="amount">
                        </div>
                    </fieldset>

                    <div class="input-group">
                        <span class="cardnumber input-group-addon"><span class="glyphicon glyphicon-credit-card"></span> </span>
                        <input type="text" class="cardnumber form-control" placeholder="Card Number" data-stripe="number">
                    </div>

                    <div class="input-group">
                        <span class="cvc input-group-addon"><span class="glyphicon glyphicon-lock"></span> </span>
                        <input type="text" class="cvc form-control" placeholder="CVC" data-stripe="cvc">
                        <span class="mm input-group-addon"><span class="glyphicon glyphicon-calendar"></span> </span>
                        <input type="text" class="mm form-control" placeholder="MM" data-stripe="exp-month">
                        <span class="yyyy input-group-addon"><span class="glyphicon glyphicon-calendar"></span> </span>
                        <input type="text" class="yyyy form-control" placeholder="YYYY" data-stripe="exp-year">
                    </div>
                </div>
                <div class="help-block">Powered by Stripe</div>
                <button type="submit" class="btn btn-primary btn-lg">Fund this project</button>
            </g:form>

        </div>

        <div class="col-md-2"></div>

        <div class="col-md-4">
            <g:render template="rewardtile"/>
            <g:render template="/layouts/singletile"/>
        </div>
    </div>
</div>
</body>
</html>
