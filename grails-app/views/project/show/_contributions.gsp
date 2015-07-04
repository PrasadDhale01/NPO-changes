<!-- Contributions -->
<g:set var="userService" bean="userService"/>
<g:set var="facebookService" bean="facebookService"/>
<g:set var="projectService" bean="projectService" />
<g:set var="contributionService" bean="contributionService"/>
<%@ page import="java.text.SimpleDateFormat" %>
<%
    SimpleDateFormat dateFormat = new SimpleDateFormat("d MMM, YYYY");
    SimpleDateFormat timeFormat = new SimpleDateFormat("hh:mm:ss");
    def currentTeamUser
    def user = currentUser
    def fundRaiser
    if (user != null) {
        fundRaiser = user.username
        if(user != project.user && user == team.user) {
            currentTeamUser = team.user
        }
    }
    def projectId = project.id
%>
<g:if test="${contributions.empty}">
    <div class="alert alert-info">No contributions yet. Yours can be the first one.</div>
</g:if>
<g:if test="${user && !isCrUserCampBenOrAdmin && CurrentUserTeam}">
    <g:if test="${team.user == user}">
        <a href="#" class="btn btn-primary btn-sm pull-right offlinecontributionbtn" data-toggle="modal" data-target="#offlineContributionModal" model="['project': project]">
            Manage Offline Contribution
        </a>
        <!-- Button trigger modal -->
        <g:if test="${!contributions.empty}">
            <button class="btn btn-primary btn-sm btn-circle pull-right reportCls" data-toggle="modal" data-target="#reportModal">
                Report
            </button>
        </g:if>
        
        <div class="modal fade" id="reportModal" tabindex="-1" role="dialog" aria-labelledby="reportModalLabel" aria-hidden="true">
            <g:form controller="project" action="generateCSV" role="form">
                <div class="modal-dialog">
                    <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal" aria-hidden="true"> &times; </button>
                            <h4 class="modal-title" id="reportModalLabel">
                            <h4><b>CONTRIBUTION REPORT</b></h4>
                        </h4>
                    </div>
                    <g:hiddenField name="projectId" value="${project.id}"/>
                    <g:hiddenField name="teamId" value="${team.id}"/>
                    <div class="modal-body">
                        <g:if test="${!contributions.empty}">
                            <dl class="dl">
                                <div class="table table-responsive">
                                    <table class="table table-bordered">
                                        <thead>
                                            <tr class="alert alert-title ">
                                                <th class="col-sm-2 text-center">CAMPAIGN</th>
                                                <th class="col-sm-2 text-center">FUNDRAISER</th>
                                                <g:if test="${project.rewards.size()>1}">
                                                    <th class="col-sm-1 text-center">DATE AND TIME</th>
                                                </g:if>
                                                <g:else>
                                                    <th class="col-sm-2 text-center">DATE AND TIME</th>
                                                </g:else>
                                                <g:if test="${project.rewards.size()>1}">
                                                    <th class="col-sm-1 text-center">CONTRIBUTOR NAME</th>
                                                </g:if>
                                                <g:else>
                                                    <th class="col-sm-2 text-center">CONTRIBUTOR NAME</th>
                                                </g:else>
                                                <th class="col-sm-2 text-center">CONTRIBUTOR EMAIL</th>

                                                <g:if test="${project.rewards.size()>1}">
                                                    <th class="col-sm-2 text-center">PERK</th>
                                                    <th class="col-sm-2 text-center">SHIPPING DETAILS</th>
                                                </g:if>

                                                <th class="text-center">AMOUNT</th>
                                                <th class="text-center">MODE</th>                                
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <g:each in="${contributions}" var="contribution">
                                            <%
                                                def date = contribution.date.format('YYYY:MM:dd HH:mm:ss')
                                                def friendlyName = userService.getFriendlyName(contribution.user)
                                                def isFacebookUser = userService.isFacebookUser(contribution.user)
                                                def userFacebookUrl = facebookService.getUserFacebookUrl(contribution.user)
                                                def amount = projectService.getDataType(contribution.amount)
                                                def pay_mode=contribution.isContributionOffline
                                                def contributorName= contribution.contributorName
                                                def contributorEmail
                                                contributorEmail = contribution.contributorEmail
                                                if (!contributorEmail) {
                                                    contributorEmail = " "
                                                }
                                                def shippingDetails = contributionService.getShippingDetails(contribution)
                                            %>
                                            <tr>
                                                <td class="col-sm-2 text-center wordBreak">${project.title}</td>
                                                <td class="col-sm-2 text-center wordBreak">
                                                    ${contributionService.getFundRaiserName(contribution, project)}
                                                </td>
                                                <g:if test="${project.rewards.size()>1}">
                                                    <td class="col-sm-1 text-center ">${date}</td>
                                                </g:if>
                                                <g:else>
                                                    <td class="col-sm-2 text-center ">${date}</td>
                                                </g:else>
                                                <g:if test="${project.rewards.size()>1}">
                                                    <td class="col-sm-1 wordBreak">${contributorName}</td>
                                                </g:if>
                                                <g:else>
                                                    <td class="col-sm-2 wordBreak">${contributorName}</td>
                                                </g:else>
                                                <td class="col-sm-2 wordBreak">${contributorEmail}</td>

                                                <g:if test="${project.rewards.size()>1}">
                                                    <td class="col-sm-2">${contribution.reward.title}</td>
                                                    <td class="col-sm-2 wordBreak">${raw(shippingDetails)}</td> 
                                                </g:if>
                                        
                                                <td class="text-center">$${amount}</td>
                                        
                                                <g:if test="${pay_mode}">
                                                    <td class="text-center">Offline</td>
                                                </g:if>
                                                <g:else>
                                                    <td class="text-center">Online</td>
                                                </g:else>
                                            </tr>
                                        </g:each>
                                    </tbody>
                                </table>
                            </div>
                        </dl>
                    </g:if>
                    <g:else>
                        <div class="alert alert-info">No contributions yet. Yours can be the first one.</div>
                    </g:else>
                    </div>
                        <div class="modal-footer">
                            <button type="submit" class="btn btn-primary">Generate CSV</button>
                        </div>
                    </div> <!-- /.modal-dialog -->
                </div><!-- /.modal-content -->
            </g:form>
        </div><!-- /.modal -->
    </g:if>
    
    <div class="clear"></div>
    
    <!-- Modal -->
    <div class="modal fade offlineContributionModal" id="offlineContributionModal" tabindex="-1" role="dialog" aria-labelledby="offlineContributionModal" aria-hidden="true">
        <g:form controller="fund" action="saveOfflineContribution" id="${project.id}" params="['fr':fundRaiser]" role="form">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-body">
                        <div class="col-sm-12 margin">
                            <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
                            <h4 class="heading">ENTER OFFLINE CONTRIBUTION</h4>
                        </div>
                        <div class="col-sm-12 margin">
                            <p class="justify text-paragraph">We understand that not all your friends will contribute online. 
                            Give your offline contributors due credit by listing their name and contribution amount below. 
                            The offline contributions will be listed under the contribution tab on your campaign. Each cent counts to make a campaign successful! 
                            </p>
                        </div>
                        <div class="col-sm-8">
                             <div class="form-group">
                                 <label class="text" for="title">Display Name</label>
                                 <input type="text" class="form-control contributioninput" name="contributorName1"/>
                             </div>
                        </div>
                        <div class="col-sm-4">
                            <div class="form-group">
                                <label for="title" class="text">Amount</label>
                                <input type="text" class="form-control contributioninput" name="amount1" id="offlineAmount1"/>
                            </div>
                            <div id="errormsg1"></div>
                        </div>
                        <div class="clear"></div>
                    </div>
                    <div class="clear"></div>
                    <div class="modal-footer">
                        <button data-dismiss="modal" class="btn btn-primary">Close</button>
                        <button class="btn btn-primary" type="submit" id="saveButton">Save</button>
                    </div>
                </div>
            </div>
        </g:form>
    </div>
