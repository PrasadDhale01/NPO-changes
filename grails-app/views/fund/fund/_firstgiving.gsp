<div class="col-md-4">
    <g:if test="${flash.amt_message}">
        <div class="alert alert-danger">
            ${flash.amt_message}
        </div>
    </g:if>
    <div class="row">
    <%--     <div class="col-md-12 col-sm-12 col-xs-12">
            <h1>Amount</h1>
        </div>--%>
    </div>
    <g:form action="checkout" method="POST" class="checkoutForm">
    
        <g:hiddenField name="projectId" value="${project.id}" />
        <g:hiddenField name="fr" value="${vanityUsername}" />
        <g:hiddenField name="rewardId" />
        <g:hiddenField name="url" value="${base_url}" id="url"/>
        <g:hiddenField name="anonymous" value="false" id="anonymous"/>
        <g:hiddenField name="projectTitle" value="${vanityTitle}"/>
        
        <!-- Value set by Javascript -->
        <div class="row">
            <div class="col-md-12 col-sm-12 col-xs-12">
            <div class="form-group">
                <div class="input-group">
                    <span class="amount input-group-addon"><span class="glyphicon glyphicon-usd"></span></span>
                    <input class="amount form-control" placeholder="Enter Donation Amount" <g:if test="${perk}">value="${reward.price.round()}"</g:if><g:else>value=""</g:else> id="amount" name="amount" type="text">
                </div>
                <span id="errormsg"></span>
            </div>
            </div>
        </div>
        <div class="row">
            <div class="col-md-12 col-sm-12 col-xs-12">
                <g:if test="${user != null}">
                    <g:hiddenField name="tempValue" id="tempValue" value="${user.id}"/>
                    <g:hiddenField name="userId"  id="userId" value="${user.id}"/>
                </g:if>
                <div class="panel panel-default">
                     <div class="panel-heading">
                         <h3 class="panel-title">Contact details (for your receipt)</h3>
                     </div>
                     <div class="panel-body">
                         <div class="col-md-12 col-sm-6 col-xs-12">
                             <div class="form-group">
                                 <div class="input-group col-md-12">
                                     <g:if test="${user}">
                                         <input class="form-control" type="text" placeholder="First Name" name="firstname" value="${user.firstName}" required>
                                     </g:if>
                                     <g:else>
                                         <input class="form-control" type="text" placeholder="First Name" name="firstname" required>
                                     </g:else>
                                 </div>
                             </div>
                         </div>
                         <div class="col-md-12 col-sm-6 col-xs-12">
                             <div class="form-group">
                                 <div class="input-group col-md-12">
                                     <g:if test="${user}">
                                         <input class="form-control" type="text" placeholder="Last Name" name="lastname" value="${user.lastName}" required>
                                     </g:if>
                                     <g:else>
                                         <input class="form-control" type="text" placeholder="Last Name" name="lastname" required>
                                     </g:else>
                                 </div>
                             </div>
                         </div>
                         <div class="col-md-12 col-sm-6 col-xs-12">
                             <div class="form-group">
                                 <div class="input-group col-md-12">
                                     <input class="form-control" type="email" placeholder="Email" name="email" value="${user?.email}" required>
                                 </div>
                             </div>
                         </div>
                     </div>
                 </div>
                <label class="checkbox">
                    <input type="checkbox" name="anonymousUser" id="anonymousUser" > Please keep my contribution anonymous.
                </label>
            </div>
        </div>
        <div class="row">
            <div class="col-md-12 col-sm-12 col-xs-12">
                <div  class="amount-button"><button type="submit" class="btn donateNow btnChargeContinue  btn-lg" id="btnCheckoutContinue">CONTINUE</button></div>
            </div>
        </div>
    </g:form>
</div>
<div class="col-md-4">
    <g:if test="${project.rewards.size()>1}">
        <g:render template="fund/rewards" model="[user:user]" />
    </g:if>
</div>
