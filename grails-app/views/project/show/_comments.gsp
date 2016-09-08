<!-- Comments -->
<g:set var="userService" bean="userService"/>
<%@ page import="java.text.SimpleDateFormat" %>
<%
    SimpleDateFormat dateFormat = new SimpleDateFormat("MMM d");
    def fundRaiser
    def team
    def beneficiary = project?.user 
    if (user) {
        fundRaiser = user?.username
        team = userService.getTeamByUser(user, project)
    } else {
        fundRaiser = beneficiary?.username
        team = userService.getTeamByUser(beneficiary, project)
    }

    List listcomment=[]
    if(project?.user==team?.user){
        listcomment= projectComments
    }else{
        listcomment= teamComments
    }
    def projectId=project.id
    def teamCommentId
    def commentId
    if(projectComment) {
        commentval = projectComment.comment
        commentId = projectComment?.id
    }
    if(teamcomment) {
        commentval = teamcomment.comment
        teamCommentId = teamcomment?.id
    }
	
	def userObj = userService.getCurrentUser()
	def userImage
	if (userObj) {
		if (userObj.userImageUrl) {
			userImage = userObj.userImageUrl
		} else {
			userImage = '//s3.amazonaws.com/crowdera/assets/6667f492-acde-4f1c-b9d5-d66f5282baad.png'
		}
	}else {
        userImage = '//s3.amazonaws.com/crowdera/assets/6667f492-acde-4f1c-b9d5-d66f5282baad.png'
    }
%>

<g:if test="${flash.commentmessage}">
    <div class="alert alert-danger">${flash.commentmessage}</div>
</g:if>

