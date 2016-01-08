<html>
<head>
    <meta name="layout" content="main" />
    <r:require modules="checkoutjs"/>
</head>
<body>
<div class="feducontent">
   <div class="container footer-container">
       <div class="row row-transaction">
           <h1 class="col-sm-6 col-xs-12">Transaction List</h1>
           <div class="sendEmailToContributors col-sm-2 col-xs-6">
               <g:link action="sendEmailToContributors" controller="fund" class="btn btn-primary btn-sm btn-xs-width sendContributorEmail">Send Email</g:link>
           </div>
           <g:if test="${!contribution.empty }">
           <div class="generateCSV col-sm-2 col-xs-6">
               <g:form controller="fund" action="generateCSV" Method="post" >
                   <g:hiddenField name="currency" value="${currency}"/>
                   <button type="submit" class="btn btn-primary btn-sm btn-xs-width pull-right" >Generate CSV</button>
               </g:form>
            </div>
          </g:if>
          <div class="col-sm-2 col-xs-6 col-transaction">
              <g:hiddenField name="url" value="${url}" id="url"/>
              <g:hiddenField name="currency" value="${contribution.currency}" id="currency"/>
              <g:select class="selectpicker text-center" name="transactionSort" id="transactionSort" from="${transactionSort}" optionKey="value" optionValue="value" onchange="showSortedTransaction()"/>
          </div>
       </div>
       <div class="clear"></div>
       <g:if test="${flash.contributorUsernameAndPwdmessage}">
           <div class="alert alert-info text-center">
               ${flash.contributorUsernameAndPwdmessage}
           </div>
       </g:if>
       <div class="currencyconvertor" id="currencyconvertor">
           <g:form action="currency" controller="user">
               <div class="currencydiv col-md-4 col-xs-8">
                   <div class="form-group">
                       <div class="input-group">
                           <span class="input-group-addon"><b>1$ = </b></span>
                           <input class="form-control" type="text" name="currency" value="${multiplier}"/>
                           <span class="input-group-addon"><span class="fa fa-inr"></span></span>
                       </div>
                   </div>
               </div>
               <div class="col-md-2 col-xs-4">
                   <button type="submit" class="btn btn-primary btn-sm" id="currencysubmitbtn" onClick="return confirm(&#39;Changes in currency value will be reflected throughout the site. Are you sure you want to change the currency value.?&#39;);">Save</button>
               </div>
           </g:form>
       </div>
       <div class="clear"></div>
       <div id="transactionInfo">
           <g:render template="/user/admin/transactionGrid" model="['contribution': contribution]"></g:render>
       </div>
    </div>
</div>
</body>
</html>
