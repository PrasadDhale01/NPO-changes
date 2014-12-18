<g:set var="userService" bean="userService"/>
<g:set var="projectService" bean="projectService"/>
<html>
<head>
    <meta name="layout" content="main" />
</head>
<body>
<% def contribution = projectService.getDataType(contribution.amount) %>
<div class="feducontent">
    <div class="container">
        <div class="row">
            <div class="col-md-8">
                <h1>Thank you!</h1>
                <p>You have funded this campaign. You will receive your chosen reward soon.</p>

                <h3>Funding confirmation.</h3>
                <table class="table table-bordered table-hover table-condensed">
                    <tbody>
                    <tr>
                        <td>Campaign</td>
                        <td><g:link controller="project" action="show" id="${project.id}">${project.title}</g:link></td>
                    </tr>
                    <tr>
                        <td>Beneficiary</td>
                        <td>${projectService.getBeneficiaryName(project)}</td>
                    </tr>
                    <g:if test ="${userService.isAnonymous(user)}">
                    <tr>
                        <td>Contributor</td>
                        <td>Anonymous</td>
                    </tr>
                    </g:if>
                    <g:else>
                    <tr>
                        <td>Contributor</td>
                        <td>${user.firstName} ${user.lastName}</td>
                    </tr>
                    </g:else>
                    <tr>
                        <td>Amount</td>
                        <td>$${contribution}</td>
                    </tr>
                    </tbody>
                </table>
                <g:if test ="${userService.isAnonymous(user)}">
                	<div class="alert alert-success">Receipt has been sent over to your email</div>
                </g:if>
                <g:else>
                	<div class="alert alert-success">Receipt has been sent over email to ${user.email}</div>
                </g:else>
            </div>
            <div class="col-md-4">
                <g:if test="${project.rewards.size()>1 }">
                    <g:render template="rewardtile"/>
                </g:if>
                <g:render template="/layouts/tile"/>
            </div>
        </div>
    </div>
</div>
</body>
</html>
