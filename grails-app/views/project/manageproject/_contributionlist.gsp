<%-- Contributions --%>
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
                <div class="col-xs-12 col-sm-6 col-md-4 col-lg-4 top-pan manage-contribution-md-tabs contribution-inr  manage-contributiontile">
                    <div <g:if test='${contribution.isAnonymous}'>class ="pans alphabet-A"</g:if><g:else>class ="pans ${alphabet}"</g:else>>
                        <div class ="col-sm-3 col-xs-3 img-contribution">
                            <img class="user-img-header" src="${imageUrl}" alt="alphabet">
                        </div>
                        <div class="col-sm-9 col-xs-9 pn-word">
                            <g:if test="${isFacebookUser}">
                                <h4><a href="${userFacebookUrl}">${friendlyName}</a></h4>
                                <span class="sso">
                                    <g:if test="${project.payuStatus}">
                                        <span class="fa fa-inr"><b>${contribution.amount.round()}</b></span><span class="font-usd">&nbsp;&nbsp;INR</span>
                                    </g:if>
                                    <g:else>
                                        $<b>${contribution.amount.round()}</b><span class="font-usd">&nbsp;&nbsp;USD</span>
                                    </g:else>
                                </span>
                                <div class="font-days"><g:if test="${numberOfDays >1}">${numberOfDays}&nbsp;&nbsp;Days Ago</g:if><g:elseif test="${numberOfDays == 1}">${numberOfDays}&nbsp;&nbsp;Day Ago</g:elseif><g:else>Today</g:else></div>
                            </g:if>
                            <g:else>
                                <g:if test="${contribution.contributorName}">
                                    <h4>${contribution.contributorName}</h4>
                                    <span class="sso">
                                        <g:if test="${project.payuStatus}">
                                            <span class="fa fa-inr"><b>${contribution.amount.round()}</b></span><span class="font-usd">&nbsp;&nbsp;INR</span>
                                        </g:if>
                                        <g:else>
                                            $<b>${contribution.amount.round()}</b><span class="font-usd">&nbsp;&nbsp;USD</span>
                                        </g:else>
                                    </span>
                                    <div class="font-days"><g:if test="${numberOfDays >1}">${numberOfDays}&nbsp;&nbsp;Days Ago</g:if><g:elseif test="${numberOfDays == 1}">${numberOfDays}&nbsp;&nbsp;Day Ago</g:elseif><g:else>Today</g:else></div>
                                </g:if>
                                <g:else>
                                    <h4>${friendlyName}</h4>
                                    <div class="font-days"><g:if test="${numberOfDays >1}">${numberOfDays}&nbsp;&nbsp;Days Ago</g:if><g:elseif test="${numberOfDays == 1}">${numberOfDays}&nbsp;&nbsp;Day Ago</g:elseif><g:else>Today</g:else></div>
                                </g:else>
                            </g:else>
                        </div>
                    </div>
                </div>
            </g:if>
            <g:else>
                <div class="col-xs-12 col-sm-6 col-md-4 col-lg-4 top-pan manage-contribution-md-tabs offline-contribution-pans manage-contributiontile">
                    <div class ="pans ${alphabet} contribution-inr">
                        <div class ="col-sm-3 col-xs-3 img-contribution">
                            <img class="user-img-header" src="${imageUrl}" alt="alphabet">
                        </div>
                        <div class="col-sm-9 col-xs-9 pn-word">
                            <h4>${contribution.contributorName}</h4> 
                            <span class="sso">
                                <g:if test="${project.payuStatus}">
                                    <span class="fa fa-inr"><b>${contribution.amount.round()}</b></span><span class="font-usd">&nbsp;&nbsp;INR</span>
                                </g:if>
                                <g:else>
                                    $<b>${contribution.amount.round()}</b><span class="font-usd">&nbsp;&nbsp;USD</span>
                                </g:else>
                            </span>
                            <div class="font-days"><g:if test="${numberOfDays >1}">${numberOfDays}&nbsp;&nbsp;Days Ago</g:if><g:elseif test="${numberOfDays == 1}">${numberOfDays}&nbsp;&nbsp;Day Ago</g:elseif><g:else>Today</g:else></div>
                            <div class="clear"></div>
                            <g:if test="${contribution.fundRaiser.equals(fundRaiser)}">
                                <div class="col-sm-8 col-xs-8">
                                    <div class="offline-contribution">Offline Contribution</div>
                                </div>
                                <g:if test="${!ended}">
                                <div class="col-sm-4 col-xs-4 edit-delete-fund manage-editdel-width">
                                    <div class="offline-edit-delete-btn">
                                       <button class="projectedit close manage-contribution-delete editofflinecontribution"  data-toggle="modal" data-target="#contributionedit" data-id="${contribution.id}">
                                           <i class="glyphicon glyphicon-edit" ></i>
                                       </button>

                                       <g:form controller="project" action="contributiondelete" method="post" id="${contribution.id}" params="['projectId':projectId, 'fr': fundRaiser, 'offset': offset]">
                                           <g:hiddenField name="manageCampaign" value="${manageCampaign}" id="manageCampaign${contribution.id}"></g:hiddenField>
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
                       
                </div>
            </g:else>
                
            <%--  Modal --%>
            <%--
            <div class="modal fade" id="rewarddetails${contribution.id}" tabindex="-1" aria-hidden="true">
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
                                    <label><b>Name: &nbsp;</b> ${contribution.contributorName}</label>
                                </div>
                                <div class="form-group">
                                    <label><b>Email: &nbsp;</b> ${contribution.contributorEmail}</label>
                                </div>
                            </g:else>
                            <g:if test="${contribution.email  != null}">
                                <g:if test="${!contribution.email.equalsIgnoreCase('null')}">
                                    <div class="form-group">
                                         <label><b>Shipping Email: &nbsp;</b> ${contribution.email}</label>
                                    </div>
                                </g:if>
                            </g:if>
                            <g:if test="${contribution.physicalAddress != null}">
                                <g:if test="${!contribution.physicalAddress.equalsIgnoreCase('null')}">
                                     <div class="form-group">
                                         <label><b>Physical Address: &nbsp;</b> ${contribution.physicalAddress}</label>
                                     </div>
                                 </g:if>
                            </g:if>
                            <g:if test="${contribution.twitterHandle  != null}">
                                <g:if test="${!contribution.twitterHandle.equalsIgnoreCase('null')}">
                                    <div class="form-group">
                                        <label><b>Twitter Handle: &nbsp;</b> ${contribution.twitterHandle}</label>
                                    </div>
                                </g:if>
                            </g:if>
                            <g:if test="${contribution.custom  != null}">
                                <g:if test="${!contribution.custom.equalsIgnoreCase('null')}">
                                    <div class="form-group">
                                        <label><b>Custom Details: &nbsp;</b> ${contribution.custom}</label>
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
            --%>
        </g:each>
        
        <%-- EditContributionModal --%>
	    <div class="modal fade offlineContributionModal contributionedit" id="contributionedit" tabindex="-1" aria-hidden="true">
	        <g:form action="contributionedit" controller="project"  params="['projectId':projectId, 'fr': fundRaiser, 'offset': offset]">
	            <div class="modal-dialog">
	                <div class="modal-content">
	                    <div class="modal-body">
	                        <div class="col-sm-12 margin">
	                            <input type="hidden" name="contributionId" id="contributionId-edit">
	                            <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
	                            <h4 class="heading crowderasupport hidden-xs"><img src="//s3.amazonaws.com/crowdera/assets/icon-edit.png" alt="Edit offline contribution"/>&nbsp;&nbsp;EDIT OFFLINE CONTRIBUTION</h4>
	                            <span class="visible-xs"><img src="//s3.amazonaws.com/crowdera/assets/icon-edit.png" class="img-size-xs" alt="Edit offline contribution"/>&nbsp;&nbsp;<b>EDIT OFFLINE CONTRIBUTION</b></span>
	                        </div>
	                        <g:hiddenField name="manageCampaign" value="${manageCampaign}" id="manageCampaign"></g:hiddenField>
	                        <div class="col-sm-12">
	                            <div class="form-group">
	                                <label class="text col-sm-3">First Name</label>
	                                <div class="col-sm-9"> 
	                                <input type="text" class="form-control contributioninput" name="contributorName" id="contributorName-edit"><br>
	                                </div>
	                            </div>
	                            <div class="form-group">
	                                <label class="text col-sm-3">Last Name</label>
	                                <div class="col-sm-9"> 
	                                <input type="text" class="form-control contributioninput" name="contributorLastName" id="contributorLastName-edit"><br>
	                                </div>
	                            </div>
	                        </div>
	                        <div class="col-sm-12">
	                            <div class="form-group">
	                                <label class="text col-sm-3">Email</label>
	                                <div class="col-sm-9"> 
	                                    <input type="email" class="form-control contributioninput" name="contributorEmail" id="contributorEmail-edit" required><br>
	                                </div>
	                            </div>
	                        </div>
	                        <div class="col-sm-12 margin-btm-10">
	                            <div class="form-group">
	                                <label class="text col-sm-3">Amount(<g:if test="${project.payuStatus}"><span class="fa fa-inr"></span></g:if><g:else>$</g:else>)</label>
	                                <div class="col-sm-9"> 
	                                <input type="text" class="form-control contributioninput offlineAmount" name="amount" id="contributorAmount-edit">
	                                </div>
	                            </div>
	                            <div class="contributionerrormsg"></div>
	                        </div>
	                        <g:if test="${isTaxReceipt}">
	                             <div class="col-sm-12 margin-btm-10">
	                                 <div class="form-group">
	                                     <label class="text col-sm-12">
	                                         <input type="checkbox" name="isTaxreceipt" id="isTaxreceiptEdit" > Do you want to provide tax receipt?
	                                     </label>
	                                 </div>
	                             </div>
	                             <div class="col-sm-12">
	                                 <div class="form-group">
	                                     <label class="text col-sm-3 pannumberEditDiv">
	                                         PAN Number
	                                     </label>
	                                     <div class="col-sm-9 pannumberEditDiv">
	                                         <input class="form-control" id="editPanNumber" name="panNumber1" type="text" placeholder="Enter PAN Number" maxlength="10"/>
	                                     </div>
	                                 </div>
	                             </div>
	                         </g:if>
	                    </div>
	                    <div class="clear"></div>
	                    <div class="modal-footer">
	                        <button data-dismiss="modal" class="btn btn-primary">Close</button>
	                        <button class="btn btn-primary" type="submit">Save</button>
	                    </div>
	                </div>
	            </div>
	        </g:form>
	    </div>
                   
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

    $(".editofflinecontribution").click(function(event) {

    	$("#contributorName-edit").val("");
        $("#contributorLastName-edit").val("");
        $("#contributorEmail-edit").val("");
        $("#contributorAmount-edit").val("");
        $("#editPanNumber").val("");
        $("#contributionId-edit").val("");
        $("#isTaxreceiptEdit").prop("checked", false).change();
        
   	    var url = "/fund/getOfflineContribution";
        var grid = $(this).parents('#contributionList');
        var id = $(this).data("id");

        $.ajax({
            type: 'GET',
            url: url,
            data: {
                id : id
            },
            success: function(data) {
                data = JSON.parse(data)
                $("#contributionId-edit").val(id);
                $("#contributorName-edit").val(data.firstName);
                $("#contributorLastName-edit").val(data.lastName);
                $("#contributorEmail-edit").val(data.email);
                $("#contributorAmount-edit").val(data.amount);
                if (data.panNumber != undefined && data.panNumber != "") {
                    $("#editPanNumber").val(data.panNumber);
                    $("#isTaxreceiptEdit").prop("checked", true).change();
                }
            }
        });
    });
</script>
