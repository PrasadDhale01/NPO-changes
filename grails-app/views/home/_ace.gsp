<!-- Changes for new home page -->
<g:set var="projectService" bean="projectService"/>
<%
def country_code = projectService.getCountryCodeForCurrentEnv(request)
%>
<div class="howitworkUpdated">  
	<div class="hm-how-it-work" >
     <div class="row">
	<div class="col-md-12 how-it-work--title">
            <h1 class="text-center headingtext">It's Simple, Secure and Easy to Fundraise on Crowdera</h1>
            <h4>Online fundraising has never been so easy</h4>
        </div>
    </div>
    <div class="row threeEqualdiv">
       <div class="col-sm-4 divOne">
       <img class="img-responsive" src="//s3.amazonaws.com/crowdera/project-images/d0d720e0-4735-4a1d-917b-0a91cda2d4fe.png" title="Tell-Your-Story---Icon.png">
       <br>
       <b>Tell Your Story</b><br>
              <p>Simple, intuitive, templatized storybuilder<br> helps to invoke right emotions in<br> your donors.</p>
       </div>
       <div class="col-sm-4 divTwo">
       <img class="img-responsive" src="//s3.amazonaws.com/crowdera/project-images/f6284a93-b94c-453e-a6c7-9bf8b99aeae8.png" title="Engage-your-crowd---Icon.png">
       <br>
       <b>Engage Your Crowd</b><br>
              <p>Effective tools to help you engage &<br> manage your crowd to amplify your<br> fundraising results.</p>
       </div>
       <div class="col-sm-4 divThree">
       <img class="img-responsive" src="//s3.amazonaws.com/crowdera/project-images/e9ac293b-7915-4002-914d-a7065104583d.png" title="Get-Funded!---Icon.png">
       <br>
       <b>Get Funded</b><br>
              <p>We don't dip into donor dollars,<br>so keep all you raise with direct disbursement<br> into your payment account.</p>
       </div>
       <div class="createnewButton">
       		<g:link mapping="createCampaign" params="[country_code: country_code]" class="mycreateButton btn-block hm-howtoCreatecampaign-btn">
                  	CREATE A CAMPAIGN
              </g:link>
<%--	       <a href="/campaign/create" class="mycreateButton btn-block hm-howtoCreatecampaign-btn">CREATE A CAMPAIGN</a>--%>
	  </div>
    </div>
<%--	    <img class="img-responsive home-img-large-size hidden-xs  visible-lg" src="//s3.amazonaws.com/crowdera/assets/how-it-work-step-web-a-3.jpg" alt="How-it-work">--%>
	    
	    <div class="hm-howitworks-mobile-image">
	       <img class="img-responsive home-img-large-size visible-xs" src="//s3.amazonaws.com/crowdera/assets/how-it-work1.jpg" alt="How-it-work">
	    </div>
	    
<%--	    <img class="img-responsive home-img-large-size hidden-xs hidden-lg visible-sm visible-md" src="//s3.amazonaws.com/crowdera/assets/howitwork-step-a-tab-2.jpg" alt="How-it-work">--%>




	</div>
</div>	

