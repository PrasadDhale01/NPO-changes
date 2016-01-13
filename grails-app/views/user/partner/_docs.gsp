<g:hiddenField name="folderId"></g:hiddenField>
<input type="file" class="upload" name="file" id="newDocFile">
<div class="col-sm-12 col-xs-12 docs-tab-border">
    <ul class="nav nav-pills nav-tab-doc">
        <li><span class="active doc-tab-right-border doc-tab-padding">
            <a href="#files" data-toggle="tab" class="active tab-data-toggle doc-tab-files">
                My Storage
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
    <g:form action="newfolder" name="newfolder">
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
                        <div class="fileUpload btn btn-info btn-sm cr-btn-color" id="receiptUploadBtn">
                            Upload File
                            <input type="file" class="upload" name="file">
                        </div>
                    </div>
                </div>
                <g:if test="${!isAdmin}">
                    <div class="modal-footer">
                        <button type="button" class="btn btn-sm btn-default" data-dismiss="modal">Cancel</button>
                        <button type="submit" class="btn btn-sm btn-primary" id="sendReceiptBtn">Send</button>
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
        <g:if test="${!isAdmin}">
            <div class="trash-docs-fixed-btn" id="trash-docs-fixed-btn">
                <button class="btn btn-danger btn-round" type="button" id="remove-folder">
                    <span class="fa fa-trash"></span>
                </button>
            </div>
        </g:if>
    </div>
    <div class="tab-pane tab-pane-active" id="drive">
        <div class="col-sm-12">
            <button type="button" class="btn btn-sm btn-primary pull-right" id="pick">Import File</button>
            
            <div class="trash-drivefile-fixed-btn" id="trash-drivefile-fixed-btn">
                <button class="btn btn-danger btn-round" type="button" id="remove-drive-file">
                    <span class="fa fa-trash"></span>
                </button>
            </div>
            <div class="clear"></div>
            <div id="driveFiles">
            </div>
        </div>
    </div>
    <div class="tab-pane tab-pane-active" id="receipt">
        
    </div>
    <div class="tab-pane tab-pane-active" id="viewfolder">
        
    </div>
</div>

<div class="dropup add-docs-fixed-btn" id="add-docs-fixed-btn">
    <button class="btn btn-primary btn-round dropdown-toggle" type="button" data-toggle="dropdown" id="dropupbtn">
        <span class="glyphicon glyphicon-plus"></span>
    </button>
    <ul class="dropdown-menu dropdown-menu-right">
        <li class="dropdown-doc-padding" id="first"><span class="fileUpload">
            <span class="uploaddocfile" id="uploaddocfile">Upload File</span>
        </span></li>
        <li class="divider"></li>
        <li class="dropdown-doc-padding" id="third" data-toggle="modal" data-target="#createNewFolder">New Folder</li>
    </ul>
</div>
<div class="trash-file-fixed-btn" id="trash-file-fixed-btn">
    <button class="btn btn-danger btn-round" type="button" id="remove-file">
        <span class="fa fa-trash"></span>
    </button>
</div>
