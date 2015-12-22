<%
    def request_url=request.getRequestURL().substring(0,request.getRequestURL().indexOf("/", 8))
    def base_url = (request_url.contains('www')) ? grailsApplication.config.crowdera.BASE_URL1 : grailsApplication.config.crowdera.BASE_URL
    def projectId = project.id
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
            <div class="text-center">
                <h1 class="hidden-xs"><img class="img-circle" src="//s3.amazonaws.com/crowdera/assets/icon-edit.png" alt="Edit Campaign"/> Edit Campaign Update</h1>
                <h3 class="hidden-sm hidden-md hidden-lg"><img class="img-circle" src="//s3.amazonaws.com/crowdera/assets/icon-edit.png" alt="Edit Campaign"/> Edit Campaign Update</h3>
            </div><br/>
            <div class="clear"></div>
            
            <g:uploadForm class="form-horizontal editForm" controller="project" action="saveEditUpdate" method="post" role="form" id="${projectUpdate.id}" params="['projectId': projectId]">
                <input type="hidden" id="baseUrl" value="${baseUrl}">
                <g:hiddenField name="projectUpdateId" value="${projectUpdate.id}"/>
                
                <div class="form-group">
                    <label class="col-sm-1 col-md-1 control-label"><b>Title</b></label>
                    <div class="col-sm-10 col-md-10">
                        <input class="form-control manage-title-editupdate" name="${FORMCONSTANTS.TITLE}" id="${FORMCONSTANTS.TITLE}" value="${projectUpdate.title}">
                    </div>
                </div><br/>
                <div class="form-group">
                    <label class="col-sm-1 col-md-1 control-label"><b>Story</b></label>
                    <div class="col-sm-10 col-md-10 TW-editUpdate-redactor">
                        <textarea name="${FORMCONSTANTS.STORY}" id="${FORMCONSTANTS.STORY}" class="redactorEditor">${projectUpdate.story}</textarea>
                        <span id="storyRequired">Ths field is required</span>
                    </div>
                </div><br/>
                <div class="clear"></div>
                
                <div class="form-group">
                    <label class="col-sm-1 col-md-1 control-label"><b>Pictures</b></label>
                    <div class="col-sm-2 col-md-2 col-xs-12">
                        <div class="fileUpload btn btn-primary btn-sm">
                            <span>Add Images</span>
                            <input type="file" name="${FORMCONSTANTS.THUMBNAIL}[]" id="projectUpdateImageFile" class="upload" accept="image/jpeg, image/png">
                        </div>
                    </div>
                    <div class="col-md-9 col-sm-9 col-xs-12">
                        <div id="uploadingUpdateEditImage">Uploading Picture......</div>
                    </div>
                    <div class="clear"></div>
                    <div class="col-md-offset-1 col-md-11 col-sm-11 col-sm-offset-1 col-xs-12" id="projectUpdatemessageDiv">
                        <label class="docfile-orglogo-css" id="editUpdateimg">Please select image file.</label>
                        <label class="docfile-orglogo-css" id="campaignUpdatefilesize"></label>
                    </div>
                    <div class="col-md-offset-1 col-md-11 col-sm-11 col-sm-offset-1 col-xs-12" id="projectUpdateImageDiv">
                        <g:each var="imageUrl" in="${projectUpdate.imageUrls}">
                            <div id="imagediv" class="pr-thumb-div">
                                <img alt="image" class='pr-thumbnail' src='${imageUrl.url}' id="imgThumb${imageUrl.id}">
                                <div class="deleteicon pictures-edit-deleteicon">
                                    <img alt="cross" onClick="deleteProjectImage(this,'${imageUrl.id}','${projectUpdate.id}');" src="//s3.amazonaws.com/crowdera/assets/delete.ico">
                                </div>
                            </div>
                        </g:each>
                        <script>
                            function deleteProjectImage(current, imageId, projectUpdateId) {
                                $.ajax({
                                    type:'post',
                                    url:$("#baseUrl").val()+'/project/deleteProjectUpdateImage',
                                    data:'imageId='+imageId+'&projectUpdateId='+projectUpdateId,
                                    success: function(data){
                                    	$(current).parents('#imagediv').remove();
                                    }
                                }).error(function(){
                                    console.log('cannot delete campaign update image');
                                });
                             }
                        </script>
                    </div>
                </div>
                <div class="form-group">
                    <div class="col-sm-offset-4 col-sm-4 col-md-offset-4 col-md-4 col-xs-8 mange-editupdate-btns updatesubmitbtn">
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
        function confirmExit()
        {
            if(needToConfirm){
                return "You have attempted to leave this page.  If you have made any changes to the fields without clicking the Save button, your changes will be lost.  Are you sure you want to exit this page?";
            }
        }
    </script>
    <g:javascript>
        $(function() {
            $('.redactorEditor').redactor({
                imageUpload:'/project/getRedactorImage',
                plugins: ['video','fontsize', 'fontfamily', 'fontcolor'],
                imageResizable: true,
                buttonsHide: ['indent', 'outdent', 'horizontalrule', 'deleted']
            });
        });
</g:javascript>
</div>
</body>
</html>
