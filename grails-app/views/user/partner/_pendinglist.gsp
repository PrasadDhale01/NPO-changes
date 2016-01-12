<%
    def index1 = 0;
%>
<div class="col-xs-12">
    <div class="table table-responsive table-xs-left">
        <table class="table table-bordered">
            <thead>
                <tr class="alert alert-title ">
                    <th class="text-center col-sm-1">Sr. No.</th>
                    <th class="text-center col-sm-2">FirstName</th>
                    <th class="text-center col-sm-2">LastName</th>
                    <th class="text-center col-sm-2">Email</th>
                    <th class="text-center col-sm-2">Created Date</th>
                    <th class="text-center col-sm-1">Re Invite</th>
                </tr>
            </thead>
            <tbody>
                <g:each var="${partner}" in="${pendingList}">
                    <% index1 = index1 + 1 %>
                    <tr>
                        <td class="text-center col-sm-1">${index1}</td>
                        <td class="text-center col-sm-2">${partner.user.firstName}</td>
                        <td class="text-center col-sm-2">${partner.user.lastName}</td>
                        <td class="text-center col-sm-2">${partner.user.email}</td>
                        <td class="text-center col-sm-2">${partner.created}</td>
                        <td class="text-center col-sm-2"><g:link class="btn btn-primary btn-sm" action="" controller="user" id="${partner.id}">Send</g:link></td>
                    </tr>
                </g:each>
            </tbody>
        </table>
    </div>
</div>
