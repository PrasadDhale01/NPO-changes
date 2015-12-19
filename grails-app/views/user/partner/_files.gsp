<g:if test="${folderName}">
    <div class="folderdirectory">
        <span><a href="#files" data-toggle="tab" class="active tab-data-toggle doc-tab-files">My Folder</a></span><span>&nbsp; -> &nbsp;</span> <span class="folderName-span"> ${folderName}</span>
    </div>
</g:if>

<g:if test="${!files.empty}">
    <%
        def index = 0
        def partnerId
        def folderId
        if (partner) {
            partnerId = partner.id
        }
        if (folder) {
            folderId = folder.id
        }
    %>
    
    <div class="folderlist">
        <g:each in="${files}" var="file">
            <%
                def trashUrl = baseUrl+'/user/trashdocfile?id='+file.id+'&partnerId='+partnerId+'&folderId='+folderId
            %>
            <div class="col-sm-4 col-md-3 col-lg-3 col-xs-6 text-center file-thumbnail-div">
                <div class="file-thumbnail-container" data-trashurl="${trashUrl}">
                    <div class="file-thumbnail">
                        <span class="glyphicon glyphicon-file"></span>
                    </div>
                    <div class="fileName-text" data-url="${file.docUrl}">
                        ${file.docName}
                    </div>
                </div>
            </div>
        </g:each>
    </div>
</g:if>
<g:else>
    <div class="alert alert-info text-center">
        This folder is empty. Click add button to upload the documents.
    </div>
</g:else>
<script>
    $('.folderdirectory').find('.tab-data-toggle').click(function() {
        $('#viewfolder').hide();
        $('.doc-tab-files').addClass('active');
        $('#folderId').val('');
        $('.folderlist').find('.folder').removeClass('active');
        $('#remove-folder').val('');
        $('.trash-docs-fixed-btn').hide();
    });

    $("#doc-files-list, #folder-file-list").find('.doc-file-trash a').click(function(event) {
        event.preventDefault();
        if (confirm('Are you sure you want to discard this file?')) {
            var url = $(this).attr('href');
            var grid = $(this).parents('#driveFiles');
            var folderId = $('#folderId').val();

            $.ajax({
                type: 'GET',
                url: url,
                success: function(data) {
                    $(grid).fadeOut('fast', function() {$(this).html(data).fadeIn('fast');});
                    if (folderId) {
                        var driveFileGrid = $('#viewfolder');
                        $(driveFileGrid).fadeOut('fast', function() {$(this).html(data).fadeIn('fast');});
                    } else {
                        var driveFileGrid = $('#docFiles');
                        $(driveFileGrid).fadeOut('fast', function() {$(this).html(data).fadeIn('fast');});
                    }
                }
            });
        }
    });

    $('.file-thumbnail-container').dblclick(function(event){
    	var url = $(this).find('.fileName-text').data('url');
    	$('.file-thumbnail-container').removeClass('active');
    	$('#remove-file').val('');
    	$('.trash-file-fixed-btn').show();
    	window.open(url, '_blank');
    });

    $('.file-thumbnail-container').click(function(event){
        var trashUrl = $(this).data('trashurl');
        
        $('.file-thumbnail-container').removeClass('active');
        $('.folderlist').find('.folder').removeClass('active');
        $('#remove-folder').val('');
        $('.trash-docs-fixed-btn').hide();
        $('#remove-file').val(trashUrl);
        $('.trash-file-fixed-btn').show();
        $(this).addClass('active');
    });
</script>
