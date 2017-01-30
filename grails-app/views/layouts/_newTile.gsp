<%@ page import="java.text.SimpleDateFormat" %>
<g:set var="contributionService" bean="contributionService"/>
<g:set var="projectService" bean="projectService"/>
<g:set var="userService" bean="userService"/>
<%
     SimpleDateFormat dateFormat = new SimpleDateFormat("MMM d");
     def percentage = project.percentage
    def cents
    if(percentage >= 100) {
        cents = 100
    } else {
        cents = percentage
    }
    def userImageUrl = project.user.userImageUrl
      def uri = request.forwardURI
%>
<g:if test="${project.validated}">
    <div class="fedu thumbnail grow tile-pad">
        <g:hiddenField name="projectId" class="projectId" id="projectId" value="${project.id}"/>
        <div class="card col-lg-12 card-dis">

             <g:if test="${!project.isAdminOrBeneficiary}">
                <g:if test="${project.enable==false}">
                    <div class="show-tile-dis teamtile-banner">
                        <img src="//s3.amazonaws.com/crowdera/assets/Disabled-tag.png" alt="diabledTeam">
                    </div>
                </g:if>
                <g:else>
                    <div class="show-tile-dis teamtile-banner">
                        <img src="//s3.amazonaws.com/crowdera/assets/Team-tag.png" alt="team">
                    </div>
                </g:else>
            </g:if>
            <g:elseif test="${project.isCampaignAdminByUser}">
                <g:if test="${project.enable==false}">
                    <div class="show-tile-dis teamtile-banner">
                        <img src="//s3.amazonaws.com/crowdera/assets/Disabled-tag-tag.png" alt="diabledTeam">
                    </div>
                </g:if>
                <g:else>
                    <div class="show-tile-dis teamtile-banner">
                        <img alt="co-owner" src="//s3.amazonaws.com/crowdera/assets/Co-owner-tag.png">
                    </div>
                </g:else>
            </g:elseif>
            <g:else>
                <div class="show-tile-dis teamtile-banner">
                    <!-- <img src="//s3.amazonaws.com/crowdera/assets/owner-tag.png" alt="owner">-->
                </div>
            </g:else>

            <div class="blacknwhite tile">
                <div class="authors-container">
                    <div class="author">
<%--                        <g:link class="card-user account-photo  account-product-owner" controller="project" action="showCampaign" id="${project.projectId}" title="${project.projectTitle}" params="['fr': project.projectOwner]">--%>
                        <g:link class="card-user account-photo  account-product-owner" mapping="showCampaign" params="[country_code:project.countryCode.toLowerCase(),projectTitle:project.title,fr:project.username,category:project.fundsRecievedBy.toLowerCase()]">
                            <div class="mask">
                                 <div class="dis-supported-the">
                                    <g:if test="${project.campaignOwnerId != project.user?.id}">
	                                     SUPPORTING<br>
	                                     <g:if test="${project.organizationName}">
	                                         ${project.organizationName}
	                                     </g:if>
                                     </g:if>
                                 </div>

                                <g:if test="${project.user}">
                                    <g:if test="${userImageUrl}">
                                        <img class="img-responsive img-circle discover-avtar-image" src="${userImageUrl}" alt="Thumb">
                                    </g:if>
                                    <g:else>
                                        <img class="user-img-header img-responsive img-circle user-discover-img" src="${project.alphabet.userImage}" alt="user alphabet icon">
                                    </g:else>
                                    <div class="discover-user-name">
                                        Campaign by<br>${project.user?.firstName} ${project.user?.lastName}
                                    </div>
                                </g:if>
                            </div>
                         </g:link>

                    </div>
                </div>
                <g:link mapping="showCampaign" params="[country_code:project.countryCode.toLowerCase(),projectTitle:project.title,fr:project.username,category:project.fundsRecievedBy.toLowerCase()]">

                    <img class="project-img" src="${project.imageLink}" alt="thumbnail">
                </g:link>
            </div>
    </div>


        <div class="caption tile-title-descrp project-title project-story-span tile-min-height">

            <g:link  mapping="showCampaign" params="[country_code:project.countryCode.toLowerCase(),projectTitle:project.title,fr:project.username,category:project.fundsRecievedBy.toLowerCase()]">
                ${project.title.toUpperCase()}
            </g:link>
            <div class="campaign-title-margin-bottom"></div>
            <span>${project.description}</span>
        </div>

        <div class="modal-footer tile-footer tile-fonts-footer">
            <div class="row">
                <div class="col-xs-4 col-sm-4 col-md-4 goalIcon">
                    <img src="//s3.amazonaws.com/crowdera/assets/tile-goal-icon.png" alt="tile-goal">
                </div>
                <div class="col-xs-4 col-sm-4 col-md-4 campaign-tile-border daysleftIcon">
                    <img src="//s3.amazonaws.com/crowdera/assets/timeleft.png" alt="timeleft">
                </div>
                <div class="col-sm-4 col-md-4 col-xs-4 progress-pie-chart show-tile progressBarIcon " data-percent="43">
                    <div class="c100 p${cents} small text-center">
                        <span>${percentage}%</span>
                        <div class="slice">
                            <div class="bar showprogressBar"></div>
                            <div class="fill showprogressBar"></div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="row tilepadding">
