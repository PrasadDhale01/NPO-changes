<g:set var="contributionService" bean="contributionService"/>
<g:set var="projectService" bean="projectService"/>
<%
    def percentage = contributionService.getPercentageContributionForProject(project)
    def firstAdmins = project.projectAdmins[1]
    def secondAdmins = project.projectAdmins[2]
    def thirdAdmins = project.projectAdmins[3]
    def eamil1
    def email2
    def email3
    if (firstAdmins) {
        email1 = firstAdmins.getEmail()
    }
    if (secondAdmins) {
        email2 = secondAdmins.getEmail()
    }
    if (thirdAdmins) {
        email3 = thirdAdmins.getEmail()
    }

    def endDate = projectService.getProjectEndDate(project)
    def campaigndate = endDate.getTime().format('MM/dd/yyyy')
%>
<html>
<head>
    <meta name="layout" content="main" />
    <r:require modules="projecteditjs"/>
    <ckeditor:resources/>
    <link rel="stylesheet" href="/bootswatch-yeti/bootstrap.css">
    <link rel="stylesheet" href="/css/datepicker.css">
    <script src="/js/main.js"></script>
    <script src="/js/bootstrap-datepicker.js"></script>
    <script>
    var j = jQuery.noConflict();
        j(function(){
            j('.datepicker').datepicker();
        });
    </script>
