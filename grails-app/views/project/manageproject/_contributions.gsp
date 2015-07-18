<!-- Contributions -->
<g:set var="userService" bean="userService"/>
<g:set var="contributionService" bean="contributionService"/>
<g:set var="facebookService" bean="facebookService"/>
<g:set var="projectService" bean="projectService"/>
<%@ page import="java.text.SimpleDateFormat" %>
<%
    SimpleDateFormat dateFormat = new SimpleDateFormat("d MMM, YYYY");
    SimpleDateFormat timeFormat = new SimpleDateFormat("hh:mm:ss");
    def manageCampaign = "manageCampaign"
    def fundRaiser = user.username
    def projectId = project.id
%>
<g:if test="${project.validated}">
<div class="col-md-12 col-md-12 col-sm-12 col-xs-12">
    <g:if test="${totalContributions.empty}">
        <div class="col-md-12 col-md-12 col-sm-12 col-xs-12">
            <div class="alert alert-info">No contributions yet.</div>
        </div>
    </g:if>
    <g:if test="${project.validated}">
        <div class="col-md-12 col-md-12 col-sm-12 col-xs-12">
        <a href="#" class="btn btn-primary btn-sm pull-right managecontribution" data-toggle="modal" data-target="#offlineContributionModal" model="['project': project]">
            Manage Offline Contribution
        </a>
        <g:if test="${!totalContributions.empty}">
            <a href="#"class="btn btn-primary btn-sm btn-circle pull-right mngReportCls" data-toggle="modal" data-target="#reportModal">
                Report
            </a>
        </g:if>
        </div>
    </g:if>
    <div class="clear"></div>
    <!-- Modal -->
    <div class="modal fade offlineContributionModal" id="offlineContributionModal" tabindex="-1" role="dialog" aria-labelledby="offlineContributionModal" aria-hidden="true">
        <g:form action="saveOfflineContribution" controller="fund" id="${project.id}"  params="['fr':fundRaiser]" role="form">
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
	                         The offline contributions will be listed under the contribution tab on your campaign.
	                          Each cent counts to make a campaign successful! 
	                        </p>
                        </div>
                        <g:hiddenField name="manageCampaign" value="${manageCampaign}"></g:hiddenField>
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
    <g:if test="${!contributions.empty}">
        <h2 class="crowderasupport text-center"><img src="//s3.amazonaws.com/crowdera/assets/icon-contribution.png" alt="Campaign Contributions"/>&nbsp;&nbsp;Campaign Contributions</h2>
        <div class="commentsoncampaign mng-contribution-center-alignment">
            <g:each in="${contributions}" var="contribution">
                <%
                    def date = dateFormat.format(contribution.date)
                    def friendlyName = userService.getFriendlyName(contribution.user)
                    def isFacebookUser = userService.isFacebookUser(contribution.user)
                    def userFacebookUrl = facebookService.getUserFacebookUrl(contribution.user)
                    def reward = contribution.reward

                    def numberOfDays = contributionService.getNumberOfDaysForContribution(contribution)
                    def imageUrl
                    if (contribution.user.userImageUrl) {
                        imageUrl = contribution.user.userImageUrl
                        alphabet = 'userimagecolor'
                    } else if (contribution.contributorName){
                        obj = userService.getCurrentUserImage(contribution.contributorName)
                        alphabet = obj.alphabet
                        imageUrl = obj.userImage
                    }
                %>
                <g:if test="${!contribution.isContributionOffline}">
                    <div class="col-xs-12 col-sm-6 col-md-4 col-lg-3 top-pan">
                        <div <g:if test='${contribution.isAnonymous}'>class ="pans alphabet-A"</g:if><g:else>class ="pans ${alphabet}"</g:else>>
                            <div class ="col-sm-3 col-xs-3 img-contribution">
                                <img class="user-img-header" src="${imageUrl}" alt="alphabet">
                            </div>
         
                            <div class="col-sm-9 col-xs-9 pn-word">
                                <g:if test="${isFacebookUser}">
                                    <h4><a href="${userFacebookUrl}">${friendlyName}</a></h4>
                                    <span class="sso">$<b>${contribution.amount}</b></span><span class="font-usd">&nbsp;&nbsp;USD</span>
                                    <dd class="font-days">${numberOfDays}&nbsp;&nbsp;<g:if test="${numberOfDays >1}">Days</g:if><g:else>Day</g:else> Ago</dd>
                                </g:if>
                                <g:else>
                                    <g:if test="${contribution.contributorName}">
                                        <h4>${contribution.contributorName}</h4>
                                        <span class="sso">$<b>${contribution.amount.round()}</b></span><span class="font-usd">&nbsp;&nbsp;USD</span>
                                        <dd class="font-days">${numberOfDays}&nbsp;&nbsp;<g:if test="${numberOfDays >1}">Days</g:if><g:else>Day</g:else> Ago</dd>
                                    </g:if>
                                    <g:else>
                                        <h4>${friendlyName}</h4>
                                        <dd class="font-days">${numberOfDays}&nbsp;&nbsp;<g:if test="${numberOfDays >1}">Days</g:if><g:else>Day</g:else> Ago</dd>
                                    </g:else>
                                </g:else>
                            </div>
                        </div>
                    </div>
                </g:if>
                <g:else>
                    <div class="col-xs-12 col-sm-6 col-md-4 col-lg-3 top-pan offline-contribution-pans">
                        <div class ="pans ${alphabet}">
                            <div class ="col-sm-3 col-xs-3 img-contribution">
                                <img class="user-img-header" src="${imageUrl}" alt="alphabet">
                            </div>

                            <div class="col-sm-9 col-xs-9 pn-word">
                                <h4>${contribution.contributorName}</h4> 
                                <span class="sso">$<b>${contribution.amount.round()}</b></span><span class="font-usd">&nbsp;&nbsp;USD</span>
                                <dd class="font-days">${numberOfDays}&nbsp;&nbsp;<g:if test="${numberOfDays >1}">Days</g:if><g:else>Day</g:else> Ago</dd>
                            <div class="clear"></div>
                            <g:if test="${contribution.fundRaiser.equals(fundRaiser)}">
                                <div class="col-sm-8 col-xs-8">
                                    <div class="offline-contribution">Offline Contribution</div>
                                </div>
                                <div class="col-sm-4 col-xs-4 edit-delete-fund">
                                    <div class="offline-edit-delete-btn">
                                        <button class="projectedit close" id="editproject"  data-toggle="modal" data-target="#contributionedit${contribution.id}" model="['project': project,'contribution': contribution]">
                                            <i class="glyphicon glyphicon-edit" ></i>
                                        </button>

                                        <g:form controller="project" action="contributiondelete" method="post" id="${contribution.id}" params="['projectId':projectId, 'fr': fundRaiser, 'offset': offset]">
                                            <g:hiddenField name="manageCampaign" value="${manageCampaign}"></g:hiddenField>
                                            <button class="projectedit close" onclick="return confirm(&#39;Are you sure you want to discard this contribution?&#39;);">
                                                <i class="glyphicon glyphicon-trash" ></i>
                                            </button>
                                        </g:form>
                                    </div>
                                </div>
                            </g:if>
                        </div>
                    </div>
                    <div class="clear"></div>
                        
                        <!-- EditContributionModal -->
                        <div class="modal fade offlineContributionModal contributionedit" id="contributionedit${contribution.id}" tabindex="-1" role="dialog" aria-labelledby="contributionedit${contribution.id}" aria-hidden="true">
                            <g:form action="contributionedit" controller="project" id="${contribution.id}"  params="['projectId':projectId, 'fr': fundRaiser, 'offset': offset]" role="form">
                                <div class="modal-dialog">
                                    <div class="modal-content">
                                        <div class="modal-body">
                                            <div class="col-sm-12 margin">
                                                <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
                                                <h4 class="heading crowderasupport"><img src="//s3.amazonaws.com/crowdera/assets/icon-edit.png" alt="Edit offline contribution"/>&nbsp;&nbsp;EDIT OFFLINE CONTRIBUTION</h4>
                                            </div>
                                            <g:hiddenField name="manageCampaign" value="${manageCampaign}"></g:hiddenField>
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
       		    
       			<!-- Modal -->
				<div class="modal fade" id="rewarddetails${contribution.id}" tabindex="-1" role="dialog" aria-labelledby="rewarddetails" aria-hidden="true">
			        <div class="modal-dialog">
			            <div class="modal-content">
			                <div class="modal-header">
			                    <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
			                    <h4 class="modal-title text-center"><b>Shipping Details</b></h4>
			                </div>
			                <div class="modal-body">
			                    <g:if test="${contribution.contributorEmail == 'anonymous@example.com'}">
			                        <div class="form-group">
			                            <label>By Anonymous Good Soul </label>
			                        </div>
			                    </g:if>
			                    <g:else>
			                        <div class="form-group">
			                            <label for="name"><b>Name: &nbsp;</b> ${contribution.contributorName}</label>
			                        </div>
			                        <div class="form-group">
			                            <label for="email"><b>Email: &nbsp;</b> ${contribution.contributorEmail}</label>
			                        </div>
			                    </g:else>
			                    <g:if test="${contribution.email  != null}">
			                    	<g:if test="${!contribution.email.equalsIgnoreCase('null')}">
								        <div class="form-group">
								        	<label for="name"><b>Shipping Email: &nbsp;</b> ${contribution.email}</label>
								        </div>
							        </g:if>
								</g:if>
								<g:if test="${contribution.physicalAddress != null}">
									<g:if test="${!contribution.physicalAddress.equalsIgnoreCase('null')}">
								        <div class="form-group">
								            <label for="name"><b>Physical Address: &nbsp;</b> ${contribution.physicalAddress}</label>
								        </div>
							        </g:if>
								</g:if>
								<g:if test="${contribution.twitterHandle  != null}">
									<g:if test="${!contribution.twitterHandle.equalsIgnoreCase('null')}">
								        <div class="form-group">
								        	<label for="name"><b>Twitter Handle: &nbsp;</b> ${contribution.twitterHandle}</label>
								        </div>
							        </g:if>
								</g:if>
								<g:if test="${contribution.custom  != null}">
									<g:if test="${!contribution.custom.equalsIgnoreCase('null')}">
								        <div class="form-group">
								        	<label for="name"><b>Custom Details: &nbsp;</b> ${contribution.custom}</label>
								        </div>
							        </g:if>
								</g:if>
			                </div>
			                <div class="modal-footer">
                                <button data-dismiss="modal" class="btn btn-sm btn-primary">Close</button>
                            </div>
			            </div>
			        </div>
				</div>
				
   			</g:each>
   		</div>
	</g:if>
	<div class="clear"></div>
	<div class="contributionPaginate">
        <g:paginate controller="project" max="12" action="manageproject" total="${totalContributions.size()}" params="['projectTitle':vanityTitle]" fragment="contributions"/>
    </div>
