<h4>List of community managers</h4>
<div class="table-responsive">
<table class="table table-bordered">
    <thead>
    <tr>
        <th>Name</th>
        <th>Email</th>
        <th># of users in community</th>
        <th>Outstanding credit ($)</th>
        <th>Add credits ($)</th>
    </tr>
    </thead>
    <tbody>
    <g:each in="${communitymgrs}" var="communitymgr">
        <tr>
            <td>${communitymgr.firstName}</td>
            <td>${communitymgr.email}</td>
            <td></td>
            <td></td>
            <td>
                <form class="form-inline" role="form">
                    <div class="input-group" style="max-width: 200px; min-width: 180px;">
                        <input type="text" class="form-control" placeholder="Amount">
                        <span class="input-group-btn">
                            <button class="btn btn-default" type="button">Add credit ($)</button>
                        </span>
                    </div>
                </form>
            </td>
        </tr>
    </g:each>
    </tbody>
</table>
</div>
<form class="form-inline" role="form">
    <label>Authorize a user to be a community manager</label>
    <div class="input-group">
        <input type="text" class="form-control" placeholder="Enter username" name="username">
        <span class="input-group-btn">
            <button class="btn btn-default" type="button">Add user as community manager</button>
        </span>
    </div>
</form>
