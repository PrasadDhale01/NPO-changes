<html>
<head>
    <meta name="layout" content="main" />
    <r:require modules="projectcreatejs"/>
</head>
<body>
<div class="feducontent">
    <div class="container">
        <div class="row">
         <h1 class="text-center">User List</h1><br>
            <g:if test="${flash.message}">
                <div class="alert alert-success text-center">
                    ${flash.message}
                </div>
            </g:if>
            <h4>Verified Users</h4>
            <div class="table table-responsive">
            	<table class="table table-bordered">
            	    <thead>
                	<tr class="alert alert-title ">
                    	    <th>Id</th>
                    	    <th class="col-sm-2 text-center">Email</th>
                    	    <th class="col-sm-2 text-center">First Name</th>
                    	    <th class="col-sm-2 text-center">Last Name</th>
                    	    <th class="col-sm-2 text-center">Role</th>
                    	    <th class="col-sm-2 text-center">Date Created</th>
                    	    <th class="col-sm-2 text-center">Last Updated</th>            
                	</tr>
            	    </thead>
            	    <tbody>
                 	<g:render template="admin/userListGrid" model="['users': verifiedUsers]"></g:render>
            	    </tbody>
            	</table>
            </div><br>
            <h4>Non-Verified Users</h4>
            <div class="row">
                <div class="col-sm-3">
                    <h5>Send an email to non-verified users</h5>
                </div>
                <div  class="col-sm-2">
                    <g:link action="resendToUsers" controller="User">
                        <button class="sendMail" ><span class="glyphicon glyphicon-envelope"></span> Send Mail</button>
                    </g:link>
                </div>
            </div>
            <div class="table table-responsive">
            	<table class="table table-bordered">
            	    <thead>
                	<tr class="alert alert-title ">
                    	    <th>Id</th>
                    	    <th class="col-sm-2 text-center">Email</th>
                    	    <th class="col-sm-2 text-center">First Name</th>
                    	    <th class="col-sm-2 text-center">Last Name</th>
                    	    <th class="col-sm-2 text-center">Role</th>
                    	    <th class="col-sm-2 text-center">Date Created</th>
                    	    <th class="col-sm-2 text-center">Re-send Confirm Email</th>            
                	</tr>
            	    </thead>
            	    <tbody>
                 	<g:render template="admin/userListGrid" model="['users': nonVerifiedUsers]"></g:render>
            	    </tbody>
            	</table>
            </div>
        </div>
    </div>    
</div>
</body>
</html>
