<g:set var="rewardService" bean="rewardService" />
<%@ page import="java.text.SimpleDateFormat"%>
<%
    def request_url=request.getRequestURL().substring(0,request.getRequestURL().indexOf("/", 8))
    String baseUrl = (request_url.contains('www')) ? grailsApplication.config.crowdera.BASE_URL1 : grailsApplication.config.crowdera.BASE_URL
    
    def base_url = baseUrl.substring(0, (baseUrl.length() - 1))
    def iteratorCount = 1
    def lastrewardCount = 1
    def rewardItrCount = projectRewards.size()
    def spendCount
    def spendLastMatrix
    def spendLastNumAvail
    if (spends){
        spendCount = spends.size()
        spendLastMatrix = spends.last()
        spendLastNumAvail = spendLastMatrix.numberAvailable
    }
    String ans1val, ans3val, ans2val, ans5val, ans6val, ans7val , ans8val, r1, r2, r3
    if (qA){
        ans1val = (qA.ans1 && qA.ans1 != 'NO')? qA.ans1 : null;
        ans3val = (qA.ans3 && qA.ans3 != 'NO')? qA.ans3 : null;
        ans2val = (qA.ans2 && qA.ans2 != 'NO')? qA.ans2 : null;
        ans5val = (qA.ans5 && qA.ans5 != 'NO')? qA.ans5 : null;
        ans6val = (qA.ans6 && qA.ans6 != 'NO')? qA.ans6 : null;
        ans7val = (qA.ans7 && qA.ans7 != 'NO')? qA.ans7 : null;
        ans8val = (qA.ans8 && qA.ans8 != 'NO')? qA.ans8 : null;
    }
    if(reasonsToFund){
        r1 = (reasonsToFund.reason1) ? reasonsToFund.reason1 : null;
        r2 = (reasonsToFund.reason2) ? reasonsToFund.reason2 : null;
        r3 = (reasonsToFund.reason3) ? reasonsToFund.reason3 : null;
    }
    
    SimpleDateFormat dateFormat = new SimpleDateFormat("MM/dd/yyyy");
    def currentDate = new Date();
    def taxRecieptId = null
    if (taxReciept){
        taxRecieptId = taxReciept.id
    }
    
    String beneficiaryName = (project.beneficiary.lastName)? project.beneficiary.firstName +' ' +project.beneficiary.lastName :  project.beneficiary.firstName
%>
<html>
<head>
<title>Crowdera- Create campaign</title>
<link rel="canonical" href="${base_url}/campaign/start" />
<meta name="layout" content="main" />
<r:require modules="projectcreatejs" />

<link rel="stylesheet" href="/css/datepicker.css">
<link rel="stylesheet" href="/css/style.css">

