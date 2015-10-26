<g:set var="rewardService" bean="rewardService"/>
<%
    def request_url=request.getRequestURL().substring(0,request.getRequestURL().indexOf("/", 8))
    def base_url = (request_url.contains('www')) ? grailsApplication.config.crowdera.BASE_URL1 : grailsApplication.config.crowdera.BASE_URL
    def iteratorCount = 1
    def lastrewardCount = 1
    def rewardItrCount = projectRewards.size()
%>
<html>
<head>
<meta name="layout" content="main" />
<r:require modules="projectcreatejs" />

<link rel="stylesheet" href="/css/datepicker.css">
</head>
<body>
    <input type="hidden" id="b_url" value="<%=base_url%>" /> 
    <input type="hidden" name="uuid" id="uuid" />
    <input type="hidden" name="charity_name" id="charity_name" />
    <input type="hidden" name="url" value="${currentEnv}" id="currentEnv"/>
    <g:hiddenField name="payfir" value="${project.charitableId}" id="payfir"/>
    <g:hiddenField name="paypal" value="${project.paypalEmail}"/>
    <g:hiddenField name="projectamount" value="${project.amount}" id="projectamount"/>
    <g:hiddenField name="vanityUrlStatus" id="vanityUrlStatus" value="true"/>

    <div class="text-center">
        <header class="col-sm-12 col-xs-12 cr-tabs-link cr-ancher-tab">
            <a class=" col-sm-2 col-xs-2 cr-img-start-icon" href="#start"><div class="col-sm-0 cr-subheader-icons"><img class="cr-start TW-cr-sec-header-start-icon-width" src="//s3.amazonaws.com/crowdera/assets/start-Icon-White.png" alt="Start"></div><div class="hidden-xs"><b>Start</b></div></a>
            <a class=" col-sm-2 col-xs-2 cr-img-story-icon" href="#story"><div class="col-sm-0 cr-subheader-icons"><img class="cr-story TW-cr-sec-header-icon-width" src="//s3.amazonaws.com/crowdera/assets/story-Icon-White.png" alt="Story"></div><div class="hidden-xs"><b>Story</b></div></a>
            <a class=" col-sm-2 col-xs-2 cr-img-admin-icon" href="#admins"><div class="col-sm-0 cr-subheader-icons"><img class="cr-admin TW-cr-sec-header-icon-width" src="//s3.amazonaws.com/crowdera/assets/admin-Icon---White.png" alt="Admin"></div><div class="hidden-xs"><b>Admin</b></div></a>
            <a class=" col-sm-2 col-xs-2 cr-img-perk-icon" href="#perk"><div class="col-sm-0 cr-subheader-icons"><img class="cr-perk TW-cr-sec-header-icon-width" src="//s3.amazonaws.com/crowdera/assets/perk-Icon-White.png" alt="Perk"></div><div class="hidden-xs"><b>Perks</b></div></a>
            <a class=" col-sm-2 col-xs-2 cr-img-payment-icon" href="#payment"><div class="col-sm-0 cr-subheader-icons"><img class="cr-payment TW-cr-sec-header-icon-width" src="//s3.amazonaws.com/crowdera/assets/payment-Icon-White.png" alt="Payment"></div><div class="hidden-xs"><b>Payment</b></div></a>
            <a class=" col-sm-2 col-xs-2 cr-img-launch-icon" href="#launch"><div class="col-sm-0 cr-subheader-icons"><img class="cr-launch TW-cr-sec-header-launch-icon-width" src="//s3.amazonaws.com/crowdera/assets/launch-Icon--White.png" alt="Launch"></div><div class="hidden-xs"><b>Launch</b></div></a>
        </header>
    </div>
    <div class="bg-color col-sm-12 col-xs-12 cr-top-space">
        <div class="container footer-container" id="campaigncreate">
        <g:uploadForm class="form-horizontal"  controller="project" action="campaignOnDraftAndLaunch" params="['title': vanityTitle, 'userName':vanityUsername]">
            <g:hiddenField name="projectId" id="projectId" value="${project.id}"/>
            <div class="startsection"></div>

            <div class="col-sm-12 cr-start-flex cr-lft-mobile cr-safari" id="start">
                <label class="panel body cr-start-size cr-safari">START</label>
                <div class="form-group col-sm-10 cr-start-space campaignEndDateError">

                    <div class="col-sm-3 deadline-popover">
                        <div class="input-group enddate">
                            <g:if test="${campaignEndDate}">
                                <input class="datepicker pull-left cr-datepicker-height cr-mob-datepicker" id="datepicker" name="${FORMCONSTANTS.DAYS}" readonly="readonly" value="${campaignEndDate}" placeholder="Deadline"> 
                            </g:if>
                            <g:else>
                                <input class="datepicker pull-left cr-datepicker-height cr-mob-datepicker" id="datepicker" name="${FORMCONSTANTS.DAYS}" readonly="readonly" placeholder="Deadline">
                            </g:else>
                            <img class="hidden-xs deadlineInfo-img pull-right" src="//s3.amazonaws.com/crowdera/assets/Information-Icon.png" alt="Information icon"><i class="fa fa-caret-down cr-caret-size" style="position:absolute;"></i>
                        </div>
                    </div>
                    <div class="col-sm-3">
                        <div class="font-list">
                            <g:if test="${project.category && project.category.toString() != 'OTHER'}">
                                <g:select class="selectpicker cr-start-dropdown-category cr-drops cr-opn-dropdown cr-drop-color cr-all-mobile-dropdown" name="${FORMCONSTANTS.CATEGORY}" from="${categoryOptions}" id="category" optionKey="key" optionValue="value" value="${project.category}"/>
                            </g:if>
                            <g:else>
                                <g:select class="selectpicker cr-start-dropdown-category cr-drops cr-opn-dropdown cr-drop-color cr-all-mobile-dropdown" name="${FORMCONSTANTS.CATEGORY}" from="${categoryOptions}" id="category" optionKey="key" optionValue="value" noSelection="['null':'Category']"/>
                            </g:else>
                        </div>
                    </div>
                    <div class="col-sm-3">
                        <div class="cr-dropdown-alignment font-list">
                            <g:if test="${project.beneficiary.country}">
                                <g:select style="width:0px !important;" class="selectpicker cr-drops cr-drop-color cr-start-dropdown-country cr-all-mobile-dropdown" id="country" name="${FORMCONSTANTS.COUNTRY}" from="${country}" value="${project.beneficiary.country}" optionKey="key" optionValue="value" />
                            </g:if>
                            <g:else>
                                <g:select style="width:0px !important;" class="selectpicker cr-drops cr-drop-color cr-start-dropdown-country cr-all-mobile-dropdown" id="country" name="${FORMCONSTANTS.COUNTRY}" from="${country}" value="#" optionKey="key" optionValue="value" noSelection="['null':'Country']"/>
                            </g:else>
                        </div>
                    </div>
                    <div class="col-sm-3">
                        <div class="font-list">
                            <g:if test="${project.payuEmail}">
                                <g:select class="selectpicker cr-start-dropdown-payment cr-drops cr-drop-color cr-all-mobile-dropdown" name="${FORMCONSTANTS.PAYMENT}" from="${payOpts}" id="paymentOpt" value="PAYU" optionKey="key" optionValue="value" />
                            </g:if>
                            <g:elseif test="${project.charitableId}">
                                <g:select class="selectpicker cr-start-dropdown-payment cr-drops cr-drop-color cr-all-mobile-dropdown" name="${FORMCONSTANTS.PAYMENT}" from="${payOpts}" id="paymentOpt" value="FIR" optionKey="key" optionValue="value" />
                            </g:elseif>
                            <g:elseif test="${project.paypalEmail}">
                                <g:select class="selectpicker cr-start-dropdown-payment cr-drops cr-drop-color cr-all-mobile-dropdown" name="${FORMCONSTANTS.PAYMENT}" from="${payOpts}" id="paymentOpt" value="PAY" optionKey="key" optionValue="value" />
                            </g:elseif>
                            <g:else>
                                <g:select class="selectpicker cr-start-dropdown-payment cr-drops cr-drop-color cr-all-mobile-dropdown" name="${FORMCONSTANTS.PAYMENT}" from="${payOpts}" id="paymentOpt" value="${FORMCONSTANTS.PAYMENT}" optionKey="key" optionValue="value" noSelection="['null':'Payment']"/>
                            </g:else>
                        </div>
                    </div>
                </div>
            </div>

            <g:hiddenField name="campaignvideoUrl" value="${project.videoUrl}" id="addvideoUrl"/>
            <div class="col-sm-6 video-popover" id="media">
                <div class="panel panel-default panel-create-size" id="videoBox">
                    <div class="form-group">
                        <div class="col-md-10 col-xs-8 col-videoUrl-textbox">
                            <input class="form-control form-control-no-border text-color videoUrl" name="${FORMCONSTANTS.VIDEO}" placeholder="Video URL">
                        </div>
                        <div class="col-sm-2 col-xs-2 col-videoUrl-button">
                            <button type="button" class="btn btn-info btn-sm cr-btn-color add">Add</button>
                        </div>
                    </div>
                </div>
                <img class="videoInfo-img" src="//s3.amazonaws.com/crowdera/assets/Information-Icon.png" alt="Information icon">
            </div>
            <div class="col-sm-6 video-popover" id="media-video">
                <div class="panel panel-default panel-create-size">
                    <div class="panel-body">
                        <div class="form-group">
                            <div class="col-sm-6" id="ytVideo"></div>
                        </div>
                        <span class="videoUrledit close" id="videoUrledit"><i class="glyphicon glyphicon-edit" ></i></span>
                        <span class="videoUrledit close"><i class="glyphicon glyphicon-trash" id="deleteVideo"></i></span>
                    </div>
                </div>
                <img class="videoInfo-img" src="//s3.amazonaws.com/crowdera/assets/Information-Icon.png" alt="Information icon">
            </div>

            <div class="col-sm-6 image-popover">
                <div class="panel panel-default panel-create-size upload-campaign-pic panel-pic-uploaded <g:if test="${!project.imageUrl}">panel-hidden</g:if>">
                    <div class="form-group" id="createthumbnail">
                        <div class="createpage-img-panel">
                            <div class="col-sm-12 pad-result" id="campaignthumbnails">
                                <g:each var="imgurl" in="${project.imageUrl}">
                                    <div id="imgdiv" class="pr-thumb-div">
                                        <img alt="image" class='pr-thumbnail' src='${imgurl.url }' id="imgThumb${imgurl.id}">
                                        <div class="deleteicon pictures-edit-deleteicon">
                                            <img alt="cross" onClick="deleteProjectImage(this,'${imgurl.id}','${project.id}');" src="//s3.amazonaws.com/crowdera/assets/delete.ico">
                                        </div>
                                    </div>
                                </g:each>
                            </div>
                            <div class="clear"></div>
                            <div class="col-md-12">
                                <div id="uploadingCampaignImage">Uploading Picture......</div>
                                <div class="imageNumValidation">You cannot upload more than 5 images</div>
                                <label class="docfile-orglogo-css imgmsg">Please select image file.</label>
                                <label class="docfile-orglogo-css campaignfilesize" id="campaignFilesizeID"></label>
                            </div>
                        </div>

                        <div class="col-pictures pull-right">
                            <div class="fileUpload btn btn-info btn-sm cr-btn-color">
                                Add Image 
                                <input type="file" class="upload" name="addCampaignImage" id="campaignImage" accept="image/jpeg, image/png">
                            </div>
                        </div>
                    </div>
                </div>
                <div class="panel panel-default panel-create-size upload-campaign-pic panel-no-image <g:if test="${project.imageUrl}">panel-hidden</g:if>">
                    <div class="col-sm-12 col-add-picture">
                        <div class="fileUpload btn btn-info btn-sm cr-btn-color ">
                            Add Image
                            <input type="file" class="upload" name="${FORMCONSTANTS.THUMBNAIL}[]" id="projectImageFile" accept="image/jpeg, image/png">
                        </div>
                    </div>
                    <div class="clear"></div>
                    <div class="col-sm-12 col-error-placement" id="col-error-placement">
                        <label class="docfile-orglogo-css imgmsg">Please select image file.</label>
                        <label class="docfile-orglogo-css campaignfilesize" id="campaignFilesizeID1"></label>
                    </div>
                </div>
                <img class="pictureInfo-img" src="//s3.amazonaws.com/crowdera/assets/Information-Icon.png" alt="Information icon">
            </div>

            <div class="col-sm-12" id="story">
                <div class="form-group">
                    <div class="col-sm-12 cr-story-padding">
                        <div class="cr-story-flx cr-safari">
                            <label class="panel body cr-story-size cr-safari">STORY</label>
                            <label class="panel-body cr-panel-story">A good engaging story is the backbone of your Campaign.
                                                     You want your readers to be compelled to share your story
                                                     and make your campaign go viral. Be passionate and make 
                                                     them believe and trust your goal.</label>
                        </div>
                        <textarea name="${FORMCONSTANTS.STORY}" class="redactorEditor">
                            <g:if test="${project.story}">${project.story}</g:if>
                        </textarea>
                        <span id="storyRequired">Ths field is required</span>
                        <g:hiddenField name="projectHasStory" id="projectHasStory" value="${project.story}"/>
                    </div>
                </div>
            </div>
                     
            <div class="col-sm-12 manage-Top-tabs-mobile" id="admins">
                <div class="cr-tabs-admins cr-safari">
                    <label class="panel body cr-admin-title cr-safari">ADMIN</label>
                    <ul class="nav nav-tabs manage-projects cr-safari-mobile nav-justified cr-ul-tabs">
                        <li class="cr-li-tabs cr-li-tabsss cr-hover-color">
                            <a href="#admin" data-toggle="tab" aria-expanded="false">
                                <span class="glyphicon glyphicon-user cr-icon-tabs-user visible-xs"></span><span class="tab-text hidden-xs cr-add-tabs-title cr-font-title pull-left">Add Campaign Admin</span><i class="glyphicon glyphicon-chevron-down cr-tab-in cr-tab-icons hidden-xs pull-right"></i>
                            </a>
                        </li>
                        <li class="active cr-tabs-update cr-li-tabsss cr-hover-color">
                            <a data-toggle="tab" href="#organization" aria-expanded="true">
                                <span class="glyphicon glyphicon-eye-open cr-icon-tabs-eye visible-xs"></span><span class="tab-text hidden-xs cr-font-title pull-left">Update Display Information</span><i class="glyphicon glyphicon-chevron-down cr-tab-in cr-tab-icons hidden-xs pull-right"></i>
                            </a>
                        </li>
                        <li class="cr-tabs-update cr-li-tabsss cr-hover-color">
                            <a data-toggle="tab" href="#personal"> 
                                <span class="glyphicon glyphicon-info-sign cr-icon-tabs-info visible-xs"></span><span class="tab-text hidden-xs cr-font-title pull-left">Update Personal Information</span><i class="glyphicon glyphicon-chevron-down cr-tab-in cr-tab-icons hidden-xs pull-right"></i>
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
                                        <input type="email" class="form-control form-control-no-border cr-placeholder cr-chrome-place text-color cr-marg-mobile" name="email1" id="firstadmin" value="${email1}" placeholder="First Admin">
                                    </g:if>
                                    <g:else>
                                        <input type="email" class="form-control form-control-no-border cr-placeholder cr-chrome-place text-color cr-marg-mobile" name="email1" id="firstadmin" placeholder="First Admin">
                                    </g:else>
                                </div>
                            </div>
                        </div>
                                      
                        <div class="col-sm-4">
                            <div class="form-group">
                                <div class="col-sm-12">
                                    <g:if test="${email2}">
                                        <input type="email" class="form-control form-control-no-border cr-placeholder cr-chrome-place text-color cr-marg-mobile" name="email2" id="secondadmin" value="${email2}" placeholder="Second Admin">
                                    </g:if>
                                    <g:else>
                                        <input type="email" class="form-control form-control-no-border cr-placeholder cr-chrome-place text-color cr-marg-mobile" name="email2" id="secondadmin" placeholder="Second Admin">
                                    </g:else>
                                </div>
                            </div>
                        </div>
                                
                        <div class="col-sm-4">
                            <div class="form-group">
                                <div class="col-sm-12">
                                    <g:if test="${email3}">
                                        <input type="email" class="form-control form-control-no-border cr-placeholder cr-chrome-place text-color cr-marg-mobile" name="email3" id="thirdadmin" value="${email3}" placeholder="Third Admin">
                                    </g:if>
                                    <g:else>
                                        <input type="email" class="form-control form-control-no-border cr-placeholder cr-chrome-place text-color cr-marg-mobile" name="email3" id="thirdadmin" placeholder="Third Admin">
                                    </g:else>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="tab-pane panel-body active row" id="organization">
                        <div class="col-sm-4">
                            <div class="form-group" id="organizationName">
                                <div class="col-sm-12">
                                    <input class="form-control form-control-no-border cr-placeholder cr-chrome-place text-color cr-marg-mobile" name="${FORMCONSTANTS.ORGANIZATIONNAME}" value="${project.organizationName}" id="organizationname" placeholder="Individual / Organization Name">
                                </div>
                            </div>
                        </div>
                        <div class="col-sm-4">
                            <div class="form-group">
                                <div class="col-sm-12">
                                    <g:if test="${project.webAddress}">
                                        <input class="form-control form-control-no-border cr-placeholder cr-chrome-place text-color cr-marg-mobile" name="${FORMCONSTANTS.WEBADDRESS}" id="webAddress" placeholder="URL / Web Address / Facebook" value="${project.webAddress}">
                                    </g:if>
                                    <g:else>
                                        <input class="form-control form-control-no-border cr-placeholder cr-chrome-place text-color cr-marg-mobile" name="${FORMCONSTANTS.WEBADDRESS}" id="webAddress" placeholder="URL / Web Address / Facebook">
                                    </g:else>
                                </div>
                            </div>
                        </div>
                        <div class="col-sm-4">
                            <div class="form-group createOrgIconDiv">
                                <div class="col-sm-6">
                                    <div class="fileUpload btn btn-info btn-sm cr-btn-color cr-marg-mobile">
                                        Display Picture
                                        <input type="file" class="upload" id="iconfile" name="iconfile" accept="image/jpeg, image/png">
                                    </div>
                                    <label class="docfile-orglogo-css" id="logomsg">Please select image file.</label>
                                    <label class="docfile-orglogo-css" id="iconfilesize">The file you are attempting to upload is larger than the permitted size of 3MB.</label>
                                </div>
                                <g:if test="${project.organizationIconUrl}">
                                    <div class="pr-icon-thumbnail-div edit-image-mobile col-sm-2">
                                        <img id="imgIcon" alt="cross" class="pr-icon-thumbnail" src="${project.organizationIconUrl}">
                                        <div class="deleteicon orgicon-css-styles">
                                            <img alt="cross" onClick="deleteOrganizationLogo(this,'${project.id}');" src="//s3.amazonaws.com/crowdera/assets/delete.ico" id="logoDelete">
                                        </div>
                                    </div>
                                </g:if>
                                <g:else>
                                    <div id="icondiv" class="pr-icon-thumbnail-div cr-image-mobile col-sm-2">
                                        <img id="imgIcon" alt="cross" class="pr-icon-thumbnail">
                                        <div class="deleteicon orgicon-css-styles">
                                            <img alt="cross" onClick="removeLogo();" id="delIcon" src="//s3.amazonaws.com/crowdera/assets/delete.ico">
                                        </div>

                                    </div>
                                </g:else>
                                <div class="clear"></div>
                                <div class="col-sm-12">
                                    <div id="uploadingCampaignOrgIcon">Uploading Organization Icon....</div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="tab-pane panel-body row" id="personal">
                        <div class="col-sm-4">
                            <div class="form-group">
                                <div class="col-sm-12">
                                    <input type="text" id="firstName" class="form-control form-control-no-border cr-placeholder cr-chrome-place text-color cr-marg-mobile" name="${FORMCONSTANTS.FIRSTNAME}" value="${user.firstName}" placeholder="First Name" readonly>
                                </div>
                            </div>
                        </div>

                        <div class="col-sm-4">
                            <div class="form-group">
                                <div class="col-sm-12">
                                    <input type="text" id="lastName" class="form-control form-control-no-border cr-placeholder cr-chrome-place text-color cr-marg-mobile" name="${FORMCONSTANTS.LASTNAME}" value="${user.lastName}" placeholder="Last Name" readonly>
                                </div>
                            </div>
                        </div>

                        <div class="col-sm-4">
                            <div class="form-group">
                                <div class="col-sm-12">
                                    <g:if test="${project.beneficiary.email}">
                                        <input type="email" id="email" class="form-control form-control-no-border cr-placeholder cr-chrome-place text-color cr-marg-mobile" name="${FORMCONSTANTS.EMAIL}" placeholder="email" value="${project.beneficiary.email}">
                                    </g:if>
                                    <g:else>
                                        <input type="email" id="email" class="form-control form-control-no-border cr-placeholder cr-chrome-place text-color cr-marg-mobile" name="${FORMCONSTANTS.EMAIL}" placeholder="email">
                                    </g:else>
                                </div>
                            </div>
                        </div>
                        <div class="clear"></div>
                        <div class="col-sm-4">
                            <div class="form-group">
                                <div class="col-sm-12">
                                    <g:if test="${project.beneficiary.facebookUrl}">
                                        <input type="text" id="facebookUrl" class="form-control form-control-no-border cr-placeholder cr-chrome-place text-color cr-marg-mobile" name="${FORMCONSTANTS.FACEBOOKURl}" value="${project.beneficiary.facebookUrl}" placeholder="Facebook Url">
                                    </g:if>
                                    <g:else>
                                        <input type="text" id="facebookUrl" class="form-control form-control-no-border cr-placeholder cr-chrome-place text-color cr-marg-mobile" name="${FORMCONSTANTS.FACEBOOKURl}" placeholder="Facebook Url">
                                    </g:else>
                                </div>
                            </div>
                        </div>

                        <div class="col-sm-4">
                            <div class="form-group">
                                <div class="col-sm-12">
                                    <g:if test="${project.beneficiary.twitterUrl}">
                                        <input type="text" id="twitterUrl" class="form-control form-control-no-border cr-placeholder cr-chrome-place text-color cr-marg-mobile" name="${FORMCONSTANTS.TWITTERURl}" value="${project.beneficiary.twitterUrl}" placeholder="Twitter Url">
                                    </g:if>
                                    <g:else>
                                        <input type="text" id="twitterUrl" class="form-control form-control-no-border cr-placeholder cr-chrome-place text-color cr-marg-mobile" name="${FORMCONSTANTS.TWITTERURl}" placeholder="Twitter Url">
                                    </g:else>
                                </div>
                            </div>
                        </div>

                        <div class="col-sm-4">
                            <div class="form-group">
                                <div class="col-sm-12">
                                    <g:if test="${project.beneficiary.linkedinUrl}">
                                        <input type="text" id="linkedinUrl" class="form-control form-control-no-border cr-placeholder cr-chrome-place text-color cr-marg-mobile" name="${FORMCONSTANTS.LINKEDINURL}" placeholder="Linkedin Url" value="${project.beneficiary.linkedinUrl}">
                                    </g:if>
                                    <g:else>
                                        <input type="text" id="linkedinUrl" class="form-control form-control-no-border cr-placeholder cr-chrome-place text-color cr-marg-mobile" name="${FORMCONSTANTS.LINKEDINURL}" placeholder="Linkedin Url">
                                    </g:else>
                                </div>
                            </div>
                        </div>
                        <div class="clear"></div>
                        <div class="col-sm-4">
                            <div class="form-group">
                                <div class="col-sm-12">
                                    <g:if test="${project.beneficiary.telephone}">
                                        <input type="tel" id="telephone" class="form-control form-control-no-border cr-placeholder cr-chrome-place text-color cr-marg-mobile" name="${FORMCONSTANTS.TELEPHONE}" placeholder="Phone" value="${project.beneficiary.telephone}">
                                    </g:if>
                                    <g:else>
                                        <input type="tel" id="telephone" class="form-control form-control-no-border cr-placeholder cr-chrome-place text-color cr-marg-mobile" name="${FORMCONSTANTS.TELEPHONE}" placeholder="Phone">
                                    </g:else>
                                </div>
                            </div>
                        </div>
                        <div class="col-sm-8">
                            <div class="form-group">
                                <div class="col-sm-12">
                                    <g:if test="${currentEnv == 'development'}">
                                    <div class="col-lg-6 col-md-6 col-sm-6 col-xs-12 customUrlLabel">localhost:8080/campaigns/</div>
                                    <div class="col-lg-6 col-md-6 col-sm-6 col-xs-12 customUrlTextBoxDev">
                                        <input class="form-control form-control-no-border cr-placeholder cr-chrome-place text-color cr-marg-mobile customVanityUrl" name="customVanityUrl" id="customVanityUrl" placeholder="Custom Vanity Url" value="${project.customVanityUrl}">
                                    </div>
                                    </g:if>
                                    <g:elseif test="${currentEnv == 'test'}">
                                    <div class="col-lg-6 col-md-6 col-sm-6 col-xs-12 customUrlLabel">test.crowdera.co/campaigns/</div>
                                    <div class="col-lg-6 col-md-6 col-sm-6 col-xs-12 customUrlTextBoxTest ">
                                        <input class="form-control form-control-no-border cr-placeholder cr-chrome-place text-color cr-marg-mobile customVanityUrlTest" name="customVanityUrl" id="customVanityUrl" placeholder="Custom Vanity Url" value="${project.customVanityUrl}">
                                    </div>
                                    </g:elseif>
                                    <g:elseif test="${currentEnv == 'testIndia'}">
                                    <div class="col-lg-6 col-md-6 col-sm-6 col-xs-12 customUrlLabel">test.crowdera.in/campaigns/</div>
                                    <div class="col-lg-6 col-md-6 col-sm-6 col-xs-12 customUrlTextBoxTest ">
                                        <input class="form-control form-control-no-border cr-placeholder cr-chrome-place text-color cr-marg-mobile customVanityUrlTest" name="customVanityUrl" id="customVanityUrl" placeholder="Custom Vanity Url" value="${project.customVanityUrl}">
                                    </div>
                                    </g:elseif>
                                    <g:elseif test="${currentEnv == 'staging'}">
                                    <div class="col-lg-6 col-md-6 col-sm-6 col-xs-12 customUrlLabel customUrlLabelStaging">staging.crowdera.co/campaigns/</div>
                                    <div class="col-lg-6 col-md-6 col-sm-6 col-xs-12 customUrlTextBoxStaging ">
                                        <input class="form-control form-control-no-border cr-placeholder cr-chrome-place text-color cr-marg-mobile customVanityUrlStaging" name="customVanityUrl" id="customVanityUrl" placeholder="Custom Vanity Url" value="${project.customVanityUrl}">
                                    </div>
                                    </g:elseif>
                                    <g:elseif test="${currentEnv == 'stagingIndia'}">
                                    <div class="col-lg-6 col-md-6 col-sm-6 col-xs-12 customUrlLabel customUrlLabelStaging">staging.crowdera.in/campaigns/</div>
                                    <div class="col-lg-6 col-md-6 col-sm-6 col-xs-12 customUrlTextBoxStaging ">
                                        <input class="form-control form-control-no-border cr-placeholder cr-chrome-place text-color cr-marg-mobile customVanityUrlStaging" name="customVanityUrl" id="customVanityUrl" placeholder="Custom Vanity Url" value="${project.customVanityUrl}">
                                    </div>
                                    </g:elseif>
                                    <g:elseif test="${currentEnv == 'production'}">
                                    <div class="col-lg-6 col-md-6 col-sm-6 col-xs-12 customUrlLabel">crowdera.co/campaigns/</div>
                                    <div class="col-lg-6 col-md-6 col-sm-6 col-xs-12 customUrlTextBoxProd ">
                                        <input class="form-control form-control-no-border cr-placeholder cr-chrome-place text-color cr-marg-mobile customVanityUrlProd" name="customVanityUrl" id="customVanityUrl" placeholder="Custom Vanity Url" value="${project.customVanityUrl}">
                                    </div>
                                    </g:elseif>
                                    <g:elseif test="${currentEnv == 'prodIndia'}">
                                    <div class="col-lg-6 col-md-6 col-sm-6 col-xs-12 customUrlLabel">crowdera.in/campaigns/</div>
                                    <div class="col-lg-6 col-md-6 col-sm-6 col-xs-12 customUrlTextBoxProd">
                                        <input class="form-control form-control-no-border cr-placeholder cr-chrome-place text-color cr-marg-mobile customVanityUrlProd" name="customVanityUrl" id="customVanityUrl" placeholder="Custom Vanity Url" value="${project.customVanityUrl}">
                                    </div>
                                    </g:elseif>
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
                <div class="col-sm-12 cr-lab-rd-flex cr-space cr-safari" id="perk">
                    <div class="cr-perks-flex cr-perks-space cr-safari">
                        <label class="panel-body cr-perks-size "><span class="cr-offering">Offering</span> PERKS?</label>
                    </div>
                    <div class="btn-group btnPerkBgColor col-sm-push-6 cr-perk-yesno-tab cr-mobile-sp ie-cr-perks" data-target="buttons">
                        <label class="btn btn-default cr-lbl-mobile"> <input type="radio" name="answer" value="yes" id="yesradio"> YES<i class="glyphicon glyphicon-chevron-down cr-perk-chevron-icon"></i></label> 
                        <label class="btn btn-default cr-lbl-mobiles"> <input type="radio" name="answer" value="no" id="noradio"> NO</label>
                    </div>
             </div>
            </div>

            <div id="addNewRewards">
                <g:if test="${rewardItrCount > 0}">
                    <g:each in="${projectRewards}" var="reward">
                        <%
                            def shippingInfo = rewardService.getRewardShippingObjectByReward(reward);
                            def price = (reward.price).round()
                            lastrewardCount = reward.rewardCount
                        %>
                        <div class="rewardsTemplate" id="rewardTemplate${reward.rewardCount}" value="${reward.rewardCount}">
                            <div class="col-sm-2">
                                <div class="form-group">
                                    <div class="col-sm-12">
                                        <g:if test="${currentEnv == 'testIndia' || currentEnv == 'stagingIndia' || currentEnv == 'prodIndia'}">
                                            <span class="cr2-currency-label fa fa-inr cr-perks-amts"></span>
                                            <input type="text" placeholder="Amount" name="rewardPrice${reward.rewardCount}" class="form-control form-control-no-border-amt rewardPrice cr-input-digit cr-tablat-padd rewardPrice" id="rewardPrice${reward.rewardCount}" value="${price}">
                                        </g:if>
                                        <g:else>
                                            <span class="cr2-currency-label">$</span>
                                            <input type="text" placeholder="Amount" name="rewardPrice${reward.rewardCount}" class="form-control rewardPrice form-control-no-border-amt cr-input-digit cr-tablat-padd rewardPrice" id="rewardPrice${reward.rewardCount}" value="${price}">
                                        </g:else>
                                    </div>
                                </div>
                            </div>
          
                            <div class="col-sm-5">
                                <div class="form-group">
                                    <div class="col-sm-12">
                                        <input type="text" placeholder="Name of Perk" name="rewardTitle${reward.rewardCount}" class="form-control cr-tablet-left cr-perk-title-number form-control-no-border text-color cr-placeholder cr-chrome-place rewardTitle" id="rewardTitle${reward.rewardCount}" value="${reward.title}">
                                    </div>
                                </div>
                            </div>
                            <div class="col-sm-5">
                                <div class="form-group">
                                    <div class="col-sm-12">
                                        <input type="text" placeholder="Number available" name="rewardNumberAvailable${reward.rewardCount}" class="form-control cr-perk-title-number form-control-no-border text-color cr-placeholder cr-chrome-place  rewardNumberAvailable" id="rewardNumberAvailable${reward.rewardCount}" value="${reward.numberAvailable}">
                                    </div>
                                </div>
                            </div>
                        
                            <div class="form-group">
                                <div class="col-sm-12">
                                    <div class="col-sm-12">
                                        <textarea class="form-control rewardDescription form-control-no-border text-color cr-placeholder cr-chrome-place" name="rewardDescription${reward.rewardCount}" id="rewardDesc${reward.rewardCount}" rows="2" placeholder="Let your contributors feel special by rewarding them. Think out of the box and leave your contributors awestruck. Make sure you have calculated the costs associated with the perk; you do not want to lose money!" maxlength="250">${reward.description}</textarea>
                                        <p class="cr-perk-des-font">Please refer to our <a href="${resource(dir: '/termsofuse')}" target="_blank">Terms  Of  Use</a> for more details on perks.</p>
                                    </div>
                                </div>
                            </div>
                            
                            <div class="col-sm-12">
                                <div class="form-group">
                                    <div class="btn-group col-sm-12" data-toggle="buttons">
                                        <label class="panel-body col-sm-2 col-xs-12 cr-check-btn-perks text-center">Mode of <br> Delivery</label>
                                        <g:if test="${shippingInfo.address}">
                                            <label class="btn btn-default col-sm-2 col-xs-12 cr-hovers cr-font-perks shippingAddress cr-perks-back-color lblmail${reward.rewardCount} active"><input type="checkbox" checked="checked" name="mailingAddress${reward.rewardCount}" value="true" id="mailaddcheckbox${reward.rewardCount}">Mailing <br> address</label>
                                        </g:if>
                                        <g:else>
                                            <label class="btn btn-default col-sm-2 col-xs-12 cr-hovers cr-font-perks  shippingAddress cr-perks-back-color lblmail${reward.rewardCount}"><input type="checkbox" name="mailingAddress${reward.rewardCount}" value="true" id="mailaddcheckbox${reward.rewardCount}">Mailing <br> address</label>
                                        </g:else>
                                        <g:if test="${shippingInfo.email}">
                                            <label class="btn btn-default col-sm-2 col-xs-12 cr-hovers cr-font-perks shippingEmail cr-perks-back-color lblemail${reward.rewardCount} active"><input type="checkbox" checked="checked" name="emailAddress${reward.rewardCount}" value="true" id="emailcheckbox${reward.rewardCount}">Email <br> address</label>
                                        </g:if>
                                        <g:else>
                                            <label class="btn btn-default col-sm-2 col-xs-12 cr-hovers cr-font-perks shippingEmail cr-perks-back-color lblemail${reward.rewardCount}"><input type="checkbox" name="emailAddress${reward.rewardCount}" value="true" id="emailcheckbox${reward.rewardCount}">Email <br> address</label>
                                        </g:else>
                                        <g:if test="${shippingInfo.twitter}">
                                            <label class="btn btn-default col-sm-2 col-xs-12 cr-hovers cr-font-perks shippingTwitter cr-perks-back-color lbltwitter${reward.rewardCount} active"><input type="checkbox" checked="checked" name="twitter${reward.rewardCount}" value="true" id="twittercheckbox${reward.rewardCount}">Twitter <br> handle</label>
                                        </g:if>
                                        <g:else>
                                            <label class="btn btn-default col-sm-2 col-xs-12 cr-hovers cr-font-perks shippingTwitter cr-perks-back-color lbltwitter${reward.rewardCount}"><input type="checkbox" name="twitter${reward.rewardCount}" value="true" id="twittercheckbox${reward.rewardCount}">Twitter <br> handle</label>
                                        </g:else>
                                        <input type="text" name="custom${reward.rewardCount}" id="customcheckbox${reward.rewardCount}" class="customText form-control-no-border text-color cr-custom-place cr-perks-back-color cr-customchrome-place col-sm-4 col-xs-12" placeholder="Custom" value="${shippingInfo.custom}">
                                    </div>
                                </div>
                            </div>
                            <g:hiddenField name="rewardNum" id="rewardNum${reward.rewardCount}" value="${reward.rewardCount}" class="rewardNum"/>
                            <g:if test="${rewardItrCount > iteratorCount}">
                                <div class="col-sm-12 perk-css editDeleteReward" id="editDeleteReward${reward.rewardCount}">
                                    <div class="col-sm-12 perk-create-styls edit-top-gsp perkEditDeleteAlign">
                                        <span class="perkSaveMessage" id="perkSaveMessage${reward.rewardCount}">Perk Saved</span>
                                        <div class="btn btn-circle perks-created-remove intutive-glyphicon editreward" id="editreward${reward.rewardCount}" value="${reward.rewardCount}">
                                            <i class="glyphicon glyphicon-floppy-save"></i>
                                        </div>
                                        <div class="btn btn-circle perks-created-remove intutive-glyphicon deletereward" id="deletereward${reward.rewardCount}" value="${reward.rewardCount}">
                                            <i class="glyphicon glyphicon-trash"></i>
                                        </div>
                                    </div>
                                </div>
                            </g:if>
                        </div>
                        <% iteratorCount++; %>
                    </g:each>
                </g:if>
                <g:else>
                    <div class="rewardsTemplate" id="rewardTemplate1" value="1">
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
                                    <input type="text" placeholder="Name of Perk" name="rewardTitle1" class="form-control rewardTitle cr-tablet-left cr-perk-title-number form-control-no-border text-color cr-placeholder cr-chrome-place" id="rewardTitle1">
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
                                   <textarea class="form-control rewardDescription form-control-no-border text-color cr-placeholder cr-chrome-place" name="rewardDescription1" id="rewardDesc1" rows="2" placeholder="Let your contributors feel special by rewarding them. Think out of the box and leave your contributors awestruck. Make sure you have calculated the costs associated with the perk; you do not want to lose money!" maxlength="250"></textarea>
                                   <p class="cr-perk-des-font">Please refer to our <a href="${resource(dir: '/termsofuse')}" target="_blank">Terms  Of  Use</a> for more details on perks.</p>
                               </div>
                           </div>
                       </div>
                   
                       <div class="col-sm-12">
                           <div class="form-group">
                               <div class="btn-group col-sm-12" data-toggle="buttons">
                                    <label class="panel-body col-sm-2 col-xs-12 cr-check-btn-perks text-center">Mode of <br> Delivery</label>
                                    <label class="btn btn-default col-sm-2 col-xs-12 cr-hovers cr-font-perks cr-perks-back-color shippingAddress"><input type="checkbox" name="mailingAddress1" value="true" id="mailaddcheckbox1">Mailing <br> address</label>
                                    <label class="btn btn-default col-sm-2 col-xs-12 cr-hovers cr-font-perks cr-perks-back-color shippingEmail"><input type="checkbox" name="emailAddress1" value="true" id="emailcheckbox1">Email <br> address</label>
                                    <label class="btn btn-default col-sm-2 col-xs-12 cr-hovers cr-font-perks cr-perks-back-color shippingTwitter"><input type="checkbox" name="twitter1" value="true" id="twittercheckbox1">Twitter <br> handle</label>
                                    <input type="text" name="custom1" id="customcheckbox1" class="customText form-control-no-border text-color cr-custom-place cr-customchrome-place cr-perks-back-color col-sm-4 col-xs-12" placeholder="Custom">
                              </div>
                           </div>
                       </div>
                       <g:hiddenField name="rewardNum" id="rewardNum1" value="1" class="rewardNum"/>
                   </div>
                </g:else>
            </div>
            
            <div class="row">
                <div class="col-sm-12 perk-css" id="updatereward">
                    <div class="col-sm-12 perk-create-styls perkEditDeleteAlign" >
                        <span class="perkSaveMessage" id="perkSaveMessage">Perk Saved</span>
                        <div class="btn btn-circle perks-css-create intutive-glyphicon" id="savereward" value="${lastrewardCount}">
                            <i class="glyphicon glyphicon-floppy-save"></i>
                        </div>
                        <div class="btn btn-circle perks-css-create intutive-glyphicon" id="createreward">
                            <i class="glyphicon glyphicon-plus"></i>
                        </div>
                        <div class="btn btn-circle perks-created-remove intutive-glyphicon" id="removereward">
                            <i class="glyphicon glyphicon-trash"></i>
                        </div>
                    </div>
                </div>
            </div>
            <div></div>
            
            <g:if test="${projectRewards.size() > 0}">
                <input type="hidden" name="rewardCount" id="rewardCount" value="${lastrewardCount}"/>
            </g:if>
            <g:else>
                <input type="hidden" name="rewardCount" id="rewardCount" value="0"/>
            </g:else>
            <div class="clear"></div>
            <div class="form-group">
                <div class="col-sm-12 cr-payments-pad" id="payment">
                    <div class="cr-story-flx cr-payment-marg col-sm-12 cr-safari">
                        <label class="panel-body cr-payments-lab cr-safari">PAYMENTS</label>
                        <label class="panel-body cr-payments">Payments are sent and received via your choice of Payment Gateway.
                        You keep 100% of the money you raise. Crowdera does not charge any fee to you.</label>
                    </div>
                    <label class="cr-pad-who">Who will recieve the funds</label>
                    <div class="btn-group col-sm-12 cr-perk-check cr-radio-option" data-toggle="buttons">
                        <g:if test="${currentEnv == 'testIndia' || currentEnv == 'stagingIndia' || currentEnv == 'prodIndia'}">
                            <label class="panel-body cr-check-btn-first text-center col-sm-3 col-xs-12"> <span class="cr-reci-siz">Recipient</span><span class="cr-pay-rd"> of funds</span></label>  
                            <label class="btn btn-default cr-check-btn col-sm-3 col-xs-12 cr-reci-siz <g:if test="${project.fundsRecievedBy == 'PERSON'}">active</g:if>" id="person"> <input type="radio" name="" value="yes">Individual</label> 
                            <label class="btn btn-default cr-check-btn col-sm-3 col-xs-12 cr-mob-payments <g:if test="${project.fundsRecievedBy == 'NGO'}">active</g:if>" id="ngo"> <input type="radio" name="" value="no"><span class="cr-pay-rd"> An Indian </span><span class="cr-reci-siz">NGO</span></label>
                            <label class="btn btn-default cr-check-btn col-sm-3 col-xs-12 <g:if test="${project.fundsRecievedBy == 'OTHERS'}">active</g:if>" id="others"> <input type="radio" name="" value="no"><span class="cr-reci-siz">Others</span></label>
                        </g:if>
                        <g:else>
                            <label class="panel-body cr-check-btn-first text-center col-sm-3 col-xs-12"> <span class="cr-reci-siz">Recipient</span><span class="cr-pay-rd"> of funds</span></label>  
                            <label class="btn btn-default cr-check-btn col-sm-2 col-xs-12 cr-reci-siz <g:if test="${project.fundsRecievedBy == 'PERSON'}">active</g:if>" id="person"> <input type="radio" name="recipientPerson" value="yes">Person</label> 
                            <label class="btn btn-default cr-check-btn col-sm-3 col-xs-12 cr-mob-payments <g:if test="${project.fundsRecievedBy == 'NON-PROFITS'}">active</g:if>" id="non-profit"> <input type="radio" name="nonProfit" value="no"><span class="cr-pay-rd">A US 501(c)(3)</span><span class="cr-reci-siz"> Non-profit</span></label>
                            <label class="btn btn-default cr-check-btn col-sm-2 col-xs-12 cr-mob-payments <g:if test="${project.fundsRecievedBy == 'NGO'}">active</g:if>" id="ngo"> <input type="radio" name="recipientNgo" value="no"><span class="cr-pay-rd">A non-US </span><span class="cr-reci-siz">NGO</span></label>
                            <label class="btn btn-default cr-check-btn col-sm-2 col-xs-12 <g:if test="${project.fundsRecievedBy == 'OTHERS'}">active</g:if>" id="others"> <input type="radio" name="recipientOther" value="no"><span class="cr-reci-siz">Others</span></label>
                        </g:else>
                    </div>
                </div>
            </div>
            
            <div class="form-group">
                <g:if test ="${currentEnv == 'testIndia' || currentEnv == 'stagingIndia' || currentEnv == 'prodIndia'}">
                    <div id="PayUMoney">
                        <div class="form-group">
                            <label class="col-sm-4 control-label">Email</label>
                            <div class="col-sm-6 col-xs-10">
                                <g:if test="${project.payuEmail}">
                                    <input type="email" id="payuemail" class="form-control form-control-no-border cr-payu-space-mobile text-color" name="${FORMCONSTANTS.PAYUEMAIL}" value="${project.payuEmail}">
                                </g:if>
                                <g:else>
                                    <input type="email" id="payuemail" class="form-control form-control-no-border cr-payu-space-mobile text-color" name="${FORMCONSTANTS.PAYUEMAIL}">
                                </g:else>
                            </div>
                        </div>
                    </div>
                </g:if>
                <g:else>
                    <div class="col-sm-12" id="paypalemail">
                        <div class="form-group">
                            <img class="col-sm-4 cr-paypal-image" src="//s3.amazonaws.com/crowdera/assets/paypal-Image.png" alt="paypal">
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
                        <div class="col-sm-12 cr-tablet-space cr-center-charity" id="charitableId">
                            <div class="form-group">
