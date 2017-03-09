<g:set var="projectService" bean="projectService"/>
<%
    def fullName
    def branch
    def ifscCode
    def accountType
    def accountNumber
    String email
    String mobile
    String address1
    String address2
    String city
    String state
    String country
    String zip
    String payoutmode
    
    if (bankInfo) {
        fullName = bankInfo.fullName
        branch = bankInfo.branch
        ifscCode = bankInfo.ifscCode
        accountType = bankInfo.accountType
        accountNumber = bankInfo.accountNumber
        email = bankInfo.email
        mobile = bankInfo.mobile
        address1 = bankInfo.address1
        address2 = bankInfo.address2
        city = bankInfo.city
        state = bankInfo.state
        country = bankInfo.country
        zip = bankInfo.zip
        payoutmode = bankInfo.payoutmode
        
    }
    if (email == null) {
        email = project.citrusEmail
    }
    def indianStates = projectService.getIndianState()
	
	String paymentStatus = ""
	if (project.validated) {
		paymentStatus = "readonly"
	}
%>

<div class="col-xs-12" id="paymentInfo">
    <div class="col-sm-6 col-md-6 col-lg-6 col-xs-12">
        <div class="form-group">
            <input type="text" id="citrusBeneficiaryname" class="form-control" name="citrusBeneficiaryname" value="${fullName}" title="Citrus Beneficiary Name" placeholder="Citrus Beneficiary Name" maxlength="64" ${paymentStatus}>
        </div>
    </div>
    <div class="col-sm-6 col-md-6 col-lg-6 col-xs-12">
        <div class="form-group">
            <input type="text" class="form-control" name="${FORMCONSTANTS.CITRUSEMAIL}" id="citrusemail" value="${email}" placeholder="Citrus Email" maxlength="32" title="Citrus Email" ${paymentStatus}>
        </div>
    </div>
    <div class="col-sm-6 col-md-6 col-lg-6 col-xs-12">
        <div class="form-group">
            <input type="text" id="citrusBankBranch" class="form-control" name="citrusBankBranch" value="${branch}" placeholder="Bank branch" maxlength="64" title="Bank Branch" ${paymentStatus}>
        </div>
    </div>
    <div class="col-sm-6 col-md-6 col-lg-6 col-xs-12">
        <div class="form-group">
            <input type="text" id="citrusIfscCode" class="form-control" name="citrusIfscCode" value="${ifscCode}" placeholder="IFSC code" maxlength="11" title="IFSC code" ${paymentStatus}>
        </div>
    </div>
    <div class="col-sm-6 col-md-6 col-lg-6 col-xs-12">
        <div class="form-group">
            <input type="text" id="citrusAccountType" class="form-control" name="citrusAccountType" value="${accountType}" placeholder="Account type" maxlength="20" title="Account type" ${paymentStatus}>
        </div>
    </div>
    <div class="col-sm-6 col-md-6 col-lg-6 col-xs-12">
        <div class="form-group">
            <input type="text" id="citrusAccountNumber" class="form-control" name="citrusAccountNumber" value="${accountNumber}" placeholder="Account number" maxlength="35" title="Account number" ${paymentStatus}>
        </div>
    </div>
    <div class="col-sm-6 col-md-6 col-lg-6 col-xs-12">
        <g:if test="${payoutmode}">
	        <div class="form-group">
                <input type="text" id="payoutmode" class="form-control" name="payoutmode" value="${payoutmode}" placeholder="Payoutmode" title="Payout Mode" readonly>
            </div>
        </g:if>
        <g:else>
            <div class="form-group">
                <input type="text" id="payoutmode" class="form-control" name="payoutmode" value="WALLET" placeholder="Payoutmode" title="Payout Mode" readonly>
            </div>
        </g:else>
    </div>
    <div class="col-sm-6 col-md-6 col-lg-6 col-xs-12">
        <div class="form-group">
            <input type="text" class="form-control" name="citrusMobile" id="citrusMobile" value="${mobile}" placeholder="Mobile Number" maxlength="10" title="Mobile Number" ${paymentStatus}>
        </div>
    </div>
    <div class="col-sm-6 col-md-6 col-lg-6 col-xs-12">
        <div class="form-group">
            <input type="text" class="form-control" name="citrusAddress1" id="citrusAddress1" value="${address1}" placeholder="Address Line 1" maxlength="64" title="Citrus Address Line1" ${paymentStatus}>
        </div>
    </div>
    <div class="col-sm-6 col-md-6 col-lg-6 col-xs-12">
        <div class="form-group">
            <input type="text" class="form-control" name="citrusAddress2" id="citrusAddress2" value="${address2}" placeholder="Address Line 2" maxlength="64" title="Citrus Address Line2" ${paymentStatus}>
        </div>
    </div>
    <div class="col-sm-6 col-md-6 col-lg-6 col-xs-12">
        <div class="form-group">
            <input type="text" class="form-control" name="citrusCity" id="citrusCity" value="${city}" placeholder="City" maxlength="64" title="Citrus City" ${paymentStatus}>
        </div>
    </div>
    <div class="col-sm-6 col-md-6 col-lg-6 col-xs-12">
        <div class="form-group">
            <input type="text" class="form-control" name="citrusZip" id="citrusZip" value="${zip}" placeholder="Zip" maxlength="8" title="Citrus Zip" ${paymentStatus}>
        </div>
    </div>
    <div class="col-sm-6 col-md-6 col-lg-6 col-xs-12">
        <div class="form-group" id="indianStates">
            <g:select class="indianstate selectpicker" name="citrusState" id="citrusState" from="${indianStates}" value="${state}" optionKey="key" optionValue="value" noSelection="['null':'State']" />
        </div>
    </div>
    <div class="col-sm-6 col-md-6 col-lg-6 col-xs-12">
        <div class="form-group">
            <input type="text" class="form-control" name="citrusCountry" id="citrusCountry" value="India" placeholder="Country" title="Citrus Country" readonly>
        </div>
    </div>
    
</div>