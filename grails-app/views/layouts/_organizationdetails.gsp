<%
    def user = project.user
 %>
<g:set var="projectService" bean="projectService"/>
<g:set var="userService" bean="userService"/>
<div class="panel panel-default">
    <div class="panel-heading">
   		Campaign by
<%--        <g:if test="${isFundingOpen}">--%>
<%--            <h3 class="panel-title">Fund this project</h3>--%>
<%--        </g:if>--%>
<%--        <g:else>--%>
<%--            <h3 class="panel-title">Funding closed</h3>--%>
<%--        </g:else>--%>
    </div>
<%--<div class="blacknwhite" style="height: 100%; width: 100%; overflow: hidden; width: 100%;padding: 0; margin-top: 30px;">--%>
<%--	<label class="col-sm-12" style="margin-top:10px"><h3>Project By</h3></label>--%>
   	<div class="organization-details text-center">
   	<label class="col-sm-12"><h4><b>${project.organizationName}</b></h4></label>
   	<img alt="" src="${project.organizationIconUrl}" style="height:100px; width:100px; margin-left: 10px; border:2px">
    <label class="col-sm-12">WEB: <a href="${project.webAddress}">${project.webAddress}</a></label>
    <div class="clear"></div>
</div>
</div>
