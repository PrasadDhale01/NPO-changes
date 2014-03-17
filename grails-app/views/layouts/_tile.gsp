<%--
Expects the parent containers to be like so:
<div class="row">
    <ul class="thumbnails list-unstyled">
        ... /layouts/tile ...
    </ul>
</div>
--%>
<%@ page import="java.text.SimpleDateFormat" %>
<g:set var="contributionService" bean="contributionService"/>
<%
    def percentage = contributionService.getPercentageContributionForProject(it)

    def startDate = Calendar.instance
    startDate.setTime(it.created)

    def endDate = Calendar.instance
    endDate.setTime(it.created)
    endDate.add Calendar.DAY_OF_YEAR, it.days

    def today = Calendar.instance
    boolean ended = endDate.compareTo(today) < 0 ? true : false

    SimpleDateFormat dateFormat = new SimpleDateFormat("MMM d");
%>
<li class="col-xs-6 col-md-3">
    <div class="thumbnail" style="padding: 0">
        <div style="height: 200px; overflow: hidden;">
            <g:if test="${it.image}">
                <img alt="${it.title}" style="width: 100%;" src="${createLink(controller: 'project', action: 'thumbnail', id: it.id)}">
            </g:if>
            <g:else>
                <img style="width: 100%" src="http://lorempixel.com/300/250/abstract">
            </g:else>

        </div>

        <div class="caption">
            <h4><g:link controller="project" action="show" id="${it.id}" title="${it.title}"><div>${it.title}</div></g:link></h4>
            <p>${it.name}</p>
            <!-- <p><i class="icon icon-map-marker"></i>Place, Country</p> -->
        </div>

        <div class="modal-footer" style="text-align: left; margin-top: 0;">
            <div class="row">
                <div class="col-md-6"><b>${percentage}%</b><br/><small>FUNDED</small></div>
                <g:if test="${ended}">
                    <div class="col-md-6"><b>ENDED</b><br><small>${dateFormat.format(endDate.getTime())}</small></div>
                </g:if>
                <g:else>
                    <div class="col-md-6"><b>ENDING</b><br><small>${dateFormat.format(endDate.getTime())}</small></div>
                </g:else>
            </div>
        </div>
        <div class="progress">
            <div class="progress-bar progress-bar-success" role="progressbar" aria-valuenow="${percentage}" aria-valuemin="0" aria-valuemax="100" style="width: ${percentage}%;">
                <!-- <span class="sr-only">${percentage}% Complete</span> -->
                ${percentage}%
            </div>
        </div>
    </div>
</li>
