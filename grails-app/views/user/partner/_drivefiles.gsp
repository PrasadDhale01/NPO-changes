<%
    def indexcount = offset ? Integer.parseInt(offset) : 0
    def count = files.size()
    def index = 0
    def userId = user.id
%>
<div class="table table-responsive table-xs-left">
    <table class="table table-bordered">
        <thead>
            <tr class="alert alert-title ">
                <th class="col-sm-1">Sr. No.</th>
                <th class="col-sm-8">Title</th>
                <th class="col-sm-2">Explore</th>
                <th class="col-sm-1">Trash</th>
            </tr>
        </thead>
        <tbody>
            <% while(index < count) { %>
                <g:render template="/user/partner/filelist" model="['file': files.get(index++), index: ++indexcount]"></g:render>
            <% } %>
        </tbody>
    </table>
</div>
<div class="clear"></div>
<div class="filespaginate">
    <g:paginate controller="user" max="10" maxsteps="6" action="loadDriveFiles" params="['userId': userId]" total="${totalFiles.size()}"/>
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
        if (confirm('Are you sure you want to discard this file?')) {
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
</script>
