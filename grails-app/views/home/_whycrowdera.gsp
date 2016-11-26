<!-- Changes for new home page -->
<g:if test="${currentEnv == 'testIndia' || currentEnv == 'stagingIndia' || currentEnv == 'prodIndia'}">
<div class="container how-it-work-container">
   <div class="row">
    <h1 class="text-center headingtext1">Multiple Reasons to Fundraise on Crowdera</h1>
   </div> 
</div>
<div class="container whycrowderatemplate how-it-work-container">
    <div class="row hidden-sm hidden-xs whycrowderacol-md-2">
        <div class="col-md-6 whycrowderacol-md-12">
            <div class="col-md-12 whycrowderadiv whycrowderacol-md">
                <div class="col-md-2">
                    <img class="whycrowderaimg" src="//s3.amazonaws.com/crowdera/assets/crowdera-is-free-icon.png" alt="crowdera-is-free">
                </div>
                <div class="col-md-10">
                    <h4 class="pull-left subheadingtext">Crowdera is FREE*</h4>
                    <div class="clear"></div>
                    <p class="pull-left crowderacontent1">We don't dip into your donor dollars - No Fee at all.</p>
                </div>
            </div>
            <div class="col-md-12 whycrowderadiv whycrowderadiv2 whycrowderacol-md">
                <div class="col-md-2">
                    <img class="whycrowderaimg" src="//s3.amazonaws.com/crowdera/assets/flexible-funding-icon.png" alt="Flexible-Deadline">
                </div>
                <div class="col-md-10">
                    <h4 class="pull-left subheadingtext">Flexible Funding</h4>
                    <div class="clear"></div>
                    <p class="pull-left crowderacontent1">You keep the money you raise, even if it is just 1% of the goal.</p>
                </div>
            </div>
            <div class="col-md-12 whycrowderadiv whycrowderadiv3 whycrowderacol-md">
                <div class="col-md-2">
                    <img src="//s3.amazonaws.com/crowdera/assets/flexible-deadline-icon.png" alt="Flexible-Fundin">
                </div>
                <div class="col-md-10">
                    <h4 class="pull-left subheadingtext">Flexible Deadline</h4>
                    <div class="clear"></div>
                    <p class="pull-left crowderacontent1">You can extend your deadline if needed</p>
                </div>
            </div>
            <g:if test="${currentEnv == 'development' || currentEnv == 'test' || currentEnv == 'staging' || currentEnv == 'production'}">
                <div class="col-md-12 whycrowderadiv whycrowderadiv4 whycrowderacol-md">
                    <div class="col-md-2">
                        <img src="//s3.amazonaws.com/crowdera/assets/multiple-secure-payment-gateways-icon.png" alt="Free-Crowdfunding">
                    </div>
                    <div class="col-md-10">
                        <h4 class="pull-left subheadingtext">Multiple Secure Payment Gateways</h4>
                        <div class="clear"></div>
                        <p class="pull-left crowderacontent1">You select between PayPal, PayU or FirstGiving</p>
                    </div>
                </div>
            </g:if>
        </div>
        <div class="col-md-6 whycrowderacol-md-12">
            <div class="col-md-12 whycrowderadiv whycrowderacol-md">
                <div class="col-md-2">
                    <img src="//s3.amazonaws.com/crowdera/assets/teams-to-multiply-results-icon.png" alt="Instant-Fundraising">
                </div>
                <div class="col-md-10">
                    <h4 class="pull-left subheadingtext">Teams to Multiply Results</h4>
                    <div class="clear"></div>   
                    <p class="pull-left crowderacontent1">Your team can share their individuals stories, define their own goals, and even their own perks (coming soon)</p>
                </div>
            </div>
            <div class="col-md-12 whycrowderadiv whycrowderacol-md whycrowderadiv6 whycdradivpadding">
                <div class="col-md-2">
                    <img src="//s3.amazonaws.com/crowdera/assets/mobile-friendly-funding-icon.png" alt="Mobile-Friendly-Funding-Page">
                </div>
                <div class="col-md-10">
                    <h4 class="pull-left subheadingtext">Mobile Friendly Funding Page</h4>
                    <div class="clear"></div>
                    <p class="pull-left crowderacontent1">Your fundraising page can be accessed from any phone.</p>
                </div>
            </div>
            <g:if test="${currentEnv == 'development' || currentEnv == 'test' || currentEnv == 'staging' || currentEnv == 'production'}">
                <div class="col-md-12 whycrowderadiv whycrowderadiv7 whycrowderacol-md">
                    <div class="col-md-2">
                        <img src="//s3.amazonaws.com/crowdera/assets/instant-fundraising-icon.png" alt="Multiple-Secure-Payment-Gateways">
                    </div>
                    <div class="col-md-10">
                        <h4 class="pull-left subheadingtext">Instant Fundraising</h4>
                        <div class="clear"></div>
                        <p class="pull-left crowderacontent1">Donor funds are instantly transferred to your account</p>
                    </div>
                </div>
            </g:if>
            <div class="col-md-12 whycrowderadiv whycrowderadiv8 whycrowderacol-md whycdradivpadding8">
                <div class="col-md-2">
                    <img src="//s3.amazonaws.com/crowdera/assets/free-crowdfunding-icon.png" alt="Teams-to-Multiply-Results">
                </div>
                <div class="col-md-10">
                    <h4 class="pull-left subheadingtext">Free Crowdfunding Ebook</h4>
                    <div class="clear"></div>
                    <p class="pull-left crowderacontent1">Step by step guidelines for crowdfunding.</p>
                </div>
            </div>
        </div>
    </div>
