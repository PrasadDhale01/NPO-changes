<html>
<head>
    <meta name="layout" content="main" />
    <r:require modules="projectcreatejs"/>
</head>
<body>
<div class="feducontent">
    <div class="container">
        <div class="row">
        <h1>User List</h1><br>
            <g:if test="${flash.message}">
                <div class="alert alert-success">
                    ${flash.message}
                </div>
            </g:if>
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
                 		<g:render template="admin/userListGrid" model="['users': users]"></g:render>
            		</tbody>
            	</table>
            </div>
        </div>
    </div>    
</div>
</body>
</html>
