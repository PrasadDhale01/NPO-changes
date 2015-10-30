<g:set var="projectService" bean="projectService"/>
<g:set var="userService" bean="userService"/>
<% 
    def beneficiary = project.user
    def webUrl = projectService.getWebUrl(project)
%>
<div class="panel panel-default TW-org-panel-height sh-pan-height">
				<div class="organization-details text-center">
								<div class="col-md-12 show-icons">
												<g:if test="${project.beneficiary.facebookUrl}">
																<a href="${project.beneficiary.facebookUrl}" target="_blank">
																    <img src="//s3.amazonaws.com/crowdera/assets/facebook-icon.png" alt="fb-icons">
																</a>
												</g:if>
												<g:if test="${project.webAddress}">
																<a href="${webUrl}" target="_blank">
																    <img src="//s3.amazonaws.com/crowdera/assets/show-online-original-icon.png" alt="fb-icons">
																</a>
												</g:if>
								</div>
								<br><br>
								<h4><b class="TW-org-title-font-size">${project.organizationName}</b></h4>
								
								<div class="tilesanstitletag">
												<g:if test="${project.draft}">
												    <img src="//s3.amazonaws.com/crowdera/assets/Draft-tag.png" alt="draft">
												</g:if>
												<g:elseif test="${project.rejected}">
												    <img src="//s3.amazonaws.com/crowdera/assets/Rejected-tag.png" alt="rejected">
												</g:elseif>
												<g:elseif test="${!project.validated}">
												    <img src="//s3.amazonaws.com/crowdera/assets/Pending-tag.png" alt="validated">
												</g:elseif>
												<g:elseif test="${ended}">
												    <img src="//s3.amazonaws.com/crowdera/assets/ended-tag.png" alt="ended">
												</g:elseif>
												<g:elseif test="${percentage >= 75}">
												    <img src="//s3.amazonaws.com/crowdera/assets/Funded-Tag.png" alt="funded">
												</g:elseif>
												<g:elseif test="${isCampaignAdmin}">
												    <img src="//s3.amazonaws.com/crowdera/assets/Co-owner-tag.png" alt="CO-OWNER">
												</g:elseif>
												<g:elseif test="${isEnabledTeamExist}">
																<g:if test="${currentFundraiser == beneficiary}">
																    <img src="//s3.amazonaws.com/crowdera/assets/show-campaign-by-orig.png" alt="Owner">
																</g:if>
																<g:else>
																    <img src="//s3.amazonaws.com/crowdera/assets/Team-tag.png" alt="team">
																</g:else>
												</g:elseif>
								</div>
				</div>
</div>
