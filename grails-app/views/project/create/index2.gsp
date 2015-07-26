<g:set var="userService" bean="userService" />
<g:set var="contributionService" bean="contributionService"/>
<g:set var="projectService" bean="projectService"/>
<% 
    def user = userService.getCurrentUser() 
	
    def base_url = grailsApplication.config.crowdera.BASE_URL
   
		
	def payu_url=	grailsApplication.config.crowdera.PAYU.BASE_URL
	def request_url=request.getRequestURL().substring(0,request.getRequestURL().indexOf("/", 8))
%>
<html>
<head>
<meta name="layout" content="main" />
<r:require modules="projectcreatejs" />

<link rel="stylesheet" href="/bootswatch-yeti/bootstrap.css">
<link rel="stylesheet" href="/css/datepicker.css">
<script src="//tinymce.cachefly.net/4.1/tinymce.min.js"></script>
<script src="/js/main.js"></script>
<script src="/js/bootstrap-datepicker.js"></script>
<script type="text/javascript">
$(function() {
    $('.redactorEditor').redactor({
        imageUpload:'/project/getRedactorImage',
        focus: true,
        plugins: ['fontsize','fontfamily','fontcolor','video']
    });
});

    function removeLogo(){
		$('#delIcon').removeAttr('src');
		$('#imgIcon').removeAttr('src');
		$('#icondiv').hide();
		$('#iconfile').val(''); 
	}

 var nowTemp = new Date();
 var now = new Date(nowTemp.getFullYear(), nowTemp.getMonth(), nowTemp.getDate(), 0, 0, 0, 0);
 now.setDate(now.getDate()+91);
 var j = jQuery.noConflict();
 	j(function(){
 		j('#datepicker').datepicker({
 			  onRender: function(date) {    
 				   if (date.valueOf() < nowTemp.valueOf() || date.valueOf() >= now.valueOf()){
 					   return  'disabled';
 				   } 
 			}
 		});
 	});
 
