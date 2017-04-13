<%@ page import="java.text.SimpleDateFormat" %>
<g:set var="userService" bean="userService" />
<%
    SimpleDateFormat dateFormat = new SimpleDateFormat("MM/dd/yyyy");
	def currentDate = new Date();
	def isAdmin = userService.isAdmin();
%>
<div class="col-sm-12 padding-tax-reciept-xs col-tax-reciept-panel <g:if test="${!project.offeringTaxReciept}">col-reciept-display-none</g:if>">
   <div class="cr-spend-matrix">
        <label class="col-md-2 col-sm-3 col-xs-12 text-center cr-panel-spend-matrix <g:if test="${isAdmin}">donation-head-padding</g:if>"><span class="cr-spend-matrix-font donation-font">Donation Receipts</span></label>
        <label class="col-md-10 col-sm-9 hidden-xs cr-panel-spend-matrix-guide">
        </label>
   </div>
   <div class="panel panel-body cr-panel-body-spend-matrix form-group cr-panel-body cr-hash-tags">
       <g:if test="${'in'.equalsIgnoreCase(country_code)}">
            <g:if test="${taxReciept}">
                <div class="row">
                    <div class="col-sm-12">
                        <div class="col-sm-4 col-xs-12 form-group form-group-tax-reciept">
                             <input type="text" maxlength="64" placeholder="Registered Name" class="form-control tax-reciept-holder-name" name="tax-reciept-holder-name" value="${taxReciept.name}">
                        </div>
                        <div class="col-sm-4 col-xs-12 form-group form-group-tax-reciept">
                            <input type="text" maxlength="32" placeholder="Registration Number" class="form-control tax-reciept-registration-num" name="tax-reciept-registration-num" value="${taxReciept.regNum}">
                        </div>
                        <div class="col-sm-4 col-xs-12 form-group form-group-tax-reciept">
                            <input type="text" maxlength="10" placeholder="PAN Card Number" class="form-control tax-reciept-holder-pan-card" name="tax-reciept-holder-pan-card" value="${taxReciept.panCardNumber}">
                        </div>
                    </div>
                    <div class="col-sm-12">
                        <div class="col-sm-4 col-xs-12 form-group form-group-tax-reciept">
                            <g:if test="${dateFormat.format(taxReciept.expiryDate) == dateFormat.format(currentDate)}">
                                <input type="text" class="form-control datepicker-expiry text-date" placeholder="Expiry Date" name="expiry-date">
                            </g:if>
                            <g:else>
                                <input type="text" class="form-control datepicker-expiry text-date" placeholder="Expiry Date" name="expiry-date" value="${dateFormat.format(taxReciept.expiryDate)}">
                            </g:else>
                        </div>
                        <div class="col-sm-4 col-xs-12 form-group form-group-tax-reciept">
                            <g:if test="${dateFormat.format(taxReciept.regDate) == dateFormat.format(currentDate)}">
                                <input type="text" class="form-control datepicker-reg text-date" placeholder="Registration Date" name="reg-date">
                            </g:if>
                            <g:else>
                                <input type="text" class="form-control datepicker-reg text-date" placeholder="Registration Date" name="reg-date" value="${dateFormat.format(taxReciept.regDate)}">
                            </g:else>
                        </div>
                        <div class="col-sm-4 col-xs-12 form-group form-group-tax-reciept">
                            <input type="text" maxlength="10" placeholder="Phone Number" class="form-control tax-reciept-holder-phone" name="tax-reciept-holder-phone" value="${taxReciept.phone}" >
                        </div>
                    </div>
                    <div class="col-sm-12">
                        <div class="col-sm-4 col-xs-12 form-group form-group-tax-reciept">
                            <input type="text" maxlength="64" class="form-control addressLine1" placeholder="AddressLine 1" name="addressLine1" value="${taxReciept.addressLine1}">
                        </div>
                        <div class="col-sm-4 col-xs-12 form-group form-group-tax-reciept">
                            <input type="text" maxlength="64" class="form-control addressLine2" placeholder="AddressLine 2" name="addressLine2" value="${taxReciept.addressLine2}">
                        </div>
                        <div class="col-sm-4 col-xs-12 form-group form-group-tax-reciept">
                            <input type="text" maxlength="32" class="form-control tax-reciept-holder-city" placeholder="City" name="tax-reciept-holder-city" value="${taxReciept.city}">
                        </div>
                    </div>
            
                    <div class="col-sm-12">
                        <div class="col-sm-4 col-xs-12 form-group form-group-tax-reciept">
                            <input type="text" maxlength="16" class="form-control zip" placeholder="ZIP" name="zip"  value="${taxReciept.zip}">
                        </div>
                        <div class="col-sm-4 col-xs-12 form-group form-group-tax-reciept form-group-selectpicker form-group-dropdown">
                            <g:select class="selectpicker form-control selectpicker-state tax-reciept-dropdown-menu" name="tax-reciept-holder-state" from="${stateInd}" optionKey="value" optionValue="value" value="${taxReciept.taxRecieptHolderState}" noSelection="['OTHER':'State']"/>
                        </div>
                        <div class="col-sm-4 col-xs-12 form-group form-group-tax-reciept">
                            <input type="text" class="form-control country" placeholder="Country" name="country" value="India" readonly>
                        </div>
                    </div>
                    
                    <div class="col-sm-12">
                        <div class="col-sm-4 col-xs-12 form-group form-group-tax-reciept">
                            <input type="text" maxlength="32" class="form-control tax-reciept-orgStatus" placeholder="Status of Organization" name="tax-reciept-orgStatus" value="${taxReciept?.deductibleStatus}" >
                        </div>
                 
                        <div class="col-sm-4 col-xs-12 form-group form-group-tax-reciept">
                            <input type="text" maxlength="5" class="form-control tax-reciept-exemptionPercentage" placeholder="% of Exemption" name="tax-reciept-exemptionPercentage" value="${taxReciept?.exemptionPercentage}" >
                        </div>
                      
	                    <div class="col-sm-4 col-xs-12 form-group">
	                        <div class="col-sm-12 col-md-7 col-xs-9 digital_signature">
	                            <div class="fileUpload btn btn-info btn-sm cr-btn-color ">
	                                Add Digital Signature
	                                <input type="file" class="upload" id="digitalSign" name="digitalSign" accept="image/jpeg, image/png">
	                            </div>
	                        </div>
	                        <div class="signature_img_seperator"></div>
	                        <g:if test="${taxReciept.signatureUrl}">
	                            <div class="pr-icon-thumbnail-div edit-image-mobile col-sm-12 col-md-5 col-xs-3 <g:if test="${isAdmin}">pr-icon-div-margin</g:if>">
	                                <img id="editsignatureIcon" alt="cross" class="pr-icon-thumbnail" src="${taxReciept.signatureUrl}">
	                                <div class="deleteicon orgicon-css-styles">
	                                    <img alt="cross" id="deleditsignature" src="//s3.amazonaws.com/crowdera/assets/delete.ico">
	                                </div>
	                            </div>
	                        </g:if>
		                    <g:else>
		                        <div id="signaturediv" class="pr-icon-thumbnail-div cr-image-mobile col-sm-12 col-md-5 col-xs-3">
		                            <img id="signatureIcon" alt="cross" class="pr-icon-thumbnail">
		                            <div class="deleteicon orgicon-css-styles">
		                                <img alt="cross" id="delsignature" src="//s3.amazonaws.com/crowdera/assets/delete.ico">
		                            </div>
		                         </div>
	                        </g:else>
	                            
	                        <div class="clear"></div>
	                        <label class="docfile-orglogo-css" id="signaturemsg">Please select image file.</label>
	                        <label class="docfile-orglogo-css" id="signaturemsgsize">The file you are attempting to upload is larger than the permitted size of 3MB.</label>
	                    </div>
	                    
	                 </div>
                </div>
            
                <div class="row">
                    <div class="col-sm-12 col-sm-fcra">
                        <input type="checkbox" name="fcra-checkbox" class="fcra-checkbox" <g:if test="${taxReciept.fcraRegNum}">checked="checked"</g:if>>&nbsp;&nbsp;Are you FCRA registered ?
                    </div>
                    <div class="fcra-clear"></div>
                    <div class="fcra-details <g:if test="${!taxReciept.fcraRegNum}">fcra-display-none</g:if>">
                        <div class = "col-sm-4">
                            <div class="col-sm-12 form-group form-group-tax-reciept">
                                <input type="text" maxlength="32" placeholder="FCRA Registration No." class="form-control fcra-reg-no" name="fcra-reg-no" value="${taxReciept.fcraRegNum}">
                            </div>
                        </div>
                        <div class = "col-sm-4">
                            <div class="col-sm-12 form-group form-group-tax-reciept">
                                <g:if test="${dateFormat.format(taxReciept.fcraRegDate) == dateFormat.format(currentDate)}">
                                    <input type="text" placeholder="FCRA Registration Date" class="form-control fcra-reg-date text-date" name="fcra-reg-date">
                                </g:if>
                                <g:else>
                                    <input type="text" placeholder="FCRA Registration Date" class="form-control fcra-reg-date text-date" name="fcra-reg-date" value="${dateFormat.format(taxReciept.fcraRegDate)}">
                                </g:else>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="col-sm-2 col-xs-12 col-add-tax-files">
                        <div class="col-sm-12 col-xs">
                            <div class="fileUpload btn btn-info btn-sm cr-btn-color ">
                                Add Files
                                <input type="file" class="upload taxRecieptFiles" id="taxRecieptFiles" name="taxRecieptFiles">
                            </div>
                        </div>
                    </div>
                    <div class="col-tax-file-show col-sm-10 col-xs-12" id="col-tax-file-show">
                       <g:each var="file" in="${taxReciept.files}">
                           <% def url = file.url %>
                           <div class="col-sm-3 col-sm-tax-reciept">
                               <div class="cr-tax-files">
                                   <div class="col-file-name">${url.substring(url.lastIndexOf("/") + 1)}</div>
                                   <div class="deleteicon">
                                       <button type="button" class="close" onclick="deleteTaxRecieptFiles(this, ${file.id}, ${taxReciept.id})">&times;</button>
                                   </div>
                               </div>
                           </div>
                       </g:each>
                    </div>
                </div>
                <div class="row">
                    <div class="clear-tax-reciept"></div>
                    <div class="col-sm-12 col-file-upload-error-placement col-sm-fcra">
                        <label class="docfile-orglogo-css filesize" id="filesize"></label>
                        <label class="docfile-orglogo-css fileempty" id="fileempty"></label>
                        <div class="uploadingFile">Uploading File....</div>
                    </div>
                </div>
            </g:if>
            <g:else>
                <div class="row">
                    <div class="col-sm-12">
                        <div class="col-sm-4 col-xs-12 form-group form-group-tax-reciept">
                             <input type="text" maxlength="64" placeholder="Registered Name" class="form-control tax-reciept-holder-name" name="tax-reciept-holder-name">
                        </div>
                        <div class="col-sm-4 col-xs-12 form-group form-group-tax-reciept">
                            <input type="text" maxlength="64" placeholder="Registration Number" class="form-control tax-reciept-registration-num" name="tax-reciept-registration-num">
                        </div>
                        <div class="col-sm-4 col-xs-12 form-group form-group-tax-reciept">
                            <input type="text" maxlength="10" placeholder="PAN Card Number" class="form-control tax-reciept-holder-pan-card" name="tax-reciept-holder-pan-card">
                        </div>
                    </div>
                    <div class="col-sm-12">
                        <div class="col-sm-4 col-xs-12 form-group form-group-tax-reciept">
                            <input type="text" class="form-control datepicker-reg text-date" placeholder="Registration Date" name="reg-date">
                        </div>
                        <div class="col-sm-4 col-xs-12 form-group form-group-tax-reciept">
                            <input type="text" class="form-control datepicker-expiry text-date" placeholder="Expiry Date" name="expiry-date">
                        </div>
                        <div class="col-sm-4 col-xs-12 form-group form-group-tax-reciept">
                            <input type="text" maxlength="10" placeholder="Phone Number" class="form-control tax-reciept-holder-phone" name="tax-reciept-holder-phone">
                        </div>
                    </div>
                    <div class="col-sm-12">
                        <div class="col-sm-4 col-xs-12 form-group form-group-tax-reciept">
                            <input type="text" maxlength="64" class="form-control addressLine1" placeholder="AddressLine 1" name="addressLine1">
                        </div>
                        <div class="col-sm-4 col-xs-12 form-group form-group-tax-reciept">
                            <input type="text" maxlength="64" class="form-control addressLine2" placeholder="AddressLine 2" name="addressLine2">
                        </div>
                        <div class="col-sm-4 col-xs-12 form-group form-group-tax-reciept">
                            <input type="text" maxlength="32" class="form-control tax-reciept-holder-city" placeholder="City" name="tax-reciept-holder-city">
                        </div>
                    </div>
            
                    <div class="col-sm-12">
                    	<div class="col-sm-4 col-xs-12 form-group form-group-tax-reciept">
                            <input type="text" maxlength="16" class="form-control zip" placeholder="ZIP" name="zip">
                        </div>
                        <div class="col-sm-4 col-xs-12 form-group form-group-tax-reciept form-group-selectpicker form-group-dropdown">
                            <g:select class="selectpicker form-control selectpicker-state tax-reciept-dropdown-menu" name="tax-reciept-holder-state" from="${stateInd}" optionKey="value" optionValue="value" noSelection="['OTHER':'State']"/>
                        </div>
                        <div class="col-sm-4 col-xs-12 form-group form-group-tax-reciept">
                            <input type="text" class="form-control country" placeholder="Country" name="country" value="India" readonly>
                        </div>
                        
                    </div>
                    <div class="col-sm-12">
                    	<div class="col-sm-4 col-xs-12 form-group form-group-tax-reciept">
                            <input type="text" maxlength="32" class="form-control tax-reciept-orgStatus" placeholder="Status of Organization" name="tax-reciept-orgStatus">
                        </div>
	                    <div class="col-sm-4 col-xs-12 form-group form-group-tax-reciept">
	                        <input type="text" maxlength="5" class="form-control tax-reciept-exemptionPercentage" placeholder="% of Exemption" name="tax-reciept-exemptionPercentage">
	                    </div>
	                    <div class="form-group col-sm-4 col-md-4 col-xs-12">
	                         <div class="col-sm-12 col-md-7 col-xs-9 digital_signature">
	                             <div class="fileUpload btn btn-info btn-sm cr-btn-color ">
	                                 Add Digital Signature
	                                 <input type="file" class="upload" id="digitalSign" name="digitalSign" accept="image/jpeg, image/png">
	                             </div>
	                         </div>
	                         <div id="signaturediv" class="pr-icon-thumbnail-div cr-image-mobile col-sm-12 col-md-5 col-xs-3">
	                             <img id="signatureIcon" alt="cross" class="pr-icon-thumbnail">
	                             <div class="deleteicon orgicon-css-styles">
	                                 <img alt="cross" id="delsignature" src="//s3.amazonaws.com/crowdera/assets/delete.ico">
	                              </div>
	                         </div>
	                         
	                         <div class="clear"></div>
	                         <label class="docfile-orglogo-css" id="signaturemsg">Add only PNG or JPG extension image.</label>
	                         <label class="docfile-orglogo-css" id="signaturemsgsize">The file you are attempting to upload is larger than the permitted size of 3MB.</label>
	                     </div>
                     
                     </div>
                </div>
            
                <div class="row">
                    <div class="col-sm-12 col-sm-fcra">
                        <input type="checkbox" name="fcra-checkbox" class="fcra-checkbox">&nbsp;&nbsp;Are you FCRA registered ?
                    </div>
                    <div class="fcra-clear"></div>
                    <div class="fcra-details fcra-display-none">
                        <div class = "col-sm-4">
                            <div class="col-sm-12 form-group form-group-tax-reciept">
                                <input type="text" maxlength=32" placeholder="FCRA Registration No." class="form-control fcra-reg-no" name="fcra-reg-no">
                            </div>
                        </div>
                        <div class = "col-sm-4">
                            <div class="col-sm-12 form-group form-group-tax-reciept">
                                <input type="text" placeholder="FCRA Registration Date" class="form-control fcra-reg-date text-date" name="fcra-reg-date">
                            </div>
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="col-sm-2 col-add-tax-files col-xs-12">
                        <div class="col-sm-12 col-xs-12">
                            <div class="fileUpload btn btn-info btn-sm cr-btn-color ">
                                Add Files
                                <input type="file" class="upload taxRecieptFiles" id="taxRecieptFiles" name="taxRecieptFiles">
                            </div>
                        </div>
                    </div>
                    <div class="col-tax-file-show col-sm-10 col-xs-12" id="col-tax-file-show">
                    </div>
                </div>
                <div class="row">
                    <div class="clear-tax-reciept"></div>
                    <div class="col-sm-12 col-file-upload-error-placement col-sm-fcra">
                        <label class="docfile-orglogo-css filesize" id="filesize"></label>
                        <label class="docfile-orglogo-css fileempty" id="fileempty"></label>
                        <div class="uploadingFile">Uploading File....</div>
                    </div>
                </div>
            </g:else>
       </g:if>
       <g:else>
           <g:if test="${taxReciept}">
               <div class="col-sm-12 col-xs-12 col-plr-0 rowseperator">
                   <div class="col-sm-4">
                       <div class="form-group form-group-tax-reciept">
                           <input type="text" maxlength="9" placeholder="EIN" class="form-control ein" name="ein" value="${taxReciept.ein}">
                       </div>
                   </div>
                   <div class="col-sm-4">
                       <div class="form-group form-group-tax-reciept">
                           <input type="text" maxlength="64" placeholder="Name" class="form-control tax-reciept-holder-name" name="tax-reciept-holder-name" value="${taxReciept.name}">
                       </div>
                   </div>
                   <div class="col-sm-4">
                       <div class="form-group form-group-tax-reciept-dropdown form-group-dropdown">
                           <g:select class="selectpicker form-control tax-reciept-deductible-status tax-reciept-dropdown-menu" name="tax-reciept-deductible-status" from="${deductibleStatusList}" optionKey="key" optionValue="value" value="${taxReciept?.deductibleStatus}" noSelection="['null':'Deductible Status']"/>
                       </div>
                   </div>
               </div>
               
               <div class="clear"></div>
               
               <div class="col-sm-12 col-xs-12 col-plr-0 rowseperator">
                   <div class="col-sm-4">
                       <div class="form-group form-group-tax-reciept">
                           <input type="text" maxlength="64" placeholder="Address Line 1" class="form-control addressLine1" name="addressLine1" value="${taxReciept.addressLine1}">
                       </div>
                   </div>
                   <div class="col-sm-4">
                       <div class="form-group form-group-tax-reciept">
                           <input type="text" maxlength="64" placeholder="Address Line 2" class="form-control addressLine2" name="addressLine2" value="${taxReciept.addressLine2}">
                       </div>
                   </div>
                   <div class="col-sm-4">
                       <div class="form-group form-group-tax-reciept">
                           <input type="text" maxlength="32" placeholder="City" class="form-control tax-reciept-holder-city" name="tax-reciept-holder-city" value="${taxReciept.city}">
                       </div>
                   </div>
               </div>
               
               <div class="clear"></div>
               
               <div class="col-sm-12 col-xs-12 col-plr-0 rowseperator">
                   <div class="col-sm-4">
                       <div class="form-group form-group-tax-reciept">
                           <input type="text" maxlength="16" placeholder="Zip" class="form-control zip" name="zip" value="${taxReciept.zip}">
                       </div>
                   </div>
                   <div class="col-sm-4">
                       <div class="form-group form-group-tax-reciept">
                           <input type="text" maxlength="32" placeholder="State" class="form-control tax-reciept-holder-state" name="tax-reciept-holder-state" value="${taxReciept.taxRecieptHolderState}">
                       </div>
                   </div>
                   <div class="col-sm-4">
                       <div class="form-group form-group-tax-reciept-dropdown form-group-dropdown">
                           <g:select class="selectpicker form-control tax-reciept-holder-country-edit tax-reciept-holder-country" name="tax-reciept-holder-country" from="${country}" optionKey="value" value="${taxReciept.country}" optionValue="value" noSelection="['null':'Country']"/>
                       </div>    
                   </div>
               </div>
               
               <div class="clear"></div>
               
                <div class="col-sm-12 col-xs-12 col-plr-0 rowseperator">
                   <div class="col-sm-4 col-xs-12">
                       <div class="form-group form-group-tax-reciept">
                           <input type="text" maxlength="10" placeholder="Phone Number" class="form-control tax-reciept-holder-phone" name="tax-reciept-holder-phone" value="${taxReciept.phone}">
                       </div>
                   </div>
                   <div class="form-group col-sm-8 col-xs-12">
                       <div class="col-sm-5 col-md-4 col-xs-9 col-plr-0">
                           <div class="fileUpload btn btn-info btn-sm cr-btn-color ">
                               Add Digital Signature
                               <input type="file" class="upload" id="digitalSign" name="digitalSign" accept="image/jpeg, image/png">
                           </div>
                       </div>
                       
                       <g:if test="${taxReciept.signatureUrl}">
                           <div class="pr-icon-thumbnail-div edit-image-mobile col-sm-4 col-xs-3">
                               <img id="editsignatureIcon" alt="cross" class="pr-icon-thumbnail" src="${taxReciept.signatureUrl}">
                               <div class="deleteicon orgicon-css-styles">
                                   <img alt="cross" id="deleditsignature" src="//s3.amazonaws.com/crowdera/assets/delete.ico">
                               </div>
                           </div>
                       </g:if>
                       <g:else>
                           <div id="signaturediv" class="pr-icon-thumbnail-div cr-image-mobile col-sm-4 col-xs-3">
                               <img id="signatureIcon" alt="cross" class="pr-icon-thumbnail">
                               <div class="deleteicon orgicon-css-styles">
                                   <img alt="cross" id="delsignature" src="//s3.amazonaws.com/crowdera/assets/delete.ico">
                               </div>
                           </div>
                       </g:else>
                       
                       <div class="clear"></div>
                       <label class="docfile-orglogo-css" id="signaturemsg">Add only PNG or JPG extension image.</label>
                       <label class="docfile-orglogo-css" id="signaturemsgsize">The file you are attempting to upload is larger than the permitted size of 3MB.</label>
                   </div>
               </div>
               
           </g:if>
           <g:else>
               
               <div class="col-sm-12 col-xs-12 col-plr-0 rowseperator">
                   <div class="col-sm-4">
                       <div class="form-group form-group-tax-reciept">
                           <input type="text" maxlength="9" placeholder="EIN" class="form-control ein" name="ein">
                       </div>
                   </div>
                   <div class="col-sm-4">
                       <div class="form-group form-group-tax-reciept">
                           <input type="text" maxlength="64" placeholder="Name" class="form-control tax-reciept-holder-name" name="tax-reciept-holder-name">
                       </div>
                   </div>
                   <div class="col-sm-4">
                       <div class="form-group form-group-tax-reciept-dropdown form-group-dropdown">
                           <g:select class="selectpicker form-control tax-reciept-deductible-status tax-reciept-dropdown-menu" name="tax-reciept-deductible-status" from="${deductibleStatusList}" optionKey="key" optionValue="value" noSelection="['null':'Deductible Status']"/>
                       </div>
                   </div>
               </div>
               
               <div class="clear"></div>
               
               <div class="col-sm-12 col-xs-12 col-plr-0 rowseperator">
                   <div class="col-sm-4">
                       <div class="form-group form-group-tax-reciept">
                           <input type="text" maxlength="64" placeholder="Address Line 1" class="addressLine1 form-control" name="addressLine1">
                       </div>
                   </div>
                   <div class="col-sm-4">
                       <div class="form-group form-group-tax-reciept">
                           <input type="text" maxlength="64" placeholder="Address Line 2" class="addressLine2 form-control" name="addressLine2">
                       </div>
                   </div>
                   <div class="col-sm-4">
                       <div class="form-group form-group-tax-reciept">
                           <input type="text" maxlength="32" placeholder="City" class="form-control tax-reciept-holder-city" name="tax-reciept-holder-city">
                       </div>
                   </div>
               </div>
               
               <div class="clear"></div>
               
               <div class="col-sm-12 col-xs-12 col-plr-0 rowseperator">
                   <div class="col-sm-4">
                       <div class="form-group form-group-tax-reciept">
                           <input type="text" maxlength="16" placeholder="Zip" class="form-control zip" name="zip">
                       </div>
                   </div>
                   <div class="col-sm-4">
                       <div class="form-group form-group-tax-reciept">
                           <input type="text" maxlength="32" placeholder="State" class="form-control tax-reciept-holder-state" name="tax-reciept-holder-state">
                       </div>
                   </div>
                   <div class="col-sm-4">
                       <div class="form-group form-group-tax-reciept-dropdown form-group-dropdown">
                           <g:select class="selectpicker form-control tax-reciept-holder-country-edit tax-reciept-holder-country" name="tax-reciept-holder-country" from="${country}" optionKey="value" optionValue="value" noSelection="['null':'Country']"/>
                       </div>    
                   </div>
               </div>
               
               <div class="clear"></div>
               
               <div class="col-sm-12 col-xs-12 col-plr-0 rowseperator">
                   <div class="col-sm-4 col-xs-12">
                       <div class="form-group form-group-tax-reciept">
                           <input type="text" maxlength="10" placeholder="Phone Number" class="form-control tax-reciept-holder-phone" name="tax-reciept-holder-phone">
                       </div>
                   </div>
                   <div class="form-group col-sm-8 col-xs-12">
                       <div class="col-sm-5 col-md-4 col-xs-9 col-plr-0">
                           <div class="fileUpload btn btn-info btn-sm cr-btn-color ">
                                Add Digital Signature
                                <input type="file" class="upload" id="digitalSign" name="digitalSign" accept="image/jpeg, image/png">
                           </div>
                       </div>
                       <div id="signaturediv" class="pr-icon-thumbnail-div cr-image-mobile col-sm-4 col-xs-3">
                           <img id="signatureIcon" alt="cross" class="pr-icon-thumbnail">
                           <div class="deleteicon orgicon-css-styles">
                               <img alt="cross" id="delsignature" src="//s3.amazonaws.com/crowdera/assets/delete.ico">
                           </div>
                       </div>
                       
                       <div class="clear"></div>
                       <label class="docfile-orglogo-css" id="signaturemsg">Add only PNG or JPG extension image.</label>
                       <label class="docfile-orglogo-css" id="signaturemsgsize">The file you are attempting to upload is larger than the permitted size of 3MB.</label>
                   </div>
               </div>
               
           </g:else>
       </g:else>
    </div>
</div>

