<!-- Contributions -->
<g:set var="userService" bean="userService"/>
<g:set var="facebookService" bean="facebookService"/>
<g:set var="projectService" bean="projectService" />
<%@ page import="java.text.SimpleDateFormat" %>
<%
    SimpleDateFormat dateFormat = new SimpleDateFormat("MMM d");
    List list = []
    if(project.user == team.user) {
        list = project.contributions
    }else {
        list = team.contributions
    }
    def user = userService.getCurrentUser()
    def isCampaignOwnerOrAdmin
    def fundRaiser
    def CurrentUserTeam
    if (user != null) {
        isCampaignOwnerOrAdmin = userService.isCampaignBeneficiaryOrAdmin(project, user)
        CurrentUserTeam = userService.getTeamByUser(user, project)
        fundRaiser = user.username
    }
%>
<g:if test="${list.empty}">
    <div class="alert alert-info">No contributions yet. Yours can be the first one.</div>
</g:if>
<g:if test="${user && !isCampaignOwnerOrAdmin && CurrentUserTeam}">
    <g:if test="${team.user == user}">
        <a href="#" class="btn btn-primary btn-sm btn-circle pull-right" data-toggle="modal" data-target="#offlineContributionModal" model="['project': project]">
            Manage Offline Contribution
        </a>
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
                            <p class="justify text-paragraph">If your friends donate by check or hand you a pile of cash or a stack of casino chips,
                                you can enter their name and donation amount below and the donor will show up in your donations scroll and everyone will be happy.
                                If you want to enter checks in bulk, just make the Display Name say something like "Offline Donations."
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
                        <div class="col-sm-8">
                            <div class="form-group">
                                <label class="text" for="title">Display Name</label>
                                <input type="text" class="form-control contributioninput" name="contributorName2"/>
                            </div>
                        </div>
                        <div class="col-sm-4">
                            <div class="form-group">
                                <label for="title" class="text">Amount</label>
                                <input type="text" class="form-control contributioninput" name="amount2" id="offlineAmount2"/>
                            </div>
                            <div id="errormsg2"></div>
                        </div>
                        <div class="clear"></div>
                        <div class="col-sm-8">
                            <div class="form-group">
                                <label class="text" for="title">Display Name</label>
                                <input type="text" class="form-control contributioninput" name="contributorName3"/>
                            </div>
                        </div>
                        <div class="col-sm-4">
                            <div class="form-group">
                                <label for="title" class="text">Amount</label>
                                <input type="text" class="form-control contributioninput" name="amount3" id="offlineAmount3"/>
                            </div>
                            <div id="errormsg3"></div>
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
</g:if>
<g:if test="${!list.empty}">
    <dl class="dl">
        <g:each in="${list}" var="contribution">
            <%
                def date = dateFormat.format(contribution.date)
                def friendlyName = userService.getFriendlyName(contribution.user)
                def isFacebookUser = userService.isFacebookUser(contribution.user)
                def userFacebookUrl = facebookService.getUserFacebookUrl(contribution.user)
                def amount = projectService.getDataType(contribution.amount)
            %>
            <g:if test="${!contribution.isContributionOffline}">
                <dt>$${amount}</dt>
                <g:if test="${isFacebookUser}">
                    <dd>By <a href="${userFacebookUrl}">${friendlyName}</a>, on ${date}</dd>
                </g:if>
                <g:else>
                    <dd>By ${friendlyName}, on ${date}</dd>
                </g:else>
                <hr>
            </g:if>
            <g:else>
                <dt>Offline Contribution</dt>
                <dt>$${amount}</dt>
                <dd>By ${contribution.contributorName}, on ${date}</dd>
                <hr>
            </g:else>
        </g:each>
    </dl>
</g:if>
