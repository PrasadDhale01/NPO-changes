<g:set var="projectService" bean="projectService"/>
<g:set var="userService" bean="userService"/>
<% 
    def beneficiary = project.user
    def x = userService.isCampaignBeneficiaryOrAdmin(project, beneficiary)
%>
<div class="panel panel-default org-panel-2 organization-panel personal-details-panel">
    <h6 class="text-center"><b>Campaign Creator</b></h6>
    <label><b>Name : </b>${beneficiary.firstName} ${beneficiary.lastName}</label><br>
    <label><b>Email : </b> <a href="mailto:${beneficiary.email}">${beneficiary.email}</a></label><br>
    <label><b>Country : </b>${project.beneficiary.country}</label><br>
    <g:if test="${project.beneficiary.telephone}">
        <label><b>Contact : </b>${project.beneficiary.telephone}</label><br>
    </g:if>
    <g:if test="${project.beneficiary.city}">
        <label><b>Contact : </b>${project.beneficiary.city}</label><br>
    </g:if>
    
    <g:if test="${project.projectAdmins.email.size() > 1}">
        <div class="col-sm-12 coCreator hidden-sm">
            <h6 class="text-center"><b>Campaign Co-Creator</b></h6><hr class="hrClasses"/>
        </div>
        <g:each in="${project.projectAdmins.email}" var="admin">
           <g:if test="${admin!="campaignadmin@crowdera.co"}">
               <label class="hidden-sm">${admin}</label><br>
           </g:if>
        </g:each>
    </g:if>
    
</div>
