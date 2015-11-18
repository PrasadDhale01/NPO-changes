<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1"/>
<meta name="layout" content="main"/>
<r:require modules="feedbackjs"/> 
</head>
<body>
  <div class="feducontent body bg-color">
  	<div class="container feedback-container">
  		<div class="row bg-color-white">
  			<div class="row">
  				<div class="col-lg-1 col-md-1 col-sm-1 previewsubmitbtnTop">
		           <g:link controller="user" action="feedback" >Back</g:link>
		    	</div>
  				<div class="col-lg-10 col-md-10 col-sm-10">
  					<h3 class="col-lg-12 col-md-12 col-sm-12 col-xs-12 text-center">Feedback by: ${user.firstName} ${user.lastName}</h3>
  				</div>
  				
  			</div>
  			<div class="questions col-lg-12 col-md-12 col-sm-12 col-xs-12">
  				<div class="question-list">
	  					<div class="form-group question">
	  						<span>1)&nbsp;How did you hear about us?</span>
	  						<div class="answer">
	  							<input type="text" class="form-control input-lg" name="answer_1" value="${feedback.answer_1}"> 
	  						</div>
	  					</div>
	  					<div class="form-group question">
	  						<g:if test="${feedback.answer_2_n}">
	  							<div class="form-group">
	  							<span>2)&nbsp;What do you like the best about Crowdera?</span>
		  						<div class="answer">
		  							<div class="">
										<input type="text" class="form-control input-lg" name="answer_2_n" value="${feedback.answer_2_n}">
									</div> 
		  						</div>
	  						</div>
	  						</g:if>
	  						<g:else>
	  							<div class="form-group">
	  							<span>2a)&nbsp;What others crowdfunding platforms did you use?</span>
		  						<div class="answer">
		  							<input type="text" class="form-control input-lg" name="answer_2_y1" value="${feedback.answer_2_y1}"> 
		  						</div>
		  						<br>
		  						<span>2b)&nbsp;What did you like the best about those platforms?</span>
		  						<div class="answer">
		  							<input type="text" class="form-control input-lg" name="answer_2_y2" value="${feedback.answer_2_y2}"> 
		  						</div>
	  						</div>
	  						</g:else>
	  					</div>
	  					<div class="form-group question">
	  						<span>3)&nbsp;How easy was it to create your campaign on Crowdera?</span>
	  						<div class="answer">
	  							<input type="text" class="form-control input-lg" name="answer_3" value="${feedback.answer_3}"> 
	  						</div>
	  					</div>
	  					<div class="form-group question">
	  						<g:if test="${feedback.answer_4_n}">
	  							<div class="form-group">
	  							<span>4)&nbsp;Is there a reason why you didn't use the Team feature?</span>
		  						<div class="answer">
		  							<input type="text" class="form-control input-lg" name="answer_4_n" value="${feedback.answer_4_n}">  
		  						</div>
	  						</div>
	  						</g:if>
	  						<g:else>
	  							<div class="form-group">
	  							<span>4)&nbsp;How easy was it to Add and Manage Teams?</span>
		  						<div class="answer">
		  							<input type="text" class="form-control input-lg" name="answer_4_y" value="${feedback.answer_4_y}"> 
		  						</div>
	  						</div>
	  						</g:else>
	  					</div>
	  					<div class="form-group question">
	  						<span>5)&nbsp;What other "must have" or "nice to have" feautres would your recommend?</span>
	  						<div class="answer">
	  							<input type="text" class="form-control input-lg" name="answer_5" value="${feedback.answer_5}">  
	  						</div>
	  					</div>
	  					<div class="form-group question">
	  						<span>6)&nbsp;Do you need volunteer or additional help in fundraising?</span>
	  						<div class="answer">
	  							<input type="text"  class="form-control input-lg" name="answer_6" value="${feedback.answer_6}">  
	  						</div>
	  					</div>
	  					<div class="form-group question">
	  						<span>7)&nbsp;Did you face any challenge or aberration on our site?</span>
	  						<div class="answer">
	  							<input type="text" class="form-control input-lg" name="answer_7" value="${feedback.answer_7}">
	  						</div>
	  					</div>
	  					<div class="form-group question">
	  						<span>8)&nbsp;How likely are you to use or recommend Crowdera in the future?</span>
	  						<div class="answer">
	  							<input type="text" class="form-control input-lg" name="answer_8" value="${feedback.answer_8}">
	  						</div>
	  					</div>
	  					<div class="form-group question">
	  						<g:if test="${feedback.answer_9_n}">
	  							<div class="form-group">
	  							<span>9)&nbsp;Please state the reason for your rating, so that we can improve our service in future.</span>
		  						<div class="answer">
		  							<input type="text"  class="form-control input-lg" name="answer_9_n" value="${feedback.answer_9_n}"> 
		  						</div>
	  						</div>
	  						</g:if>
	  						<g:else>
	  							<div class="form-group">
	  							<span>9a)&nbsp;What is the best way to provide you with more product information?</span>
		  						<div class="answer">
		  							<input type="text"  class="form-control input-lg" name="answer_9_y1" value="${feedback.answer_9_y1}"> 
		  						</div>
	  						</div>
	  						<div class="form-group">
	  							<span>9b)&nbsp;Did our platform provided with all the services that you hoped for?</span>
		  						<div class="answer">
		  							<input type="text"  class="form-control input-lg" name="answer_9_y2" value="${feedback.answer_9_y2}"> 
		  						</div>
	  						</div>
	  						<div class="form-group">
	  							<span>9c)&nbsp;How visually appealing is our website ?</span>
		  						<div class="answer">
		  							<input type="text"  class="form-control input-lg" name="answer_9_y3" value="${feedback.answer_9_y3}"> 
		  						</div>
	  						</div>
	  						<div class="form-group">
	  							<span>9d)&nbsp;Did you take more or less time than you had expected to create your campaign on crowdera?</span>
		  						<div class="answer">
		  							<input type="text" class="form-control input-lg" name="answer_9_y4" value="${feedback.answer_9_y4}"> 
		  						</div>
	  						</div>
	  						<div class="form-group">
	  							<span>9e)&nbsp;Do you have any other suggestions or comments for crowdera?</span>
		  						<div class="answer">
		  							<input type="text"  class="form-control input-lg" name="answer_9_y5" value="${feedback.answer_9_y5}"> 
		  						</div>
	  						</div>
	  						<div class="form-group">
	  							<span>9f)&nbsp;If you could change one thing about the entire website of crowdera, what would it be?</span>
		  						<div class="answer">
		  							<input type="text" class="form-control input-lg" name="answer_9_y6" value="${feedback.answer_9_y6}"> 
		  						</div>
	  						</div>
	  						</g:else>
	  					</div>
	  					
	  					<div class="previewsubmitbtn">
	  						<g:link controller="user" action="feedback" ><button class="btn btn-default btn-info center-block">Back</button></g:link>
	  					</div>
	  					<br>
  				</div>
  			</div>
  		</div>
  	</div>
  </div>
</body>
</html>