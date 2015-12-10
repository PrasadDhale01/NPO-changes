<g:each in="${folders}" var="folder">
    <div class="col-md-3 col-sm-4">
       <div class="folder">
           <div class="folderName"><span class="glyphicon glyphicon-folder-close"></span>&nbsp;&nbsp; ${folder.fName}</div>
       </div>
    </div>
</g:each>

<div class="table table-responsive table-xs-left">
    <table class="table table-bordered">
        <thead>
            <tr class="alert alert-title">
                <th>Sr. No.</th>
                <th class="col-sm-8">Title</th>
                <th class="col-sm-2">Explore</th>
                <th class="col-sm-1">Trash</th>
            </tr>
        </thead>
        <tbody>
            <g:each in="${files}" var="file">
            </g:each>
        </tbody>
    </table>
</div>
