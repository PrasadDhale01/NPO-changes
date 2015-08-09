<g:set var="userService" bean="userService" />
<g:set var="contributionService" bean="contributionService"/>
<g:set var="projectService" bean="projectService"/>
<% 
    def base_url = grailsApplication.config.crowdera.BASE_URL
%>
<html>
<head>
    <meta name="layout" content="main" />
    <r:require modules="projectcreatejs" />
    
    <link rel="stylesheet" href="/bootswatch-yeti/bootstrap.css">
    <link rel="stylesheet" href="/css/datepicker.css">
</head>
<body>
    <input type="hidden" id="b_url" value="<%=base_url%>" /> 
    <input type="hidden" name="uuid" id="uuid" />
    <input type="hidden" name="charity_name" id="charity_name" />
    <input type="hidden" name="url" value="${currentEnv}" id="currentEnv"/>
    <g:hiddenField name="payfir" value="${project.charitableId}" id="payfir"/>
    <g:hiddenField name="paypal" value="${project.paypalEmail}"/>
    <div class="">
        <div class="text-center">
             <header class="col-sm-12 col-xs-12 cr-tabs-link cr-ancher-tab">
	            <a class=" col-sm-2 col-xs-6 cr-img-start-icon" href="#start"><div class="col-sm-0"><img class="cr-start" src="//s3.amazonaws.com/crowdera/assets/start-Icon-Blue.png" alt="Start"></div>Start</a>
                <a class=" col-sm-2 col-xs-6 cr-img-story-icon" href="#story"><div class="col-sm-0"><img class="cr-story" src="//s3.amazonaws.com/crowdera/assets/story-Icon-Blue.png" alt="Story"></div>Story</a>
	            <a class=" col-sm-2 col-xs-6 cr-img-admin-icon" href="#admins"><div class="col-sm-0"><img class="cr-admin" src="//s3.amazonaws.com/crowdera/assets/admin-Icon---Blue.png" alt="Admin"></div>Admin</a>
	            <a class=" col-sm-2 col-xs-6 cr-img-perk-icon" href="#perk"><div class="col-sm-0"><img class="cr-perk" src="//s3.amazonaws.com/crowdera/assets/perk-Icon-Blue.png" alt="Perk"></div>Perks</a>
	            <a class=" col-sm-2 col-xs-6 cr-img-payment-icon" href="#payFirst"><div class="col-sm-0"><img class="cr-payment" src="//s3.amazonaws.com/crowdera/assets/payment-Icon-Blue.png" alt="Payment"></div>Payment</a>
	            <a class=" col-sm-2 col-xs-6 cr-img-launch-icon" href="#launch"><div class="col-sm-0"><img class="cr-launch" src="//s3.amazonaws.com/crowdera/assets/launch-Icon--Blue.png" alt="Launch"></div>Launch</a>
            </header>
        </div>
        <div class="bg-color col-sm-12 col-xs-12 cr-top-space">
        <div class="container footer-container" id="campaigncreate">
            <g:uploadForm class="form-horizontal"  controller="project" action="campaignOnDraftAndLaunch" role="form" params="['title': vanityTitle, 'userName':vanityUsername]">
                <g:hiddenField name="projectId" value="${project.id}"/>
                <div class="col-sm-12 cr-start-flex">
                    <label class="panel body cr-start-size">START</label>
                    <div class="form-group" id="start">
                        <div class="col-sm-3">
                             <div class="input-group enddate">
                                 <g:if test="${campaignEndDate}">
                                     <input class="datepicker pull-left cr-datepicker-height cr-mob-datepicker" id="datepicker" name="${FORMCONSTANTS.DAYS}" readonly="readonly" value="${campaignEndDate}" placeholder="Deadline"> 
                                 </g:if>
                                 <g:else>
                                     <input class="datepicker pull-left cr-datepicker-height cr-mob-datepicker" id="datepicker" name="${FORMCONSTANTS.DAYS}" readonly="readonly" placeholder="Deadline">
                                 </g:else>
                                 <i class="fa fa-caret-down cr-caret-size" style="position:absolute;"></i>
                             </div>
                        </div>
                    
                        <div class="col-sm-3">
                            <div class="font-list">
                                    <g:if test="${project.category && project.category.toString() != 'OTHER'}">
                                        <g:select class="selectpicker cr-start-dropdown-category cr-all-mobile-dropdown" name="${FORMCONSTANTS.CATEGORY}" from="${categoryOptions}" id="category" optionKey="key" optionValue="value" value="${project.category}"/>
                                    </g:if>
                                    <g:else>
                                        <g:select class="selectpicker cr-start-dropdown-category cr-all-mobile-dropdown" name="${FORMCONSTANTS.CATEGORY}" from="${categoryOptions}" id="category" optionKey="key" optionValue="value" />
                                    </g:else>
                                </div>
                            </div>
                            <div class="col-sm-3">
                                <div class="cr-dropdown-alignment font-list">
                                    <g:if test="${project.beneficiary.country}">
                                        <g:select style="width:0px !important;" class="selectpicker cr-start-dropdown-country cr-all-mobile-dropdown" id="country" name="${FORMCONSTANTS.COUNTRY}" from="${country}" value="${project.beneficiary.country}" optionKey="key" optionValue="value" />
                                    </g:if>
                                    <g:else>
                                        <g:select style="width:0px !important;" class="selectpicker cr-start-dropdown-country cr-all-mobile-dropdown" id="country" name="${FORMCONSTANTS.COUNTRY}" from="${country}" value="#" optionKey="key" optionValue="value" />
                                    </g:else>
                                </div>
                            </div>
                            
                            <div class="col-sm-3">
	                            <div class="font-list">
	                                <g:if test="${project.payuEmail}">
	                                    <g:select class="selectpicker cr-start-dropdown-payment cr-all-mobile-dropdown" name="${FORMCONSTANTS.PAYMENT}" from="${payOpts}" id="payment" value="PAYU" optionKey="key" optionValue="value" />
	                                </g:if>
	                                <g:elseif test="${project.charitableId}">
	                                    <g:select class="selectpicker cr-start-dropdown-payment cr-all-mobile-dropdown" name="${FORMCONSTANTS.PAYMENT}" from="${payOpts}" id="payment" value="FIR" optionKey="key" optionValue="value" />
	                                </g:elseif>
	                                <g:elseif test="${project.paypalEmail}">
	                                    <g:select class="selectpicker cr-start-dropdown-payment cr-all-mobile-dropdown" name="${FORMCONSTANTS.PAYMENT}" from="${payOpts}" id="payment" value="PAY" optionKey="key" optionValue="value" />
	                                </g:elseif>
	                                <g:else>
	                                    <g:select class="selectpicker cr-start-dropdown-payment cr-all-mobile-dropdown" name="${FORMCONSTANTS.PAYMENT}" from="${payOpts}" id="payment" value="${FORMCONSTANTS.PAYMENT}" optionKey="key" optionValue="value" />
	                                </g:else>
	                            </div>
                            </div>
                        </div>
                    </div>
                    <g:hiddenField name="campaignvideoUrl" value="${project.videoUrl}" id="addvideoUrl"/>
                    <div class="col-sm-6" id="media">
                        <a href="#addVideo" data-toggle="modal">
                            <div class="panel panel-default panel-create-size" id="videoBox">
                                <img id="addVideoIcon" class="addVideoIcon img-responsive" src="//s3.amazonaws.com/crowdera/assets/addvideoicon.png">
                            </div>
                        </a>
                    </div>
                    <div class="col-sm-6" id="media-video">
                        <div class="panel panel-default panel-create-size" id="videoBox">
                           <a href="#addVideo" data-toggle="modal">
                               <button class="videoUrledit close" id="videoUrledit">
                                   <i class="glyphicon glyphicon-edit" ></i>
                               </button>
                           </a>
                           <div class="panel-body">
                               <div class="form-group">
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
                                    <div class="fileUpload btn btn-info btn-sm cr-btn-color">
                                        <span>Upload Pictures</span>
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
                            <label class="panel body cr-story-size">STORY</label>
                      	    <label class="panel-body cr-panel-story">A good engaging story is the backbone of your Campaign.
	                                                                    you want your readers to be compelled to share your story
	                                                                    and make your campaign go viral. Be passionate and make 
	                                                                    them believe and trust your goal.</label>
                       	    </div>
                            <textarea name="${FORMCONSTANTS.STORY}" row="4" col="6" class="redactorEditor">
                                <g:if test="${project.story}">${project.story}</g:if>
                            </textarea>
                            <span id="storyRequired">Ths field is required</span>
                            <g:hiddenField name="projectHasStory" id="projectHasStory" value="${project.story}"/>
                        </div>
                    </div>
                </div>
	                    
               <div class="col-sm-12 manage-Top-tabs-mobile" id="admins">
                   <div class="cr-tabs-admins">
	                   <label class="panel body cr-admin-title">ADMIN</label>
                       <ul class="nav nav-tabs manage-projects nav-justified cr-ul-tabs">
                           <li class="cr-li-tabs cr-hover-color">
                              <a href="#admin" data-toggle="tab" aria-expanded="false">
                                   <span class="glyphicon glyphicon-user cr-icon-tabs-user visible-xs"></span><span class="tab-text hidden-xs cr-add-tabs-title cr-font-title">Add Campaign <br> Admin<i class="glyphicon glyphicon-chevron-down cr-tab-in cr-tab-icons pull-right"></i></span>
	                           </a>
	                       </li>
	                       <li class="active cr-tabs-update cr-hover-color">
	                           <a data-toggle="tab" href="#organization" aria-expanded="true">
	                               <span class="glyphicon glyphicon-eye-open cr-icon-tabs-eye visible-xs"></span><span class="tab-text hidden-xs cr-font-title">Update Display <br> Information<i class="glyphicon glyphicon-chevron-down cr-tab-in cr-tab-icons pull-right"></i></span>
	                           </a>
	                       </li>
	                       <li class="cr-tabs-update cr-hover-color">
	                           <a data-toggle="tab" href="#personal"> 
		                            <span class="glyphicon glyphicon-info-sign cr-icon-tabs-info visible-xs"></span><span class="tab-text hidden-xs cr-font-title">Update Personal <br> Information<i class="glyphicon glyphicon-chevron-down cr-tab-in cr-tab-icons pull-right"></i></span>
		                       </a>
		                   </li>
		               </ul>
                   </div>

				    <!-- Tab panes -->
					<div class="tab-content panel panel-default col-sm-12 cr-tab-panel-top">
                        <div class="tab-pane panel-body row" id="admin">
                            <div class="col-sm-4">
                                <div class="form-group">
                                    <div class="col-sm-12">
                                        <g:if test="${email1}">
                                            <input type="email" class="form-control form-control-no-border cr-placeholder cr-chrome-place text-color" name="email1" id="firstadmin" value="${email1}" placeholder="First Admin"></input>
                                        </g:if>
                                        <g:else>
                                            <input type="email" class="form-control form-control-no-border cr-placeholder cr-chrome-place text-color" name="email1" id="firstadmin" placeholder="First Admin"></input>
                                        </g:else>
                                    </div>
                                </div>
                            </div>
		                                    
                            <div class="col-sm-4">
                                <div class="form-group">
                                 <div class="col-sm-12">
                                     <g:if test="${email2}">
                                         <input type="email" class="form-control form-control-no-border cr-placeholder cr-chrome-place text-color" name="email2" id="secondadmin" value="${email2}" placeholder="Second Admin"></input>
                                     </g:if>
                                     <g:else>
                                         <input type="email" class="form-control form-control-no-border cr-placeholder cr-chrome-place text-color" name="email2" id="secondadmin" placeholder="Second Admin"></input>
                                     </g:else>
                                 </div>
                                </div>
                            </div>
                                
                            <div class="col-sm-4">
                                <div class="form-group">
                                 <div class="col-sm-12">
                                     <g:if test="${email3}">
                                         <input type="email" class="form-control form-control-no-border cr-placeholder cr-chrome-place text-color" name="email3" id="thirdadmin" value="${email3}" placeholder="Third Admin"></input>
                                     </g:if>
                                     <g:else>
                                         <input type="email" class="form-control form-control-no-border cr-placeholder cr-chrome-place text-color" name="email3" id="thirdadmin" placeholder="Third Admin"></input>
                                     </g:else>
                                 </div>
                                </div>
                            </div>       
					    </div>
                        <div class="tab-pane panel-body active row" id="organization">
                            <div class="col-sm-4">
                                <div class="form-group" id="organizationName">
                                    <div class="col-sm-12">
                                        <input class="form-control form-control-no-border cr-placeholder cr-chrome-place text-color" name="${FORMCONSTANTS.ORGANIZATIONNAME}" value="${project.organizationName}" id="organizationname" placeholder="Organization Name">
                                    </div>
                                </div>
                            </div>
                 
                            <div class="col-sm-4">
                                <div class="form-group">
                                    <div class="col-sm-12">
                                        <g:if test="${project.webAddress}">
                                            <input class="form-control form-control-no-border cr-placeholder cr-chrome-place text-color" name="${FORMCONSTANTS.WEBADDRESS}" id="webAddress" placeholder="Web Address" value="${project.webAddress}">
                                        </g:if>
                                        <g:else>
                                            <input class="form-control form-control-no-border cr-placeholder cr-chrome-place text-color" name="${FORMCONSTANTS.WEBADDRESS}" id="webAddress" placeholder="Web Address">
                                        </g:else>
                                    </div>
                                </div>
                            </div>

                            <div class="col-sm-4">
                                <div class="form-group">
                                    <div class="col-sm-6">
                                        <div class="fileUpload btn btn-info btn-sm cr-btn-color">
                                            <span>Organization Logo</span>
                                            <input type="file" class="upload" id="iconfile" name="iconfile" accept="image/jpeg, image/png">
                                        </div>
                                        <label class="docfile-orglogo-css" id="logomsg">Please select image file.</label>
                                        <label class="docfile-orglogo-css" id="iconfilesize">The file you are attempting to upload is larger than the permitted size of 3MB.</label>
                                    </div>
                                    <div id="icondiv" class="pr-icon-thumbnail-div col-sm-2">
                                        <img id="imgIcon" alt="cross" class="pr-icon-thumbnail">
                                        <div class="deleteicon orgicon-css-styles">
                                            <img alt="cross" onClick="removeLogo();" id="delIcon">
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="tab-pane panel-body row" id="personal">
                            <div class="col-sm-4">
                                <div class="form-group">
                                    <div class="col-sm-12">
                                        <input type="text" id="firstName" class="form-control form-control-no-border cr-placeholder cr-chrome-place text-color" name="${FORMCONSTANTS.FIRSTNAME}" value="${user.firstName}" placeholder="First Name">
                                    </div>
                                </div>
                            </div>

                            <div class="col-sm-4">
                                <div class="form-group">
                                    <div class="col-sm-12">
                                        <input type="text" id="lastName" class="form-control form-control-no-border cr-placeholder cr-chrome-place text-color" name="${FORMCONSTANTS.LASTNAME}" value="${user.lastName}" placeholder="Last Name">
                                    </div>
                                </div>
                            </div>

                            <div class="col-sm-4">
                                <div class="form-group">
                                    <div class="col-sm-12">
                                        <g:if test="${project.beneficiary.telephone}">
                                            <input type="tel" id="telephone" class="form-control form-control-no-border cr-placeholder cr-chrome-place text-color" name="${FORMCONSTANTS.TELEPHONE}" placeholder="Phone" value="${project.beneficiary.telephone}">
                                        </g:if>
                                        <g:else>
                                            <input type="tel" id="telephone" class="form-control form-control-no-border cr-placeholder cr-chrome-place text-color" name="${FORMCONSTANTS.TELEPHONE}" placeholder="Phone">
                                        </g:else>
                                    </div>
                                </div>
                            </div>
                            <div class="clear"></div>
                            <div class="col-sm-4">
                                <div class="form-group">
                                    <div class="col-sm-12">
                                        <g:if test="${project.beneficiary.facebookUrl}">
                                            <input type="text" id="facebookUrl" class="form-control form-control-no-border cr-placeholder cr-chrome-place text-color" name="${FORMCONSTANTS.FACEBOOKURl}" value="${project.beneficiary.facebookUrl}" placeholder="Facebook Url">
                                        </g:if>
                                        <g:else>
                                            <input type="text" id="facebookUrl" class="form-control form-control-no-border cr-placeholder cr-chrome-place text-color" name="${FORMCONSTANTS.FACEBOOKURl}" placeholder="Facebook Url">
                                        </g:else>
                                    </div>
                                </div>
                            </div>

                            <div class="col-sm-4">
                                <div class="form-group">
                                    <div class="col-sm-12">
                                        <g:if test="${project.beneficiary.twitterUrl}">
                                            <input type="text" id="twitterUrl" class="form-control form-control-no-border cr-placeholder cr-chrome-place text-color" name="${FORMCONSTANTS.TWITTERURl}" value="${project.beneficiary.twitterUrl}" placeholder="Twitter Url">
                                        </g:if>
                                        <g:else>
                                            <input type="text" id="twitterUrl" class="form-control form-control-no-border cr-placeholder cr-chrome-place text-color" name="${FORMCONSTANTS.TWITTERURl}" placeholder="Twitter Url">
                                        </g:else>
                                    </div>
                                </div>
                            </div>

                            <div class="col-sm-4">
                                <div class="form-group">
                                    <div class="col-sm-12">
                                        <g:if test="${project.beneficiary.linkedinUrl}">
                                            <input type="text" id="linkedinUrl" class="form-control form-control-no-border cr-placeholder cr-chrome-place text-color" name="${FORMCONSTANTS.LINKEDINURL}" placeholder="Linkedin Url" value="${project.beneficiary.linkedinUrl}">
                                        </g:if>
                                        <g:else>
                                            <input type="text" id="linkedinUrl" class="form-control form-control-no-border cr-placeholder cr-chrome-place text-color" name="${FORMCONSTANTS.LINKEDINURL}" placeholder="Linkedin Url">
                                        </g:else>
                                    </div>
                                </div>
                            </div>
                            
