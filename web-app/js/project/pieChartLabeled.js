var spendCauseList = $('#spendCauseList').val();
var spendAmountPerList = $('#spendAmountPerList').val();
var payuStatus = $('#payuStatus').val();
var projectAmount = $('#projectamount').val();
var list1;
if (spendCauseList != null || spendCauseList != undefined) {
	list1 = spendCauseList.split(",");
}

var list2
if (spendAmountPerList != null || spendAmountPerList != undefined) {
	list2 = spendAmountPerList.split(",");
}
var percentageList = []
var currentEnv=$('#currentEnv').val();

if (list2 != undefined && list1 != undefined) {
    for (i=0; i<list2.length; i++){
        percentageList.push(parseInt(list2[i]))
    }
    var $container = jQuery('#graph');
    var barcolors      = ['#99E5E5','#D1FF19', '#FFAA2B', '#5EFF36', '#FF2626', '#FFFF2A', '#DDA0DD', '#FDC6C0', '#BF6666', '#FDBC80', '#FDDF5B', '#FF2626', '#DDA0DD', '#5EFF36', '#FFFF2A', '#FDC6C0', '#D1FF19', '#FFAA2B'],
        highlightcolor = '#FFF68F',
        lengendlabels  = list1,
        data           = percentageList;

    var pheight = parseInt($container.css('height')),
        pwidth  = parseInt($container.css('width')),
        bgcolor = jQuery('body').css('background-color'),
        radius;

    if (screen.width > 1025){
        radius  = pwidth < pheight ? pwidth/2.2 : pheight/2.2;
    } else if (screen.width > 767 && screen.width < 1025){
        radius  = pwidth < pheight ? pwidth/2.8 : pheight/2.8;
    } else {
        radius  = pwidth < pheight ? pwidth/3.2 : pheight/3.2;
    }

    var paper = new Raphael($container[0], pwidth, pheight);

    // draw the piechart
    var pie = paper.piechart(pwidth/2, pheight/2, radius, data, { 
        legend: lengendlabels, 
        legendpos: 'east',
        legendcolor: 'black',
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
  
        if (this.label) {
            this.label[0].stop();
            this.label[0].attr({ r: 8.5 });
            this.label[1].attr({ "font-weight": 800 });
            if (payuStatus == true || payuStatus == 'true'){
                center_label.attr('text', 'Rs. '+this.value.value);
            } else {
                center_label.attr('text', '$'+this.value.value);
            }
            //   center_label.animate({ 'opacity': 1.0 }, 500);
        }
    }, function () {
        this.sector.animate({ transform: 's1 1 ' + this.cx + ' ' + this.cy }, 500, "bounce");
        this.sector.animate({ 'stroke': bgcolor }, 400);
        if (this.label) {
            this.label[0].animate({ r: 5 }, 500, "bounce");
            this.label[1].attr({ "font-weight": 400 });
            //center_label.attr('text','');
            //    center_label.animate({ 'opacity': 0.0 }, 500);
        }
    });

    pie.mouseout(function (){
        if (payuStatus == true || payuStatus == 'true'){
            center_label.attr('text', 'Rs. '+projectAmount);
        } else {
            center_label.attr('text', '$'+projectAmount);
        }
    });

    //  blank circle in center to create donut hole effect
    paper.circle(pwidth/2, pheight/2, radius*0.5)
        .attr({'fill': bgcolor, 'stroke': bgcolor});

        var center_label = paper.text(pwidth/2, pheight/2, '')
        .attr({'fill': 'black', 'font-size': '12', "font-weight": 800, 'opacity': 1 });

    // to show campaign amount at center on page load
    if (payuStatus == true || payuStatus == 'true'){
        center_label.attr('text', 'Rs. '+projectAmount);
    } else {
        center_label.attr('text', '$'+projectAmount);
    }

}