</div>
</g:if>
<g:else>
   <div class="container homepageusmoreReasons">
      <h1>Many More Reasons To Fund On Crowdera</h1>
      <div class="col-lg-5 colmanyMargin">
            <ul>
                <li class="inlineimageReason">
                      <img class="img-responsive reasoonIcon" src="//s3.amazonaws.com/crowdera/project-images/76c6480b-b4c6-45c9-925f-74adf6ce1176.png" title="free-logo">
                      <b class="inlineTitle">Crowdera Is Free</b>
                      <p class="reasonInlinetext">We don't dip into your donor dollars.No fee at all</p>
                   </li>
                   <li class="inlineimageReason">
                      <img class="img-responsive reasoonIcon" src="//s3.amazonaws.com/crowdera/project-images/8036a0c2-fc42-48b1-93fd-a725715cbc14.png" title="flexible-funding">
                      <b class="inlineTitle inOne">Flexible Funding</b>
                      <p class="reasonInlinetext">You keep the money you raised, even if it is just 1% of the goal</p>
                   </li>
                   <li class="inlineimageReason">
                      <img class="img-responsive reasoonIcon" src="//s3.amazonaws.com/crowdera/project-images/a0e2ddb6-0871-46da-81dc-b1e96baa47a5.png" title="flexible-deadline">
                      <b class="inlineTitle inTwo">Flexible Deadline</b>
                      <p class="reasonInlinetext">You can extend your deadline if needed</p>
                   </li>
                   <li class="inlineimageReason">
                      <img class="img-responsive reasoonIcon" src="//s3.amazonaws.com/crowdera/project-images/078c84db-e4ac-4052-ab90-3ce78a113c05.png" title="secure---Icon.png">
                      <b class="inlineTitle inTwo">Multiple Secure Payment Gateways</b>
                      <p class="reasonInlinetext">You select between PayPal, PayU or FirstGiving</p>
                   </li>
                </ul>
      </div>
      <div class="col-lg-5 colmanyMarginone">
            <ul>
                  <li class="inlineimageReason">
                      <img class="img-responsive reasoonIcon" src="//s3.amazonaws.com/crowdera/project-images/2c88fa94-fb3a-4760-ada8-f97e64d66586.png" title="Teams---Icon.png">
                      <b class="inlineTitle inThree">Teams To Multiply Results</b>
                      <p class="reasonInlinetext">Your team can share their individual stories, define their own goals, and even their own perks(coming soon)</p>
                   </li>
                   <li class="inlineimageReason">
                      <img class="img-responsive reasoonIcon" src="//s3.amazonaws.com/crowdera/project-images/35902ae7-8279-4a88-b1dc-e02f2461e37f.png" title="Mobile-Friendly---Icon.png">
                      <b class="inlineTitle inFour">Mobile Freindly Funding Page</b>
                      <p class="reasonInlinetext">Your fundraising can be accessed from any phone</p>
                   </li>
                   <li class="inlineimageReason">
                      <img class="img-responsive reasoonIcon" src="//s3.amazonaws.com/crowdera/project-images/f5f55c8b-f069-4445-bff0-c4e57b94a316.png" title="Instant-Fund---Icon.png">
                      <b class="inlineTitle inFive">Instant Fundraising</b>
                      <p class="reasonInlinetext">Donor funds are instantly transferred to your account</p>
                   </li>
                   <li class="inlineimageReason">
                      <img class="img-responsive reasoonIcon" src="//s3.amazonaws.com/crowdera/project-images/834fac72-03b7-4725-9011-51ea62db4b32.png" title="Crowdera-E-book---Icon.png">
                      <b class="inlineTitle inSix">Free Crowdfunding Ebook</b>
                      <p class="reasonInlinetext">Step by step guidelines for crowdfunding </p>
                   </li>
             </ul>
      </div>
      <div>
      <div class="row">
          <div class="reasonButton reasonButtonone pull-left col-lg-3">
	         <a href="/campaign/create" class="pull-left morereasonsButton btn-block hm-howtoCreatecampaign-btn">Start Now</a>
	      </div>
	      <div class="reasonButton reasonButtontwo pull-right col-lg-3">
	         <a href="/us/campaigns" class="pull-right morereasonsButton btn-block hm-howtoCreatecampaign-btn">Explore</a>
	      </div>
      </div>
   </div>
   </div>
</g:else>