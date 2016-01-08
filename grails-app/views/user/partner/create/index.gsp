<html>
<head>
    <meta name="layout" content="main" />
    <r:require module="createpartnerjs"/>
</head>
<body>
    <div class="feducontent partnercreatepage">
        <div class="container footer-container" id="partner-create-page">
            <h1 class="mainheading">Create your Partner Page</h1>
            <g:uploadForm action="partnersave" controller="user">
                <g:hiddenField name="partnerId" value="${partner.id}"/>
                <g:hiddenField name="customUrlStatus" id="customUrlStatus" value="true"/>
                
	            <div class="partnerorgdetails">
	                <div class="col-lg-6 col-md-6 col-sm-6 partner-margin-bottom">
	                   <div class="form-group">
	                       <label class="col-sm-12 text-color orgName-padding">Name of your Organization</label>
	                       <div class="col-sm-12 orgName-padding">
	                           <input type="text" class="form-control form-control-no-border text-color cr1-box-size" id="orgName" name="orgName" value="${partner.orgName}" placeholder="Organization Name">
	                       </div>
	                   </div>
	                </div>
                    
	                <div class="col-lg-6 col-md-6 col-sm-6">
	                    <label class="col-sm-12 text-color cr1-vanity-label-indx1 cr1-vanity-label-indx1 hidden-xs">Link for your partner page</label>
	                    <label class="col-sm-12 text-color cr1-vanity-label-indx1 cr1-vanity-label-indx1 visible-xs">
	                        <g:if test="${currentEnv == 'testIndia' || currentEnv == 'stagingIndia' || currentEnv == 'prodIndia'}">
	                            crowdera.in/partners/
	                        </g:if>
	                        <g:else>
	                            crowdera.co/partners/
	                        </g:else>
	                    </label>
	                    <div class="col-sm-12 col-xs-12 form-group col-partner-page">
	                        <div class="cr1-vanityUrl-indx1 hidden-xs">
	                            <g:if test="${currentEnv == 'testIndia' || currentEnv == 'stagingIndia' || currentEnv == 'prodIndia'}">
	                                crowdera.in/partners/
	                            </g:if>
	                            <g:else>
	                                crowdera.co/partners/
	                            </g:else>
	                        </div>
	                        <input class="form-control form-control-no-border partnercustomUrl cr-placeholder cr-chrome-place text-color" name="customUrl" id="customUrl" value="${partner.customUrl}" placeholder="Your-partner-page-url">
	                        <label class="pull-right " id="titleLength"></label>
	                    </div>
	                </div>
	            </div>
	            <div class="col-sm-12">
	                <div class="form-group">
	                    <label class="text-color orgName-padding">Description</label>
	                    <textarea name="description" class="redactorEditor">
	                        <g:if test="${partner.description}">${partner.description}</g:if>
	                    </textarea>
	                </div>
	            </div>
	            
	            <div class="col-sm-6 partner-category-dropdown partner-margin-bottom" id="category">
	                <div class="col-sm-12 orgName-padding">
		                <label class="text-color orgName-padding">Which category best describes the majority of your campaigns?</label>
		                <div class="btn-group btn-input btn-block clearfix">
		                    <button type="button" class="btn btn-default btn-block dropdown-toggle" data-toggle="dropdown">
		                        <span data-bind="label"><g:if test="${partner.category}">${partner.category}</g:if><g:else>Category</g:else></span>&nbsp;<span class="caret"></span>
		                    </button>
		                    <ul class="dropdown-menu">
		                        <li><a href="#">Animals</a></li>
		                        <li><a href="#">Arts</a></li>
		                        <li><a href="#">Children</a></li>
		                        <li><a href="#">Community</a></li>
		                        <li><a href="#">Civic Needs</a></li>
		                        <li><a href="#">Education</a></li>
		                        <li><a href="#">Elderly</a></li>
		                        <li><a href="#">Environment</a></li>
		                        <li><a href="#">Film</a></li>
		                        <li><a href="#">Health</a></li>
		                        <li><a href="#">Non Profits</a></li>
		                        <li><a href="#">Social Innovation</a></li>
		                        <li><a href="#">Religion</a></li>
		                        <li><a href="#">Other</a></li>
		                    </ul>
		                </div>
	                </div>
	            </div>
	            
