<html>
<head>
<meta name="layout" content="main" />
</head>
<body>

	<div class="container">
		<h1>Create Project</h1>

        <g:form class="form-horizontal" controller="project" action="publish" role="form">

			<div class="panel panel-default">
				<div class="panel-heading">
					<h3 class="panel-title">Basics</h3>
				</div>
				<div class="panel-body">
		            <div class="form-group">
		                <label for="projectTitle" class="col-sm-2 control-label">Project title</label>
		                <div class="col-sm-10">
		                    <input class="form-control" name="title" placeholder="Enter project title">
		                </div>
		            </div>
	                <div class="form-group">
	                    <label for="email" class="col-sm-2 control-label">Email</label>
	                    <div class="col-sm-10">
	                        <input type="email" class="form-control" name="email" placeholder="Email">
	                    </div>
	                </div>
	                <div class="form-group">
	                    <label for="amount" class="col-sm-2 control-label">Amount</label>
	                    <div class="col-sm-10">
	                        <input class="form-control" name="amount" placeholder="Amount">
	                    </div>
	                </div>
				</div>
			</div>

            <div class="panel panel-default">
                <div class="panel-heading">
                    <h3 class="panel-title">Reason</h3>
                </div>
                <div class="panel-body">
		            <div class="form-group">
		                <label for="amount" class="col-sm-2 control-label">Funds towards</label>
		                <div class="col-sm-10">
		                    <g:select class="form-control" name="fundRaisingReason"
		                              from="${fundRaisingOptions}"
		                              optionKey="key" optionValue="value"/>
		                </div>
		            </div>
		            <div class="form-group">
		                <label for="amount" class="col-sm-2 control-label">Funds for</label>
		                <div class="col-sm-10">
		                    <g:select class="form-control" name="fundRaisingFor"
		                              from="${raisingForOptions}"
		                              optionKey="key" optionValue="value"/>
		                </div>
		            </div>
                </div>
            </div>

            <div class="panel panel-default">
                <div class="panel-heading">
                    <h3 class="panel-title">Reason</h3>
                </div>
                <div class="panel-body">
		            <div class="form-group">
                        <label class="col-sm-2 control-label">All cool?</label>
		                <div class="col-sm-10">
		                    <button type="submit" class="btn btn-primary">Create Project</button>
		                </div>
		            </div>
                </div>
            </div>

		</g:form>

	</div>
</body>
</html>
