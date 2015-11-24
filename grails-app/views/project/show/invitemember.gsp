<%@ page contentType="text/html;charset=UTF-8" %>
<%
	def request_url=request.getRequestURL().substring(0,request.getRequestURL().indexOf("/", 8))
	def base_url = (request_url.contains('www')) ? grailsApplication.config.crowdera.BASE_URL1 : grailsApplication.config.crowdera.BASE_URL
 %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1"/>
<meta name="layout" content="main"/>
<r:require modules="projectshowjs"/>
</head>
<body>
  <div class="feducontent body bg-color">
  	<div class="container  feedback-container">
  		<input type="hidden" id="b_url" value="<%=base_url%>" />
  		<g:if test="${flash.contact_message}">
             <div class="alert alert-danger" align="center">
                 ${flash.contact_message}
             </div>
        </g:if>
  		<div class="row bg-color-white">
  			<div class="col-sm-12" id="inviteTeamMember">
	  			<g:form	controller="project" action="inviteTeamMember" id="${project.id}"  class="inviteTeamMember">
	  				<g:hiddenField name="amount" value="${project.amount}"/>
                    <div class="form-group">
                        <label>Name</label>
                        <input type="text" class="form-control all-place" name="username" value="${username}" placeholder="Name"/>
                    </div>
                    <div class="form-group">
                    	<div><label>Add to contacts</label></div>
                    	<div class="socialImg" style="display:inline-flex;">
                    		<a href="#"><img class="constantContact img-responsive" alt="Constantcontact" src="//s3.amazonaws.com/crowdera/assets/show-e-mail-light-gray.png"></a>&nbsp;
                    		<a href="#"><img class="gmailContact img-responsive" alt="Gmail" src="//s3.amazonaws.com/crowdera/assets/show-google-gray.png"></a>
                    	</div>
                    	<g:if test="${email}">
                    		<div class="row divSocialContacts">
                    		    <input type="hidden" name="socialProvider" class="socialProvider" value="${provider}">
                    		    <div class="col-md-4 socialContactDiv">
                    			    <input type="text" class="form-control all-place socialContact" name="socialContact" id="socialContact" placeholder="Contact" value="${email}"/>
                    		    </div>
                    		    <div class="col-md-2">
                    			    <button type="button" class="btn btn-default btn-info btn-sm center-block btnSocialContacts" id="btnSocialContactss">Import Contacts</button>
                    		    </div>
                    	    </div>
                    	</g:if>
                    	<g:else>
                    		<div class="row divSocialContact">
                    		    <input type="hidden" name="socialProvider" class="socialProvider">
                    		    <div class="col-md-4 socialContactDiv">
                    			    <input type="text" class="form-control all-place socialContact" name="socialcontact"  placeholder="Contact" id="socialContacts"/>
                    		    </div>
                    		    <div class="col-md-2">
                    			    <button type="button" class="btn btn-default btn-info btn-sm center-block btnSocialContacts" id="btnSocialContacts">Import Contacts</button>
                    		    </div>
                    	    </div>
                    	</g:else>
                    </div>
                    <g:if test="${contactList}">
                    	<div class="form-group">
                            <label>Email ID's (separated by comma)</label>
                            <textarea class="form-control all-place" name="emailIds" rows="4" placeholder="Email ID's" id="contactlist">${contactList}</textarea>
                        </div>
                    </g:if>
                    <g:else>
                    	<div class="form-group">
                            <label>Email ID's (separated by comma)</label>
                            <textarea class="form-control all-place" name="emailIds" rows="4" placeholder="Email ID's" ></textarea>
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