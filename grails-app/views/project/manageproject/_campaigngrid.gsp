<%-- ProjectUpdateInformation --%>
<%
    def links = projectService.getProjectUpdatedImageLink(projectUpdate)
    def projectId = project.id
    def shareUrl = base_url+'/c/'+shortUrl
    def updateImageUrl = projectUpdate?.imageUrls?.url
%>
<g:hiddenField name="title" value="${projectUpdate.title}"/>
<g:hiddenField name="story" value="${projectUpdate.story }"/> 
<g:hiddenField name="image" value="${updateImageUrl}"/>

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
        <img src="//s3.amazonaws.com/crowdera/assets/fb-icon-update.png" alt="Facebook Share">
    </a>
    <a class="share-mail pull-left social show-emailjsid" href="#" data-toggle="modal" data-target="#updatesendmailmodal" target="_blank" id="${projectUpdate.id}">
        <img src="//s3.amazonaws.com/crowdera/assets/show-e-mail-light-gray.png" class="show-email" alt="Email Share">
    </a>
    <a class="twitter-share-updatepage pull-left social" target="_blank">
        <img src="//s3.amazonaws.com/crowdera/assets/show-twitter-gray.png" class="show-twitter" alt="Twitter Share">
    </a>
    <a class="social share-linkedin pull-left" href="https://www.linkedin.com/cws/share?url=${shareUrl}%23projectupdates&" onclick="javascript:window.open(this.href,'', 'menubar=no,toolbar=no,resizable=yes,scrollbars=yes,height=600,width=600');return false;">
        <img src="//s3.amazonaws.com/crowdera/assets/show-linkedin-gray.png" class="show-linkedin" alt="LinkedIn Share">
    </a>
    <a class="social google-plus-share pull-left" href="https://plus.google.com/share?url=${shareUrl}%23projectupdates&" onclick="javascript:window.open(this.href,'', 'menubar=no,toolbar=no,resizable=yes,scrollbars=yes,height=600,width=600');return false;">
        <img src="//s3.amazonaws.com/crowdera/assets/show-google-gray.png" class="show-google" alt="Google+ Share">
    </a>
</div>
