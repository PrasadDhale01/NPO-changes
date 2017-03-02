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
   <b>We get excited when we see our fundraisers making a great difference in improving their quality of life, restoring hope in mankind,
   <br>realizing dreams and supporting people in need.</b>
   <br><br>
   <div class="imageCollage container whycrowderacontainer">
	      <div class="row rowOne">
	         <div class="col-sm-4 col-lg-4 col-md-4 colrowHeight colOne">
	         	<div class="imageHover">
			         <a href="us/ngo/Girls-Write-Haiti/Laura-104">
			            <img class="img-responsive rowOneImg imgAltr center-block" src="//s3.amazonaws.com/crowdera/project-images/11c11d1e-a071-44c6-9242-f814e3b29a7a.png" alt="Girls-Write-Haiti" data-alt-src="//s3.amazonaws.com/crowdera/project-images/15269fa1-8881-48a9-9006-49e2bb4f0e64.png">
			         </a>
			    </div>
	         	<div class="hoverButton hov-btn center-block">
		           <div class="desktopcampaignDivbutton">
			          <g:link mapping="createCampaign" params="[country_code: country_code]" class="pull-left desktopCampaigntext btn-block hm-howtoCreatecampaign-btn">
		                        START A SIMILAR CAMPAIGN
		              </g:link>
		           </div>
		      	</div>
	         </div>
	         <div class="col-sm-4 col-lg-4 col-md-4 colrowHeight colOne">
		         <div class="imageHover">
			         <a href="us/ngo/Securing-Prajwala--An-Anti-Trafficking-Intervention/Friends-of-680">
			            <img class="img-responsive imageTwo imgAltr center-block" src="//s3.amazonaws.com/crowdera/project-images/58c443e9-9c68-41ac-8178-23b530d02acf.png" alt="Securing-Prajwala--An-Anti-Trafficking-Intervention" data-alt-src="//s3.amazonaws.com/crowdera/project-images/5a8ec5e4-308e-4a5a-bb82-d32e4a58e483.png">
			         </a>
		         </div>
	         </div>
	         <div class="col-sm-4 col-lg-4 col-md-4 colrowHeight colOne">
		          <div class="imageHover">
			         <a href="us/non-profit/KukSoolWon-Kick-a-thon-2016/MACDA-1204">
			            <img class="img-responsive imageThree imgAltr center-block" src="//s3.amazonaws.com/crowdera/project-images/e79f74f1-7feb-4f50-8e1e-3823df63d7ce.png" alt="KukSoolWon-Kick-a-thon-2016" data-alt-src="//s3.amazonaws.com/crowdera/project-images/937ba5f1-2762-4452-ac36-7079c9d4ba80.png">
			         </a>
			      </div>
	         </div>
	      </div>
	      <div class="row rowTwo">
	         <div class="col-sm-4 col-lg-4 col-md-4 colrowHeight">
	         <div class="imageHover4">
		         <a href="us/ngo/Vote-For-Austin-With-The-Election-Navigator/Brandi-Clark-174">
		            <img class="img-responsive imageFour imgAltr colrowHeight  center-block" src="//s3.amazonaws.com/crowdera/project-images/299f9823-192f-4a47-977c-254d3bb17e36.png" alt="Vote-For-Austin-With-The-Election-Navigator" style="height: 222px;" data-alt-src="//s3.amazonaws.com/crowdera/project-images/cd152a10-3483-4b21-ba9d-ed66bbd5ead7.png">
		         </a>
		     </div>
		     <div class="hoverButton4 hov-btn center-block">
		           <div class="desktopcampaignDivbutton campaignDivbutton4">
			          <g:link mapping="createCampaign" params="[country_code: country_code]" class="pull-left desktopCampaigntext btn-block hm-howtoCreatecampaign-btn">
		                        START A SIMILAR CAMPAIGN
		              </g:link>
		           </div>
		      	</div>
	         </div>
	         <div class="col-sm-8 col-lg-8 col-md-8 colrowHeight">
		         <div class="imageHover4">
			         <a href="us/non-profit/the-relay-2016/Two-Cents-of-Hope-440">
			            <img class="img-responsive imageFive imgAltr colrowHeight  center-block" src="//s3.amazonaws.com/crowdera/project-images/aea57a8d-ec8c-457b-834d-10db5608c73f.png" alt="the-relay-2016" data-alt-src="//s3.amazonaws.com/crowdera/project-images/93237b4f-4245-4b86-b138-3de266eee13f.png">
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
			               <img class="img-responsive imageSix imgAltr colrowHeight center-block" src="//s3.amazonaws.com/crowdera/project-images/bd558427-a1ad-4af1-9755-c5a0bb142f52.png" alt="Genesis-3D-Visual-Effects-Missionary" data-alt-src="//s3.amazonaws.com/crowdera/project-images/6fcddce1-8fc2-4419-88be-12886d566781.png">
			            </a>
			        </div>
	            </div>
	          </div>
	          <div class="row innerrowTwo">
	                     <div class="col-sm-6 col-lg-6 col-md-6 colrowHeight">
		                     <div class="imageHover3">
		                        <a href="us/ngo/Seth-Boyden-Outdoor-Learning-Center/Lizete-100">
		                           <img class="img-responsive pull-left imageSeven imgAltr center-block" src="//s3.amazonaws.com/crowdera/project-images/9152bf26-2b68-4adb-9d7d-172d927657eb.png" alt="Seth-Boyden-Outdoor-Learning-Center" data-alt-src="//s3.amazonaws.com/crowdera/project-images/315b5ff6-1f16-4364-92c7-102d7e9d8c62.png">
		                        </a>
		                     </div>
		                     <div class="hoverButton3 hov-btn center-block">
		                        <div class="desktopcampaignDivbutton divBtn3">
			                       <g:link mapping="createCampaign" params="[country_code: country_code]" class="pull-left desktopCampaigntext btn-block hm-howtoCreatecampaign-btn">
		                              START A SIMILAR CAMPAIGN
		                           </g:link>
		                        </div>
		                    </div>
	                     </div>
	                     <div class="col-sm-6 col-lg-6 col-md-6 colrowHeight">
		                     <div class="imageHover3">
		                        <a href="us/ngo/Harmony-Community-Garden/Ashley-43">
		                           <img class="center-block img-responsive pull-right imageEight imgAltr center-block" src="//s3.amazonaws.com/crowdera/project-images/d1ec3dbf-d7d3-4dfd-81c6-2b59bdc7be40.png" alt="Harmony-Community-Garden" data-alt-src="//s3.amazonaws.com/crowdera/project-images/e1dbad90-15e8-44c0-9184-c4794a53c4a7.png">
		                        </a>
		                     </div>
	                     </div>
	               </div>
	         </div>
	         <div class="col-sm-4 col-lg-4 col-md-4 nineDiv">
	            <div class="imageHover2">
	               <a href="us/person/Saving-Our-Soil--Youth-led-Agroecology-Project-In-Guatemala/michael-142">
	                  <img class="img-responsive imageNine imgAltr center-block" src="//s3.amazonaws.com/crowdera/project-images/c1c9d5f3-df4a-4472-8a63-3e6b77dd4176.jpg" alt="Saving-Our-Soil--Youth-led-Agroecology-Project-In-Guatemala" data-alt-src="//s3.amazonaws.com/crowdera/project-images/e9003839-20a3-4401-9733-47d238b52959.jpg">
	               </a>
	            </div>
	         </div>
	         <div class="hoverButton2 hov-btn center-block">
		           <div class="desktopcampaignDivbutton divBtn2">
			          <g:link mapping="createCampaign" params="[country_code: country_code]" class="pull-left desktopCampaigntext btn-block hm-howtoCreatecampaign-btn">
		                        START A SIMILAR CAMPAIGN
		              </g:link>
		           </div>
		     </div>
	      </div>
	      <div class="successfullcampaignLogos">
	         <div class="row">
		         <div class="col-sm-12 logolist-1">
		            <a><img class="img-responsive" src="//s3.amazonaws.com/crowdera/project-images/25d23a53-3ef9-4548-ae80-86f1968dcd21.png" alt="Logo-1.png"></a>
		            <a><img class="img-responsive" src="//s3.amazonaws.com/crowdera/project-images/f6549ca7-3cee-4f6a-b279-04dd83f1f30e.png" alt="Logo-2.png"></a>
		            <a><img class="img-responsive" src="//s3.amazonaws.com/crowdera/project-images/6b8416b5-edc6-4a4d-9029-5d7a016ad331.png" alt="Logo-3.png"></a>
		            <a><img class="img-responsive" src="//s3.amazonaws.com/crowdera/project-images/5795d1a6-4da9-4ecf-b7cb-e76457fa5c50.png" alt="Logo-4.png"></a>
		            <a><img class="img-responsive" src="//s3.amazonaws.com/crowdera/project-images/74fa22f6-1766-494f-a373-a73974467d42.png" alt="Logo-5.png"></a>
		            <a><img class="img-responsive" src="//s3.amazonaws.com/crowdera/project-images/43806d54-47e0-4429-a79e-edd4bb3106d2.png" alt="Logo-6.png"></a>
		            <a><img class="img-responsive" src="//s3.amazonaws.com/crowdera/project-images/49a415c7-3887-424f-afcd-b68f92efa8db.png" alt="Logo-7.png"></a>
		            <a><img class="img-responsive" src="//s3.amazonaws.com/crowdera/project-images/e8d00bae-a06c-4f47-a7b0-3ddf8e23e4b6.png" alt="Logo-8.png"></a>
		            <a><img class="img-responsive" src="//s3.amazonaws.com/crowdera/project-images/41a5b3ef-132c-4ee1-97f8-d9a431d6ae52.png" alt="Logo-9.png"></a>
		            <a><img class="img-responsive" src="//s3.amazonaws.com/crowdera/project-images/99e8b863-0745-4546-bc41-7c8e99d92655.png" alt="Logo-10.png"></a>
		         </div>
	         </div>
	         <div class="row">
		         <div class="col-sm-12 logolist-2">
		            <a><img class="img-responsive tab-logo" src="//s3.amazonaws.com/crowdera/project-images/e52cb27f-bfc8-42f2-8ee5-275dfe887a45.png" alt="Logo-11.png"></a>
		            <a><img class="img-responsive tab-logo" src="//s3.amazonaws.com/crowdera/project-images/48bc0ef2-44ae-47ff-b9b9-a82989c898c3.png" alt="Logo-12.png"></a>
		            <a><img class="img-responsive tab-logo" src="//s3.amazonaws.com/crowdera/project-images/3c1dc276-c6e6-4f02-a294-69f0715c6233.png" alt="Logo-12.png"></a>
		            <a><img class="img-responsive" src="//s3.amazonaws.com/crowdera/project-images/694c2806-4a40-49a4-83fc-9877385d6412.png" alt="Logo-14.png"></a>
		            <a><img class="img-responsive" src="//s3.amazonaws.com/crowdera/project-images/cb9e3cfc-4fd6-45e8-82e1-9c55dd767083.png" alt="Logo-15.png"></a>
		            <a><img class="img-responsive" src="//s3.amazonaws.com/crowdera/project-images/ec58b431-a474-4355-9aa6-88f10199d5b7.png" alt="Logo-16.png"></a>
		            <a><img class="img-responsive" src="//s3.amazonaws.com/crowdera/project-images/431a1032-19fb-4536-b314-c8f4aceb9c82.png" alt="Logo-17.png"></a>
		            <a><img class="img-responsive" src="//s3.amazonaws.com/crowdera/project-images/fa541db9-85ea-41c4-8c5d-79c06dc73e01.png" alt="Logo-18.png"></a>
		            <a><img class="img-responsive" src="//s3.amazonaws.com/crowdera/project-images/5e9ccc02-8c71-4b61-8daa-128e4663f76d.png" alt="Logo-19.png"></a>
		         </div>
	         </div>
	      </div>
	      <br>
	      <b class="successfullcampaignBottomline">and many more partners rely on free crowdera for their fundraising needs</b>
   </div>   