<g:if test="${project.validated}">
    <b class="show-comments-title">Comments</b>
    <g:if test="${projectComment || teamcomment}">
        <div class="commentBox">
            <g:uploadForm controller="project" action="editCommentSave"  params="['projectTitle': vanityTitle, 'fr': fundRaiser]">
                <input type="hidden" name='teamCommentId' value="${teamCommentId}"/>
                <input type="hidden" name='commentId' value="${commentId}"/>

                <div class="form-group show-padding-commentsbox col-lg-12 col-sm-12 col-md-12 col-xs-12">
                    <div class="col-lg-1 col-sm-1 col-md-1 col-xs-2 show-comment-profile-padding">
                        <g:if test="${userService.isFacebookUser()}">
                            <span><img class="show-cmment-box-imgheight" src="${userImage}" alt="userImage"></span>
                        </g:if>
                        <g:elseif test="${userService.isAdmin()}">
                            <span><img class="show-cmment-box-imgheight" src="${userImage}" alt="userImage"></span>
                        </g:elseif>
                        <g:elseif test="${userService.isAuthor()}">
                            <span><img class="show-cmment-box-imgheight" src="${userImage}" alt="userImage"></span>
                        </g:elseif>
                        <g:elseif test="${userService.isCommunityManager()}">
                            <span><img class="show-cmment-box-imgheight" src="${userImage}" alt="userImage"></span>
                        </g:elseif>
                        <g:else>
                             <span><img class="show-cmment-box-imgheight" src="${userImage}" alt="userImage"></span>
                        </g:else>
                    </div>
                    <div class="col-lg-11 col-sm-11 col-md-11 col-xs-10 show-all-padding">
                    	<textarea class="form-control show-textareawidth" name="comment" rows="4" required placeholder="Leave a comment">${commentval}</textarea>
                        <div class="col-xs-4 col-sm-2 col-md-2 col-lg-2 upload-btn">
                            <div class="fileUpload btn-sm sh-attach-btn">
                                <img alt="attach-file-img" src="//s3.amazonaws.com/crowdera/assets/61bdcd37-b1f9-4d7c-af21-377063443cab.png " class="sh-attach-file-icon">
                                <span>Attached File</span>
                                <input type="file" class="commentImgFile upload show-attach-file attachfileforcomments" name="attachFileUrls" accept="image/png, image/jpeg"/>
                            </div>
                        </div>
                        <g:if test="${projectComment?.attachFile != null && projectComment?.attachFile != 'null'}">
	                        <div class="col-sm-6 commentResultId">
	                             <div  class="comment-imgdiv comment-thumb-div sh-tabs-iconleft">
                                        <img alt="image" class='img-thumbnail pr-thumbnail' src='${projectComment?.attachFile}'>
                                        <div class="deleteicon comment-deleteicon">
                                            <img class="commentImgEdit" alt="cross"  src="//s3.amazonaws.com/crowdera/assets/delete.ico">
                                        </div>
                                 </div>
		                     </div>
	                     </g:if>
	                     <g:elseif test="${teamcomment?.attachteamfile !=null && teamcomment?.attachteamfile !='null'}">
	                     	<div class="col-sm-6 commentResultId">
	                             <div  class="comment-imgdiv comment-thumb-div sh-tabs-iconleft">
                                        <img alt="image" class='img-thumbnail pr-thumbnail' src='${teamcomment?.attachteamfile}'>
                                        <div class="deleteicon comment-deleteicon">
                                            <img class="commentImgEdit" alt="cross"  src="//s3.amazonaws.com/crowdera/assets/delete.ico">
                                        </div>
                                 </div>
		                     </div>
	                     </g:elseif>
	                     <g:else>
	                     	<div class="col-sm-6 commentResultId">
	                             <div class="comment-imgdiv comment-thumb-div sh-tabs-iconleft">
                                        <img alt="image" class='img-thumbnail pr-thumbnail' src='#'>
                                        <div class="deleteicon comment-deleteicon">
                                            <img class="commentImgDelete" alt="cross"  src="//s3.amazonaws.com/crowdera/assets/delete.ico">
                                        </div>
                                 </div>
		                     </div>
	                     </g:else>
                        <div class="clear"></div>
                         <label class="docfile-orglogo-css show-label-msz fileforcomments"></label> 
                    </div>
                </div>
                <button type="submit" class="btn show-btn-font btn-lg pull-right show-button-cmt">Save comment</button>
                <div class="clear"></div>
            </g:uploadForm>
        </div>
    </g:if>
	<g:else>
	     <div class="commentBox">
	         <g:if test="${team?.user!=project?.user}">
	             <g:uploadForm controller="project" action="teamcomment"  id="${project.id}" params="['fr': fundRaiser]">
	                 <div class="form-group show-padding-commentsbox col-lg-12 col-sm-12 col-md-12 col-xs-12">
	                     <div class="col-lg-1 col-sm-1 col-md-1 col-xs-2 show-comment-profile-padding">
                             <g:if test="${userService.isFacebookUser()}">
                                 <span><img class="show-cmment-box-imgheight" src="${userImage}" alt="userImage"></span>
                             </g:if>
                             <g:elseif test="${userService.isAdmin()}">
                                 <span><img class="show-cmment-box-imgheight" src="${userImage}" alt="userImage"></span>
                             </g:elseif>
                             <g:elseif test="${userService.isAuthor()}">
                                 <span><img class="show-cmment-box-imgheight" src="${userImage}" alt="userImage"></span>
                             </g:elseif>
                             <g:elseif test="${userService.isCommunityManager()}">
                                 <span><img class="show-cmment-box-imgheight" src="${userImage}" alt="userImage"></span>
                             </g:elseif>
                             <g:else>
                                  <span><img class="show-cmment-box-imgheight" src="${userImage}" alt="userImage"></span>
                             </g:else>
                         </div>
                         <div class="col-lg-11 col-sm-11 col-md-11 col-xs-10 show-all-padding">
                        	<textarea class="form-control show-textareawidth" name="comment" rows="4" required placeholder="Leave a comment">${commentval}</textarea>
                        	<div class="col-xs-4 col-sm-2 col-md-2 col-lg-2 upload-btn">
                            	<div class="fileUpload btn-sm sh-attach-btn">
                                	<img alt="attach-file-img" src="//s3.amazonaws.com/crowdera/assets/61bdcd37-b1f9-4d7c-af21-377063443cab.png " class="sh-attach-file-icon">
                                	<span>Attached File</span>
                                	<input  type="file" class="commentImgFile upload show-attach-file attachfileforcomments" name="teamAttachFile" accept="image/png, image/jpeg"/>
                            	</div>
                        	</div>
                        	<div class="col-sm-6 commentResultId">
	                             <div class="comment-imgdiv comment-thumb-div sh-tabs-iconleft">
                                    <img alt="image" class='comment-img-id img-thumbnail pr-thumbnail' src='#'>
                                    <div class="deleteicon comment-deleteicon">
                                        <img class="commentImgDelete" alt="cross"  src="//s3.amazonaws.com/crowdera/assets/delete.ico">
                                    </div>
                                </div>
	                         </div>
                         	<div class="clear"></div>
                         	<label class="docfile-orglogo-css show-label-msz fileforcomments"></label>  
                     	</div>
	                 </div>
	                 <button type="submit" class="btn  show-btn-font btn-lg pull-right show-button-cmt">Post comment</button>
	                 <div class="clear"></div>
	             </g:uploadForm>
	        </g:if>
	        <g:else>
	            <g:uploadForm controller="project" action="comment"  id="${project.id}" params="['fr':fundRaiser]">
	                <div class="form-group show-padding-commentsbox col-lg-12 col-sm-12 col-md-12  col-xs-12">
	                    <div class="col-lg-1 col-sm-1 col-md-1 col-xs-2 show-comment-profile-padding">
                          <g:if test="${userService.isFacebookUser()}">
                                <span><img class="show-cmment-box-imgheight" src="${userImage}" alt="userImage"></span>
                            </g:if>
                            <g:elseif test="${userService.isAdmin()}">
                                <span><img class="show-cmment-box-imgheight" src="${userImage}" alt="userImage"></span>
                            </g:elseif>
                            <g:elseif test="${userService.isAuthor()}">
                                <span><img class="show-cmment-box-imgheight" src="${userImage}" alt="userImage"></span>
                            </g:elseif>
                            <g:elseif test="${userService.isCommunityManager()}">
                                <span><img class="show-cmment-box-imgheight" src="${userImage}" alt="userImage"></span>
                            </g:elseif>
                            <g:else>
                                <span><img class="show-cmment-box-imgheight" src="${userImage}" alt="userImage"></span>
                            </g:else>
	                     </div>
	                     
	                     <div class="col-lg-11 col-sm-11 col-md-11 col-xs-10 show-all-padding">
	                        <textarea class="form-control show-textareawidth" name="comment" rows="4" required placeholder="Leave a comment">${commentval}</textarea>
	                        <div class="col-xs-4 col-sm-2 col-md-2 col-lg-2 upload-btn">
	                            <div class="fileUpload btn-sm sh-attach-btn">
	                                <img alt="attach-img-file" src="//s3.amazonaws.com/crowdera/assets/61bdcd37-b1f9-4d7c-af21-377063443cab.png " class="sh-attach-file-icon">
	                                <span>Attached File</span>
	                                <input  type="file" class="commentImgFile upload show-attach-file attachfileforcomments" name="attachedFileForProject" accept="image/png, image/jpeg"/>
	                            </div>
	                         </div>
	                         <div class="col-sm-6 commentResultId">
	                             <div class="comment-imgdiv comment-thumb-div sh-tabs-iconleft">
                                        <img alt="image" class='comment-img-id img-thumbnail pr-thumbnail' src='#'>
                                        <div class="deleteicon comment-deleteicon">
                                            <img class="commentImgDelete" alt="cross"  src="//s3.amazonaws.com/crowdera/assets/delete.ico">
                                        </div>
                                    </div>
	                         </div>
	                         <div class="clear"></div>
	                         <label class="docfile-orglogo-css show-label-msz fileforcomments"></label> 
	                     </div>
	                </div>
	                <button type="submit" class="btn btn-lg pull-right show-btn-font show-button-cmt">Post comment</button>
	                <div class="clear"></div>
	            </g:uploadForm>
	        </g:else>
	    </div>
	</g:else>
