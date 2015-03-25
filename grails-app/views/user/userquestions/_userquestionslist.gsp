<html>
<body>
    <tr>
    	<td>${service.id}</td>
    	<td class="col-md-2 col-sm-2">${service.customername}</td>
    	<td class="col-md-2 col-sm-2">${service.email}</td>
        <td class="col-md-2 col-sm-2">${service.subject}</td>
        <td class="col-md-2 col-sm-2">${service.category}</td>
        <td class="col-md-2 col-sm-2">${service.description}</td>
        <td class="col-md-1 col-sm-1">
            <g:if test="${service.attachments.isEmpty()}">
                <a class="btn btn-sm btn-default">No Attachments</a>
            </g:if>
            <g:else>
                <a href="#" class="btn btn-sm btn-primary" data-id="${service}" data-toggle="modal" data-target="#attachment${service.id}">View Attachments</a>
            </g:else>
            
        </td>
        <td class="col-md-1 col-sm-1">
            <g:if test="${service.status == false}">
                <a href="#" class="btn btn-sm btn-primary" data-id="${service}" data-toggle="modal" data-target="#servicemodal${service.id}">Respond</a>
            </g:if>
            <g:else>
                 <button class="btn btn-sm btn-default">Responded</button>
            </g:else>
        </td>
    </tr>
    <div class="row" id="customerservice">
	    <div class="modal fade" id="servicemodal${service.id}" tabindex="-1" role="dialog" aria-labelledby="servicemodal" aria-hidden="true">
	        <g:form action="response" controller="user" id="${service.id}" role="form">
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
	                            <textarea class="form-control" name="answer" maxlength="140" rows="4" placeholder="Response to User's Question" required></textarea>
	                        </div>
	                    </div>
	                    <div class="modal-footer">
	                        <button type="submit" class="btn btn-primary btn-block">Send Response</button>
	                    </div>
	                </div>
	            </div>
	        </g:form>
	    </div>
    </div>
    
    <div class="row" id="customerservice">
	    <div class="modal fade" id="attachment${service.id}" tabindex="-1" role="dialog" aria-labelledby="servicemodal" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
                        <h4 class="modal-title"><b>Attachments</b></h4>
                    </div>
                    <div class="modal-body">
                        <g:each in="${service.attachments}" var="attachment">
                            <div class="attachmentsLink">
                                <a href="${attachment.url}">${attachment.url}</a>
                            </div>
                        </g:each>
                    </div>
                    <div class="modal-footer">
                    </div>
                </div>
            </div>
	    </div>
    </div>
</body>
</html>
