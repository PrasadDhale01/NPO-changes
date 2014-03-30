<g:set var="userService" bean="userService"/>
<html>
<head>
    <meta name="layout" content="main" />
</head>
<body>
<div class="feducontent">
    <div class="container">
        <div class="row">
            <div class="col-md-8">
                <h1>Thank you!</h1>
                <p>You have funded this project. You will receive your chosen reward soon.</p>

                <h3>Funding confirmation.</h3>
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
                        <td>$${contribution.amount}</td>
                    </tr>
                    </tbody>
                </table>
                <div class="alert alert-success">Receipt has been sent over email to ${userService.getCurrentUser().email}</div>
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
