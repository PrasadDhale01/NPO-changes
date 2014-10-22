<html>
<head>
    <meta name="layout" content="main" />
    <r:require modules="fundjs"/>
</head>
<body>
<div class="feducontent">
    <div class="container">
        <div class="row">

            <div class="col-md-4">

                <h1>Amount</h1>

                <g:form action="checkout" method="POST" role="form">

                    <g:hiddenField name="projectId" value="${project.id}"/>
                    <g:hiddenField name="rewardId"/> <!-- Value set by Javascript -->

                    <div class="form-group">
                        <div class="input-group">
                            <span class="amount input-group-addon"><span class="glyphicon glyphicon-usd"></span> </span>
                            <input class="amount form-control" <%-- value="${reward.price}" --%> id="amount" name="amount">
                        </div>
                        <span id="errormsg"></span>
                    </div>

                    <button type="submit" class="btn btn-primary btn-lg">Continue</button>
                </g:form>

            </div>

            <div class="col-md-4">
                <g:render template="fund/rewards"/>
            </div>

            <div class="col-md-4">
                <g:render template="/layouts/tile"/>
            </div>
        </div>
    </div>
</div>
</body>
</html>
