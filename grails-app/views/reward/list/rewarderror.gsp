<html>
<head>
<meta name="layout" content="main" />
</head>
<body>
<div class="feducontent">
    <div class="container">
        <h2>Error</h2>
        <div class="alert alert-danger">
            Oh snap! Something went wrong creating the reward.
            <g:if test="${flash.reward_message}">
                <ul>
                    <li>${flash.reward_message}</li>
                </ul>
            </g:if>
        </div>

        <g:if env="development">
            <g:renderErrors bean="${reward}"/>
        </g:if>
    </div>
</div>
</body>
</html>
