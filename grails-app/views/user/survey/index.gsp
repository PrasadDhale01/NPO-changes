<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1"/>
<meta name="layout" content="main"/>
</head>
<body>
  <div class="feducontent body">
    <div class="container">
        <div class="row">
            <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
               <div class="table table-responsive">
                   <table class="table table-bordered">
                       <thead>
                           <tr class="alert alert-title">
                               <th class="col-sm-2 text-center">Owner</th>
                               <th class="col-sm-2 text-center">Project Title</th>
                               <th class="col-sm-2 text-center">Download</th>
                           </tr>
                       </thead>
                       <tbody>
                           <g:render template='/user/survey/feedbacklist'/>
                       </tbody>
                  </table>
              </div>
              <br>
          </div>
      </div>
    </div>
  </div>
</body>
</html>
