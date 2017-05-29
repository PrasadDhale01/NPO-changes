<%@ page contentType="text/html;charset=UTF-8" %>
<g:set bean="projectService" var="projectService"/>
<%
	def request_url=request.getRequestURL().substring(0,request.getRequestURL().indexOf("/", 8))
	def base_url = (request_url.contains('www')) ? grailsApplication.config.crowdera.BASE_URL1 : grailsApplication.config.crowdera.BASE_URL
	def currentEnv = projectService.getCurrentEnvironment()
%>
<html>
    <head>
        <title>Crowdera- InviteMember</title>
        <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1"/>
        <meta name="layout" content="main"/>
        <r:require modules="projectshowjs"/>
    </head>
    <body>
        <div class="feducontent body bg-color">
            <div class="container  feedback-container">
                <input type="hidden" id="b_url" value="<%=base_url%>" />
                <g:if test="${flash.contact_message}">
                    <div class="alert alert-danger" align="center">${flash.contact_message}</div>
                </g:if>
            <div class="row bg-color-white">
                <div class="col-sm-12" id="inviteTeamMember">
                    <g:form	controller="project" action="inviteTeamMember" id="${project.id}"  method="POST" class="inviteTeamMember">
                        <g:hiddenField name="amount" value="${project.amount}"/>
                        <g:hiddenField name="ismanagepage" value="managepage" />
                        <div class="form-group">
                            <label>Name</label>
                           <input type="text" class="form-control all-place" name="username" value="${user.firstName +' '+ user.lastName}" placeholder="Name">
                        </div>
                        <div class="form-group">
                            <div><label>Add to contacts</label></div>
                            <div class="socialContactsImg">
                                <a href="#"><img class="constantContact <g:if test='${provider=="constant"}'> highlightIcon </g:if> img-responsive" alt="Constantcontact" src="//s3.amazonaws.com/crowdera/assets/constantcontact-icon.png"></a>&nbsp;
                                <a href="#"><img class="gmailContact <g:if test='${provider=="google"}'> highlightIcon </g:if> img-responsive" alt="Gmail" src="//s3.amazonaws.com/crowdera/assets/show-original-google-color.png"></a>
                                <a href="#"><img class="mailchimpContact <g:if test='${provider=="mailchimp"}'> highlightIcon </g:if> img-responsive" alt="MailChimp" src="//s3.amazonaws.com/crowdera/assets/mailchimp.png"></a>
                                <g:if test="${ currentEnv=='test' || currentEnv=='development'}">
<%--                                    <a href="#"><img class="facebookContact <g:if test='${provider=="facebook"}'> highlightIcon </g:if> img-responsive" alt="Facebook" src="//s3.amazonaws.com/crowdera/assets/contribution-fb-share.png"></a>--%>
                                    <a href="#"><img class="csvContact  img-responsive" alt="CSV" src="//s3.amazonaws.com/crowdera/assets/csv-icon.png"></a>
                                </g:if>
                            </div>
                            <g:if test="${email}">
                                <div class="row divSocialContact">
                                    <input type="hidden" name="socialProvider" class="socialProvider" value="${provider}">
                                     <div class="col-sm-6 socialContactDiv">
                                         <input type="text" class="form-control all-place socialContact" name="socialContact" id="socialContact" placeholder="Email" value="${email}">
                                     </div>
                                     <div class="col-sm-2">
                                         <button type="button" class="btn btn-default btn-info btn-sm pull-right btnSocialContacts" id="btnSocialContactss">Import Contacts</button>
                                      </div>
                                </div>
                                <div class="row divCSVContacts">
                                    <div class="upload" >
                                        <div class="col-sm-8">
                                            <div class="input-group">
                                                <span class="input-group-btn">
                                                    <span class="btn btn-info btn-file">
                                                        Browse<input type="file" name="filecsv" id="csvfile"  accept=".csv"  class="filecsv">
                                                    </span>
                                                </span>
                                                <input type="text" class="form-control csvFile" placeholder="filename" readonly>
                                            </div>
                                        </div>
                                        <div class="col-sm-2">
                                            <input type="button" value="Import"  class="btn btn-default btn-info btn-sm pull-right  csvbtn" />
                                        </div>
                                    </div>
                                    <div class="csv-empty-emails col-sm-12">Email(s) not found</div>
                                </div>
                            </g:if>
                            <g:else>
                                <div class="row divSocialContact">
                                    <input type="hidden" name="socialProvider" class="socialProvider">
                                    <div class="col-sm-6 socialContactDiv">
                                        <input type="text" class="form-control all-place socialContact" name="socialcontact"  placeholder="Email" id="socialContacts">
                                    </div>
                                    <div class="col-sm-2">
                                        <button type="button" class="btn btn-default btn-info btn-sm pull-right btnSocialContacts" id="btnSocialContacts">Import Contacts</button>
                                    </div>
                                 </div>
                                 <div class="row divCSVContacts">
                                     <div class="upload" >
                                         <div class="col-sm-8">
                                             <div class="input-group">
                                                 <span class="input-group-btn">
                                                     <span class="btn btn-info btn-file">
                                                         Browse<input type="file" name="filecsv" id="csvfile"  accept=".csv"  class="filecsv">
                                                      </span>
                                                 </span>
                                                 <input type="text" class="form-control csvFile" placeholder="filename" readonly>
                                             </div>
                                         </div>
                                         <div class="col-sm-2">
                                             <input type="button" value="Import"  class="btn btn-default btn-info btn-sm pull-right  csvbtn"/>
                                         </div>
                                     </div>
                                     <div class="csv-empty-emails col-sm-12">Email(s) not found</div>
                                 </div>
                             </g:else>
                         </div>
                         <g:if test="${contactList}">
                             <div class="form-group">
                                 <label>Email ID's (separated by comma)</label>
                                 <textarea class="form-control all-place contactlist" name="emailIds" rows="4" placeholder="Email ID's" id="contactlist">${contactList}</textarea>
                             </div>
                         </g:if>
                         <g:else>
                             <div class="form-group">
                                 <label>Email ID's (separated by comma)</label>
                                 <textarea class="form-control all-place contactlist" name="emailIds" rows="4" placeholder="Email ID's" ></textarea>
                             </div>
                         </g:else>
                         <div class="form-group">
                             <label>Message (Optional)</label>
                             <textarea class="form-control all-place" name="teammessage" rows="4" placeholder="Message"></textarea>
                         </div>
                         <div class="submitbtn">
                             <button class="btn btn-default btn-info center-block" id="btnSendInvitation">Send Invitation</button>
                         </div>
                     </g:form>
                 </div>
             </div>
         </div>
         <div id="test"></div>
     </div>
 </body>
</html>
