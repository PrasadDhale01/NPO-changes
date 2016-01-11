<g:set var="projectService" bean="projectService"/>
<g:set var="userService" bean="userService"/>
<% 
    def beneficiary = project.user
    def x = userService.isCampaignBeneficiaryOrAdmin(project, beneficiary)
    String purpose, catgory
    if (project.usedFor == 'SOCIAL_NEEDS'){
        purpose = 'Social-Innovtion'
    } else if (project.usedFor == 'PERSONAL_NEEDS'){
        purpose = 'Personal-Needs'
    } else if (project.usedFor == 'IMPACT'){
        purpose = 'Impact';
    } else if (project.usedFor == 'PASSION'){
        purpose = 'Passion';
    }
    
    if (project.category.toString() == 'SOCIAL_INNOVATION'){
        category = 'Social-Innovtion'
    } else if (project.category.toString() == 'NON_PROFITS'){
        category = 'Non-Profits'
    } else if (project.category.toString() == 'CIVIC_NEEDS'){
        category = 'Civic-Needs'
    } else {
        category = project.category.toString().toLowerCase().capitalize();
    }

%>
<div class="panel panel-default org-panel-2 organization-panel personal-details-panel">
    <h6 class="text-center"><b>Campaign Creator</b></h6>
    <label><b>Name : </b>${beneficiary.firstName} ${beneficiary.lastName}</label><br>
    <label><b>Country : </b>${project.beneficiary.country}</label><br>
    <g:if test="${project.beneficiary.telephone}">
        <label><b>City : </b>${project.beneficiary.city}</label><br>
    </g:if>
    <g:if test="${project.beneficiary.city}">
        <label><b>Contact : </b>${project.beneficiary.telephone}</label><br>
    </g:if>
    <label><b>Purpose : </b>${purpose}</label><br>
    <label><b>Category : </b>${category}</label><br>
    <g:if test="${project.rewards.size() > 1}">
        <label><b>Rewards : </b>${project.rewards.size()}</label>
    </g:if>
    <g:else>
        <label><b>Rewards : </b> No Rewards</label>
    </g:else>
    <label><b>,Teams : </b>${project.teams.size()}</label>

    <g:if test="${project.projectAdmins.email.size() > 1}">
        <div class="col-sm-12 hidden-sm">
            <h6 class="text-center"><b>Campaign Co-Creator</b></h6><hr class="hrClasses"/>
        </div>
        <g:each in="${project.projectAdmins.email}" var="admin">
           <g:if test="${admin!="campaignadmin@crowdera.co"}">
               <label class="hidden-sm">${admin}</label><br>
           </g:if>
        </g:each>
    </g:if>
    
</div>
