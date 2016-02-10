<%@ page import="java.text.SimpleDateFormat" %>
<g:set var="contributionService" bean="contributionService"/>
<g:set var="projectService" bean="projectService"/>

<div class="<g:if test="${!project.validated || project.projectUpdates.empty}">col-md-12</g:if><g:else>col-md-offset-2 col-md-8</g:else> col-sm-12 col-xs-12">
    <g:if test="${project.validated}">
    <%--<g:if test="${ended}">
	    	<div class="alert alert-info">Campaign Ended.</div>
	    </g:if>--%>
	    <g:if test="${project.projectUpdates.empty}">
		    <g:if test="${!ended}">
		    	<div class="alert alert-info">No updates yet.</div>
		    </g:if>
		</g:if>
        <g:uploadForm class="form-horizontal" controller="project" action="projectupdate" params="['projectTitle':vanityTitle]">
            <button type="submit" class="btn btn-sm btn-primary pull-right" name="button" value="draft"><i class="fa fa-plus-circle"></i> Create Update</button>
        </g:uploadForm>
	    <div class="clear"></div>
		
		<g:if test="${!project.projectUpdates.empty}">
		    <%
		        def projectUpdates = project.projectUpdates.reverse()
		        def i = projectUpdates.size()
		        def count = projectUpdates.size()
			    def rows = projectUpdates.size()
			    def index = 0
			%>
		    <g:each in="${(1..rows).toList()}" var="row">
			    <div class="col-md-12 col-sm-12 col-xs-12 campaignupdate">
	                <% if (index < count) { %>
	                    <g:render template="/project/manageproject/campaigngrid" model="['projectUpdate': projectUpdates.get(index++), 'manageProject':'manageProject','i': i--]"></g:render>
                       
                    <% } %>
			    </div>
			</g:each>
		</g:if>
	</g:if>
	<g:else>
	        <div class="alert alert-info">You can post updates after the campaign is published.</div>
	</g:else>
	
	<div class="col-sm-12">
    <%--  Modal --%>
    <div class="modal fade" id="updatesendmailmodal" tabindex="-1" role="dialog" aria-hidden="true">
        <g:form action="sendupdateemail" id="${project.id}" class="sendMailFormMng">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal">
                            <span aria-hidden="true">&times;</span><span class="sr-only">Close</span>
                        </button>
                        <h4 class="modal-title">Recipient Email ID's</h4>
                    </div>
                    <div class="modal-body">
                        <g:hiddenField name="amount" value="${project.amount}" />
                        <g:hiddenField name="ismanagepage" value="managepage" />
                        <g:hiddenField name="fr" value="${fundRaiser}" />
                        <g:hiddenField name="vanityTitle" value="${vanityTitle}"/>
                        <g:hiddenField name="projectUpdateId"/>
                        
                        <div class="form-group">
                            <label>Your Name</label> <input type="text" class="form-control all-place" name="name" placeholder="Name">
                        </div>
                        <div class="form-group">
                            <label>Email ID's (separated by comma)</label>
                            <textarea class="form-control all-place" name="emails" rows="4" placeholder="Email ID's"></textarea>
                        </div>
                        <div class="form-group">
                            <label>Message (Optional)</label>
                            <textarea class="form-control all-place" name="message" rows="4" placeholder="Message"></textarea>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="submit" class="btn btn-primary btn-block" id="btnSendMailMng">Send Email</button>
                    </div>
                </div>
            </div>
        </g:form>
    </div>
</div>
	</div>
