<html>
<head>
<meta name="layout" content="main" />

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
                <div class="">
                    <h3>Create a new Reward</h3>
                    <form role="form">
                        <div class="form-group">
                            <label for="title">Title</label>
                            <input type="text" class="form-control" name="title" placeholder="Title" required="">
                        </div>
                        <div class="form-group">
                            <label for="description">Description</label>
                            <input type="text" class="form-control" name="description" placeholder="Description" required="">
                        </div>
                        <div class="form-group">
                            <label for="price">Price ($)</label>
                            <input type="text" class="form-control" name="price" placeholder="Price" required="">
                        </div>
                        <button type="submit" class="btn btn-default">Submit</button>
                    </form>
                </div>
            </div>
        </div>

        <hr>

    </div>
</div>
</body>
</html>
