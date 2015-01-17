<g:set var="userService" bean="userService" />
<g:set var="contributionService" bean="contributionService"/>
<g:set var="projectService" bean="projectService"/>
<% def user = userService.getCurrentUser() 
def base_url = grailsApplication.config.crowdera.BASE_URL
%>
<html>
<head>
<meta name="layout" content="main" />
<r:require modules="projectcreatejs" />
<script src="//tinymce.cachefly.net/4.1/tinymce.min.js"></script>
<link rel="stylesheet" href="/bootswatch-yeti/bootstrap.css">
<link rel="stylesheet" href="/css/datepicker.css">
<script src="/js/main.js"></script>
<script src="/js/bootstrap-datepicker.js"></script>
<script>
	var j = jQuery.noConflict();
		j(function(){
			j('.datepicker').datepicker();
		});
</script>
<script>
tinymce.init({
	mode : "specific_textareas",
    editor_selector : "mceEditor",
	plugins: [
          "advlist autolink lists link image charmap print preview hr anchor pagebreak emoticons",
      ],
      toolbar: "| insertfile undo redo | styleselect | bold italic | alignleft aligncenter alignright alignjustify | bullist numlist outdent indent | link image forecolor backcolor emoticons",
      image_advtab: true,
      templates: [
          {title: 'Test template 1', content: 'Test 1'},
          {title: 'Test template 2', content: 'Test 2'}
      ]
});
</script>
<script>
	function removeLogo(){
 			$('#delIcon').removeAttr('src');
			$('#imgIcon').removeAttr('src');
			$('#icondiv').hide();
			$('#iconfile').val(''); 
	}
</script>

