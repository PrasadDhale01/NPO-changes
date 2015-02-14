<html>
<head>
	<meta name="layout" content="main" />
	<r:require modules="projecteditjs"/>
	<script src="//tinymce.cachefly.net/4.1/tinymce.min.js"></script>
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
</head>
<body>
    <div class="feducontent">
		<div class="container">
		    <g:uploadForm class="form-horizontal" controller="project" action="updatesave" id="${project.id}" role="form">
		    <div class="row">
<%--		        <h1><span class="glyphicon glyphicon-leaf"></span> Post an update</h1>--%>
				<h1><img class="img-circle" src="/images/icon-create.png" alt="Generic placeholder image"> Post an update</h1>
		        <div class="panel panel-default">
		            <div class="panel-heading">
						<h3 class="panel-title">Story and Images</h3>
					</div>
			        <div class="panel-body">
				        <div class="form-group">
							<label class="col-sm-2 control-label">Story</label>
							<div class="col-sm-10">
								<textarea name="${FORMCONSTANTS.STORY}" id="${FORMCONSTANTS.STORY}" class="mceEditor">
									${initialValue}</textarea>
						    </div>
						</div><br/>
						
	                    <div class="form-group">
	                        <label class="col-sm-2 control-label">Pictures</label>
	                        <div class="col-sm-2">
	                            <button class="btn btn-primary btn-sm" type="button" id="addProjectImage">Add Image&nbsp;<span class="fa fa-plus-circle"></span></button>
	                            <input type="file" class="hidden" name="${FORMCONSTANTS.THUMBNAIL}[]" id="updateImageFile" multiple="multiple" accept="image/*">
	                            <label class="show-update-select" id="imgupdatemsg">Select image file.</label>
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
