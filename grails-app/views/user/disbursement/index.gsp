<!-- Author Krishna -->
<html>
<head>
    <title>Crowdera - Disbursement</title>
    <meta name="layout" content="main" />
    <r:require modules="disbursementjs"/>
    <r:require module="datatablecss"/>
    
</head>
<body>
<div class="feducontent">

    <div class="container">
        <div class="row">
            <h2 class="text-center"><b>Campaigns List</b></h2>
            
            <div class="table table-responsive">
                <table class="table table-bordered table-striped" id="campaignlist">
                    <thead>
                    <tr class="">
                        <th class="col-sm-1">SR NO</th>
                        <th class="col-sm-2 text-center">TITLE</th>
                        <th class="col-sm-2 text-center">DESCRIPTION</th>
                        <th class="col-sm-1 text-center">GOAL</th>
                        <th class="col-sm-1 text-center">RAISED</th>
                        <th class="col-sm-1 text-center">DAYS_LEFT</th>
                        <th class="col-sm-1 text-center">CITRUS EMAIL</th>
                        <th class="col-sm-1 text-center">SELLER_ID</th>
                        <th class="col-sm-1 text-center">DISBURSEMENT</th>
                    </tr>
                    </thead>
                    <tbody>
                        <% 
                            int index = 1;
                        %>
                        <g:each var="project" in="${projects}">
                        <tr>
                            <td>${index++}</td>
                            <td>${project.title}</td>
                            <td>${project.description}</td>
                            <td>
	                            <g:if test="${project.amount != null}">
	                                ${project.amount.round()}
	                            </g:if>
	                        </td>
                            <td>
	                            <g:if test="${project.raised != null}">
	                                ${project.raised.round()}
	                            </g:if>
	                            <g:else>
	                               0
	                            </g:else>
                            </td>
                            <td>${project.daysleft}</td>
                            <td>${project.citrusEmail}</td>
                            <td>${project.sellerId}</td>
                            <td>
                                <g:link controller="user" action="getcontribution" class="btn btn-xs btn-primary contributions" params="['projectId' : project.id, sellerId: project.sellerId]">
                                    View Contributions
                                </g:link>
                            </td>
                        </tr>
                        </g:each>
                    </tbody>
                </table>
            </div>
            
        </div>
        
        <br/><br/>
        <div class="row">
	        <div class="contributionList" id="contributionList">
	            
	        </div>
        </div>
        
    </div>
    <br/>
</div>
</body>

</html>
