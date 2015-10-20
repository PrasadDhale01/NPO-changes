<g:set var="userService" bean="userService"/>
<html>
<head>
    <meta name="layout" content="main" />
    <r:require module="timelinecss"/>
    <r:require modules="userjs"/>
</head>
<body>
    <div class="feducontent">
        <div class="container edituserprofilecontainer">
            <div class="col-sm-12 text-center userdashboardcontainer-sm">
                <ul>
                    <li class=""><a href="#editUserInfo" data-toggle="tab" title="My Campaigns">Edit User Info</a></li>
                    <li class=""><a href="#edit_location" data-toggle="tab" title="Edit Location">Edit Location</a></li>
                    <li class="last"><a href="#socialConnect" data-toggle="tab" title="Social Connect">Social Connect</a></li>  
                </ul>
            </div>
            
            <div class="tab-content" id="tab-content-top">
                <div class="tab-pane col-md-12 col-sm-12 col-xs-12" id="socialConnect">
                    <div id="socialConnect">
                        <div class="connectsection">
                            <a href="#"><img src="//s3.amazonaws.com/crowdera/assets/dashboardfb-md.png" alt="facebook"></a>
                            <a href="#"><img src="//s3.amazonaws.com/crowdera/assets/dashboardlinkedin-md.png" alt="linkedin"></a>
                            <a href="#"><img src="//s3.amazonaws.com/crowdera/assets/dashboardgoogle-md.png" alt="Google"></a>
                            <a href="#"><img src="//s3.amazonaws.com/crowdera/assets/dashboardpaypal-md.jpg" alt="paypal"></a>
                        </div>
                    </div>
                </div>
                <div class="tab-pane active" id="editUserInfo">
                    <g:render template="user/userprofile"/>
                </div>
                <div class="tab-pane" id="edit_location">
                    <g:render template="user/editlocation"/>
                </div>
            </div>
        </div>
    </div>
</body>
</html>
