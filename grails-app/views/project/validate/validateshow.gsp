<%@ page import="java.text.SimpleDateFormat"%>
<g:set var="projectService" bean="projectService" />
<g:set var="userService" bean="userService" />
<%
    def projectTitle = project.title
    if (projectTitle) {
        projectTitle = projectTitle.toUpperCase(Locale.ENGLISH)
    }
    def currentTeamAmount = currentTeam.amount
    boolean isvalidateShow = true
%>
<html>
<head>
    <meta name="layout" content="main"/>
    <r:require modules="projectshowjs"/>
    <r:require modules="rewardjs"/>
    <r:require module="sidebarcss"/>
</head>
<body>
    <div class="validate-show-div">
    
        <div id="wrapper">

        <!-- Sidebar -->
        <div class="hidden-xs" id="sidebar-wrapper">
            <ul class="sidebar-nav">
                <li class="sidebar-brand">
                    <input name="approveChk[]" type="checkbox"/><label class="control-label"><b>Eyeball 1</b></label>
                </li>
                <li>
                    <input name="approveChk[]" type="checkbox"/><label class="control-label"><b>Eyeball 2</b></label>
                </li>
                <li>
                    <input name="approveChk[]" type="checkbox"/><label class="control-label"><b>Social References</b></label>
                </li>
                <li>
                    <input name="approveChk[]" type="checkbox"/><label class="control-label"><b>Website</b></label>
                </li>
                <li>
                    <input name="approveChk[]" type="checkbox"/><label class="control-label"><b>Founder</b></label>
                </li>
                <li>
                    <input name="approveChk[]" type="checkbox"/><label class="control-label"><b>Cause</b></label>
                </li>
                <li>
                    <input name="approveChk[]" type="checkbox"/><label class="control-label"><b>Documents</b></label>
                </li>
                <li>
                    <input name="approveChk[]" type="checkbox"/><label class="control-label"><b>Feasibility</b></label>
                </li>
                <li>
                    <input name="approveChk[]" type="checkbox"/><label class="control-label"><b>Grammer</b></label>
                </li>
                <li>
                    <input name="approveChk[]" type="checkbox"/><label class="control-label"><b>Images</b></label>
                </li>
                <li>
                    <input name="approveChk[]" type="checkbox"/><label class="control-label"><b>Video</b></label>
                </li>
                <li>
                    <input name="approveChk[]" type="checkbox"/><label class="control-label"><b>Verified</b></label>
                </li>
            </ul>
        </div>
        <!-- /#sidebar-wrapper -->
        
        <!-- Page Content -->
        <div id="page-content-wrapper">
            <div class="container-fluid">
              <div class="col-lg-offset-0 col-md-offset-0 col-lg-12 col-md-12 col-sm-offset-0 col-sm-12 col-xs-12">
                    <div class="alert alert-info text-center" id="validateChecklistmsg">
                        Please verify the complete checklist
                    </div>
                    <h1 class="green-heading validatecampaignTitle">
                        <g:link controller="project" action="validateshow" id="${project.id}" title="${project.title}"> ${projectTitle} </g:link>
                    </h1>
                </div>
                <div class="col-lg-offset-0 col-md-offset-0 col-lg-12 col-md-12 col-sm-offset-0 col-sm-12">
                    
                    <div class="col-lg-offset-0 col-lg-4 col-md-offset-0 col-md-4 col-sm-offset-0 col-sm-6 col-xs-12">
                        <% 
                            def beneficiary = project.user
                        %>
                        <div class="panel panel-default org-panel-1 organization-panel">
                            <div class="organization-details text-center">
                                <h6><b>Campaign by</b> ${beneficiary.firstName}</h6>
                                <h5><b class="TW-org-title-font-size">${project.organizationName}</b></h5>
                                <g:if test="${project.organizationIconUrl}">
                                    <img alt="Organization" src="${project.organizationIconUrl}" class="org-logo">
                                </g:if>
                                <g:else>
                                    <img alt="Upload Icon" src="//s3.amazonaws.com/crowdera/assets/defaultOrgIcon.jpg" class="org-logo">
                                </g:else>
                                <g:if test="${project.webAddress}">
                                    <br><label>Web: <a href="${webUrl}" target="${webUrl}">${project.webAddress}</a></label>
                                </g:if>
                            </div>
                            <g:render template="/layouts/tilesanstitle" model="['currentTeamAmount':currentTeamAmount]"/>
                        </div>
                        <a class="btn btn-sm btn-block btn-default validatebutton TW-text-decoration visible-xs">ON HOLD</a>
                        <g:link controller="project" action="updateValidation" id="${project.id}" class="btn btn-sm btn-block btn-primary validatebutton TW-text-decoration hidden-sm approvebtn-md" role="button">
                            <i class="glyphicon glyphicon-check validateshow-validate"></i>&nbsp;APPROVE
                        </g:link>
                        <g:form action="delete" controller="project" id="${project.id}" method="post">
                            <button class="validatebtn btn btn-sm btn-danger btn-block validateshow-discard visible-xs" name="_action_delete" value="Delete" onclick="return confirm(&#39;Are you sure you want to reject this campaign?&#39;);"><i class="fa fa-trash-o"></i>&nbsp;REJECT</button>
                        </g:form>
                    </div>
                    <div class="col-lg-4 col-md-4 col-sm-6 col-xs-12">
                        <g:render template="/layouts/personaldetails"/>
                        <a class="btn btn-sm btn-block btn-default validatebutton TW-text-decoration hidden-xs">ON HOLD</a>
                        <g:link controller="project" action="updateValidation" id="${project.id}" class="visible-sm btn btn-sm btn-block btn-primary validatebutton TW-text-decoration approvebtn-sm" role="button">
                            <i class="glyphicon glyphicon-check validateshow-validate"></i>&nbsp;APPROVE
                        </g:link>
                        
                        <g:form action="delete" controller="project" id="${project.id}" method="post">
                            <button class="validatebtn btn btn-sm btn-danger btn-block validateshow-discard visible-sm" name="_action_delete" value="Delete" onclick="return confirm(&#39;Are you sure you want to reject this campaign?&#39;);"><i class="fa fa-trash-o"></i>&nbsp;REJECT</button>
                        </g:form>
                    </div>
                    <div class="clear visible-sm"></div>
                    <div class="col-lg-offset-0 col-lg-4 col-md-4 col-sm-6 col-xs-12">
                        <div class="panel panel-default organization-panel org-panel-3 org-padding">
                            <h6 class="text-center"><b>Details</b></h6>
                            <g:if test='${project.charitableId}'>
                                <label><b>Payment mode : </b>FirstGiving</label><br>
                                <label><b>Charitable ID: </b>${project.charitableId }</label><br>
                            </g:if>
                            <g:elseif test='${project.payuEmail}'>
                                <label><b>Payment mode : </b>payUMoney</label><br>
                                <label><b>PayUMoney Email: </b>${project.payuEmail }</label><br>
                            </g:elseif>
                            <g:else>
                                <label><b>Payment mode : </b>Paypal</label><br>
                                <label><b>Paypal Email : </b>${project.paypalEmail}</label><br>
                            </g:else>
                            <label><b>Purpose : </b>${project.usedFor}</label><br>
                            <label><b>Category : </b>${project.category}</label><br>
                            <g:if test="${project.rewards.size() > 1}">
                                <label><b>Rewards : </b>${project.rewards.size()}</label><br>
                            </g:if>
                            <g:else>
                                <label><b>Rewards : </b> No Rewards</label><br>
                            </g:else>
                            <label><b>Teams : </b>${project.teams.size()}</label>
                        </div>
                        <g:form action="delete" controller="project" id="${project.id}" method="post">
                            <button class="validatebtn btn btn-sm btn-danger btn-block hidden-sm hidden-xs validateshow-discard" name="_action_delete" value="Delete" onclick="return confirm(&#39;Are you sure you want to reject this campaign?&#39;);"><i class="fa fa-trash-o"></i>&nbsp;REJECT</button>
                        </g:form>
                    </div>
                    <div class="col-lg-offset-0 col-lg-4 col-md-4 col-sm-6 col-xs-12 visible-sm">
                        <div class="panel panel-default organization-panel org-panel-4 org-padding">
                            <g:if test="${project.projectAdmins.email.size() > 1}">
                                <div class="coCreator">
                                    <h6 class="text-center"><b>Campaign Co-Creator</b></h6><hr class="hrClasses"/>
                                    <g:each in="${project.projectAdmins.email}" var="admin">
                                       <g:if test="${admin != "campaignadmin@crowdera.co"}">
                                           <label>${admin}</label><br>
                                       </g:if>
                                    </g:each>
                                </div>
                            </g:if>
                            <g:else>
                                <h6 class="text-center"><b>No Campaign Admins</b></h6>
                            </g:else>
                        </div>
                    </div>
        
                    <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12 validateshowtab <g:if test="${rewards.size() > 1}">rewards_tab</g:if><g:else>validate_story_tab</g:else>">
                        <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12 tabborders">
                            <g:set var="screen" id="screen" value="false"></g:set>
                            <ul class="nav nav-pills nav-justi nav-justified show-marginbottoms sh-tabs mng-safari-mobile show-new-tabs-alignments<g:if test="${!project.projectUpdates.isEmpty()}"> TW-show-updateTab-width </g:if><g:else> mng-dt-tabs </g:else>">
                                <li>
                                    <span class="active show-tbs-right-borders">
                                        <a href="#story" data-toggle="tab" class="show-tabs-text sh-selected essentials">
                                            <span class="tab-text"> STORY</span>
                                        </a>
                                    </span>
                                </li>
                                <li class="hidden-xs">
                                    <span class="show-tbs-right-borders hidden-xs">
                                        <a href="#manageTeam" data-toggle="tab"  class="show-tabs-text manageTeam">
                                            <span class="tab-text"> TEAMS</span>
                                        </a>
                                    </span>
                                </li>
                                <g:if test="${rewards.size() > 1}">
                                    <li>
                                        <span class="show-tbs-right-borders validaterewards">
                                            <a href="#rewards" data-toggle="tab" class="show-tabs-text">
                                                <span class="tab-text"> REWARDS</span>
                                            </a>
                                        </span>
                                    </li>
                                </g:if>
                                <li class="hidden-xs">
                                    <span class="show-tbs-right-borders hidden-xs">
                                        <a href="#contributions" data-toggle="tab"  class="show-tabs-text contributions">
                                            <span class="tab-text"> CONTRIBUTIONS</span>
                                        </a>
                                    </span>
                                </li>
                                <li class="hidden-xs">
                                    <span class="show-comit-lft hidden-xs">
                                        <a href="#comments" data-toggle="tab"  class="show-tabs-text comments">
                                            <span class="tab-text hidden-xs"> COMMENTS</span>
                                        </a>
                                    </span>
                                </li>
                            </ul>
                        </div>
                    </div>
                    <div class="col-lg-offset-1 col-lg-10 col-md-offset-1 col-md-10 col-sm-offset-0 col-sm-12 col-xs-12">
                        <!-- Tab panes -->
                        <div class="tab-content">
                            <div class="tab-pane active" id="story">
                                <g:render template="show/story" model="['isvalidateShow': isvalidateShow]"/>
                            </div>
                            <g:if test="${rewards.size() > 1}">
                                <div class="tab-pane" id="rewards">
                                    <g:render template="validate/rewardgrid"/>
                                </div>
                            </g:if>
                            <div class="tab-pane" id="manageTeam">
                                <g:render template="manageproject/manageteam"/>
                            </div>
                            <div class="tab-pane" id="contributions">
                                <g:render template="manageproject/contributions" model="['team':currentTeam]"/>
                            </div>
                            <div class="tab-pane" id="comments">
                                <g:render template="show/comments"/>
                            </div>
                        </div>
                    </div>
                </div>
                
                <div class="col-lg-2 col-md-2 col-sm-3 col-xs-12 side-bar-top visible-xs">
                    <div class="panel panel-default validate-side-bar" id="validate-side-bar">
                        <div class="form-group">
                            <label class="control-label"><b>Eyeball 1</b></label><input name="approveChk[]" type="checkbox"/>
                        </div>
                        <div class="form-group">
                            <label class="control-label"><b>Eyeball 2</b></label><input name="approveChk[]" type="checkbox"/>
                        </div>
                        <div class="form-group">
                            <label class="control-label"><b>Social References</b></label><input name="approveChk[]" type="checkbox"/>
                        </div>
                        <div class="form-group">
                            <label class="control-label"><b>Website</b></label><input name="approveChk[]" type="checkbox"/>
                        </div>
                        <div class="form-group">
                            <label class="control-label"><b>Founder</b></label><input name="approveChk[]" type="checkbox"/>
                        </div>
                        <div class="form-group">
                            <label class="control-label"><b>Cause</b></label><input name="approveChk[]" type="checkbox"/>
                        </div>
                        <div class="form-group">
                            <label class="control-label"><b>Documents</b></label><input name="approveChk[]" type="checkbox"/>
                        </div>
                        <div class="form-group">
                            <label class="control-label"><b>Feasibility</b></label><input name="approveChk[]" type="checkbox"/>
                        </div>
                        <div class="form-group">
                            <label class="control-label"><b>Grammer</b></label><input name="approveChk[]" type="checkbox"/>
                        </div>
                        <div class="form-group">
                            <label class="control-label"><b>Images</b></label><input name="approveChk[]" type="checkbox"/>
                        </div>
                        <div class="form-group">
                            <label class="control-label"><b>Video</b></label><input name="approveChk[]" type="checkbox"/>
                        </div>
                        <div class="form-group">
                            <label class="control-label"><b>Verified</b></label><input name="approveChk[]" type="checkbox"/>
                        </div>
                    </div>
                </div>
            </div>
        
        </div>
        <!-- /#page-content-wrapper -->

    </div>
    <!-- /#wrapper -->
    </div>
    
</body>
</html>
