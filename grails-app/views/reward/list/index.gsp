<html>
<head>
    <meta name="layout" content="main" />
    <r:require modules="rewardjs"/>
</head>
<body>
<div class="feducontent">
	<div class="container">
		<h1><i class="fa fa-gift fa-lg"></i> Rewards</h1>

        <div class="row">
            <div class="col-md-9">
                <g:render template="list/rewardgrid" model="['rewards': rewards]"></g:render>
            </div>

            <div class="col-md-3">
                <h3>Create a new Reward</h3>

                <g:if test="${flash.message}">
                    <div class="alert alert-info">
                        ${flash.message}
                    </div>
                </g:if>

                <g:form action="save" role="form">
                    <div class="form-group">
                        <label for="title">Title</label>
                        <input type="text" class="form-control" name="title" placeholder="Title">
                    </div>
                    <div class="form-group">
                        <label for="description">Description</label>
                        <input type="text" class="form-control" name="description" placeholder="Description">
                    </div>
                    <div class="form-group">
                        <label for="price">Price ($)</label>
                        <input type="text" class="form-control" name="price" placeholder="Price">
                    </div>
                    <button type="submit" class="btn btn-primary btn-block">Create Reward</button>
                </g:form>
            </div>
        </div>

        <hr>

    </div>
</div>
</body>
</html>
