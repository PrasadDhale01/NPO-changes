<g:set var="projectService" bean="projectService" />
<%@ page import="java.text.SimpleDateFormat" %>
<%
    SimpleDateFormat dateFormat = new SimpleDateFormat("MMM d");
%>
<g:if test="${contributions.size() == 0}">
    <div class="center-block col-xs-12 userprfl-warning">
        You haven't contributed to any campaign yet. You can start contributing now.<br>
        <g:link controller="project" action="list" class="btn btn-default btn-sm btn-info">Contribute</g:link>
    </div>
</g:if>
<g:else>
    <ul class="timeline">
        <%
            def index = 0
        %>
        <g:each in="${contributions.reverse()}" var="contribution">
            <g:if test="${index++ % 2 == 0}">
                <li>
            </g:if>
            <g:else>
                <li class="timeline-inverted">
            </g:else>
                <div class="timeline-badge info hidden-xs"><i class="fa fa-credit-card"></i></div>
                <div class="timeline-panel">
                    <div class="timeline-heading">
                        <h4 class="timeline-title">Contributed : 
                          <b>
                              <g:if test="${environment=='testIndia' || environment=='stagingIndia' || environment=='prodIndia'}">
                                  <span class="fa fa-inr"></span>
                              </g:if>
                              <g:else>$</g:else>
                              ${projectService.getDataType(contribution.amount)}
                           </b>
                        </h4>
                        <p><small class="text-muted">
                            <i class="glyphicon glyphicon-time"></i> on ${dateFormat.format(contribution.date)}, towards
                        </small></p>
                    </div>
                    <div class="timeline-body">
                    	<g:link controller="project" action="showCampaign" id="${contribution.project.id}"  params="['fr':contribution.fundRaiser]" fragment="contributions">
	                    	<div class="row userprfl-cmpgn-container">
	                    		<div class="col-xs-4 usrPrfl-cmpgn-img">
	                    			<img class="img-responsive" src="${projectService.getProjectImageLink(contribution.project)}" alt="Campaign Image" >
	                    		</div>
	                    		<div class="col-xs-8 usrPrfl-cmpgn-title">
	                    			<p>${contribution.project.title}</p>
	                    		</div>
	                    	</div>
                    	</g:link>
                    </div>
                </div>
            </li>
        </g:each>
    </ul>
</g:else>
