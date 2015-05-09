<%
    def baseUrl = grailsApplication.config.crowdera.BASE_URL
    def projectId = project.id
%>
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
        <h1><img class="img-circle" src="//s3.amazonaws.com/crowdera/assets/icon-edit.png" alt="Edit Campaign"/> Edit Campaign Update</h1>
        <g:uploadForm class="form-horizontal" controller="project" action="saveEditUpdate" method="post" role="form" id="${projectUpdate.id}" params="['projectId': projectId]">
            <input type="hidden" id="baseUrl" value="${baseUrl}"/>
            <div class="panel panel-default">
	            <div class="panel-heading">
					<h3 class="panel-title">Story and Images</h3>
				</div>
		        <div class="panel-body">
		            <div class="form-group">
						<label class="col-sm-2 control-label">Story</label>
						<div class="col-sm-10">
							<textarea name="${FORMCONSTANTS.STORY}" id="${FORMCONSTANTS.STORY}" class="mceEditor">${projectUpdate.story}</textarea>
					    </div>
					</div><br/>
					
                    <div class="form-group">
                        <label class="col-sm-2 control-label">Pictures</label>
                        <div class="col-sm-2">
                            <div class="fileUpload btn btn-primary btn-sm">
 					            <span>Add Images</span>
                                <input type="file" name="${FORMCONSTANTS.THUMBNAIL}[]" id="projectUpdateImageFile" class="upload" accept="image/jpeg, image/png" multiple>
                            </div>
                            <label class="docfile-orglogo-css" id="editUpdateimg">Please select image file.</label>
                            <label class="docfile-orglogo-css" id="campaignUpdatefilesize"></label>
                        </div>
                        <div class="col-sm-8">
                            <g:each var="imageUrl" in="${projectUpdate.imageUrls}">
                                <div id="imagediv" class="pr-thumb-div">
                                    <img alt="image" class='pr-thumbnail' src='${imageUrl.url}' id="imgThumb${imageUrl.id}"/>
                                    <div class="deleteicon pictures-edit-deleteicon">
                                        <img alt="cross" onClick="deleteProjectImage(this,'${imageUrl.id}','${projectUpdate.id}');" value='${imageUrl.id}' src="//s3.amazonaws.com/crowdera/assets/delete.ico" id="imageDelete"/>
                                    </div>
                                </div>
                            </g:each>
                            <script>
                                function deleteProjectImage(current, imageId, projectUpdateId) {
                                    $(current).parents('#imagediv').remove();
                                    $.ajax({
                                        type:'post',
                                        url:$("#baseUrl").val()+'/project/deleteProjectUpdateImage',
                                        data:'imageId='+imageId+'&projectUpdateId='+projectUpdateId,
                                        success: function(data){
                                            $('#test').html(data);
                                        }
                                    }).error(function(){
                                        alert('An error occured');
                                    });
                                }
                            </script>
                            <output id="imageresult"></output>
                            <div id="test"></div>
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
                        <label class="col-sm-2 control-label">Save Changes</label>
                        <div class="col-sm-2-offset col-sm-4">
                            <button type="submit" class="btn btn-primary btn-sm updatesubmitbutton" name="button" id="updatesubmitbutton">Submit Update</button>
                        </div>
                    </div>
                </div>
            </div>
        </g:uploadForm>
    </div>
</div>
</body>
</html>
