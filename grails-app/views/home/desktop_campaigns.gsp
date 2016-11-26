<!-- Changes for new home page -->
<g:set var="projectService" bean="projectService"/>
<%
def country_code = projectService.getCountryCodeForCurrentEnv(request)
%>
<g:if test="${country_code == 'in'}">
<g:if test="${request.method=="POST" }">
<g:set var="projectService" bean="projectService"/>
<div class='container col-x-plf-0'>
    <div class='col-md-10 col-md-offset-1 col-xs-12 col-xs-offset-0'>
    
        <div class='row'>
            <div class='col-md-12 hm-mobile-title'>
                <h1 class='text-center headingtext'>Latest Campaigns Raising Free on Crowdera</h1><br>
            </div>
        </div>
        <div class='item active home-campaign-tile-container home-tile-mobile hidden-xs'>
            <div class='row'>
                <ul class='thumbnails list-unstyled home-campaign-tile'>
                    <% 
                        def index1 = 1
                        def currentEnv = projectService.getCurrentEnvironment()
                        def projects = projectService.getHomePageCampaignListByEnv(currentEnv)
                     %>
                    <g:each in='${projects}' var='project'>
                        <li class='<g:if test='${index1++ > 2}'>hidden-md col-lg-4 hidden-sm col-sm-6 col-xs-12</g:if><g:else>col-md-6 col-sm-6 col-lg-4 col-xs-12</g:else>'>
                            <g:render template='/layouts/tile' model='[project:project]'></g:render>
                        </li>
                    </g:each>
                </ul>
            </div>
        </div>
        <div class='text-center explorebtn hidden-xs'>
            <a href="/campaigns" class="btn btn-default hm-explorecampaign">Explore Campaigns</a>
        </div>
    </div>
</div>
</g:if>
</g:if>
<g:else>
   <div class="container homepageusCampaigns">
   <div class="imageCollage">
   <h1>They Raised Successfully on Crowdera Absolutely Free</h1>
   <br>
   <b>We get excited when we see our fundraisers making a great difference in improving their quality of life, restoring hope in mankind,
   <br>realizing dreams and supporting people in need.</b>
   <br><br>
      <div class="row rowOne">
         <div class="col-lg-3" style="height: 305px;">
         	<div id="imageHover">
		         <a href="us/ngo/Girls-Write-Haiti/Laura-104">
		            <img class="img-responsive imageOne" src="//s3.amazonaws.com/crowdera/project-images/0ce056d1-0881-4494-b3ff-72b7c72214a5.jpg" title="Sucessfull-Campaign-Image--1.png">
		         </a>
		    </div>
         	<div id="hoverButton">
         	 <div class="desktopcampaignDivbutton col-lg-3">
<%--	         		<a href="/campaign/create" class="pull-left desktopCampaigntext btn-block hm-howtoCreatecampaign-btn">START A SIMILAR CAMPAIGN</a>--%>
	      		<g:link mapping="createCampaign" params="[country_code: country_code]" class="pull-left desktopCampaigntext btn-block hm-howtoCreatecampaign-btn">
                        START A SIMILAR CAMPAIGN
              	</g:link>
             </div>
	      	</div>
	      	
	      	
         </div>
         <div class="col-lg-3">
         <a href="us/ngo/Securing-Prajwala--An-Anti-Trafficking-Intervention/Friends-of-680">
            <img class="img-responsive imageTwo" src="//s3.amazonaws.com/crowdera/project-images/3dadf037-c245-4ca6-b411-bc980624b4ed.jpg" title="Sucessfull-Campaign-Image--2.png">
         </a>
         </div>
         <div class="col-lg-3">
         <a href="us/non-profit/KukSoolWon-Kick-a-thon-2016/MACDA-1204">
            <img class="img-responsive imageThree" src="//s3.amazonaws.com/crowdera/project-images/afdd5672-2790-4d3b-8523-4beab50b7c8f.jpg" title="Sucessfull-Campaign-Image--3.png">
         </a>
         </div>
      </div>
      <div class="row rowTwo">
         <div class="col-lg-3">
         <a href="us/ngo/Vote-For-Austin-With-The-Election-Navigator/Brandi-Clark-174">
            <img class="img-responsive imageFour" src="//s3.amazonaws.com/crowdera/project-images/dca74e85-6b35-4a30-adec-214c11c91267.jpg" title="Sucessfull-Campaign-Image--4(1).png" style="height: 222px;">
         </a>
         </div>
         <div class="col-lg-6">
         <a href="us/non-profit/the-relay-2016/Two-Cents-of-Hope-440">
            <img class="img-responsive imageFive" src="//s3.amazonaws.com/crowdera/project-images/d09ba7ed-95d8-4bab-add2-8267ab6ddf5f.jpg" title="Sucessfull-Campaign-Image--5.png">
         </a>
         </div>
      </div>
      <div class="row rowThree">
         <div class="col-lg-6 innerCollage">
            <div class="row innerrowOne">
            <a href="us/non-profits/Genesis-3D-Visual-Effects-Missionary/Kenda-794">
               <img class="img-responsive imageSix" src="//s3.amazonaws.com/crowdera/project-images/c3b60781-d425-48f9-a10a-b3f12f1dbd1e.jpg" title="Sucessfull-Campaign-Image--6.png">
            </a>
            </div>
            <div class="row innerrowTwo">
                     <a href="us/ngo/Seth-Boyden-Outdoor-Learning-Center/Lizete-100"><img class="img-responsive pull-left imageSeven" src="//s3.amazonaws.com/crowdera/project-images/a982f0c0-c907-4e76-ad3d-c0933a0f3c0e.jpg" title="Sucessfull-Campaign-Image--8.png"></a>
                     <a href="us/ngo/Harmony-Community-Garden/Ashley-43"><img class="img-responsive pull-right imageEight" src="//s3.amazonaws.com/crowdera/project-images/026767a4-ddec-4099-b2c1-7f103fc65866.jpg" title="Sucessfull-Campaign-Image--9.png"></a>
               </div>
         </div>
         <div class="col-lg-3">
         <a href="us/person/Saving-Our-Soil--Youth-led-Agroecology-Project-In-Guatemala/michael-142">
            <img class="img-responsive imageNine" src="//s3.amazonaws.com/crowdera/project-images/0b8dae23-4933-4741-ac6e-479dc14cab5a.jpg" title="Sucessfull-Campaign-Image--7.png">
         </a>
         </div>
      </div>
      <div class="successfullcampaignLogos">
         <img class="img-responsive" src="//s3.amazonaws.com/crowdera/project-images/006253fd-9061-48d4-9a79-1bc2d12cde33.png" title="Campaign-Logo(1).png">
      </div>
      <br>
      <b class="successfullcampaignBottomline">and many more partners rely on free crowdera for their fundraising needs</b>
   </div>   
   </div>
</g:else>
 <script>
<%-- $("document").ready(function(){--%>
<%--	    $("#imageHover").mouseover(function()--%>
<%--		{--%>
<%--			$(this).addClass("#hoverButton");--%>
<%--		}).mouseleave(function()--%>
<%--		{--%>
<%--			$(this).removeClass("#hoverButton");--%>
<%--		});--%>
<%--	});--%>
 $(document).ready(function(){
	 $('#hoverButton div').hide();
	      	$('#imageHover img').hover(function() {
	            $('#hoverButton div').show();
	        });
	        $('#imageHover img').mouseleave(function() {
	            $('#hoverButton div').hide();
	        });
 });
</script>