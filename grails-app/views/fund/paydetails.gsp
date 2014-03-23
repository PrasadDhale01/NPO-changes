<html>
<head>
    <meta name="layout" content="main" />
</head>
<body>
<div class="container">
    <div class="row">
        <div class="col-md-8">
            <h1>Payment details</h1>
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
            <button type="button" class="btn btn-primary btn-lg">Fund</button>
        </div>
        <div class="col-md-4">
            <g:render template="rewardtile"/>
            <g:render template="/layouts/singletile"/>
        </div>
    </div>
</div>
</body>
</html>
