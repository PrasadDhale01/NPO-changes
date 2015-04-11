<html>
<head>
    <meta name="layout" content="main" />
    <r:require modules="projectcreatejs"/>
</head>
<body>
<div class="feducontent">
    <div class="container">
        <div class="row">
        <h1>Transaction List</h1><br>
            <g:if test="${flash.message}">
                <div class="alert alert-success">
                    ${flash.message}
                </div>
            </g:if>
            <g:if test="${!transaction.empty }">
                <g:form controller="fund" action="generateCSV" role="form" Method="post" >
                    <div class="generateCSV">
                        <button type="submit" class="btn btn-primary btn-sm pull-right" >Generate CSV</button>
                    </div>
                </g:form>
           </g:if>
            <div class="table table-responsive">
            	<table class="table table-bordered">
            	    <thead>
                	<tr class="alert alert-title ">
                        <th>SR. NO.</th>
                        <th>Transaction Id</th>
                        <th>Contribution Date</th>
                    	<th>Project</th>
                    	<th>Contributor Name</th>
                    	<th>Project Amount</th>
                    	<th>Contributed Amount</th>
                	</tr>
            	    </thead>
            	    <tbody>
                 	    <g:render template="/user/admin/transactionGrid" model="['transaction': transaction]"></g:render>
            	    </tbody>
            	</table>
            </div>
        </div>
    </div>    
</div>
</body>
</html>
