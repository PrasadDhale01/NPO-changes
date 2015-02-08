<html>
<head>
    <meta name="layout" content="main" />
</head>
<body>
<div class="feducontent">
    <div class="container">
        <div class="row">
        <h1> Pending User Questions</h1><br>
            <g:if test="${flash.servicemessage}">
                <div class="alert alert-success">
                    ${flash.servicemessage}
                </div>
            </g:if>
            <div class="table table-responsive">
            	<table class="table table-bordered">
            	    <thead>
                	<tr class="alert alert-title ">
                        <th>Id</th>
                        <th>User Name</th>
                        <th>Email Id</th>
                        <th>Subject</th>
                    	<th>Customer type</th>
                    	<th>Description</th>
                    	<th>Response</th>
                	</tr>
            	    </thead>
            	    <tbody>
                 	    <g:render template="/user/userquestions/userquestionsgrid" model="['service': services]"></g:render>
            	    </tbody>
            	</table>
            </div>
        </div>
    </div>    
</div>
</body>
</html>
