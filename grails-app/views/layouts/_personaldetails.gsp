<g:set var="projectService" bean="projectService"/>
<g:set var="userService" bean="userService"/>
<% 
    def beneficiary = project.user
    def isCoAdmin = userService.isCampaignBeneficiaryOrAdmin(project, beneficiary)
    def counter=1
%>
<div class="panel panel-default">
    <div class="panel-heading">
        <span>Additional Information</span>
    </div>
    <div class="panel-body">
   	  <div class="organization-details text-left">
        <div class="col-sm-12">
                <span><b>Campaign Creator</b></span><hr class="hrClass"/>
        </div>
        <ul>
          <li><span><b>Name : </b>${beneficiary.firstName} ${beneficiary.lastName}</span></li>
          <li><span><b>Email : </b> <a href="mailto:${beneficiary.email}">${beneficiary.email}</a></span></li>
          <g:if test="${project.beneficiary.telephone}">
          <li><span><b>Contact : </b>${project.beneficiary.telephone}</span></li>
          </g:if>
          <g:if test='${project.paypalEmail==null}'>
              <li><span><b>Payment mode : </b>FirstGiving</span></li>
          </g:if>
          <g:else>
              <li><span><b>Payment mode : </b>Paypal</span></li>
          </g:else>
        </ul>
   	    
        <g:if test="${isCoAdmin}">
            <g:if test="${project.projectAdmins.email.size() > 1}">
              <div class="col-sm-12 coCreator">
                    <span><b>Campaign Co-Creator</b></span><hr class="hrClass"/>
              </div>
            </g:if>
            <g:each in="${project.projectAdmins.email}" var="admin">
                <g:if test="${admin!="campaignadmin@crowdera.co"}">
                  <ul>
                    <li><span>${admin}</span></li>
                  </ul>
                  <% counter++%>
                </g:if>
            </g:each>
        </g:if>
      </div>
    </div>
</div>
