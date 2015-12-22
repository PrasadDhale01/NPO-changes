<g:if test="${!folders.empty}">
    <div class="folderlist">
        <g:each in="${folders}" var="folder">
            <div class="col-md-3 col-sm-4">
                <div class="folder" id="${folder.id}">
                    <div class="folderName"><span class="glyphicon glyphicon-folder-close"></span>&nbsp;&nbsp; ${folder.fName}</div>
                </div>
            </div>
        </g:each>
    </div>
    <script>
    $('.folderlist').find('.folder').dblclick(function(event){
        if($('#createNewFolder').find('form').valid()){
            $('#createNewFolder').modal("hide");
            var id = $(this).attr('id');
            var userId = $('#userId').val();
            var driveFileGrid = $('#viewfolder');
            var baseUrl = $('#baseUrl').val();
            var loadFilesUrl = baseUrl+'/user/loadFolder?userId='+userId+'&id='+id;
            $.ajax({
                type: 'GET',
                url: loadFilesUrl,
                success: function(data) {
                    
                    $(driveFileGrid).fadeOut('fast', function() {$(this).html(data).fadeIn('fast');});
                    $('.nav-tab-doc').find('.tab-data-toggle').removeClass('active');
                    
                    $('#partner-doc-content').find('.tab-pane').removeClass('active');
                    $('#viewfolder').addClass('active');
                    $('#folderId').val(id);
                }
            });
        }
    });
    $('.folderlist').find('.folder').click(function(event){
    	$('#remove-file').val('');
        $('.trash-file-fixed-btn').hide();
        $('.folderlist').find('.folder').removeClass('active');
        $('.file-thumbnail-container').removeClass('active');
        $(this).addClass('active');
        var id = $(this).attr('id');
        $('.trash-docs-fixed-btn').show();
        $('#remove-folder').val(id);
    });
    </script>
</g:if>