<%--                            <div class="col-sm-4">--%>
<%--                                <div class="form-group">--%>
<%--                                    <div class="col-sm-12">--%>
<%--                                        <g:hiddenField name="fbShareUrl" id="fbShareUrl" value="${fbShareUrl}"/>--%>
<%--                                         <a target="_blank" class="fb-like pull-left  cr-tab-icon-padding fbShareForSmallDevices" href="https://www.facebook.com/sharer/sharer.php?s=100&amp;&p[url]=${fbShareUrl}">--%>
<%--                                             <img src="//s3.amazonaws.com/crowdera/assets/facebook-Icon.png" alt="Facebook Share">--%>
<%--                                         </a>--%>
<%--                                         <a target="_blank" class="fb-like pull-left fbShareForLargeDevices cr-tab-icon-padding" id="fbshare">--%>
<%--                                             <img src="//s3.amazonaws.com/crowdera/assets/facebook-Icon.png" alt="Facebook Share">--%>
<%--                                         </a>--%>
<%--                                         <a class="share-linkedin pull-left cr-tab-icon-padding">--%>
<%--                                             <img src="//s3.amazonaws.com/crowdera/assets/twitter-Icon.png" alt="LinkedIn Share">--%>
<%--                                         </a>--%>
<%--                                         <a class="twitter-share pull-left" id="twitterShare" data-url="${base_url}/campaigns/${vanityTitle}/${vanityUsername}" target="_blank">--%>
<%--                                             <img src="//s3.amazonaws.com/crowdera/assets/linked-In--Icon.png" alt="Twitter Share">--%>
<%--                                         </a>--%>
<%--                                     </div>--%>
<%--                                 </div>--%>
<%--                             </div>--%>
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
	                <div class="col-sm-12 cr-lab-rd-flex cr-space" id="perk">
	                    <div class="cr-perks-flex cr-perks-space">
	                        <label class="panel-body cr-perks-size "><span class="cr-offering">Offering</span> PERKS?</label>
	                    </div>
	                    <div class="btn-group btnPerkBgColor col-sm-12 col-sm-push-6 cr-perk-yesno-tab cr-mobile-sp" data-target="buttons">
	                        <label class="btn btn-default col-sm-2 cr-lbl-mobile"> <input type="radio" name="answer" value="yes"> YES<i class="glyphicon glyphicon-chevron-down cr-perk-chevron-icon"></i></label> 
	                        <label class="btn btn-default col-sm-2 cr-lbl-mobiles"> <input type="radio" name="answer" value="no"> NO</label>
	                    </div>
	                </div>
                </div>
					
                <input type="hidden" name="rewardCount" id="rewardCount" value='0'/>
                <div id="addNewRewards">
                    <div class="rewardsTemplate" id="rewardTemplate">
                        <div class="col-sm-2">
                            <div class="form-group">
                                <div class="col-sm-12">
                                    <g:if test="${currentEnv == 'testIndia' || currentEnv == 'stagingIndia' || currentEnv == 'prodIndia'}">
                                        <span class="cr2-currency-label fa fa-inr cr-perks-amts"></span>
                                        <input type="text" placeholder="Amount" name="rewardPrice1" class="form-control form-control-no-border-amt rewardPrice cr-input-digit cr-tablat-padd rewardPrice" id="rewardPrice1">
                                    </g:if>
                                    <g:else>
                                        <span class="cr2-currency-label">$</span>
                                        <input type="text" placeholder="Amount" name="rewardPrice1" class="form-control rewardPrice form-control-no-border-amt cr-input-digit cr-tablat-padd rewardPrice" id="rewardPrice1">
                                    </g:else>
                                </div>
                            </div>
                        </div>
										
                        <div class="col-sm-5">
                            <div class="form-group">
                                <div class="col-sm-12">
                                    <input type="text" placeholder="Name of Perk" name="rewardTitle1" class="form-control cr-tablet-left cr-perk-title-number form-control-no-border text-color cr-placeholder cr-chrome-place required" id="rewardTitle1">
                                </div>
                            </div>
                        </div>
                        <div class="col-sm-5">
                            <div class="form-group">
                                <div class="col-sm-12">
                                    <input type="text" placeholder="Number available" name="rewardNumberAvailable1" class="form-control cr-perk-title-number form-control-no-border text-color cr-placeholder cr-chrome-place  rewardNumberAvailable" id="rewardNumberAvailable1">
                                </div>
                            </div>
                        </div>
                        
                        <div class="form-group">
                            <div class="col-sm-12">
                                <div class="col-sm-12">
                                    <textarea class="form-control rewardDescription form-control-no-border text-color cr-placeholder cr-chrome-place required" name="rewardDescription1" id="rewardDesc1" rows="2" placeholder="Description" maxlength="250"></textarea>
                                    <p class="cr-perk-des-font">Please refer to our Terms of Use for more details on perks.</p>
                                </div>
                            </div>
                        </div>
                        <div class="col-sm-12">
                            <div class="form-group">
                                <div class="btn-group col-sm-12" data-toggle="buttons">
                                    <label class="panel-body col-sm-2 col-xs-12 cr-check-btn-perks text-center">Mode of <br> Shipping</label>
                                    <label class="btn btn-default col-sm-2 col-xs-12 cr-hovers cr-font-perks"><input type="checkbox" name="mailingAddress1" value="true" id="mailaddcheckbox1">Mailing <br> address</label>
                                    <label class="btn btn-default col-sm-2 col-xs-12 cr-hovers cr-font-perks"><input type="checkbox" name="emailAddress1" value="true" id="emailcheckbox1">Email <br> address</label>
                                    <label class="btn btn-default col-sm-2 col-xs-12 cr-hovers cr-font-perks"><input type="checkbox" name="twitter1" value="true" id="twittercheckbox1">Twitter <br> handle</label>
                                    <input type="text" name="custom1" id="customcheckbox1" class="customText form-control-no-border text-color cr-custom-place cr-customchrome-place col-sm-4 col-xs-12" placeholder="Custom">
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="col-sm-12 perk-css" id="updatereward">
                        <div class="col-sm-12 perk-create-styls" align="right">
                            <div class="btn btn-primary btn-circle perks-css-create" id="savereward">
                                <i class="glyphicon glyphicon-floppy-save"></i>
                            </div>
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
                        <div class="cr-story-flx cr-payment-marg col-sm-12">
                            <label class="panel-body cr-payments-lab">PAYMENTS</label>
