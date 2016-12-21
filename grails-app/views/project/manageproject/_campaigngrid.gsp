<%-- ProjectUpdateInformation --%>
<%
    def links = projectService.getProjectUpdatedImageLink(projectUpdate)
    def projectId = project.id
    def shareUrl = base_url+'/c/'+shortUrl
    def updateImageUrl = projectUpdate?.imageUrls?.url
%>
<input type="hidden" name="title" value="${projectUpdate.title}"/>
<input type="hidden" name="story" value="${projectUpdate.story }"/> 
<input type="hidden" name="image" value="${updateImageUrl}"/>

<div class="col-md-6 col-sm-6 col-xs-12">
    <span><b>Update #${i}</b></span>&nbsp;&nbsp;&nbsp;&nbsp;<b>${projectUpdate.title}</b>
</div>
<g:if test="${manageProject}">
    <div class="col-md-6 col-sm-6 col-xs-12">
        <g:form controller="project" action="editCampaignUpdate" method="post"  id="${projectUpdate.id}" params="['projectId': projectId]">
            <button class="projectedit close"  aria-label="Edit project">
                <i class="glyphicon glyphicon-edit" ></i>
            </button>
        </g:form>
    </div>
</g:if>
<div class="col-md-12 col-sm-12 col-xs-12 campaignUpdateStory">
    ${raw(projectUpdate.story)}
    
    <g:if test="${!links.isEmpty()}">
	    <div class="blacknwhite campaignupdatedimages sh-imgUpdt-mob" onmouseover="showNavigation()" onmouseleave="hideNavigation()">
	        <g:render template="/project/manageproject/projectupdateimagecarousel" model="['images': links]"/>
	    </div>
    </g:if>
</div>

<div class="col-lg-12 col-sm-12 col-md-12 col-xs-12 manage-updateshare">
    <a target="_self" class="fb-like pull-left social fbShareForLargeDevices fbshare-headermangepage" href="#">
        <img class="update-share-fbimg" src="//s3.amazonaws.com/crowdera/assets/87908047-8496-40ee-9f44-7af06f2df03d.png" alt="Facebook Share">
    </a>
    <a class="share-mail pull-left social show-emailjsid" href="#" data-toggle="modal" data-target="#updatesendmailmodal" target="_blank" id="${projectUpdate.id}">
        <img src="//s3.amazonaws.com/crowdera/assets/82677812-3c6f-404d-80c2-7e3f77c60cf9.png" class="show-email" alt="Email Share">
    </a>
    <a class="twitter-share-updatepage pull-left social" target="_blank">
        <img src="//s3.amazonaws.com/crowdera/assets/823f1cf6-49fe-4ec2-a0dd-2d2a437ad081.png" class="show-twitter" alt="Twitter Share">
    </a>
    <a class="social share-linkedin pull-left" href="https://www.linkedin.com/cws/share?url=${shareUrl}%23projectupdates&" onclick="javascript:window.open(this.href,'', 'menubar=no,toolbar=no,resizable=yes,scrollbars=yes,height=600,width=600');return false;">
        <img src="//s3.amazonaws.com/crowdera/assets/8a7fbe36-68f8-401e-8644-5780d656d298.png" class="show-linkedin" alt="LinkedIn Share">
    </a>
    <a class="social google-plus-share pull-left" href="https://plus.google.com/share?url=${shareUrl}%23projectupdates&" onclick="javascript:window.open(this.href,'', 'menubar=no,toolbar=no,resizable=yes,scrollbars=yes,height=600,width=600');return false;">
        <img src="//s3.amazonaws.com/crowdera/assets/ccda789b-4001-4c95-a65f-38c0b9a7a474.png" class="show-google" alt="Google+ Share">
    </a>
</div>