<%--                                <label class="col-sm-4 control-label">FirstGiving</label>--%>
                            <img class="col-sm-4 cr-first-giving" src="//s3.amazonaws.com/crowdera/assets/firstgiving-icons-1.jpg" alt="firstgiving">
                            <div class="col-sm-6">
                                <a data-toggle="modal" href="#myModal" class="charitableLink cr-tablet-orgcharity">Find your organization</a>
                            </div>
                            <div class="col-sm-4 cr-charity-lbl" id="charitable">
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
                                        <button data-dismiss="modal" class="btn btn-primary TW-btn-editfundraiser">Close</button>
                                        <button class="btn btn-primary" data-dismiss="modal" id="saveCharitableId">Save</button>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </g:else>
                
                <div class="col-sm-12 cr-paddingspace termsOfUseCheckboxOnCreatePage" id="launch">
                    <div class="col-md-offset-2 col-md-8 col-sm-offset-1 col-sm-8">
                        <div class="form-group">
                            <input type="checkbox" name="checkBox" id="agreetoTermsandUse" <g:if test="${project.touAccepted}">checked="checked"</g:if>>  I accept <a href="${resource(dir: '/termsofuse')}">Terms of Use</a> and <a href="${resource(dir: '/privacypolicy')}">Privacy Policy</a>
                        </div>
                    </div>
                    <div class="clear"></div>
                    <div class="col-sm-6 text-center">
                        <button type="submit" class="cr-bg-preview-btn cr-btn-alignment-pre cr-btn-margin createsubmitbutton hidden-xs" id="previewButton"  name="button"></button>
                        <button class="cr-bg-xs-preview-btn cr-xs-mobile createsubmitbutton visible-xs" id="previewButtonXS" type="submit" name="button"></button>
                    </div>
                    <g:hiddenField name="isSubmitButton" value="true" id="isSubmitButton"></g:hiddenField>

                    <div class="col-sm-6 text-center">
                        <button type="submit" class="cr-bg-Launch-btn cr-btn-alignment-lac cr-btn-launch createsubmitbutton hidden-xs" id="submitProject" name="button" value="submitProject"></button>
                        <button type="submit" class="cr-bg-xs-Launch-btn cr-xs-mobile createsubmitbutton visible-xs" id="submitProjectXS" name="button" value="submitProject"></button>
                    </div>
                </div>
            </div>
            
             <!-- Modal -->
            <div class="modal fade" id="addVideo" tabindex="-1" role="dialog" aria-hidden="true">
                <div class="modal-dialog modal-xs">
                    <div class="modal-content">
                        <div class="modal-header video-modal">
                            <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
                            <h3 class="modal-title text-center"><b>Upload Video</b></h3>
                        </div>
                        <div class="modal-body">
                            <div class="row">
                                <div class="form-group col-xs-text-box-with-button">
                                    <div class="col-sm-10 col-xs-9 col-xs-textbox">
                                        <input class="form-control form-control-no-border text-color videoUrl" name="${FORMCONSTANTS.VIDEO}" value="${project.videoUrl}" placeholder="Video URL">
                                    </div>
                                    <div class="col-sm-2 col-xs-2 col-xs-button">
                                        <button type="button" class="btn btn-info btn-sm cr-btn-color add btn-center">Add</button>
                                    <div>
                                </div>
                            </div>
                        </div>
                        
                    </div>
                </div>
            </div>
                
            </div>
            </div>
        </g:uploadForm> 
        </div>
    </div>
    
    <script src="/js/main.js"></script>
    <script src="/js/bootstrap-datepicker.js"></script>
    <script type="text/javascript">
        var needToConfirm = true;
        window.onbeforeunload = confirmExit;
        function confirmExit() {
            if(needToConfirm){
                return "You have attempted to leave this page.  If you have made any changes to the fields without clicking the Save button, your changes will be lost.  Are you sure you want to exit this page?";
            }
        }

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
                $('.deadline-popover').find("span").remove();
                $('.campaignEndDateError').closest(".form-group").removeClass('has-error');
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
                console.log('Error occured on selecting the Deadline.');
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
                    console.log('Error occured on deleting the Campaign Admin.');
                });
            }
        }

        function deleteOrganizationLogo(current, projectId) {
            $.ajax({
                type:'post',
                url:$("#b_url").val()+'/project/deleteOrganizationLogo',
                data:'projectId='+projectId,
                success: function(data){
                    $('#imgIcon').removeAttr('src');
                    $('#imgIcon').hide();
                    $('#logoDelete').hide();
                    $('#orgediticonfile').val('');
                }
            }).error(function(){
                console.log('Error occured on deleting the organization icon.');
            });
        }

        function deleteProjectImage(current,imgst, projectId) {
            $.ajax({
                type:'post',
                url:$("#b_url").val()+'/project/deleteProjectImage',
                data:'imgst='+imgst+'&projectId='+projectId,
                success: function(data){
                    $(current).parents('#imgdiv').remove();
                    if($('#campaignthumbnails').find('.pr-thumb-div').length == 0){
                        $('.panel-pic-uploaded').hide();
                        $('.panel-no-image').show();
                    }
                }
            }).error(function(){
                 console.log('Error occured on deleting the Campaign Image.');
            });
        }

    </script>
</body>
</html>
