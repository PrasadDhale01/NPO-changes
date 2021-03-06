<tr>
	<td>${index}</td>
	<td class="col-md-2 col-sm-2">${service.customername}</td>
	<td class="col-md-2 col-sm-2">${service.email}</td>
    <td class="col-md-2 col-sm-2">${service.subject}</td>
    <td class="col-md-2 col-sm-2">${service.category}</td>
    <td class="col-md-1 col-sm-1">${service.date}</td>
    <td class="col-md-1 col-sm-1 text-center">
        <a href="#" class="btn btn-sm btn-primary" data-id="${service}" data-toggle="modal" data-target="#attachment${service.id}">View Details</a>
    </td>
    <td class="col-md-1 col-sm-1 text-center">
        <g:if test="${service.status == false}">
            <a href="#" class="btn btn-sm btn-primary" data-id="${service}" data-toggle="modal" data-target="#servicemodal${service.id}">Respond</a>
        </g:if>
        <g:else>
             <button class="btn btn-sm btn-default">Responded</button>
        </g:else>
    </td>
    <td class="col-md-1 col-sm-1">
        <g:form action="discardUserQuery" controller="user" id="${service.id}">
            <button class="btn btn-sm btn-danger" onclick="return confirm(&#39;Are you sure you want to discard this Query?&#39;);">Discard</button>
        </g:form>
    </td>
</tr>
<div class="modal fade customerServicehelp" id="servicemodal${service.id}" tabindex="-1" role="dialog" aria-labelledby="servicemodal" aria-hidden="true">
    <g:uploadForm action="response" controller="user" id="${service.id}" role="form">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
                    <h4 class="modal-title"><b>Response to User's Questions</b></h4>
                </div>
                <div class="modal-body">
                    <div class="form-group">
                        <label for="customername"><b>Customer Name</b></label>
                        <input type="text" class="form-control" name="customername" value="${service.customername}"/>
                    </div>
                    <div class="form-group">
                        <label for="emailId"><b>Customer Email Id</b></label>
                        <input type="text" class="form-control" name="emailId" value="${service.email}"/>
                    </div>
                    <div class="form-group">
                        <label for="question"><b>Question</b></label>
                        <input type="text" class="form-control" name="question" value="${service.subject}"/>
                    </div>
                    <div class="form-group">
                        <label for="answer"><b>Response to User's Question</b></label>
                        <textarea class="form-control" name="answer" rows="4" placeholder="Response to User's Question" required></textarea>
                    </div>
                    <div class="form-group attachment-group">
                        <label for="attachments"><b>Attachments</b></label>
                        <div class="clear"></div>
                        <div class="col-xs-12 col-sm-4 col-md-4">
                            <div class="fileUpload btn btn-primary btn-sm">
                                <span>Choose File</span>
                                <input type="file" class="upload" id="attachments" name="file"/>
                            </div>
                            <label class="docfile-orglogo-css" id="attachmentfilesize"></label>
                        </div>
                        <div class="col-xs-12 col-sm-8 col-md-8">
                            <output id="result"></output>
                        </div>
                    </div>
                    <div class="clear"></div>
                </div>
                <div class="modal-footer">
                    <button type="submit" class="btn btn-primary btn-block">Send Response</button>
                </div>
            </div>
        </div>
    </g:uploadForm>
</div>

<div class="row" id="customerservice">
    <div class="modal fade" id="attachment${service.id}" tabindex="-1" role="dialog" aria-labelledby="servicemodal" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
                    <h4 class="modal-title"><b>User Query Details</b></h4>
                </div>
                <div class="modal-body">
                    <div class="form-group">
                        <div class="outertext"><b>Description:</b></div>
                        <div class="clear"></div>
                        <div class="innertext">${service.description}</div>
                    </div>
                    <div class="form-group">
                        <g:if test="${!service.attachments.isEmpty()}">
                            <div class="outertext"><b>Attachments:</b></div>
                            <g:each in="${service.attachments}" var="attachment">
                                <div class="attachmentsLink">
                                    <a href="${attachment.url}">${attachment.url}</a>
                                </div>
                            </g:each>
                        </g:if>
                        <g:else>
                            <div class="outertext"><b>No Attachments</b></div>
                        </g:else>
                    </div>
                </div>
                <div class="modal-footer">
                </div>
            </div>
        </div>
    </div>
</div>