</script>
</head>
<body>
<input type="hidden" id="b_url" value="<%=base_url%>" /> 
<input type="hidden" name="uuid" id="uuid" />
<input type="hidden" name="charity_name" id="charity_name" />
<input type="hidden" name="url" value="${payu_url}" id="url"/>
<input type="hidden" name="currentUrl" value="${request_url}" id="currentUrl"/>
    <div class="">
        <div class="text-center">
           <header>
	            <a class="cr-ancher-tab" href="#start">Start</a>
                <a class="cr-ancher-tab" href="#story">Story</a>
	            <a class="cr-ancher-tab" href="#admins">Admin</a>
	            <a class="cr-ancher-tab" href="#perk">Perks</a>
	            <a class="cr-ancher-tab" href="#payFirst">Payment</a>
	            <a class="cr-ancher-tab" href="#launch">Launch</a>
            </header>
        </div>
        <div class="bg-color">
        <div class="container footer-container" id="campaigncreate">
            <g:uploadForm class="form-horizontal cr-top-space"  controller="project" action="campaignOnDraftAndLaunch" id="${project.id}" role="form" params="['title': vanityTitle]">
                <div class="col-sm-12">
                    <div class="form-group" id="start">
                        <div class="col-sm-3">
                             <div class="input-group enddate"><span class="input-group-addon datepicker-error cr-datepicker-icon"><span class="glyphicon glyphicon-calendar"></span></span>
                                 <input class="datepicker pull-left" id="datepicker" name="${FORMCONSTANTS.DAYS}" readonly="readonly" placeholder="Deadline"> 
                             </div>
                        </div>
                    
                        <div class="col-sm-3">
                            <div class="font-list">
                                <g:select class="selectpicker" name="${FORMCONSTANTS.CATEGORY}" from="${categoryOptions}" optionKey="key" optionValue="value" />
                            </div>
                        </div>
                         
                        <div class="col-sm-3">
	                        <div class="cr-dropdown-alignment font-list">
	                            <g:select style="width:0px !important;" class="selectpicker" name="${FORMCONSTANTS.COUNTRY}" from="${country}" value="#" optionKey="key" optionValue="value" />
	                        </div>
                        </div>
                          
                        <div class="col-sm-3">
	                        <g:if test="${request_url==payu_url}">
		                        <div class="font-list">
		                            <g:select class="selectpicker" name="${FORMCONSTANTS.PAYMENT}" from="${projectService.getIndiaPaymentGateway()}" id="payment" value="${FORMCONSTANTS.PAYMENT}" optionKey="key" optionValue="value" />
		                        </div>
		                    </g:if>
		                    <g:else>
		                        <div class="font-list">
		                            <g:select class="selectpicker" name="${FORMCONSTANTS.PAYMENT}" from="${projectService.getPayment()}" id="payment" value="${FORMCONSTANTS.PAYMENT}" optionKey="key" optionValue="value" />
		                        </div>
		                    </g:else>
                        </div>
                    </div>   
                </div>
                    
                <div class="col-sm-6" id="media">
                    <div class="panel panel-default panel-create-size">
                        <div class="panel-body">
                            <div class="form-group">
                                <div class="col-sm-8">
                                    <input id="videoUrl" class="form-control" name="${FORMCONSTANTS.VIDEO}" placeholder="Video URL">
                                </div>
                                <div class="pad-btn col-xs-6 col-sm-4">
                                    <input type="button" id="add" class="btn  btn-info btn-sm" name="Add" value="Add Video"/>
                                </div>
                                <div class="col-sm-6" id="ytVideo"></div>
                            </div>
                        </div>
                    </div>
                </div>
                        
                <div class="col-sm-6 ">
                    <div class="panel panel-default panel-create-size">
                        <div class="panel-body">
                            <div class="form-group" id="createthumbnail">
                                <div class="col-sm-12">
                                    <div class="fileUpload btn btn-info btn-sm">
                                        <span>Upload Pictuers</span>
                                        <input type="file" class="upload" name="${FORMCONSTANTS.THUMBNAIL}[]" id="projectImageFile" accept="image/jpeg, image/png" multiple>
                                    </div>
                                    <div class="clear"></div>
                                    <label class="docfile-orglogo-css" id="imgmsg">Please select image file.</label>
                                    <label class="docfile-orglogo-css" id="campaignfilesize"></label>
                                </div>
                                <div class="col-sm-12 pad-result">
                                    <output id="result"></output>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                        
            
               
               <div class="col-sm-12" id="story">
                   <div class="form-group">
                       <div class="col-sm-12 cr-story-padding">
                           <div class="cr-story-flx">
	                       	   <label class="btn btn-info btn-text">Story</label>
	                       	   <label class="panel-body cr-panel-story">A good engaging story is the backbone of your Campaign.
	                                                                    you want your readers to be compelled to share your story
	                                                                    and make your campaign go viral. Be passionate and make 
	                                                                    them believe and trust your goal.</label>
                       	   </div>
                           <textarea name="${FORMCONSTANTS.STORY}" id="${FORMCONSTANTS.STORY}" row="4" col="6" class="redactorEditor" placeholder="Biref summary:-
                                                                                                                                                   Your story needs to be like the book readers never want to 
                                                                                                                                                   keep down! Tell your contributors what you are raising funds for
                                                                                                                                                   and how will it make difference to you. Your organization
                                                                                                                                                   and the community at large.">
                              ${initialValue}</textarea>
                       </div>
                   </div>
               </div>
	                    
                        <div class="col-sm-12 manage-Top-tabs-mobile" id="admins">
						    <div class="cr-tabs-admins">
  								<label class="btn btn-info">ADMIN</label>
						    	<ul class="nav nav-tabs manage-projects nav-justified cr-ul-tabs">
									<li class="cr-li-tabs"><a href="#admin" data-toggle="tab" aria-expanded="false">
									   <span class="tab-text hidden-xs cr-add-tabs-title">Add Campaign co-creators</span><i class="glyphicon glyphicon-chevron-down pull-right"></i>
										</a></li>
										<li class="active cr-tabs-update"><a data-toggle="tab" href="#organization" aria-expanded="true">
										<span class="tab-text hidden-xs">Update Display Information<i class="glyphicon glyphicon-chevron-down pull-right"></i></span>
										</a></li>
										<li class="cr-tabs-update"><a data-toggle="tab" href="#personal"> 
											<span class="tab-text hidden-xs">Update Personal Information<i class="glyphicon glyphicon-chevron-down pull-right"></i></span>
	 									</a></li>
						   		 </ul>
                            </div>

						    <!-- Tab panes -->
							<div class="tab-content panel panel-default col-sm-12 cr-tab-panel-top">
								<div class="tab-pane panel-body row" id="admin">
							        <div class="col-sm-4">
							             <div class="form-group">
			                                 <div class="col-sm-12">
			                                     <input type="text" class="form-control" name="email1" id="firstadmin" placeholder="First Admin"></input>
			                                 </div>
		                                 </div>
		                            </div>
		                                    
                                    <div class="col-sm-4">
                                        <div class="form-group">
	                                        <div class="col-sm-12">
	                                            <input type="text" class="form-control" name="email2" id="secondadmin" placeholder="Second Admin"></input>
	                                        </div>
                                        </div>
                                    </div>
		                                    
                                    <div class="col-sm-4">
                                        <div class="form-group">
	                                        <div class="col-sm-12">
	                                            <input type="text" class="form-control" name="email3" id="thirdadmin" placeholder="Third Admin"></input>
	                                        </div>
                                        </div>
                                    </div>       
								</div>
								
								<div class="tab-pane panel-body active row" id="organization">
								    <div class="col-sm-4">
								        <div class="form-group" id="organizationName">
			                                <div class="col-sm-12">
			                                    <input class="form-control" name="${FORMCONSTANTS.ORGANIZATIONNAME}" value="${project.organizationName}" id="organizationname" placeholder="Organization Name">
				                            </div>
			                            </div>
		                            </div>
		                            
		                            <div class="col-sm-4">
			                            <div class="form-group">
			                                <div class="col-sm-12">
			                                    <input class="form-control" name="${FORMCONSTANTS.WEBADDRESS}" placeholder="Web Address">
			                                </div>
			                            </div>
		                            </div>
		                            
		                             <div class="col-sm-4">
					                    <div class="form-group">
			                                <div class="col-sm-6">
			                                    <div class="fileUpload btn btn-info btn-sm">
			                                        <span>Organization Logo</span>
			                                        <input type="file" class="upload" id="iconfile" name="iconfile" accept="image/jpeg, image/png">
			                                    </div>
			                                    <label class="docfile-orglogo-css" id="logomsg">Please select image file.</label>
			                                    <label class="docfile-orglogo-css" id="iconfilesize">The file you are attempting to upload is larger than the permitted size of 3MB.</label>
			                                </div>
			                                <div id="icondiv" class="pr-icon-thumbnail-div col-sm-2">
			                                    <img id="imgIcon" alt="cross" class="pr-icon-thumbnail"/>
			                                    <div class="deleteicon orgicon-css-styles">
			                                        <img alt="cross" onClick="removeLogo();" id="delIcon"/>
			                                    </div>
			                                </div>
					                    </div>
					                 </div>
								</div>
								
								<div class="tab-pane panel-body row" id="personal">
								    <div class="col-sm-4">
										<div class="form-group">
			                                <div class="col-sm-12">
			                                    <input id="firstName" class="form-control" name="${FORMCONSTANTS.FIRSTNAME}" value="${user.firstName}" placeholder="First Name">
				                            </div>
			                            </div>
		                            </div>
		                            
		                            <div class="col-sm-4">
			                            <div class="form-group">
			                                <div class="col-sm-12">
			                                    <input id="lastName" class="form-control" name="${FORMCONSTANTS.LASTNAME}" value="${user.lastName}" placeholder="Last Name">
			                                </div>
			                            </div>
		                            </div>
		                            
		                            <div class="col-sm-4">
			                            <div class="form-group">
											<div class="col-sm-12">
												<input type="tel" class="form-control" name="${FORMCONSTANTS.TELEPHONE}" placeholder="Phone">
											</div>
									    </div>
								    </div>
		                            
		                            <div class="col-sm-4">
			                            <div class="form-group">
			                                <div class="col-sm-12">
			                                <g:hiddenField name="fbShareUrl" id="fbShareUrl" value="${fbShareUrl}"/>
			                                  <a target="_blank" class="fb-like pull-left social fbShareForSmallDevices" href="http://www.facebook.com/sharer/sharer.php?s=100&amp;&p[url]=${fbShareUrl}">
			                                      <img src="//s3.amazonaws.com/crowdera/assets/fb-share-icon.png" alt="Facebook Share">
		                                      </a>
												<a target="_blank" class="fb-like pull-left fbShareForLargeDevices" id="fbshare">
													<img src="//s3.amazonaws.com/crowdera/assets/fb-share-icon.png" alt="Facebook Share">
												</a>
		                                       <a class="twitter-share pull-left" id="twitterShare" data-url="${base_url}/campaigns/${vanityTitle}/${vanityUsername}" target="_blank">
			                                       <img src="//s3.amazonaws.com/crowdera/assets/twitter-share-icon.png" alt="Twitter Share">
		                                       </a>
		                                       <a class="social share-linkedin pull-left" href="https://www.linkedin.com/cws/share?url=${fbShareUrl}"  id="share-linkedin" onclick="javascript:window.open(this.href,'', 'menubar=no,toolbar=no,resizable=yes,scrollbars=yes,height=600,width=600');return false;">
			                                       <img src="//s3.amazonaws.com/crowdera/assets/linked-in-share-icon.png" alt="LinkedIn Share">
		                                       </a>
			                                </div>
			                            </div>
		                            </div>
		                            <div class="col-sm-12">
			                            <div class="form-group">
				                            <div class="col-sm-12">
				                            	<p class="cr-para">We will use this information to contact you if there are any issues with the campaign.This information will not be shared publicly.</p>
				                            </div>
			                            </div>
		                            </div>
								</div>
								
							</div>
	
						</div>
	                   
							<div class="form-group">
								<div class="col-sm-12" id="perk">
									<div class="btn-group btnPerkBgColor col-sm-12 cr-perk-yesno-tab" data-target="buttons">
										<span class="btn btn-info col-sm-2 pull-left">offering PERKS ?</span>
										<label class="btn btn-default col-sm-2 pull-right"> <input type="radio" name="answer" value="no"> NO</label>
										<label class="btn btn-default col-sm-2 pull-right"> <input type="radio" name="answer" value="yes"> YES<i class="glyphicon glyphicon-chevron-down cr-perk-chevron-icon"></i></label> 
									</div>
								</div>
							</div>
						
							<input type="hidden" name="rewardCount" id="rewardCount" value='0'/>
								<div id="addNewRewards">
									<div class="rewardsTemplate" id="rewardTemplate">
								        <div class="col-sm-2">
										    <div class="form-group">
												<div class="col-sm-12">
													<g:if test="${request_url==payu_url}">
													    <span class="cr2-currency-label fa fa-inr cr-perks-amts"></span>
														<input type="text" placeholder="Amount" name="rewardPrice1"
															class="form-control rewardPrice cr-input-digit required" id="rewardPrice1" min="0">
													</g:if>
													<g:else>
													    <span class="cr2-currency-label">$</span>
														<input type="text" placeholder="Amount" name="rewardPrice1"
															class="form-control rewardPrice cr-input-digit required" id="rewardPrice1" min="0">
													</g:else>
												</div>
											</div>	
										</div>
										
										<div class="col-sm-5">
											<div class="form-group">
												<div class="col-sm-12">
													<input type="text" placeholder="Name of Perk" name="rewardTitle1"
														class="form-control cr-perk-title-number required" id="rewardTitle1">
												</div>
											</div>
										</div>
										
										<div class="col-sm-5">
											<div class="form-group">
												<div class="col-sm-12">
													<input type="text" placeholder="Number available" name="rewardNumberAvailable1"
														class="form-control cr-perk-title-number required" id="rewardNumberAvailable1">
												</div>
											</div>
									   </div>
									
										<div class="form-group">
											<div class="col-sm-12">
												<div class="col-sm-12">
													<textarea class="form-control rewardDescription required"
														name="rewardDescription1" id="rewardDesc1" rows="2"
														placeholder="Description" maxlength="250"></textarea>
														<p class="cr-perk-des-font">Please refer to our Terms of Use for more details on perks.</p>
												</div>
											</div>
										</div>
										<div class="col-sm-12">
	                                        <div class="form-group">
	                                            <div class="btn-group col-sm-12 cr-perk-check" data-toggle="buttons">
	                                                <label class="btn btn-default col-sm-3"><input type="checkbox" name="mailingAddress1" value="true" id="mailaddcheckbox1">Mailing address</label>
	                                                <label class="btn btn-default col-sm-3 "><input type="checkbox" name="emailAddress1" value="true" id="emailcheckbox1">Email address</label>
	                                                <label class="btn btn-default col-sm-3 "><input type="checkbox" name="twitter1" value="true" id="twittercheckbox1">Twitter handle</label>
	                                                <label class="btn btn-default col-sm-3"><input type="checkbox" name="custom1" value="true" id="customcheckbox1">Custom</label>
	                                            </div>
	                                        </div>
	                                    </div>
									</div>
							</div>
							<div class="row">
								<div class="col-sm-12 perk-css" id="updatereward">
									<div class="col-sm-12 perk-create-styls" align="right">
										<div class="btn btn-primary btn-circle perks-css-create" id="createreward">
											<i class="glyphicon glyphicon-plus"></i>
										</div>
										<div class="btn btn-primary btn-circle perks-created-remove" id="removereward">
											<i class="glyphicon glyphicon-trash"></i>
										</div>
									</div>
								</div>
							</div>
                         <div class="clear"></div>
                         
                          
                         <div class="form-group" id="payFirst">
								<div class="col-sm-12 cr-payments-pad">
								    <div class="cr-story-flx col-sm-12">
										    <label class="btn btn-info btn-text">Payments</label>
	                       	                <label class="panel-body cr-payments">Payments are sent and received via your choice of Payment Gateway.
	                                                                              You keep 100% of the money you raise. Crowdera does not charge any fee to you.</label>
	                                         
	                                </div>
	                               <label class="cr-pad-who">Who will recieve the funds</label>
									<div class="btn-group col-sm-12 cr-perk-check cr-radio-option" data-toggle="buttons">
										<label class="btn btn-default cr-check-btn col-sm-3"> <input type="radio" name="" value="yes">Person</label> 
										<label class="btn btn-default cr-check-btn col-sm-3"> <input type="radio" name="" value="no">Non-profit</label>
										<label class="btn btn-default cr-check-btn col-sm-3"> <input type="radio" name="" value="no">NGO</label>
										<label class="btn btn-default cr-check-btn col-sm-3"> <input type="radio" name="" value="no">Others</label>
									</div>
								</div>
							</div>
                          
						<div class="form-group">
						    <g:if test ="${request_url==payu_url}">
							    <div id="PayUMoney">
								    <div class="col-sm-12">
									    <div class="form-group">
									        <label class="col-sm-4 control-label">Marchant ID </label>
											<div class="col-sm-6">
												<input id="payuemail" type="email" class="form-control" name="${FORMCONSTANTS.PAYUEMAIL}">
											</div>
										</div>
									</div>
									 <div class="col-sm-12">
									    <div class="form-group">
									        <label class="col-sm-4 control-label">Secret Key</label>
											<div class="col-sm-6">
												<input type="text" class="form-control" name="${FORMCONSTANTS.SECRETKEY}">
											</div>
										</div>
									</div>
								</div>
						    </g:if>
						    <g:else>
								<div class="col-sm-12" id="paypalemail">
	                                <div class="form-group">
	                                    <label class="col-sm-4 control-label">PayPal Email ID </label>
	                                    <div class="col-sm-6 paypalVerification">
	                                        <input id="paypalEmailId" type="email" class="form-control paypal-create" name="${FORMCONSTANTS.PAYPALEMAIL}">
	                                        <g:hiddenField name="paypalEmailAck" value="" id="paypalEmailAck"/>
	                                    </div>
	                                </div>
	                            </div>
	         					<div class="col-sm-12" id="charitableId">							
									<div class="form-group">
									    <label class="col-sm-4 control-label">Charitable ID</label>
										<div class="col-sm-3">
											<a data-toggle="modal" href="#myModal" class="charitableLink">Find your organization</a>
										</div>
										<div class="col-sm-4" id="charitable">
											<input type="text" id="hiddencharId" name="${FORMCONSTANTS.CHARITABLE}" placeholder="charitableId" readonly>
										</div>
									</div>
									<div class="modal" id="myModal">
										<div class="modal-dialog">
											<div class="modal-content">
												<div class="modal-header">
													<button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
													<h4 class="modal-title">Find your charity organization</h4>
												</div>
												<div class="modal-body">
													<div id="fgGraphWidgetContainer"></div>
													<script>
														var FG_GRAPHWIDGET_PARAMS = {
															results : {
																selectaction : function(uuid,charity_name) {	
																	document.getElementById("uuid").value = uuid;
																	document.getElementById("charity_name").value = charity_name;
																}
															}
														};
														function setOrganization() {
															$('#charitable').find('input').val(document.getElementById("uuid").value);
															$('#organizationName').find('input').val(document.getElementById("charity_name").value);
														}
													</script>
													<script src="//assets.firstgiving.com/graphwidget/static/js/fg_graph_widget.min.js"></script>
												</div>
												<div class="modal-footer">
													<button href="#" data-dismiss="modal" class="btn btn-primary">Close</button>
													<button class="btn btn-primary" href="#" data-dismiss="modal" onclick="setOrganization()" id="saveButton">Save</button>
												</div>
											</div>
										</div>
									</div>
							   </div>
						    </g:else>
								
                    <div class="col-sm-12 cr-paddingspace" id="launch">
                        <div class="col-sm-6 text-center " >
                            <g:link class="cr-bg-preview-btn" id="${project.id}" controller="project" action="manageCampaign"></g:link>
                        </div>
                        <g:hiddenField name="isSubmitButton" value="true" id="isSubmitButton"></g:hiddenField>
<%--                        <div class="col-sm-4 text-center padding-btn" >--%>
<%--                            <button type="button" class="btn  btn-primary btn-colors" name="button" id="saveasdraft"  value="draft">Save</button>--%>
<%--                        </div>--%>
                        <div class="col-sm-6 text-center" >
                            <button type="button" class="cr-bg-Launch-btn" id="submitProject" name="button" value="submitProject"></button>
                        </div>
                    </div>
                </div>
                       
            </g:uploadForm>
		</div>
		</div>
	</div>
</body>
</html>