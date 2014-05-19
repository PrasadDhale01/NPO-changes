<html>
<head>
    <meta name="layout" content="main" />
</head>
<body>
<div class="feducontent">
    <div class="container">
        <h2><i class="fa fa-users"></i> Manage Communities</h2>
        <g:link action="create"><button type="button" class="btn btn-default">Create new Community</button></g:link>

        <div class="panel-group top-buffer" id="accordion">
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
                                ${index}: ${community.title}
                            </a>
                        </h4>
                    </div>
                    <g:if test="${index == 1}">
                        <div id="collapse-${index}" class="panel-collapse">
                    </g:if>
                    <g:else>
                        <div id="collapse-${index}" class="panel-collapse collapse">
                    </g:else>
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
