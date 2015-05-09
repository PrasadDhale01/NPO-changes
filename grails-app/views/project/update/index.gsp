<html>
<head>
	<meta name="layout" content="main" />
	<r:require modules="projecteditjs"/>
	<script src="//tinymce.cachefly.net/4.1/tinymce.min.js"></script>
	<script>
	    tinymce.init({
		    mode : "specific_textareas",
		    menubar: "edit insert view format",
	        editor_selector : "mceEditor",
	        plugins: [
	                  "advlist autolink lists link image media charmap print preview hr anchor pagebreak emoticons",
	              ],
	              toolbar: "| undo redo | bold italic | alignleft aligncenter alignright alignjustify | bullist numlist outdent indent | link image media forecolor backcolor emoticons",
	              image_advtab: true,
	              templates: [
	                  {title: 'Test template 1', content: 'Test 1'},
	                  {title: 'Test template 2', content: 'Test 2'}
	              ]
	    });

	    var needToConfirm = true;
        window.onbeforeunload = confirmExit;
        function confirmExit()
        {
            if(needToConfirm){
            	return "You have attempted to leave this page.  If you have made any changes to the fields without clicking the Save button, your changes will be lost.  Are you sure you want to exit this page?";
            }
        }
	</script>
</head>
<body>
    <div class="feducontent">
		<div class="container">
		    <g:uploadForm class="form-horizontal" controller="project" action="updatesave" id="${project.id}" role="form">
		    <div class="row">
				<h1><img class="img-circle" src="//s3.amazonaws.com/crowdera/assets/icon-create.png" alt="Post an update"/> Post an update</h1>
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
	                            <label class="docfile-orglogo-css" id="updatefilesize"></label>
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
								<button type="submit" class="btn btn-primary btn-sm updatesubmitbutton" name="button" id="updatesubmitbutton">Submit Update</button>
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
