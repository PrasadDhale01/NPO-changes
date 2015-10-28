<html>
<head>
    <meta name="layout" content="main" />
    <r:require modules="checkoutjs"/>
</head>
<body>
<div class="feducontent">
   <div class="container footer-container">
       <div class="row row-transaction">
           <h1 class="col-md-8 col-sm-8 col-xs-12">Transaction List</h1>
           <g:if test="${!contribution.empty }">
           <div class="generateCSV col-md-2 col-sm-2 col-xs-6">
               <g:form controller="fund" action="generateCSV" Method="post" >
                   <g:hiddenField name="currency" value="${currency}"/>
                   <button type="submit" class="btn btn-primary btn-sm btn-xs-width pull-right" >Generate CSV</button>
               </g:form>
            </div>
          </g:if>
          <div class="col-md-2 col-sm-2 col-xs-6 col-transaction">
              <g:hiddenField name="url" value="${url}" id="url"/>
              <g:hiddenField name="currency" value="${contribution.currency}" id="currency"/>
              <g:select class="selectpicker text-center" name="transactionSort" id="transactionSort" from="${transactionSort}" optionKey="value" optionValue="value" onchange="showSortedTransaction()"/>
          </div>
       </div>
       <div class="table table-responsive table-xs-left">
           <table class="table table-bordered">
               <thead>
                   <tr class="alert alert-title ">
                       <th class="text-center col-sm-1">Sr. No.</th>
                       <th class="text-center col-sm-2">Contribution Date & Time</th>
                       <th class="text-center col-sm-3">Campaign</th>
                       <th class="text-center col-sm-2">Contributor Name</th>
                       <th class="text-center">Identity</th>
                       <th class="text-center col-sm-2">Contributed Amount</th>
                       <th class="text-center col-sm-2">Email</th>
                       <th class="text-center">Mode</th>
                   </tr>
               </thead>
               <tbody id="transactionInfo">
                   <g:render template="/user/admin/transactionGrid" model="['contribution': contribution]"></g:render>
               </tbody>
           </table>
       </div>
    </div>    
</div>
</body>
</html>
