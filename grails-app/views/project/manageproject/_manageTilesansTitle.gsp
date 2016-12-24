<%@ page import="java.text.SimpleDateFormat" %>
<g:set var="contributionService" bean="contributionService"/>
<g:set var="projectService" bean="projectService"/>
<g:set var="userService" bean="userService"/>
<%
    def amount = project.amount.round()
    def currentUser = userService.getCurrentUser()
    def username = currentUser.username
    SimpleDateFormat dateFormat = new SimpleDateFormat("MMM d");
    def cents
    if(percentage >= 100) {
        cents = 100
    } else {
        cents = percentage
    }
%>


<div class="row">
    <div class="fullwidth pull-right manage-edit-mobilebtns">
         <g:if test="${username.equals('campaignadmin@crowdera.co')}">
             
            <%--             <a href="javascript:void(0)" onclick="submitCampaignShowForm('edit','${project.id}','${username}');" class="manage-edit-draft-left col-lg-6 col-md-6 col-sm-6 col-xs-6">--%>
               <g:link mapping="editCampaign" params="[country_code: country_code,fr:username,id: project.id]" class="manage-edit-draft-left col-lg-6 col-md-6 col-sm-6 col-xs-6">
                 <span class="btn btn-default manage-btn-width manage-btn-back-color" aria-label="Edit project"><i class="fa fa-pencil-square-o edit-space"></i>EDIT
                 </span>
          </g:link>   
<%--             </a>--%>
             <g:form controller="project" action="projectdelete" method="post" id="${project.id}" params="[country_code: project.country.countryCode,id: project.id]" class="col-lg-6 col-md-6 col-sm-6 col-xs-6 manage-btn-padding">
                 <button class="btn btn-danger manage-deletebtn-width" aria-label="Edit project" id="projectdelete" onclick="return confirm(&#39;Are you sure you want to discard this campaign?&#39;);">
                 <i class="fa fa-trash edit-space"></i>DELETE</button>
             </g:form>
         
         </g:if>
         <g:else>
         
<%--             <g:if test="${!project.validated && percentage <= 999}">--%>
<%--                 <a href="javascript:void(0)" onclick="submitCampaignShowForm('edit','${project.id}','${username}');" class="manage-edit-draft-left col-lg-6 col-md-6 col-sm-6 col-xs-6">--%>
<%--                     <span class="btn btn-default manage-btn-width manage-btn-back-color"  aria-label="Edit project"><i class="fa fa-pencil-square-o edit-space"></i>EDIT--%>
<%--                     </span>--%>
<%--                 </a>--%>
<%--             </g:if>--%>
             <g:if test="${!project.validated && percentage <= 999}">
                   <g:link mapping="editCampaign" params="[country_code: country_code,fr:username,id: project.id]" class="manage-edit-draft-left col-lg-6 col-md-6 col-sm-6 col-xs-6">
                     <span class="btn btn-default manage-btn-width manage-btn-back-color"  aria-label="Edit project"><i class="fa fa-pencil-square-o edit-space"></i>EDIT
                     </span>
                </g:link>
             </g:if>
             <g:if test="${!project.validated}">
                 <g:form controller="project" action="projectdelete" method="post" id="${project.id}" params="[country_code: project.country.countryCode,id: project.id]" class="col-lg-6 col-md-6 col-sm-6 col-xs-6 manage-btn-padding">
                     <button class="btn btn-danger manage-deletebtn-width" aria-label="Edit project" id="projectdelete" onclick="return confirm(&#39;Are you sure you want to discard this campaign?&#39;);">
                     <i class="fa fa-trash edit-space"></i>DELETE</button>
                 </g:form>
             </g:if>
             
             <g:if test="${project.validated && percentage <= 999}">
                <g:link mapping="editCampaign" params="[country_code: country_code,fr:username,id: project.id]" class="manage-edit-left">
                     <span class="btn btn-default manage-btn-width-aft-validated manage-btn-back-color"  aria-label="Edit project" ><i class="fa fa-pencil-square-o edit-space"></i>EDIT CAMPAIGN
                     </span>
                </g:link>
             </g:if>
             
         </g:else>
    </div>
</div>
<%--               user profile code  --%>
                      <div class="col-lg-12 col-sm-12 col-md-12 show-profile-padding show-org-profiletile hidden-xs">
                       <div class="col-lg-4 col-sm-4 col-md-4 show-profile-imagewidth">
                           <g:if test="${user?.userImageUrl}">
                                <div id="partnerImageEditDeleteIcon">
                                    <span  class="show-image-dp">
                                        <img src="${user?.userImageUrl}" alt="avatar">
                                    </span>
                                </div>
                            </g:if>
                            <g:else>
                                <div id="userAvatarUploadIcon">
                                    <span id="useravatar">
                                        <img class="show-user-profile-hw" src="https://s3.amazonaws.com/crowdera/assets/profile_image.jpg" alt="' '">
                                    </span>
                                </div>
                            </g:else> 
                        </div>
                        <div class="col-lg-8 col-sm-8 col-md-8 show-profile-padding show-tabs-profiledesp">
                            <div class="show-lbl-orgname">
                                <label class="col-lg-8 col-sm-8 col-md-8 show-profile">Campaign by:</label>
                                <g:if test="${project.organizationName && currentFundraiser == beneficiary}">
                                    <span class="col-lg-12 col-sm-12 col-md-12 show-org-name">${project?.organizationName}</span>
                                </g:if>
                                <g:if test="${currentFundraiser != beneficiary}">
                                    <span class="col-lg-12 col-sm-12 col-md-12 show-org-name">${currentFundraiser?.firstName} ${currentFundraiser?.lastName}</span>
                                </g:if>
                            </div>
<%--                            <div class="show-contact-profilefixes col-lg-12 col-sm-12 col-md-12">--%>
<%--                                <div class="col-lg-2 col-sm-2 col-md-2 show-email-profileIcons">--%>
<%--                                    <img class="show-profile-imgs" src="//s3.amazonaws.com/crowdera/assets/1c19404a-4627-4479-94b0-46e49e62471b.png" alt="emails">--%>
<%--                                </div>--%>
<%--                                <div class="col-lg-10 col-sm-10 col-md-10 show-contact-profilefixes">--%>
<%--                                    <span class="col-lg-12 col-sm-12 col-md-12 show-contact-ofOwner">Contact Campaign of Owner</span>--%>
<%--                                </div>--%>
<%--                            </div>--%>
                        </div> 
                    </div>
<g:render template="/layouts/showTilesanstitleForOrg" model="['currentFundraiser':currentUser,'username':username]"/>

 <div class="redirectCampaign">
	 <a class="btn btn-show-bannerslogantext btn-lg btn-block sh-mission-script sh-mission-script-height" href="#" data-toggle="modal" onclick="javascript:window.open('/project/redirectToInviteMember?projectId=${project.id}&page=show','', 'menubar=no,toolbar=no,resizable=0,scrollbars=yes,height=500,width=786');return false;"><span class="glyphicon glyphicon-user"></span> &nbsp;&nbsp;Invite Members </a>
</div>	