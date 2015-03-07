<html>
<head>
    <meta name="layout" content="main" />
    <r:require modules="projectcreatejs"/>
</head>
<body>
<div class="feducontent">
    <div class="container">
        <div class="row">
        <center> <h1>User List</h1> </center><br>
            <g:if test="${flash.message}">
                <div class="alert alert-success">
                    <center>${flash.message}</center>
                </div>
            </g:if>
            <h4>Verified Users</h4>
            <div class="table table-responsive">
            	<table class="table table-bordered">
            	    <thead>
                	<tr class="alert alert-title ">
                    	    <th>Id</th>
                    	    <th>Email</th>
                    	    <th>First Name</th>
                    	    <th>Last Name</th>
                    	    <th>Role</th>
                    	    <th>Date Created</th>
                    	    <th>Last Updated</th>            
                	</tr>
            	    </thead>
            	    <tbody>
                 	<g:render template="admin/userListGrid" model="['users': verifiedUsers]"></g:render>
            	    </tbody>
            	</table>
            </div><br>
            <h4>Non-Verified Users</h4>
            <div class="table table-responsive">
            	<table class="table table-bordered">
            	    <thead>
                	<tr class="alert alert-title ">
                    	    <th>Id</th>
                    	    <th>Email</th>
                    	    <th>First Name</th>
                    	    <th>Last Name</th>
                    	    <th>Role</th>
                    	    <th>Date Created</th>
                    	    <th>Re-send Confirm Email</th>            
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
