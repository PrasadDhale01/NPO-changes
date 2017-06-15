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
	def country_code = projectService.getCountryCodeForCurrentEnv(request)
%>
<g:if test="${project.validated}">
<div class="col-md-12 col-md-12 col-sm-12 col-xs-12 cdra-mng-ftpadding manage-contribution-bgcolor">
    <g:hiddenField name="isIndianCampaign" value="${project.payuStatus}" id="isIndianCampaign"/>
    <g:if test="${totalContributions.empty}">
        <div class="alert alert-info">No contributions yet.</div>
    </g:if>
    <g:if test="${project.validated}">
        <div class="manage-report-offline-lft">
        <div class="dropdown pull-right">
        
            <button class="btn btn-default dropdown-toggle" type="button" 
            id="dropdownMenu1" data-toggle="dropdown" aria-haspopup="true" aria-expanded="true">
            Manage contribution
            <span class="caret"></span></button>
            
            <ul class="dropdown-menu cdra-mng-dropwidth" aria-labelledby="dropdownMenu1">
            <g:if test="${!ended}">
               <li> <a href="#" class="" data-toggle="modal" data-target="#offlineContributionModal">
                    Manage Offline Contribution
                </a></li>
            </g:if>
            <g:elseif test="${ended}">
               <li> <a href="#" class="" id="endedOfflineContribution">
                    Manage Offline Contribution
                </a></li>
            </g:elseif>
            <g:if test="${!totalContributions.empty}">
                <li><a href="#" class="" data-toggle="modal" data-target="#moveContributionModal">
                    Move Contributions
                </a></li>
             <li>   <a href="#" class="" data-toggle="modal" data-target="#reportModal">
                    Transaction Report
                </a></li>
            </g:if>
            </ul>
        </div>
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
                                <label class="text col-sm-3">First Name</label>
                                <div class="col-sm-9"> 
                                <input type="text" class="form-control contributioninput" name="contributorName1"><br>
                                </div>
                            </div>
                        </div>
                         <div class="col-sm-12">
                            <div class="form-group">
                                <label class="text col-sm-3">Last Name</label>
                                <div class="col-sm-9"> 
                                <input type="text" class="form-control contributioninput" name="contributorLastName"><br>
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
                                <label class="text col-sm-3">Amount</label>
                                <div class="col-sm-9"> 
                                <input type="text" class="form-control contributioninput" name="amount1" id="offlineAmount1"><br>
                                </div>
                            </div>
                            <div id="errormsg1"></div>
                        </div>
                        <g:if test="${ (project.paypalEmail && project.citrusEmail) || (project.paypalEmail && project.payuEmail)}">
                        <div class="col-sm-12">
                            <div class="form-group">
                                <label class="text col-sm-3">Currency</label>
                                <div class="col-sm-3"> 
                                    <select name="currency" class="selectpicker form-control" >
                                        <option value="INR">INR</option>
                                        <option value="USD">USD</option>
                                    </select>
                                </div>
                            </div>
                        </div>
                        </g:if>
<%--                        <g:elseif test="${project.payuStatus == true}">--%>
<%--                            <input type="text" class="form-control" name="currency" value="INR" style="display: none;">--%>
<%--                        </g:elseif>--%>
                        <g:else>
                            <input type="text" class="form-control" name="currency" value="${project.country.currency.currency_code}" style="display: none;">
                        </g:else>
                        <g:if test="${isTaxReceipt}">
                            <div class="col-sm-12">
                                <div class="form-group">
		                            <label class="text col-sm-12">
		                                <input type="checkbox" name="isTaxreceipt" id="isTaxreceipt" > Do you want to provide tax receipt?
		                            </label>
		                        </div>
		                    </div>
		                    <div class="col-sm-12">
                                <div class="form-group">
                                <br/>
		                            <label class="text col-sm-3 pannumberdiv">
		                                PAN Number
                                    </label>
		                            <div class="col-sm-9 pannumberdiv">
		                                <input class="form-control" id="panNumber" name="panNumber" type="text" placeholder="Enter PAN Number" maxlength="10"/>
		                            </div>
		                        </div>
		                    </div>
                        </g:if>
                        
                        <div class="clear"></div>
                    </div>
                    <div class="clear"></div>
                    <div class="modal-footer">
                        <button data-dismiss="modal" class="btn btn-primary pull-left">Close</button>
                        <button class="btn btn-primary pull-right" type="submit" id="saveButton">Save</button>
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
                <div class="dl">
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
                                    <th class="text-center">CURRENCY</th>
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
								        def currency = contributions?.currency
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
										<td class="text-center">${currency}</td>
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
                </div>
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
                </div>
                <div class="modal-body">
                    <div class="col-sm-12">
                        <div class="form-group">
                            <label class="text col-sm-3 moveContribution"><b>From:</b></label>
                            <div class="col-sm-9"> 
                                 <g:select from="${enableTeamNames}" class="form-control fundRaiserTeam" name="fundRaiserTeam" noSelection="['':'Move contribution from']" optionKey="key" optionValue="value"/><br>
                            </div>
                        </div>
                    </div>
                    <div class="col-sm-12">
                        <div class="form-group">
                            <label class="text col-sm-3 moveContribution"><b>To:</b></label>
                            <div class="col-sm-9"> 
                            <g:select from="${teamNames}" class="form-control fundRaiserTeam2" name="fundRaiserTeam2" noSelection="['':'Move contribution to']" optionKey="key" optionValue="value"/><br>
                           </div>
                        </div>
                    </div>
                    <div class="col-sm-12">
                        <div class="form-group">
                            <label class="text col-sm-3 moveContribution"><b>Contribution:</b></label>
                            <div class="col-sm-9"> 
                             <g:select from="" class="form-control" name="contributiondetailId" id="contributiondetailId" noSelection="['':'Select Contribution Detail']"/><br>
                           </div>
                        </div>
                    </div>
                    <%--<div class="col-sm-12">
                        <div class="form-group">
                            <label class="text col-sm-3 moveContribution">Contribution(<g:if test="${project.payuStatus}"><span class="fa fa-inr"></span></g:if><g:else>$</g:else>)</label>
                            <div class="col-sm-9">
                                <g:select from="" class="form-control contributionAmount" name="contributionAmount" id="contributionAmt" noSelection="['':'Contribution']"/><br>
                            </div>
                        </div>
                    </div>
                    --%>
                    <div class="clear"></div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default btn-md" data-dismiss="modal">Close</button>
                    <button  class="btn btn-primary btn-md" id="btnMove">Move</button>
                </div>
            </div>
        </g:form>
    </div>
</div>
