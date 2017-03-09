<g:set var="projectService" bean="projectService"/>
<%
def country_code = projectService.getCountryCodeForCurrentEnv(request)
 %>
<%--<div class="container how-it-work-container">
    <div class="row text-center success-story-title">
        <g:if test="${currentEnv == 'testIndia' || currentEnv == 'stagingIndia' || currentEnv == 'prodIndia'}">
            <span class="text-center">They Raised Successfully on Crowdera <br> for What Matters to them</span>
        </g:if>
        <g:else>
            <span class="text-center">They Raised Successfully on Crowdera <br> for What Matters to them</span>
        </g:else>
    </div> 
</div>
<g:if test="${currentEnv == 'stagingIndia' || currentEnv == 'prodIndia' || currentEnv == 'staging' || currentEnv == 'production'}">
    <div class="container how-it-work-container">
        <div class="row">
            <div class="col-md-12 col-sm-12 col-xs-12">
                <div class="col-lg-3 col-md-6 col-sm-6 col-xs-12 text-center story-bottom-margin">
                    <span><a href="${resource(dir: '/'+"${country_code}"+'/campaigns/The-Relay-2015/Two-Cents-of-Hope-440')}"><img src="//s3.amazonaws.com/crowdera/assets/The-Relay-2015-story-img.jpg" alt="Life Vest"></a></span><br>
                </div>
                <div class="col-lg-3 col-md-6 col-sm-6 col-xs-12 text-center story-bottom-margin">
                    <span class="navbar-brand-footer"><a href="${resource(dir: '/'+"${country_code}"+'/${country_code}/campaigns/Girls-Write-Haiti/Laura-104')}"><img src="//s3.amazonaws.com/crowdera/assets/Girls-write-haiti-story-img.jpg" alt="Two Cents Of hope"></a></span>
                </div>
                <div class="clear-both hidden-md hidden-lg"></div>
                <div class="col-lg-3 col-md-6 col-sm-6 col-xs-12 text-center story-bottom-margin">
                    <span><a href="${resource(dir: '/'+"${country_code}"+'/campaigns/Vote-For-Austin-With-The-Election-Navigator/Brandi-Clark-174')}"><img src="//s3.amazonaws.com/crowdera/assets/Vote-for-austin-story-img.jpg" alt="Prajwala"></a></span>
                </div>
                <div class="col-lg-3 col-md-6 col-sm-6 col-xs-12 text-center story-bottom-margin">
                    <span><a href="${resource(dir: '/'+"${country_code}"+'/campaigns/Dance-For-Kindness-Flashmob-Anthem/Orly-155')}"><img src="//s3.amazonaws.com/crowdera/assets/Dace-for-kindness-story-img.jpg" alt="Eco Netwrork"></a></span>
                </div>
                <div class="clear-both"></div>
            </div>
        </div>
    </div>
</g:if>
--%>