</head>
<body>
	<input type="hidden" id="b_url" value="<%=base_url%>" /> 
	<input type="hidden" name="uuid" id="uuid" />
	<input type="hidden" name="charity_name" id="charity_name" />
	<div class="feducontent">
		<div class="container">
			<h1>
				<span class="glyphicon glyphicon-leaf"></span> Create Campaign
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
									<div class="col-sm-4">
										<input type="text" placeholder="City"
											name="${FORMCONSTANTS.CITY}" class="form-control">
									</div>
									
									<label class="col-sm-2 control-label">Postcode</label>
									<div class="col-sm-4">
										<input type="text" placeholder="Postcode"
											name="${FORMCONSTANTS.POSTALCODE}" class="form-control">
									</div>
								</div>

								<div class="form-group country-create-project">
									<label class="col-sm-2 control-label">State</label>
									<div class="col-sm-10" id="val1">
										<g:select  class="selectpicker" type="text" name="${FORMCONSTANTS.STATEORPROVINCE}" from="${state}" optionKey="key" optionValue="value"/>	
									</div>
									<div class="col-sm-10" id="val2">
										<input type="text" placeholder="State"
											name="otherstate" class="form-control">
									</div>
								</div>

								<div class="form-group country-create-project">
									<label class="col-sm-2 control-label">Country</label>
									<div class="col-sm-10">
										<g:select type="text" id="val3" class="selectpicker" name="${FORMCONSTANTS.COUNTRY}" from="${country}" value="US" optionKey="key" optionValue="value"/>
									</div>
								</div>

								<div class="form-group">
                             		<label class="col-sm-2 control-label">&nbsp;</label>
         							<div class="col-sm-10">
          								<input type="checkbox" name="checkBox" > I confirm I am over the age of 13.
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
						<h3 class="panel-title">Organization</h3>
					</div>
					<div class="panel-body">
						<div class="form-group">
							<label class="col-sm-2 control-label">Preferred payment gateway</label>
							<div class="col-sm-10 form-group" id="payopt">
								<div class="col-sm-8">
									<div class="btn-group btn-group-sm">
										<label class="btn btn-default"> <input type="radio" name="pay" value="paypal">&nbsp;Paypal</label>
										<label class="btn btn-default"> <input type="radio" name="pay" value="firstgiving">&nbsp;First Giving</label>
									</div>
								</div>
							</div>
							<div class="col-sm-12" id="paypalemail">
                                <div class="form-group">
									<label class="col-sm-2 control-label">PayPal Email ID </label>
									<div class="col-sm-4">
										<input id="email" type="email" class="form-control" name="${FORMCONSTANTS.PAYPALEMAIL}">
									</div>
								</div>
 							</div>
							<div class="col-sm-12" id="paypalcheckbox">
							    <div class="form-group">
	                             	<label class="col-sm-2 control-label">&nbsp;</label>
	         						<div class="col-sm-10">
	          						    <input type="checkbox" name="checkBox2" > I attest that this is a verified non-profit.
	         						</div>
          						</div>
         					</div>
         					
							<div class="col-sm-12" id="charitableId">							
								<div class="form-group">
								    <label class="col-sm-2 control-label">Charitable ID</label>
									<div class="col-sm-2">
										<a data-toggle="modal" href="#myModal" class="charitableLink">Find your organization</a>
									</div>
									<div class="col-sm-6" id="charitable">
										<input type="text" id="hiddencharId" name="${FORMCONSTANTS.CHARITABLE}" placeholder="charitableId" readonly>
									</div>
								</div>
								<div class="modal" id="myModal">
									<div class="modal-dialog">
										<div class="modal-content">
											<div class="modal-header">
												<button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
												<h4 class="modal-title">Find your charity organization</h4>
											</div>
											<div class="modal-body">
												<div id="fgGraphWidgetContainer"></div>
												<script>
													var FG_GRAPHWIDGET_PARAMS = {
														results : {
															selectaction : function(uuid,charity_name) {	
																document.getElementById("uuid").value = uuid;
																document.getElementById("charity_name").value = charity_name;
															}
														}
													};
													function setOrganization() {
														$('#charitable').find('input').val(document.getElementById("uuid").value);
														$('#organizationName').find('input').val(document.getElementById("charity_name").value);
													}
												</script>
												<script src="http://assets.firstgiving.com/graphwidget/static/js/fg_graph_widget.min.js"></script>
											</div>
											<div class="modal-footer">
												<button href="#" data-dismiss="modal" class="btn btn-primary">Close</button>
												<button class="btn btn-primary" href="#" data-dismiss="modal" onclick="setOrganization()" id="saveButton">Save</button>
											</div>
										</div>
									</div>
								</div>
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
									<label class="col-sm-4 control-label" id="iconfiles">Organization Logo</label>
									<div class="col-sm-4">
										<input type="file" id="iconfile" name="iconfile" accept="image/*">
										<button id="chooseFile" class="btn btn-primary" type="button">
											<i class="icon-file"></i> Choose File
										</button>
										<label  id="logomsg" style="color:red;dispaly:none;" >Select image file.</label>
									</div>
									<div id="icondiv" class="pr-icon-thumbnail-div col-sm-4">
									<img id="imgIcon" class="pr-icon-thumbnail"/>
										<div class="deleteicon">
											<img onClick="removeLogo();"
												id="delIcon" style="margin: 2px; width: 10px; height: 10px;" />
										</div>
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
							<label class="col-sm-2 control-label">Campaign end date</label>
							<div class="col-sm-10">
								<div class="input-group enddate"><span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>
									<input class="datepicker pull-left" name="${FORMCONSTANTS.DAYS}" placeholder="Campaign end date"> 
							    </div>
							</div>
						</div>
					</div>
				</div>

				<div class="panel panel-default">
					<div class="panel-heading">
						<h3 class="panel-title">Tell us about your Campaign</h3>
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
						<div class="form-group">
							<label class="col-sm-2 control-label">Campaign title</label>
							<div class="col-sm-10">
								<input class="form-control" name="${FORMCONSTANTS.TITLE}"
									placeholder="Enter Campaign title">
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-2 control-label">Brief Description</label>
							<div class="col-sm-10">
								<textarea class="form-control" id="descarea"
									name="${FORMCONSTANTS.DESCRIPTION}" rows="2"
									placeholder="Make it catchy, and no more than 140 characters" maxlength="140"></textarea>
									<label class="pull-right " id="desclength"></label>
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-2 control-label">Story</label>
							<div class="col-sm-10">
								<textarea name="${FORMCONSTANTS.STORY}" id="${FORMCONSTANTS.STORY}" row="4" col="6" class="mceEditor">
									${initialValue}</textarea>
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
      						<div class="col-sm-4">
        						<button id="add_img_btn" class="btn btn-primary btnAddImage" type="button"> <i class="icon-file"></i> Add Image </button>
        						<label id="imgmsg" style="color:red;" >Select image file.</label>
        						<input type="file" class="hidden" name="${FORMCONSTANTS.THUMBNAIL}[]"
         							id="projectImageFile" multiple="multiple" accept="image/*">
      						</div>
      						<!--<div class="col-sm-2">
        						<input class="hidden" name="${FORMCONSTANTS.IMAGEURL}"
         							placeholder="Image URL">
       						</div>-->
      						<div class="col-sm-6">
        						<output id="result"></output>
      						</div>
    					</div>
    					<div class="form-group">
      						<label class="col-sm-2 control-label">Video URL</label>
      						<div class="col-sm-4">
        						<input id="videoUrl" class="form-control"
         							name="${FORMCONSTANTS.VIDEO}">
      						</div>
      						<div class="col-sm-4" id="ytVideo"></div>
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
						</div>
							<input type="hidden" name="rewardCount" id="rewardCount" value='1'/>
							<div id="addNewRewards">
								<div class="rewardsTemplate" id="rewardTemplate">
									<div class="row">
										<div class="form-group rewardTitles col-sm-6">
											<label class="col-sm-4 control-label">Reward Title</label>
											<div class="col-sm-8">
												<input type="text" placeholder="Title" name="rewardTitle1"
													class="form-control rewardTitle required" id="rewardTitle1">
											</div>
										</div>
										<div class="form-group col-sm-6">
											<label class="col-sm-3 control-label">Reward Price</label>
											<div class="col-sm-9">
												<input type="number" placeholder="Enter digits only" name="rewardPrice1"
													class="form-control rewardPrice required" id="rewardPrice1" min="0">
											</div>
										</div>
									</div>
									
									<div class="form-group row">
										<div class="col-sm-12">
											<label class="col-sm-2 control-label rewarddesctitle" >Reward Description</label>
											<div class="col-sm-10 rewarddesc">
												<textarea class="form-control rewardDescription required"
													name="rewardDescription1" id="rewardDesc1" rows="2"
													placeholder="Description"></textarea>
											</div>
										</div>
									</div><hr>
								</div>
							</div>
						

							<div class="row">
								<div class="col-sm-12" id="updatereward" style="margin-left:-43px;">
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
