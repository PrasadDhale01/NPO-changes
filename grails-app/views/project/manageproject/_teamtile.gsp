<%@ page import="java.text.SimpleDateFormat"%>
<g:set var="contributionService" bean="contributionService" />
<g:set var="projectService" bean="projectService" />
<g:set var="userService" bean="userService"/>
<%
    def user = team.user
    def username = user.username
    def userImageUrl = user.userImageUrl
    def userName = user.firstName
    def goal = projectService.getDataType(team.amount)
	def contributedAmount = contributionService.getTotalContributionForUser(team.contributions)
    def amount = projectService.getDataType(contributedAmount)
    SimpleDateFormat dateFormat = new SimpleDateFormat("MMM d");
    def uri = request.forwardURI
    def ismanagepage = uri.contains("manageproject")
    def isAdminOrBeneficiary = userService.isCampaignBeneficiaryOrAdmin(project, user)
%>

<div class="fedu thumbnail grow teamtile teamtile-padding">
	<div class="blacknwhite teamtile-style">
	    <g:if test="${!ismanagepage || !isAdminOrBeneficiary}">
			<g:link controller="project" action="show" id="${project.id}" params="['fr': username]">
			    <g:if test="${userImageUrl != null}">
					<img alt="${userName}" class="project-img" src="${userImageUrl}">
				</g:if>
				<g:else>
				    <div class="imageWithTag">
	                <div class="under">
				        <img src="${resource(dir: 'images', file: 'profile_image.jpg')}" class="project-img" alt="Upload Photo"/>
	                </div>
	                <g:if test="${!team.enable}">
					    <div class="over teamtile-banner">
							<img src="/images/disabledTeam.png">
						</div>
					</g:if>
					<g:else>
		                <g:if test="${user == project.user}">
						    <div class="over teamtile-banner">
								<img src="/images/OWNER.png">
							</div>
						</g:if>
						<g:else>
						    <div class="over teamtile-banner">
								<img src="/images/teamTop.png">
							</div>
						</g:else>
					</g:else>
	            </div>
				</g:else>
			</g:link>
		</g:if>
		<g:else>
		    <g:link controller="project" action="manageproject" id="${project.id}">
			    <g:if test="${userImageUrl != null}">
					<img alt="${userName}" class="project-img" src="${userImageUrl}">
				</g:if>
				<g:else>
				    <div class="imageWithTag">
	                <div class="under">
				        <img src="${resource(dir: 'images', file: 'profile_image.jpg')}" class="project-img" alt="Upload Photo"/>
	                </div>
	                <g:if test="${!team.enable}">
					    <div class="over teamtile-banner">
							<img src="/images/disabledTeam.png">
						</div>
					</g:if>
					<g:else>
		                <g:if test="${user == project.user}">
						    <div class="over teamtile-banner">
								<img src="/images/OWNER.png">
							</div>
						</g:if>
						<g:else>
						    <div class="over teamtile-banner">
								<img src="/images/teamTop.png">
							</div>
						</g:else>
					</g:else>
	            </div>
				</g:else>
			</g:link>
		</g:else>
	</div>

	<div class="modal-footer tile-footer">
		<div class="text-left">
			<span>${userName}</span>
		</div>
	</div>

	<div class="modal-footer tile-footer">
		<div class="row tilepadding">
			<div class="col-md-6 col-xs-6">
                <h6 class="text-center"><span class="lead goal-size">$${goal}</span><br/>GOAL</h6>
            </div>
			<div class="col-md-6 col-xs-6">
				<h6 class="text-center">
					<span class="lead achived-size">$${amount}</span><br />ACHIEVED
				</h6>
			</div>
		</div>
	</div>
</div>
