<g:set var="projectService" bean="projectService"/>
<g:set var="projectValidate" value="${projects.validated}"/>

<% if (projectValidate == false) { %>
    <div class="fedu thumbnail grow" style="padding: 0" align:left>
        <div style="height: 200px; overflow: hidden;" class="blacknwhite">
            <g:link controller="project" action="validateshow" id="${projects.id}" title="${projects.title}">
                <img alt="${projects.title}" style="width: 100%; height: 100%;" src="${projectService.getProjectImageLink(projects)}">
            </g:link>
        </div>
	<div class="caption">
	    <h4><g:link controller="project" action="validateshow" id="${projects.id}" title="${projects.title}">${projects.title}</g:link></h4>
	    <p>${projectService.getBeneficiaryName(projects)}</p>
        </div>
	<div class="modal-footer" style="text-align: left; margin-top: 0;">
	    <div class="row">
	        <div class="col-md-3">
		    <h5 class="text-center">GOAL<br/><span class="lead">$${projects.amount}</span></h5>
	        </div>
	        <div class="col-md-3">
		    <h5 class="text-center">DAYS<br><span class="lead">${projects.days}</span></h5>
                </div>
	    </div>
	</div>
    </div>    
<%}%>