<%
    def index2 = 0
%>
<div class="col-xs-12">
    <div class="table table-responsive table-xs-left">
        <table class="table table-bordered">
            <thead>
                <tr class="alert alert-title ">
                    <th class="text-center col-sm-1">Sr. No.</th>
                    <th class="text-center col-sm-2">Name</th>
                    <th class="text-center col-sm-2">Email</th>
                    <th class="text-center col-sm-2">Organization Name</th>
                    <th class="text-center col-sm-2">Website</th>
                    <th class="text-center col-sm-3">Description</th>
                </tr>
            </thead>
            <tbody>
                <g:each var="${partner}" in="${draftList}">
                    <% index2 = index2 + 1 %>
                    <tr>
                        <td class="text-center col-sm-1">${index2}</td>
                        <td class="text-center col-sm-2">${partner.user.firstName} ${partner.user.lastName}</td>
                        <td class="text-center col-sm-2">${partner.user.email}</td>
                        <td class="text-center col-sm-2">${partner.orgName}</td>
                        <td class="text-center col-sm-2">${partner.website}</td>
                        <td class="text-center col-sm-3">${raw(partner.description)}</td>
                    </tr>
                </g:each>
            </tbody>
        </table>
    </div>
</div>