<div class="container homepageusCampaigns whycrowderacontainer">
   <h1>They Raised Successfully on Crowdera Absolutely Free</h1>
	<br>
   <h4>We get excited when we see our fundraisers making a great difference in improving their quality of life, restoring hope in mankind,
   <br>realizing dreams and supporting people in need.</h4>
   <br><br>
   <div class="imageCollage container whycrowderacontainer">
	      <div class="row rowOne">
	         <div class="col-sm-4 col-lg-4 col-md-4 colrowHeight colOne">
	         	<div class="imageHover">
			         <a href="us/ngo/Girls-Write-Haiti/Laura-104">
			            <img class="img-responsive rowOneImg imgAltr center-block" src="//s3.amazonaws.com/crowdera/project-images/eff72769-5296-461e-8679-f701b9018339.png" alt="Girls-Write-Haiti" data-alt-src="//s3.amazonaws.com/crowdera/project-images/eb699c23-055c-4e8f-a428-8aeba5e5f501.png">
			         </a>
			    </div>
	         	<div class="hoverButton hov-btn center-block">
		           <div class="desktopcampaignDivbutton">
			          <g:link mapping="createCampaign" params="[country_code: country_code]" class="pull-left desktopCampaigntext npoCreate-btn btn-block hm-howtoCreatecampaign-btn">
		                        START A SIMILAR CAMPAIGN
		              </g:link>
		           </div>
		      	</div>
	         </div>
	         <div class="col-sm-4 col-lg-4 col-md-4 colrowHeight colOne">
		         <div class="imageHover">
			         <a href="us/ngo/Securing-Prajwala--An-Anti-Trafficking-Intervention/Friends-of-680">
			            <img class="img-responsive imageTwo imgAltr center-block" src="//s3.amazonaws.com/crowdera/project-images/3fe48a3c-0b0a-4ac2-9651-ef74d40a8a15.png" alt="Securing-Prajwala--An-Anti-Trafficking-Intervention" data-alt-src="//s3.amazonaws.com/crowdera/project-images/a655325f-7853-4193-8e8a-0374ff6bf66e.png">
			         </a>
		         </div>
	         </div>
	         <div class="col-sm-4 col-lg-4 col-md-4 colrowHeight colOne">
		          <div class="imageHover">
			         <a href="us/non-profit/KukSoolWon-Kick-a-thon-2016/MACDA-1204">
			            <img class="img-responsive imageThree imgAltr center-block" src="//s3.amazonaws.com/crowdera/project-images/3159777b-a162-4b06-99c3-2f38f44d1b28.png" alt="KukSoolWon-Kick-a-thon-2016" data-alt-src="//s3.amazonaws.com/crowdera/project-images/7819508a-cdf8-47fd-acf2-3b82e745373f.png">
			         </a>
			      </div>
	         </div>
	      </div>
	      <div class="row rowTwo">
	         <div class="col-sm-4 col-lg-4 col-md-4 colrowHeight">
	         <div class="imageHover4">
		         <a href="us/ngo/Vote-For-Austin-With-The-Election-Navigator/Brandi-Clark-174">
		            <img class="img-responsive imageFour imgAltr colrowHeight  center-block" src="//s3.amazonaws.com/crowdera/project-images/d08eead4-35e0-4b0e-bc71-bc9f2709b500.png" alt="Vote-For-Austin-With-The-Election-Navigator" style="height: 222px;" data-alt-src="//s3.amazonaws.com/crowdera/project-images/3f403c07-110b-4591-92fd-04d70960a153.png">
		         </a>
		     </div>
		     <div class="hoverButton4 hov-btn center-block">
		           <div class="desktopcampaignDivbutton campaignDivbutton4">
			          <g:link mapping="createCampaign" params="[country_code: country_code]" class="pull-left desktopCampaigntext npoCreate-btn btn-block hm-howtoCreatecampaign-btn">
		                        START A SIMILAR CAMPAIGN
		              </g:link>
		           </div>
		      	</div>
	         </div>
	         <div class="col-sm-8 col-lg-8 col-md-8 colrowHeight">
		         <div class="imageHover4">
			         <a href="us/non-profit/the-relay-2016/Two-Cents-of-Hope-440">
			            <img class="img-responsive imageFive imgAltr colrowHeight  center-block" src="//s3.amazonaws.com/crowdera/project-images/3d4ac398-5737-47a5-b36f-8f9ba5e7730d.png" alt="the-relay-2016" data-alt-src="//s3.amazonaws.com/crowdera/project-images/fc9f2d0b-8a7b-4b00-abd6-ab15e5e1d9a0.png">
			         </a>
		         </div>
	         </div>
	      </div>
	      <div class="row rowThree">
	         <div class="col-sm-8 col-lg-8 col-md-8 innerCollage">
	         <div class="row">
	            <div class="col-sm-12 col-lg-12 col-md-12 innerrowOne colrowHeight">
		            <div class="imageHover4">
			            <a href="us/non-profits/Genesis-3D-Visual-Effects-Missionary/Kenda-794">
			               <img class="img-responsive imageSix imgAltr colrowHeight center-block" src="//s3.amazonaws.com/crowdera/project-images/43ed4a2a-7fca-412a-a8d2-40d792fe0b1b.png" alt="Genesis-3D-Visual-Effects-Missionary" data-alt-src="//s3.amazonaws.com/crowdera/project-images/6595500f-5bc8-42e2-b39a-916d5ae2eb6b.png">
			            </a>
			        </div>
	            </div>
	          </div>
	          <div class="row innerrowTwo">
	                     <div class="col-sm-6 col-lg-6 col-md-6 colrowHeight">
		                     <div class="imageHover3">
		                        <a href="us/ngo/Seth-Boyden-Outdoor-Learning-Center/Lizete-100">
		                           <img class="img-responsive pull-left imageSeven imgAltr center-block" src="//s3.amazonaws.com/crowdera/project-images/348e4d7f-17e5-4525-a2d0-5f1df88a6e45.png" alt="Seth-Boyden-Outdoor-Learning-Center" data-alt-src="//s3.amazonaws.com/crowdera/project-images/90fe1f6a-39d7-40a1-82c6-2062fef4b242.png">
		                        </a>
		                     </div>
		                     <div class="hoverButton3 hov-btn center-block">
		                        <div class="desktopcampaignDivbutton divBtn3">
			                       <g:link mapping="createCampaign" params="[country_code: country_code]" class="pull-left desktopCampaigntext npoCreate-btn btn-block hm-howtoCreatecampaign-btn">
		                              START A SIMILAR CAMPAIGN
		                           </g:link>
		                        </div>
		                    </div>
	                     </div>
	                     <div class="col-sm-6 col-lg-6 col-md-6 colrowHeight">
		                     <div class="imageHover3">
		                        <a href="us/ngo/Harmony-Community-Garden/Ashley-43">
		                           <img class="center-block img-responsive pull-right imageEight imgAltr center-block" src="//s3.amazonaws.com/crowdera/project-images/34c9bbd3-c8b7-4d2e-b8fd-e02d318f0092.png" alt="Harmony-Community-Garden" data-alt-src="//s3.amazonaws.com/crowdera/project-images/d308cb6b-1ac9-4f52-ac3b-72b6fcee564f.png">
		                        </a>
		                     </div>
	                     </div>
	               </div>
	         </div>
	         <div class="col-sm-4 col-lg-4 col-md-4 nineDiv">
	            <div class="imageHover2">
	               <a href="us/person/Saving-Our-Soil--Youth-led-Agroecology-Project-In-Guatemala/michael-142">
	                  <img class="img-responsive imageNine imgAltr center-block" src="//s3.amazonaws.com/crowdera/project-images/ebef9458-bebb-4a80-a57f-c688d9e28877.png" alt="Saving-Our-Soil--Youth-led-Agroecology-Project-In-Guatemala" data-alt-src="//s3.amazonaws.com/crowdera/project-images/bb81ab66-49af-4c4b-99ba-77a3a9498b4d.png">
	               </a>
	            </div>
	         </div>
	         <div class="hoverButton2 hov-btn center-block">
		           <div class="desktopcampaignDivbutton divBtn2">
			          <g:link mapping="createCampaign" params="[country_code: country_code]" class="pull-left desktopCampaigntext npoCreate-btn btn-block hm-howtoCreatecampaign-btn">
		                        START A SIMILAR CAMPAIGN
		              </g:link>
		           </div>
		     </div>
	      </div>
	      <br>
   </div>   
