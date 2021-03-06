<%-- Contributions --%>
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
    def conversionMultiplier = multiplier
    if (!conversionMultiplier) {
        conversionMultiplier = projectService.getCurrencyConverter();
    }
%>
<g:if test="${!contributions.empty}">
    <div class="row contributions-panel contribution-center-alignment">
        <div class="col-sm-12 contribution-inner-tile show-contributions-top">
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
                <div class="col-sm-6 col-lg-6 col-md-6 show-contributionpadding">
                    <g:if test="${!contribution.isAnonymous}">
                 	    <%
                            def contributorEmail = contribution.contributorEmail
                        %>
                        <g:if test="${currentEnv=='testIndia' || currentEnv=='test' }">
                            <g:link controller="user" action="viewUserProfile" id="${contribution.user.id}" params="[amount:amount, contributorEmail: contributorEmail]" target="_blank">
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
                                                <g:if test="${currentEnv == 'testIndia' || currentEnv == 'stagingIndia' || currentEnv == 'prodIndia'}">
                                                    <span class="fa fa-inr"></span><g:if test="${project.payuStatus}"><b>${amount}</b></g:if><g:else><b>${amount * conversionMultiplier}</b></g:else><span class="font-usd">&nbsp;&nbsp;INR</span>
                                                </g:if>
                                                <g:else>
                                                    $<b>${amount}</b><span class="font-usd">&nbsp;&nbsp;USD</span>
                                                </g:else>
                                            </span>
                                            <div class="font-days"><g:if test="${numberOfDays >1}">${numberOfDays}&nbsp;&nbsp;Days</g:if><g:elseif test="${numberOfDays == 1}">${numberOfDays}&nbsp;&nbsp;Day Ago</g:elseif><g:else>Today</g:else></div>
                                        </g:if>
                                        <g:else>
                                            <h4 class="anonymous-top">Anonymous Good Soul</h4>
                                            <span class="sso">
                                                <g:if test="${currentEnv == 'testIndia' || currentEnv == 'stagingIndia' || currentEnv == 'prodIndia'}">
                                                    <span class="fa fa-inr"></span><g:if test="${project.payuStatus}"><b>${amount}</b></g:if><g:else><b>${amount * conversionMultiplier}</b></g:else><span class="font-usd">&nbsp;&nbsp;INR</span>
                                                </g:if>
                                                <g:else>
                                                    $<b>${amount}</b><span class="font-usd">&nbsp;&nbsp;USD</span>
                                                </g:else>
                                            </span>
                                            <div class="font-days"><g:if test="${numberOfDays >1}">${numberOfDays}&nbsp;&nbsp;Days Ago</g:if><g:elseif test="${numberOfDays == 1}">${numberOfDays}&nbsp;&nbsp;Day Ago</g:elseif><g:else>Today</g:else></div>
                                        </g:else>
                                    </g:if>
                                    <g:else>
                                        <g:if test="${contribution.contributorName}">
                                            <h4>${contribution.contributorName}</h4>
                                            <span class="sso">
                                                <g:if test="${currentEnv == 'testIndia' || currentEnv == 'stagingIndia' || currentEnv == 'prodIndia'}">
                                                    <span class="fa fa-inr"></span><g:if test="${project.payuStatus}"><b>${amount}</b></g:if><g:else><b>${amount * conversionMultiplier}</b></g:else><span class="font-usd">&nbsp;&nbsp;INR</span>
                                                </g:if>
                                                <g:else>
                                                    $<b>${amount}</b><span class="font-usd">&nbsp;&nbsp;USD</span>
                                                </g:else>
                                            </span>
                                            <div class="font-days"><g:if test="${numberOfDays >1}">${numberOfDays}&nbsp;&nbsp;Days Ago</g:if><g:elseif test="${numberOfDays == 1}">${numberOfDays}&nbsp;&nbsp;Day Ago</g:elseif><g:else>Today</g:else></div>
                                        </g:if>
                                        <g:else>
                                            <h4>${friendlyName}</h4>
                                            <span class="sso">
                                                <g:if test="${currentEnv == 'testIndia' || currentEnv == 'stagingIndia' || currentEnv == 'prodIndia'}">
                                                    <span class="fa fa-inr"></span><g:if test="${project.payuStatus}"><b>${amount}</b></g:if><g:else><b>${amount * conversionMultiplier}</b></g:else><span class="font-usd">&nbsp;&nbsp;INR</span>
                                                </g:if>
                                                <g:else>
                                                    $<b>${amount}</b><span class="font-usd">&nbsp;&nbsp;USD</span>
                                                </g:else>
                                            </span>
                                            <div class="font-days"><g:if test="${numberOfDays >1}">${numberOfDays}&nbsp;&nbsp;Days Ago</g:if><g:elseif test="${numberOfDays == 1}">${numberOfDays}&nbsp;&nbsp;Day Ago</g:elseif><g:else>Today</g:else></div>
                                        </g:else>
                                    </g:else>
                                
                                </div>
                            </div>
                            </g:link>
                        </g:if>
                        <g:else>
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
                                                <g:if test="${currentEnv == 'testIndia' || currentEnv == 'stagingIndia' || currentEnv == 'prodIndia'}">
                                                    <span class="fa fa-inr"></span><g:if test="${project.payuStatus}"><b>${amount}</b></g:if><g:else><b>${amount * conversionMultiplier}</b></g:else><span class="font-usd">&nbsp;&nbsp;INR</span>
                                                </g:if>
                                                <g:else>
                                                    $<b>${amount}</b><span class="font-usd">&nbsp;&nbsp;USD</span>
                                                </g:else>
                                            </span>
                                            <div class="font-days"><g:if test="${numberOfDays >1}">${numberOfDays}&nbsp;&nbsp;Days</g:if><g:elseif test="${numberOfDays == 1}">${numberOfDays}&nbsp;&nbsp;Day Ago</g:elseif><g:else>Today</g:else></div>
                                        </g:if>
                                        <g:else>
                                            <h4 class="anonymous-top">Anonymous Good Soul</h4>
                                            <span class="sso">
                                                <g:if test="${currentEnv == 'testIndia' || currentEnv == 'stagingIndia' || currentEnv == 'prodIndia'}">
                                                    <span class="fa fa-inr"></span><g:if test="${project.payuStatus}"><b>${amount}</b></g:if><g:else><b>${amount * conversionMultiplier}</b></g:else><span class="font-usd">&nbsp;&nbsp;INR</span>
                                                </g:if>
                                                <g:else>
                                                    $<b>${amount}</b><span class="font-usd">&nbsp;&nbsp;USD</span>
                                                </g:else>
                                            </span>
                                            <div class="font-days"><g:if test="${numberOfDays >1}">${numberOfDays}&nbsp;&nbsp;Days Ago</g:if><g:elseif test="${numberOfDays == 1}">${numberOfDays}&nbsp;&nbsp;Day Ago</g:elseif><g:else>Today</g:else></div>
                                        </g:else>
                                    </g:if>
                                    <g:else>
                                        <g:if test="${contribution.contributorName}">
                                            <h4>${contribution.contributorName}</h4>
                                            <span class="sso">
                                                <g:if test="${currentEnv == 'testIndia' || currentEnv == 'stagingIndia' || currentEnv == 'prodIndia'}">
                                                    <span class="fa fa-inr"></span><g:if test="${project.payuStatus}"><b>${amount}</b></g:if><g:else><b>${amount * conversionMultiplier}</b></g:else><span class="font-usd">&nbsp;&nbsp;INR</span>
                                                </g:if>
                                                <g:else>
                                                    $<b>${amount}</b><span class="font-usd">&nbsp;&nbsp;USD</span>
                                                </g:else>
                                            </span>
                                            <div class="font-days"><g:if test="${numberOfDays >1}">${numberOfDays}&nbsp;&nbsp;Days Ago</g:if><g:elseif test="${numberOfDays == 1}">${numberOfDays}&nbsp;&nbsp;Day Ago</g:elseif><g:else>Today</g:else></div>
                                        </g:if>
                                        <g:else>
                                            <h4>${friendlyName}</h4>
                                            <span class="sso">
                                                <g:if test="${currentEnv == 'testIndia' || currentEnv == 'stagingIndia' || currentEnv == 'prodIndia'}">
                                                    <span class="fa fa-inr"></span><g:if test="${project.payuStatus}"><b>${amount}</b></g:if><g:else><b>${amount * conversionMultiplier}</b></g:else><span class="font-usd">&nbsp;&nbsp;INR</span>
                                                </g:if>
                                                <g:else>
                                                    $<b>${amount}</b><span class="font-usd">&nbsp;&nbsp;USD</span>
                                                </g:else>
                                            </span>
                                            <div class="font-days"><g:if test="${numberOfDays >1}">${numberOfDays}&nbsp;&nbsp;Days Ago</g:if><g:elseif test="${numberOfDays == 1}">${numberOfDays}&nbsp;&nbsp;Day Ago</g:elseif><g:else>Today</g:else></div>
                                        </g:else>
                                    </g:else>
                                
                                </div>
                            </div>
                	   </g:else>
                	</g:if>
                	<g:else>
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
                                        <g:if test="${currentEnv == 'testIndia' || currentEnv == 'stagingIndia' || currentEnv == 'prodIndia'}">
                                            <span class="fa fa-inr"></span><g:if test="${project.payuStatus}"><b>${amount}</b></g:if><g:else><b>${amount * conversionMultiplier}</b></g:else><span class="font-usd">&nbsp;&nbsp;INR</span>
                                        </g:if>
                                        <g:else>
                                            $<b>${amount}</b><span class="font-usd">&nbsp;&nbsp;USD</span>
                                        </g:else>
                                    </span>
                                    <div class="font-days"><g:if test="${numberOfDays >1}">${numberOfDays}&nbsp;&nbsp;Days</g:if><g:elseif test="${numberOfDays == 1}">${numberOfDays}&nbsp;&nbsp;Day Ago</g:elseif><g:else>Today</g:else></div>
                                </g:if>
                                <g:else>
                                    <h4 class="anonymous-top">Anonymous Good Soul</h4>
                                    <span class="sso">
                                        <g:if test="${currentEnv == 'testIndia' || currentEnv == 'stagingIndia' || currentEnv == 'prodIndia'}">
                                            <span class="fa fa-inr"></span><g:if test="${project.payuStatus}"><b>${amount}</b></g:if><g:else><b>${amount * conversionMultiplier}</b></g:else><span class="font-usd">&nbsp;&nbsp;INR</span>
                                        </g:if>
                                        <g:else>
                                            $<b>${amount}</b><span class="font-usd">&nbsp;&nbsp;USD</span>
                                        </g:else>
                                    </span>
                                    <div class="font-days"><g:if test="${numberOfDays >1}">${numberOfDays}&nbsp;&nbsp;Days Ago</g:if><g:elseif test="${numberOfDays == 1}">${numberOfDays}&nbsp;&nbsp;Day Ago</g:elseif><g:else>Today</g:else></div>
                                </g:else>
                            </g:if>
                            <g:else>
                                <g:if test="${contribution.contributorName}">
                                    <h4>${contribution.contributorName}</h4>
                                    <span class="sso">
                                        <g:if test="${currentEnv == 'testIndia' || currentEnv == 'stagingIndia' || currentEnv == 'prodIndia'}">
                                            <span class="fa fa-inr"></span><g:if test="${project.payuStatus}"><b>${amount}</b></g:if><g:else><b>${amount * conversionMultiplier}</b></g:else><span class="font-usd">&nbsp;&nbsp;INR</span>
                                        </g:if>
                                        <g:else>
                                            $<b>${amount}</b><span class="font-usd">&nbsp;&nbsp;USD</span>
                                        </g:else>
                                    </span>
                                    <div class="font-days"><g:if test="${numberOfDays >1}">${numberOfDays}&nbsp;&nbsp;Days Ago</g:if><g:elseif test="${numberOfDays == 1}">${numberOfDays}&nbsp;&nbsp;Day Ago</g:elseif><g:else>Today</g:else></div>
                                </g:if>
                                <g:else>
                                    <h4>${friendlyName}</h4>
                                    <span class="sso">
                                        <g:if test="${currentEnv == 'testIndia' || currentEnv == 'stagingIndia' || currentEnv == 'prodIndia'}">
                                            <span class="fa fa-inr"></span><g:if test="${project.payuStatus}"><b>${amount}</b></g:if><g:else><b>${amount * conversionMultiplier}</b></g:else><span class="font-usd">&nbsp;&nbsp;INR</span>
                                        </g:if>
                                        <g:else>
                                            $<b>${amount}</b><span class="font-usd">&nbsp;&nbsp;USD</span>
                                        </g:else>
                                    </span>
                                    <div class="font-days"><g:if test="${numberOfDays >1}">${numberOfDays}&nbsp;&nbsp;Days Ago</g:if><g:elseif test="${numberOfDays == 1}">${numberOfDays}&nbsp;&nbsp;Day Ago</g:elseif><g:else>Today</g:else></div>
                                </g:else>
                            </g:else>
                        </div>
                    </div>
                    </g:else>
                </div>
            </g:if>
            <g:else>
                <%
                    def contributorEmail = contribution.contributorEmail
                %>
                    <div class="col-sm-6 col-lg-6 col-md-6 show-contributionpadding">
                        <div class ="pan ${alphabet}">
                            <div class ="col-sm-4 col-xs-4 img-panel">
                                <img class="user-img-header" src="${imageUrl}" alt="alphabet">
                            </div>
                            <div class="col-sm-8 col-xs-8 pn-word contribution-inr">
                                <h4>${contribution.contributorName}</h4> 
                                <span class="sso">
                                    <g:if test="${currentEnv == 'testIndia' || currentEnv == 'stagingIndia' || currentEnv == 'prodIndia'}">
                                        <span class="fa fa-inr"></span><g:if test="${project.payuStatus}"><b>${amount}</b></g:if><g:else>${amount * conversionMultiplier}</g:else><span class="font-usd">&nbsp;&nbsp;INR</span>
                                    </g:if>
                                    <g:else>
                                        $<b>${amount}</b><span class="font-usd">&nbsp;&nbsp;USD</span>
                                    </g:else>
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
                                <g:if test="${!ended}">
                                    <div class="col-sm-6 cols">
                                        <g:if test="${contribution.fundRaiser.equals(fundRaiser) && team.user == user && !isCrUserCampBenOrAdmin}">
                                            <div class="edits">
                                                <button class="projectedit close editofflinecontribution" id="editproject"  data-toggle="modal" data-target="#contributionedit" data-id="${contribution.id}">
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
                                </g:if>
                            </div>
                        </div>
                        <div class="clear"></div>

                    </div>
                
            </g:else>
            
        </g:each>
        
        <div class="modal fade offlineContributionModal contributionedit" id="contributionedit" tabindex="-1" role="dialog" aria-labelledby="contributionedit" aria-hidden="true">
             <g:form action="contributionedit" controller="project"  params="['projectId':projectId, 'fr': fundRaiser, 'offset':offset]">
                 <div class="modal-dialog">
                     <div class="modal-content">
                         <div class="modal-body">
                             <div class="col-sm-12 margin">
                                 <input type="hidden" name="contributionId" id="contributionId-edit">
                                 <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
                                 <h4 class="heading crowderasupport"><img src="//s3.amazonaws.com/crowdera/assets/icon-edit.png" alt="Edit offline contribution"/>&nbsp;&nbsp;EDIT OFFLINE CONTRIBUTION</h4>
                             </div>
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
                                             <input type="checkbox" name="isTaxreceipt" id="isTaxreceiptEdit" > Do you want to provide donation receipt?
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
    </div>
</g:if>

<div class="clear"></div>
<div class="contributionPaginate" id="contributionPaginate">
    <g:paginate controller="project" max="12" action="contributionList" maxsteps="5" total="${totalContributions.size()}" params="['projectId':projectId,'fr': vanityUsername]"/>
</div>
<script>
    $('#contributions-mobile, #contributions').find("#contributionList").find('.contributionPaginate a').click(function(event) {
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
