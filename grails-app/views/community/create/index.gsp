<g:set var="userService" bean="userService"/>
<html>
<head>
    <meta name="layout" content="main" />
    <r:require modules="communityjs"/>
</head>
<body>
<div class="feducontent">
	<div class="container">
		<h1><i class="fa fa-users"></i> Create Community</h1>

        <g:form class="form-horizontal" action="save" role="form">
            <div class="panel panel-default">
                <div class="panel-heading">
                    <h3 class="panel-title">Create your brand new community here</h3>
                </div>
                <div class="panel-body">
                    <div class="form-group">
                        <label class="col-sm-2 control-label">Title</label>
                        <div class="col-sm-10">
                            <input class="form-control" name="${FORMCONSTANTS.TITLE}" placeholder="Title">
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">Description</label>
                        <div class="col-sm-10">
                            <textarea class="form-control" rows="4" name="${FORMCONSTANTS.DESCRIPTION}" placeholder="Community description"></textarea>
                        </div>
                    </div>

                    <div class="form-group">
                        <label class="col-sm-2 control-label"></label>
		                <div class="col-sm-10">
		                    <button type="submit" class="btn btn-primary">Create Community</button>
		                </div>
		            </div>
                </div>
            </div>
		</g:form>

	</div>
</div>

</body>
</html>