<div class="container creationPlans">
   <h1>Transparent, Trustworthy & Free Fundraising</h1>
   <h3>While it's free to raise money on crowdera, your secure payment partner deducts their fee from each donation.<br>
    Plus, you can choose paid value added services.</h3>
    
    <div class="row" style="margin-left: 15px;">
       <div class="col-lg-6 waterPlan">
          <img class="img-responsive" src="//s3.amazonaws.com/crowdera/project-images/14927070-56b7-49d5-8b39-5defeca874fe.png" alt="water-plan-background">
             <div class="waterPlantext">
                <img class="img-responsive" src="//s3.amazonaws.com/crowdera/project-images/42ca7fcc-70fd-46d8-94fb-09a397d7cbcb.png" alt="water-plan-logo">
                <b class="waterPlantitle">Water</b>
                <h1 class="planHeader">Truly Free  <b class="verticalL">|</b>  No Free Ever</h1>
                <div class="waterInnersubtitle">
                   <b>Water is for humans as fundraising is for<br> the causes. Everything you need for<br> your successful fundraising is free with crowdera.</b>
                </div>
                <hr class="planLine">
                <ul>
                   <li class="inlineImage">
                      <img class="img-responsive" src="//s3.amazonaws.com/crowdera/project-images/6db09532-69e0-4405-a6ff-dd9d74fce867.png" title="Right---Icon.png">
                      <p class="inlineTextwithimage">No Commissions, No Monthly Subscriptions & No Donor Tip</p>
                   </li>
                   <li class="inlineImage">
                      <img class="img-responsive" src="//s3.amazonaws.com/crowdera/project-images/6db09532-69e0-4405-a6ff-dd9d74fce867.png" title="Right---Icon.png">
                      <p class="inlineTextwithimage">Immediate Access To Funds Raised(US, Canada & UK)</p>
                   </li>
                   <li class="inlineImage">
                      <img class="img-responsive" src="//s3.amazonaws.com/crowdera/project-images/6db09532-69e0-4405-a6ff-dd9d74fce867.png" title="Right---Icon.png">
                      <p class="inlineTextwithimage">Most Comphrehensive Social Media Integration</p>
                   </li>
                   <li class="inlineImage">
                      <img class="img-responsive" src="//s3.amazonaws.com/crowdera/project-images/6db09532-69e0-4405-a6ff-dd9d74fce867.png" title="Right---Icon.png">
                      <p class="inlineTextwithimage">Lowest Card Transaction Fee of  <b class="boldSpace">2.85% + $0.30</b> per transaction</p>
                   </li>
                   <li class="inlineImage">
                      <img class="img-responsive" src="//s3.amazonaws.com/crowdera/project-images/6db09532-69e0-4405-a6ff-dd9d74fce867.png" title="Right---Icon.png">
                      <p class="inlineTextwithimage">Flexible Funding, No Penalty For Missing Goal</p>
                   </li>
                   <li class="inlineImage">
                      <img class="img-responsive" src="//s3.amazonaws.com/crowdera/project-images/6db09532-69e0-4405-a6ff-dd9d74fce867.png" title="Right---Icon.png">
                      <p class="inlineTextwithimage">No Deadlines, Keep Raising</p>
                   </li>
                   <li class="inlineImage">
                      <img class="img-responsive" src="//s3.amazonaws.com/crowdera/project-images/6db09532-69e0-4405-a6ff-dd9d74fce867.png" title="Right---Icon.png">
                      <p class="inlineTextwithimage">Simple, Intuitive & Guided Campaign Creation</p>
                   </li>
                   <li class="inlineImage">
                      <img class="img-responsive" src="//s3.amazonaws.com/crowdera/project-images/6db09532-69e0-4405-a6ff-dd9d74fce867.png" title="Right---Icon.png">
                      <p class="inlineTextwithimage">Mobile Optimized Campaign Pages</p>
                   </li>
                   <li class="inlineImage">
                      <img class="img-responsive" src="//s3.amazonaws.com/crowdera/project-images/6db09532-69e0-4405-a6ff-dd9d74fce867.png" title="Right---Icon.png">
                      <p class="inlineTextwithimage">Your Own Personal URL & Short LInk For Social Sharing</p>
                   </li>
                   <li class="inlineImage">
                      <img class="img-responsive" src="//s3.amazonaws.com/crowdera/project-images/6db09532-69e0-4405-a6ff-dd9d74fce867.png" title="Right---Icon.png">
                      <p class="inlineTextwithimage">Help Desk, Learning Center & Much More</p>
                   </li>
                </ul>
                <div class="planButton">
                <g:link mapping="createCampaign" params="[country_code: country_code]" class="newCustomButtonplan btn-block hm-howtoCreatecampaign-btn">
                  	CREATE A CAMPAIGN
              </g:link>
