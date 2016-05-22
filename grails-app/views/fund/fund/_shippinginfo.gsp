<g:if test="${shippingInfo}">
   <g:if test="${shippingInfo.address != null || shippingInfo.email  != null || (shippingInfo.twitter  != null && anonymous == 'false') || (shippingInfo.custom  != null && shippingInfo.custom  != '')}">
       <div class="panel panel-primary billing-panel">
           <div class="panel-heading shipping-heading">
               <h3 class="panel-title">Shipping Information Required to Fulfill a Perk</h3>
           </div>
           <div class="panel-body">
               <g:if test="${shippingInfo.address != null}">
                   <div class="col-sm-12">
	                   <label class="checkbox control-label">
	                      <input type="checkbox" name="checkAddress" id="checkAddress" > Address same as above.
	                   </label>
                   </div>
                   <div class="col-md-6" id="physicalAddress">
                       <div class="form-group">
                           <div class="input-group col-md-12">
                               <input class="form-control all-place" type="text" placeholder="AddressLine1" name="addressLine1" id="addressLine1">
                           </div>
                       </div>
                       <div class="form-group">
                           <div class="input-group col-md-12">
                               <input class="form-control all-place" type="text" placeholder="AddressLine2" name="addressLine2" id="addressLine2">
                           </div>
                       </div>
                       <div class="form-group">
                           <div class="input-group col-md-12">
                               <div class="row">
                                   <div class="col-sm-6">
                                       <input class="form-control all-place" type="text" placeholder="City" name="city" id="city">
                                   </div>
                                   <div class="col-sm-6">
                                       <input class="form-control all-place" type="text" placeholder="Zip" name="zip" id="zip"> 
                                   </div>
                               </div>
                           </div>
                       </div>
                   </div>
                   <div class="col-md-6">
                       <div class="form-group">
                           <div class="input-group col-md-12">
                               <g:select class="selectpicker state" name="state" id="state" from="${state}" optionKey="key" optionValue="value"/>
                           </div>
                       </div>
                       <div class="form-group" id="other">
                           <div class="input-group col-md-12">
                               <input class="form-control all-place" type="text" placeholder="Other State" name="otherstate1" id="otherstate1">
                           </div>
                       </div>
                       <div class="form-group">
                           <div class="input-group col-md-12">
                               <g:select class="selectpicker" name="country" id="country" from="${country}" value="US" optionKey="key" optionValue="value"/>
                           </div>
                       </div>
                   </div>
                   
                   <div class="clear"></div>
                   <g:if test="${shippingInfo.email  != null || (shippingInfo.twitter  != null && anonymous == 'false') || shippingInfo.custom  != null}">
                       <hr>
                   </g:if>
               </g:if>
               <g:if test="${shippingInfo.email  != null}">
                   <div class="col-md-6">
                       <div class="form-group">
                           <div class="input-group col-md-12">
                               <input class="form-control all-place" type="text" placeholder="Email" name="shippingEmail" id="shippingEmail">
                           </div>
                       </div>
                   </div>
               </g:if>
               <g:if test="${shippingInfo.twitter  != null && anonymous == 'false'}">
                   <div class="col-md-6">
                       <div class="form-group">
                           <div class="input-group col-md-12">
                               <input class="form-control all-place" type="text" placeholder="Twitter Handle" name="twitterHandle">
                           </div>
                       </div>
                   </div>
               </g:if>
               <g:if test="${shippingInfo.custom != null && shippingInfo.custom != ''}">
                   <g:hiddenField name="customField" id="customField" value="${shippingInfo.custom}"/>
                   <div class="col-md-6">
                       <div class="form-group">
                           <div class="input-group col-md-12">
                               <input class="form-control all-place" type="text" id="customShippingInfo" name="shippingCustom">
                           </div>
                       </div>
                   </div>
               </g:if>
               
           </div>
       </div>
   </g:if>
</g:if>

<script type="text/javascript">
    reloadjs();
</script>