</div>
</g:if>
<g:else>
    <div class="alert alert-info">Campaign is yet to be validated.</div>
</g:else>

<!-- Modal -->
<div class="modal fade" id="reportModal" tabindex="-1" role="dialog" aria-labelledby="reportModalLabel" aria-hidden="true">
   <g:form controller="project" action="generateCSV" role="form">
   <div class="modal-dialog">
      <div class="modal-content">
         <div class="modal-header">
            <button type="button" class="close" 
               data-dismiss="modal" aria-hidden="true">
                  &times;
            </button>
            <h4 class="modal-title" id="reportModalLabel">
               <span class="text-center"><h3><b>CONTRIBUTION REPORT</b></h3></span>
            </h4>
         </div>
         <g:hiddenField name="projectId" value="${project.id}"/>
         <div class="modal-body">
           <g:if test="${!totalContributions.empty}">
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

                                <g:each in="${project.contributions.reverse()}" var="contributions">
                                    <%
                                        def date = contributions.date.format('YYYY:MM:dd HH:mm:ss')
                                        def friendlyName = userService.getFriendlyName(contributions.user)
                                        def isFacebookUser = userService.isFacebookUser(contributions.user)
                                        def userFacebookUrl = facebookService.getUserFacebookUrl(contributions.user)
                                        def amount = projectService.getDataType(contributions.amount)
                                        def pay_mode=contributions.isContributionOffline
                                        def contributorName= contributions.contributorName
                                        def contributorEmail
                                        contributorEmail = contributions.contributorEmail
                                        if (!contributorEmail) {
                                            contributorEmail = " "
                                        }
                                        def shippingDetails = contributionService.getShippingDetails(contributions)
                                    %>
                                    <tr>
                                        <td class="col-sm-2 text-center wordBreak">${project.title}</td>
                                        <td class="col-sm-2 text-center wordBreak">
                                            ${contributionService.getFundRaiserName(contributions, project)}
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
                                            <td class="col-sm-2">${contributions.reward.title}</td>
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
            <button type="submit" class="btn btn-primary" 
               >Generate CSV
            </button>
         </div>
       </div> <!-- /.modal-dialog -->
    </div><!-- /.modal-content -->
    </g:form>
</div><!-- /.modal -->