<%--	            <div class="col-sm-6">--%>
<%--	                <div class="col-sm-12 col-xs-12 col-xs-zero-padding">--%>
<%--	                    <label class="text-color orgName-padding">Do you want to approve your campaign before they go live?</label>--%>
<%--	                    <div class="form-group">--%>
<%--	                        <p class="partnerRadioBtn"><input type="radio" name="answer" class="ans1" value="yes">&nbsp;YES&nbsp;&nbsp;&nbsp;--%>
<%--	                        <input type="radio" name="answer" class="ans1" value="no">&nbsp;NO</p>--%>
<%--	                    </div>--%>
<%--	                </div>--%>
<%--	            </div>--%>
	            <div class="clear"></div>
	            <div class="col-sm-12 partner-contact-info">
	                <div class="partner-contact-info-label">
	                    <label class="col-md-3 col-sm-3 col-xs-12 text-center contact-info-label"><span class="contact-info-label-font">Social Info</span></label>
	                    <label class="col-md-9 col-sm-9 hidden-xs contact-info-guide">
	                        Appears under "Contact Us" on your Partner Page
	                    </label>
	                </div>
	                <div class="panel panel-body cr-partner-contact-info">
	                    <div class="col-sm-12 col-xs-12 rowseperator">
	                        <div class="col-sm-4 contact-info-bottom">
                                <div class="form-group">
                                    <input type="text" id="facebookUrl" class="form-control form-control-no-border cr-placeholder cr-chrome-place text-color" name="facebookUrl" value="${partner.facebook}" placeholder="Facebook Url">
                                </div>
                            </div>
		                    <div class="col-sm-4 contact-info-bottom">
		                        <div class="form-group">
		                            <input type="text" id="twitterUrl" class="form-control form-control-no-border cr-placeholder cr-chrome-place text-color" name="twitterUrl" value="${partner.twitter}" placeholder="Twitter Url">
		                        </div>
		                    </div>
		
		                    <div class="col-sm-4 contact-info-bottom">
		                        <div class="form-group">
	                                <input type="text" id="linkedinUrl" class="form-control form-control-no-border cr-placeholder cr-chrome-place text-color" name="linkedinUrl" value="${partner.linkedin}" placeholder="Linkedin Url">
		                        </div>
		                    </div>
	                    </div>
	                    <div class="col-sm-12 col-xs-12 rowseperator">
	                        <div class="col-sm-4 contact-info-bottom">
                                <div class="form-group">
                                    <input type="text" id="website" class="form-control form-control-no-border cr-placeholder cr-chrome-place text-color" name="website" value="${partner.website}" placeholder="Website">
                                </div>
                            </div>
	                        <div class="col-sm-4 contact-info-bottom">
                                <div class="form-group">
                                    <input type="text" id="youtubeUrl" class="form-control form-control-no-border cr-placeholder cr-chrome-place text-color" name="youtubeUrl" value="${partner.youTube}" placeholder="YouTube Url">
                                </div>
                            </div>
	                    </div>
	                </div>
	            </div>
	            
	            <div class="col-sm-12 partner-contact-info">
	                <div class="partner-contact-info-label partner-org-info">
	                    <label class="col-md-4 col-xs-12 text-center contact-info-label"><span class="contact-info-label-font">Organization Information</span></label>
	                    <label class="col-md-8 hidden-xs contact-info-guide org-info-guide">
	                        This information is used by Indiegogo to contact you and will not be shared publicly.
	                    </label>
	                </div>
	                <div class="panel panel-body cr-partner-contact-info">
	                    <div class="col-sm-12 col-xs-12 rowseperator">
		                    <div class="col-sm-4 contact-info-bottom">
	                            <div class="form-group">
	                                <input type="text" id="name" class="form-control form-control-no-border cr-placeholder cr-chrome-place text-color" name="name" value="${user.firstName}" placeholder="Name">
	                            </div>
	                        </div>
	                        <div class="col-sm-4 contact-info-bottom">
	                            <div class="form-group">
	                                <input type="email" id="email" class="form-control form-control-no-border cr-placeholder cr-chrome-place text-color  " name="email" value="${partner.email}" placeholder="Email">
	                            </div>
	                        </div>
	                        <div class="col-sm-4 contact-info-bottom">
	                            <div class="form-group">
	                                <input type="text" id="telephone" class="form-control form-control-no-border cr-placeholder cr-chrome-place text-color" name="telephone" value="${partner.telePhone}" placeholder="Phone">
	                            </div>
	                        </div>
	                    </div>
	                    <div class="col-sm-12 col-xs-12 rowseperator">
		                    <div class="col-sm-4 contact-info-bottom">
		                        <div class="form-group" id="partner-country">
		                            <g:select class="selectpicker" id="country" name="country" from="${country}" value="${partner.country}" optionKey="key" optionValue="value"/>
		                        </div>
		                    </div>
		                    <div class="col-sm-4 contact-info-bottom">
		                        <div class="form-group">
	                                <input type="text" id="addressLine1" class="form-control form-control-no-border cr-placeholder cr-chrome-place text-color" name="addressLine1" value="${partner.addressLine1}" placeholder="Address Line1">
		                        </div>
		                    </div>
		
		                    <div class="col-sm-4 contact-info-bottom">
		                        <div class="form-group">
	                                <input type="text" id="addressLine2" class="form-control form-control-no-border cr-placeholder cr-chrome-place text-color" name="addressLine2" value="${partner.addressLine2}" placeholder="Address Line2">
		                        </div>
		                    </div>
		                </div>
	                    <div class="col-sm-12 col-xs-12 rowseperator">
		                    <div class="col-sm-4 contact-info-bottom">
		                        <div class="form-group">
	                                <input type="text" id="city" class="form-control form-control-no-border cr-placeholder cr-chrome-place text-color" name="city" value="${partner.city}" placeholder="City">
		                        </div>
		                    </div>
		                    <div class="col-sm-4 contact-info-bottom">
		                        <div class="form-group">
	                                <input type="text" id="state" class="form-control form-control-no-border cr-placeholder cr-chrome-place text-color" name="state" value="${partner.state}" placeholder="State">
		                        </div>
		                    </div>
		                    <div class="col-sm-4 contact-info-bottom">
		                        <div class="form-group">
	                                <input type="text" id="zipCode" class="form-control form-control-no-border cr-placeholder cr-chrome-place text-color" name="zipCode" value="${partner.zipCode}" placeholder="ZIP Code">
		                        </div>
		                    </div>
	                    </div>
	                </div>
	            </div>
	            <div class="col-sm-12">
	                <div class="form-group">
                        <input type="checkbox" name="checkBox" id="agreetoTermsandUse">  I have read and accept the <a href="${resource(dir: '/termsofuse')}">Partner Terms</a> 
                    </div>
	            </div>
	            
                <div class="col-sm-12 cr-paddingspace text-center" id="save">
                    <button type="submit" class="btn btn-default partnersavebtn" name="button" id="partnersaveButton">Launch</button>
                </div>
            </g:uploadForm>
        </div>
    </div>
</body>
</html>
