<%
    def request_url=request.getRequestURL().substring(0,request.getRequestURL().indexOf("/", 8))
    def base_url = (request_url.contains('www')) ? grailsApplication.config.crowdera.BASE_URL1 : grailsApplication.config.crowdera.BASE_URL
%>
<html>
<head>
	<meta name="layout" content="main" />
	<r:require modules="projecteditjs"/>
</head>
<body>
<div class="bg-color">
    <div class="feducontent">
        <div class="container editUpdateForm campaignUpdateContainer">
            <g:uploadForm class="form-horizontal editForm" controller="project" action="updatesave" id="${project.id}" role="form">
                <input type="hidden" id="baseUrl" value="${baseUrl}">
                <div class="row">
                    <div class="text-center">
                        <h1 class="hidden-xs"><img class="img-circle" src="//s3.amazonaws.com/crowdera/assets/icon-edit.png" alt="Edit Campaign"/> Campaign Update</h1>
                        <h3 class="hidden-sm hidden-md hidden-lg"><img class="img-circle" src="//s3.amazonaws.com/crowdera/assets/icon-edit.png" alt="Edit Campaign"/> Campaign Update</h3>
                    </div><br/>
                    <div class="clear"></div>
                    <div class="form-group">
                        <label class="col-sm-1 control-label"><b>Title</b></label>
                        <div class="col-sm-10">
                            <input class="form-control manage-mobile-title" name="${FORMCONSTANTS.TITLE}" id="${FORMCONSTANTS.TITLE}">
                        </div>
                    </div><br/>
                    <div class="form-group">
                        <label class="col-sm-1 control-label"><b>Story</b></label>
                        <div class="col-sm-10 TW-update-redactor">
                            <textarea name="${FORMCONSTANTS.STORY}" id="${FORMCONSTANTS.STORY}" class="redactorEditor">
                            ${initialValue}</textarea>
                            <span id="storyRequired">This field is required</span>
                        </div>
                    </div><br/>
                    <div class="clear"></div>
                    <div class="form-group">
                        <label class="col-sm-1 col-md-1 control-label"><b>Pictures</b></label>
                        <div class="col-sm-2 col-md-2 col-xs-12">
                            <div class="fileUpload btn btn-primary btn-sm">
                                <span>Add Images</span>
                                <input type="file" name="${FORMCONSTANTS.THUMBNAIL}[]" id="updateImageFile" class="upload" accept="image/jpeg, image/png">
                            </div>
                        </div>
                        <div class="col-md-9 col-sm-9 col-xs-12">
                            <div id="uploadingUpdateImage">Uploading Picture......</div>
                        </div>
                        <div class="clear"></div>
                        <div class="col-md-offset-1 col-md-11 col-sm-11 col-sm-offset-1 col-xs-12" id="projectUpdatemessageDiv">
                            <label class="show-update-select" id="imgupdatemsg">Select image file.</label>
                            <label class="docfile-orglogo-css" id="updatefilesize"></label>
                        </div>
                        <div class="col-md-offset-1 col-md-11 col-sm-11 col-sm-offset-1 col-xs-10 mange-update-mobilepic" id="projectUpdateImageDiv">
                            <script>
                            function deleteProjectUpdateImage(current, imageUrl) {
                            	$(current).parents('#imgdiv').remove();
                            	var imageList = [];
                            	var imageLists = $('#imageList').val();
                            	if ($('#imageList').val()) {
                        	        var result = imageLists.split(",");
                                    for(var i = 0;i < result.length;i++) {
                                        if ((result[i]) != imageUrl) {
                                	        imageList.push((result[i]));
                                        }
                                    }
                                    $('#imageList').val(imageList);
                            	}
                            }
                            </script>
                        </div>
                        <g:hiddenField name="imageList" id="imageList"/>
                    </div>
   
                <div class="col-sm-offset-4 col-sm-4 col-md-offset-4 col-md-4 col-xs-8 mange-update-btns updatesubmitbtn">
                    <button type="submit" class="btn btn-primary updatesubmitbutton hidden-xs" name="button" id="updatesubmitbutton"></button>
                    <button type="submit" class="btn btn-primary updatesubmitbuttonXS visible-xs" name="button" id="updatesubmitbuttonXS"></button>
                </div>

            </div>
        </g:uploadForm>
    </div>
</div>
<script>
    var needToConfirm = true;
    window.onbeforeunload = confirmExit;
    function confirmExit() {
        if(needToConfirm){
            return "You have attempted to leave this page.  If you have made any changes to the fields without clicking the Save button, your changes will be lost.  Are you sure you want to exit this page?";
        }
    }
</script>
   <g:javascript>
    $(function() {
        $('.redactorEditor').redactor({
            imageUpload:'/project/getRedactorImage',
            imageResizable: true,
            plugins: ['video','fontsize', 'fontfamily', 'fontcolor'],
            buttonsHide: ['indent', 'outdent', 'horizontalrule', 'deleted']
        });
    });
</g:javascript>
</div>
</body>
</html>