</g:if>
<g:else>
    <h3 class="hidden-xs"><b>Comments</b></h3>
    <div class="alert alert-info sh-comnt-align hidden-xs">No Comments yet.</div>
</g:else>
     
<g:if test="${!listcomment.isEmpty()}">
    <div class="panel panel-default show-comments-details">
        <div class="panel-body commentsoncampaign">
            <div class="list-group">
                <g:each in="${listcomment}" var="comment">
                    <%
                        def date = dateFormat.format(comment.date)
                        def isAnonymous = userService.isAnonymous(comment?.user)
                    %>
                    <g:if test="${user== project?.user}">
                        <g:if test="${!comment.status}">
                            <div class="panel-body tile-footer show-comments-date">
				                <g:if test="${isAnonymous}">
                                    <span class="dt">By ${comment?.userName}, on ${date}</span><br>
                                </g:if>
                                <g:else>
                                    <span class="dt">By ${userService.getFriendlyFullName(comment?.user)}, on ${date}</span><br>
                                </g:else>
				                <span class="dd">${comment.comment}</span>
				                <div class="clear"></div>
				                <g:if test="${team?.user == project?.user}">
	                            	<g:if test="${comment?.attachFile != null && comment?.attachFile != 'null'}">
		                             	<div class="${currentUser?'col-sm-6':''} comment-attach-img">
	                                        <img alt="image" class='img-thumbnail comment-thumbnail' src='${comment?.attachFile}'>
	                                 	</div>
		                     		</g:if>
	                     		</g:if>
	                     		<g:else>
	                     			<g:if test="${comment?.attachteamfile != null && comment?.attachteamfile != 'null'}">
		                             	<div class="${currentUser?'col-sm-6':''} comment-attach-img">
	                                        <img alt="image" class='img-thumbnail comment-thumbnail' src='${comment?.attachteamfile}'>
	                                 	</div>
		                     		</g:if>
	                     		</g:else>
                                <g:if test="${comment?.user == currentUser || project?.user == currentUser}">
                                    <div class="editAndDeleteBtn deleteComment">
                                        <g:form controller="project" action="commentdelete" method="post" params="['projectId':projectId, 'fr': fundRaiser]">
                                            <input type="hidden" name='commentId' value="${comment.id}"/>
                                            <button class="projectedit close" onclick="return confirm(&#39;Are you sure you want to discard this comment?&#39;);">
                                           <i class="glyphicon glyphicon-trash"></i>
                                            </button>
                                        </g:form>
                                        <g:if test="${comment?.user == currentUser}">
                                            <form name="editComment" action="/project/editComment" method="post"  >
                                                <input type="hidden" name='projectTitle' value="${vanityTitle}"/>
                                                <input type="hidden" name='fr' value="${fundRaiser}"/>
                                                <input type="hidden" name='commentId' value="${comment.id}"/>
                                                <button type="submit" class="projectedit close">
                                                    <i class="glyphicon glyphicon-edit glyphicon-lg projectedit"></i>
                                                </button>
                                            </form>
                                        </g:if>
                                    </div>
                                </g:if>
			                </div>
			            </g:if>
                    </g:if>
                    <g:else>
                        <div class="panel-body tile-footer show-comments-date">
                            <g:if test="${isAnonymous}">
                                <span class="dt">By ${comment?.userName}, on ${date}</span><br>
                            </g:if>
                            <g:else>
                                <span class="dt">By ${userService.getFriendlyFullName(comment?.user)}, on ${date}</span><br>
                            </g:else>
                            <span class="dd">${comment.comment}</span>
                            <div class="clear"></div>
                            <g:if test="${team?.user == project?.user}">
	                            <g:if test="${comment?.attachFile != null && comment?.attachFile != 'null'}">
		                             <div class="${currentUser?'col-sm-6':''} comment-attach-img">
	                                        <img alt="image" class='img-thumbnail comment-thumbnail' src='${comment?.attachFile}'>
	                                 </div>
		                     	</g:if>
	                     	</g:if>
	                     	<g:else>
	                     		<g:if test="${comment?.attachteamfile != null && comment?.attachteamfile != 'null'}">
		                             <div class="${currentUser?'col-sm-6':''} comment-attach-img">
	                                        <img alt="image" class='img-thumbnail comment-thumbnail' src='${comment?.attachteamfile}'>
	                                 </div>
		                     	</g:if>
	                     	</g:else>
                            <g:if test="${team?.user!=project?.user || comment?.user == currentUser}">
                                <g:if test="${team?.user == currentUser || comment?.user == currentUser}">
                                    <div class="editAndDeleteBtn deleteComment">
                                        <g:form controller="project" action="commentdelete" method="post" params="['projectId':projectId, 'fr': fundRaiser]">
                                            <input type="hidden" name='teamCommentId' value="${comment.id}"/>
                                            <button class="projectedit close" onclick="return confirm(&#39;Are you sure you want to discard this comment?&#39;);">
                                            <i class="glyphicon glyphicon-trash"></i>
                                            </button>
                                        </g:form>
                                        <g:if test="${comment?.user == currentUser}">
                                            <form  name="editcomment" action="/project/editComment" method="post">
                                                <input type="hidden" name='projectTitle' value="${vanityTitle}"/>
                                                <input type="hidden" name='fr' value="${fundRaiser}"/>
                                                <input type="hidden" name='teamCommentId' value="${comment.id}"/>
                                                    <button type="submit" class="projectedit close pull-right">
                                                        <i class="glyphicon glyphicon-edit glyphicon-lg projectedit"></i>
                                                    </button>
                                            </form>
                                        </g:if>
                                    </div>
                                </g:if>
                            </g:if>
                        </div>
                    </g:else>
                </g:each>
            </div>
        </div>
    </div>
</g:if>
