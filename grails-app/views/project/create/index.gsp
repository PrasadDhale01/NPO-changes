<g:set var="userService" bean="userService" />
<g:set var="contributionService" bean="contributionService"/>
<% def user = userService.getCurrentUser() 
def base_url = grailsApplication.config.crowdera.BASE_URL
%>
<html>
<head>
<meta name="layout" content="main" />
<r:require modules="projectcreatejs" />
<ckeditor:resources />
</head>
<body>
	<input type="hidden" id="b_url" value="<%=base_url%>" /> 
	<input type="hidden" name="uuid" id="uuid" />
	<input type="hidden" name="charity_name" id="charity_name" />
	<div class="feducontent">
		<div class="container">
			<h1>
				<span class="glyphicon glyphicon-leaf"></span> Create Project
			</h1>

			<g:uploadForm class="form-horizontal" controller="project"
				action="save" role="form">

				<div class="panel panel-default">
					<div class="panel-heading">
						<h3 class="panel-title">Campaign Creator</h3>
					</div>
					<div class="panel-body">

						<div class="row">
							<div class="col col-sm-6">
								<div class="form-group">
									<label class="col-sm-4 control-label">First Name</label>
									<div class="col-sm-8">
										<input id="firstName" class="form-control"
											name="${FORMCONSTANTS.FIRSTNAME}" value="${user.firstName}"
											readonly>
									</div>
								</div>
								<div class="form-group">
									<label class="col-sm-4 control-label">Last Name</label>
									<div class="col-sm-8">
										<input id="lastName" class="form-control"
											name="${FORMCONSTANTS.LASTNAME}" value="${user.lastName}"
											readonly>
									</div>
								</div>
								<div class="form-group">
									<label class="col-sm-4 control-label">Email</label>
									<div class="col-sm-8">
										<input id="email" type="email" class="form-control"
											name="${FORMCONSTANTS.EMAIL}" value="${user.email}" readonly>
									</div>

								</div>
								<div class="form-group">
									<label class="col-sm-4 control-label">Telephone</label>
									<div class="col-sm-8">
										<input type="tel" class="form-control"
											name="${FORMCONSTANTS.TELEPHONE}" placeholder="Telephone">
									</div>
								</div>
							</div>
							<div class="col col-sm-6">
								<div class="form-group">
									<label class="col-sm-2 control-label">Address</label>
									<div class="col-sm-10">
										<input type="text" placeholder="Line 1"
											name="${FORMCONSTANTS.ADDRESSLINE1}" class="form-control">
									</div>
								</div>
								<div class="form-group">
									<label class="col-sm-2 control-label">Address</label>
									<div class="col-sm-10">
										<input type="text" placeholder="Line 2"
											name="${FORMCONSTANTS.ADDRESSLINE2}" class="form-control">
									</div>
								</div>
								<div class="form-group">
									<label class="col-sm-2 control-label">City</label>
									<div class="col-sm-10">
										<input type="text" placeholder="City"
											name="${FORMCONSTANTS.CITY}" class="form-control">
									</div>
								</div>

								<div class="form-group">
									<label class="col-sm-2 control-label">State</label>
									<div class="col-sm-4">
										<input type="text" placeholder="State"
											name="${FORMCONSTANTS.STATEORPROVINCE}" class="form-control">
									</div>

									<label class="col-sm-2 control-label">Postcode</label>
									<div class="col-sm-4">
										<input type="text" placeholder="Postcode"
											name="${FORMCONSTANTS.POSTALCODE}" class="form-control">
									</div>
								</div>

								<div class="form-group">
									<label class="col-sm-2 control-label">Country</label>
									<div class="col-sm-10">
										<input type="text" placeholder="Country"
											name="${FORMCONSTANTS.COUNTRY}" class="form-control">
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>

				<div class="panel panel-default">
					<div class="panel-heading">
						<h3 class="panel-title">Organizations</h3>
					</div>
					<div class="panel-body">
						<div class="form-group">
							<label class="col-sm-2 control-label">How do you like to
								get amount?</label>
							<div class="form-group" id="payopt">
								<label class="col-sm-2 control-label"></label>
								<div class="col-sm-8">
									<div class="btn-group btn-group-sm">
										<label class="btn btn-default"> <input type="radio"
											name="pay" value="paypal">&nbsp;Paypal
										</label> <label class="btn btn-default"> <input type="radio"
											name="pay" value="firstgiving">&nbsp;First Giving
										</label>
									</div>
								</div>
							</div>
							<div class="form-group" id="paypalemail">
								<label class="col-sm-2 control-label">PayPal Email ID </label>
								<div class="col-sm-3">
									<input id="email" type="email" class="form-control"
										name="${FORMCONSTANTS.PAYPALEMAIL}">
								</div>
							</div>
							<div id="organisation">
								<label class="col-sm-2 control-label">Is your
									organization registered with FirstGiving?</label>
								<div class="col-sm-8">
									<div class="btn-group btn-group-sm">
										<label class="btn btn-default"> <input type="radio"
											name="wel" value="yes"> Yes
										</label> <label class="btn btn-default"> <input type="radio"
											name="wel" value="no"> No
										</label>
									</div>
								</div>
							</div>
						</div>
						<div class="form-group" id="charitableId">
							<div class="row">
								<div class="col-sm-6">
									<label class="col-sm-4 control-label">Charitable ID</label>
									<div class="col-sm-8" id="charitable">
										<input type="text" class="form-control"
											name="${FORMCONSTANTS.CHARITABLE}" placeholder="CharitableId">
									</div>
								</div>
								<div class="col-sm-6">
									<a data-toggle="modal" href="#myModal" class="charitableLink">Find
										your organization</a>
								</div>
								<div class="modal" id="myModal">
									<div class="modal-dialog">
										<div class="modal-content">
											<div class="modal-header">
												<button type="button" class="close" data-dismiss="modal"
													aria-hidden="true">×</button>
												<h4 class="modal-title">Find your charity organization</h4>
											</div>
											<div class="modal-body">
												<div id="fgGraphWidgetContainer"></div>
												<script>
													var FG_GRAPHWIDGET_PARAMS = {
														results : {
															selectaction : function(
																	uuid,
																	charity_name) {
																document
																		.getElementById("uuid").value = uuid;
																document
																		.getElementById("charity_name").value = charity_name;
															}
														}
													};
													function setOrganization() {
														$('#charitable')
																.find('input')
																.val(
																		document
																				.getElementById("uuid").value);
														$('#organizationName')
																.find('input')
																.val(
																		document
																				.getElementById("charity_name").value);
													}
												</script>
												<script
													src="http://assets.firstgiving.com/graphwidget/static/js/fg_graph_widget.min.js"></script>
											</div>
											<div class="modal-footer">
												<button href="#" data-dismiss="modal"
													class="btn btn-primary">Close</button>
												<button class="btn btn-primary" href="#"
													data-dismiss="modal" onclick="setOrganization()"
													id="saveButton">Save</button>
											</div>
										</div>
									</div>
								</div>
							</div>
						</div>
						<div class="form-group" id="textfile">
							<label class="col-sm-2 control-label">Upload your Letter
								of Determination</label>
							<div class="col-sm-4">
								<input type="file" name="textfile">
							</div>
						</div>
						<hr>
						<div class="row">
							<div class="col col-sm-6">
								<div class="form-group" id="organizationName">
									<label class="col-sm-4 control-label" id="organizationName">Organization
										Name</label>
									<div class="col-sm-8">
										<input class="form-control"
											name="${FORMCONSTANTS.ORGANIZATIONNAME}"
											id="organizationname" placeholder="Organization Name">
									</div>
								</div>
								<div class="form-group">
									<label class="col-sm-4 control-label" id="iconfile">Organization
										Icon</label>
									<div class="col-sm-8">
										<input type="file" name="iconfile">
									</div>
								</div>
							</div>
							<div class="col col-sm-6">
								<div class="form-group">
									<label class="col-sm-4 control-label" id="webAddress">Web
										Address</label>
									<div class="col-sm-8">
										<input class="form-control"
											name="${FORMCONSTANTS.WEBADDRESS }" placeholder="Web Address">
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>

				<div class="panel panel-default">
					<div class="panel-heading">
						<h3 class="panel-title">Campaign Co-Creators</h3>
					</div>
					<div class="panel-body">
						<div class="col-sm-6">
							<div class="form-group">
								<label class="col-sm-4 control-label">First Admin</label>
								<div class="col-sm-8">
									<input type="text" class="form-control" name="email1"
										id="firstadmin" placeholder="Email ID"></input>
								</div>
							</div>
							<div class="form-group">
								<label class="col-sm-4 control-label">Second Admin</label>
								<div class="col-sm-8">
									<input type="text" class="form-control" name="email2"
										id="secondadmin" placeholder="Email ID"></input>
								</div>
							</div>
						</div>

						<div class="col-sm-6">
							<div class="form-group">
								<label class="col-sm-4 control-label">Third Admin</label>
								<div class="col-sm-8">
									<input type="text" class="form-control" name="email3"
										id="thirdadmin" placeholder="Email ID"></input>
								</div>
							</div>
						</div>
					</div>
				</div>

				<div class="panel panel-default">
					<div class="panel-heading">
						<h3 class="panel-title">Select Your Cause</h3>
					</div>
					<div class="panel-body">
						<div class="form-group">
							<label class="col-sm-2 control-label">Category</label>
							<div class="col-sm-10">
								<g:select class="selectpicker" name="${FORMCONSTANTS.CATEGORY}"
									from="${categoryOptions}"
									value="${FORMCONSTANTS.DEFAULT_CATEGORY}" optionKey="key"
									optionValue="value" />
							</div>
						</div>
					</div>
				</div>

				<div class="panel panel-default">
					<div class="panel-heading">
						<h3 class="panel-title">Funding Goal and Campaign End Date</h3>
					</div>
					<div class="panel-body">
						<div class="form-group">
							<label class="col-sm-2 control-label">Amount</label>
							<div class="col-sm-10">
								<input class="form-control" name="${FORMCONSTANTS.AMOUNT}"
									id="${FORMCONSTANTS.AMOUNT}" placeholder="Amount"> <span
									id="errormsg"></span>
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-2 control-label"># of Days Campaign Runs</label>
							<div class="col-sm-10">
								<input class="form-control" name="${FORMCONSTANTS.DAYS}"
									placeholder="Recommend: 30, 45, or 90">
							</div>
						</div>
					</div>
				</div>

				<div class="panel panel-default">
					<div class="panel-heading">
						<h3 class="panel-title">Tell Us About Your Campaign</h3>
					</div>
					<div class="panel-body">
						<div class="form-group">
							<label class="col-sm-2 control-label">Project title</label>
							<div class="col-sm-10">
								<input class="form-control" name="${FORMCONSTANTS.TITLE}"
									placeholder="Enter project title">
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-2 control-label">Brief Description</label>
							<div class="col-sm-10">
								<textarea class="form-control"
									name="${FORMCONSTANTS.DESCRIPTION}" rows="2"
									placeholder="Make it catchy, and no more than 140 characters"></textarea>
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
                                    ['Maximize'],['TextColor'],
                                    [ 'Image','Flash','Table','HorizontalRule','Smiley','SpecialChar','PageBreak','Iframe' ]
                                ]
                            </ckeditor:config>

								<ckeditor:editor toolbar="Mytoolbar"
									name="${FORMCONSTANTS.STORY}" id="${FORMCONSTANTS.STORY}"
									height="200px" width="100%">
									${initialValue}
								</ckeditor:editor>
							</div>
						</div>
					</div>
				</div>

				<div class="panel panel-default">
					<div class="panel-heading">
						<h3 class="panel-title">Campaign Images and Video</h3>
					</div>
					<div class="panel-body">
						<div class="form-group">
							<label class="col-sm-2 control-label">Pictures</label>
							<div class="col-sm-2">
							    <button class="btnAddImage btn-circle" type="button" id="add_img_btn">Add Image&nbsp;<span class="fa fa-plus-circle"></span></button>
								<input type="file" class="hidden" name="${FORMCONSTANTS.THUMBNAIL}[]"
									id="projectImageFile" multiple="multiple">
							</div>
							<!--<div class="col-sm-2">
								<input class="hidden" name="${FORMCONSTANTS.IMAGEURL}"
									placeholder="Image URL">
							</div>-->
							<div class="col-sm-8">
							    <output id="result"></output>	
							</div>						
						</div>
						</div>
						<div class="form-group">
							<label class="col-sm-2 control-label">Video URL</label>
							<div class="col-sm-4">
								<input id="videoUrl" class="form-control"
									name="${FORMCONSTANTS.VIDEO}">
							</div>
						</div>
					</div>

				<div class="panel panel-default">
					<div class="panel-heading">
						<h3 class="panel-title">Rewards</h3>
					</div>
					<div class="panel-body">
						<div class="form-group">
							<label class="col-sm-2 control-label">Will you offer rewards?</label>
							<div class="col-sm-10">
								<div class="btn-group btn-group-sm">
									<label class="btn btn-default"> <input type="radio"
										name="answer" value="yes"> Yes
									</label> <label class="btn btn-default"> <input type="radio"
										name="answer" value="no"> No
									</label>
								</div>
							</div>

							<div id="addNewRewards">
								<hr>
								<div class="rewardsTemplate" id="rewardTemplate">
									<hr>
									<div class="row">
										<div class="col-sm-6">
											<label class="col-sm-4 control-label">Reward Title</label>
											<div class="col-sm-8">
												<input type="text" placeholder="Title" name="rewardTitle"
													class="form-control rewardTitle">
											</div>
										</div>
										<div class="col-sm-6">
											<label class="col-sm-3 control-label">Reward Price</label>
											<div class="col-sm-9">
												<input type="number" placeholder="Price" name="rewardPrice"
													class="form-control rewardPrice">
											</div>
										</div>
									</div>
									<br>
									<div class="row">
										<div class="col-sm-12">
											<label class="col-sm-2 control-label">Reward
												Description</label>
											<div class="col-sm-10" style="left-padding: 0px;">
												<textarea class="form-control rewardDescription"
													name="rewardDescription" id="rewardDescription" rows="2"
													placeholder="Description" style="left-padding: 0px"></textarea>
											</div>
										</div>
									</div>
								</div>
							</div>
							<br>

							<div class="row">
								<div class="col-sm-12" id="updatereward">
									<div class="col-sm-12" align="right" style="right-padding: 0px">
										<div class="btn btn-primary btn-circle" id="createreward"
											style="padding: 3px 6px;">
											<i class="glyphicon glyphicon-plus"></i>
										</div>
										<div class="btn btn-primary btn-circle" id="removereward"
											style="padding: 3px 6px;">
											<i class="glyphicon glyphicon-trash"></i>
										</div>
									</div>
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
							<label class="col-sm-2 control-label">All Cool!</label>
							<div class="col-sm-2-offset col-sm-4">
								<button type="submit" class="btn btn-primary" name="button"
									id="submitProject" value="submitProject">Submit Campaign</button>
							</div>
							<div class="col-sm-4">
								<button type="submit" class="btn btn-primary" name="button"
									value="draft">Save as draft</button>
							</div>
						</div>
					</div>
				</div>

			</g:uploadForm>
		</div>
	</div>

</body>
</html>
