<html>
<head>
<meta name="layout" content="main" />
</head>
<body>

	<div class="container">
		<h1>Create Project</h1>

        <g:form controller="project" action="publish" role="form">
			<div class="form-group">
				<label for="projectTitle">Project title</label>
				<input class="form-control" name="title" placeholder="Enter project title">
			</div>
            <div class="form-group">
                <label for="email">Email</label>
                <input type="email" class="form-control" name="email" placeholder="Email">
            </div>
			<div class="form-group">
				<label for="amount">Amount</label>
				<input class="form-control" name="amount" placeholder="Amount">
			</div>
			<button type="submit" class="btn btn-default">Create Project</button>
		</g:form>

	</div>
</body>
</html>
