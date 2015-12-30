<div class="col-lg-offset-2 col-lg-8 col-md-offset-1 col-md-10 col-sm-offset-0 col-sm-12 col-xs-12" id="invite-campaign-owner">
    <g:form action="invite" controller="user">
        <h4 class="green-heading"><b>Recipient Email ID's</b></h4>
        <div class="form-group">
            <label><b>Your Name</b></label> 
            <input type="text" class="form-control all-place" name="name" placeholder="Name" value="${user.firstName}"/>
        </div>
        <div class="form-group">
        <div><label><b>Add to contacts</b></label></div>
        <div class="socialContactsImg">
            <a href="#"><img class="constantContact img-responsive" alt="Constantcontact" src="//s3.amazonaws.com/crowdera/assets/constantcontact-icon.png"></a>&nbsp;
            <a href="#"><img class="gmailContact img-responsive" alt="Gmail" src="//s3.amazonaws.com/crowdera/assets/show-original-google-color.png"></a>
            <a href="#"><img class="mailchimpContact img-responsive" alt="Mailchimp" src="//s3.amazonaws.com/crowdera/assets/mailchimp.png"></a>
            <g:if test="${ currentEnv=='test' || currentEnv=='development'}">
             <a href="#"><img class="facebookContact img-responsive" alt="Facebook" src="//s3.amazonaws.com/crowdera/assets/contribution-fb-share.png"></a>
             <a href="#"><img class="csvContact img-responsive" alt="CSV" src="//s3.amazonaws.com/crowdera/assets/csv-icon.png"></a>
            </g:if>
        </div>
        <g:if test="${email}">
             <div class="row divSocialContacts">
                 <input type="hidden" name="socialProvider" class="socialProvider" value="${provider}">
                 <div class="col-md-6 socialContactDiv">
                     <input type="text" class="form-control all-place socialContact" name="socialContact" id="socialContact" placeholder="Email" value="${email}"/>
                 </div>
                 <div class="col-md-2">
                      <button type="button" class="btn btn-default btn-info btn-sm center-block btnSocialContacts" id="btnSocialContactss">Import Contacts</button>
                 </div>
             </div>
         </g:if>
         <g:else>
             <div class="row divSocialContact">
                 <input type="hidden" name="socialProvider" class="socialProvider">
                 <div class="col-md-6 socialContactDiv">
                     <input type="text" class="form-control all-place socialContact" name="socialcontact"  placeholder="Email" id="socialContacts"/>
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
            <label><b>Email ID's (separated by comma)</b></label>
            <textarea class="form-control all-place" name="emails" rows="4" placeholder="Email ID's"></textarea>
        </div>
     </g:else>
        <div class="form-group">
            <label><b>Message (Optional)</b></label>
            <textarea class="form-control all-place" name="message" rows="4" placeholder="Message"></textarea>
        </div>
        <g:if test="${!isAdmin}">
            <button type="submit" class="btn btn-primary pull-right hidden-xs" id="btnSendinvitation">Invite</button>
            <button type="submit" class="btn btn-block btn-sm btn-primary visible-xs" id="mobBtnSendinvitation">Invite</button>
        </g:if>
    </g:form>
</div>
