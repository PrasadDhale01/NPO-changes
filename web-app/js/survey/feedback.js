$(function(){
	
	$('.question-list').find('form').validate({
		rules:{
			answer_1:{
				required:true
			},
			answer_2:{
				required:true
			},
			answer_2_y1:{
				required:true
			},
			answer_2_y2:{
				required:true
			},
			answer_2_n:{
				required:true
			},
			answer_3:{
				required:true
			},
			answer_4:{
				required:true
			},
			answer_4_y:{
				required:true
			},
			answer_4_n:{
				required:true
			},
			answer_5:{
				required:true
			},
			answer_6:{
				required:true
			},
			answer_7:{
				required:true
			},
			answer_8:{
				required:true
			},
			answer_9:{
				required:true
			},
			answer_10:{
				required:true
			}
			
		},
		errorPlacement: function(error, element) {
        	if(element.attr("name")=="answer_2") {
                error.appendTo(".ansTwoError");
            }else if(element.attr("name")=="answer_4"){
            	error.appendTo(".ansFourError");
            }else if(element){
            	error.appendTo(element.parent());
            }
        }
	});
	
	
	$("input[name='answer_2']").change(function(){
     	if($(this).val()=="yes") {
     		$('.secondQOptOne').show();
     		$('.secondQOptTwo').hide();
     	}else{
     		$('.secondQOptOne').hide();
     		$('.secondQOptTwo').show();
     	}
	});
	$("input[name='answer_4']").change(function(){
     	if($(this).val()=="yes") {
     		$('.question_4_opt_yes').show();
     		$('.question_4_opt_no').hide();
     	}else{
     		$('.question_4_opt_yes').hide();
     		$('.question_4_opt_no').show();
     	}
	});
});