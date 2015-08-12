<!-- Comments -->
<%
    def base_url = grailsApplication.config.crowdera.BASE_URL
    def fbShareUrl = base_url+"/campaigns/"+project.id+"?fr="+project.user.username
    def fundRaiser = user.username
%>

<div class="col-xs-12 col-md-4 mobileview-top">
	<g:render template="/project/manageproject/tilesanstitle" />
	<g:if test="${project.draft}">
		<g:form controller="project" action="saveasdraft"
			id="${project.id}">
			<button class="btn btn-block btn-primary">
				<i class="glyphicon glyphicon-check"></i>&nbsp;Submit for approval
			</button>
		</g:form>
	</g:if>
	<br>
</div>

<div class="col-md-8">
	<div class="blacknwhite campaignupdatedimages" onmouseover="showNavigation()" onmouseleave="hideNavigation()">
        <g:render template="/project/manageproject/projectimagescarousel" model="['images': projectimages]"/>
    </div>
    <br>
    <%-- Social features --%>
    <g:hiddenField name="fbShareUrl" id="fbShareUrl" value="${fbShareUrl}"/>
    <g:if test="${project.validated}">
		<div class="shared pull-left mng-sharing-icon-alignment">
			<span><label>SHARE:</label></span>
		</div>
		<a target="_blank" class="fb-like pull-left social fbShareForLargeDevices" id="fbshare">
			<img src="//s3.amazonaws.com/crowdera/assets/fb-share-icon.png" alt="Facebook Share">
		</a>
		<a target="_blank" class="fb-like pull-left social fbShareForSmallDevices" href="http://www.facebook.com/sharer/sharer.php?s=100&amp;&p[url]=${fbShareUrl}">
			<img src="//s3.amazonaws.com/crowdera/assets/fb-share-icon.png" alt="Facebook Share">
		</a>
		<a class="share-mail pull-left social" href="#" data-toggle="modal" data-target="#sendmailmodal" target="_blank" id="share-mail">
			<img src="//s3.amazonaws.com/crowdera/assets/email-share-icon.png">
		</a>
		<a class="twitter-share pull-left social" id="twitterShare" target="_blank">
			<img src="//s3.amazonaws.com/crowdera/assets/twitter-share-icon.png" alt="Twitter Share">
		</a>
		<%--       	<a class="social like-share pull-left" id="likeShare" data-url="${base_url}/campaigns/${vanityTitle}/${vanityUsername}" target="_blank">--%>
		<%--            		<img src="//s3.amazonaws.com/crowdera/assets/like-share-icon.png" alt="Like Share"/>--%>
		<%--        </a>--%>
		<a class="social share-linkedin pull-left" href="https://www.linkedin.com/cws/share?url=${fbShareUrl}"  id="share-linkedin" onclick="javascript:window.open(this.href,'', 'menubar=no,toolbar=no,resizable=yes,scrollbars=yes,height=600,width=600');return false;">
			<img src="//s3.amazonaws.com/crowdera/assets/linked-in-share-icon.png" alt="LinkedIn Share">
		</a>
		<a class="social google-plus-share pull-left" id="googlePlusShare" href="https://plus.google.com/share?url=${fbShareUrl}" onclick="javascript:window.open(this.href,'', 'menubar=no,toolbar=no,resizable=yes,scrollbars=yes,height=600,width=600');return false;">
			<img src="//s3.amazonaws.com/crowdera/assets/google-plus-share.png" alt="Google+ Share">
		</a>
	</g:if>

    <div class="col-md-12 col-sm-12 col-xs-12">
        <p class="campaignDescription justify">${raw(project.description)}</p>
        <p class="campaignStory justify">${raw(project.story)}</p>
    </div>
    
	<div class="col-sm-12">
	    <!-- Modal -->
		<div class="modal fade" id="sendmailmodal" tabindex="-1" role="dialog" aria-hidden="true">
			<g:form action="sendemail" id="${project.id}" role="form" class="sendMailFormMng">
		        <div class="modal-dialog">
				    <div class="modal-content">
					    <div class="modal-header">
					        <button type="button" class="close" data-dismiss="modal">
							    <span aria-hidden="true">&times;</span><span class="sr-only">Close</span>
							</button>
							<h4 class="modal-title">Recipient Email ID's</h4>
						</div>
						<div class="modal-body">
						    <g:hiddenField name="amount" value="${project.amount}" />
						    <g:hiddenField name="ismanagepage" value="managepage" />
						    <g:hiddenField name="fr" value="${fundRaiser}" />
                                                   <g:hiddenField name="vanityTitle" value="${vanityTitle}"/>
						    <div class="form-group">
							    <label>Your Name</label> <input type="text" class="form-control" name="name" placeholder="Name" />
						    </div>
							<div class="form-group">
						        <label>Email ID's (separated by comma)</label>
								<textarea class="form-control" name="emails" rows="4" placeholder="Email ID's"></textarea>
							</div>
							<div class="form-group">
							    <label>Message (Optional)</label>
								<textarea class="form-control" name="message" rows="4" placeholder="Message"></textarea>
							</div>
						</div>
						<div class="modal-footer">
						    <button type="submit" class="btn btn-primary btn-block" id="btnSendMailMng">Send Email</button>
						</div>
				    </div>
			    </div>
	        </g:form>
		</div>
	</div>
</div>

<div class="col-xs-12 col-md-4 mobileview-bottom">
    <g:render template="/project/manageproject/tilesanstitle" />
    <g:if test="${project.draft}">
        <g:if test="${isPreview}">
            <button class="btn btn-block btn-primary">
                <i class="glyphicon glyphicon-check"></i>&nbsp;Submit for approval
            </button>
        </g:if>
        <g:else>
            <g:if test="${project.organizationIconUrl && (project.charitableId || project.paypalEmail || project.payuEmail) && (!project.imageUrl.isEmpty()) && project.organizationName && project.beneficiary.country && (projectService.getRemainingDay(project) > 0)}">
                <g:form controller="project" action="saveasdraft" id="${project.id}">
                    <button class="btn btn-block btn-primary">
                        <i class="glyphicon glyphicon-check"></i>&nbsp;Submit for approval
                    </button>
                </g:form>
            </g:if>
            <g:else>
                <button class="btn btn-block btn-primary" id="submitForApprovalBtn"><i class="glyphicon glyphicon-check"></i>&nbsp;Submit for approval</button>
            </g:else>
        </g:else>
    </g:if>
    <br>
</div>
