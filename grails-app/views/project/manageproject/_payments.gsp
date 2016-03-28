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
    
    if (bankInfo ) {
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
%>

<g:if test="${project.citrusEmail}">
<br/>
<div class="col-xs-12" id="paymentInfo">
	<g:form action="paymentInfo" controller="user" params="['projectTitle':vanityTitle]">
	    <div class="col-sm-6 col-md-6 col-lg-6 col-xs-12">
	        <div class="form-group">
	            <input type="text" id="beneficiaryname" class="form-control" name="fullName" value="${fullName}" placeholder="Beneficiary Name">
	        </div>
	        <div class="form-group">
	            <input type="text" class="form-control" name="email" value="${email}" placeholder="Beneficiary Email" readonly>
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
	        <div class="form-group">
	            <input type="text" id="payoutmode" class="form-control" name="payoutmode" value="${payoutmode}" placeholder="Payoutmode">
	        </div>
	    </div>
	    <div class="col-sm-6 col-md-6 col-lg-6 col-xs-12">
	        <div class="form-group">
	            <input type="text" class="form-control" name="mobile" value="${mobile}" placeholder="Mobile Number">
	        </div>
	        <div class="form-group">
	            <input type="text" class="form-control" name="address1" value="${address1}" placeholder="Address Line 1">
	        </div>
	        <div class="form-group">
	            <input type="text" class="form-control" name="address2" value="${address2}" placeholder="Address Line 2">
	        </div>
	        <div class="form-group">
	            <input type="text" class="form-control" name="city" value="${city}" placeholder="City">
	        </div>
	        <div class="form-group">
	            <input type="text" class="form-control" name="zip" value="${zip}" placeholder="Zip">
	        </div>
	        <div class="form-group" id="indianStates">
	            <g:select class="indianstate selectpicker" id="state" name="state" from="${indianStates}" value="${state}" optionKey="key" optionValue="value" noSelection="['null':'State']"/>
	        </div>
	        <div class="form-group">
	            <input type="text" class="form-control" name="country" value="India" placeholder="Country" readonly>
	        </div>
	    </div>
	    <div class="clear"></div>
	    <div class="col-xs-12">
	        <button class="btn btn-md btn-primary pull-right" type="submit">Save</button>
	    </div>
	</g:form>
</div>
</g:if>
<g:else>
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
</g:else>
