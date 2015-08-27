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
                <div class="row">
                    <div class="text-center">
                        <h1 class="hidden-xs"><img class="img-circle" src="//s3.amazonaws.com/crowdera/assets/icon-edit.png" alt="Edit Campaign"/> Campaign Update</h1>
                        <h3 class="hidden-sm hidden-md hidden-lg"><img class="img-circle" src="//s3.amazonaws.com/crowdera/assets/icon-edit.png" alt="Edit Campaign"/> Campaign Update</h3>
                    </div><br/>
                    <div class="clear"></div>
                    <div class="form-group">
                        <label class="col-sm-1 control-label"><b>Title</b></label>
                        <div class="col-sm-10">
                            <input class="form-control" name="${FORMCONSTANTS.TITLE}" id="${FORMCONSTANTS.TITLE}" />
                        </div>
                    </div><br/>
                    <div class="form-group">
                        <label class="col-sm-1 control-label"><b>Story</b></label>
                        <div class="col-sm-10 TW-update-redactor">
                            <textarea name="${FORMCONSTANTS.STORY}" id="${FORMCONSTANTS.STORY}" class="redactorEditor">
                            ${initialValue}</textarea>
                            <span id="storyRequired">Ths field is required</span>
                        </div>
                    </div><br/>
                    <div class="clear"></div>
                    <div class="form-group">
                        <label class="col-sm-1 control-label"><b>Pictures</b></label>
                        <div class="col-sm-2">
                            <button class="btn btn-primary btn-sm" type="button" id="addProjectImage">Add Image&nbsp;<span class="fa fa-plus-circle"></span></button>
                            <input type="file" class="hid-input-type-file" name="${FORMCONSTANTS.THUMBNAIL}[]" id="updateImageFile" multiple="multiple" accept="image/jpeg, image/png">
                            <label class="show-update-select" id="imgupdatemsg">Select image file.</label>
                            <label class="docfile-orglogo-css" id="updatefilesize"></label>
                        </div>
                        <div class="col-sm-9">
                        <output id="result"></output>
                    </div>
                </div>
   
                <div class="col-sm-offset-4 col-sm-4 col-md-offset-4 col-md-4 col-xs-offset-2 col-xs-8 updatesubmitbtn">
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
            plugins: ['video'],
            buttonsHide: ['indent', 'outdent', 'horizontalrule']
        });
    });
</g:javascript>
</div>
</body>
</html>
