<%@ page import="java.text.SimpleDateFormat" %>
<g:set var="contributionService" bean="contributionService"/>
<g:set var="projectService" bean="projectService"/>
<g:set var="userService" bean="userService"/>
<%
    def amount = project.amount.round()
    def currentUser = userService.getCurrentUser()
    def username = currentUser.username
    SimpleDateFormat dateFormat = new SimpleDateFormat("MMM d");
    def cents
    if(percentage >= 100) {
        cents = 100
    } else {
        cents = percentage
    }
%>
<g:render template="/layouts/organizationdetails" model="['currentFundraiser':currentUser,'username':username]"/>
<div class="fedu thumbnail grow managedetails-edit">
    <div class="modal-footer tile-footer tileanstitle-goals">
	<div class="row icons-centering">
		<div class="col-xs-4 col-sm-4 col-md-4 goalIcon">
			<img src="//s3.amazonaws.com/crowdera/assets/goal-icon.png" alt="goal-icon">
		</div>
		<div class="col-xs-4 col-sm-4 col-md-4 progress-pie-chart show-contri-tile progressBarIcon" data-percent="43">
            <div class="c100  p${cents} pie-tile pie-css text-center mobile-pie">
                <span class="c999">${percentage}%</span>
                <div class="slice">
                    <div class="bar progressBar"></div>
                    <div class="fill progressBar"></div>
                </div>
            </div>
        </div>
		<div class="col-xs-4 col-sm-4 col-md-4 daysleftIcon">
			<img src="//s3.amazonaws.com/crowdera/assets/timeleft.png" alt="daysleft">
		</div>
	</div>
    <div class="row amount-centering">
        <div class="col-xs-4 col-sm-4 col-md-4 amount-alignment amount-text-align text-center">
            <span class="text-center tile-goal show-contribution-amt-tile">
                <g:if test="${project.payuStatus}"><span class="fa fa-inr"></span></g:if><g:else>$</g:else><span class="lead show-contribution-amt-tile">${amount}</span>
            </span>
        </div>
        <div class="col-md-4 col-xs-4 amount-alignment contribution-border amount-text-align text-center">
            <span class="text-center tile-goal show-contribution-amt-tile">
                <g:if test="${project.payuStatus}"><span class="fa fa-inr"></span></g:if><g:else>$</g:else><span class="lead show-contribution-amt-tile">${totalContribution}</span>
            </span>
        </div>
        
        <g:if test="${ended}">
            <div class="col-md-4 col-sm-4 col-xs-4 show-tile-text-size contribution-tile show-contribution-amt-tile">
                <span class="days-alignment show-contribution-amt-tile ">DAYS<br>LEFT</span>
                <span class="tile-day-num show-contribution-amt-tile ">00</span>
            </div>
        </g:if>
        <g:else>
            <!-- Time left till end date. -->
<%--            <div class="col-xs-4 col-sm-4 col-md-4 daysleft">--%>
<%--                <div class="col-xs-6 col-sm-6 col-md-6 daysleft days-text"><p class="tile-text-size">DAYS<br>LEFT</p></div>--%>
<%--                <div class="col-xs-6 col-sm-6 col-md-6 daysleft days-num"><h6 class="text-center"><span class="lead tab-amount">${day}</span></h6></div>--%>
<%--            </div>--%>
            <div class="col-md-4 col-sm-4 col-xs-4 show-tile-text-size contribution-tile show-contribution-amt-tile">
               <span class="days-alignment">DAYS<br>LEFT</span>
               <g:if test="${day > 0 && day < 10 }">
                  	<span class="tile-day-num show-contribution-amt-tile ">0${day}</span>
               </g:if>
               <g:else>
                  	<span class="tile-day-num show-contribution-amt-tile ">${day}</span>
               </g:else>
           </div>
        </g:else>
    </div>
    </div>
    <div class="modal-footer tile-footer managedetails-nine-nine">
        <div class="row">
            <div class="fullwidth pull-right">
                 <g:if test="${percentage <= 999}">
                     <g:link controller="project" action="editCampaign" method="post" id="${project.id}">
                         <button class="projectedit close"  aria-label="Edit project" id="editproject">
                             <i class="glyphicon glyphicon-edit" ></i>
                         </button>
                     </g:link>
                 </g:if>
                 <g:if test="${!project.validated || username.equals('campaignadmin@crowdera.co') }">
                     <g:form controller="project" action="projectdelete" method="post" id="${project.id}">
                         <button class="projectedit close" aria-label="Edit project" id="projectdelete" onclick="return confirm(&#39;Are you sure you want to discard this campaign?&#39;);">
                             <i class="glyphicon glyphicon-trash" ></i>
                         </button>
                     </g:form>
                 </g:if>
            </div>
        </div>
    </div>
</div>
