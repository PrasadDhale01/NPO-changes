<div class="col-md-3 col-md-offset-3">
    <div class="input-group">
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
        <form action="/campaign" onClick="searchList()" name="searchableForm">
        <div class="inner-addon right-addon">
            <i class="glyphicon glyphicon-search"></i>
            <input type="search" class="search" id="q"  name="q" value="${params.q}" placeholder="Search">
        </div>
        </form>
    </div>
</div>
<!--<div class="col-md-4">
    <g:render template="list/pagination"></g:render>
</div> -->
<br>
