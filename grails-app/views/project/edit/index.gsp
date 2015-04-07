<g:set var="contributionService" bean="contributionService"/>
<g:set var="projectService" bean="projectService"/>
<g:set var="userService" bean="userService"/>
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
    def amount = projectService.getDataType(project.amount)
    def base_url = grailsApplication.config.crowdera.BASE_URL
    def numberOfDays = projectService.getDaysFromStartDate(project)
    def currentUser = userService.getCurrentUser()
%>
<html>
<head>
    <meta name="layout" content="main" />
    <r:require modules="projecteditjs"/>
    <link rel="stylesheet" href="/bootswatch-yeti/bootstrap.css">
    <link rel="stylesheet" href="/css/datepicker.css">
    <script src="//tinymce.cachefly.net/4.1/tinymce.min.js"></script>
    <script src="/js/main.js"></script>
    <script src="/js/bootstrap-datepicker.js"></script>
    <script>
   

        tinymce.init({
        	mode : "specific_textareas",
        	menubar: "edit insert view format",
            editor_selector : "mceEditor",
            plugins: [
                      "advlist autolink lists link image media charmap print preview hr anchor pagebreak emoticons",
                  ],
                  toolbar: "| undo redo | bold italic | alignleft aligncenter alignright alignjustify | bullist numlist outdent indent | link image media forecolor backcolor emoticons",
                  image_advtab: true,
                  templates: [
                      {title: 'Test template 1', content: 'Test 1'},
                      {title: 'Test template 2', content: 'Test 2'}
                  ]
        });

        var needToConfirm = true;
        window.onbeforeunload = confirmExit;
        function confirmExit()
        {
            if(needToConfirm){
            	return "You have attempted to leave this page.  If you have made any changes to the fields without clicking the Save button, your changes will be lost.  Are you sure you want to exit this page?";
            }
        }
    </script>
