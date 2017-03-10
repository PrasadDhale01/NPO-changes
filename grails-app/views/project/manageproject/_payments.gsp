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
	            <input type="text" id="beneficiaryname" class="form-control" name="fullName" value="${fullName}" placeholder="Beneficiary Name" maxlength="30">
	        </div>
	        <div class="form-group">
	            <input type="text" class="form-control" name="email" value="${email}" placeholder="Beneficiary Email" readonly maxlength="30">
	        </div>
	        <div class="form-group">
	            <input type="text" id="branch" class="form-control" name="branch" value="${branch}" placeholder="Bank branch" maxlength="30">
	        </div>
	        <div class="form-group">
	            <input type="text" id="ifscCode" class="form-control" name="ifscCode" value="${ifscCode}" placeholder="IFSC code" maxlength="11">
	        </div>
	        <div class="form-group">
	            <input type="text" id="accountType" class="form-control" name="accountType" value="${accountType}" placeholder="Account type" maxlength="20">
	        </div>
	        <div class="form-group">
	            <input type="text" id="accountNumber" class="form-control" name="accountNumber" value="${accountNumber}" placeholder="Account number" maxlength="35">
	        </div>
	        <g:if test="${payoutmode}">
		        <div class="form-group">
	                <input type="text" id="payoutmode" class="form-control" name="payoutmode" value="${payoutmode}" placeholder="Payoutmode" readonly>
	            </div>
            </g:if>
            <g:else>
                <div class="form-group">
                    <input type="text" id="payoutmode" class="form-control" name="payoutmode" value="WALLET" placeholder="Payoutmode" readonly>
                </div>
            </g:else>
	    </div>
	    <div class="col-sm-6 col-md-6 col-lg-6 col-xs-12">
	        <div class="form-group">
	            <input type="text" class="form-control" name="mobile" value="${mobile}" placeholder="Mobile Number" maxlength="10">
	        </div>
	        <div class="form-group">
	            <input type="text" class="form-control" name="address1" value="${address1}" placeholder="Address Line 1" maxlength="50">
	        </div>
	        <div class="form-group">
	            <input type="text" class="form-control" name="address2" value="${address2}" placeholder="Address Line 2" maxlength="50">
	        </div>
	        <div class="form-group">
	            <input type="text" class="form-control" name="city" value="${city}" placeholder="City" maxlength="30">
	        </div>
	        <div class="form-group">
	            <input type="text" class="form-control" name="zip" value="${zip}" placeholder="Zip" maxlength="8">
	        </div>
	        <div class="form-group" id="indianStates">
	            <g:select class="indianstate selectpicker" id="state" name="state" from="${indianStates}" value="${state}" optionKey="key" optionValue="value" noSelection="['null':'State']"/>
	        </div>
	        <div class="form-group">
	            <input type="text" class="form-control" name="country" value="India" placeholder="Country" readonly>
	        </div>
	    </div>
	    <%--<div class="clear"></div>
	    <div class="col-xs-12">
	        <button class="btn btn-md btn-primary pull-right" type="submit">Save</button>
	    </div>
	--%>
	</g:form>
</div>
</g:if>
<g:else>
    <div class="col-sm-12 col-sm-offset-0 col-md-8 col-md-offset-2 col-lg-8 col-lg-offset-2 col-xs-12 col-xs-offset-0" id="paymentInfo">
	    <g:form action="paymentInfo" controller="user" params="['projectTitle':vanityTitle]">
	        <div class="form-group">
	            <input type="text" id="beneficiaryname" class="form-control" name="fullName" value="${fullName}" placeholder="Beneficiary Name" maxlength="30">
	        </div>
	        <div class="form-group">
	            <input type="text" id="branch" class="form-control" name="branch" value="${branch}" placeholder="Bank branch" maxlength="30">
	        </div>
	        <div class="form-group">
	            <input type="text" id="ifscCode" class="form-control" name="ifscCode" value="${ifscCode}" placeholder="IFSC code" maxlength="11">
	        </div>
	        <div class="form-group">
	            <input type="text" id="accountType" class="form-control" name="accountType" value="${accountType}" placeholder="Account type" maxlength="20">
	        </div>
	        <div class="form-group">
	            <input type="text" id="accountNumber" class="form-control" name="accountNumber" value="${accountNumber}" placeholder="Account number" maxlength="35">
	        </div>
	        <button class="btn btn-lg btn-primary btn-block" type="submit">Save</button>
	    </g:form>
	</div>
</g:else>
