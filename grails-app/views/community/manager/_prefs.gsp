<div class="panel panel-default">
    <div class="panel-heading">
        <h3 class="panel-title"><i class="fa fa-cogs"></i> Preferences</h3>
    </div>
    <div class="panel-body">

        <g:form id="suggestedcreditamount" class="form-horizontal" action="updateSuggestedCredit" role="form">
            <g:hiddenField name="communityId" value="${community.id}"/>

            <div class="row">
                <div class="col-md-12">
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
                </div>
            </div>
        </g:form>
    </div>
</div>
