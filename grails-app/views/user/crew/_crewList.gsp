<g:if test="${crews.status == false}">
<tr>
    <td>${index}</td>
    <td class="col-md-4 col-sm-4">${crews.firstName} ${crews.lastName}</td>
    <td class="col-md-4 col-sm-4">${crews.requestDate}</td>
    <td class="col-md-3 col-sm-3 text-center">
        <a href="#" class="btn btn-sm btn-primary" data-id="${crews}" data-toggle="modal" data-target="#crewRespond${crews.id}">View and Respond</a>
    </td>
    <td class="col-md-4 col-sm-4 text-center">
        <g:form action="discardDetails" controller="User" id="${crews.id}">
            <button class="btn btn-sm btn-danger" onclick="return confirm(&#39;Are you sure you want to discard this Applicant?&#39;);">Discard</button>
        </g:form>
    </td>    
</tr>
</g:if>
<g:else>
    <tr>
    <td>${index}</td>
    <td class="col-md-4 col-sm-4">${crews.firstName} ${crews.lastName}</td>
    <td class="col-md-4 col-sm-4">${crews.adminDate}</td>
    <td class="col-md-3 col-sm-3 text-center">
        <a href="#" class="btn btn-sm btn-primary" data-id="${crews}" data-toggle="modal" data-target="#crewResponded${crews.id}">View Details</a>
    </td>
    <td class="col-md-4 col-sm-4 text-center">
        <g:form action="discardDetails" controller="User" id="${crews.id}">
            <button class="btn btn-sm btn-danger" onclick="return confirm(&#39;Are you sure you want to discard this Applicant?&#39;);">Discard</button>
        </g:form>
    </td>    
</tr>
</g:else>

<!-- For Respond Modal -->
<div class="modal fade" id="crewRespond${crews.id}" tabindex="-1" role="dialog" aria-labelledby="servicemodal" aria-hidden="true">
    <g:uploadForm action="responseforCrews" controller="User" id="${crews.id}" role="form">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type"button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">close</span></button>
                    <h4 class="modal-title text-center"><b>Applicant Details</b></h4>
                </div>
                <div class="modal-body">
                    <div class="form-group">
                        <label for="crewsFirstName">Name</label>
                        <input type="text" class="form-control" name="crewFirstName" value="${crews.firstName} ${crews.lastName}"/>
                    </div>
                    <div class="form-group">
                        <label for="crews Email">Email</label>
                        <input type="text" class="form-control" name="crewEmail" value="${crews.email}"/>
                    </div>
                    <div class="form-group">
                        <label for="crews Phone">Phone</label>
                        <input type="text" class="form-control" name="crewPhone" value="${crews.phone}"/>
                    </div>
                    <div class="form-group">
                        <label for="crewDescription"><b>Description</b></label>
                        <div class="clear"></div>
                        <div class="innertext">${crews.crewDescription}</div>
                    </div>
                    <div class="form-group">
	                    <g:if test="${crews.resumeUrl}">
	                         <label for="resumeUrl"><b>Resume</b></label>
	                         <div class="clear"></div>
	                         <a href="${crews.resumeUrl}">${crews.resumeUrl}</a>
	                    </g:if>
	                    <g:else>
	                         <div class="outertext"><b>No Resume</b></div>
	                    </g:else>
                    </div>
                    <div class="form-group">
                         <g:if test="${crews.linkedIn}">
                              <label for="resumeUrl"><b>LinkedIn</b></label>
                              <div class="clear"></div>
                               <a href="${crews.linkedIn}" target="_blank">${crews.linkedIn}</a>
                         </g:if>     
                    </div>
                    <div class="form-group">
                         <g:if test="${crews.faceBook}">
                              <label for="resumeUrl"><b>Facebook</b></label>
                              <div class="clear"></div>
                               <a href="${crews.faceBook}" target="_blank">${crews.faceBook}</a>
                         </g:if>     
                    </div>
                    <div class="form-group">
                        <label for="crewsReply"><b>Response to Applicant</b></label>
                        <textarea class="form-control" name="adminReply" rows="4" placeholder="Response to Crew's Resume" required></textarea>
                    </div>
                    <div class="form-group">
                         <label>Attachment</label>
                         <div class="clear"></div>
                         <div class="col-xs-4 col-sm-4 col-md-4 upload-btn">
                             <div class="fileUpload btn btn-primary btn-sm">
                                 <span>Upload</span>
                                 <input type="file" class="upload " id="applicantfile" name="resume" accept="application/msword,application/pdf,.txt,.docx"/>
                             </div>
                         </div>
                         <div class="col-xs-8 col-sm-8 col-md-8">
                             <div id="applicantOutput"></div>
                         </div>
                         <div class="clear"></div>
                         <label class="docfile-orglogo-css" id="applicantfilesize"></label> 
                     </div>
                </div>
                <div class="modal-footer">
                    <button data-dismiss="modal" class="btn btn-modal">Close</button>
				    <button class="btn btn-modal" type="submit">Send</button>
                </div>
            </div>
        </div>
    </g:uploadForm>
