<html>
<head>
    <meta name="layout" content="main" />
</head>
<body>
<div class="feducontent">
	<div class="container">
		<h1><span class="glyphicon glyphicon-leaf"></span> Bulk Import Projects</h1>

        <g:if test="${flash && flash.message}">
            <div class="alert alert-danger">
                ${flash.message}
            </div>
        </g:if>
        <g:elseif test="${flash && flash.success}">
            <div class="alert alert-success">
                ${flash.success}
            </div>
        </g:elseif>

        <g:uploadForm class="form-horizontal" controller="project" action="bulkimport" role="form">

            <div class="panel panel-default">
                <div class="panel-heading">
                    <h3 class="panel-title">Import projects from Spreadsheet</h3>
                </div>
                <div class="panel-body">
                    <g:if test="${flash && flash.projecterror}">
                        <div class="alert alert-danger">
                            <p>Error while validating project with title: ${flash.projecterror.title}</p>
                            <p>${flash.projecterror.error}</p>
                            <g:if test="${flash.projecterror.note}">
                                <p>NOTE: ${flash.projecterror.error}</p>
                            </g:if>
                        </div>
                    </g:if>

                    <div class="form-group">
                        <label class="col-sm-2 control-label">Projects spreadsheet</label>
                        <div class="col-sm-10">
                            <input type="file" name="${FORMCONSTANTS.PROJECTSEXCEL}">
                            <p class="help-block">
                                <i class="fa fa-warning"></i>
                                The uploaded spreadsheet should follow this <a href="/secured/ProjectsUploadTemplate.xlsx">template</a>
                            </p>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">Import</label>
                        <div class="col-sm-10">
                            <button type="submit" class="btn btn-default">Import Projects from Spreadsheet</button>

                        </div>
                    </div>
                </div>
            </div>
		</g:uploadForm>
	</div>
</div>

</body>
</html>