</div>

<%--Code to preload hovering images in order to reduce loading time--%>
<div style="display: none;">
  <img alt="hover1" src="//s3.amazonaws.com/crowdera/project-images/eb699c23-055c-4e8f-a428-8aeba5e5f501.png">
  <img alt="hover2" src="//s3.amazonaws.com/crowdera/project-images/a655325f-7853-4193-8e8a-0374ff6bf66e.png">
  <img alt="hover3" src="//s3.amazonaws.com/crowdera/project-images/7819508a-cdf8-47fd-acf2-3b82e745373f.png">
  <img alt="hover4" src="//s3.amazonaws.com/crowdera/project-images/3f403c07-110b-4591-92fd-04d70960a153.png">
  <img alt="hover5" src="//s3.amazonaws.com/crowdera/project-images/fc9f2d0b-8a7b-4b00-abd6-ab15e5e1d9a0.png">
  <img alt="hover6" src="//s3.amazonaws.com/crowdera/project-images/6595500f-5bc8-42e2-b39a-916d5ae2eb6b.png">
  <img alt="hover7" src="//s3.amazonaws.com/crowdera/project-images/90fe1f6a-39d7-40a1-82c6-2062fef4b242.png">
  <img alt="hover8" src="//s3.amazonaws.com/crowdera/project-images/d308cb6b-1ac9-4f52-ac3b-72b6fcee564f.png">
  <img alt="hover9" src="//s3.amazonaws.com/crowdera/project-images/bb81ab66-49af-4c4b-99ba-77a3a9498b4d.png">
</div>
