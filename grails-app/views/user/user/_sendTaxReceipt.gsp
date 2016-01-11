<g:hiddenField name="vanityTitle" class="vanityTitle" value="${vanityTitle}"/>
<div class="search-sort-back">
<div class="col-sm-2">
	<div class="col-sm-3 col-md-5 backToTiles">&lt;&lt;&nbsp;Back</div>
</div>
<div class="col-sm-10 search-sort">
<div class="col-contributor col-xs-12">
	<div class="contributor-search-box col-sm-7 col-xs-8">
		<input type="search" class="search-contributors" placeholder="Search....">
		<span class="glyphicon glyphicon-search glyphicon-contributor-search"></span>
	</div>
	<div class="col-sm-5 col-xs-4 col-contributor-search">
	    <g:select class="selectpicker contributorsSort" value="${sort}" name="contributorsSort" from="${sortList}" optionKey="key" optionValue="value"/>
	</div>
</div>
</div>
</div><br><br><br>
<g:if test="${contributionList && totalContributions && !contributionList.empty && !totalContributions.empty}">
<%
    def count = contributionList.size()
    def index = 0
    def indexcount = offset ? offset : 0
%>
<div class="table table-responsive">
	<table class="table table-bordered">
		<thead>
			<tr class="alert alert-title">
				<th class="text-center">Sr.No</th>
				<th class="text-center">Select</th>
				<th class="col-sm-3 text-center">Name</th>
				<th class="col-sm-3 text-center">Email</th>
				<th class="text-center">Amount</th>
				<th class="text-center">Date & Time</th>
			</tr>
		</thead>
		<tbody>
			<% while(index < count) { %>
                <g:render template="/user/user/contributorsList" model="['contribution': contributionList.get(index++), index: ++indexcount]"></g:render>
			<% } %>
		</tbody>
	</table>
</div>

<div class="clear"></div>
<div class="pull-right sendTaxReceiptPaginate filespaginate">
    <g:paginate controller="user" max="10" maxsteps="5" action="sortContributorsList" params="['vanityTitle':vanityTitle, sort:sort]" total="${totalContributions.size()}"/>
</div>

<div class="clear"></div>
<div class="pull-right col-send-email">
    <button class="btn btn-primary btn-sm sendEmailToContributors">Send Email</button>
</div>

<div class="pull-right">
    <input type="button" value="Select all" class="btn btn-primary btn-sm selectAllCheckbox">
</div>

<span class="pull-right" id="selectedLength"></span>
<div id="email-send-confirmation">Email has been send to the contributors</div>
</g:if>
<g:else>
    <div class="col-sm-12">
        <br>
        <div class="alert alert-info">
            You do not have such contributions yet.
        </div>
    </div>
</g:else>

<script>
    var baseUrl = $('#baseUrl').val();

	/* Apply selectpicker to selects. */
	$('.selectpicker').selectpicker({
        style: 'btn btn-sm btn-default'
	});

	/* Pagination logic*/
	$(".send-tax-receipt-to-contributors").find('.sendTaxReceiptPaginate a').click(function(event) {
	    event.preventDefault();
	    var url = $(this).attr('href');
	    var grid = $(this).parents(".send-tax-receipt-to-contributors");
	    $.ajax({
	        type: 'GET',
	        url: url,
	        success: function(data) {
	            $(grid).fadeOut('fast', function() {$(this).html(data).fadeIn('fast');});
	        }
	    });
	});

	/*sorting contribution list*/
    $('.contributorsSort').change(function (){
        var vanityTitle = $('.vanityTitle').val();
        var grid = $(".send-tax-receipt-to-contributors");
        $.ajax({
            type: 'post',
            url:baseUrl+'/user/sortContributorsList',
            data:'vanityTitle='+vanityTitle+'&sort='+$(this).val(),
            success: function(data) {
                $(grid).fadeOut('fast', function() {$(this).html(data).fadeIn('fast');});
            }
        }).error(function(e){
           console.log('Error occured while fetching contribution list sorted by '+$(this).val());
        });
    });

    /*back to campaign tiles*/
    $('.backToTiles').click(function (){
        var grid = $(".campaignTilePaginate");
        $('#loadingfilegif').show(); 
        $.ajax({
            type: 'post',
            url:baseUrl+'/user/loadCampaignTile',
            success: function(data) {
            	$('#loadingfilegif').hide(); 
                $(grid).fadeOut('fast', function() {$(this).html(data).fadeIn('fast');});
            }
        }).error(function(e){
           console.log('Error occured while showing campaign tile for sending tax receipt');
        });
    });

	/*Search by contributor name*/
	$('.search-contributors').keypress(function (e) {
		var key = e.which;
		if(key == 13){ // the enter key code
			var vanityTitle = $('.vanityTitle').val();
			var grid = $(".send-tax-receipt-to-contributors");
			$.ajax({
				type: 'post',
				url:baseUrl+'/user/searchByName',
				data:'vanityTitle='+vanityTitle+'&query='+$(this).val(),
				success: function(data) {
				$(grid).fadeOut('fast', function() {$(this).html(data).fadeIn('fast');});
			}
			}).error(function(e){
			    console.log('Error occured while fetching contribution list sorted by '+$(this).val());
			});
		}
	});

    $('.contributor-checkbox-select').click(function(){
    	var length = $('.contributor-checkbox-select:checked').length;
    	document.getElementById("selectedLength").innerHTML= length + " selected";
    });

	$('.selectAllCheckbox').click(function (){
		if ($(this).hasClass('deSelectAllCheckbox')) {
			$('.contributor-checkbox-select').prop('checked', false);
	        document.getElementById("selectedLength").innerHTML= " ";
	        this.value = 'Select all';
	        $(this).removeClass('deSelectAllCheckbox');
		} else {
	        var length = $('.contributor-checkbox-select').length;
			$('.contributor-checkbox-select').prop('checked', true);
	        document.getElementById("selectedLength").innerHTML= length + " selected";
	        this.value = 'Deselect all';
	        $(this).addClass('deSelectAllCheckbox');
		}
	});

	$('.sendEmailToContributors').click(function(){
		var list =[];
		var vanityTitle = $('.vanityTitle').val();
		$('.contributor-checkbox-select:checked').each(function (){
			list.push(this.id);
		});

		$.ajax({
            type: 'post',
            url:baseUrl+'/user/sendTaxReceiptToContributors',
            data:'vanityTitle='+vanityTitle+'&list='+list,
            success: function(data) {
                $('#email-send-confirmation').show().fadeOut(9000);
            }
        }).error(function(e){
            console.log('Error occured while sending email to contributors');
        });

	});

</script>
