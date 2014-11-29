$(function() {
	console.log("create.js initialized");
	
	/* Apply selectpicker to selects. */
    $('.selectpicker').selectpicker({
        style: 'btn btn-sm btn-default'
    });
    
    /* Validate form on submit. */
    var validator = $('form').validate({
        rules: {
            amount: {
                required: true,
                number: true,
                maxlength: 5,
                max: 50000
            },
            days: {
                required: true,
                number: true,
                max: 365
            },
            title: {
                required: true,
                minlength: 5,
                maxlength: 140
            },
            description: {
                required: true,
                minlength: 10,
                maxlength: 140
            },
            story: {
                required: true,
                minlength: 10,
                maxlength: 5000
            },
            videoUrl: {
                isYoutubeVideo: true
            },
            organizationName: {
                required: true
            },
            webAddress: {
            	isWebUrl: true,
            	required: true
            },
            email1: {
            	email: true
            },
            email2: {
            	email: true
            },
            email3: {
            	email: true
            }
        },
        messages:{
            thumbnail: "Please upload a thumbnail image for project",
            textfile: "Please upload your Letter of Determination",
            iconfile: "Please upload your organization logo"
        },
        errorPlacement: function(error, element) {
        	if ( element.is(":radio") || element.is(":checkbox")) {
        		error.appendTo(element.parent().parent());
        	}else{
        		error.insertAfter(element);
        	}
        }//end error Placement
    });

    /** ********************Organization Icon*************************** */

    $('#chooseFile').click(function(event) {
        event.preventDefault();
        $('#iconfile').trigger('click');
    });

    $("#iconfile").on("change", function() {
        var file = this.files[0];
        var fileName = file.name;
        var fileSize = file.size;

        var picReader = new FileReader();
        picReader.addEventListener("load", function(event) {
            var picFile = event.target;
            $('#imgIcon').attr('src', picFile.result);
            $('#delIcon').attr('src', "/images/delete.ico");

        });
        // Read the image
        picReader.readAsDataURL(file);

    });

    /***************************Multiple Image Selection*************** */

    $("#add_img_btn").click(function() {
        $("#projectImageFile").click()
    });

    $('#projectImageFile').change(function(event) {
                        var files = event.target.files; // FileList object
                        var output = document.getElementById("result");
                        for ( var i = 0; i < files.length; i++) {
                            var file = files[i];
                            var filename = file.name;

                            // Only pics
                            if (!file.type.match('image'))
                                continue;
                            var picReader = new FileReader();
                            picReader.addEventListener("load",function(event) {
                                                var picFile = event.target;

                                                var div = document
                                                        .createElement("div");
                                                div.innerHTML = "<div id=\"imgdiv\" class=\"pr-thumbnail-div\"><img  class='pr-thumbnail' src='"
                                                        + picFile.result
                                                        + "'"
                                                        + "title='"
                                                        + file.name
                                                        + "'/><div class=\"deleteicon\"><img onClick=\"$(this).parents('#imgdiv').remove();\" src=\"/images/delete.ico\" style=\"margin:2px;width:10px;height:10px;\"/></div>"
                                                        + "</div>";

                                                output.insertBefore(div, null);
                            });
                            // Read the image
                            picReader.readAsDataURL(file);
                        }
    });
    
    $("#addProjectImage").click(function() {
        $("#updateImageFile").click()
    });
    
    $('#updateImageFile').change( function(event) {
        var files = event.target.files;
        var output = document.getElementById("result");
        for ( var i = 0; i < files.length; i++) {
            var file = files[i];
            var filename = file.name;

            if (!file.type.match('image'))
              continue;
            var picReader = new FileReader();
            picReader.addEventListener("load",function(event) {
                var picFile = event.target;
                var div = document.createElement("div");
               div.innerHTML = "<div id=\"imgdiv\" class=\"pr-thumbnail-div pull-left\"><img  class='pr-thumbnail' src='"+ picFile.result+ "'"+ "title='"+ file.name
                    + "'/><div class=\"deleteicon\"><img onClick=\"$(this).parents('#imgdiv').remove();\" src=\"/images/delete.ico\" style=\"width:10px;height:10px;\"/></div>"
                    + "</div>";

                output.insertBefore(div, null);
            });
            // Read the image
            picReader.readAsDataURL(file);
        }
    });

});
