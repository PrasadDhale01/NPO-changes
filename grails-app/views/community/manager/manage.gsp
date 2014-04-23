<html>
<head>
    <meta name="layout" content="main" />
</head>
<body>
<div class="feducontent">
    <div class="container">
        <h2>Manage Communities</h2>

        <div class="panel-group" id="accordion">
            <%
                def index = 0
            %>
            <g:each in="${communities}" var="community">
                <%
                    ++index;
                %>
                <div class="panel panel-primary">
                    <div class="panel-heading">
                        <h4 class="panel-title">
                            <a data-toggle="collapse" data-parent="#accordion" href="#collapse-${index}">
                                <i class="fa fa-users"></i> ${index}: ${community.title}
                            </a>
                        </h4>
                    </div>
                    <div id="collapse-${index}" class="panel-collapse collapse">
                        <div class="panel-body">
                            <g:render template="manager/vitals" model="[community: community]"/>

                            <div class="row top-buffer">
                                <div class="col-md-6">
                                    <g:render template="manager/members" model="[community: community]"/>
                                </div>
                                <div class="col-md-6">
                                    <g:render template="manager/transactions" model="[community: community]"/>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </g:each>
        </div>
    </div>
</div>
</body>
</html>
