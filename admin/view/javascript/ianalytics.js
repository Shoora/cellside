google.load("visualization", "1", {packages:["corechart"]});

$('a[href=#search-queries]').bind('click', function() {
	setTimeout(function() { drawChart(); }, 500);
});

$('a[href=#dashboard1]').bind('click', function() {
	setTimeout(function() { drawChart(); }, 500);
});

$('a[href=#searches]').bind('click', function() {
	$('a[href=#search-queries]').click();
});

google.setOnLoadCallback(drawChart);
function drawChart() {
	if(typeof(monthlySearchesGraph) != 'undefined') {
		var data = google.visualization.arrayToDataTable(monthlySearchesGraph);
		var options = {
		  hAxis: {title: '',  titleTextStyle: {color: 'blue'}, slantedText:true},
		  chartArea: {left: 70},
		  width: $('ul.iModuleAdminSuperWrappers').width() - 250,
		  height: 400
		};
		
		var chart = new google.visualization.AreaChart(document.getElementById('searchedFound'));
		chart.draw(data, options);
	}
	
	var rawDataToArray = function(num) {
		if (!num) return null;
		var rawrows = num.split(';');
		var rows = [];
		$(rawrows).each(function(i) {
			var expression = $.trim($(this)[0]);
			if (expression != '') {
				var spl = expression.split(':');
				if (spl[1]) { spl[1] = parseInt(spl[1])}
				rows.push(spl);
			}
		});
		
		return rows;
	}
	
	// Pieable
	$('.pieable').each(function(index) {

		var data = new google.visualization.DataTable();
		var title = $(this).data('title'); if (!title) { title = ''; }
		var options = {
		  width: $('#content').width()/4 - 50,
		  title: title,
		  backgroundColor: 'transparent',
		  is3D: false,
		  chartArea: {
			  width: '100%',
			  height: '75%'
		  },
		  legend: {
			 position: 'right',
			 textStyle: {
				 fontSize: '11'
			 }
		  },
		  pieSliceTextStyle: {
			 fontSize: '11'
		  }
		};
		
		var rows = rawDataToArray($(this).data('num'));
		var colors = [];
		$(rows).each(function(i) {
			if (rows[i])
				if (rows[i][2]) {
					colors.push(rows[i].pop());
				}
		});
		if (colors.length > 0) {
			options.colors = colors;
		}
		//var colors = rawDataToArray($(this).data('colors'));
		
		data.addColumn('string', 'Label');
		data.addColumn('number', 'Value');
		data.addRows(rows);
		
		var chart = new google.visualization.PieChart($(this)[0]);
		chart.draw(data, options);
	});

}


var nowDate = new Date();

$('.iAnalyticsDateFilter input').datepicker({
	dateFormat:'yy-mm-dd',
	changeMonth:true,
	changeYear:true,
	maxDate:'+0 d',
	minDate:iAnalyticsMinDate
});

$('.fromDate').datepicker("option", "onSelect", function( selectedDate ) {
	iAnalyticsUpdateSelect($(this));
	$( ".iAnalyticsDateFilter input.toDate" ).datepicker( "option", "minDate", selectedDate );
});

$('.toDate').datepicker("option", "minDate", $( ".iAnalyticsDateFilter input.fromDate" ).datepicker( "getDate" ));
$('.toDate').datepicker("option", "onSelect", function( selectedDate ) {
	iAnalyticsUpdateSelect($(this));
	$( ".iAnalyticsDateFilter input.fromDate" ).datepicker( "option", "maxDate", selectedDate );
});

$('.iAnalyticsSelectBox').change(function(e) {
	
	var fromDate = new Date(); fromDate.setTime(nowDate.getTime());
	var toDate = new Date(); toDate.setTime(nowDate.getTime());
	var substract = 0;
	if ($(this).val() == 'last-week') {
		substract = 6*24*3600*1000;
	} else if ($(this).val() == 'last-month') {
		substract = 29*24*3600*1000;	
	} else if ($(this).val() == 'last-year') {
		substract = 364*24*3600*1000;	
	}
	
	fromDate.setTime(fromDate.getTime() - substract);
	
	if (substract > 0) {
		$('.iAnalyticsDateFilter .toDate').datepicker('setDate', toDate);
		$('.iAnalyticsDateFilter .fromDate').datepicker('setDate', fromDate);
	}
});

$('.iAnalyticsDateFilter button.dateFilterButton').click(function(event) {
	var fromDate = $(this).parent().parent().children('td:eq(1)').children('input').val();
	var toDate = $(this).parent().parent().children('td:eq(2)').children('input').val();
	
	iAnalyticsFilterDates(fromDate, toDate);
	
	fromDate = $.datepicker.formatDate('yy-mm-dd', $(this).parent().parent().children('td:eq(1)').children('input').datepicker( "getDate" ));
	toDate =  $.datepicker.formatDate('yy-mm-dd', $(this).parent().parent().children('td:eq(2)').children('input').datepicker( "getDate" ));

	var newURL = document.location.search;

	if (newURL.match(/fromDate=/) != null) {
		newURL = newURL.replace(/fromDate=(.*)(&|$)/g, "fromDate=" + fromDate + "&");	
	} else { 
		newURL +='&fromDate=' + fromDate; 
	}
	
	if (newURL.match(/toDate=/) != null) {
		newURL = newURL.replace(/toDate=(.*)(&|$)/g, "toDate=" + toDate + "&");	
	} else { 
		newURL +='&toDate=' + toDate; 
	}
	
	newURL = newURL.replace(/&+/g, "&");
	newURL = newURL.replace(/(&$)/g, "");
	
	document.location.search = newURL ;
});

function iAnalyticsUpdateSelect(field) {
	var fromDate = $(field).parent().parent().children('td:eq(1)').children('input').datepicker('getDate').getTime()/(24*3600*1000);
	var toDate = $(field).parent().parent().children('td:eq(2)').children('input').datepicker('getDate').getTime()/(24*3600*1000);
	var interval = null;
	
	if ($.datepicker.formatDate('yy-mm-dd', $(field).parent().parent().children('td:eq(2)').children('input').datepicker('getDate')) == $.datepicker.formatDate('yy-mm-dd', nowDate)) {
		interval = toDate - fromDate + 1;	
	}
	
	if (interval == 7) {
		$('.iAnalyticsSelectBox').val('last-week');
	} else if (interval == 30) {
		$('.iAnalyticsSelectBox').val('last-month');
	} else if (interval == 365) {
		$('.iAnalyticsSelectBox').val('last-year');
	} else {
		$('.iAnalyticsSelectBox').val('custom');
	}
}

function iAnalyticsFilterDates(fromDate, toDate) {
	try {
		$.datepicker.parseDate('yy-mm-dd', toDate);
	} catch(err) {
		$( ".iAnalyticsDateFilter input.fromDate" ).datepicker( "setDate", $('.iAnalyticsDateFilter input.toDate').datepicker("option", "maxDate"));
	}
	
	try {
		$.datepicker.parseDate('yy-mm-dd', fromDate);
	} catch(err) {
		$( ".iAnalyticsDateFilter input.fromDate" ).datepicker( "setDate", iAnalyticsMinDate );
	}
}