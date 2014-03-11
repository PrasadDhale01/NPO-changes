<%@ page import="java.text.SimpleDateFormat" %>
<div>
    <div class="row">
        <div class="col-sm-8">
            <h2>
                <a href="blogs/${it.id}">${it.title}</a>
            </h2>
        </div>
        <div class="col-sm-4">
            <h2>
                <%
                    SimpleDateFormat dateFormat = new SimpleDateFormat("MMM d");
                    def date = dateFormat.format(it.date)
                %>
                <span class="lead pull-right">By ${it.author} <span class="small">on ${date}</span></span>
            </h2>
        </div>
    </div>
    <div class="well">
        <p class="text-justify">
            ${it.snippet}
            <span><a role="button" class="btn btn-link btn-xs" href="blogs/${it.id}">Continue reading</a></span>
        </p>
    </div>
</div>
