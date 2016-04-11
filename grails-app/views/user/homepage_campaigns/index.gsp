<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1"/>
<meta name="layout" content="main"/>
</head>
<body>
  <div class="feducontent body bg-color">
    <div class="container feedback-container">
        <g:if test="${flash.homemessage }">
            <div class="alert alert-success text-center">
                ${flash.homemessage}
            </div>
        </g:if>
        <div class="row bg-color-white">
            <div class="questions col-lg-12 col-md-12 col-sm-12 col-xs-12">
                <div class="question-list">
                <g:form action="manageHomePageCampaigns" controller="user" method="POST" class="feedback-form">
                   <div class="form-group question">
                       <div class="chooseHomePageCampaign">
                            <g:select class="selectpicker form-control input-lg "
                             name="campaignOne" from="${projects.title}" id="campaignOne"  optionValue="value" value="${campaignOne}"/>
                       </div>
                   </div>
                   <div class="form-group question">
                       <div class="form-group">
                           <div class="chooseHomePageCampaign">
                               <g:select class="selectpicker form-control input-lg"
                               name="campaignTwo" from="${projects.title}" id="campaignTwo" optionValue="value" value="${campaignTwo}" /> 
                           </div>
                       </div>
                   </div>
                   <div class="form-group question">
                       <div class="chooseHomePageCampaign">
                           <g:select class="selectpicker form-control input-lg"
                             name="campaignThree" from="${projects.title}" id="campaignThree" optionValue="value" value="${campaignThree}"/> 
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
  <script type="text/javascript">
      $(function() {
  
          /* Apply selectpicker to selects. */
          $('.selectpicker').selectpicker({
              style: 'btn btn-md btn-default'
          });
     });
   </script>
</body>
</html>
