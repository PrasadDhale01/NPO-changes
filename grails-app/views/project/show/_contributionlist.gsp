<!-- Contributions -->
<g:set var="userService" bean="userService"/>
<g:set var="facebookService" bean="facebookService"/>
<g:set var="projectService" bean="projectService" />
<g:set var="contributionService" bean="contributionService"/>
<%@ page import="java.text.SimpleDateFormat" %>
<%
    SimpleDateFormat dateFormat = new SimpleDateFormat("d MMM, YYYY");
    SimpleDateFormat timeFormat = new SimpleDateFormat("hh:mm:ss");
    def user = currentUser
    def fundRaiser
    if (user != null) {
        fundRaiser = user.username
    }
    def projectId = project.id
%>
<g:if test="${!contributions.empty}">
    <div class="row contributions-panel contribution-center-alignment">
        <div class="col-sm-12 contribution-inner-tile">
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
                <div class="col-sm-4 col-lg-6 col-md-6 top-pan">
                    <div <g:if test='${contribution.isAnonymous}'>class ="pan alphabet-A"</g:if><g:else>class ="pan ${alphabet}"</g:else>>
                        <div class ="col-sm-4 col-xs-4 img-panel">
                            <g:if test="${contribution.isAnonymous}">
                                <img class="user-img-header" src="//s3.amazonaws.com/crowdera/assets/alphabet-A.png" alt="alphabet">
                            </g:if>
                            <g:else>
                                <img class="user-img-header" src="${imageUrl}" alt="alphabet">
                            </g:else>
                        </div>
                        <div class="col-sm-8 col-xs-8 pn-word contribution-inr">
                            <g:if test="${contribution.isAnonymous}">
                                <g:if test="${isCrUserCampBenOrAdmin && CurrentUserTeam && currentFundraiser == team}">
                                    <h4>${contribution.contributorName}</h4> 
                                    <span class="sso">
                                        <g:if test="${project.payuStatus}"><span class="fa fa-inr"></span><b>${amount}</b><span class="font-usd">&nbsp;&nbsp;INR</span></g:if><g:else>$<b>${amount}</b><span class="font-usd">&nbsp;&nbsp;USD</span></g:else>
                                    </span>
                                    <div class="font-days"><g:if test="${numberOfDays >1}">${numberOfDays}&nbsp;&nbsp;Days</g:if><g:elseif test="${numberOfDays == 1}">${numberOfDays}&nbsp;&nbsp;Day Ago</g:elseif><g:else>Today</g:else></div>
                                </g:if>
                                <g:else>
                                    <h4 class="anonymous-top">Anonymous Good Soul</h4>
                                    <span class="sso">
                                        <g:if test="${project.payuStatus}"><span class="fa fa-inr"></span><b>${amount}</b><span class="font-usd">&nbsp;&nbsp;INR</span></g:if><g:else>$<b>${amount}</b><span class="font-usd">&nbsp;&nbsp;USD</span></g:else>
                                    </span>
                                    <div class="font-days"><g:if test="${numberOfDays >1}">${numberOfDays}&nbsp;&nbsp;Days Ago</g:if><g:elseif test="${numberOfDays == 1}">${numberOfDays}&nbsp;&nbsp;Day Ago</g:elseif><g:else>Today</g:else></div>
                                </g:else>
                            </g:if>
                            <g:else>
                                <g:if test="${contribution.contributorName}">
                                    <h4>${contribution.contributorName}</h4>
                                    <span class="sso">
                                        <g:if test="${project.payuStatus}"><span class="fa fa-inr"></span><b>${amount}</b><span class="font-usd">&nbsp;&nbsp;INR</span></g:if><g:else>$<b>${amount}</b><span class="font-usd">&nbsp;&nbsp;USD</span></g:else>
                                    </span>
                                    <div class="font-days"><g:if test="${numberOfDays >1}">${numberOfDays}&nbsp;&nbsp;Days Ago</g:if><g:elseif test="${numberOfDays == 1}">${numberOfDays}&nbsp;&nbsp;Day Ago</g:elseif><g:else>Today</g:else></div>
                                </g:if>
                                <g:else>
                                    <h4>${friendlyName}</h4>
                                    <span class="sso">
                                        <g:if test="${project.payuStatus}"><span class="fa fa-inr"></span><b>${amount}</b><span class="font-usd">&nbsp;&nbsp;INR</span></g:if><g:else>$<b>${amount}</b><span class="font-usd">&nbsp;&nbsp;USD</span></g:else>
                                    </span>
                                    <div class="font-days"><g:if test="${numberOfDays >1}">${numberOfDays}&nbsp;&nbsp;Days Ago</g:if><g:elseif test="${numberOfDays == 1}">${numberOfDays}&nbsp;&nbsp;Day Ago</g:elseif><g:else>Today</g:else></div>
                                </g:else>
                            </g:else>
                        </div>
                    </div>
                </div>
            </g:if>
            <g:else>
                <div class="col-sm-4 col-lg-6 col-md-6 top-pan">
                    <div class ="pan ${alphabet}">
                        <div class ="col-sm-4 col-xs-4 img-panel">
                            <img class="user-img-header" src="${imageUrl}" alt="alphabet">
                        </div>
                        <div class="col-sm-8 col-xs-8 pn-word contribution-inr">
                            <h4>${contribution.contributorName}</h4> 
                            <span class="sso">
                                <g:if test="${project.payuStatus}"><span class="fa fa-inr"></span><b>${amount}</b><span class="font-usd">&nbsp;&nbsp;INR</span></g:if><g:else>$<b>${amount}</b><span class="font-usd">&nbsp;&nbsp;USD</span></g:else>
                            </span>
                            <div class="font-days"><g:if test="${numberOfDays >1}">${numberOfDays}&nbsp;&nbsp;Days Ago</g:if><g:elseif test="${numberOfDays == 1}">${numberOfDays}&nbsp;&nbsp;Day Ago</g:elseif><g:else>Today</g:else></div>
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
                                        <button class="projectedit close" id="editproject"  data-toggle="modal" data-target="#contributionedit${contribution.id}">
                                            <i class="glyphicon glyphicon-edit" ></i>
                                        </button>
                                        <g:form controller="project" action="contributiondelete" method="post" id="${contribution.id}" params="['projectId':projectId, 'fr': fundRaiser, 'offset': offset]">
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
                    
                    <div class="modal fade offlineContributionModal contributionedit" id="contributionedit${contribution.id}" tabindex="-1" role="dialog" aria-labelledby="contributionedit${contribution.id}" aria-hidden="true">
                        <g:form action="contributionedit" controller="project" id="${contribution.id}"  params="['projectId':projectId, 'fr': fundRaiser, 'offset':offset]">
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
        </g:each>
       </div>
    </div>
</g:if>
<div class="clear"></div>
<div class="contributionPaginate" id="contributionPaginate">
    <g:paginate controller="project" max="12" action="contributionList" total="${totalContributions.size()}" params="['projectId':projectId,'fr': vanityUsername]"/>
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
