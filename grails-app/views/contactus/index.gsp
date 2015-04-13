<head>
<meta name="layout" content="main" />
<r:require modules="homejs"/>
<script type="text/javascript">
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
	<div class="feducontent">
		<div class="container contactUs" id="contactUs">
                        <g:if test="${flash.contactmessage}">
			    <div class="alert alert-success" align="center">
		                ${flash.contactmessage}
			    </div>
			</g:if>
			<g:uploadForm action="crowderacustomerhelp" controller="Home" role="form">
				<div class="col-xs-12 col-xs-offset-0 col-sm-12 col-sm-offset-0 col-md-10 col-md-offset-2">
					<h3 class="crowderasupport"><img src="https://s3.amazonaws.com/crowdera/assets/questionorcomment.png" alt="Question or Comment">&nbsp;&nbsp;<b>Submit a question or comment</b></h3>
				</div>
				<div class=" col-xs-12 col-xs-offset-0 col-sm-8 col-sm-offset-2 col-md-6 col-md-offset-3">
					<div class="form-group">
						<label for="customerType" class="control-label"><b>Customer Type</b></label>
						<div class="clear"></div>
						<% def customertypes = ['Campaign Owner', 'Contributor', 'Other'] %>
						<g:select class="selectpicker" name="customerType" from="${customertypes}" value="${customertypes[0]}"/>
					</div>
					<div class="form-group">
						<label for="Subject"><b>Subject</b></label>
						<input type="text" class="form-control" id="Subject" name="subject"/>
						<p class="contactparagraph">Please use a few words to summarize your question.</p>
					</div>
					<div class="form-group">
						<label for="description"><b>Description</b></label>
						<textarea class="form-control" id="description" name="helpDescription" rows="4"></textarea>
						<div class="clear"></div>
						<p class="contactparagraph">We love hearing from you and would like to respond to your request timely and accurately. To help us do so, please include as many specific details as possible.</p>
					</div>
					<div class="form-group">
						<label for="firstAndLastName"><b>First and Last Name</b></label>
						<input type="text" id="firstAndLastName" class="form-control" name="firstAndLastName"/>
					</div>
					<div class="form-group">
						<label for="emailAddress"><b>Your Email Address</b></label>
						<input type="text" id="emailAddress" class="form-control" name="emailAddress"/>
					</div>
					<div class="form-group attachment-group">
						<label for="attachments"><b>Attachments</b></label>
						<div class="clear"></div>
						<div class="col-xs-12 col-sm-4 col-md-4">
						    <div class="fileUpload btn btn-primary btn-sm">
 						        <span>Choose File</span>
 						        <input type="file" class="upload" id="attachments" name="files" multiple/>
       					    </div>
       					    <label class="docfile-orglogo-css" id="attachmentfilesize"></label>
       					</div>
       					<div class="col-xs-12 col-sm-8 col-md-8">
    						<output id="result"></output>
  						</div>
			        </div>
			        <div class="clear"></div>
			        <hr/>
					<div class="contactUsSubmitButton">
						<button type="submit" id="contactsubmitbutton" class="btn btn-primary">Submit</button>
					</div>
				</div>
			</g:uploadForm>
		</div>
	</div>
</body>
