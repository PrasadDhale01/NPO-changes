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

<div class="row">
    <div class="fullwidth pull-right manage-edit-mobilebtns">
         <g:if test="${username.equals('campaignadmin@crowdera.co')}">
	         
             <a href="javascript:void(0)" onclick="submitCampaignShowForm('edit','${project.id}','${username}');" class="manage-edit-draft-left col-lg-6 col-md-6 col-sm-6 col-xs-6">
                 <span class="btn btn-default manage-btn-width manage-btn-back-color" aria-label="Edit project"><i class="fa fa-pencil-square-o edit-space"></i>EDIT
                 </span>
             </a>
             <g:form controller="project" action="projectdelete" method="post" id="${project.id}" class="col-lg-6 col-md-6 col-sm-6 col-xs-6 manage-btn-padding">
                 <button class="btn btn-danger manage-deletebtn-width" aria-label="Edit project" id="projectdelete" onclick="return confirm(&#39;Are you sure you want to discard this campaign?&#39;);">
                 <i class="fa fa-trash edit-space"></i>DELETE</button>
             </g:form>
         
         </g:if>
         <g:else>
         
             <g:if test="${!project.validated && percentage <= 999}">
                 <a href="javascript:void(0)" onclick="submitCampaignShowForm('edit','${project.id}','${username}');" class="manage-edit-draft-left col-lg-6 col-md-6 col-sm-6 col-xs-6">
                     <span class="btn btn-default manage-btn-width manage-btn-back-color"  aria-label="Edit project"><i class="fa fa-pencil-square-o edit-space"></i>EDIT
                     </span>
                 </a>
             </g:if>
             <g:if test="${!project.validated}">
                 <g:form controller="project" action="projectdelete" method="post" id="${project.id}" class="col-lg-6 col-md-6 col-sm-6 col-xs-6 manage-btn-padding">
                     <button class="btn btn-danger manage-deletebtn-width" aria-label="Edit project" id="projectdelete" onclick="return confirm(&#39;Are you sure you want to discard this campaign?&#39;);">
                     <i class="fa fa-trash edit-space"></i>DELETE</button>
                 </g:form>
             </g:if>
             
	         <g:if test="${project.validated && percentage <= 999}">
	             <a href="javascript:void(0)" onclick="submitCampaignShowForm('edit','${project.id}','${username}');" class="manage-edit-left">
	                 <span class="btn btn-default manage-btn-width-aft-validated manage-btn-back-color"  aria-label="Edit project" ><i class="fa fa-pencil-square-o edit-space"></i>EDIT CAMPAIGN
	                 </span>
	             </a>
	         </g:if>
	         
         </g:else>
    </div>
</div>

<div class="fedu grow managedetails-edit manage-tiletitile-top">
    <div class="modal-footer tile-footer tileanstitle-goals manage-tabs-width">
	    <div class="row icons-centering manage-tileIcons-width">
		    <div class="col-xs-4 col-sm-4 col-md-4 goalIcon">
			    <img src="//s3.amazonaws.com/crowdera/assets/tile-goal-icon.png" alt="goal-icon">
		    </div>
		    <div class="col-xs-4 col-sm-4 col-md-4 daysleftIcon">
                <img src="//s3.amazonaws.com/crowdera/assets/timeleft.png" alt="daysleft">
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
	    </div>
        <div class="row amount-centering manage-tileIcons-width">
            <div class="col-xs-4 col-sm-4 col-md-4 amount-alignment amount-text-align text-center manage-amt-tile-mobile">
                <span class="text-center tile-goal show-contribution-amt-tile">
                    <g:if test="${project.payuStatus}"><span class="fa fa-inr"></span></g:if><g:else>$</g:else><span class="lead show-contribution-amt-tile">${amount}</span>
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
        
            <div class="col-md-4 col-xs-4 amount-alignment amount-text-align text-center mange-contri-mobiletile">
                <span class="text-center tile-goal show-contribution-amt-tile">
                    <g:if test="${project.payuStatus}"><span class="fa fa-inr"></span></g:if><g:else>$</g:else><span class="lead show-contribution-amt-tile">${totalContribution}</span>
                </span>
            </div>
        
        </div>
    </div>
    
</div>
