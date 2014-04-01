<g:set var="userService" bean="userService"/>
<g:set var="communityService" bean="communityService"/>

<html>
<head>
    <meta name="layout" content="main" />
</head>
<body>
<div class="feducontent">
    <div class="container">
        <h2>Manage Communities</h2>

        <label>List of communities</label>
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
                        <td>$${new Double(community.credit).trunc(2)}</td>
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

        <form class="form-inline" role="form">
            <label>Authorize an existing user to be a community manager</label>
            <div class="input-group">
                <input type="text" class="form-control" placeholder="Enter email" name="username">
                <span class="input-group-btn">
                    <button class="btn btn-default" type="button">Add user as community manager</button>
                </span>
            </div>
        </form>

    </div>
</div>
</body>
</html>