</g:if>
<g:if test="${!contributions.empty}">
    <div class="row contributions-panel">
       <div class="col-sm-12">
        <g:each in="${contributions}" var="contribution">
            <%
                def date = dateFormat.format(contribution.date)
                def friendlyName = userService.getFriendlyName(contribution.user)
                def isFacebookUser = userService.isFacebookUser(contribution.user)
                def userFacebookUrl = facebookService.getUserFacebookUrl(contribution.user)
                def amount = projectService.getDataType(contribution.amount)
				def numberOfDays = contributionService.getNumberOfDaysForContribution(contribution)
				
				def imageUrl
				if (contribution.user.userImageUrl) {
					imageUrl = contribution.user.userImageUrl
					alphabet = 'userimagecolor'
				} else if (contribution.contributorName){
				    def obj = userService.getCurrentUserImage(contribution.contributorName)
					alphabet = obj.alphabet
					imageUrl = obj.userImage
				}
            %>
            <g:if test="${!contribution.isContributionOffline}">
                <div class="col-sm-4 top-pan">
                    <div <g:if test='${contribution.isAnonymous}'>class ="pan alphabet-A"</g:if><g:else>class ="pan ${alphabet}"</g:else>>
	                    <div class ="col-sm-4 col-xs-4 img-panel">
	                        <g:if test="${contribution.isAnonymous}">
	                            <img class="user-img-header" src="//s3.amazonaws.com/crowdera/assets/alphabet-A.png">
	                        </g:if>
	                        <g:else>
	                            <img class="user-img-header" src="${imageUrl}">
	                        </g:else>
	                    </div>
	                        
		               <div class="col-sm-8 col-xs-8 pn-word">
		                   <g:if test="${contribution.isAnonymous}">
		                       <g:if test="${isCrUserCampBenOrAdmin && CurrentUserTeam && currentFundraiser == team}">
			                       <h4>${contribution.contributorName}</h4> 
			                       <span class="sso">$<b>${amount}</b></span><span class="font-usd">&nbsp;&nbsp;USD</span>
			                       <dd class="font-days">${numberOfDays}&nbsp;&nbsp;Days Ago</dd>
			                   </g:if>
			                   <g:else>
				                   <h4 class="anonymous-top">Anonymous Good Soul</h4>
				                   <span class="font-anonymous">${numberOfDays}&nbsp;&nbsp;Days Ago</span>
			                   </g:else>
			               </g:if>
		                   <g:else>
			                   <g:if test="${contribution.contributorName}">
			                       <h4>${contribution.contributorName}</h4>
			                       <span class="sso">$<b>${amount}</b></span><span class="font-usd">&nbsp;&nbsp;USD</span>
					               <dd class="font-days">${numberOfDays}&nbsp;&nbsp;Days Ago</dd>
			                   </g:if>
			                   <g:else>
			                       <h4>${friendlyName}</h4>
			                       <span class="sso">$<b>${amount}</b></span><span class="font-usd">&nbsp;&nbsp;USD</span>
					               <dd class="font-usd">${numberOfDays}&nbsp;&nbsp;Days Ago</dd>
			                   </g:else>
		                   </g:else>
		               </div>
                    </div>
                </div>
            </g:if>
            <g:else>
                <div class="col-sm-4 top-pan">
	                <div class ="pan ${alphabet}">
		                <div class ="col-sm-4 col-xs-4 img-panel">
		                    <img src="${imageUrl}">
		                </div>
                        <div class="col-sm-8 col-xs-8 pn-word">
                            <h4>${contribution.contributorName}</h4> 
                            <span class="sso">$<b>${amount}</b></span><span class="font-usd">&nbsp;&nbsp;USD</span>
				            <dd class="font-days">${numberOfDays}&nbsp;&nbsp;Days Ago</dd>
			            </div>
	                    <div class="clear"></div>
	                    <div class="col-sm-12"> 
	                        <div class="col-sm-6">
	                            <g:if test="${contribution.isContributionOffline && team.user == user && !isCrUserCampBenOrAdmin}">
	                                <dd class="so-off-con">Offline Contribution</dd>
	                            </g:if>
	                        </div>
	                        
	                        <div class="col-sm-6 cols">
	                            <g:if test="${contribution.fundRaiser.equals(fundRaiser) && team.user == user && !isCrUserCampBenOrAdmin}">
                                    <div class="edits">
                                        <button class="projectedit close" id="editproject"  data-toggle="modal" data-target="#contributionedit${contribution.id}" model="['project': project,'contribution': contribution]">
                                            <i class="glyphicon glyphicon-edit" ></i>
                                        </button>
                                        <g:form controller="project" action="contributiondelete" method="post" id="${contribution.id}" params="['projectId':projectId, 'fr': fundRaiser]">
                                            <button class="projectedit close" onclick="return confirm(&#39;Are you sure you want to discard this contribution?&#39;);">
                                                <i class="glyphicon glyphicon-trash"></i>
                                            </button>
                                        </g:form>
                                    </div>
	                            </g:if>
	                        </div>
	                    </div>
	                </div>
                    <div class="clear"></div>
                    
                    <!-- EditContributionModal -->
                    <div class="modal fade offlineContributionModal contributionedit" id="contributionedit${contribution.id}" tabindex="-1" role="dialog" aria-labelledby="contributionedit${contribution.id}" aria-hidden="true">
                        <g:form action="contributionedit" controller="project" id="${contribution.id}"  params="['projectId':projectId, 'fr': fundRaiser]" role="form">
                            <div class="modal-dialog">
                                <div class="modal-content">
                                    <div class="modal-body">
                                        <div class="col-sm-12 margin">
                                            <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
                                            <h4 class="heading crowderasupport"><img src="//s3.amazonaws.com/crowdera/assets/icon-edit.png" alt="Edit offline contribution"/>&nbsp;&nbsp;EDIT OFFLINE CONTRIBUTION</h4>
                                        </div>
                                        <div class="col-sm-8">
                                            <div class="form-group">
                                                <label class="text" for="title">Display Name</label>
                                                <input type="text" class="form-control contributioninput" name="contributorName" value="${contribution.contributorName}"/>
                                            </div>
                                        </div>
                                        <div class="col-sm-4">
                                            <div class="form-group">
                                                <label for="title" class="text">Amount</label>
                                                <input type="text" class="form-control contributioninput offlineAmount" name="amount" value="${contribution.amount.round()}" id="offlineAmount"/>
                                            </div>
                                            <div class="contributionerrormsg"></div>
                                        </div>
                                    </div>
                                    <div class="clear"></div>
                                    <div class="modal-footer">
                                        <button data-dismiss="modal" class="btn btn-primary">Close</button>
                                        <button class="btn btn-primary" type="submit" id="saveButton">Save</button>
                                    </div>
                                </div>
                            </div>
                        </g:form>
                    </div>
                </div>
            </g:else>
        </g:each>
       </div>
    </div>
</g:if>
