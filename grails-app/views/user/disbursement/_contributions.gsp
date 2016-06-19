<!-- Author Krishna -->

<h2 class="text-center"><b>Contribution List</b></h2>

<div class="table table-responsive">
    <table class="table table-bordered" id="contributionslist">
        <thead>
        <tr class="">
            <th class="col-sm-1">SR NO</th>
            <th class="col-sm-2 text-center">CONTRIBUTOR_NAME</th>
            <th class="col-sm-2 text-center">CONTRIBUTOR_EMAIL</th>
            <th class="col-sm-1 text-center">AMOUNT</th>
            <th class="col-sm-1 text-center">DATE</th>
            <th class="col-sm-1 text-center">SPLIT_ID</th>
            <th class="col-sm-2 text-center">SPLIT_REFERENCE</th>
            <th class="col-sm-2 text-center">MERCHANT_TRANSACTION_ID</th>
            <th class="col-sm-1 text-center">DISBURSE</th>
        </tr>
        </thead>
        <tbody>
            <% 
                int index = 1;
            %>
            <g:each var="contribution" in="${contributions}">
            <tr>
                <td class="text-center col-sm-1">${index++}</td>
                <td class="text-center col-sm-2"> ${contribution.contributorName}</td>
                <td class="text-center col-sm-2"> ${contribution.contributorEmail}</td>
                <td class="text-center col-sm-1">
                    <g:if test="${contribution.amount != null}">
                        ${contribution.amount.round()}
                    </g:if>
                </td>
                <td class="text-center col-sm-1"></td>
                <td class="text-center col-sm-1"> ${contribution.splitId} </td>
                <td class="text-center col-sm-1"> ${contribution.splitRef} </td>
                <td class="text-center col-sm-2"> ${contribution.merchantTxId} </td>
                
                <td class="text-center col-sm-1"> 
                    <g:link action="paymentDisburse" controller="user" class="btn btn-primary btn-xs">Disburse</g:link>
                </td>
                
            </tr>
            </g:each>
            
        </tbody>
    </table>
</div>

<div class="panel panel-default margin_top">
    <div class="panel-heading">
        Check Campaign Owner Account Balance (Seller Account Balance)
    </div>
    <div class="panel-body">
        <div class="col-sm-2">
            <button class="btn btn-sm btn-primary checkbalance">Check Balance Amount</button>
        </div>
        <div class="col-sm-4">
            <div class="form-group">
                <input type="text" class="form-control" id="selleramount" readonly>
                <input type="hidden" name="sellerId" id="sellerId" value="${sellerId}"/>
            </div>
        </div>
    </div>
</div>

<script type="text/javascript">
	$('#contributionslist').DataTable({
		"iDisplayLength": 5,
	    "aLengthMenu": [[5, 10, 25, 50, -1], [5, 10, 25, 50, "All"]]
	});

	$('.checkbalance').click(function() {
		var url = "/fund/getSellerAccountBalance"
        
        $.ajax({
            type: 'POST',
            url: url,
            data: 'sellerId='+ $('#sellerId').val(),
            success: function(data) {
                $('#selleramount').val(data);
                alert(data);
            }
        });
	});
</script>
