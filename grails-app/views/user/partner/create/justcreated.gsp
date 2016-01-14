<html>
<head>
<meta name="layout" content="main" />
</head>
<body>
<div class="feducontent">
    <div class="container">
        <g:if test="${saved}">
            <g:if test="${partner}">
                <div class="wrap">
                    <div class="alert alert-success">Awesome. You have successfully created a Partner page.</div>
                </div>
                <div class="panel panel-default">
                    <div class="panel-heading">
                        <h3 class="panel-title">Next steps</h3>
                    </div>
                    <div class="panel-body">
                        Your request for Partner page has been submitted for review and will be published within 24 hours.
                    </div>
                </div>
            </g:if>
            <g:else>
                <h2>Error</h2>
                <div class="alert alert-danger">Oh snap! Looks like that Partner doesn't exist.</div>
            </g:else>
        </g:if>
        
        <g:if test="${alreadyExist}">
            <g:if test="${partner}">
                <g:if test="${partner.draft || partner.rejected}">
                    <div class="alert alert-info">You have already submitted request for partner application page. It is under verification process. For any queries contact us.</div>
                </g:if>
                <g:elseif test="${partner.validated}">
                    <div class="alert alert-info">You already have a partner page.</div>
                </g:elseif>
            </g:if>
        </g:if>
        
    </div>
</div>
</body>
</html>
