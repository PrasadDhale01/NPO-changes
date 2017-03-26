function notifysuccess (message) {

	noty({
		text : message,
		layout : 'center',
		type : 'success',
		modal : true,
		theme : 'defaultTheme',
		animation : {
			open : 'animated fadeIn', // Animate.css class names
			close : 'animated fadeOut',// Animate.css class names
			easing : 'swing',
			speed : 500,
		},
		timeout : 2000,
	});

}

function notifyupdate (message) {

	noty({

		text : message,
		layout : 'center',
		type : 'warning',
		modal : true,
		theme : 'defaultTheme',
		animation : {
			open : 'animated fadeIn', // Animate.css class names
			close : 'animated fadeOut',// Animate.css class names
			easing : 'swing',
			speed : 500,
		},
		timeout : 2000,
	});

}

function notifycopy (message) {

	noty({
		text : message,
		layout : 'center',
		type : 'success',
		modal : true,
		animation : {
			open : 'animated fadeIn', // Animate.css class names
			close : 'animated fadeOut',// Animate.css class names
			easing : 'swing',
			speed : 500,
		},
		timeout : 2000,
	});

}

function notifyerror (message, time) {

	if (time == undefined) {
		time = 2000;
	}
	noty({
		text : message,
		layout : 'center',
		type : 'error',
		modal : true,
		animation : {
			open : 'animated fadeIn', // Animate.css class names
			close : 'animated fadeOut',// Animate.css class names
			easing : 'swing',
			speed : 500,
		},
		timeout : time,
	});

}

function notifyConfirm(message,element, callbackfunction){
	 noty({
        text: message,
        type: 'confirm',
        modal : true,
        layout: 'center',
        theme: 'defaultTheme',
 		buttons: [
 		     { addClass: 'btn btn-success btn-space', 
		       text: 'Ok', 
		       onClick: function($noty) {
			    	window[callbackfunction](element)
					$noty.close();
			   }
		     },
		     { addClass: 'btn btn-danger btn-space', 
		       text: 'Cancel', 
		       onClick: function($noty) {
		           $noty.close();
		       	   // noty({text: 'You clicked "Cancel" button', type: 'error'});
		       }
		     }
		  ],
		animation : {
			open : 'animated fadeIn', // Animate.css class names
			close : 'animated fadeOut',// Animate.css class names
			easing : 'swing',
			speed : 2000,
		},
		timeout: false,
    });
}


function ajaxCall (formData, url, method, callbackfunction) {

	$('#loading-gif').show();
	$.ajax({
		/* dataType: "json", */
		url : url,
		type : method,
		data : formData,
		success : function (response) {
			if(response==null || (typeof response != "boolean" && response=="") ){
				notifyerror('No Record Found!!'); 
			}
			$('#loading-gif').hide();
			window[callbackfunction](JSON.stringify(response));
		},
		error : function () {
			$('#loading-gif').hide();
			notifyerror("Error Occurred");
		}
	});

}

