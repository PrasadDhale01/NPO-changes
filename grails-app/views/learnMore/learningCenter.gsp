<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1"/>
<meta name="layout" content="main"/>
<title>Crowdera - Learning Center</title>
</head>
<body>
<div class="feducontent learnBg-color">
<div class="body">
    <div id="faqdiv" class="container learnContainer" >
	  <div class="articless" id="loadfaqcontents"></div>
	  <div id="paginate" class="row">
            <div class="pull-left"><strong><a href="#" class="prev" id="sec1-faq12">Previous</a></strong></div>
            <div class="text-center"><strong><a href="/faqlinks" class="home" id="home">Home</a></strong></div>
            <div class="pull-right nexxt"><strong><a href="#" class="next" id="sec1-faq14">Next</a></strong></div>
        </div>
	</div>
  </div>
</div>
<script>
  

     $(function(){
         $("#paginate").hide();
    	 $('#loadfaqcontents').load("/fcontent #faqLinks");
     });
     
     $("#faqdiv").on("click", "a", function(event){
         event.preventDefault();
         event.stopPropagation();
         
          var faqId=$(this).attr("id");
          var faqText = $("#"+faqId).text();
         
         loadFAQContents(faqId);
     });

     function loadFAQContents(faqId){
         var sections = {"1":14, "2":4, "3":12, "4":10};
         
    	 if(faqId==="home"){
             $("#paginate").hide();
             faqId="faqLinks";
         }else if(faqId==="create"){
             window.location.href="/Creating-Campaign";
         }
         else if(faqId==="perk"){
             window.location.href="/Perks";
         }
         else if(faqId==="manage"){
             window.location.href="/Managing-Campaign";
         }
         else if(faqId==="contribute"){
             window.location.href="/Contributor";
         }else if(faqId==="main"){
             window.location.href="/";
         }else{

        	 var regex =/sec([\w-]*)-faq([\w-]*)/;
             var secVal = faqId.match(regex)[1];
             var faqVal = faqId.match(regex)[2];

             var nextLink="";
             var prevLink="";
             var nextVal=0;
             var prevVal=0;

             switch(parseInt(secVal)){
                 case 1:

                	 if(parseInt(faqVal)<=14){
                		 nextVal=parseInt(faqVal)+1;
                         prevVal= parseInt(faqVal)-1;
                    	 hideShowNext(nextVal, 15);
                    	 hideShowPrev(prevVal,0);
                     }
                 break;

                 case 2:
                	 if(parseInt(faqVal)<=4){
                		 nextVal=parseInt(faqVal)+1;
                         prevVal= parseInt(faqVal)-1;
                         hideShowNext(nextVal, 5);
                         hideShowPrev(prevVal,0);
                     }
                 break;
                 case 3:
                     if(parseInt(faqVal)<=12){
                    	 nextVal=parseInt(faqVal)+1;
                         prevVal= parseInt(faqVal)-1;
                         hideShowNext(nextVal, 13);
                         hideShowPrev(prevVal,0);
                     }
                 break;
                 case 4:
                     if(parseInt(faqVal)<=10){
                    	 nextVal=parseInt(faqVal)+1;
                         prevVal= parseInt(faqVal)-1;
                         hideShowNext(nextVal, 11);
                         hideShowPrev(prevVal,0);
                     }
                 break;
             }

             $("#paginate").show();
             
             prevLink ="sec"+secVal+"-"+"faq"+(prevVal);
             nextLink ="sec"+secVal+"-"+"faq"+(nextVal);

             $(".prev").attr('id',prevLink);
             $(".next").attr('id',nextLink);
             
         }

    	 $('#loadfaqcontents').load("/fcontent #"+faqId);
    	
    	
     }


     function hideShowPrev(start, end){
    	 if(parseInt(start)===parseInt(end)){
             $(".prev").text('');
         }else{
             $(".prev").text('Previous');
         }
     }
     
     function hideShowNext(start, end){
    	 if(parseInt(start)===parseInt(end)){
             $(".next").text('');
         }else{
             $(".next").text('Next');
         }
     }
</script>  
</body>
</html>