<%--	               <a href="/campaign/create" class="newCustomButtonplan btn-block hm-howtoCreatecampaign-btn">CREATE A CAMPAIGN</a>--%>
	            </div>
	            <div class="zeroPercent">
	               <p>0% Fees Guaranteed</p>
	            </div>
             </div>
          </div>
       <div class="col-lg-6 ownPlan">
          <img class="img-responsive" src="//s3.amazonaws.com/crowdera/project-images/7514d45b-aa17-4b8a-98d1-c2db7b674e15.png" alt="myown-plan-background">
             <div class="ownPlantext">
                <img class="img-responsive" src="//s3.amazonaws.com/crowdera/project-images/0a14a929-3ba9-4fdd-b6d3-f956d74e2c29.png" alt="own-plan-logo">
                <b class="ownPlantitle">Make Your Own Drink</b>
                <h1 class="planHeader">Commision Free  <b class="verticalL">|</b> Starting $5/month</h1>
                <div class="ownplanInnersubtitle">
                   <b>Add a bit of cofee or a lot of nutrition to the water for<br> making your fundraising more fun and<br> effective with bunch of premium options and tools.</b>
                </div>
                <hr class="planLine">
                <ul>
                <li class="inlineImage">
                      <img class="img-responsive" src="//s3.amazonaws.com/crowdera/project-images/6db09532-69e0-4405-a6ff-dd9d74fce867.png" title="Right---Icon.png">
                      <p class="inlineTextwithimage">Always Free Fundraising(No Commission Ever)</p>
                   </li>
                   <li class="inlineImage">
                      <img class="img-responsive" src="//s3.amazonaws.com/crowdera/project-images/6db09532-69e0-4405-a6ff-dd9d74fce867.png" title="Right---Icon.png">
                      <p class="inlineTextwithimage">Unlimited Campaigns & Unlimited Fundraising Teams</p>
                   </li>
                   <li class="inlineImage">
                      <img class="img-responsive" src="//s3.amazonaws.com/crowdera/project-images/6db09532-69e0-4405-a6ff-dd9d74fce867.png" title="Right---Icon.png">
                      <p class="inlineTextwithimage">Transaction Fee Discounted Upto <b class="boldSpace">2.35% + $0.30</b> per transaction</p>
                   </li>
                   <li class="inlineImage">
                      <img class="img-responsive" src="//s3.amazonaws.com/crowdera/project-images/6db09532-69e0-4405-a6ff-dd9d74fce867.png" title="Right---Icon.png">
                      <p class="inlineTextwithimage">White Labeled Fundraising With Unlimited Viral Campaigns </p>
                   </li>
                   <li class="inlineImage">
                      <img class="img-responsive" src="//s3.amazonaws.com/crowdera/project-images/6db09532-69e0-4405-a6ff-dd9d74fce867.png" title="Right---Icon.png">
                      <p class="inlineTextwithimage">Custom Branding, Reports, Dasboards & Integration</p>
                   </li>
                   <li class="inlineImage">
                      <img class="img-responsive" src="//s3.amazonaws.com/crowdera/project-images/6db09532-69e0-4405-a6ff-dd9d74fce867.png" title="Right---Icon.png">
                      <p class="inlineTextwithimage">Donor Management & Compliance</p>
                   </li>
                   <li class="inlineImage">
                      <img class="img-responsive" src="//s3.amazonaws.com/crowdera/project-images/6db09532-69e0-4405-a6ff-dd9d74fce867.png" title="Right---Icon.png">
                      <p class="inlineTextwithimage">Manage & Distribute Distribution Receipts</p>
                   </li>
                   <li class="inlineImage">
                      <img class="img-responsive" src="//s3.amazonaws.com/crowdera/project-images/6db09532-69e0-4405-a6ff-dd9d74fce867.png" title="Right---Icon.png">
                      <p class="inlineTextwithimage">Donor Matching From <b class="boldSpace">2500+ US Corporations</b></p>
                   </li>
                   <li class="inlineImage">
                      <img class="img-responsive" src="//s3.amazonaws.com/crowdera/project-images/6db09532-69e0-4405-a6ff-dd9d74fce867.png" title="Right---Icon.png">
                      <p class="inlineTextwithimage">Google Adverts Grant Application Assistance</p>
                   </li>
                   <li class="inlineImage">
                      <img class="img-responsive" src="//s3.amazonaws.com/crowdera/project-images/6db09532-69e0-4405-a6ff-dd9d74fce867.png" title="Right---Icon.png">
                      <p class="inlineTextwithimage">Access To Many More Features & Services</p>
                   </li>
                </ul>
                <div class="planButton">
                  <g:link mapping="createCampaign" params="[country_code: country_code]" class="newCustomButtonplan newCustomButtonownplan btn-block hm-howtoCreatecampaign-btn">
                  	CHOOSE PLAN
                	</g:link>
<%--	               <a href="/campaign/create" class="newCustomButtonplan btn-block hm-howtoCreatecampaign-btn">CREATE A CAMPAIGN</a>--%>
	            </div>
	            <div class="zeroPercent">
	               <p>0% Fees Guaranteed</p>
	            </div>
             </div>
       </div>
    </div>
</div>