</head>
<body>
<input type="hidden" id="b_url" value="<%=base_url%>" />
<input type="hidden" class="campaigndate" value="<%=numberOfDays%>"/>
<input type="hidden" name="uuid" id="uuid"/>
<input type="hidden" name="charity_name" id="charity_name"/>
<div class="feducontent">
	<div class="container">
		<h1><img class="img-circle" src="/images/icon-edit.png" alt="Edit Campaign"/> Edit Campaign</h1>

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
                                    <input type="file" id="orgediticonfile" name="iconfile" accept="image/*">
                                    <button id="chooseFile" class="btn btn-primary btn-sm" type="button">
                                            <i class="icon-file"></i> Choose File
                                    </button>
                                    <label class="docfile-orglogo-css" id="editlogo">Please select image file.</label>
                                    <label class="docfile-orglogo-css" id="iconfilesize">The file you are attempting to upload is larger than the permitted size of 3MB.</label>
                                </div>
                                <div id="icondiv" class="pr-icon-thumbnail-div col-sm-4">
                                        <g:if test="${project.organizationIconUrl}">
                                            <img id="imgIcon" alt="cross" class="pr-icon-thumbnail" src="${project.organizationIconUrl}" />
                                            <div class="deleteicon orgicon-css-styles">
                                                <img alt="cross" onClick="deleteOrganizationLogo(this,'${project.id}');"
                                                src="/images/delete.ico" id="logoDelete"/>
                                            </div>
                                        </g:if>
                                        <g:else>
                                            <img alt="cross" id="imgIcon" class="pr-icon-thumbnail edit-logo-icon"/>
                                            <div class="deleteicon edit-delete">
                                                 <img alt="cross" onClick="deleteOrganizationLogo(this,'${project.id}');"
                                                 id="logoDelete"/>
                                            </div>
                                        </g:else>
                                </div>
                                <script>
                                   function deleteOrganizationLogo(current, projectId) {
                                       $('#imgIcon').removeAttr('src');
                                        $('#imgIcon').hide();
                                        $('#logoDelete').hide();
                                        $('#orgediticonfile').val(''); 
                                        $.ajax({
                                            type:'post',
                                            url:$("#b_url").val()+'/project/deleteOrganizationLogo',
                                            data:'projectId='+projectId,
                                            success: function(data){
                                            $('#test').html(data);
                                        }
                                        }).error(function(){
                                            alert('An error occured');
                                        });
                                    }
                             </script>
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
	                        <g:if test="${project.user == currentUser}">
	                            <div class="textFieldWithTag">
	                                <input type="text" class="form-control" name="email1" value="${email1}" id="firstadmin" placeholder="Email ID" ></input>
					    <g:if test="${email1}">
				            <div class="deleteIconAbove">
                                                <img alt="admin delete" onClick="deleteAdmin(this,'${project.id}', 'email1', '${email1}');"
                                                    src="/images/delete.ico" id="logoDelete1"/>
                                            </div>
                                        </g:if>
                                   </div>
				</g:if>
				<g:else>
				    <input type="text" class="form-control" name="email1" value="${email1}" id="firstadmin" placeholder="Email ID" readonly></input>
				</g:else>
		            </div>
	                </div>
	                <div class="form-group">
	                   <label class="col-sm-4 control-label">Second Admin</label>
	                   <div class="col-sm-8">
	                       <g:if test="${project.user == currentUser}">
	                           <div class="textFieldWithTag">
	                               <input type="text" class="form-control" name="email2" value="${email2}" id="secondadmin" placeholder="Email ID"></input>
	                                <g:if test="${email2}">
	                                    <div class="deleteIconAbove">
                                                <img alt="admin delete" onClick="deleteAdmin(this,'${project.id}', 'email2', '${email2}');"
                                                    src="/images/delete.ico" id="logoDelete2"/>
                                            </div>
                                        </g:if>
	                            </div>
	                        </g:if>
	                        <g:else>
	                           <input type="text" class="form-control" name="email2" value="${email2}" id="secondadmin" placeholder="Email ID" readonly></input>
			        </g:else>
			    </div>
	                 </div>
                    </div>
                    
                    <div class="col-sm-6">
	                <div class="form-group">
	                    <label class="col-sm-4 control-label">Third Admin</label>
	                    <div class="col-sm-8">
	                        <g:if test="${project.user == currentUser}">
	                            <div class="textFieldWithTag">
	                                <input type="text" class="form-control" name="email3" id="thirdadmin" class="" value="${email3}" placeholder="Email ID"></input>
	                                 <g:if test="${email3}">
	                                    <div class="deleteIconAbove">
                                                <img alt="admin delete" onClick="deleteAdmin(this,'${project.id}', 'email3' ,'${email3}');"
                                                    src="/images/delete.ico" id="logoDelete3"/>
                                            </div>
                                        </g:if>
                                    </div>
	                        </g:if>
	                        <g:else>
	                            <input type="text" class="form-control" name="email3" id="thirdadmin" value="${email3}" placeholder="Email ID" readonly></input>
				</g:else>
			    </div>
	                </div>
                    </div>
                    <span id="test"></span>
                    <script>
                    function deleteAdmin(current, projectId, email, username) {
                       var stat= confirm("Are you sure you want delete this admin");
                       if(stat){
                       if(email == "email1"){
                           $('#firstadmin').val('');
                           $('#logoDelete1').hide();  
                        }
                        if(email == "email2"){
                            $('#secondadmin').val('');
                            $('#logoDelete2').hide();  
                        }
                        if(email == "email3"){
                            $('#thirdadmin').val('');
                            $('#logoDelete3').hide();  
                        }
                    	                      
                        $.ajax({
                             type:'post',
                             url:$("#b_url").val()+'/project/deleteCampaignAdmin',
                             data:'projectId='+projectId+'&username='+username,
                             success: function(data){
                             $('#test').html(data);
                         }
                         }).error(function(){
                             alert('An error occured');
                         });
                        }
                     }
                    </script>
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
                            <input class="form-control" name="${FORMCONSTANTS.AMOUNT}" value="${amount}" id="amount">
                            <span id="errormsg"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">Campaign end date</label>
                        <div class="col-sm-10">
                            <div class="input-group enddate"><span class="input-group-addon datepicker-error"><span class="glyphicon glyphicon-calendar"></span></span>
                                <input class="datepicker pull-left" id="datepicker" name="${FORMCONSTANTS.DAYS}" value="${campaigndate}" readonly="readonly" placeholder="Campaign end date"> 
                            </div>
                            <script>
                                var nowTemp = new Date();
                                var now = new Date(nowTemp.getFullYear(), nowTemp.getMonth(), nowTemp.getDate(), 0, 0, 0, 0);
                                var days = $('.campaigndate').val();
                                nowTemp.setDate(now.getDate()-days);
                        	    now.setDate(now.getDate()+90-days);
         
                        	    var j = jQuery.noConflict();
                        		    j(function(){
                        			    j('#datepicker').datepicker({
                        				    onRender: function(date) {    
                        					    if (date.valueOf() < nowTemp.valueOf() || date.valueOf() > now.valueOf()){
                        						    return  'disabled';
                        					    } 
                        				    }
                        			    });
                        		    });
                            </script>
                        </div>
                    </div>
                </div>
            </div>

            <div class="panel panel-default">
                <div class="panel-heading">
                    <h3 class="panel-title">Tell us about your Campaign</h3>
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
                            <textarea class="form-control" name="${FORMCONSTANTS.DESCRIPTION}" id="descarea" maxlength="140" rows="2" placeholder="Make it catchy, and no more than 140 characters"> ${project.description} </textarea>
                            <label class="pull-right " id="desclength"></label>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">Story</label>
                        <div class="col-sm-10">
                            <textarea name="${FORMCONSTANTS.STORY}" id="${FORMCONSTANTS.STORY}" row="4" col="6" class="mceEditor">
									 ${project.story}</textarea>
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
                            <div class="fileUpload btn btn-primary btn-sm">
	        					<span>Add Images</span>
                                <input type="file" name="${FORMCONSTANTS.THUMBNAIL}[]" id="projectImageFile" class="upload" accept="image/jpeg, image/png" multiple>
                            </div>
							<label class="docfile-orglogo-css" id="editimg">Please select image file.</label>
							<label class="docfile-orglogo-css" id="campaignfilesize"></label>
                        </div>
                        <div class="col-sm-8">
                                <g:each var="imgurl" in="${project.imageUrl}">
                                    <div id="imgdiv" class="pr-thumb-div">
                                        <img alt="image" class='pr-thumbnail' src='${imgurl.url }' id="imgThumb${imgurl.id}"/>
                                        <div class="deleteicon pictures-edit-deleteicon">
                                            <img alt="cross" onClick="deleteProjectImage(this,'${imgurl.id}','${project.id}');" value='${imgurl.id}'
                                            src="/images/delete.ico" id="imageDelete"/>
                                        </div>
                                    </div> 
                                </g:each>
                                <script>
                                   function deleteProjectImage(current,imgst, projectId) {
                                        $(current).parents('#imgdiv').remove();
                                        $.ajax({
                                            type:'post',
                                            url:$("#b_url").val()+'/project/deleteProjectImage',
                                            data:'imgst='+imgst+'&projectId='+projectId,
                                            success: function(data){
                                            $('#test').html(data);
                                        }
                                        }).error(function(){
                                            alert('An error occured');
                                        });
                                    }
                             </script>
                                <output id="result"></output>
                                <div id="test"></div>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">Video URL</label>
                        <div class="col-sm-4">
                            <input id="videoUrl" class="form-control" name="${FORMCONSTANTS.VIDEO}" value="${project.videoUrl}">
                        </div>
                        <iframe class="edits-video" id="ytVideo" src="${project.videoUrl}"></iframe>
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
		                    <button type="submit" name="_action_update" id="editsubmitbutton" value="Update" class="btn btn-primary">Save</button>
		                </div>
		            </div>
                </div>
            </div>

		</g:uploadForm>
	</div>
</div>

</body>
</html>
