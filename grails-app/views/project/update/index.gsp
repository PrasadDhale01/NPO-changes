<html>
<head>
	<meta name="layout" content="main" />
	<r:require modules="projecteditjs"/>
	<ckeditor:resources />
</head>
<body>
    <div class="feducontent">
		<div class="container">
		    <g:uploadForm class="form-horizontal" controller="project" action="updatesave" id="${project.id}" role="form">
		    <div class="row">
		        <h1><span class="glyphicon glyphicon-leaf"></span> Post an update</h1>
		        <div class="panel panel-default">
		            <div class="panel-heading">
						<h3 class="panel-title">Story and Images</h3>
					</div>
			        <div class="panel-body">
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
		                        
								<ckeditor:editor toolbar="Mytoolbar" name="${FORMCONSTANTS.STORY}" id="${FORMCONSTANTS.STORY}" height="200px" width="100%">
						            ${initialValue}
							    </ckeditor:editor>
						    </div>
						</div><br/>
						
	                    <div class="form-group">
	                        <label class="col-sm-2 control-label">Pictures</label>
	                        <div class="col-sm-2">
	                            <button class="btn btn-primary btn-sm" type="button" id="addProjectImage">Add Image&nbsp;<span class="fa fa-plus-circle"></span></button>
	                            <input type="file" class="hidden" name="${FORMCONSTANTS.THUMBNAIL}[]" id="updateImageFile" multiple="multiple" accept="image/*">
	                            <label id="imgupdatemsg" style="color:red;" >Select image file.</label>
	                        </div>
	                        <div class="col-sm-8">
							    <output id="result"></output>
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
							<label class="col-sm-2 control-label">Save Update</label>
							<div class="col-sm-2-offset col-sm-4">
								<button type="submit" class="btn btn-primary btn-sm" name="button" id="updatesubmitbutton">Submit Update</button>
							</div>
						</div>
					</div>
				</div>
				
		    </div>
		    </g:uploadForm>
		</div>
	</div>
</body>
</html>
