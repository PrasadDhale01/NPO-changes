<%
   def count = contribution.size()
   def index = 0
   def indexcount = offset ? Integer.parseInt(offset) : 0
%>
<div class="table table-responsive table-xs-left">
    <table class="table table-bordered">
        <thead>
            <tr class="alert alert-title ">
                <th class="text-center col-sm-1">Sr. No.</th>
                <th class="text-center col-sm-2">Contribution Date & Time</th>
                <th class="text-center col-sm-3">Campaign</th>
                <th class="text-center col-sm-2">Contributor Name</th>
                <th class="text-center">Identity</th>
                <th class="text-center col-sm-2">Contributed Amount</th>
                <th class="text-center col-sm-2">Email</th>
                <th class="text-center">Mode</th>
            </tr>
        </thead>
        <tbody>
            <% while(index < count) { %>
												   <g:render template="/user/admin/transactionList" model="['contribution': contribution.get(index++), index: ++indexcount]"></g:render>
												<% } %>
        </tbody>
    </table>
</div>

<div class="pull-right transactionPaginate">
    <g:paginate controller="fund" max="10" action="transactionList" total="${totalContributions.size()}"/>
</div>
<script>
    $("#transactionInfo").find('.transactionPaginate a').click(function(event) {
        event.preventDefault();
        var url = $(this).attr('href');
        var grid = $(this).parents('#transactionInfo');

        $.ajax({
            type: 'GET',
            url: url,
            success: function(data) {
                $(grid).fadeOut('fast', function() {$(this).html(data).fadeIn('fast');});
            }
        });
    });
</script>
