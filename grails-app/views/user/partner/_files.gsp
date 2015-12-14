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
    <div class="table table-responsive table-xs-left" class="doc-files-list" id="<g:if test="${folder}">folder-file-list</g:if><g:else>doc-files-list</g:else>">
        <table class="table table-bordered">
            <thead>
                <tr class="alert alert-title">
                    <th>Sr. No.</th>
                    <th class="col-sm-8">Name</th>
                    <th class="col-sm-2">Download</th>
                    <th class="col-sm-1">Trash</th>
                </tr>
            </thead>
            <tbody>
                <g:each in="${files}" var="file">
                    <%
                        def trashUrl = baseUrl+'/user/trashdocfile?id='+file.id+'&partnerId='+partnerId+'&folderId='+folderId
                    %>
                    <tr>
                        <td class="col-sm-1">${++index}</td>
                        <td class="col-sm-8"><g:if test="${file.docName}">${file.docName}</g:if><g:else>Untitled</g:else></td>
                        <td class="col-sm-2"><a href="${file.docUrl}" target="_self">Download</a></td>
                        <td class="col-sm-1 text-center doc-file-trash"><a href="${trashUrl}"><i class="glyphicon glyphicon-trash"></i></a></td>
                    </tr>
                </g:each>
            </tbody>
        </table>
    </div>
</g:if>
<g:elseif test="${folderName}">
    <div class="alert alert-info text-center">
        This folder is empty. Click upload to upload the documents.
    </div>
</g:elseif>
<script>
    $('.folderdirectory').find('.tab-data-toggle').click(function() {
        $('#viewfolder').hide();
        $('.doc-tab-files').addClass('active');
        $('#folderId').val('');
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
</script>
