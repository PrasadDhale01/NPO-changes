<!-- Contributions -->
<g:set var="userService" bean="userService"/>
<g:set var="facebookService" bean="facebookService"/>
<g:set var="projectService" bean="projectService" />
<%@ page import="java.text.SimpleDateFormat" %>
<%
    SimpleDateFormat dateFormat = new SimpleDateFormat("d MMM, YYYY");
    SimpleDateFormat timeFormat = new SimpleDateFormat("hh:mm:ss");
    def currentTeamUser
    List list = []
    if(project.user == team.user) {
        list = project.contributions.reverse();
    }else {
        list = team.contributions.reverse();
    }
    def user = userService.getCurrentUser()
    def isCampaignOwnerOrAdmin
    def fundRaiser
    def CurrentUserTeam
    if (user != null) {
        isCampaignOwnerOrAdmin = userService.isCampaignBeneficiaryOrAdmin(project, user)
        CurrentUserTeam = userService.getTeamByUser(user, project)
        fundRaiser = user.username
        if(user != project.user && user == team.user) {
            currentTeamUser = team.user
        }
    }
    def projectId = project.id
%>
<g:if test="${list.empty}">
    <div class="alert alert-info">No contributions yet. Yours can be the first one.</div>
</g:if>
<g:if test="${user && !isCampaignOwnerOrAdmin && CurrentUserTeam}">
    <g:if test="${team.user == user}">
        <a href="#" class="btn btn-primary btn-sm pull-right offlinecontributionbtn" data-toggle="modal" data-target="#offlineContributionModal" model="['project': project]">
            Manage Offline Contribution
        </a>
        <!-- Button trigger modal -->
        <g:if test="${!list.empty}">
            <button class="btn btn-primary btn-sm btn-circle pull-right reportCls" data-toggle="modal" data-target="#reportModal">
                Report
            </button>
        </g:if>
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
<g:if test="${!list.empty}">
    <div class="commentsoncampaign">
        <g:each in="${list}" var="contribution">
            <%
                def date = dateFormat.format(contribution.date)
                def friendlyName = userService.getFriendlyName(contribution.user)
                def isFacebookUser = userService.isFacebookUser(contribution.user)
                def userFacebookUrl = facebookService.getUserFacebookUrl(contribution.user)
                def amount = projectService.getDataType(contribution.amount)
            %>
            <g:if test="${!contribution.isContributionOffline}">
                <div class="modal-body tile-footer manage-comments-footer">
                    <div class="rewardsection">
                        <b>$${amount}</b>
                    </div>
                    <g:if test="${isFacebookUser}">
                        <dd>By <a href="${userFacebookUrl}">${friendlyName}</a>, on ${date}</dd>
                    </g:if>
                    <g:if test="${contribution.isAnonymous}">
                        <g:if test="${isCampaignOwnerOrAdmin && CurrentUserTeam && currentFundraiser == team}">
			               <dd>By ${contribution.contributorName}, on ${date}</dd>
			            </g:if>
			            <g:else>
			                <p>By Anonymous Good Soul, on ${date}</p>
			            </g:else>
			        </g:if>
                    <g:else>
                        <dd>By ${contribution.contributorName}, on ${date}</dd>
                    </g:else>
                    <g:if test="${contribution.comments}">
			            <p><b>Comment:</b> ${contribution.comments}</p>
			        </g:if>
                </div>
            </g:if>
            <g:else>
                <div class="modal-body tile-footer manage-comments-footer">
                    <div class="rewardsection">
                        <b>Offline Contribution</b>
                    </div>
                    <div class="rewardsection">
                        <b>$${amount}</b>
                    </div>
                    <p>By ${contribution.contributorName}, on ${date}</p>
                    <div class="clear"></div>
		            <g:if test="${contribution.fundRaiser.equals(fundRaiser) && team.user == user && !isCampaignOwnerOrAdmin}">
		                <div class="editAndDeleteBtn">
		                    <div class="pull-right">
		                        <button class="projectedit close" id="editproject"  data-toggle="modal" data-target="#contributionedit${contribution.id}" model="['project': project,'contribution': contribution]">
                                    <i class="glyphicon glyphicon-edit" ></i>
                                </button>
                            </div>
                            <div class="pull-right">
                                <g:form controller="project" action="contributiondelete" method="post" id="${contribution.id}" params="['projectId':projectId, 'fr': fundRaiser]">
                                    <button class="projectedit close" onclick="return confirm(&#39;Are you sure you want to discard this contribution?&#39;);">
                                        <i class="glyphicon glyphicon-trash"></i>
                                    </button>
                                </g:form>
                            </div>
                        </div>
                    </g:if>
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
</g:if>

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
               <h4><b>CONTRIBUTION REPORT</b></h4>
            </h4>
         </div>
         <g:hiddenField name="projectId" value="${project.id}"/>
         <g:hiddenField name="teamId" value="${team.id}"/>
         <div class="modal-body">
           <g:if test="${!list.empty}">
                <dl class="dl">
                    <div class="table table-responsive">
                        <table class="table table-bordered">
                            <thead>
                                <tr class="alert alert-title ">
                                    <th class="col-sm-2 text-center">CAMPAIGN</th>
                                    <th class="col-sm-2 text-center">FUNDRAISER</th>
                                    <th class="col-sm-1 text-center">CONTRIBUTION_DATE</th>
                                    <th class="col-sm-1 text-center">CONTRIBUTION_TIME</th>
                                    <th class="col-sm-2 text-center">CONTRIBUTOR_NAME</th>
                                    <th class="col-sm-2 text-center">CONTRIBUTOR_EMAIL</th>

                                    <g:if test="${project.rewards.size()>1}">
                                        <th class="col-sm-2 text-center">SHIPPING_DETAILS</th>
                                    </g:if>

                                    <th class="text-center">AMOUNT</th>
                                    <th class="text-center">MODE</th>                                                      
                                </tr>
                            </thead>
                            <tbody>
                                <g:each in="${list}" var="contributions">
                                    <%
                                        def date = dateFormat.format(contributions.date)
                                        def time = timeFormat.format(contributions.date);
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
                                        def shippingDetails

                                        if(contributions.email==null && contributions.physicalAddress==null && contributions.
                                            twitterHandle==null  && contributions.custom==null){
                                            shippingDetails="No Perk Selected "
                                        }else{
                                            if(contributions.email!=null){
                                                shippingDetails="<b>Email:</b> " +contributions.email

                                                if(contributions.physicalAddress!=null){
                                                    shippingDetails+=", <br><b>Physical Address:</b> " + contributions.physicalAddress
                                                }
                                                if(contributions.twitterHandle!=null){
                                                    shippingDetails+=" , <br><b>Twitter Handle:</b> " + contributions.twitterHandle
                                                }
                                                if(contributions.custom!=null) {
                                                    shippingDetails+=" , <br><b>Custom: </b> " +contributions.custom
                                                }
                                            }
                                            if(contributions.physicalAddress!=null){
                                                shippingDetails="<b>Physical Address:</b> " + contributions.physicalAddress
                                                if(contributions.twitterHandle!=null){
                                                    shippingDetails+=" , <br><b>Twitter Handle:</b> " + contributions.twitterHandle
                                                }
                                                if(contributions.custom!=null) {
                                                    shippingDetails+=" , <br><b>Custom: </b> " + contributions.custom
                                                }
                                                if(contributions.email!=null){
                                                    shippingDetails+=" , <br><b>Email:</b> " +contributions.email
                                                }
                                            }
                                            if(contributions.twitterHandle!=null){
                                                shippingDetails ="<b>Twitter Handle:</b> " + contributions.twitterHandle
                                                if(contributions.physicalAddress!=null){
                                                    shippingDetails+=" , <br><b>Physical Address:</b> " + contributions.physicalAddress
                                                }
                                                if(contributions.custom!=null) {
                                                    shippingDetails+=" , <br><b>Custom: </b> " + contributions.custom
                                                }
                                                if(contributions.email!=null){
                                                    shippingDetails+=" ,<br><b>Email:</b> " +contributions.email
                                                }
                                            }
                                            if(contributions.custom!=null){
                                                shippingDetails="<b>Custom: </b>  " + contributions.custom
                                                if(contributions.physicalAddress!=null){
                                                    shippingDetails+=" , <br><b>Physical Address:</b> " + contributions.physicalAddress
                                                }
                                                if(contributions.twitterHandle!=null) {
                                                    shippingDetails+=" , <br><b>Twitter Handle:</b> " + contributions.twitterHandle
                                                }
                                                if(contributions.email!=null){
                                                    shippingDetails+=" , <br><b>Email:</b> " +contributions.email
                                                } 
                                            }
                                        }    

                                    %>
                                    <tr>
                                        <td class="col-sm-2 text-center wordBreak">${project.title}</td>
                                        <td class="col-sm-2 text-center wordBreak">
                                            ${contributionService.getFundRaiserName(contributions, project)}
                                        </td>
                                        <td class="col-sm-1 text-center">${date}</td>
                                        <td class="col-sm-1 text-center">${time}</td>
                                        <td class="col-sm-2 wordBreak">${contributorName}</td>
                                        <td class="col-sm-2 wordBreak">${contributorEmail}</td>

                                        <g:if test="${project.rewards.size()>1}">
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