<%--                                            <img alt="" src="/images/Payment-Button.jpg">--%>
                            <label class="panel-body cr-payments">Payments are sent and received via your choice of Payment Gateway.
                               You keep 100% of the money you raise. Crowdera does not charge any fee to you.</label>
                        </div>
                        <label class="cr-pad-who">Who will recieve the funds</label>
                        <div class="btn-group col-sm-12 cr-perk-check cr-radio-option" data-toggle="buttons">
                            <label class="panel-body cr-check-btn-first text-center col-sm-3 col-xs-12 <g:if test="${project.usedFor == 'RECIEPIENT'}">active</g:if>" id="recipient"> <span class="cr-reci-siz">Recipient</span><span class="cr-pay-rd"> of funds</span></label>  
                            <label class="btn btn-default cr-check-btn col-sm-2 col-xs-12 cr-reci-siz <g:if test="${project.fundsRecievedBy == 'PERSON'}">active</g:if>" id="person"> <input type="radio" name="" value="yes">Person</label> 
                            <label class="btn btn-default cr-check-btn col-sm-3 col-xs-12 cr-mob-payments <g:if test="${project.fundsRecievedBy == 'NON-PROFITS'}">active</g:if>" id="non-profit"> <input type="radio" name="" value="no"><span class="cr-pay-rd">A US 501CC1</span><span class="cr-reci-siz"> Non-profit</span></label>
                            <label class="btn btn-default cr-check-btn col-sm-2 col-xs-12 cr-mob-payments <g:if test="${project.fundsRecievedBy == 'NGO'}">active</g:if>" id="ngo"> <input type="radio" name="" value="no"><span class="cr-pay-rd">A non-US </span><span class="cr-reci-siz">NGO</span></label>
                            <label class="btn btn-default cr-check-btn col-sm-2 col-xs-12 <g:if test="${project.fundsRecievedBy == 'OTHERS'}">active</g:if>" id="others"> <input type="radio" name="" value="no"><span class="cr-reci-siz">Others</span></label>
                        </div>
                    </div>
                </div>
                <div class="form-group">
                    <g:if test ="${currentEnv == 'testIndia' || currentEnv == 'stagingIndia' || currentEnv == 'prodIndia'}">
                        <div id="PayUMoney">
                            <div class="col-sm-12">
                                <div class="form-group">
                                    <label class="col-sm-4 control-label">PayU Email</label>
                                    <div class="col-sm-6">
                                        <g:if test="${project.payuEmail}">
                                            <input type="email" id="payuemail" class="form-control form-control-no-border text-color" name="${FORMCONSTANTS.PAYUEMAIL}" value="${project.payuEmail}">
                                        </g:if>
                                        <g:else>
                                             <input type="email" id="payuemail" class="form-control form-control-no-border text-color" name="${FORMCONSTANTS.PAYUEMAIL}">
                                        </g:else>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </g:if>
                    <g:else>
                        <div class="col-sm-12" id="paypalemail">
                            <div class="form-group">
                                <img class="col-sm-4 cr-paypal-image" src="//s3.amazonaws.com/crowdera/assets/paypal-Image.png">
                                <div class="col-sm-6 paypalVerification">
                                    <g:if test="${project.paypalEmail}">
                                        <input id="paypalEmailId" type="email" class="form-control paypal-create form-control-no-border cr-placeholder cr-chrome-place" value="${project.paypalEmail}" name="${FORMCONSTANTS.PAYPALEMAIL}" placeholder="Paypal email address">
                                    </g:if>
                                    <g:else>
                                        <input id="paypalEmailId" type="email" class="form-control paypal-create form-control-no-border cr-placeholder cr-chrome-place" name="${FORMCONSTANTS.PAYPALEMAIL}" placeholder="Paypal email address">
                                    </g:else>
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
                                    <g:if test="${project.charitableId}">
                                        <input type="text" id="hiddencharId" name="${FORMCONSTANTS.CHARITABLE}" value="${project.charitableId}" placeholder="charitableId" readonly>
                                    </g:if>
                                    <g:else>
                                        <input type="text" id="hiddencharId" name="${FORMCONSTANTS.CHARITABLE}" placeholder="charitableId" readonly>
                                    </g:else>
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
                                            </script>
                                            <script src="//assets.firstgiving.com/graphwidget/static/js/fg_graph_widget.min.js"></script>
                                        </div>
                                        <div class="modal-footer">
                                            <button href="#" data-dismiss="modal" class="btn btn-primary">Close</button>
                                            <button class="btn btn-primary" href="#" data-dismiss="modal" id="saveButton">Save</button>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </g:else>
                    <div class="col-sm-12 cr-paddingspace" id="launch">
                        <div class="col-sm-6 text-center">
                            <g:link class="cr-bg-preview-btn cr-btn-alignment-pre cr-btn-margin createsubmitbutton hidden-xs" id="${project.id}" params="['isPreview':true]" controller="project" action="manageCampaign"></g:link>
                            <g:link class="cr-bg-xs-preview-btn cr-xs-mobile createsubmitbutton visible-xs" id="${project.id}" params="['isPreview':true]" controller="project" action="manageCampaign"></g:link>
                        </div>
                        <g:hiddenField name="isSubmitButton" value="true" id="isSubmitButton"></g:hiddenField>
