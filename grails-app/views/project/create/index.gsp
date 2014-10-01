<g:set var="userService" bean="userService"/>
<html>
<head>
    <meta name="layout" content="main" />
    <r:require modules="projectcreatejs"/>
</head>
<body>
<div class="feducontent">
	<div class="container">
		<h1><span class="glyphicon glyphicon-leaf"></span> Create Project</h1>

        <g:uploadForm class="form-horizontal" controller="project" action="save" role="form">

			<div class="panel panel-default">
				<div class="panel-heading">
					<h3 class="panel-title">Who</h3>
				</div>
				<div class="panel-body">
                    <div class="form-group">
                        <label class="col-sm-2 control-label">For</label>
                        <div class="col-sm-10">
                            <g:select class="selectpicker" name="${FORMCONSTANTS.FUNDRAISINGFOR}"
                                      from="${raisingForOptions}"
                                      optionKey="key" optionValue="value"/>
                        </div>
                    </div>
                    <hr>
                    <div class="row">
                        <div class="col col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-4 control-label">First Name</label>
                                <div class="col-sm-8">
                                    <input id="firstName" class="form-control" name="${FORMCONSTANTS.FIRSTNAME}">
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-4 control-label">Last Name</label>
                                <div class="col-sm-8">
                                    <input id="lastName" class="form-control" name="${FORMCONSTANTS.LASTNAME}">
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-4 control-label">Gender</label>
                                <div class="col-sm-8">
                                    <div class="btn-group btn-group-sm" data-toggle="buttons">
                                        <label class="btn btn-default">
                                            <input type="radio" name="${FORMCONSTANTS.GENDER}" value="${genderOptions.MALE}"> Male
                                        </label>
                                        <label class="btn btn-default">
                                            <input type="radio" name="${FORMCONSTANTS.GENDER}" value="${genderOptions.FEMALE}"> Female
                                        </label>
                                        <label class="btn btn-default">
                                            <input type="radio" name="${FORMCONSTANTS.GENDER}" value="${genderOptions.UNSPECIFIED}"> Unspecified
                                        </label>
                                    </div>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-4 control-label">Email</label>
                                <div class="col-sm-8">
                                    <input id="email" type="email" class="form-control" name="${FORMCONSTANTS.EMAIL}">
                                </div>

                            </div>
                            <div class="form-group">
                                <label class="col-sm-4 control-label">Telephone</label>
                                <div class="col-sm-8">
                                    <input class="form-control" name="${FORMCONSTANTS.TELEPHONE}" placeholder="Telephone">
                                </div>
                            </div>
                        </div>
                        <div class="col col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-2 control-label">Address</label>
                                <div class="col-sm-10">
                                    <input type="text" placeholder="Line 1" name="${FORMCONSTANTS.ADDRESSLINE1}" class="form-control">
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-2 control-label">Address</label>
                                <div class="col-sm-10">
                                    <input type="text" placeholder="Line 2" name="${FORMCONSTANTS.ADDRESSLINE2}" class="form-control">
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-2 control-label">City</label>
                                <div class="col-sm-10">
                                    <input type="text" placeholder="City" name="${FORMCONSTANTS.CITY}" class="form-control">
                                </div>
                            </div>

                            <div class="form-group">
                                <label class="col-sm-2 control-label">State</label>
                                <div class="col-sm-4">
                                    <input type="text" placeholder="State" name="${FORMCONSTANTS.STATEORPROVINCE}" class="form-control">
                                </div>

                                <label class="col-sm-2 control-label">Postcode</label>
                                <div class="col-sm-4">
                                    <input type="text" placeholder="Postcode" name="${FORMCONSTANTS.POSTALCODE}" class="form-control">
                                </div>
                            </div>

                            <div class="form-group">
                                <label class="col-sm-2 control-label">Country</label>
                                <div class="col-sm-10">
                                    <input type="text" placeholder="Country" name="${FORMCONSTANTS.COUNTRY}" class="form-control">
                                </div>
                            </div>
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
                        <label class="col-sm-2 control-label">Funds towards</label>
                        <div class="col-sm-10">
                            <g:select class="selectpicker" name="${FORMCONSTANTS.FUNDRAISINGREASON}"
                                      from="${fundRaisingOptions}"
                                      optionKey="key" optionValue="value"/>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">Category</label>
                        <div class="col-sm-10">
                            <g:select class="selectpicker" name="${FORMCONSTANTS.CATEGORY}"
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
                        <label class="col-sm-2 control-label">Amount</label>
                        <div class="col-sm-10">
                            <input class="form-control" name="${FORMCONSTANTS.AMOUNT}" placeholder="Amount">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">In days</label>
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
                        <label class="col-sm-2 control-label">Project title</label>
                        <div class="col-sm-10">
                            <input class="form-control" name="${FORMCONSTANTS.TITLE}" placeholder="Enter project title">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">Description</label>
                        <div class="col-sm-10">
                            <textarea class="form-control" name="${FORMCONSTANTS.SSTORY}" rows="2" placeholder="Enter project description"></textarea>
                        </div>
                    </div>
                     <div class="form-group">
                        <label class="col-sm-2 control-label">Story</label>
                        <div class="col-sm-10">
                            <input type="hidden" class="form-control">  
                            <ckeditor:editor   name="${FORMCONSTANTS.STORY}"  toolbar="custom" height="200px" width="100%">
                                ${initialValue}
                            </ckeditor:editor>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">Thumbnail image</label>
                        <div class="col-sm-4">
                            <input type="file" name="${FORMCONSTANTS.THUMBNAIL}">
                            <p class="help-block">Please upload a thumbnail image for project.</p>
                        </div>
                        <div class="col-sm-4">
                            <input class="hidden" name="${FORMCONSTANTS.IMAGEURL}" placeholder="Image URL">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">Rewards</label>
                        <div class="col-sm-10">
                            <select class="multiselect" name="${FORMCONSTANTS.REWARDS}" multiple="multiple">
                                <g:each in="${rewardOptions}" var="rewardOption">
                                    <option value="${rewardOption.key}">${rewardOption.value.title} ($${rewardOption.value.price})</option>
                                </g:each>
                            </select>
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
</div>

</body>
</html>
