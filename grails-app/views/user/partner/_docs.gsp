<g:hiddenField name="folderId"></g:hiddenField>
<input type="file" class="upload" name="file" id="newDocFile">
<div class="col-sm-12 col-xs-12 docs-tab-border">
    <ul class="nav nav-pills nav-tab-doc">
        <li><span class="active doc-tab-right-border doc-tab-padding">
            <a href="#files" data-toggle="tab" class="active tab-data-toggle doc-tab-files">
                Files
            </a>
            </span>
        </li>
        <li><span class="doc-tab-right-border doc-tab-padding">
                <g:if test="${!isAdmin}">
                    <span class="uploaddocfile" id="uploaddocfile">Upload</span>
                </g:if>
                <g:else>
                    <span class="uploaddocfile">Upload</span>
                </g:else>
            </span>
        </li>
        <li><span class="doc-tab-right-border doc-tab-padding">
            <a href="#" data-toggle="modal" data-target="#createNewFolder">
                New Folder
            </a>
            </span>
        </li>
        <li><span class="doc-tab-right-border doc-tab-padding">
            <a href="#drive" data-toggle="tab" class="tab-data-toggle">
                Google Drive
            </a>
            </span>
        </li>
        <li><span class="doc-tab-padding">
            <a href="#" data-toggle="modal" data-target="#sendReceiptModal">
                Send Receipt
            </a>
            </span>
        </li>
    </ul>
</div>
<!-- Modal -->
<div class="modal fade" id="createNewFolder" aria-hidden="true">
    <g:form action="newfolder" id="" name="" class="">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
                    <h3 class="modal-title text-center"><b>New Folder</b></h3>
                </div>
                <div class="modal-body">
                    <br/>
                    <div class="form-group">
                        <input type="text" class="form-control all-place" name="title" id="folderName" placeholder="Untitled folder"/>
                    </div>
                </div>
                <g:if test="${!isAdmin}">
                    <div class="modal-footer">
                        <button type="button" class="btn btn-sm btn-default" data-dismiss="modal">Cancel</button>
                        <button type="button" class="btn btn-sm btn-primary" id="savenewfolderbtn">Create</button>
                    </div>
                </g:if>
            </div>
        </div>
    </g:form>
</div>

<!-- Modal -->
<div class="modal fade" id="sendReceiptModal" aria-hidden="true">
    <g:uploadForm action="sendReceipt" controller="user">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
                    <h3 class="modal-title text-center"><b>Send Receipt</b></h3>
                </div>
                <div class="modal-body">
												        <div class="form-group">
												            <label><b>Your Name</b></label> 
												            <input type="text" class="form-control all-place" name="name" placeholder="Name" value="${user.firstName}"/>
												        </div>
												        <div class="form-group">
												            <label><b>Recipient Email</b></label>
												            <input type="text" class="form-control all-place" name="email" placeholder="Email"/>
												        </div>
												        <div class="form-group">
												            <label><b>Message (Optional)</b></label>
												            <textarea class="form-control all-place" name="message" rows="4" placeholder="Message"></textarea>
												        </div>
												        <div class="form-group">
												            <div class="fileUpload btn btn-info btn-sm cr-btn-color">
                            Upload File
                            <input type="file" class="upload" name="file">
                        </div>
												        </div>
												    </div>
												    <g:if test="${!isAdmin}">
												        <div class="modal-footer">
                        <button type="button" class="btn btn-sm btn-default" data-dismiss="modal">Cancel</button>
                        <button type="submit" class="btn btn-sm btn-primary" id="sendReceiptBtn">send</button>
                    </div>
                </g:if>
												    
												</div>
								</div>
    </g:uploadForm>
</div>

<div class="clear"></div>
<div class="tab-content" id="partner-doc-content">
    <div class="active tab-pane tab-pane-active" id="files">
        <div class="docFolders" id="docFolders">
            <g:render template="/user/partner/folders"/>
        </div>
        <div class="docFiles" id="docFiles">
            <g:render template="/user/partner/files"/>
        </div>
    </div>
    <div class="tab-pane tab-pane-active" id="drive">
        <div class="col-sm-12">
            <g:if test="${!isAdmin}">
                <button type="button" class="btn btn-sm btn-primary pull-right" id="pick">Load File</button>
            </g:if>
            <div id="driveFiles">
            </div>
        </div>
    </div>
    <div class="tab-pane tab-pane-active" id="receipt">
        
    </div>
    <div class="tab-pane tab-pane-active" id="viewfolder">
        
    </div>
</div>
