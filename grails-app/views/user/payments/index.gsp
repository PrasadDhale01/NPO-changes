<html>
<head>
    <meta name="layout" content="main" />
</head>
<body>
    <div class="feducontent">
        <div class="container">
            <div class="row">
                <h1> Payment Details for Campaigns</h1><br>
                <div class="table table-responsive">
                    <table class="table table-bordered">
                        <thead>
                            <tr class="alert alert-title ">
                                <th>ID</th>
                                <th>CAMPAIGN TITLE</th>
                                <th>BENEFICIARY NAME</th>
                                <th>BANK BRANCH</th>
                                <th>IFSC CODE</th>
                                <th>ACCOUNT TYPE</th>
                                <th>ACCOUNT NUMBER</th>
                            </tr>
                        </thead>
                        <tbody>
                            <g:render template="/user/payments/paymentgrid"></g:render>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
</body>
</html>