</div>

<%--Code to preload hovering images in order to reduce loading time--%>
<div style="display: none;">
  <img alt="hover1" src="//s3.amazonaws.com/crowdera/project-images/15269fa1-8881-48a9-9006-49e2bb4f0e64.png">
  <img alt="hover2" src="//s3.amazonaws.com/crowdera/project-images/5a8ec5e4-308e-4a5a-bb82-d32e4a58e483.png">
  <img alt="hover3" src="//s3.amazonaws.com/crowdera/project-images/937ba5f1-2762-4452-ac36-7079c9d4ba80.png">
  <img alt="hover4" src="//s3.amazonaws.com/crowdera/project-images/cd152a10-3483-4b21-ba9d-ed66bbd5ead7.png">
  <img alt="hover5" src="//s3.amazonaws.com/crowdera/project-images/93237b4f-4245-4b86-b138-3de266eee13f.png">
  <img alt="hover6" src="//s3.amazonaws.com/crowdera/project-images/6fcddce1-8fc2-4419-88be-12886d566781.png">
  <img alt="hover7" src="//s3.amazonaws.com/crowdera/project-images/532d9a92-127b-4c47-a3f2-6e9e7a6925ce.png">
  <img alt="hover8" src="//s3.amazonaws.com/crowdera/project-images/d1ec3dbf-d7d3-4dfd-81c6-2b59bdc7be40.png">
  <img alt="hover9" src="//s3.amazonaws.com/crowdera/project-images/e9003839-20a3-4401-9733-47d238b52959.jpg">
</div>
