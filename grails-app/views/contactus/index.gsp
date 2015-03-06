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
			<g:form action="crowderacustomerhelp" controller="Home" role="form">
				<div class="col-xs-12 col-xs-offset-0 col-sm-12 col-sm-offset-0 col-md-10 col-md-offset-2">
					<h3 class="crowderasupport"><img src="/images/questionorcomment.png">&nbsp;&nbsp;<b>Submit a question or comment</b></h3>
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
						<input type="text" class="form-control" name="subject"/>
						<p class="contactparagraph">Please use a few words to summarize your question.</p>
					</div>
					<div class="form-group">
						<label for="description"><b>Description</b></label>
						<textarea class="form-control" name="helpDescription" maxlength="140" rows="4" placeholder="Description"></textarea>
						<div class="clear"></div>
						<p class="contactparagraph">Please enter additional details of
							your request. To help us get you an answer as quickly as
							possible, please consider including as many specific details as
							possible. For example, if your question is about a particular
							campaign on Crowdera, please include the name of the campaign
							and a link.</p>
					</div>
					<div class="form-group">
						<label for="firstAndLastName"><b>First and Last Name</b></label>
						<input type="text" class="form-control" name="firstAndLastName"/>
					</div>
					<div class="form-group">
						<label for="emailAddress"><b>Your Email Address</b></label>
						<input type="text" class="form-control" name="emailAddress"/>
					</div>
					<div class="contactUsSubmitButton">
						<button type="submit" id="contactsubmitbutton" class="btn btn-primary">Submit</button>
					</div>
				</div>
			</g:form>
		</div>
	</div>
</body>