</div>

<!-- Modal for Responded by admin -->
<div class="modal fade" id="crewResponded${crews.id}" tabindex="-1" role="dialog" aria-labelledby="servicemodal" aria-hidden="true">
     <div class="modal-dialog">
         <div class="modal-content">
             <div class="modal-header">
                 <button type"button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">close</span></button>
                 <h4 class="modal-title text-center"><b>Applicant Details</b></h4>
             </div>
             <div class="modal-body font-lab">
                 <div class="form-group">
                     <label for="Name"><b>Name:</b>&nbsp;&nbsp;</label>
                     <label for="Name">${crews.firstName} ${crews.lastName}</label>
                 </div>
                 <div class="form-group">
                     <label for="crews Email"><b>Email:</b>&nbsp;&nbsp;</label>
                     <label for="Name">${crews.email}</label> 
                 </div>
                 <div class="form-group">
                     <label for="crews Phone"><b>Phone:</b>&nbsp;</label>
                     <label for="Name">${crews.phone}</label> 
                 </div>
                 <div class="form-group">
                     <label for="crewDescription"><b>Description:</b></label>
                     <div class="clear"></div>
                     <div class="innertext">${crews.crewDescription}</div>
                 </div>
                 <div class="form-group">
                  <g:if test="${crews.resumeUrl}">
                       <label for="resumeUrl"><b>Resume</b></label>
                       <div class="clear"></div>
                       <a href="${crews.resumeUrl}">${crews.resumeUrl}</a>
                  </g:if>
                  <g:else>
                       <div class="outertext"><b>No Resume</b></div>
                  </g:else>
                 </div>
                 <div class="form-group">
                      <g:if test="${crews.linkedIn}">
                           <label for="resumeUrl"><b>LinkedIn</b></label>
                           <div class="clear"></div>
                            <a href="${crews.linkedIn}" target="_blank">${crews.linkedIn}</a>
                      </g:if>     
                 </div>
                 <div class="form-group">
                      <g:if test="${crews.faceBook}">
                           <label for="resumeUrl"><b>Facebook</b></label>
                           <div class="clear"></div>
                            <a href="${crews.faceBook}" target="_blank">${crews.faceBook}</a>
                      </g:if>     
                 </div>
                 <div class="form-group">
                     <label for="crewsReply"><b>Response to Applicant:</b></label>
                      <div class="clear"></div>
                     <label for="Name">${crews.adminReply}</label> 
                 </div>
                 <div class="form-group">
                  <g:if test="${crews.docByAdmin}">
                       <label for="Attachments"><b>Attachments by Admin</b></label>
                       <div class="clear"></div>
                       <a href="${crews.docByAdmin}">${crews.docByAdmin}</a>
                  </g:if>
                  <g:else>
                       <div class="outertext"><b>No Resume</b></div>
                  </g:else>
                 </div>
             </div>
             <div class="modal-footer">
                 <button type="button" class="btn btn-primary" data-dismiss="modal">close</button>
             </div>
         </div>
     </div>
</div>
