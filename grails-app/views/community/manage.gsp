<%@ page import="fedu.DateHelper" %>
<g:set var="userService" bean="userService"/>
<g:set var="communityService" bean="communityService"/>
<g:set var="creditService" bean="creditService"/>
<html>
<head>
    <meta name="layout" content="main" />
    <r:require modules="communityjs"/>
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
                                <p># of members: ${communityService.getNumberofMembersInCommunity(community)}</p>
                                <ul>
                                <g:each in="${communityService.getMembersInCommunity(community)}" var="member">
                                    <li>${userService.getFriendlyName(member)}</li>
                                </g:each>
                                </ul>
                            </td>
                            <td>
                                <p>$${creditService.getTotalCreditForCommunity(community)}</p>
                                <ul>
                                    <g:each in="${creditService.getAllCreditsForCommunity(community)}" var="credit">
                                        <li>$${credit.amount} credit posted on ${DateHelper.format(credit.date)}</li>
                                    </g:each>
                                </ul>
                            </td>
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