</head>
<body>
<input type="hidden" name="uuid" id="uuid"/>
<input type="hidden" name="charity_name" id="charity_name"/>
<div class="feducontent">
	<div class="container">
		<h1><span class="glyphicon glyphicon-edit"></span> Edit Campaign</h1>

        <g:uploadForm class="form-horizontal" controller="project" action="update" method="post" role="form">
            <input type="hidden" name="_method" value="PUT" id="_method" />

			<div class="panel panel-default">
				<div class="panel-heading">
					<h3 class="panel-title">Campaign Creator</h3>
				</div>
				<div class="panel-body">
                    <div class="row">
                        <div class="col col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-4 control-label">First Name</label>
                                <div class="col-sm-8">
                                    <input id="firstName" class="form-control" name="${FORMCONSTANTS.FIRSTNAME}" value="${project.beneficiary.firstName}" disabled>
                                    <g:hiddenField name="projectId" value="${project.id}"/>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-4 control-label">Last Name</label>
                                <div class="col-sm-8">
                                    <input id="lastName" class="form-control" name="${FORMCONSTANTS.LASTNAME}" value="${project.beneficiary.lastName}" disabled>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-4 control-label">Email</label>
                                <div class="col-sm-8">
                                    <input id="email" type="email" class="form-control" name="${FORMCONSTANTS.EMAIL}" value="${project.beneficiary.email}" disabled>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-4 control-label">Telephone</label>
                                <div class="col-sm-8">
                                    <input class="form-control" name="${FORMCONSTANTS.TELEPHONE}" value="${project.beneficiary.telephone}" disabled>
                                </div>
                            </div>
                        </div>
                        <div class="col col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-2 control-label">Address</label>
                                <div class="col-sm-10">
                                    <input type="text" name="${FORMCONSTANTS.ADDRESSLINE1}" value="${project.beneficiary.addressLine1}" class="form-control" disabled>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-2 control-label">Address</label>
                                <div class="col-sm-10">
                                    <input type="text" name="${FORMCONSTANTS.ADDRESSLINE2}" value="${project.beneficiary.addressLine2}" class="form-control" disabled>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-2 control-label">City</label>
                                <div class="col-sm-10">
                                    <input type="text" name="${FORMCONSTANTS.CITY}" value="${project.beneficiary.city}" class="form-control" disabled>
                                </div>
                            </div>
                            
                            <div class="form-group">
                                <label class="col-sm-2 control-label">State</label>
                                <div class="col-sm-4">
                                    <input type="text" name="${FORMCONSTANTS.STATEORPROVINCE}" value="${project.beneficiary.stateOrProvince}" class="form-control" disabled>
                                </div>
                                <label class="col-sm-2 control-label">Postcode</label>
                                <div class="col-sm-4">
                                    <input type="text" name="${FORMCONSTANTS.POSTALCODE}" value="${project.beneficiary.postalCode}" class="form-control" disabled>
                                </div>
                            </div>

                            <div class="form-group">
                                <label class="col-sm-2 control-label">Country</label>
                                <div class="col-sm-10">
                                    <input type="text" name="${FORMCONSTANTS.COUNTRY}" value="${project.beneficiary.country}" class="form-control" disabled>
                                </div>
                            </div>
                        </div>
                    </div>
				</div>
			</div>
            
            <div class="panel panel-default">
                <div class="panel-heading">
                    <h3 class="panel-title">Organization</h3>
                </div>
                <div class="panel-body">
                    <div class="form-group" id="charitableId">
                    	<div class="row">
                    	    <div class="col-sm-6" >
                    	    	<g:if test="${project.charitableId}">
	                    			<label class="col-sm-4 control-label">Charitable ID</label>
	                   		    	<div class="col-sm-8" id="charitable">
	                                	<input type="text"  class="form-control" name="${FORMCONSTANTS.CHARITABLE}" value="${project.charitableId}" placeholder="CharitableId" readonly>
	                       	    	</div>
	                       	    </g:if>
	                       	    <g:else>
	                       	    	<label class="col-sm-4 control-label">PaypalEmail ID</label>
	                   		    	<div class="col-sm-8" id="charitable">
	                                	<input type="text"  class="form-control" name="${FORMCONSTANTS.PAYPALEMAIL}" value="${project.paypalEmail}" placeholder="PaypalEmail Id" readonly>
	                       	    	</div>
	                       	    </g:else>
                            </div>
                            
                            <div class="modal" id="myModal">
                                <div class="modal-dialog">
                                    <div class="modal-content">
                                        <div class="modal-header">
                                            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                                            <h4 class="modal-title">Find your charity organization</h4>
                                        </div>
                                        <div class="modal-body">
                                            <div id="fgGraphWidgetContainer"></div>
                                            <script>
                                            var FG_GRAPHWIDGET_PARAMS = {
                                                results : {
                                                    selectaction : function(uuid,charity_name) {
                                                        document.getElementById("uuid").value=uuid;
                                                        document.getElementById("charity_name").value=charity_name;
                                                    }
                                                }
                                            };
                                            function setOrganization() {
                                                $('#charitable').find('input').val(document.getElementById("uuid").value);
                                                $('#organizationName').find('input').val(document.getElementById("charity_name").value);
                                            }
                                            </script>
                                            <script src="http://assets.firstgiving.com/graphwidget/static/js/fg_graph_widget.min.js"></script>
                                        </div>
                                        <div class="modal-footer">
                                            <button href="#" data-dismiss="modal" class="btn btn-primary">Close</button>
                                            <button class="btn btn-primary" href="#" data-dismiss="modal" onclick="setOrganization()" id="saveButton">Save</button>
                                        </div>
                                    </div>
                                </div>
                            </div>        
                        </div>
                    </div>
                    <hr>
                    <div class="row">
                        <div class="col col-sm-6">
                            <div class="form-group" id="organizationName">
                                <label class="col-sm-4 control-label" id="organizationName">Organization Name</label>
                                <div class="col-sm-8">
                                    <input  class="form-control" name="${FORMCONSTANTS.ORGANIZATIONNAME}" value="${project.organizationName}" id="organizationname" placeholder="Organization Name" disabled>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-4 control-label" id="iconfiles">Organization Logo</label>
                                <div class="col-sm-4">
                                    <input type="file" id="iconfile" name="iconfile">
                                    <button id="chooseFile" class="btn btn-primary" type="button">
                                            <i class="icon-file"></i> Choose File
                                     </button>
                                </div>
                                <div id="icondiv" class="pr-icon-thumbnail-div col-sm-4">
                                        <img id="imgIcon" class="pr-icon-thumbnail" src="${project.organizationIconUrl}" />
                                </div>
                            </div>
                        </div>
                        <div class="col col-sm-6">
                            <div class="form-group">
                                <label class="col-sm-4 control-label" id="webAddress">Web Address</label>
                                <div class="col-sm-8">
                                    <input  class="form-control" name="${FORMCONSTANTS.WEBADDRESS }" value="${project.webAddress}" placeholder="Web Address">
                                </div>
                            </div>
                        </div>
                    </div>
               </div>
            </div>
            
            <div class="panel panel-default">
                <div class="panel-heading">
                    <h3 class="panel-title">Campaign Co-Creators</h3>
                </div>
                <div class="panel-body">
                    <div class="col-sm-6">
	                    <div class="form-group">
	                        <label class="col-sm-4 control-label">First Admin</label>
	                        <div class="col-sm-8">
	                            <input type="text" class="form-control" name="email1" value="${email1}" id="firstadmin" placeholder="Email ID" ></input>
					        </div>
	                    </div>
	                    <div class="form-group">
	                        <label class="col-sm-4 control-label">Second Admin</label>
	                        <div class="col-sm-8">
	                            <input type="text" class="form-control" name="email2" value="${email2}" id="secondadmin" placeholder="Email ID"></input>
					        </div>
	                    </div>
                    </div>
                    
                    <div class="col-sm-6">
	                    <div class="form-group">
	                        <label class="col-sm-4 control-label">Third Admin</label>
	                        <div class="col-sm-8">
	                            <input type="text" class="form-control" name="email3" id="thirdadmin" value="${email3}" placeholder="Email ID"></input>
					        </div>
	                    </div>
                    </div>
                </div>
            </div>

            <div class="panel panel-default">
                <div class="panel-heading">
                    <h3 class="panel-title">Funding Goal and Campaign End Date</h3>
                </div>
                <div class="panel-body">
                    <div class="form-group">
                        <label class="col-sm-2 control-label">Amount</label>
                        <div class="col-sm-10">
                            <input class="form-control" name="${FORMCONSTANTS.AMOUNT}" value="${project.amount}">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">Campaign end date</label>
                        <div class="col-sm-10">
                            <div class="input-group enddate"><span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>
                                <input class="datepicker pull-left" name="${FORMCONSTANTS.DAYS}" value="${campaigndate}" placeholder="Campaign end date"> 
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <div class="panel panel-default">
                <div class="panel-heading">
                    <h3 class="panel-title">Tell Us About Your Campaign</h3>
                </div>
                <div class="panel-body">
                    <div class="form-group">
                        <label class="col-sm-2 control-label">Category</label>
                        <div class="col-sm-10">
                            <g:select class="selectpicker" name="${FORMCONSTANTS.CATEGORY}"
                                      from="${categoryOptions}" value="${project.category}"
                                      optionKey="key" optionValue="value"/>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">Campaign title</label>
                        <div class="col-sm-10">
                            <input class="form-control" name="${FORMCONSTANTS.TITLE}" value="${project.title}">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">Brief Description</label>
                        <div class="col-sm-10">
                            <textarea class="form-control" name="${FORMCONSTANTS.DESCRIPTION}" rows="2" placeholder="Make it catchy, and no more than 140 characters"> ${project.description} </textarea>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">Story</label>
                        <div class="col-sm-10">
                            <ckeditor:config var="toolbar_Mytoolbar">
                                [
                                    ['Bold', 'Italic', 'Underline','Strike','Subscript', 'Superscript','-', 'RemoveFormat',],
                                    ['Link','Unlink','Anchor'],
                                    ['Styles','Format','Font','FontSize'],
                                    ['Maximize'],['TextColor'],
                                    [ 'Image','Flash','Table','HorizontalRule','Smiley','SpecialChar','PageBreak','Iframe' ]
                                ]
                            </ckeditor:config>
                            
                            <ckeditor:editor toolbar="Mytoolbar" name="${FORMCONSTANTS.STORY}" id="${FORMCONSTANTS.STORY}" height="200px" width="100%">
                                ${project.story}
                            </ckeditor:editor>
                        </div>
                    </div>
                      
                </div>
            </div>
            
            <div class="panel panel-default">
                <div class="panel-heading">
                    <h3 class="panel-title">Campaign Images and Video</h3>
                </div>
                <div class="panel-body">
                    <div class="form-group">
                        <label class="col-sm-2 control-label">Pictures</label>
                        <div class="col-sm-2">
                            <button id="add_img_btn" class="btn btn-primary btnAddImage"type="button">
                                    <i class="icon-file"></i> Add Image
                            </button>
                            <input type="file" name="${FORMCONSTANTS.THUMBNAIL}[]" id="projectImageFile" multiple="multiple" class="hidden">
                        </div>
                        <div class="col-sm-8">
                                <g:each var="imgurl" in="${project.imageUrl}">
                                    <img src="${imgurl.url }" style="width:50px;height:50px;"/>
                                </g:each>
                                <output id="result"></output>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">Video URL</label>
                        <div class="col-sm-4">
                            <input id="videoUrl" class="form-control" name="${FORMCONSTANTS.VIDEO}" value="${project.videoUrl}">
                        </div>
                        <iframe id="ytVideo" style="width:200px;height:100px; display:block;" src="${project.videoUrl}"></iframe>
                    </div>
                </div>
            </div>

            <div class="panel panel-default">
                <div class="panel-heading">
                    <h3 class="panel-title">Get set, go</h3>
                </div>
                <div class="panel-body">
		            <div class="form-group">
                        <label class="col-sm-2 control-label">Save changes?</label>
		                <div class="col-sm-10">
		                    <button type="submit" name="_action_update" value="Update" class="btn btn-primary">Save</button>
		                </div>
		            </div>
                </div>
            </div>

		</g:uploadForm>
	</div>
</div>

</body>
</html>
