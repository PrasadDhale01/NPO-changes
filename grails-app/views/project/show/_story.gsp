<%
    def username = user?.username
    def base_url = grailsApplication.config.crowdera.BASE_URL
    def projectimages = projectService.getProjectImageLinks(project)
    def teamimages = projectService.getTeamImageLinks(currentTeam,project)
    def shareUrl = base_url+'c/'+shortUrl
%>
<div class="col-md-12">
    <div class="row">
        <div class="blacknwhite campaignupdatedimages" onmouseover="showNavigation()" onmouseleave="hideNavigation()">
            <g:if test="${userService.isCampaignBeneficiaryOrAdmin(project,currentFundraiser)|| isAdmin}">
                <g:render template="/project/manageproject/projectimagescarousel" model="['images': projectimages]"/>
            </g:if>
            <g:else>
                <g:render template="/project/manageproject/projectimagescarousel" model="['images': teamimages]"/>
            </g:else>
        </div>
    </div>
</div>
    
    <%-- Social features --%>
    <g:hiddenField name="shareUrl" id="shareUrl" value="${shareUrl}"/>
    <g:hiddenField name="embedTileUrl" id="embedTileUrl" value="${embedTileUrl}"/>

    <div class="col-sm-12 social sharing-icon-alignment 
    <g:if test="${firstFiveHashtag!=null}">
    	<g:if test="${!firstFiveHashtag.isEmpty() || !firstThreeHashtag.isEmpty()}"></g:if>
    	<g:else>sharing-icons-padding-left</g:else>
     </g:if>	 
    	<g:if test="${isvalidateShow}">validate-share-border</g:if>
    	<g:else>show-share-border-line</g:else> hidden-xs">
   
        <a class="show-socials-iconsA"></a>
        <div>
            <g:if test="${isPreview || isvalidateShow}">
                <div class="show-social-icons">
                <a class="share-mail pull-left show-icons show-email-hover show-pointer-not">
                    <img src="//s3.amazonaws.com/crowdera/assets/82677812-3c6f-404d-80c2-7e3f77c60cf9.png" class="show-email-social" alt="Mail Share">
                </a>
                <a class="pull-left show-icons show-pointer-not">
                     <img src="//s3.amazonaws.com/crowdera/assets/823f1cf6-49fe-4ec2-a0dd-2d2a437ad081.png" class="show-twitter-social" alt="Twitter Share">
                </a>
                <a class="pull-left show-icons show-pointer-not">
                    <img src="//s3.amazonaws.com/crowdera/assets/9520477b-5b92-475a-ba79-9b35c1a16d3c.png" class="show-like-social" alt="campaign-supporter">
                </a>
                <a class="social share-linkedin pull-left show-icons show-pointer-not" target="_blank">
                    <img src="//s3.amazonaws.com/crowdera/assets/8a7fbe36-68f8-401e-8644-5780d656d298.png" class="show-linkedin-social" alt="LinkedIn Share">
                </a>
                <a class="social google-plus-share pull-left show-icons show-pointer-not">
                    <img src="//s3.amazonaws.com/crowdera/assets/ccda789b-4001-4c95-a65f-38c0b9a7a474.png" class="show-google-social" alt="Google+ Share">
                </a>
            
               <span class="pull-left show-icons show-pointer-not"><img src="//s3.amazonaws.com/crowdera/assets/264961c1-5e35-4357-a68b-8494e63ac04e.png" alt="embedicon" class="show-embedIcon-social"></span>
               <span class="shortUrlglyphicon glyphicon glyphicon-link glyphicon-show-design glyphicon-show-link-color show-pointer-not"></span>
            </div>
            <div>
            	<span class="col-lg-12 col-sm-12 col-md-12 text-center <g:if test="${isvalidateShow}">hashtag-font-size</g:if>">
                    <g:each in="${firstFiveHashtag}" var="hashtag">
                        ${hashtag}
                   </g:each>
                </span>
            
                <span class="showing-hashtags showing-hashtags-tabs hidden">
                   <g:each in="${firstThreeHashtag}" var="hashtag">
                        ${hashtag}
                   </g:each>
                </span>
            </div>
        </g:if>
        <g:else>
          <div class="show-social-icons">
	             <a class="share-mail pull-left show-icons" href="#" data-toggle="modal" data-target="#sendmailmodal" target="_blank" id="share-mail">
	                <img src="//s3.amazonaws.com/crowdera/assets/82677812-3c6f-404d-80c2-7e3f77c60cf9.png" alt="Mail Share" class="show-email-social">
	            </a>
	            <a class="twitter-share pull-left show-icons" id="twitterShare" data-url="${shareUrl}" target="_blank">
	                <img src="//s3.amazonaws.com/crowdera/assets/823f1cf6-49fe-4ec2-a0dd-2d2a437ad081.png" class="show-twitter-social" alt="Twitter Share">
	            </a>
	            <g:link absolute="true" uri="/campaign/supporter/${project.id}/${username}" class="pull-left show-icons">
	                <img src="//s3.amazonaws.com/crowdera/assets/9520477b-5b92-475a-ba79-9b35c1a16d3c.png" class="show-like-social" alt="campaign-supporter" id="add-campaign-supporter">
	            </g:link>
	            <a class="social share-linkedin pull-left show-icons" href="https://www.linkedin.com/cws/share?url=${shareUrl}" target="_blank" id="share-linkedin" onclick="javascript:window.open(this.href,'', 'menubar=no,toolbar=no,resizable=yes,scrollbars=yes,height=600,width=600');return false;">
	                <img src="//s3.amazonaws.com/crowdera/assets/8a7fbe36-68f8-401e-8644-5780d656d298.png" class="show-linkedin-social" alt="LinkedIn Share">
	            </a>
	            <a class="social google-plus-share pull-left show-icons" id="googlePlusShare" href="https://plus.google.com/share?url=${shareUrl}" onclick="javascript:window.open(this.href,'', 'menubar=no,toolbar=no,resizable=yes,scrollbars=yes,height=600,width=600');return false;">
	                <img src="//s3.amazonaws.com/crowdera/assets/ccda789b-4001-4c95-a65f-38c0b9a7a474.png" class="show-google-social" alt="Google+ Share">
	            </a>
	            <a href="#" data-toggle="modal" data-target="#embedTilemodal" target="_blank" class="pull-left show-icons"><img src="//s3.amazonaws.com/crowdera/assets/264961c1-5e35-4357-a68b-8494e63ac04e.png" class="show-embedIcon-social" alt="embedicon"></a>
	            <g:hiddenField name="urlShortenValue" value="${shareUrl}" id="urlShortenValue"/>
	            <div class="popoverClass">
	                <span data-title="Copy this short url and share &nbsp;&nbsp;&nbsp;" class="shortUrlglyphicon glyphicon glyphicon-link glyphicon-show-design-ract glyphicon-show-link-color"></span>
	                <div id="popoverConent" class="hidden">
	                    <button type="button" class="close">&times;</button>
	                    <p>${shareUrl}</p>
	                </div>
	            </div>
            </div>
            <div>
				<span class="col-lg-12 col-sm-12 col-md-12 text-center">
				    <g:each in="${firstFiveHashtag}" var="hashtag">
	                    <g:link class="searchablehastag" controller="project" action="search" params="['q': hashtag]">${hashtag}</g:link>
	                </g:each>
