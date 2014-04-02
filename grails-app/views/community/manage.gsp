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

        <div class="panel panel-default">
            <div class="panel-heading">List of communities managed by you (${userService.getFriendlyName()})</div>

            <div class="table-responsive">
                <table class="table table-bordered">
                    <thead>
                    <tr>
                        <th>Name</th>
                        <th>Users in community</th>
                        <th>Outstanding credit ($)</th>
                    </tr>
                    </thead>
                    <tbody>
                    <g:each in="${communities}" var="community">
                        <tr>
                            <td>${community.title}</td>
                            <td>
                                <ul>
                                <g:each in="${communityService.getMembersInCommunity(community)}" var="member">
                                    <li>${userService.getFriendlyName(member)}</li>
                                </g:each>
                                </ul>
                            </td>
                            <td>$${creditService.getTotalCreditForCommunity(community)}</td>
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
