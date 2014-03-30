<h4>List of community managers</h4>
<div class="table-responsive">
<table class="table table-bordered">
    <thead>
    <tr>
        <th>Name</th>
        <th>Email</th>
        <th># of users in community</th>
        <th>Outstanding credit ($)</th>
    </tr>
    </thead>
    <tbody>
    <g:each in="${communitymgrs}" var="communitymgr">
        <tr>
            <td>${communitymgr.firstName}</td>
            <td>${communitymgr.email}</td>
            <td></td>
            <td></td>
        </tr>
    </g:each>
    </tbody>
</table>
</div>
<form class="form-inline" role="form">
    <label>Authorize a user to be a community manager</label>
    <div class="form-group">
        <label class="sr-only" for="username">Username</label>
        <input class="form-control" id="username" placeholder="Enter username">
    </div>
    <button type="submit" class="btn btn-default btn-sm">Submit</button>
</form>

