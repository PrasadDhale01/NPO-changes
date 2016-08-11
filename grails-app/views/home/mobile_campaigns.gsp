<g:if test="${request.method=="POST" }">
<g:set var="projectService" bean="projectService"/>
<div class="container col-x-plf-0">
    <div class="col-md-10 col-md-offset-1 col-xs-12 col-xs-offset-0">
        <div id="myCarousel" class="carousel slide visible-xs hidden-sm hidden-md visible-md hm-mobile-positions"  data-ride="carousel">
           <div  id="home_indicators" style="display:none;">
               <ol class="carousel-indicators carousel-indicators-sm">
                   <li data-target="#myCarousel" data-slide-to="0" class="active sh-carousel-li"></li>
                   <li data-target="#myCarousel" data-slide-to="1" class="sh-carousel-li"></li>
                   <li data-target="#myCarousel" data-slide-to="2" class="sh-carousel-li"></li>
               </ol>
           </div>   
           <%
                
                def currentEnv = projectService.getCurrentEnvironment()
                def projects = projectService.getHomePageCampaignListByEnv(currentEnv)
           
                def count = projects.size()
                def cols = 1
                def pages = (count / cols) + (count % cols > 0 ? 1 : 0)
                def index = 0
           %>

           <div id="carousel-example" class="carousel slide visible-xs hidden-sm hidden-md home-campaign-tile-container" >
               <!-- Wrapper for slides -->
               <div class="carousel-inner hmmobile-carousel-banner">
                   <g:each in="${(1..pages).toList()}" var="row">
                       <g:if test="${row == 1}">
                           <div class="item active">
                               <div class="row">
                                   <ul class="thumbnails list-unstyled">
                                       <g:each in="${1..cols}">
                                           <% if (index < count) { %>
                                               <li class="col-xs-12">
                                                   <g:render template="/layouts/tile" model="['project': projects.get(index++)]"></g:render>
                                               </li>
                                            <% } %>
                                       </g:each>
                                   </ul>
                               </div>
                           </div>
                       </g:if><g:else>
                           <div class="item">
                               <div class="row">
                                   <ul class="thumbnails list-unstyled">
                                       <g:each in="${1..cols}">
                                           <% if (index < count) { %>
                                               <li class="col-xs-12">
                                                   <g:render template="/layouts/tile" model="['project': projects.get(index++)]"></g:render>
                                               </li>
                                           <% } %>
                                       </g:each>
                                   </ul>
                               </div>
                           </div>
                       </g:else>
                   </g:each>
               </div>
           </div>
           
           <div id="home_navigators" style="display:none;">
               <a class="left carousel-control left-css" href="#myCarousel" role="button" data-slide="prev">
                   <span class="glyphicon glyphicon-chevron-left arrow-mobile arrow-top"></span>
               </a>
               <a class="right carousel-control right-css" href="#myCarousel" role="button" data-slide="next">
                   <span class="glyphicon glyphicon-chevron-right arrow-mobile-css arrow-top"></span>
               </a>
           </div>
        </div>
        <div class="text-center explorebtn hidden-xs">
            <a href="${resource(dir: '/campaigns')}" class="btn btn-default hm-explorecampaign">Explore Campaigns</a>
        </div>
    </div>
</div>
</g:if>

