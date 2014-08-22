<g:set var="projectService" bean="projectService"/>
<div>
    <h1>FEDU</h1>

    <h3>A global platform to create and fund indigenous educational projects</h3>

    <p>You have successfully funded a project</p>
    <table style="border: dotted;">
        <tbody>
        <tr>
            <td>Project</td>
            <td><g:link absolute="true" controller="project" action="show" id="${project.id}">${project.title}</g:link></td>
        </tr>
        <tr>
            <td>Beneficiary</td>
            <td>${projectService.getBeneficiaryName(project)}</td>
        </tr>
        <tr>
            <td>Amount</td>
            <td>$${amount}</td>
        </tr>
        </tbody>
    </table>

    <p>~FEDU Team~</p>
</div>