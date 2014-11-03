<g:set var="contributionService" bean="contributionService"/>
<%
    def percentage = contributionService.getPercentageContributionForProject(project)
%>
<html>
<head>
    <meta name="layout" content="main" />
    <r:require modules="projectcreatejs"/>
    <ckeditor:resources/>
</head>
<body>
<div class="feducontent">
	<div class="container">
		<h1><span class="glyphicon glyphicon-edit"></span> Edit Project</h1>

        <g:uploadForm class="form-horizontal" controller="project" action="update" method="post">
            <input type="hidden" name="_method" value="PUT" id="_method" />

			<div class="panel panel-default">
				<div class="panel-heading">
					<h3 class="panel-title">Who</h3>
				</div>
				<div class="panel-body">
                    <div class="row">
                        <div class="col col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-4 control-label">First Name</label>
                                <div class="col-sm-8">
                                    <input id="firstName" class="form-control" name="${FORMCONSTANTS.FIRSTNAME}" value="${project.beneficiary.firstName}" disabled>
                                    <g:hiddenField name="projectId" value="${project.id}"/>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-4 control-label">Last Name</label>
                                <div class="col-sm-8">
                                    <input id="lastName" class="form-control" name="${FORMCONSTANTS.LASTNAME}" value="${project.beneficiary.lastName}" disabled>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-4 control-label">Gender</label>
                                <div class="col-sm-8">
                                    <input class="form-control" name="${FORMCONSTANTS.GENDER}" value="${project.beneficiary.gender}" disabled>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-4 control-label">Email</label>
                                <div class="col-sm-8">
                                    <input id="email" type="email" class="form-control" name="${FORMCONSTANTS.EMAIL}" value="${project.beneficiary.email}" disabled>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-4 control-label">Telephone</label>
                                <div class="col-sm-8">
                                    <input class="form-control" name="${FORMCONSTANTS.TELEPHONE}" value="${project.beneficiary.telephone}" disabled>
                                </div>
                            </div>
                        </div>
                        <div class="col col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-2 control-label">Address</label>
                                <div class="col-sm-10">
                                    <input type="text" name="${FORMCONSTANTS.ADDRESSLINE1}" value="${project.beneficiary.addressLine1}" class="form-control" disabled>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-2 control-label">Address</label>
                                <div class="col-sm-10">
                                    <input type="text" name="${FORMCONSTANTS.ADDRESSLINE2}" value="${project.beneficiary.addressLine2}" class="form-control" disabled>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-2 control-label">City</label>
                                <div class="col-sm-10">
                                    <input type="text" name="${FORMCONSTANTS.CITY}" value="${project.beneficiary.city}" class="form-control" disabled>
                                </div>
                            </div>
                            
                            <div class="form-group">
                                <label class="col-sm-2 control-label">State</label>
                                <div class="col-sm-4">
                                    <input type="text" name="${FORMCONSTANTS.STATEORPROVINCE}" value="${project.beneficiary.stateOrProvince}" class="form-control" disabled>
                                </div>
                                <label class="col-sm-2 control-label">Postcode</label>
                                <div class="col-sm-4">
                                    <input type="text" name="${FORMCONSTANTS.POSTALCODE}" value="${project.beneficiary.postalCode}" class="form-control" disabled>
                                </div>
                            </div>

                            <div class="form-group">
                                <label class="col-sm-2 control-label">Country</label>
                                <div class="col-sm-10">
                                    <input type="text" name="${FORMCONSTANTS.COUNTRY}" value="${project.beneficiary.country}" class="form-control" disabled>
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
                        <label class="col-sm-2 control-label">Category</label>
                        <div class="col-sm-4">
                            <input type="text" class="form-control" name="${FORMCONSTANTS.CATEGORY}" value="${project.category}" disabled/>
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
                            <input class="form-control" name="${FORMCONSTANTS.AMOUNT}" value="${project.amount}" disabled>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">In days</label>
                        <div class="col-sm-10">
                            <input class="form-control" name="${FORMCONSTANTS.DAYS}" value="${project.days}" disabled>
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
                            <input class="form-control" name="${FORMCONSTANTS.TITLE}" value="${project.title}" disabled>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">Description</label>
                        <div class="col-sm-10">
                            <textarea class="form-control" name="${FORMCONSTANTS.DESCRIPTION}" rows="2" placeholder="Enter project description"> ${project.description} </textarea>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">Story</label>
                        <div class="col-sm-10">
                            <ckeditor:config var="toolbar_Mytoolbar">
                                [
                                    ['Bold', 'Italic', 'Underline','Strike','Subscript', 'Superscript','-', 'RemoveFormat',],
                                    ['Link','Unlink','Anchor'],
                                    ['Styles','Format','Font','FontSize'],
                                    ['Maximize'],['TextColor'],['Smiley']
                                ]
                            </ckeditor:config>
                            
                            <ckeditor:editor toolbar="Mytoolbar" name="${FORMCONSTANTS.STORY}" id="${FORMCONSTANTS.STORY}" height="200px" width="100%">
                                ${project.story}
                            </ckeditor:editor>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">Thumbnail image</label>
                        <div class="col-sm-4">
                            <input type="file" name="${FORMCONSTANTS.THUMBNAIL}" disabled>
                            <p class="help-block">Please upload a thumbnail image for project.</p>
                        </div>
                        <div class="col-sm-4">
                            <input class="hidden" name="${FORMCONSTANTS.IMAGEURL}" placeholder="Image URL">
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
                        <label class="col-sm-2 control-label">Save changes?</label>
		                <div class="col-sm-10">
		                    <button type="submit" name="_action_update" value="Update" class="btn btn-primary">Save</button>
		                </div>
		            </div>
                </div>
            </div>

		</g:uploadForm>
	</div>
</div>

</body>
</html>
