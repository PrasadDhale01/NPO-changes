<g:set var="projectService" bean="projectService"/>
<div>
    <h1>Crowdera</h1>
    <% 	Double amt = Double.parseDouble(amount)
    	def contributedAmount = projectService.getDataType(amt) %>

    <h3>A global platform to create and fund indigenous educational campaigns</h3>

    <p>You have successfully funded a campaign</p>
    <table style="border: dotted;">
        <tbody>
        <tr>
            <td>Campaign</td>
            <td><g:link absolute="true" controller="project" action="show" id="${project.id}">${project.title}</g:link></td>
        </tr>
        <tr>
            <td>Beneficiary</td>
            <td>${projectService.getBeneficiaryName(project)}</td>
        </tr>
        <tr>
            <td>Amount</td>
            <td>$${contributedAmount}</td>
        </tr>
        </tbody>
    </table>

    <p>~Crowdera Team~</p>
</div>
