<div class="col-sm-12 docs-tab-border">
    <ul class="nav nav-pills nav-tab-doc">
        <li><span class="active doc-tab-right-border doc-tab-padding">
            <a href="#files" data-toggle="tab" class="active tab-data-toggle">
                Files
            </a>
            </span>
        </li>
        <li><span class="doc-tab-right-border doc-tab-padding">
            <a href="" data-toggle="tab" class="tab-data-toggle">
                Upload
            </a>
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
                Drive
            </a>
            </span>
        </li>
        <li><span class="doc-tab-padding">
            <a href="#receipt" data-toggle="tab" class="tab-data-toggle">
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
                <div class="modal-footer">
                    <button type="button" class="btn btn-sm btn-default" data-dismiss="modal">Cancel</button>
                    <button type="button" class="btn btn-sm btn-primary" id="savenewfolderbtn">Create</button>
                </div>
            </div>
        </div>
    </g:form>
</div>
<div class="clear"></div>
<div class="tab-content" id="partner-doc-content">
    <div class="active tab-pane tab-pane-active" id="files">
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
        krishna
    </div>
</div>
