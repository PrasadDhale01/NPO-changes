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