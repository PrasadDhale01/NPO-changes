var miscellaneous = $('#miscellaneous').val();
var spendAmountPerList = $('#spendAmountPerList').val();
var projectAmount = $('#projectamount').val();
var percentageList = [];
var currentEnv=$('#currentEnv').val();
if (miscellaneous == 'hasOtherValues'){
	var list2 = spendAmountPerList.split(",");
	for (i=0; i<list2.length; i++){
		percentageList.push(parseInt(list2[i]));
	}
} else {
	percentageList.push(parseInt(spendAmountPerList));
}
var $container = jQuery('#graphWithoutLabel');
var barcolors      = ['#99E5E5','#D1FF19', '#FFAA2B', '#5EFF36', '#FF2626', '#FFFF2A', '#DDA0DD', '#FDC6C0', '#BF6666', '#FDBC80', '#FDDF5B', '#FF2626', '#DDA0DD', '#5EFF36', '#FFFF2A', '#FDC6C0', '#D1FF19', '#FFAA2B'],
    highlightcolor = '#FFF68F',
    data           = percentageList;

var pheight = parseInt($container.css('height')),
    pwidth  = parseInt($container.css('width')),
    radius  = pwidth < pheight ? pwidth/2.2 : pheight/2.2;
    bgcolor = jQuery('body').css('background-color');

var paper = new Raphael($container[0], pwidth, pheight);

// draw the piechart
var pie = paper.piechart(pwidth/2, pheight/2, radius, data, { 
	stroke: bgcolor,
	strokewidth: 1,
	colors: barcolors
});

// assign the hover in/out functions
pie.hover(function () {
  this.sector.stop();
  this.sector.scale(1.05, 1.05, this.cx, this.cy);
  this.sector.animate({ 'stroke': highlightcolor }, 400);
  this.sector.animate({ 'stroke-width': 1 }, 500, "bounce");
  
    if (currentEnv == 'development' || currentEnv == 'test' || currentEnv == 'production' || currentEnv == 'staging'){
    	center_label.attr('text', '$'+this.value.value);
    } else {
    	center_label.attr('text', 'Rs. '+this.value.value);
    }
//    center_label.attr({ 'opacity': 1 });
//    center_label.animate({ 'opacity': 1.0 }, 500);
  }, function () {
    this.sector.animate({ transform: 's1 1 ' + this.cx + ' ' + this.cy }, 500, "bounce");
    this.sector.animate({ 'stroke': bgcolor }, 400);
      //center_label.attr('text','');
//      center_label.animate({ 'opacity': 0.0 }, 500);
});

pie.mouseout(function (){
	if (currentEnv == 'development' || currentEnv == 'test' || currentEnv == 'production' || currentEnv == 'staging'){
    	center_label.attr('text', '$'+projectAmount);
    } else {
    	center_label.attr('text', 'Rs. '+projectAmount);
    }
});

// blank circle in center to create donut hole effect
paper.circle(pwidth/2, pheight/2, radius*0.5)
  .attr({'fill': bgcolor, 'stroke': bgcolor});

var center_label = paper.text(pwidth/2, pheight/2, '')
  .attr({'fill': 'black', 'font-size': '12', "font-weight": 800, 'opacity': 1 });

if (currentEnv == 'development' || currentEnv == 'test' || currentEnv == 'production' || currentEnv == 'staging'){
	center_label.attr('text', '$'+projectAmount);
} else {
	center_label.attr('text', 'Rs. '+projectAmount);
}
