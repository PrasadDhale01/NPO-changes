<%
    def index = 0
%>
<div class="col-xs-12">
    <div class="table table-responsive table-xs-left">
        <table class="table table-bordered">
            <thead>
                <tr class="alert alert-title ">
                    <th class="text-center col-sm-1">Sr. No.</th>
                    <th class="text-center col-sm-1">Name</th>
                    <th class="text-center col-sm-2">Email</th>
                    <th class="text-center col-sm-2">Organization Name</th>
                    <th class="text-center col-sm-3">Description</th>
                    <th class="text-center col-sm-2">Website</th>
                    <th class="text-center col-sm-1">Validate</th>
                    <th class="text-center col-sm-1">Reject</th>
                </tr>
            </thead>
            <tbody>
                <g:each var="${partner}" in="${nonVerified}">
                    <%
                        index = index + 1 
                    %>
                    <tr>
				        <td class="text-center col-sm-1">${index}</td>
				        <td class="text-center col-sm-1">${partner.user.firstName} ${partner.user.lastName}</td>
				        <td class="text-center col-sm-2">${partner.user.email}</td>
				        <td class="text-center col-sm-2">${partner.orgName}</td>
				        <td class="text-center col-sm-3">${raw(partner.description)}</td>
				        <td class="text-center col-sm-1">${partner.website}</td>
				        <td class="text-center col-sm-1"><g:link class="btn btn-primary btn-sm" action="verifypartner" controller="user" id="${partner.id}">Validate</g:link></td>
				        <td class="text-center col-sm-1"><g:link class="btn btn-danger btn-sm" action="rejectpartner" controller="user">Reject</g:link></td>
				    </tr>
                </g:each>
            </tbody>
        </table>
    </div>
</div>
