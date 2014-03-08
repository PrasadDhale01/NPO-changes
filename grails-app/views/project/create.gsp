<html>
<head>
<meta name="layout" content="main" />
</head>
<body>

	<div class="container">
		<h1>Create Project</h1>

        <g:form class="form-horizontal" controller="project" action="publish" role="form">
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
            <div class="form-group">
                <div class="col-sm-offset-2 col-sm-10">
        			<button type="submit" class="btn btn-default">Create Project</button>
                </div>
            </div>
		</g:form>

	</div>
</body>
</html>
