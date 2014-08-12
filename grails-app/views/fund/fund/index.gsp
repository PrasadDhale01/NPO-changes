<html>
<head>
    <meta name="layout" content="main" />
    <r:require modules="fundjs"/>
</head>
<body>
<g:form action="checkout" method="POST" role="form">
<div class="feducontent">
    <div class="container">
        <div class="row">

            <div class="col-md-4">

                <h1>Amount</h1>

                    <g:hiddenField name="projectId" value="${project.id}"/>
                    <g:hiddenField name="rewardId"/> <!-- Value set by Javascript -->

                    <div class="form-group">
                        <div class="input-group">
                            <span class="amount input-group-addon"><span class="glyphicon glyphicon-usd"></span> </span>
                            <input class="amount form-control" <%-- value="${reward.price}" --%> id="amount" name="amount">
                        </div>
                    </div>
            </div>

            <div class="col-md-4">
                <g:render template="fund/rewards"/>
            </div>

            <div class="col-md-4">
                <g:render template="/layouts/tile"/>
		<button type="submit" class="btn btn-primary btn-lg">Continue</button>
            </div>
        </div>
    </div>
</div>
</g:form>
</body>
</html>