<%--                        <div class="col-sm-4 text-center padding-btn" >--%>
<%--                            <button type="button" class="btn  btn-primary btn-colors" name="button" id="saveasdraft"  value="draft">Save</button>--%>
<%--                        </div>--%>
                        <div class="col-sm-6 text-center">
                            <button type="button" class="cr-bg-Launch-btn cr-btn-alignment-lac cr-btn-launch createsubmitbutton hidden-xs" id="submitProject" name="button" value="submitProject"></button>
                            <button type="button" class="cr-bg-xs-Launch-btn cr-xs-mobile createsubmitbutton visible-xs" id="submitProjectXS" name="button" value="submitProject"></button>
                        </div>
                    </div>
                </div>
                
                <!-- Modal -->
                <div class="modal fade" id="addVideo" tabindex="-1" role="dialog" aria-hidden="true">
                    <div class="modal-dialog">
                        <div class="modal-content">
                            <div class="modal-header video-modal">
                                <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
                                <h3 class="modal-title text-center"><b>Upload Video</b></h3>
                            </div>
                            <div class="modal-body">
                                <div class="row">
                                    <div class="col-sm-10 form-group">
                                        <g:if test="${project.videoUrl}">
                                            <input id="videoUrl" class="form-control form-control-no-border text-color" name="${FORMCONSTANTS.VIDEO}" value="${project.videoUrl}" placeholder="Video URL">
                                        </g:if>
                                        <g:else>
                                            <input id="videoUrl" class="form-control form-control-no-border text-color" name="${FORMCONSTANTS.VIDEO}" placeholder="Video URL">
                                        </g:else>
                                    </div>
                                    <div class="col-sm-2">
                                        <button class="btn btn-info btn-sm cr-btn-color" href="#" data-dismiss="modal" id="add">Add</button>
                                    <div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </g:uploadForm>
            </div>
        </div>
	</div>
	<script type="text/javascript">
		var needToConfirm = true;
	    window.onbeforeunload = confirmExit;
	    function confirmExit()
	    {
	        if(needToConfirm){
	        	return "You have attempted to leave this page.  If you have made any changes to the fields without clicking the Save button, your changes will be lost.  Are you sure you want to exit this page?";
	        }
	    }
    </script>
    <script src="/js/main.js"></script>
    <script src="/js/bootstrap-datepicker.js"></script>
    <script type="text/javascript">

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
            }).on('changeDate', function(){
                autoSave('date', $('#datepicker').val());
            });
        });

        function autoSave(variable, varValue) {
            var projectId = $('#projectId').val();
            $.ajax({
                type:'post',
                url:$("#b_url").val()+'/project/autoSave',
                data:'projectId='+projectId+'&variable='+variable+'&varValue='+varValue,
                success: function(data) {
                    $('#test').val('test');
                }
            }).error(function() {
                alert('An error occured');
            });
        }

        function deleteAdmin(current, projectId, email, username) {
            var stat= confirm("Are you sure you want to delete this admin?");
            if(stat){
            if(email == "email1"){
                $('#firstadmin').val('');
                $('#logoDelete1').hide();  
             }
             if(email == "email2"){
                 $('#secondadmin').val('');
                 $('#logoDelete2').hide();  
             }
             if(email == "email3"){
                 $('#thirdadmin').val('');
                 $('#logoDelete3').hide();  
             }
         	                      
             $.ajax({
                  type:'post',
                  url:$("#b_url").val()+'/project/deleteCampaignAdmin',
                  data:'projectId='+projectId+'&username='+username,
                  success: function(data){
                  $('#test').html(data);
              }
              }).error(function(){
                  alert('An error occured');
              });
             }
         }

    </script>
</body>
</html>
