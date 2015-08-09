<%
    def fullName
    def branch
    def ifscCode
    def accountType
    def accountNumber
    if (bankInfo ) {
        fullName = bankInfo.fullName
        branch = bankInfo.branch
        ifscCode = bankInfo.ifscCode
        accountType = bankInfo.accountType
        accountNumber = bankInfo.accountNumber
    }
%>
<div class="col-sm-8 col-sm-offset-2 col-md-6 col-md-offset-3 col-lg-4 col-lg-offset-4 col-xs-12" id="paymentInfo">
    <g:form action="paymentInfo" controller="user" params="['projectTitle':vanityTitle]">
        <div class="form-group">
            <input type="text" id="beneficiaryname" class="form-control" name="beneficiaryName" value="${fullName}" placeholder="Beneficiary Name">
        </div>
        <div class="form-group">
            <input type="text" id="branch" class="form-control" name="branch" value="${branch}" placeholder="Bank branch">
        </div>
        <div class="form-group">
            <input type="text" id="ifscCode" class="form-control" name="ifscCode" value="${ifscCode}" placeholder="IFSC code">
        </div>
        <div class="form-group">
            <input type="text" id="accountType" class="form-control" name="accountType" value="${accountType}" placeholder="Account type">
        </div>
        <div class="form-group">
            <input type="text" id="accountNumber" class="form-control" name="accountNumber" value="${accountNumber}" placeholder="Account number">
        </div>
        <button class="btn btn-lg btn-primary btn-block" type="submit">Save</button>
    </g:form>
</div>
