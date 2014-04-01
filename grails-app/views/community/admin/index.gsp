<g:set var="userService" bean="userService"/>
<g:set var="communityService" bean="communityService"/>
<g:set var="creditService" bean="creditService"/>
<html>
<head>
    <meta name="layout" content="main" />
</head>
<body>
<div class="feducontent">
    <div class="container">
        <h2>Manage Communities</h2>
        <div class="alert alert-warning">Be careful. You are handling sensitive data. This is admin-only zone.</div>

        <div class="panel panel-default">
            <div class="panel-heading">List of communities</div>

            <div class="table-responsive">
                <table class="table table-bordered">
                    <thead>
                    <tr>
                        <th>Name</th>
                        <th>Manager</th>
                        <th># of users in community</th>
                        <th>Outstanding credit ($)</th>
                        <th>Add credits ($)</th>
                    </tr>
                    </thead>
                    <tbody>
                    <g:each in="${communities}" var="community">
                        <tr>
                            <td>${community.title}</td>
                            <td>${userService.getFriendlyName(community.manager)}</td>
                            <td>${communityService.getNumberofMembersInCommunity(community)}</td>
                            <td>$${creditService.getTotalCreditForCommunity(community)}</td>
                            <td>
                                <g:form action="addcredit" class="form-inline" role="form" id="${community.id}">
                                    <div class="input-group" style="max-width: 200px; min-width: 180px;">
                                        <input type="text" class="form-control" placeholder="Amount" name="amount" required="true">
                                        <span class="input-group-btn">
                                            <button class="btn btn-default" type="submit">Add credit ($)</button>
                                        </span>
                                    </div>
                                </g:form>
                            </td>
                        </tr>
                    </g:each>
                    </tbody>
                </table>
            </div>
        </div>

        <div class="panel panel-default">
            <div class="panel-heading">List of community managers</div>
            <div class="panel-body">
                <g:form action="addcommunitymgr" class="form-inline" role="form">
                    <label>Authorize an existing user to be a community manager</label>
                    <div class="input-group" style="max-width: 500px;">
                        <input type="text" class="form-control" placeholder="Enter email" name="email" required="true">
                        <span class="input-group-btn">
                            <button class="btn btn-default" type="submit">Authorize user as community manager</button>
                        </span>
                    </div>
                </g:form>
                <g:if test="${flash.error}">
                    <label class="bg-danger">${flash.error}</label>
                </g:if>
                <g:if test="${flash.message}">
                    <label class="bg-success">${flash.message}</label>
                </g:if>
            </div>

            <div class="table-responsive">
                <table class="table table-bordered">
                    <thead>
                    <tr>
                        <th>Name</th>
                        <th>Email</th>
                    </tr>
                    </thead>
                    <tbody>
                    <g:each in="${communitymgrs}" var="communitymgr">
                        <tr>
                            <td>${userService.getFriendlyFullName(communitymgr)}</td>
                            <td>${communitymgr.email}</td>
                        </tr>
                    </g:each>
                    </tbody>
                </table>
            </div>
        </div>

    </div>
</div>
</body>
</html>
