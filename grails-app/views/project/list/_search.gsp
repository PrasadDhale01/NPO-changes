<div class="col-md-3 col-md-offset-3">
    <div class="input-group pull-right">
    <!--<div class="input-group-btn">
            <button type="button" class="btn btn-primary dropdown-toggle"
                data-toggle="dropdown">
                All <span class="caret"></span>
            </button>
            <ul class="dropdown-menu">
                <li><a href="#">Just started</a></li>
                <li><a href="#">Mid way</a></li>
                <li><a href="#">Almost complete</a></li>
                <li><a href="#">Complete</a></li>
            </ul>
        </div> -->
        <!-- /btn-group -->
        <g:form action="search" controller="project" id="searchableForm" name="searchableForm">
        <div class="inner-addon right-addon">
            <i class="glyphicon glyphicon-search"></i>
            <input type="search" class="search" id="query"  name="query" value="${params.query}" placeholder="Search">
        </div>
        </g:form>
    </div>
</div>
<!--<div class="col-md-4">
    <g:render template="list/pagination"></g:render>
</div> -->
<br>
