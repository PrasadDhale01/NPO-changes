var miscellaneous = $('#miscellaneous').val();
var spendAmountPerList = $('#spendAmountPerList').val();
var projectAmount = $('#projectamount').val();
var percentageList = [];

if (miscellaneous === 'hasOtherValues'){
    var list2 = spendAmountPerList.split(",");
    for (var i=0; i<list2.length; i++){
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

var bgcolor = jQuery('body').css('background-color');

var paper = new Raphael($container[0], pwidth, pheight);

// draw the piechart
var pie = paper.piechart(pwidth/2, pheight/2, radius, data, {
    stroke: bgcolor,
    strokewidth: 1,
    colors: barcolors
});

var isIndianCampaign = ($('#isIndianCampaign').val() === 'true') ? true : false;

// assign the hover in/out functions
pie.hover(function () {
    this.sector.stop();
    this.sector.scale(1.05, 1.05, this.cx, this.cy);
    this.sector.animate({ 'stroke': highlightcolor }, 400);
    this.sector.animate({ 'stroke-width': 1 }, 500, "bounce");

    if (isIndianCampaign){
        center_label.attr('text', 'Rs. '+this.value.value);
    } else {
        center_label.attr('text', '$'+this.value.value);
    }
}, function () {
    this.sector.animate({ transform: 's1 1 ' + this.cx + ' ' + this.cy }, 500, "bounce");
    this.sector.animate({ 'stroke': bgcolor }, 400);

    if (isIndianCampaign){
        center_label.attr('text', 'Rs. '+this.value.value);
    } else {
        center_label.attr('text', '$'+this.value.value);
    }
});

pie.mouseout(function (){
    if (isIndianCampaign){
        center_label.attr('text', 'Rs. '+projectAmount);
    } else {
        center_label.attr('text', '$'+projectAmount);
    }
});

// blank circle in center to create donut hole effect
paper.circle(pwidth/2, pheight/2, radius*0.5)
    .attr({'fill': bgcolor, 'stroke': bgcolor});

var center_label = paper.text(pwidth/2, pheight/2, '')
    .attr({'fill': 'black', 'font-size': '12', "font-weight": 800, 'opacity': 1 });

//to show campaign amount at center on page load
if (isIndianCampaign){
    center_label.attr('text', 'Rs. '+projectAmount);
} else {
    center_label.attr('text', '$'+projectAmount);
}
