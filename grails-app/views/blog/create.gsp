<html>
<head>
<meta name="layout" content="main" />
</head>
<body>
    <div class="container">
        <h1>Create new blog</h1>
        <g:form action="publish" role="form">
            <div class="form-group">
                <label for="title">Title</label>
                <input type="text" class="form-control" name="title" placeholder="Title">
            </div>
            <div class="row">
                <div class="col-sm-6">
                    <div class="form-group">
                        <label for="author">Author</label>
                        <input type="text" class="form-control" name="author" placeholder="Author">
                    </div>
                </div>
                <div class="col-sm-6">
                    <div class="form-group">
                        <label for="date">Date</label>
                        <input type="date" class="form-control" name="date" placeholder="Date">
                    </div>
                </div>
            </div>
            <div class="form-group">
                <label for="snippet" class="control-label">Snippet</label>
                <textarea class="form-control" name="snippet" rows="2"></textarea>
            </div>
            <div class="form-group">
                <label for="content" class="control-label">Content</label>
                <textarea class="form-control" name="content" rows="10"></textarea>
            </div>
            <button type="submit" class="btn btn-default">Submit</button>
        </g:form>
    </div>
</body>
</html>
