<html>
<head>
    <meta name="layout" content="main" />
    <r:require modules="rewardjs"/>
</head>
<body>
<div class="feducontent">
    <div class="container">
        <div class="row">
            <h1><i class="glyphicon glyphicon-list"></i>&nbsp;shipping pending items</h1><br>
            <g:if test="${flash.message}">
                <div class="alert alert-success">
                    ${flash.message}&nbsp;<i class=" fa fa-exclamation-circle"></i>
                </div>
            </g:if>
            <div class="col-md-12">
                <g:render template="shipping/shippinggrid" model="['contribution': contribution]"></g:render>
            </div>
        </div>
        <hr>
        <div class="row">
            <div class="col-md-12">
                <h1><i class="glyphicon glyphicon-list"></i>&nbsp;shipping done items</h1>
                <g:render template="shipping/shippinggrid" model="['contribution': contributions]"></g:render>
            </div>
        </div>
    </div>
</div>	
</body>
</html>