<%--	                <g:each in="${firstThreeHashtag}" var="hashtag">--%>
<%--	                    <g:link class="searchablehastag" controller="project" action="search" params="['q': hashtag]">${hashtag}</g:link>--%>
<%--	                </g:each>--%>
	            </span>
				<span class="showing-hashtags showing-hashtags-tabs hashtags-padding-left">
	                
				</span>
			</div>
        </g:else>
      </div>
    </div>
    <div class="clear"></div>
    <div class="col-xs-12 show-pageDiscription show-textstorylinespec col-plr-0">
        <div class="show-description">
		    <g:if test="${isCrFrCampBenOrAdmin}">
			
	            <span class="campaignDescription justify">${raw(project.description)}</span>
			
		    </g:if>
		    <g:else>
	                <span class="campaignDescription justify">${raw(currentTeam?.description)}</span>
		    </g:else>
        

        
            <g:if test="${isCrFrCampBenOrAdmin}">
                
               <div class="checkStory read-more">${raw(project?.story)}</div>
                
            </g:if>
            <g:else>
                <div class="checkStory read-more-team">
                    <p class="campaignStory justify">${raw(currentTeam?.story)}</p>
                </div>
                <div class="checkStory read-more">
                    <p class="campaignStory justify">${raw(project?.story)}</p>
                </div>
            </g:else>
        </div>
        
        <div class="show-tags-topbottom">
         <g:if test="${firstFiveHashtag!=null}">	
	         <g:if test="${!remainingHashTags.isEmpty()}">
	            <h4 class="moretags-desktop col-lg-3 col-sm-3 col-md-3 tags-managepagewidth"><b>More tags:</b></h4>
	            <p class="moretags-desktop col-lg-9 col-sm-9 col-md-9">
	                <g:each in="${remainingHashTags}" var="hashtag">
	                    <g:link class="searchablehastag" controller="project" action="search" params="['q': hashtag]">${hashtag}</g:link>
	                </g:each>
	            </p>
	        </g:if>
	     </g:if>   
	      <g:if test="${remainingHashTagsTab!=null}">  
	        <g:if test="${!remainingHashTagsTab.isEmpty()}">
	            <h4 class="moretags-tabs col-lg-3 col-sm-3 col-md-3 tags-managepagewidth"><b>More tags:</b></h4>
	            <p class="moretags-tabs col-lg-9 col-sm-9 col-md-9">
	                 <g:each in="${remainingHashTagsTab}" var="hashtag">
	                    <g:link class="searchablehastag" controller="project" action="search" params="['q': hashtag]">${hashtag}</g:link>
	                </g:each>
	            </p>
	        </g:if>
	      </g:if>  
        </div>
        
        <div class="clear"></div>
        <div class="show-matrix-bg">
            <g:if test="${spendCauseList && spendAmountPerList}">
                <b class="show-spend-matrix-title">Campaign money will be used as</b>
                <div id="chart-container">
                <g:hiddenField name="payuStatus" value="${project.payuStatus}"   id="payuStatus"/>
                    <g:hiddenField name="spendCauseList" value="${spendCauseList}" id="spendCauseList"/>
                    <g:hiddenField name="spendAmountPerList" value="${spendAmountPerList}" id="spendAmountPerList"/>
                    <div id="graph"></div>
                </div>
                <script src="/js/raphel-pie/raphael-min.js"></script>
                <script src="/js/raphel-pie/g.raphael.js"></script>
                <script src="/js/raphel-pie/g.pie.js"></script>
            </g:if>
            <g:else>
            
            	<b class="show-spend-matrix-title">Campaign money will be used as</b>
                <div id="chart-container">
                <g:hiddenField name="payuStatus" value="${project.payuStatus}"   id="payuStatus"/>
                	<g:hiddenField name="spendCauseList" value="0" id="spendCauseList"/>
                    <g:hiddenField name="spendAmountPerList" value="0" id="spendAmountPerList"/>
                    <div id="graph"></div>
                </div>
                <script src="/js/raphel-pie/raphael-min.js"></script>
                <script src="/js/raphel-pie/g.raphael.js"></script>
                <script src="/js/raphel-pie/g.pie.js"></script>
            	
            </g:else>
        </div>
       
        
        <br/>
        <g:if test="${!isvalidateShow}">
            <div id="scrollToComment" class="show-comments-section">
                <g:if test="${managecomments == "show"}">
                    <g:render template="show/comments" model="['managecomments': managecomments,'campaign_country_code':campaign_country_code]"/>
                </g:if>
                <g:else>
                    <g:render template="/project/manageproject/comments" />
                </g:else>
            </div>
        </g:if>
    </div>