</head>
<body>
	<input type="hidden" id="b_url" value="<%=base_url%>" />
	<input type="hidden" name="uuid" id="uuid" />
	<input type="hidden" name="charity_name" id="charity_name" />
	<input type="hidden" name="url" value="${currentEnv}" id="currentEnv" />

	<g:hiddenField name="payfir" value="${project.charitableId}"
		id="payfir" />
	<g:hiddenField name="paypal" value="${project.paypalEmail}" />
	<g:hiddenField name="projectamount" value="${project.amount.round()}"
		id="projectamount" />
	<g:hiddenField name="vanityUrlStatus" id="vanityUrlStatus" value="true" />
	<g:hiddenField name="spendMatrix" value="${spends.amount}"
		id="spendMatrix" />
	<g:hiddenField name="usedForCreate" id="usedForCreate"
		value="${project.usedFor}" />
	<g:hiddenField name="selectedCountry" id="selectedCountry"
		value="${selectedCountry}" />
	<g:hiddenField name="taxRecieptId" value="${taxRecieptId}"
		id="taxRecieptId" />
	<g:hiddenField name="offeringTaxReciept" id="offeringTaxReciept"
		value="${project.offeringTaxReciept}" />

	<g:hiddenField name="titleUniqueStatus" value="true"
		id="titleUniqueStatus" />
	<g:hiddenField name="isIndianCampaign" value="${project.payuStatus}"
		id="isIndianCampaign" />

	<%--<div class="text-center">
	
	
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
    --%>
	<div class="bg-color col-sm-12 col-xs-12 cr-top-space">
		<div class="container footer-container" id="campaigncreate">


			<%--<div class="startsection"></div>
            
            --%>
			<div class="top-content">

				<div class="row">
					<div class="col-sm-12 col-md-12 form-box">

						<g:uploadForm class="form-horizontal f1" controller="project" action="campaignOnDraftAndLaunch" params="['title': vanityTitle, 'userName':vanityUsername]">

							<g:hiddenField name="country_code" value="${country_code}" />
							<g:hiddenField name="projectId" id="projectId" value="${project.id}" />
							
							<div class="f1-steps text-center">
								<div class="col-xs-12">
									<div class="f1-progress">
										<div class="f1-progress-line" data-now-value="16.66"
											data-number-of-steps="4" style="width: 16.66%;"></div>
									</div>
								</div>
								<div class="f1-step active">
									<div class="f1-step-icon">
									   <a class=" col-sm-2 col-xs-2 cr-img-start-icon" href="#start"><div class="col-sm-0 cr-subheader-icons"><img class="cr-start TW-cr-sec-header-start-icon-width" src="//s3.amazonaws.com/crowdera/assets/start-Icon-White.png" alt="S"></div></a>
									</div>
									<p>Start</p>
								</div>
								<div class="f1-step">
									<div class="f1-step-icon">
                                        <a class=" col-sm-2 col-xs-2 cr-img-story-icon" href="#story"><div class="col-sm-0 cr-subheader-icons"><img class="cr-story TW-cr-sec-header-icon-width" src="//s3.amazonaws.com/crowdera/assets/story-Icon-White.png" alt="S"></div></a>
									</div>
									<p>Story</p>
								</div>
								<div class="f1-step">
									<div class="f1-step-icon">
										<a class=" col-sm-2 col-xs-2 cr-img-story-icon" href="#story"><div class="col-sm-0 cr-subheader-icons"><img class="cr-story TW-cr-sec-header-icon-width" src="//s3.amazonaws.com/crowdera/assets/story-Icon-White.png" alt="S"></div></a>
									</div>
									<p>Impact</p>
								</div>
								<div class="f1-step">
									<div class="f1-step-icon">
									   <a class=" col-sm-2 col-xs-2 cr-img-admin-icon" href="#admins"><div class="col-sm-0 cr-subheader-icons"><img class="cr-admin TW-cr-sec-header-icon-width" src="//s3.amazonaws.com/crowdera/assets/admin-Icon---White.png" alt="A"></div></a>
									</div>
									<p>social</p>
								</div>
								<div class="f1-step">
									<div class="f1-step-icon">
									   <a class=" col-sm-2 col-xs-2 cr-img-perk-icon" href="#perk"><div class="col-sm-0 cr-subheader-icons"><img class="cr-perk TW-cr-sec-header-icon-width" src="//s3.amazonaws.com/crowdera/assets/perk-Icon-White.png" alt="P"></div></a>
									</div>
									<p>Perks</p>
								</div>
								<div class="f1-step">
									<div class="f1-step-icon">
									<a class=" col-sm-2 col-xs-2 cr-img-payment-icon" href="#payment"><div class="col-sm-0 cr-subheader-icons"><img class="cr-payment TW-cr-sec-header-icon-width" src="//s3.amazonaws.com/crowdera/assets/payment-Icon-White.png" alt="P"></div></a>
									</div>
									<p>Payments</p>
								</div>
							</div>

							<fieldset>

								<%--Desktop code --%>
								<div class="col-lg-12 col-md-12 col-sm-12">
									<div class="form-group edit-tabsMobile-margin">
										<div class="col-lg-6 col-md-6 col-sm-6">
											<label class="col-sm-12 text-color cr-padding-index1">My Name is...</label>
											<div class="col-sm-12 cr-padding-index1">
												<input type="text" class="form-control form-control-no-border text-color cr1-box-size"
													id="name1" name="${FORMCONSTANTS.FIRSTNAME}" placeholder="Display Name" value="${beneficiaryName}">
											</div>
										</div>
										
										<div class="col-lg-6 col-md-6 col-sm-6 editCustomVanityUrl">
                                            <label class="col-sm-12 text-color cr1-vanity-label-indx1 cr1-vanity-label-indx1 hidden-xs">My
                                                campaign web address
                                                </label> 
                                                <label class="col-sm-12 text-color cr1-vanity-label-indx1 cr1-vanity-label-indx1 visible-xs">
                                                <g:if test="${project.payuStatus}">
                                                    crowdera.in/campaigns/
                                                </g:if> <g:else>
                                                    gocrowdera.com/campaigns/
                                                </g:else>
                                            </label>
                                            <div class="col-sm-12 col-xs-12 cr1-mobile-indx1 col-web-url">
                                                <div class="cr1-vanityUrl-indx1 hidden-xs">
                                                    <g:if test="${project.payuStatus}">
                                                        crowdera.in/campaigns/
                                                    </g:if>
                                                    <g:else>
                                                        gocrowdera.com/campaigns/
                                                    </g:else>
                                                </div>
                                                <input
                                                    class="form-control form-control-no-border editsweb-margin-mobile  cr1-indx-mobile cr-placeholder cr-chrome-place text-color cr-marg-mobile customVanityUrlProd customVanityUrl"
                                                    name="customVanityUrl" maxlength="55"
                                                    value="${project?.customVanityUrl}" id="customVanityUrl"
                                                    placeholder="Your-Campaign-web-url"
                                                    <g:if test="${project?.validated && project?.customVanityUrl}">readonly</g:if>>
                                            </div>
                                            <div class="clear" id="vanityUrlClear"></div>
                                            <label class="pull-right" id="vanityUrlLength"></label>
                                        </div>

										<%--Mobile-code --%>
										<div class="form-group cr2-form-need visible-xs">
											<div class="col-lg-3 col-md-3 col-sm-3 col-xs-7">
												<span class="col-sm-12 cr-padding-index1">Fundraising Goal:</span>
												<div class="cr-tops">
													<g:if test="${country_code == 'in'}">
														<span
															class="i-currency-label-indx1 fa fa-inr cr1-inr-indx1"></span>
													</g:if>
													<g:elseif test="${country_code == 'us'}">
														<span class="i-currency-label-indx1">$</span>
													</g:elseif>
													<input
														class="form-control form-control-no-border-amt cr-amt-indx1"
														name="amount1" value="${project.amount.round()}"
														id="amount1"> <span id="errormsg1"></span>
												</div>
											</div>

											<div
												class="col-lg-1 col-md-1 col-sm-1 amount-popover cr1-mobile-padding-amt col-xs-1">
												<img
													class="cr1-amountInfo-img <g:if test="${project.payuStatus}">cr1-guidence-indo</g:if><g:else>cr1-guidence-us</g:else>"
													src="//s3.amazonaws.com/crowdera/assets/Information-Icon.png"
													alt="Information icon">
											</div>

											<div class="col-lg-2 col-md-2 col-sm-2 col-xs-4 cr1-in-days">
												<span class="col-lg-12 col-sm-12 col-md-12 cr-padding-index1 cr1-mobile">In Days</span>
												<div class="cr1-font-list">
													<g:select class="selectpicker cr-drop-color days" name="${FORMCONSTANTS.DAYS}" from="${inDays}"
														value="${project.days}" optionKey="key" optionValue="value" id="edit-days-mob" />
												</div>
											</div>
										</div>

									</div>

									<div class="form-group cr2-form-need hidden-xs edit-tabsMobile-margin">
										<div class="col-lg-3 col-md-3 col-sm-3 col-xs-7">
											<span class="col-sm-12 cr-padding-index1">Fundraising Goal:</span>
											<div class="cr-tops">
												<g:if test="${country_code == 'in'}">
													<span
														class="i-currency-label-indx1 fa fa-inr cr1-inr-indx1"></span>
												</g:if>
												<g:elseif test="${country_code == 'us'}">
													<span class="i-currency-label-indx1">$</span>
												</g:elseif>
												<input
													class="form-control form-control-no-border-amt cr-amt-indx1"
													name="amount" value="${project.amount.round()}"
													id="amount2"> <span id="errormsg2"></span>
											</div>
										</div>

										<div
											class="col-lg-1 col-md-1 col-sm-1 amount-popover cr1-mobile-padding-amt col-xs-1">
											<img
												class="cr1-amountInfo-img <g:if test="${project.payuStatus}">amountInfoInd-img</g:if><g:else>amountInfo-img</g:else>"
												src="//s3.amazonaws.com/crowdera/assets/Information-Icon.png"
												alt="Information icon">
										</div>

										<div class="col-lg-2 col-md-2 col-sm-2 col-xs-4 col-l-0 cr1-in-days padding-r-28">
											<span class="col-lg-12 col-sm-12 col-md-12 cr-padding-index1 cr1-mobile">In
												Days</span>
											<div class="cr1-font-list">
												<g:select class="selectpicker cr-drop-color days"
													name="${FORMCONSTANTS.DAYS}" from="${inDays}"
													value="${project.days}" optionKey="key" optionValue="value"
													id="edit-days-desktop" />
											</div>
										</div>
									</div>
									<div class="form-group edit-tabsMobile-margin">
										<div class="createTitleDiv col-lg-4 col-md-4 col-sm-4 cr1-indx1-mobileTpadding">
											<label class="col-sm-12 text-color cr-padding-index1">Fundraiser Title:</label>
											<div class="col-sm-12 cr-padding-index1 col-edit-title">
												<input
													class="form-control form-control-no-border cr-myplan-indx1 text-color campaignTitle"
													name="${FORMCONSTANTS.TITLE}"
													placeholder="Create an impactful and actionable title. Helps donors find campaign."
													value="${project.title}" id="campaignTitle1" maxlength="55">
												<label class="pull-right " id="titleLength"></label>
											</div>
										</div>
										
						               <div class="createTitleDiv col-l-0 col-lg-4 col-md-4 col-sm-4 col-xs-12 cr1-indx1-mobileTpadding">
						                    <label class="col-sm-12 text-color cr-padding-index1 cr1-myplane-padding col-r-0">I am Based in:</label>
						                    <div class="col-sm-12  form-group col-lr-0">
						                        <select name="country" id="country" class="selectOption">
						                            <option value="">Select One</option>
						                            <g:each in="${countryList}" var="countryObj">
						                                <g:if test="${project.beneficiary?.country == countryObj.key}">
						                                    <option value="${countryObj.key}" selected>${countryObj.value}</option>
						                                </g:if>
						                                <g:else>
						                                    <option value="${countryObj.key}">${countryObj.value}</option>
						                                </g:else>
						                            </g:each>
						                        </select>
						                    </div>
						               </div>
						               
						               <div class="createTitleDiv col-lg-4 col-md-4 col-sm-4 col-xs-12 cr1-indx1-mobileTpadding col-l-0">
						                    <label class="col-sm-12 text-color cr-padding-index1 cr1-myplane-padding col-r-0">Fundraiser Category:</label>
						                    <div class="col-sm-12  form-group col-lr-0">
						                        <select name="category" id="category" class="selectOption">
						                            <option value="">Select One</option>
						                            <g:each in="${categoryOptions}" var="category">
						                                <g:if test="${project.category == category.key}">
						                                    <option selected value="${category.key}">${category.value}</option>
						                                </g:if>
						                                <g:else>
						                                    <option value="${category.key}">${category.value}</option>
						                                </g:else>
						                            </g:each>
						                        </select>
						                    </div>
						               </div>
               
									</div>
									
									

									<div class="form-group createDescDiv edit-tabsMobile-margin">
										<div class="col-sm-12 cr1-descriptions-indx1 edit-description">
											<textarea
												class="form-control form-control-no-border text-color"
												id="descarea1" name="${FORMCONSTANTS.DESCRIPTION}" rows="2"
												placeholder="Campaign Description" maxlength="140">
												${project.description}
											</textarea>
											<label class="pull-right " id="desclength"></label>
										</div>
									</div>
								</div>


								<div class="col-xs-12 campaign-btn-div text-center">
									<button type="button" class="btn campaign-btn-primary btn-next"
										data-groupid="1">Save And Continue</button>
								</div>
							</fieldset>

							<fieldset>

								<g:hiddenField name="campaignvideoUrl"
									value="${project.videoUrl}" id="addvideoUrl" />
								<div class="col-sm-6 video-popover" id="media">
									<div class="panel panel-default panel-create-size"
										id="videoBox">
										<div class="form-group">
											<div class="col-md-10 col-xs-8 col-videoUrl-textbox">
												<input
													class="form-control form-control-no-border text-color videoUrl"
													id="videoUrlText" name="${FORMCONSTANTS.VIDEO}"
													placeholder="Video URL">
											</div>
											<div class="col-sm-2 col-xs-2 col-videoUrl-button">
												<button type="button"
													class="btn btn-info btn-sm cr-btn-color add"
													id="addVideoButton">Add</button>
											</div>
										</div>
									</div>
									<img class="videoInfo-img"
										src="//s3.amazonaws.com/crowdera/assets/Information-Icon.png"
										alt="Information icon">
								</div>

								<div class="col-sm-6 video-popover" id="media-video">
									<div class="panel panel-default panel-create-size">
										<div class="panel-body">
											<div class="form-group">
												<div class="col-sm-6" id="ytVideo"></div>
											</div>
											<span class="videoUrledit close" id="videoUrledit"><i
												class="glyphicon glyphicon-edit"></i></span> <span
												class="videoUrledit close"><i
												class="glyphicon glyphicon-trash" id="deleteVideo"></i></span>
										</div>
									</div>
									<img class="videoInfo-img"
										src="//s3.amazonaws.com/crowdera/assets/Information-Icon.png"
										alt="Information icon">
								</div>

								<div class="col-sm-6 image-popover">
									<div
										class="panel panel-default panel-create-size upload-campaign-pic panel-pic-uploaded <g:if test="${!project.imageUrl}">panel-hidden</g:if>">
										<div class="form-group" id="createthumbnail">
											<div class="createpage-img-panel">
												<div class="col-sm-12 pad-result" id="campaignthumbnails">
													<g:each var="imgurl" in="${project.imageUrl}">
														<div id="imgdiv" class="pr-thumb-div">
															<img alt="image" class='pr-thumbnail'
																src='${imgurl.url }' id="imgThumb${imgurl.id}">
															<div class="deleteicon pictures-edit-deleteicon">
																<img alt="cross"
																	onClick="deleteProjectImage(this,'${imgurl.id}','${project.id}');"
																	src="//s3.amazonaws.com/crowdera/assets/delete.ico">
															</div>
														</div>
													</g:each>
												</div>
												<div class="clear"></div>
												<div class="col-md-12">
													<div id="uploadingCampaignImage">Uploading
														Image......</div>
													<div class="imageNumValidation">You cannot upload
														more than 5 images</div>
													<label class="docfile-orglogo-css imgmsg"></label> <label
														class="docfile-orglogo-css campaignfilesize"
														id="campaignFilesizeID"></label>
												</div>
											</div>

											<div class="col-pictures pull-right">
												<div class="fileUpload btn btn-info btn-sm cr-btn-color">
													Add Image <input type="file" class="upload"
														name="addCampaignImage" id="campaignImage"
														accept="image/jpeg, image/png">
												</div>
											</div>
										</div>
									</div>
									<div
										class="panel panel-default panel-create-size upload-campaign-pic panel-no-image <g:if test="${project.imageUrl}">panel-hidden</g:if>">
										<div class="col-sm-12 col-add-picture">
											<div class="fileUpload btn btn-info btn-sm cr-btn-color ">
												Add Image <input type="file" class="upload"
													name="${FORMCONSTANTS.THUMBNAIL}[]" id="projectImageFile"
													accept="image/jpeg, image/png">
											</div>
										</div>
										<div class="clear"></div>
										<div class="col-sm-12 col-error-placement"
											id="col-error-placement">
											<label class="docfile-orglogo-css imgmsg"></label> <label
												class="docfile-orglogo-css campaignfilesize"
												id="campaignFilesizeID1"></label>
										</div>
									</div>
									<img class="pictureInfo-img"
										src="//s3.amazonaws.com/crowdera/assets/Information-Icon.png"
										alt="Information icon">
								</div>

								<div class="col-sm-12" id="story">
									<div class="form-group">
										<div class="col-sm-12 cr-story-padding">
											<div class="cr-story-flx cr-safari">
												<label class="panel body cr-story-size cr-safari">STORY</label>
												<label class="panel-body cr-panel-story">A good
													engaging story is the backbone of your Campaign. You want
													your readers to be compelled to share your story and make
													your campaign go viral. Be passionate and make them believe
													and trust your goal.</label>
											</div>
											<textarea name="${FORMCONSTANTS.STORY}"
												class="redactorEditor">
                                                <g:if
													test="${project.story}">
													${project.story}
												</g:if>
                                            </textarea>
											<span id="storyRequired">Ths field is required</span>
											<g:hiddenField name="projectHasStory" id="projectHasStory"
												value="${project.story}" />
										</div>
									</div>
								</div>
								<g:if
									test="${currentEnv == 'development' || currentEnv == 'test' || currentEnv == 'testIndia'}">
									<div class="col-sm-12 padding-right-xs">
										<div class="cr-spend-matrix">
											<label
												class="col-md-4 col-sm-6 col-xs-12 text-center cr-panel-spend-matrix cr-panel-qa"><span
												class="cr-spend-matrix-font">Your Contributors Want
													to Know</span></label> <label
												class="col-md-8 col-sm-6 hidden-xs cr-panel-spend-matrix-guide cr-panel-qa-guide"></label>
										</div>
										<div class="panel panel-body cr-panel-body-spend-matrix">
											<div class="col-sm-12 col-xs-12 zero-padding">
												1. Did you try other fundraising methods ?
												<div class="question-ans question-ans-1 form-group">
													<p>
														<input type="radio" name="ans1" class="ans1 yes"
															value="yes"
															<g:if test="${qA && qA.ans1 && qA.ans1 != 'NO'}">checked="checked"</g:if>>&nbsp;YES&nbsp;&nbsp;&nbsp;
														<input type="radio" name="ans1" class="ans1 no" value="no"
															<g:if test="${qA && qA.ans1 && qA.ans1 == 'NO'}">checked="checked"</g:if>>&nbsp;NO
													</p>
													<textarea
														class="ansText ansText1 form-control <g:if test="${ans1val}">display-block-text1</g:if><g:else>display-none-text1</g:else>"
														placeholder="" name="ansText1">
														${ans1val}
													</textarea>
												</div>
												<br> 2. Why do you want to crowdfund ?
												<div class="question-ans form-group">
													<textarea class="ansText ansText2 form-control"
														name="ansText2" maxlength="128">
														${ans2val}
													</textarea>
												</div>
												<br> 3. Have you crowdfunded before ?
												<div class="question-ans question-ans-3 form-group">
													<p>
														<input type="radio" name="ans3" class="ans3 yes"
															value="yes"
															<g:if test="${qA && qA.ans3 && qA.ans3 != 'NO'}">checked="checked"</g:if>>&nbsp;YES&nbsp;&nbsp;&nbsp;
														<input type="radio" name="ans3" class="ans3 no" value="no"
															<g:if test="${qA && qA.ans3 && qA.ans3 == 'NO'}">checked="checked"</g:if>>&nbsp;NO
													</p>
													<textarea maxlength="128"
														class="ansText ansText3 form-control <g:if test="${ans3val}">display-block-text3</g:if><g:else>display-none-text3</g:else>"
														name="ansText3" placeholder="">
														${ans3val}
													</textarea>
												</div>
												<br> 4. If you don't recieve 100% goal what will you
												do.
												<div class="question-ans form-group">
													<p>
														<input type="radio" name="ans4"
															class="ans4 extend-deadline" value="extend-deadline"
															<g:if test="${qA && qA.ans4 && qA.ans4 == 'extend-deadline'}">checked="checked"</g:if>>&nbsp;I
														would extend my deadline.
													</p>
													<p>
														<input type="radio" name="ans4"
															class="ans4 personally-raising"
															value="personally-raising"
															<g:if test="${qA && qA.ans4 && qA.ans4 == 'personally-raising'}">checked="checked"</g:if>>&nbsp;I
														will personally start walking towards cause using raised
														funds.
													</p>
													<p>
														<input type="radio" name="ans4" class="ans4 contact-admin"
															value="contact-admin"
															<g:if test="${qA && qA.ans4 && qA.ans4 == 'contact-admin'}">checked="checked"</g:if>>&nbsp;I
														will contact crowdera admin.
													</p>
												</div>

												5. What are the issues you or your organization is facing
												with regards to funding?
												<div class="question-ans form-group">
													<textarea class="ansText ansText5 form-control"
														name="ansText5" maxlength="128">
														${ans5val}
													</textarea>
												</div>

												6. Why are you crowdfunding at this moment?
												<div class="question-ans form-group">
													<textarea class="ansText ansText6 form-control"
														name="ansText6" maxlength="128">
														${ans6val}
													</textarea>
												</div>

												7. What will you do if you do not reach your goal within the
												chosen deadline? Will you still complete your project?
												<div class="question-ans form-group">
													<textarea class="ansText ansText7 form-control"
														name="ansText7" maxlength="128">
														${ans7val}
													</textarea>
												</div>

												8. Why should the contributors trust you?
												<div class="question-ans form-group">
													<textarea class="ansText ansText8 form-control"
														name="ansText8" maxlength="128">
														${ans8val}
													</textarea>
                                                </div>
                                            </div>
                                        </div>
                           
                                    </div>
                                </g:if>
        
                                <div class="col-xs-12 campaign-btn-div text-center">
                                    <button type="button" class="btn btn-previous campaign-btn-prev pull-left">Previous</button>
                                    <button type="button" class="btn btn-next campaign-btn-primary pull-right" data-groupid= "2">Save And Continue</button>
                                </div>
                            </fieldset>
                            
                            <fieldset>
                            
                               <div class="col-sm-12 padding-right-xs col-lr-0">
                                    <div class="cr-spend-matrix">
                                        <label class="col-md-2 col-sm-3 col-xs-12 text-center cr-panel-spend-matrix cr-panel-spend-xs"><span class="cr-spend-matrix-font">Spend Matrix</span></label>
                                        <label class="col-md-10 col-sm-9 col-xs-12 cr-panel-spend-matrix-guide cr-spend-guide-text">The matrix will be displayed as a pie chart on your campaign page for your contributors to know how the contributions or funds raised will be utilized</label>
                                    </div>
                                    
                                    <div class="panel panel-body cr-panel-body-spend-matrix cr-panel-spendMatrix-height">
                                        <div class="col-sm-9 col-xs-12 spend-matrix">
                                            <g:if test="${spendCount > 0}">
                                                <g:each in="${spends}" var="spend">
                                                    <div class="spend-matrix-template" id="spend-matrix-template${spend.numberAvailable}">
                                                        <g:if test="${spend.numberAvailable > 1}"><br class="hidden-lg hidden-md hidden-sm"></g:if>
                                                        
                                                        <div class="col-sm-amt col-sm-12">
                                                        
                                                            <span class="cr-label-spend-matrix col-sm-2 col-xs-12">I require</span>
                                                            <div class="form-group col-sm-3 col-xs-4 col-sm-input-group">
                                                                <g:if test="${country_code == 'in'}">
                                                                     <span class="fa fa-inr cr-currency"></span>
                                                                </g:if>
                                                                <g:else>
                                                                     <span class="fa fa-usd cr-currency"></span>
                                                                </g:else>
                                                                <input type="text" class="form-control form-control-no-border-amt form-control-input-width spendAmount" id="spendAmount${spend.numberAvailable}" value="${spend.amount.round()}" name="spendAmount${spend.numberAvailable}">
                                                                <span class="digitsError"></span>
                                                            </div>
                                                            <span class="cr-label-spend-matrix-for col-sm-1 col-xs-1">for</span>
                                                            <div class="col-sm-5 col-xs-7 col-input-for form-group">
                                                                <input type="text" class="form-control form-control-input-for spendCause" maxlength="64" id="spendCause${spend.numberAvailable}" name="spendCause${spend.numberAvailable}" value="${spend.cause}">
                                                            </div>&nbsp;&nbsp;
                                                            <div class="clear visible-xs"></div>
                                                            <div class="btn btn-circle spend-matrix-icons spendMatrixTemplateSave">
                                                                <g:hiddenField name="spendFieldSave" value="${spend.numberAvailable}" class="spendFieldSave" id="spendFieldSave${spend.numberAvailable}"/>
                                                                <i class="glyphicon glyphicon-floppy-save glyphicon-size glyphicon-save"></i>
                                                            </div>
                                                            <g:if test="${spend.numberAvailable != 1}">
                                                                <div class="btn btn-circle spend-matrix-icons spendMatrixTemplateDelete">
                                                                    <input type="hidden" name="spendFieldDelete" value="${spend.numberAvailable}" class="spendFieldDelete">
                                                                    <i class="glyphicon glyphicon-trash glyphicon-size"></i>
                                                                </div>
                                                            </g:if>
                                                            <div class="btn btn-circle spend-matrix-icons spendMatrixTemplateAdd <g:if test="${spend.numberAvailable != spendLastNumAvail}">display-none</g:if>" id="spendMatrixTemplateAdd${spend.numberAvailable}">
                                                                <i class="glyphicon glyphicon-plus glyphicon-size"></i>
                                                            </div>
                                                        </div>
                                                        <g:hiddenField name="spenMatrixNumberAvailable" class="spenMatrixNumberAvailable" value="${spend.numberAvailable}" id="spenMatrixNumberAvailable${spend.numberAvailable}"/>
                                                    </div>
                                                </g:each>
                                                <g:hiddenField name="lastSpendField" id="lastSpendField" value="${spendLastNumAvail}"/>
                                            </g:if>
                                            <g:else>
                                                <div class="spend-matrix-template" id="spend-matrix-template1">
                                                <div class="col-sm-amt col-sm-12">
                                                    <span class="cr-label-spend-matrix col-sm-2 col-xs-12">I require</span>
                                                    <div class="form-group col-sm-3 col-xs-4 col-sm-input-group">
                                                        <g:if test="${country_code == 'in'}">
                                                            <span class="fa fa-inr cr-currency"></span>
                                                        </g:if>
                                                        <g:else>
                                                            <span class="fa fa-usd cr-currency"></span>
                                                        </g:else>
                                                        <input type="text" class="form-control form-control-no-border-amt form-control-input-width spendAmount" id="spendAmount1" name="spendAmount1">
                                                        <span class="digitsError"></span>
                                                    </div>
                                                    <span class="cr-label-spend-matrix-for col-sm-1 col-xs-1">for</span>
                                                    <div class="col-sm-5 col-xs-7 col-input-for form-group">
                                                    <input type="text" class="form-control form-control-input-for spendCause" maxlength="64" id="spendCause1" name="spendCause1">
                                                    </div>&nbsp;&nbsp;
                                                    <div class="clear visible-xs"></div>
                                                    <div class="btn btn-circle spend-matrix-icons spendMatrixTemplateSave">
                                                        <g:hiddenField name="spendFieldSave" value="1" class="spendFieldSave" id="spendFieldSave1"/>
                                                        <i class="glyphicon glyphicon-floppy-save glyphicon-size glyphicon-save"></i>
                                                    </div>
                                                    <div class="btn btn-circle spend-matrix-icons spendMatrixTemplateAdd" id="spendMatrixTemplateAdd1">
                                                        <i class="glyphicon glyphicon-plus glyphicon-size"></i>
                                                    </div>
                                                </div>
                                                <g:hiddenField name="spenMatrixNumberAvailable" class="spenMatrixNumberAvailable" value="1" id="spenMatrixNumberAvailable1"/>
                                                </div>
                                                <g:hiddenField name="lastSpendField" id="lastSpendField" value="1"/>
                                            </g:else>
                                        </div>
                                        <div class="col-sm-offset-0 col-sm-3 col-xs-offset-1 col-xs-11 col-sm-pie-left-pdding pieChart">
                                            <g:render template="create/pieChartWithoutLabel"/>
                                        </div>
                                        <div class="clear"></div>
                                        <div class="height-xs">
                                           <span class="saved-message">Spend Saved</span>
                                        </div>
                                    </div>
                                </div>
                                
                                <div class="col-sm-12 padding-right-xs col-lr-0">
                                    <div class="cr-spend-matrix">
                                        <label class="col-sm-3 col-xs-12 text-center cr-panel-spend-matrix cr-impact-analysis"><span class="cr-spend-matrix-font">Impact Assessment</span></label>
                                        <label class="col-sm-9 hidden-xs cr-panel-spend-matrix-guide cr-impact-guide"></label>
                                    </div>
                                    <div class="panel panel-body cr-panel-body-spend-matrix cr-panel-impact-analysis">
                                        <g:render template="create/impactAnalysisText"/>
                                    </div>
                                </div>
                                
                                <div class="col-sm-12 padding-right-xs col-lr-0">
                                    <div class="cr-spend-matrix">
                                        <label class="col-sm-3 col-xs-12 text-center cr-panel-spend-matrix cr-reasons-to-fund"><span class="cr-spend-matrix-font">3 Reason to Fund</span></label>
                                        <label class="col-sm-9 col-xs-12 cr-panel-spend-matrix-guide cr-reasons-guide">Let your contributors know why they should fund your campaign.</label>
                                    </div>
                                    <div class="panel panel-body cr-panel-body-spend-matrix cr-panel-body">
                                        <p class="reasons-p form-group">1. <input type="text" name="reason1" class="reason1 reasons form-control" value="${r1}" maxLength="140"></p>
                                        <p class="reasons-p form-group">2. <input type="text" name="reason2" class="reason2 reasons form-control" value="${r2}" maxLength="140"></p>
                                        <p class="reasons-p form-group">3. <input type="text" name="reason3" class="reason3 reasons form-control" value="${r3}" maxLength="140"></p>
                                    </div>
                                </div>
                                
                                <div class="col-xs-12 campaign-btn-div text-center col-lr-0">
                                    <button type="button" class="btn btn-previous campaign-btn-prev pull-left">Previous</button>
                                    <button type="button" class="btn btn-next campaign-btn-primary pull-right" data-groupid= "3">Save And Continue</button>
                                </div>
                                    
                            </fieldset>
                            
                            <fieldset>
                            
                                <div class="col-sm-12 padding-right-xs">
                                    <div class="cr-spend-matrix">
                                         <label class="col-md-1 col-sm-2 col-xs-12 text-center cr-panel-spend-matrix cr-panel-hash-tags"><span class="cr-spend-matrix-font"># Tags</span></label>
                                         <label class="col-md-11 col-sm-10 col-xs-12 cr-panel-spend-matrix-guide cr-panel-hash-tags-guide">
                                             Keywords/Hashtags help contributors narrow their search on Crowdera. Provide at least 5 keywords that would make it easy for contributors to find your campaign
                                         </label>
                                    </div>
                                    <div class="panel panel-body cr-panel-body-spend-matrix form-group cr-panel-body cr-hash-tags">
                                        <textarea name="hashtags" class="hashtags form-control">${project.hashtags}</textarea>
                                    </div>
                                </div>
                                
                                <div class="col-sm-12 padding-right-xs">
                                    <div class="cr-spend-matrix">
                                        <label class="col-sm-3 col-xs-12 text-center cr-panel-spend-matrix cr-reasons-to-fund"><span class="cr-spend-matrix-font">ADMIN</span></label>
                                        <label class="col-sm-9 col-xs-12 cr-panel-spend-matrix-guide cr-reasons-guide"></label>
                                    </div>
                                    <div class="panel panel-body cr-panel-body-spend-matrix cr-panel-body">
                                        <div class="col-sm-4">
                                            <div class="form-group">
                                                <div class="col-sm-12">
                                                    <g:if test="${email1}">
                                                        <input type="email" class="form-control form-control-no-border cr-placeholder cr-chrome-place text-color cr-marg-mobile" name="email1" id="firstadmin" value="${email1}" placeholder="First Admin" maxlength="64">
                                                    </g:if>
                                                    <g:else>
                                                        <input type="email" class="form-control form-control-no-border cr-placeholder cr-chrome-place text-color cr-marg-mobile" name="email1" id="firstadmin" placeholder="First Admin" maxlength="64">
                                                    </g:else>
                                                </div>
                                            </div>
                                        </div>
                                        
                                        <div class="col-sm-4">
                                            <div class="form-group">
                                                <div class="col-sm-12">
                                                    <g:if test="${email2}">
                                                        <input type="email" class="form-control form-control-no-border cr-placeholder cr-chrome-place text-color cr-marg-mobile" name="email2" id="secondadmin" value="${email2}" placeholder="Second Admin" maxlength="64">
                                                    </g:if>
                                                    <g:else>
                                                        <input type="email" class="form-control form-control-no-border cr-placeholder cr-chrome-place text-color cr-marg-mobile" name="email2" id="secondadmin" placeholder="Second Admin" maxlength="64">
                                                    </g:else>
                                                </div>
                                            </div>
                                        </div>
                                                
                                        <div class="col-sm-4">
                                            <div class="form-group">
                                                <div class="col-sm-12">
                                                    <g:if test="${email3}">
                                                        <input type="email" class="form-control form-control-no-border cr-placeholder cr-chrome-place text-color cr-marg-mobile" name="email3" id="thirdadmin" value="${email3}" placeholder="Third Admin" maxlength="64">
                                                    </g:if>
                                                    <g:else>
                                                        <input type="email" class="form-control form-control-no-border cr-placeholder cr-chrome-place text-color cr-marg-mobile" name="email3" id="thirdadmin" placeholder="Third Admin" maxlength="64">
                                                    </g:else>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                
                                <div class="col-sm-12 padding-right-xs">
                                    <div class="cr-spend-matrix">
                                        <label class="col-sm-3 col-xs-12 text-center cr-panel-spend-matrix cr-reasons-to-fund"><span class="cr-spend-matrix-font">Organization</span></label>
                                        <label class="col-sm-9 col-xs-12 cr-panel-spend-matrix-guide cr-reasons-guide"></label>
                                    </div>
                                    <div class="panel panel-body cr-panel-body-spend-matrix cr-panel-body">
                                        <div class="col-sm-4">
                                            <div class="form-group" id="organizationName">
                                                <div class="col-sm-12 cr-mobiledisplyorg ">
                                                    <input class="form-control form-control-no-border cr-placeholder cr-chrome-place text-color" name="${FORMCONSTANTS.ORGANIZATIONNAME}" value="${project.organizationName}" id="organizationname" placeholder="Individual / Organization Name" maxlength="128">
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-sm-4">
                                            <div class="form-group">
                                                <div class="col-sm-12 cr-mobiledisplyorg">
                                                    <g:if test="${project.webAddress}">
                                                        <input class="form-control form-control-no-border cr-placeholder cr-chrome-place text-color" name="${FORMCONSTANTS.WEBADDRESS}" id="webAddress" placeholder="URL / Web Address / Facebook" value="${project.webAddress}" maxlength="64">
                                                    </g:if>
                                                    <g:else>
                                                        <input class="form-control form-control-no-border cr-placeholder cr-chrome-place text-color" name="${FORMCONSTANTS.WEBADDRESS}" id="webAddress" placeholder="URL / Web Address / Facebook" maxlength="64">
                                                    </g:else>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-sm-4">
                                            <div class="form-group createOrgIconDiv">
                                                <div class="col-lg-6 col-sm-8 col-md-8 col-xs-7 cr-mobiledisplyorg">
                                                    <div class="fileUpload btn btn-info btn-sm cr-btn-color">
                                                        Display Picture
                                                        <input type="file" class="upload" id="iconfile" name="iconfile" accept="image/jpeg, image/png">
                                                    </div>
                                                    <label class="docfile-orglogo-css" id="logomsg">Please select image file.</label>
                                                    <label class="docfile-orglogo-css" id="iconfilesize">The file you are attempting to upload is larger than the permitted size of 3MB.</label>
                
                                                    <label class="docfile-orglogo-css" id="iconfilesizeSmaller">The file you are attempting to upload is smaller than the permitted size of 10KB.</label>
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
                                                    <div id="uploadingCampaignOrgIcon">Uploading Picture....</div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                
                                <div class="col-sm-12 padding-right-xs">
                                    <div class="cr-spend-matrix">
                                        <label class="col-sm-3 col-xs-12 text-center cr-panel-spend-matrix cr-reasons-to-fund"><span class="cr-spend-matrix-font">Personal</span></label>
                                        <label class="col-sm-9 col-xs-12 cr-panel-spend-matrix-guide cr-reasons-guide"></label>
                                    </div>
                                    <div class="panel panel-body cr-panel-body-spend-matrix cr-panel-body">
                                        <div class="col-sm-4">
                                           <div class="form-group">
                                               <div class="col-sm-12">
                                                   <input type="text" id="firstName" class="form-control form-control-no-border cr-placeholder cr-chrome-place text-color cr-marg-mobile" maxlength="32" name="${FORMCONSTANTS.FIRSTNAME}" value="${user.firstName}" placeholder="First Name" readonly>
                                               </div>
                                           </div>
                                       </div>
               
                                       <div class="col-sm-4">
                                           <div class="form-group">
                                               <div class="col-sm-12">
                                                   <input type="text" id="lastName" class="form-control form-control-no-border cr-placeholder cr-chrome-place text-color cr-marg-mobile" maxlength="32" name="${FORMCONSTANTS.LASTNAME}" value="${user.lastName}" placeholder="Last Name" readonly>
                                               </div>
                                           </div>
                                       </div>
               
                                       <div class="col-sm-4">
                                           <div class="form-group">
                                               <div class="col-sm-12">
                                                   <g:if test="${project.beneficiary.email}">
                                                       <input type="email" id="email" class="form-control form-control-no-border cr-placeholder cr-chrome-place text-color cr-marg-mobile" maxlength="64" name="${FORMCONSTANTS.EMAIL}" placeholder="email" value="${project.beneficiary.email}">
                                                   </g:if>
                                                   <g:else>
                                                       <input type="email" id="email" class="form-control form-control-no-border cr-placeholder cr-chrome-place text-color cr-marg-mobile" maxlength="64" name="${FORMCONSTANTS.EMAIL}" placeholder="email">
                                                   </g:else>
                                               </div>
                                           </div>
                                       </div>
                                       <div class="clear"></div>
                                       <div class="col-sm-4">
                                           <div class="form-group">
                                               <div class="col-sm-12">
                                                   <g:if test="${project.beneficiary.facebookUrl}">
                                                       <input type="text" id="facebookUrl" class="form-control form-control-no-border cr-placeholder cr-chrome-place text-color cr-marg-mobile" maxlength="64" name="${FORMCONSTANTS.FACEBOOKURl}" value="${project.beneficiary.facebookUrl}" placeholder="Facebook Url">
                                                   </g:if>
                                                   <g:else>
                                                       <input type="text" id="facebookUrl" class="form-control form-control-no-border cr-placeholder cr-chrome-place text-color cr-marg-mobile" maxlength="64" name="${FORMCONSTANTS.FACEBOOKURl}" placeholder="Facebook Url">
                                                   </g:else>
                                               </div>
                                           </div>
                                       </div>
               
                                       <div class="col-sm-4">
                                           <div class="form-group">
                                               <div class="col-sm-12">
                                                   <g:if test="${project.beneficiary.twitterUrl}">
                                                       <input type="text" id="twitterUrl" class="form-control form-control-no-border cr-placeholder cr-chrome-place text-color cr-marg-mobile" maxlength="64" name="${FORMCONSTANTS.TWITTERURl}" value="${project.beneficiary.twitterUrl}" placeholder="Twitter Url">
                                                   </g:if>
                                                   <g:else>
                                                       <input type="text" id="twitterUrl" class="form-control form-control-no-border cr-placeholder cr-chrome-place text-color cr-marg-mobile" maxlength="64" name="${FORMCONSTANTS.TWITTERURl}" placeholder="Twitter Url">
                                                   </g:else>
                                               </div>
                                           </div>
                                       </div>
               
                                       <div class="col-sm-4">
                                           <div class="form-group">
                                               <div class="col-sm-12">
                                                   <g:if test="${project.beneficiary.linkedinUrl}">
                                                       <input type="text" id="linkedinUrl" class="form-control form-control-no-border cr-placeholder cr-chrome-place text-color cr-marg-mobile" maxlength="64" name="${FORMCONSTANTS.LINKEDINURL}" placeholder="Linkedin Url" value="${project.beneficiary.linkedinUrl}">
                                                   </g:if>
                                                   <g:else>
                                                       <input type="text" id="linkedinUrl" class="form-control form-control-no-border cr-placeholder cr-chrome-place text-color cr-marg-mobile" maxlength="64" name="${FORMCONSTANTS.LINKEDINURL}" placeholder="Linkedin Url">
                                                   </g:else>
                                               </div>
                                           </div>
                                       </div>
                                       <div class="clear"></div>
                                       <div class="col-sm-4">
                                           <div class="form-group">
                                               <div class="col-sm-12">
                                                   <g:if test="${project.beneficiary.telephone}">
                                                       <input type="tel" id="telephone" class="form-control form-control-no-border cr-placeholder cr-chrome-place text-color cr-marg-mobile" maxlength="16" name="${FORMCONSTANTS.TELEPHONE}" placeholder="Phone" value="${project.beneficiary.telephone}">
                                                   </g:if>
                                                   <g:else>
                                                       <input type="tel" id="telephone" class="form-control form-control-no-border cr-placeholder cr-chrome-place text-color cr-marg-mobile" maxlength="16" name="${FORMCONSTANTS.TELEPHONE}" placeholder="Phone">
                                                   </g:else>
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
                                
                                
                                <div class="col-xs-12 campaign-btn-div text-center">
                                    <button type="button" class="btn btn-previous campaign-btn-prev pull-left">Previous</button>
                                    <button type="button" class="btn btn-next campaign-btn-primary pull-right" data-groupid= "4">Save And Continue</button>
                                </div>
                                    
                            </fieldset>
                                
                            <fieldset>
                            
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
                                                            <g:if test="${country_code == 'in'}">
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
                                                            <input type="text" maxlength="64" placeholder="Name of Perk" name="rewardTitle${reward.rewardCount}" class="form-control cr-tablet-left cr-perk-title-number form-control-no-border text-color cr-placeholder cr-chrome-place rewardTitle" id="rewardTitle${reward.rewardCount}" value="${reward.title}">
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
                                                    <div class="col-sm-12 col-xs-12">
                                                        <g:if test="${country_code == 'in'}">
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
                                                        <input type="text" maxlength="64" placeholder="Name of Perk" name="rewardTitle1" class="form-control rewardTitle cr-tablet-left cr-perk-title-number form-control-no-border text-color cr-placeholder cr-chrome-place" id="rewardTitle1">
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
                                
                                <div class="col-xs-12 campaign-btn-div text-center">
                                    <button type="button" class="btn btn-previous campaign-btn-prev pull-left">Previous</button>
                                    <button type="button" class="btn btn-next campaign-btn-primary pull-right" data-groupid= "5">Save And Continue</button>
                                </div>
            
                           </fieldset>
                           
                           <fieldset>
                                
                                <div class="form-group">
                                    <div class="col-sm-12 cr-payments-pad" id="payment">
                                        <div class="cr-story-flx cr-payment-marg col-sm-12 cr-safari">
                                            <label class="panel-body cr-payments-lab cr-safari">PAYMENTS</label>
                                            <label class="panel-body cr-payments">Payments are sent and received via your choice of Payment Gateway.
                                            You keep 100% of the money you raise. Crowdera does not charge any fee to you.</label>
                                        </div>
                                    </div>
                                </div><br>
                                
                                <div class="form-group">
                                    <g:if test="${country_code == 'in'}">
                                        <div id="PayUMoney">
                                            <div class="form-group">
                                                <label class="col-sm-4 control-label">Email</label>
                                                <div class="col-sm-6 col-xs-10">
                                                    <g:if test="${project.payuEmail}">
                                                        <input type="email" maxlength="64" id="payuemail" class="form-control form-control-no-border cr-payu-space-mobile text-color" name="${FORMCONSTANTS.PAYUEMAIL}" value="${project.payuEmail}">
                                                    </g:if>
                                                    <g:else>
                                                        <input type="email" maxlength="64" id="payuemail" class="form-control form-control-no-border cr-payu-space-mobile text-color" name="${FORMCONSTANTS.PAYUEMAIL}">
                                                    </g:else>
                                                </div>
                                            </div>
                                        </div>
                                        <g:if test ="${currentEnv == 'testIndia'}">
                                            <div id="CitrusPay">
                                                <div class="form-group">
                                                    <label class="col-sm-4 control-label">Email</label>
                                                    <div class="col-sm-6 col-xs-10">
                                                        <g:if test="${project.citrusEmail}">
                                                            <input type="email" id="citrusemail" maxlength="64" class="form-control form-control-no-border cr-payu-space-mobile text-color" name="${FORMCONSTANTS.CITRUSEMAIL}" value="${project.citrusEmail}">
                                                        </g:if>
                                                        <g:else>
                                                            <input type="email" id="citrusemail" maxlength="64" class="form-control form-control-no-border cr-payu-space-mobile text-color" name="${FORMCONSTANTS.CITRUSEMAIL}">
                                                        </g:else>
                                                    </div>
                                                </div>
                                            </div>
                                        </g:if>
                                    </g:if>
                                    <g:else>
                                        <div class="col-sm-12" id="paypalemail">
                                            <div class="form-group">
                                                <img class="col-sm-4 cr-paypal-image" src="//s3.amazonaws.com/crowdera/assets/paypal-Image.png" alt="paypal">
                                                <div class="col-sm-6 paypalVerification">
                                                    <g:if test="${project.paypalEmail}">
                                                        <input id="paypalEmailId" type="email" maxlength="64" class="form-control paypal-create form-control-no-border cr-placeholder cr-chrome-place" value="${project.paypalEmail}" name="${FORMCONSTANTS.PAYPALEMAIL}" placeholder="Paypal email address">
                                                    </g:if>
                                                    <g:else>
                                                        <input id="paypalEmailId" type="email" maxlength="64" class="form-control paypal-create form-control-no-border cr-placeholder cr-chrome-place" name="${FORMCONSTANTS.PAYPALEMAIL}" placeholder="Paypal email address">
                                                    </g:else>
                                                    <g:hiddenField name="paypalEmailAck" value="" id="paypalEmailAck"/>
                                                </div>
                                            </div>
                                        </div>
                                        
                                        
                                        <div class="col-sm-12 cr-tablet-space cr-center-charity" id="charitableId">
                                            <div class="form-group">
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
                                    
                                    <div class="col-sm-12">
                                        <div class="col-md-offset-4 col-md-8 col-sm-offset-3 col-sm-9">
                                            <div class="form-group form-group-termsOfUse <g:if test="${(project.fundsRecievedBy != 'NGO' && (country_code == 'in')) || (project.fundsRecievedBy != 'NON-PROFIT' && (country_code == 'us'))}">tax-reciept</g:if>" id="tax-reciept">
                                                <input type="checkbox" name="tax-reciept-checkbox" class="tax-reciept-checkbox" id="tax-reciept-checkbox" <g:if test="${project.offeringTaxReciept}">checked="checked"</g:if>>
                                                Do you want to offer donation receipt to your contributors?
                                            </div>
                                        </div>
                                    </div>
                                    
                                    <div class="col-sm-12 padding-tax-reciept-xs col-tax-reciept-panel <g:if test="${!project.offeringTaxReciept}">col-reciept-display-none</g:if>">
                                        <div class="cr-spend-matrix">
                                             <label class="col-md-2 col-sm-3 col-xs-12 text-center cr-panel-spend-matrix"><span class="cr-spend-matrix-font">Donation receipts</span></label>
                                             <label class="col-md-10 col-sm-9 hidden-xs cr-panel-spend-matrix-guide">
                                             </label>
                                        </div>
                                        <div class="panel panel-body cr-panel-body-spend-matrix form-group cr-panel-body cr-hash-tags">
                                            <g:if test="${project.payuStatus}">
                                                 <g:if test="${taxReciept}">
                                                     <div class="row">
                                                         <div class="col-sm-4">
                                                             <div class="col-sm-12 form-group form-group-tax-reciept">
                                                                  <input type="text" maxlength="64" placeholder="Registered Name" class="form-control tax-reciept-holder-name" name="tax-reciept-holder-name" value="${taxReciept.name}">
                                                             </div>
                                                             <div class="col-sm-12 form-group form-group-tax-reciept">
                                                                 <g:if test="${dateFormat.format(taxReciept.regDate) == dateFormat.format(currentDate)}">
                                                                     <input type="text" class="form-control datepicker-reg text-date" placeholder="Registration Date" name="reg-date">
                                                                 </g:if>
                                                                 <g:else>
                                                                     <input type="text" class="form-control datepicker-reg text-date" placeholder="Registration Date" name="reg-date" value="${dateFormat.format(taxReciept.regDate)}">
                                                                 </g:else>
                                                             </div>
                                                             <div class="col-sm-12 form-group form-group-tax-reciept">
                                                                 <input type="text" maxlength="64" class="form-control addressLine1" placeholder="AddressLine 1" name="addressLine1" value="${taxReciept.addressLine1}">
                                                             </div>
                                                             <div class="col-sm-12 form-group form-group-tax-reciept">
                                                                 <input type="text" maxlength="16" class="form-control zip" placeholder="ZIP" name="zip"  value="${taxReciept.zip}">
                                                             </div>
                                                         </div>
                                                         <div class="col-sm-4">
                                                             <div class="col-sm-12 form-group form-group-tax-reciept">
                                                                 <input type="text" maxlength="32" placeholder="Registration Number" class="form-control tax-reciept-registration-num" name="tax-reciept-registration-num" value="${taxReciept.regNum}">
                                                             </div>
                                                             <div class="col-sm-12 form-group form-group-tax-reciept">
                                                                 <g:if test="${dateFormat.format(taxReciept.expiryDate) == dateFormat.format(currentDate)}">
                                                                     <input type="text" class="form-control datepicker-expiry text-date" placeholder="Expiry Date" name="expiry-date">
                                                                 </g:if>
                                                                 <g:else>
                                                                     <input type="text" class="form-control datepicker-expiry text-date" placeholder="Expiry Date" name="expiry-date" value="${dateFormat.format(taxReciept.expiryDate)}">
                                                                 </g:else>
                                                             </div>
                                                              <div class="col-sm-12 form-group form-group-tax-reciept">
                                                                 <input type="text" maxlength="64" class="form-control addressLine2" placeholder="AddressLine 2" name="addressLine2" value="${taxReciept.addressLine2}">
                                                             </div>
                                                             <div class="col-sm-12 form-group form-group-tax-reciept form-group-selectpicker form-group-dropdown">
                                                                 <g:select class="selectpicker form-control selectpicker-state tax-reciept-dropdown-menu" name="tax-reciept-holder-state" from="${stateInd}" optionKey="value" optionValue="value" value="${taxReciept.taxRecieptHolderState}" noSelection="['OTHER':'State']"/>
                                                             </div>
                                                         </div>
                                                         <div class="col-sm-4">
                                                             <div class="col-sm-12 form-group form-group-tax-reciept">
                                                                 <input type="text" maxlength="16" placeholder="PAN Card Number" class="form-control tax-reciept-holder-pan-card" name="tax-reciept-holder-pan-card" value="${taxReciept.panCardNumber}">
                                                             </div>
                                                             <div class="col-sm-12 form-group form-group-tax-reciept">
                                                                 <input type="text" maxlength="16" placeholder="Phone Number" class="form-control tax-reciept-holder-phone" name="tax-reciept-holder-phone" value="${taxReciept.phone}" >
                                                             </div>
                                                             <div class="col-sm-12 form-group form-group-tax-reciept">
                                                                 <input type="text" maxlength="32" class="form-control tax-reciept-holder-city" placeholder="City" name="tax-reciept-holder-city" value="${taxReciept.city}">
                                                             </div>
                                                             <div class="col-sm-12 form-group form-group-tax-reciept">
                                                                 <input type="text" class="form-control country" placeholder="Country" name="country" value="India" readonly>
                                                             </div>
                                                         </div>
                                                 
                                                         <div class="col-sm-4">
                                                             <div class="col-sm-12 form-group form-group-tax-reciept">
                                                                  <input type="text" maxlength="32" class="form-control tax-reciept-orgStatus" placeholder="Status of Organization" name="tax-reciept-orgStatus" value="${taxReciept?.deductibleStatus}" >
                                                              </div>
                                                         </div>
                                                         <div class="col-sm-4">
                                                             <div class="col-sm-12 form-group form-group-tax-reciept">
                                                                 <input type="text" maxlength="5" class="form-control tax-reciept-exemptionPercentage" placeholder="% of Exemption" name="tax-reciept-exemptionPercentage" value="${taxReciept?.exemptionPercentage}" >
                                                             </div>
                                                         </div>
                                                              
                                                         <div class="col-sm-4 col-xs-12">
                                                             <div class="col-sm-12 col-md-7 col-xs-9 digital_signature">
                                                                 <div class="fileUpload btn btn-info btn-sm cr-btn-color ">
                                                                     Add Digital Signature
                                                                     <input type="file" class="upload" id="digitalSign" name="digitalSign" accept="image/jpeg, image/png">
                                                                 </div>
                                                             </div>
                                                             <div class="signature_img_seperator"></div>
                                                             <g:if test="${taxReciept.signatureUrl}">
                                                                 <div class="pr-icon-thumbnail-div edit-image-mobile col-sm-12 col-md-5 col-xs-3">
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
                                                         <div class="col-sm-4">
                                                             <div class="col-sm-12 form-group form-group-tax-reciept">
                                                                  <input type="text" maxlength="64" placeholder="Registered Name" class="form-control tax-reciept-holder-name" name="tax-reciept-holder-name">
                                                             </div>
                                                             <div class="col-sm-12 form-group form-group-tax-reciept">
                                                                 <input type="text" class="form-control datepicker-reg text-date" placeholder="Registration Date" name="reg-date">
                                                             </div>
                                                             <div class="col-sm-12 form-group form-group-tax-reciept">
                                                                 <input type="text" maxlength="64" class="form-control addressLine1" placeholder="AddressLine 1" name="addressLine1">
                                                             </div>
                                                             <div class="col-sm-12 form-group form-group-tax-reciept">
                                                                 <input type="text" maxlength="16" class="form-control zip" placeholder="ZIP" name="zip">
                                                             </div>
                                                         </div>
                                                         <div class="col-sm-4">
                                                             <div class="col-sm-12 form-group form-group-tax-reciept">
                                                                 <input type="text" maxlength="64" placeholder="Registration Number" class="form-control tax-reciept-registration-num" name="tax-reciept-registration-num">
                                                             </div>
                                                             <div class="col-sm-12 form-group form-group-tax-reciept">
                                                                 <input type="text" class="form-control datepicker-expiry text-date" placeholder="Expiry Date" name="expiry-date">
                                                             </div>
                                                              <div class="col-sm-12 form-group form-group-tax-reciept">
                                                                 <input type="text" maxlength="64" class="form-control addressLine2" placeholder="AddressLine 2" name="addressLine2">
                                                             </div>
                                                             <div class="col-sm-12 form-group form-group-tax-reciept form-group-selectpicker form-group-dropdown">
                                                                 <g:select class="selectpicker form-control selectpicker-state tax-reciept-dropdown-menu" name="tax-reciept-holder-state" from="${stateInd}" optionKey="value" optionValue="value" noSelection="['OTHER':'State']"/>
                                                             </div>
                                                         </div>
                                                         <div class="col-sm-4">
                                                             <div class="col-sm-12 form-group form-group-tax-reciept">
                                                                 <input type="text" maxlength="16" placeholder="PAN Card Number" class="form-control tax-reciept-holder-pan-card" name="tax-reciept-holder-pan-card">
                                                             </div>
                                                             <div class="col-sm-12 form-group form-group-tax-reciept">
                                                                 <input type="text" maxlength="16" placeholder="Phone Number" class="form-control tax-reciept-holder-phone" name="tax-reciept-holder-phone">
                                                             </div>
                                                             <div class="col-sm-12 form-group form-group-tax-reciept">
                                                                 <input type="text" maxlength="32" class="form-control tax-reciept-holder-city" placeholder="City" name="tax-reciept-holder-city">
                                                             </div>
                                                             <div class="col-sm-12 form-group form-group-tax-reciept">
                                                                 <input type="text" class="form-control country" placeholder="Country" name="country" value="India" readonly>
                                                             </div>
                                                         </div>
                                                 
                                                         <div class="col-sm-4">
                                                             <div class="col-sm-12 form-group form-group-tax-reciept">
                                                                 <input type="text" maxlength="32" class="form-control tax-reciept-orgStatus" placeholder="Status of Organization" name="tax-reciept-orgStatus">
                                                             </div>
                                                         </div>
                                                         <div class="col-sm-4">
                                                             <div class="col-sm-12 form-group form-group-tax-reciept">
                                                                 <input type="text" maxlength="5" class="form-control tax-reciept-exemptionPercentage" placeholder="% of Exemption" name="tax-reciept-exemptionPercentage">
                                                             </div>
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
                                                                <input type="text" maxlength="32" placeholder="EIN" class="form-control ein" name="ein" value="${taxReciept.ein}">
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
                                                    
                                                     <div class="col-sm-12 col-xs-12 col-plr-0 rowseperator">
                                                        <div class="col-sm-4 col-xs-12">
                                                            <div class="form-group form-group-tax-reciept">
                                                                <input type="text" maxlength="16" placeholder="Phone Number" class="form-control tax-reciept-holder-phone" name="tax-reciept-holder-phone" value="${taxReciept.phone}">
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
                                                                <input type="text" maxlength="32" placeholder="EIN" class="form-control ein" name="ein">
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
                                                    
                                                    <div class="col-sm-12 col-xs-12 col-plr-0 rowseperator">
                                                        <div class="col-sm-4 col-xs-12">
                                                            <div class="form-group form-group-tax-reciept">
                                                                <input type="text" maxlength="16" placeholder="Phone Number" class="form-control tax-reciept-holder-phone" name="tax-reciept-holder-phone">
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
                                    
                                    <div class="col-sm-12 cr-paddingspace termsOfUseCheckboxOnCreatePage" id="launch">
                                        <div class="col-md-offset-4 col-md-8 col-sm-offset-3 col-sm-9">
                                            <div class="form-group form-group-termsOfUse">
                                                <input type="checkbox" name="checkBox" id="agreetoTermsandUse" <g:if test="${project.touAccepted}">checked="checked"</g:if>>  I accept <a href="${resource(dir: '/termsofuse')}">Terms of Use</a> and have read <a href="${resource(dir: '/privacypolicy')}">Privacy Policy</a>
                                            </div>
                                        </div>
                                        <div class="clear"></div>
                                        <div class="col-sm-6 text-center">
                                            <button type="button" class="cr-bg-preview-btn cr-btn-alignment-pre cr-btn-margin createsubmitbutton hidden-xs" id="previewButton"  name="button"></button>
                                            <button class="cr-bg-xs-preview-btn cr-xs-mobile createsubmitbutton visible-xs" id="previewButtonXS" type="button" name="button"></button>
                                        </div>
                                        <g:hiddenField name="isSubmitButton" value="true" id="isSubmitButton"></g:hiddenField>
                                           
                                        <div class="col-sm-6 text-center">
                                            <button type="submit" class="cr-bg-Launch-btn cr-btn-alignment-lac cr-btn-launch createsubmitbutton hidden-xs" id="submitProject" name="button" value="submitProject"></button>
                                            <button type="submit" class="cr-bg-xs-Launch-btn cr-xs-mobile createsubmitbutton visible-xs" id="submitProjectXS" name="button" value="submitProject"></button>
                                        </div>
                                    </div>
                                </div>
                                
                                
                            </fieldset>
                            
                            
                        </g:uploadForm> 
                     </div>
                        
                 </div>
            </div>
        
            
            <div class="clear"></div>
            
            
            <!-- Modal -->
            <div class="modal fade" id="addVideo" tabindex="-1" role="dialog" aria-hidden="true">
                <div class="modal-dialog modal-xs">
                    <div class="modal-content">
                        <div class="modal-header video-modal">
                            <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
                            <h3 class="modal-title text-center"><b>Edit Video</b></h3>
                        </div>
                        <div class="modal-body">
                            <div class="row">
                                <div class="form-group col-xs-text-box-with-button">
                                    <div class="col-sm-10 col-xs-9 col-xs-textbox">
                                        <input class="form-control form-control-no-border text-color videoUrl" id="videoUrlTextModal" name="${FORMCONSTANTS.VIDEO}" value="${project.videoUrl}" placeholder="Video URL">
                                        <span id="video-error-msg">This field is required.</span>
                                    </div>
                                    <div class="col-sm-2 col-xs-2 col-xs-button">
                                        <button type="button" class="btn btn-info btn-sm cr-btn-color add btn-center" id="addVideoFromModal">Add</button>
                                    <div>
                                </div>
                            </div>
                        </div>
                        
                    </div>
                </div>
            </div>
                
            </div>
            </div>
        </div>
    </div>
    <div class="loadinggif text-center" id="loading-gif">
        <img src="//s3.amazonaws.com/crowdera/documents/loading.gif" alt="'loadingImage'" id="loading-gif-img">
    </div>
    
    
    <!-- Required field modal -->
        <div class="modal fade" id="requiredField" tabindex="-1" role="dialog" aria-hidden="true">
             <div class="modal-dialog modal-xs">
                 <div class="modal-content">
                     <div class="modal-header video-modal">
                         <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
                         <h3 class="modal-title text-center"><b>Information!</b></h3>
                     </div>
                     <div class="modal-body requireFieldBody">
                         <h4 class="requiredFieldHeading"><span id="requiredFieldMessage"></span></h4>
                     </div>
                     
                 </div>
             </div>
         </div>
    
    <script src="/js/main.js"></script>
    <script src="/js/bootstrap-datepicker.js"></script>
    <script>
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

    var j = jQuery.noConflict();
    j(function(){

        var nowTemp = new Date();
        var now = new Date(nowTemp.getFullYear(), nowTemp.getMonth(), nowTemp.getDate(), 0, 0, 0, 0);
        
        j('.datepicker-reg').datepicker({
            onRender: function(date) {
                return date.valueOf() > now.valueOf() ? 'disabled' : '';
            }
        }).on('changeDate', function(){
            autoSave('regDate', $('.datepicker-reg').val());
        });
        
        j('.datepicker-expiry').datepicker({
            onRender: function(date) {
                return date.valueOf() < now.valueOf() ? 'disabled' : '';
            }
        }).on('changeDate', function(){
            autoSave('expiryDate', $('.datepicker-expiry').val());
        });

        j('.fcra-reg-date').datepicker({
            onRender: function(date) {
                return date.valueOf() > now.valueOf() ? 'disabled' : '';
            }
        }).on('changeDate', function(){
            autoSave('fcraRegDate', $('.fcra-reg-date').val());
        });
    });

    function autoSave(variable, varValue) {
    	console.log(  variable, "variable-Logged!");
    	console.log(  varValue, "varValue-Logged!");
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
        });
    }

    function deleteTaxRecieptFiles(current, fileId, taxRecieptId) {
        $.ajax({
            type:'post',
            url:$("#b_url").val()+'/project/deleteTaxRecieptFile',
            data:'fileId='+fileId+'&taxRecieptId='+taxRecieptId,
            success: function(data){
                $(current).parents('.cr-tax-files').remove();
            }
        }).error(function(){
        });
    }
    
    </script>
    </body>
</html>
