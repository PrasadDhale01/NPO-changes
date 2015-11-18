<%@ page contentType="text/html;charset=UTF-8" %>
<g:set var="userService" bean="userService" />
<% 
	def user= userService.getCurrentUser()
	def rating =request.getParameter("rating")
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1"/>
<meta name="layout" content="main"/>
<r:require modules="feedbackjs"/> 
</head>
<body>
  <div class="feducontent body bg-color">
  	<div class="container feedback-container">
  		<g:if test="${flash.feedback_message}">
			<div class="alert alert-success" align="center">
				${flash.feedback_message}
			</div>
		</g:if>
  		<div class="row bg-color-white">
  			<h3 class="col-lg-12 col-md-12 col-sm-12 col-xs-12">Please review the below website feedback questions.</h3>
  			<div class="questions col-lg-12 col-md-12 col-sm-12 col-xs-12">
  				<div class="question-list">
  					<g:form action="saveFeedback" controller="user" method="POST" class="feedback-form">
  						<input type="hidden" name="rating" value="${rating}">
  						<sec:ifLoggedIn>
  							<input type="hidden" name="user" value="${user.id}">
  						</sec:ifLoggedIn>
	  					<div class="form-group question">
	  						<span>1)&nbsp;How did you hear about us?</span>
	  						<div class="answer">
	  							<input type="text"  class="form-control input-lg" name="answer_1"> 
	  						</div>
	  					</div>
	  					<div class="form-group question">
	  						<span>2)&nbsp;Have you Crowdfunded in the past?</span>
	  						<div class="answer-radio">
	  							<label for="answer_2"><input type="radio" name="answer_2" value="yes">&nbsp;Yes</label>&nbsp;&nbsp;
								<label for="answer_2"><input type="radio" name="answer_2" value="no">&nbsp;No</label>
								<span class="ansTwoError"></span> 
	  						</div>
	  						<div class="form-group secondQOptOne">
	  							<br>
	  							<span>a)&nbsp;What others crowdfunding platforms did you use?</span>
		  						<div class="answer">
		  							<input type="text"  class="form-control input-lg" name="answer_2_y1"> 
		  						</div>
		  						<br>
		  						<span>b)&nbsp;What did you like the best about those platforms?</span>
		  						<div class="answer">
		  							<input type="text"  class="form-control input-lg" name="answer_2_y2"> 
		  						</div>
	  						</div>
	  						<div class="form-group secondQOptTwo">
	  							<br>
	  							<span>a)&nbsp;What do you like the best about Crowdera?</span>
		  						<div class="answer">
		  							<div class="">
										<input type="text"  class="form-control input-lg" name="answer_2_n">
									</div> 
		  						</div>
	  						</div>
	  					</div>
	  					<div class="form-group question">
	  						<span>3)&nbsp;How easy was it to create your campaign on Crowdera?</span>
	  						<div class="answer">
	  							<input type="text"  class="form-control input-lg" name="answer_3"> 
	  						</div>
	  					</div>
	  					<div class="form-group question">
	  						<span>4)&nbsp;Did you use the Team Feature?</span>
	  						<div class="answer-radio">
	  							<label for="answer_4"><input type="radio" name="answer_4" value="yes">&nbsp;Yes</label>&nbsp;&nbsp;
								<label for="answer_4"><input type="radio" name="answer_4" value="no">&nbsp;No</label> 
								<span class="ansFourError"></span>
	  						</div>
	  						<div class="form-group question_4_opt_yes">
	  							<br>
	  							<span>a)&nbsp;How easy was it to Add and Manage Teams?</span>
		  						<div class="answer">
		  							<input type="text"  class="form-control input-lg" name="answer_4_y"> 
		  						</div>
	  						</div>
	  						<div class="form-group question_4_opt_no">
	  							<br>
	  							<span>a)&nbsp;Is there a reason why you didn't use the Team feature?</span>
		  						<div class="answer">
		  							<input type="text"  class="form-control input-lg" name="answer_4_n">  
		  						</div>
	  						</div>
	  					</div>
	  					<div class="form-group question">
	  						<span>5)&nbsp;What other "must have" or "nice to have" feautres would your recommend?</span>
	  						<div class="answer">
	  							<input type="text"  class="form-control input-lg" name="answer_5">  
	  						</div>
	  					</div>
	  					<div class="form-group question">
	  						<span>6)&nbsp;Do you need volunteer or additional help in fundraising?</span>
	  						<div class="answer">
	  							<input type="text" class="form-control input-lg" name="answer_6">  
	  						</div>
	  					</div>
	  					<div class="form-group question">
	  						<span>7)&nbsp;Did you face any challenge or aberration on our site?</span>
	  						<div class="answer">
	  							<input type="text"  class="form-control input-lg" name="answer_7">
	  						</div>
	  					</div>
	  					<div class="form-group question">
	  						<span>8)&nbsp;How likely are you to use or recommend Crowdera in the future?</span>
	  						<div class="answer">
	  							<input type="text"  class="form-control input-lg" name="answer_8">
	  						</div>
	  					</div>
	  					<div class="form-group question">
	  						<span>9)&nbsp;Would you like to do a detailed survey for Crowdera?</span>
	  						<div class="answer-radio">
	  							<label for="answer_9"><input type="radio" name="answer_9" value="yes">&nbsp;Yes</label>&nbsp;&nbsp;
								<label for="answer_9"><input type="radio" name="answer_9" value="no">&nbsp;No</label> 
								<span class="ansNineError"></span>
	  						</div>
	  						<div class="form-group question_9_opt_yes">
	  							<br>
	  							<span>a)&nbsp;What is the best way to provide you with more product information?</span>
		  						<div class="answer">
		  							<input type="text"  class="form-control input-lg" name="answer_9_y1"> 
		  						</div>
	  						</div>
	  						<div class="form-group question_9_opt_yes">
	  							<span>b)&nbsp;Did our platform provided with all the services that you hoped for?</span>
		  						<div class="answer">
		  							<input type="text"  class="form-control input-lg" name="answer_9_y2"> 
		  						</div>
	  						</div>
	  						<div class="form-group question_9_opt_yes">
	  							<span>c)&nbsp;How visually appealing is our website ?</span>
		  						<div class="answer">
		  							<input type="text"  class="form-control input-lg" name="answer_9_y3"> 
		  						</div>
	  						</div>
	  						<div class="form-group question_9_opt_yes">
	  							<span>d)&nbsp;Did you take more or less time than you had expected to create your campaign on crowdera?</span>
		  						<div class="answer">
		  							<input type="text"  class="form-control input-lg" name="answer_9_y4"> 
		  						</div>
	  						</div>
	  						<div class="form-group question_9_opt_yes">
	  							<span>e)&nbsp;Do you have any other suggestions or comments for crowdera?</span>
		  						<div class="answer">
		  							<input type="text"  class="form-control input-lg" name="answer_9_y5"> 
		  						</div>
	  						</div>
	  						<div class="form-group question_9_opt_yes">
	  							<span>f)&nbsp;If you could change one thing about the entire website of crowdera, what would it be?</span>
		  						<div class="answer">
		  							<input type="text"  class="form-control input-lg" name="answer_9_y6"> 
		  						</div>
	  						</div>
	  						<div class="form-group question_9_opt_no">
	  							<br>
	  							<span>a)&nbsp;Please state the reason for your rating, so that we can improve our service in future.</span>
		  						<div class="answer">
		  							<input type="text"  class="form-control input-lg" name="answer_9_n"> 
		  						</div>
	  						</div>
	  						
	  					</div>
	  					
	  					<div class="submitbtn">
	  						<button class="btn btn-default btn-info center-block">Submit</button>
	  					</div>
  					</g:form>
  				</div>
  			</div>
  		</div>
  	</div>
  </div>
</body>
</html>
