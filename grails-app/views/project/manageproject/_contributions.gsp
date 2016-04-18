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
<g:if test="${project.validated}">
<div class="col-md-12 col-md-12 col-sm-12 col-xs-12">
    <g:if test="${totalContributions.empty}">
        <div class="alert alert-info">No contributions yet.</div>
    </g:if>
    <g:if test="${project.validated}">
        <div class="manage-report-offline-lft">
            <g:if test="${!ended}">
                <a href="#" class="btn btn-primary btn-sm pull-right managecontribution mange-contribution-mobile" data-toggle="modal" data-target="#offlineContributionModal">
                    Manage Offline Contribution
                </a>
            </g:if>
            <g:elseif test="${ended}">
                <a href="#" class="btn btn-primary btn-sm pull-right managecontribution mange-contribution-mobile" id="endedOfflineContribution">
                    Manage Offline Contribution
                </a>
            </g:elseif>
            <g:if test="${!totalContributions.empty}">
                <a href="#" class="btn btn-primary btn-sm btn-circle pull-right mngReportCls mange-contributionreport-mobile" data-toggle="modal" data-target="#moveContributionModal">
                    Move
                </a>
                <a href="#" class="btn btn-primary btn-sm btn-circle pull-right mngReportCls mange-contributionreport-mobile" data-toggle="modal" data-target="#reportModal">
                    Report
                </a>
            </g:if>
        </div>
    </g:if>
    <div class="clear"></div>
    <%-- Modal --%>
    <div class="modal fade offlineContributionModal" id="offlineContributionModal" tabindex="-1" aria-hidden="true">
        <g:form action="saveOfflineContribution" controller="fund" id="${project.id}"  params="['fr':fundRaiser]" name="saveOfflineContribution-form">
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
                        <div class="col-sm-12">
                            <div class="form-group">
                                <label class="text col-sm-3">Display Name</label>
                                <div class="col-sm-9"> 
                                <input type="text" class="form-control contributioninput" name="contributorName1"><br>
                                </div>
                            </div>
                        </div>
                        <div class="col-sm-12">
                            <div class="form-group">
                                <label class="text col-sm-3">Email</label>
                                <div class="col-sm-9"> 
                                <input type="email" class="form-control contributioninput" name="contributorEmail1" required><br>
                               </div>
                            </div>
                        </div>
                        <div class="col-sm-12">
                            <div class="form-group">
                                <label class="text col-sm-3">Amount(<g:if test="${project.payuStatus}"><span class="fa fa-inr"></span></g:if><g:else>$</g:else>)</label>
                                <div class="col-sm-9"> 
                                <input type="text" class="form-control contributioninput" name="amount1" id="offlineAmount1"><br>
                                </div>
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
    <g:if test="${!totalContributions.empty}">
        <div class="contributionList" id="contributionList">
            <g:render template="manageproject/contributionlist"/>
        </div>
    </g:if>
</div>
</g:if>
<g:else>
    <div class="alert alert-info">Campaign is yet to be validated.</div>
</g:else>

<%-- Modal --%>
<div class="modal fade" id="reportModal" tabindex="-1" aria-hidden="true">
   <g:form controller="project" action="generateCSV" name="generateCSV-form" id="generateCSV-form">
   <div class="modal-dialog">
      <div class="modal-content">
         <div class="modal-header">
            <button type="button" class="close" 
               data-dismiss="modal" aria-hidden="true">
                  &times;
            </button>
            <h4 class="modal-title text-center" id="reportModalLabel">
                <b>CONTRIBUTION REPORT</b>
            </h4>
         </div>
         
         <g:hiddenField name="projectId" value="${project.id}" id="projectId${project.id}"/>
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

                                        <td class="text-center">${amount}</td>

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
            
        </div>
        <div class="modal-footer">
            <button type="submit" class="btn btn-primary btnGenerateCSV" >Export CSV
            </button>
         </div>
      </div><%-- /.modal-dialog--%>
    </div><%--  /.modal-content --%>
    </g:form>
</div><%-- /.modal --%>

    

 <!-- Modal HTML -->
    <div id="moveContributionModal" class="modal fade">
        <div class="modal-dialog">
            <g:form action="moveContributions" controller="fund" method="post" id="${project.id}">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                        <h4 class="modal-title heading"><b>Move Contribution</b></h4>
                        <g:hiddenField name="projectId" class="projectId" id="projectId" value="${projectId}"/>
                    </div>
                    <div class="modal-body">
                        <div class="col-sm-12">
                            <div class="form-group">
                                <label class="text col-sm-3">From</label>
                                <div class="col-sm-9"> 
                                     <g:select from="${teamNames}" class="form-control contributionFR" name="contributionFR"/><br>
                                </div>
                            </div>
                        </div>
                        <div class="col-sm-12">
                            <div class="form-group">
                                <label class="text col-sm-3">To</label>
                                <div class="col-sm-9"> 
                                <g:select from="${teamNames}" class="form-control contributorName" name="contributorName" /><br>
                               </div>
                            </div>
                        </div>
                        <div class="col-sm-12">
                            <div class="form-group">
                                <label class="text col-sm-3">Amount(<g:if test="${project.payuStatus}"><span class="fa fa-inr"></span></g:if><g:else>$</g:else>)</label>
                                <div class="col-sm-9">
                                    <g:select from="" class="form-control contributionAmount" name="contributionAmount" id="contributionAmt"/><br>
                                </div>
                            </div>
                        </div>
                        <div class="clear"></div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-primary" data-dismiss="modal">Close</button>
                        <button  class="btn btn-primary " id="btnMove">Move</button>
                    </div>
                </div>
            </g:form>
        </div>
    </div>