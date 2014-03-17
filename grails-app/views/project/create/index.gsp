<html>
<head>
<meta name="layout" content="main" />
<r:require modules="createjs"/>
</head>
<body>

	<div class="container">
		<h1>Create Project</h1>

        <g:uploadForm class="form-horizontal" controller="project" action="save" role="form">

			<div class="panel panel-default">
				<div class="panel-heading">
					<h3 class="panel-title">Who</h3>
				</div>
				<div class="panel-body">
                    <div class="form-group">
                        <label for="${FORMCONSTANTS.NAME}" class="col-sm-2 control-label">Name</label>
                        <div class="col-sm-10">
                            <input class="form-control" name="${FORMCONSTANTS.NAME}" placeholder="Name">
                        </div>
                    </div>
   	                <div class="form-group">
	                    <label for="${FORMCONSTANTS.EMAIL}" class="col-sm-2 control-label">Email</label>
	                    <div class="col-sm-10">
	                        <input type="email" class="form-control" name="${FORMCONSTANTS.EMAIL}" placeholder="Email">
	                    </div>
	                </div>
                    <div class="form-group">
                        <label for="${FORMCONSTANTS.TELEPHONE}" class="col-sm-2 control-label">Telephone</label>
                        <div class="col-sm-10">
                            <input class="form-control" name="${FORMCONSTANTS.TELEPHONE}" placeholder="Telephone">
                        </div>
                    </div>
				</div>
			</div>

            <div class="panel panel-default">
                <div class="panel-heading">
                    <h3 class="panel-title">Why</h3>
                </div>
                <div class="panel-body">
                    <div class="form-group">
                        <label for="${FORMCONSTANTS.FUNDRAISINGREASON}" class="col-sm-2 control-label">Funds towards</label>
                        <div class="col-sm-10">
                            <g:select class="form-control" name="${FORMCONSTANTS.FUNDRAISINGREASON}"
                                      from="${fundRaisingOptions}"
                                      optionKey="key" optionValue="value"/>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="${FORMCONSTANTS.FUNDRAISINGFOR}" class="col-sm-2 control-label">Funds for</label>
                        <div class="col-sm-10">
                            <g:select class="form-control" name="${FORMCONSTANTS.FUNDRAISINGFOR}"
                                      from="${raisingForOptions}"
                                      optionKey="key" optionValue="value"/>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="${FORMCONSTANTS.CATEGORY}" class="col-sm-2 control-label">Category</label>
                        <div class="col-sm-10">
                            <g:select class="form-control" name="${FORMCONSTANTS.CATEGORY}"
                                      from="${categoryOptions}"
                                      optionKey="key" optionValue="value"/>
                        </div>
                    </div>
                </div>
            </div>
            <div class="panel panel-default">
                <div class="panel-heading">
                    <h3 class="panel-title">How much & When</h3>
                </div>
                <div class="panel-body">
                    <div class="form-group">
                        <label for="${FORMCONSTANTS.AMOUNT}" class="col-sm-2 control-label">Amount</label>
                        <div class="col-sm-10">
                            <input class="form-control" name="${FORMCONSTANTS.AMOUNT}" placeholder="Amount">
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="${FORMCONSTANTS.DAYS}" class="col-sm-2 control-label">In days</label>
                        <div class="col-sm-10">
                            <input class="form-control" name="${FORMCONSTANTS.DAYS}" placeholder="Days">
                        </div>
                    </div>
                </div>
            </div>

            <div class="panel panel-default">
                <div class="panel-heading">
                    <h3 class="panel-title">How</h3>
                </div>
                <div class="panel-body">
                    <div class="form-group">
                        <label for="${FORMCONSTANTS.TITLE}" class="col-sm-2 control-label">Project title</label>
                        <div class="col-sm-10">
                            <input class="form-control" name="${FORMCONSTANTS.TITLE}" placeholder="Enter project title">
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="${FORMCONSTANTS.STORY}" class="col-sm-2 control-label">Story</label>
                        <div class="col-sm-10">
                            <textarea class="form-control" name="${FORMCONSTANTS.STORY}" rows="4"></textarea>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="${FORMCONSTANTS.THUMBNAIL}" class="col-sm-2 control-label">Thumbnail image</label>
                        <div class="col-sm-10">
                            <input type="file" name="${FORMCONSTANTS.THUMBNAIL}">
                            <p class="help-block">Please upload a thumbnail image for project.</p>
                        </div>
                    </div>
                </div>
            </div>

            <div class="panel panel-default">
                <div class="panel-heading">
                    <h3 class="panel-title">Get set, go</h3>
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

		</g:uploadForm>

	</div>
</body>
</html>
