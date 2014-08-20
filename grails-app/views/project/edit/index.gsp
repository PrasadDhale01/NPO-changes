<g:set var="userService" bean="userService"/>
<g:set var="contributionService" bean="contributionService"/>
<g:set var="projectService" bean="projectService"/>
<%
    def percentage = contributionService.getPercentageContributionForProject(project)
%>
<html>
<head>
    <meta name="layout" content="main" />
    <r:require modules="projectcreatejs"/>
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
			<g:if test="${percentage != 0 }">
			<div class="form-group">
                            <label class="col-sm-2 control-label">For</label>
                            <div class="col-sm-4">
                                <input id="firstName" class="form-control" name="${FORMCONSTANTS.FUNDRAISINGFOR}" value="${project.fundRaisingFor}" disabled>          
                            </div>
                        </div>
                        </g:if>
                        <g:else>
                        <div class="form-group">
                            <label class="col-sm-2 control-label">For</label>
                            <div class="col-sm-10">
                                <g:select class="selectpicker" name="${FORMCONSTANTS.FUNDRAISINGFOR}"
                                          from="${raisingForOptions}"
                                          optionKey="key" optionValue="value"/>
                            </div>
                        </div>
                    </g:else>
                    <hr>
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
                                    <input id="email" type="email" class="form-control" name="${FORMCONSTANTS.EMAIL}" value="${project.beneficiary.email}" disabled>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-4 control-label">Telephone</label>
                                <div class="col-sm-8">
                                    <input class="form-control" name="${FORMCONSTANTS.TELEPHONE}" value="${project.beneficiary.telephone}">
                                </div>
                            </div>
                        </div>
                        <div class="col col-sm-6">
                            <g:if test="${percentage== 0}">
                                <div class="form-group">
                                    <label class="col-sm-2 control-label">Address</label>
                                    <div class="col-sm-10">
                                        <input type="text" name="${FORMCONSTANTS.ADDRESSLINE1}" value="${project.beneficiary.addressLine1}" class="form-control">
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="col-sm-2 control-label">Address</label>
                                    <div class="col-sm-10">
                                         <input type="text" name="${FORMCONSTANTS.ADDRESSLINE2}" value="${project.beneficiary.addressLine2}" class="form-control">
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="col-sm-2 control-label">City</label>
                                    <div class="col-sm-10">
                                        <input type="text" name="${FORMCONSTANTS.CITY}" value="${project.beneficiary.city}" class="form-control">
                                    </div>
                                </div>
                            </g:if>
                            <g:else>
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
                            </g:else>    
                            <div class="form-group">
                                <label class="col-sm-2 control-label">State</label>
                                <div class="col-sm-4">
                                    <input type="text" name="${FORMCONSTANTS.STATEORPROVINCE}" value="${project.beneficiary.stateOrProvince}" class="form-control" disabled>
                                </div>
                                <label class="col-sm-2 control-label">Postcode</label>
                                <g:if test="${percentage == 0 }">
                                    <div class="col-sm-4">
                                        <input type="text" name="${FORMCONSTANTS.POSTALCODE}" value="${project.beneficiary.postalCode}" class="form-control">
                                    </div>
                                </g:if>
                                <g:else>
                                    <div class="col-sm-4">
                                        <input type="text" name="${FORMCONSTANTS.POSTALCODE}" value="${project.beneficiary.postalCode}" class="form-control">
                                    </div>
                                </g:else>    
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
                    <g:if test="${percentage== 0}">
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
                    </g:if>
                    <g:else>
                        <div class="form-group">
                            <label class="col-sm-2 control-label">Funds towards</label>
                            <div class="col-sm-10">
                                <input type="text" class="form-control"  name="${FORMCONSTANTS.FUNDRAISINGREASON}" value="${project.fundRaisingReason}" disabled>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-sm-2 control-label">Category</label>
                            <div class="col-sm-10">
                                <input type="text" class="form-control" name="${FORMCONSTANTS.CATEGORY}" value="${project.category}" disabled/>
                            </div>
                        </div>
                    </g:else>
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
                            <input class="form-control" name="${FORMCONSTANTS.AMOUNT}" value="${project.amount}">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">In days</label>
                        <div class="col-sm-10">
                            <input class="form-control" name="${FORMCONSTANTS.DAYS}" value="${project.days}">
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
                            <input class="form-control" name="${FORMCONSTANTS.TITLE}" value="${project.title}">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">Story</label>
                        <div class="col-sm-10">
                             <textarea class="form-control" name="${FORMCONSTANTS.STORY}" rows="4">${project.story}</textarea>                            
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">Thumbnail image</label>
                        <div class="col-sm-4">
                            <input type="file" name="${FORMCONSTANTS.THUMBNAIL}">
                            <p class="help-block">Please upload a thumbnail image for project.</p>
                        </div>
                        <label class="col-sm-2 control-label">or, Image URL</label>
                        <div class="col-sm-4">
                            <input class="form-control" name="${FORMCONSTANTS.IMAGEURL}" value="${project.imageUrl}">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">Rewards</label>
                        <div class="col-sm-10">
                            <div class="dropdown" id="dropdown">
                            <button href="#" class="dropdown-toggle" data-toggle="dropdown">Choose Multiple rewards &nbsp;<strong class="caret"></strong></button>
                            <ul class="dropdown-menu" id="dropdown-menu">
                                <g:each in="${rewardOptions}" var="rewardOption">
                                <li>
                                <a href="#">
                                    <input type="checkbox" name="${FORMCONSTANTS.REWARDS}" class="row-select" value="${rewardOption.key}">&nbsp;&nbsp;<small>${rewardOption.value.title}</small>
                                </a>
                                </li>
                                </g:each>
                            </ul>
                            </div>
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
