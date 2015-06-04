<html>
<head>
    <meta name="layout" content="main"/>
    <r:require modules="userjs"/>
</head>
<body>
<div class="feducontent">
    <div class="container">
       <div class="row">
           <h1>Pending Applicant Request</h1>
           <br>
            <g:if test="${flash.crewsmessage}">
                <div class="alert alert-success">
                    ${flash.crewsmessage}
                </div>
            </g:if>
            <g:if test="${flash.discardMessage}">
                <div class="alert alert-success">
                    ${flash.discardMessage}
                </div>
            </g:if>
           <h4>Non-Respond Applicants</h4>
           <div class="table table-responsive">
               <table class="table table-bordered">
	               <thead>
	                   <tr class="alert alert-title">
	                       <th>Id</th>
	                       <th>Name</th>
	                       <th>Date</th>
	                       <th>Details</th>
	                       <th>Discard</th>
	                   </tr>
	               </thead>
                   <tbody>
                       <g:render template="/user/crew/crewgridList" model="['crews': nonRespondList]"></g:render>
                   </tbody>
               </table>
           </div>
           <br>
           <h4>Responded Applicants</h4>
           <div class="table table-responsive">
               <table class="table table-bordered">
                   <thead>
                       <tr class="alert alert-title">
                           <th>Id</th>
	                       <th>Name</th>
	                       <th>Date</th>
	                       <th>Responded Details</th>
	                       <th>Discard</th>
                       </tr>
                   </thead>
                   <tbody>
                       <g:render template="/user/crew/crewgridList" model="['crews': respondedList]"></g:render>
                   </tbody>
               </table>
           </div>
        </div>
    </div>
</div>
</body>
</html>