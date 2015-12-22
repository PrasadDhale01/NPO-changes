<g:if test="${files.size() > 0}">
<%
    def indexcount = offset ? Integer.parseInt(offset) : 0
    def count = files.size()
    def index = 0
    def userId = user.id
%>
<g:if test="${isSelected}">
    <div class="alert alert-info text-center" id="drive-file-already-selected">
        This file has been already selected.
    </div>
</g:if>
<div class="folderlist">
    <g:each in="${files}" var="file">
        <%
            def trashUrl = baseUrl+'/user/trashdrivefile?id='+file.id+'&userId='+user.id
        %>
        <div class="col-sm-4 col-md-3 col-lg-3 col-xs-6 text-center file-thumbnail-div">
            <div class="file-thumbnail-container" data-trashurl="${trashUrl}">
                <div class="file-thumbnail">
                    <span class="glyphicon glyphicon-file"></span>
                </div>
                <div class="fileName-text" data-url="${file.alternateLink}">
                    ${file.title}
                </div>
            </div>
        </div>
    </g:each>
</div>
<div class="clear"></div>
<div class="filespaginate">
    <g:paginate controller="user" max="8" maxsteps="6" action="loadDriveFiles" params="['userId': userId]" total="${totalFiles.size()}"/>
</div>
<script>
    $("#driveFiles").find('.filespaginate a').click(function(event) {
        event.preventDefault();
        var url = $(this).attr('href');
        var grid = $(this).parents('#driveFiles');

        $.ajax({
            type: 'GET',
            url: url,
            success: function(data) {
                $(grid).fadeOut('fast', function() {$(this).html(data).fadeIn('fast');});
            }
        });
    });

    $("#driveFiles").find('.drivetrash a').click(function(event) {
        event.preventDefault();
        if (confirm("Don't worry this file will be discarded from dashboard not from google drive. Are you sure you want to discard this file?")) {
            var url = $(this).attr('href');
            var grid = $(this).parents('#driveFiles');

            $.ajax({
                type: 'GET',
                url: url,
                success: function(data) {
                    $(grid).fadeOut('fast', function() {$(this).html(data).fadeIn('fast');});
                }
            });
        }
    });

    $('.file-thumbnail-container').dblclick(function(event){
        var url = $(this).find('.fileName-text').data('url');
        $('.file-thumbnail-container').removeClass('active');
        $('#remove-drive-file').val('');
        $('.trash-drivefile-fixed-btn').hide();
        window.open(url, '_blank');
    });

    $('.file-thumbnail-container').click(function(event){
        var trashUrl = $(this).data('trashurl');
        
        $('.file-thumbnail-container').removeClass('active');
        $('.trash-docs-fixed-btn').hide();
        
        $('.trash-drivefile-fixed-btn').show();
        $('#remove-drive-file').val(trashUrl);
        $(this).addClass('active');
    });

    $('#drive-file-already-selected').fadeOut(5000);
</script>
</g:if>
<g:else>
    <div class="alert alert-info text-center">
        You can load files from google drive.
    </div>
</g:else>
