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
                <div class="col-xs-12 col-sm-6 col-md-4 col-lg-3 top-pan contribution-inr">
                    <div <g:if test='${contribution.isAnonymous}'>class ="pans alphabet-A"</g:if><g:else>class ="pans ${alphabet}"</g:else>>
                        <div class ="col-sm-3 col-xs-3 img-contribution">
                            <img class="user-img-header" src="${imageUrl}" alt="alphabet">
                        </div>
                        <div class="col-sm-9 col-xs-9 pn-word">
                            <g:if test="${isFacebookUser}">
                                <h4><a href="${userFacebookUrl}">${friendlyName}</a></h4>
                                <span class="sso">
                                    <g:if test="${project.payuStatus}"><span class="fa fa-inr"></span><b>${contribution.amount.round()}</b><span class="font-usd">&nbsp;&nbsp;INR</span></g:if><g:else>$<b>${contribution.amount.round()}</b><span class="font-usd">&nbsp;&nbsp;USD</span></g:else>
                                </span>
                                <dd class="font-days"><g:if test="${numberOfDays >1}">${numberOfDays}&nbsp;&nbsp;Days Ago</g:if><g:elseif test="${numberOfDays == 1}">${numberOfDays}&nbsp;&nbsp;Day Ago</g:elseif><g:else>Today</g:else></dd>
                            </g:if>
                            <g:else>
                                <g:if test="${contribution.contributorName}">
                                    <h4>${contribution.contributorName}</h4>
                                    <span class="sso">
                                        <g:if test="${project.payuStatus}"><span class="fa fa-inr"></span><b>${contribution.amount.round()}</b><span class="font-usd">&nbsp;&nbsp;INR</span></g:if><g:else>$<b>${contribution.amount.round()}</b><span class="font-usd">&nbsp;&nbsp;USD</span></g:else>
                                    </span>
                                    <dd class="font-days"><g:if test="${numberOfDays >1}">${numberOfDays}&nbsp;&nbsp;Days Ago</g:if><g:elseif test="${numberOfDays == 1}">${numberOfDays}&nbsp;&nbsp;Day Ago</g:elseif><g:else>Today</g:else></dd>
                                </g:if>
                                <g:else>
                                    <h4>${friendlyName}</h4>
                                    <dd class="font-days"><g:if test="${numberOfDays >1}">${numberOfDays}&nbsp;&nbsp;Days Ago</g:if><g:elseif test="${numberOfDays == 1}">${numberOfDays}&nbsp;&nbsp;Day Ago</g:elseif><g:else>Today</g:else></dd>
                                </g:else>
                            </g:else>
                        </div>
                    </div>
                </div>
            </g:if>
            <g:else>
                <div class="col-xs-12 col-sm-6 col-md-4 col-lg-3 top-pan offline-contribution-pans">
                    <div class ="pans ${alphabet} contribution-inr">
                        <div class ="col-sm-3 col-xs-3 img-contribution">
                            <img class="user-img-header" src="${imageUrl}" alt="alphabet">
                        </div>
                        <div class="col-sm-9 col-xs-9 pn-word">
                            <h4>${contribution.contributorName}</h4> 
                            <span class="sso">
                                <g:if test="${project.payuStatus}"><span class="fa fa-inr"></span><b>${contribution.amount.round()}</b><span class="font-usd">&nbsp;&nbsp;INR</span></g:if><g:else>$<b>${contribution.amount.round()}</b><span class="font-usd">&nbsp;&nbsp;USD</span></g:else>
                            </span>
                            <dd class="font-days"><g:if test="${numberOfDays >1}">${numberOfDays}&nbsp;&nbsp;Days Ago</g:if><g:elseif test="${numberOfDays == 1}">${numberOfDays}&nbsp;&nbsp;Day Ago</g:elseif><g:else>Today</g:else></dd>
                            <div class="clear"></div>
                            <g:if test="${contribution.fundRaiser.equals(fundRaiser)}">
                                <div class="col-sm-8 col-xs-8">
                                    <div class="offline-contribution">Offline Contribution</div>
                                </div>
                                <g:if test="${!ended}">
                                <div class="col-sm-4 col-xs-4 edit-delete-fund">
                                    <div class="offline-edit-delete-btn">
                                       <button class="projectedit close" id="editproject"  data-toggle="modal" data-target="#contributionedit${contribution.id}" model="['project': project,'contribution': contribution]">
                                           <i class="glyphicon glyphicon-edit" ></i>
                                       </button>

                                       <g:form name="ContributionDelete-form" controller="project" action="contributiondelete" method="post" id="${contribution.id}" params="['projectId':projectId, 'fr': fundRaiser, 'offset': offset]">
                                           <g:hiddenField name="manageCampaign" value="${manageCampaign}"></g:hiddenField>
                                           <button class="projectedit close" onclick="return confirm(&#39;Are you sure you want to discard this contribution?&#39;);">
                                               <i class="glyphicon glyphicon-trash" ></i>
                                           </button>
                                       </g:form>
                                   </div>
                               </div>
                               </g:if>
                           </g:if>
                       </div>
                   </div>
                   <div class="clear"></div>
                       
                   <!-- EditContributionModal -->
                   <div class="modal fade offlineContributionModal contributionedit" id="contributionedit${contribution.id}" tabindex="-1" role="dialog" aria-labelledby="contributionedit${contribution.id}" aria-hidden="true">
                       <g:form name="contributionEdit-form" action="contributionedit" controller="project" id="${contribution.id}"  params="['projectId':projectId, 'fr': fundRaiser, 'offset': offset]" role="form">
                           <div class="modal-dialog">
                               <div class="modal-content">
                                   <div class="modal-body">
                                       <div class="col-sm-12 margin">
                                           <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
                                           <h4 class="heading crowderasupport"><img src="//s3.amazonaws.com/crowdera/assets/icon-edit.png" alt="Edit offline contribution"/>&nbsp;&nbsp;EDIT OFFLINE CONTRIBUTION</h4>
                                       </div>
                                       <g:hiddenField name="manageCampaign" value="${manageCampaign}"></g:hiddenField>
                                       <div class="col-md-8">
                                           <div class="form-group">
                                               <label class="text" for="title">Display Name</label>
                                               <input type="text" class="form-control contributioninput" name="contributorName" value="${contribution.contributorName}"/>
                                           </div>
                                       </div>
                                       <div class="col-md-4">
                                           <div class="form-group">
                                               <label for="title" class="text">Amount(<g:if test="${project.payuStatus}"><span class="fa fa-inr"></span></g:if><g:else>$</g:else>)</label>
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
    <g:paginate controller="project" max="12" action="contributionsList" total="${totalContributions.size()}" params="['projectId':projectId]"/>
</div>
<script>
    $("#contributionList").find('.contributionPaginate a').click(function(event) {
        event.preventDefault();
        var url = $(this).attr('href');
        var grid = $(this).parents('#contributionList');

        $.ajax({
            type: 'GET',
            url: url,
            success: function(data) {
                $(grid).fadeOut('fast', function() {$(this).html(data).fadeIn('fast');});
            }
        });
    });
</script>
