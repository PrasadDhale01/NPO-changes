<div class="panel panel-default">
    <div class="panel-heading">
        <h3 class="panel-title"><i class="fa fa-money"></i> Recent Transactions</h3>
    </div>
    <div class="panel-body">

        <g:form id="suggestedcreditamount" class="form-horizontal" action="updateSuggestedCredit" role="form">
            <g:hiddenField name="communityId" value="${community.id}"/>
            <label class="control-label">Suggested credit amount</label>
            <div class="input-group">
                <input name="${FORMCONSTANTS.SUGGESTEDCREDIT}" type="text" value="${community.suggestedCredit}" class="form-control">
                <span class="input-group-btn">
                    <button class="btn btn-default" type="submit">Update</button>
                </span>
            </div>
            <g:if test="${flash.invalidsuggestedcredit}">
                <div class="alert alert-danger top-buffer-xs">
                    Invalid suggested credit ${flash.invalidsuggestedcredit}.
                </div>
            </g:if>
        </g:form>

        <div class="table-responsive top-buffer">
            <table class="table table-bordered table-hover table-striped tablesorter">
                <thead>
                <tr>
                    <th class="header">Order #</th>
                    <th class="header">Order Date</th>
                    <th class="header">Order Time</th>
                    <th class="header">Amount (USD)</th>
                </tr>
                </thead>
                <tbody>
                <tr>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                </tr>
                <tr>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                </tr>
                <tr>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                </tr>
                <tr>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                </tr>
                <tr>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                </tr>
                <tr>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                </tr>
                <tr>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                </tr>
                <tr>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                </tr>
                <tr>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                </tr>
                <tr>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                </tr>
                </tbody>
            </table>
        </div>
        <div class="text-right">
            <a href="#">View All Transactions <i class="fa fa-arrow-circle-right"></i></a>
        </div>
    </div>
</div>
