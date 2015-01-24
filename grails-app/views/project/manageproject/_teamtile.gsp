<%@ page import="java.text.SimpleDateFormat"%>
<g:set var="contributionService" bean="contributionService" />
<g:set var="projectService" bean="projectService" />
<g:set var="userService" bean="userService"/>
<%
    def user = team.user
    def username = user.username
    def userImageUrl = user.userImageUrl
    def userName = user.firstName
    def goal = projectService.getDataType(project.amount)
	def contributedAmount = contributionService.getTotalContributionForUser(team.contributions)
    def amount = projectService.getDataType(contributedAmount)
    SimpleDateFormat dateFormat = new SimpleDateFormat("MMM d");
    def uri = request.forwardURI
    def ismanagepage = uri.contains("manageproject")
    def isAdminOrBeneficiary = userService.isCampaignBeneficiaryOrAdmin(project, user)
%>

<div class="fedu thumbnail grow teamtile" style="padding: 0">
	<div style="height: 200px; overflow: hidden;" class="blacknwhite">
	    <g:if test="${!ismanagepage || !isAdminOrBeneficiary}">
			<g:link controller="project" action="show" id="${project.id}" params="['fundRaiser': username]">
			    <g:if test="${userImageUrl != null}">
					<img alt="${userName}" class="project-img" src="${userImageUrl}">
				</g:if>
				<g:else>
				    <div class="imageWithTag">
	                <div class="under">
				        <img src="${resource(dir: 'images', file: 'profile_image.jpg')}" class="project-img" alt="Upload Photo"/>
	                </div>
	                <g:if test="${user == project.user}">
					    <div class="over">
							<img src="/images/OWNER.png" width="100">
						</div>
					</g:if>
					<g:else>
					    <div class="over">
							<img src="/images/TEAM.png" width="100">
						</div>
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
	                <g:if test="${user == project.user}">
					    <div class="over">
							<img src="/images/OWNER.png" width="100">
						</div>
					</g:if>
					<g:else>
					    <div class="over">
							<img src="/images/TEAM.png" width="100">
						</div>
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
		<div class="row">
			<div class="col-md-6 col-xs-6">
                <h6 class="text-center"><span class="lead">$${goal}</span><br/>GOAL</h6>
            </div>
			<div class="col-md-6 col-xs-6">
				<h6 class="text-center">
					<span class="lead">$${amount}</span><br />ACHIEVED
				</h6>
			</div>
		</div>
	</div>
</div>