<%--                <div class="col-xs-4 col-sm-4 col-md-4 amount-alignment amount-text-align text-center">--%>
<%--                    <span class="text-center tile-goal">--%>
<%--                        <g:if test="${currentEnv == 'testIndia' || currentEnv == 'stagingIndia' || currentEnv == 'prodIndia'}">--%>
<%--                            <span class="fa fa-inr"></span><g:if test="${project.payuStatus}"><span class="lead">${project.amount}</span></g:if><g:else><span class="lead">${project.amount * project.multiplier}</span></g:else>--%>
<%--                        </g:if>--%>
<%--                        <g:else>--%>
<%--                            $<span class="lead">${project.amount}</span>--%>
<%--                        </g:else>--%>
<%--                    </span>--%>
<%--                </div>--%>
			<div class="col-xs-4 col-sm-4 col-md-4 amount-alignment amount-text-align text-center">
                <span class="text-center tile-goal">
                    <g:if test="${country_code == 'in'}">
                        <!-- <span class="fa fa-inr"></span>-->
                        ${project.currencyValue}
                        <g:if test="${project.payuStatus}">
                        	<span class="lead">${project.amount}</span>
                        </g:if>
                        <g:else>
                        	<span class="lead">${project.amount}</span>
                        </g:else>
                    </g:if>
                    <g:else>
                        ${project.currencyValue}<span class="lead">${project.amount}</span>
                    </g:else>
                </span>
            </div>
                <g:if test="${project.ended}">
                    <div class="col-md-4 col-sm-4 col-xs-4 show-tile-text-size campaign-tile-border">
                        <span class="days-alignment">DAYS<br>LEFT</span>
                        <span class="tile-day-num">00</span>
                    </div>
                </g:if>
                <g:else>
                    <!-- Time left till end date. -->
                    <div class="col-md-4 col-sm-4 col-xs-4 show-tile-text-size campaign-tile-border">
                        <span class="days-alignment">DAYS<br>LEFT</span>
                        <g:if test="${project.remainingDay > 0 && project.remainingDay < 10 }">
                            <span class="tile-day-num">0${project.remainingDay}</span>
                        </g:if>
                        <g:else>
                            <span class="tile-day-num">${project.remainingDay}</span>
                        </g:else>
                    </div>
                </g:else>
<%--                <div class="col-md-4 col-xs-4 amount-alignment amount-text-align text-center">--%>
<%--                    <span class="text-center tile-goal">--%>
<%--                        <g:if test="${currentEnv == 'testIndia' || currentEnv == 'stagingIndia' || currentEnv == 'prodIndia'}">--%>
<%--                            <span class="fa fa-inr"></span><g:if test="${project.payuStatus}"><span class="lead">${project.contributions.round()}</span></g:if><g:else><span class="lead">${(project.contributions * project.multiplier).round()}</span></g:else>--%>
<%--                        </g:if>--%>
<%--                        <g:else>--%>
<%--                            $<span class="lead">${project.contributions.round()}</span>--%>
<%--                        </g:else>--%>
<%--                    </span>--%>
<%--                </div>--%>
			<div class="col-md-4 col-xs-4 amount-alignment amount-text-align text-center">
                <span class="text-center tile-goal">
                    <g:if test="${project.countryCode.toLowerCase() == 'in'}">
                    	<g:if test="${project.contributions == null}">
                        	${project.currencyValue}<span class="lead">0</span>
                        </g:if>
                        <g:else>
	                       ${project.currencyValue}
	                        <g:if test="${project.payuStatus}">
	                        	<span class="lead">${project.contributions.round()}</span>
	                        </g:if>
	                        <g:else>
	                        	<span class="lead">${project.contributions.round()}</span>
	                        </g:else>
	                     </g:else>  
                    </g:if>
                    <g:else>
                    	<g:if test="${project.contributions == null}">
                        	${project.currencyValue}<span class="lead">0</span>
                        </g:if>
                         <g:else>
                         	${project.currencyValue}<span class="lead">${project.contributions.round()}</span>
                         </g:else>
                    </g:else>
                </span>
            </div>
            </div>
        </div>
    </div>
</g:if>

