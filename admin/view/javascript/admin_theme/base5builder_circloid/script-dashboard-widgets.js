$(document).ready(function(){

	/*

	Dashboard Widget Layout (Homepage) JS

	*/

	/* Step 1 For Charts: Set/Reset/Adjust Canvas Width & Height - Start */

	function setCanvasWidth(){
		// Large Order/Customer - Line Chart
		// Get current width of the line chart outer container
		var orderCustomerChartWidth = $("#report-order-customer-statistic").width();
		if(orderCustomerChartWidth > 1){
			$("#order-customer-chart").css("width", orderCustomerChartWidth + "px");
		}

		// Order/Customer - Day - Line Chart
		// Get current width of the line chart outer container
		var orderCustomerChartDayWidth = $("#report-order-customer-statistic-day").width();
		if(orderCustomerChartDayWidth > 1){
			$("#order-customer-chart-day").css("width", orderCustomerChartDayWidth + "px");
		}

		// Order/Customer - Week - Line Chart
		// Get current width of the line chart outer container
		var orderCustomerChartWeekWidth = $("#report-order-customer-statistic-week").width();
		if(orderCustomerChartDayWidth > 1){
			$("#order-customer-chart-week").css("width", orderCustomerChartWeekWidth + "px");
		}

		// Order/Customer - Month - Line Chart
		// Get current width of the line chart outer container
		var orderCustomerChartMonthWidth = $("#report-order-customer-statistic-month").width();
		if(orderCustomerChartDayWidth > 1){
			$("#order-customer-chart-month").css("width", orderCustomerChartMonthWidth + "px");
		}

		// Order/Customer - Year - Line Chart
		// Get current width of the line chart outer container
		var orderCustomerChartYearWidth = $("#report-order-customer-statistic-year").width();
		if(orderCustomerChartDayWidth > 1){
			$("#order-customer-chart-year").css("width", orderCustomerChartYearWidth + "px");
		}

		// Top Customers - Donut Chart
		// Get current width of the donut chart outer container
		var topCustomerChartWidth = $(".top-customers-chart-outer").width();

		// Get current height of the donut chart outer container
		var topCustomerChartHeight = $(".top-customers-chart-container").height();

		if(topCustomerChartWidth > 0){
			if(topCustomerChartWidth >= topCustomerChartHeight){
				// Set canvas height and width of canvas to topCustomerChartHeight
				$("#top-customers-chart").css("height", topCustomerChartHeight - 35 + "px").css("width", topCustomerChartHeight - 35 + "px");
			}else{
				// Set canvas height and width of canvas to topCustomerChartWidth
				$("#top-customers-chart").css("height", topCustomerChartWidth - 15 + "px").css("width", topCustomerChartWidth - 15 + "px");
			}
		}

		// Top Products - Donut Chart
		// Get current width of the donut chart outer container
		var topProductChartWidth = $(".top-products-chart-outer").width();

		// Get current height of the donut chart outer container
		var topProductChartHeight = $(".top-products-chart-container").height();

		if(topProductChartWidth > 0){
			if(topProductChartWidth >= topProductChartHeight){
				// Set canvas height and width of canvas to topProductChartHeight
				$("#top-products-chart").css("height", topProductChartHeight - 35 + "px").css("width", topProductChartHeight - 35 + "px");
			}else{
				// Set canvas height and width of canvas to topProductChartWidth
				$("#top-products-chart").css("height", topProductChartWidth - 15 + "px").css("width", topProductChartWidth - 15 + "px");
			}
		}


		// Sales - Pie Chart
		// Get current width of the pie chart outer container
		var salesValueChartWidth = $(".sales-value .sales-value-chart").width();

		// Get current height of the pie chart outer container
		var salesValueChartHeight = $(".sales-value .dashboard-overview-outer").height();

		// Set both width and height to the smaller value of the two
		if(salesValueChartWidth > 0){
			if(salesValueChartWidth >= salesValueChartHeight){
				// Set canvas height and width of canvas to salesValueChartHeight
				$("#sales-value-chart").css("height", salesValueChartHeight - 10 + "px").css("width", salesValueChartHeight - 10 + "px");
			}else{
				// Set canvas height and width of canvas to salesValueChartWidth
				$("#sales-value-chart").css("height", salesValueChartWidth - 10 + "px").css("width", salesValueChartWidth - 10 + "px");
			}
		}
	}

	/* Step 1 For Charts: Set/Reset/Adjust Canvas Width & Height - End */


	/* Step 2a For Charts: Set Line Charts (Statistics, Daily, Weekly, Month, Yearly Charts) - Start */

	(function(fn){
		if (!fn.map) fn.map=function(f){var r=[];for(var i=0;i<this.length;i++)r.push(f(this[i]));return r}
		if (!fn.filter) fn.filter=function(f){var r=[];for(var i=0;i<this.length;i++)if(f(this[i]))r.push(this[i]);return r}
	})(Array.prototype);


	// Order/Customer Statistics - All (Used For All Date Ranges [Day, Week, Month, Year])
	function getOrderCustomerChart(range, canvasID) {

		// Get the token Var from URL
		var split = location.search.replace('?','').split('&').map(function(val){
			return val.split('=');
		});

		$.ajax({
			type: 'GET',
			url: 'index.php?route=common/home/chart&token=' + split[1][1] + '&range=' + range,
			dataType: 'json',
			beforeSend: function(){
				$(canvasID).html("<img src='view/image/admin_theme/base5builder_circloid/loading.gif' />");
			},
			error: function(){
				var textErrorChart = $(canvasID).parent().siblings().find(".text_error_chart").html();
				$(canvasID).html("<p>" + textErrorChart + "</p>");
			},
			success: function(json) {

				var option = {	
					series: {
						lines: { 
							show: true,
							fill: true,
							lineWidth: 1
						},
						points: {
							show: true
						}	
					},
					shadowSize: 0,
					grid: {
						backgroundColor: '#FFFFFF',
						borderColor: '#F2F2F2',
						hoverable: true
					},
					legend: {
						show: false
					},
					xaxis: {
						ticks: json.xaxis
					},
					tooltip: true,
					tooltipOpts: {
						content: "%s: <b>%y</b>",
						shifts: {
							x: -60,
							y: 25
						},
						defaultTheme : false
					}
				}
				var colorCode = $(canvasID).parent().siblings(".colors").text();
				option.colors = colorCode.split(',');

				$.plot($(canvasID), [json.order, json.customer], option);
			}
		});
	}

	/* Step 2a For Charts: Set Line Charts (Statistics, Daily, Weekly, Month, Yearly Charts) - End */


	/* Step 2b For Charts: Set Pie Chart (Sales-Value Chart) - Start */


	function getSalesValueChart(){

		// Set the variables
		var salesTotal = parseFloat($("#total_sale_raw").val());

		var salesThisYear = parseFloat($("#total_sale_year_raw").val());
		var salesThisYearText = $("#total_sale_year_raw").data("text-label");
		var salesThisYearCurrency = $("#total_sale_year_raw").data("currency-value");

		var salesPreviousYears = parseFloat($("#total_sales_previous_years_raw").val());
		var salesPreviousYearsText = $("#total_sales_previous_years_raw").data("text-label");
		var salesPreviousYearsCurrency = $("#total_sales_previous_years_raw").data("currency-value");

		$("#title").text("Default pie chart"); // ADD HERE - What the hell is this and why is it needed? I can't remember!
		$("#description").text("The default pie chart with no options set."); // ADD HERE - What the hell is this and why is it needed? I can't remember!

		var placeholder = $("#sales-value-chart");

		var colorCode = $("#sales-value-chart").parent().siblings(".colors").text().split(',');

		// Set the label options
		var data = [
		{ label: salesThisYearText + " <b>" + salesThisYearCurrency + "</b>",  data: salesThisYear, color: colorCode[0]},
		{ label: salesPreviousYearsText + " <b>" + salesPreviousYearsCurrency + "</b>",  data: salesPreviousYears, color: colorCode[1]}
		];

		// Plot the chart and set options
		$.plot(placeholder, data, {
			series: {
				pie: { 
					show: true,
					radius:  1,
					innerRadius: 0
				}
			},
			legend: {
				show: true,
				container: '#hiddenLegend'
			},
			grid: {
				hoverable: true,
				clickable: true
			},
			tooltip: true,
			tooltipOpts: {
				content: "%s",
				shifts: {
					x: -60,
					y: 25
				},
				defaultTheme : false
			}
		});
	}

	/* Step 2b For Charts: Set Pie Chart (Sales-Value Chart) - End */


	/* Step 2c For Charts: Set Donut Chart (Top Customer, Top Product) - Start */

	// Arguments Needed: range = day, week, ..., canvasID = where the chart will be plotted, path = the path to the DB query
	function getTopCustomerProductChart(range, canvasID, path){

		// Get the token Var from URL
		var split = location.search.replace('?','').split('&').map(function(val){
			return val.split('=');
		});

		// Check which widget is ebing updated, Top Customer or Top Product
		splitPath = path.split("/");

		if(splitPath[1] == "customer"){
			var list = "customer";
		}else if(splitPath[1] == "product"){
			var list = "product";
		}

		$.ajax({
			type: 'GET',
			url: 'index.php?route=' + path + '&token=' + split[1][1] + '&range=' + range,
			dataType: 'json',
			beforeSend: function(){
				if(list == "customer"){
					$("#top-customers-chart").html("<img src='view/image/admin_theme/base5builder_circloid/loading.gif' />");
				}else if(list == "product"){
					$("#top-products-chart").html("<img src='view/image/admin_theme/base5builder_circloid/loading.gif' />");
				}
			},
			error: function(){
				if(list == "customer"){
					var textErrorChart = $(".top-customers .text_error_chart").html();
					$("#top-customers-chart").html("<p>" + textErrorChart + "</p>");
				}else if(list == "product"){
					var textErrorChart = $(".top-products .text_error_chart").html();
					$("#top-products-chart").html("<p>" + textErrorChart + "</p>");
				}
			},
			success: function(json) {

				// Set the variables
				var data = [];
				var n = 0;

				// Reset the names/products in the list before population
				if(list == "customer"){
					$(".top-customers-list ul li .list-name").text("--");

					var textView = $(".top-customers .text_view").html();

					var colorCode = $(canvasID).parent().parent().siblings(".colors").text().split(',');

					// Populate the data array to be used by $.plot
					$.each(json.total, function(index, val){

						data.push({ label: json.name[n] + ": <b>" + json.total_currency[n] + "</b>",  data: json.total[n], color: colorCode[n]});

						// Adds 1 to n so it can correspond to the correct element name in the list
						m = n + 1;

						// Replaces the current text within the list with the customers name
						if(json.name[n] != ""){
							$(".top-customers-list ul li.top-customers-" + m + " .list-name").html('<a href="index.php?route=sale/customer&token=' + split[1][1] + '&filter_name=' + encodeURI(json.name[n]) + '">' + json.name[n] + '</a>' + ' - ' + json.total_currency[n] );
						}
						// Increment n to get the next value in the array. The loop ends here if there is no other item within the array
						n++;
					});


				}else if(list == "product"){
					$(".top-products-list ul li .list-name").text("--");

					var textView = $(".top-products .text_view").html();
					var textSold = $(".top-products .text_sold").html();

					var colorCode = $(canvasID).parent().parent().siblings(".colors").text().split(',');

					// Populate the data array to be used by $.plot
					$.each(json.quantity, function(index, val){

						data.push({ label: json.product_name[n] + ": <b>" + json.quantity[n] + " " + textSold +"</b>",  data: json.quantity[n], color: colorCode[n]});

						// Adds 1 to n so it can correspond to the correct element name in the list
						m = n + 1;

						// Replaces the current text within the list with the products name
						if(json.product_name[n] != ""){
							$(".top-products-list ul li.top-products-" + m + " .list-name").html('<a href="index.php?route=catalog/product&token=' + split[1][1] + '&filter_name=' + encodeURI(json.product_name[n]) + '">' + json.product_name[n] + '</a>' + ' - ' + json.quantity[n] + ' ' + textSold );
						}

						// Increment n to get the next value in the array. The loop ends here if there is no other item within the array
						n++;
					});
				}

				// Display "No Data" Message if there is no data
				if(list == "customer" && json.total == ""){
					// Get "no data" message
					var textNoData = $(".top-customers .text_no_data").html();
					$("#top-customers-chart").html("<p>" + textNoData + "</p>");
				}else if(list == "product" && json.quantity == ""){
					// Get "no data" message
					var textNoData = $(".top-products .text_no_data").html();
					$("#top-products-chart").html("<p>" + textNoData + "</p>");
				}else{

					var placeholder = $(canvasID);

					// Plot the chart and set options
					$.plot(placeholder, data, {
						series: {
							pie: { 
								show: true,
								radius:  1,
								innerRadius: 0.8
							}
						},
						legend: {
							show: true,
							container: '#hiddenLegend'
						},
						grid: {
							hoverable: true,
							clickable: true
						},
						tooltip: true,
						tooltipOpts: {
							content: "%s",
							shifts: {
								x: -60,
								y: 25
							},
							defaultTheme : false
						}
					});
				}
			}
		});
	}

	/* Step 2c For Charts: Set Donut Chart (Top Customer, Top Product) - End */


	/* Step 3a For Chart: Plot Charts If Enabled - Start */

	// Set Canvas Width For All Available Charts
	// Set the varialbles
	var chartOrderCustomerExists = $("#order-customer-chart").height();
	var chartOrderCustomerDayExists = $("#order-customer-chart-day").height();
	var chartOrderCustomerWeekExists = $("#order-customer-chart-week").height();
	var chartOrderCustomerMonthExists = $("#order-customer-chart-month").height();
	var chartOrderCustomerYearExists = $("#order-customer-chart-year").height();
	var chartSalesValueExists = $("#sales-value-chart").height();
	var chartTopCustomerExists = $("#top-customers-chart").height();
	var chartTopProductExists = $("#top-products-chart").height();

	// Resize the respective canvas if any of the charts require it
	if(chartOrderCustomerExists > 0 || chartOrderCustomerDayExists > 0 || chartOrderCustomerWeekExists > 0 || chartOrderCustomerMonthExists > 0 || chartOrderCustomerYearExists > 0 || chartSalesValueExists > 0 || chartTopCustomerExists > 0 || chartTopProductExists > 0){ // ADD HERE - Other charts are enabled, then set their width
		setCanvasWidth();
	}

	// Checks If Order/Customer Statistics (Large) Widget Exists
	if(chartOrderCustomerExists > 0){
		getOrderCustomerChart($('#range-order-customer').val(), "#order-customer-chart");

		// Populate Chart With New Data When New Date Range Is Selected
		$("#range-order-customer").change(function(){
			// Get Date Range
			var chartRange = $('#range-order-customer').val();
			// Plot It
			getOrderCustomerChart(chartRange, "#order-customer-chart");

		});
	}

	// Checks If Order/Customer Statistics Day Widget Exists
	if(chartOrderCustomerDayExists > 0){
		// Plot Chart
		getOrderCustomerChart("day", "#order-customer-chart-day");
	}

	// Checks If Order/Customer Statistics Week Widget Exists
	if(chartOrderCustomerWeekExists > 0){
		// Plot Chart
		getOrderCustomerChart("week", "#order-customer-chart-week");
	}

	// Checks If Order/Customer Statistics Month Widget Exists
	if(chartOrderCustomerMonthExists > 0){
		// Plot Chart
		getOrderCustomerChart("month", "#order-customer-chart-month");
	}

	// Checks If Order/Customer Statistics Year Widget Exists
	if(chartOrderCustomerYearExists > 0){
		getOrderCustomerChart("year", "#order-customer-chart-year");
	}

	// Checks If Top Customer Widget Exists
	if(chartTopCustomerExists > 0){
		// Plot Chart
		getTopCustomerProductChart($('#range-top-customers').val(), "#top-customers-chart", "sale/customer/gettopcustomers");

		// Populate Chart With New Data When New Date Range Is Selected
		$("#range-top-customers").change(function(){
			// Get Date Range
			var chartRange = $('#range-top-customers').val();
			// Plot It
			getTopCustomerProductChart(chartRange, "#top-customers-chart", "sale/customer/gettopcustomers");

		});
	}

	// Checks If Top Product Widget Exists
	if(chartTopProductExists > 0){
		// Plot Chart
		getTopCustomerProductChart($('#range-top-products').val(), "#top-products-chart", "catalog/product/gettopproducts");

		// Populate Chart With New Data When New Date Range Is Selected
		$("#range-top-products").change(function(){
			// Get Date Range
			var chartRange = $('#range-top-products').val();
			// Plot It
			getTopCustomerProductChart(chartRange, "#top-products-chart", "catalog/product/gettopproducts");

		});
	}

	// Checks If Sales-Value Widget Exists.
	// BUG: Caused by plugin itself. The Sales-Value Chart (Pie Chart) needs to be called after Top Customer & Top Product(Donut Charts) because some settings of the Donut Chart affect the Pie Chart. This bug still occurs when you hover over the Pie Chart. NEED FIX!
	if(chartSalesValueExists > 0){
		// Plot Chart
		getSalesValueChart();
	}

	/* Step 3a For Chart: Plot Charts If Enabled - End */

	
	/* Step 3b For Chart: Window Resize - Resets Widths Of Charts, Menu - Start */

	// Function To Prevent Multiple Calls While Browser Is Resizing Or Orientation Is Changed (Prevents a glitching effect)

	var waitForFinalEvent = (function () {
		var timers = {};
		return function (callback, ms, uniqueId) {
			if (!uniqueId) {
				uniqueId = "Don't call this twice without a uniqueId";
			}
			if (timers[uniqueId]) {
				clearTimeout (timers[uniqueId]);
			}
			timers[uniqueId] = setTimeout(callback, ms);
		};
	})();

	function generateUniqueString(){
		var text = "";
		var possible = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";

		for( var i=0; i < 5; i++ )
			text += possible.charAt(Math.floor(Math.random() * possible.length));

		return text;
	}
	
	// Actual Window Resize Code
	var currentWindowWidth = $(window).width();

	$(window).resize(function () {
		waitForFinalEvent(function(){

			if($(this).width() != currentWindowWidth){

				currentWindowWidth = $(window).width();

				/*
					
					ADD HERE - Add Close Menu for Smaller screens

				*/

				// Resize and Reload the Order/Customer Chart
				if(chartOrderCustomerExists > 0){
					setCanvasWidth();
					getOrderCustomerChart($('#range-order-customer').val(), "#order-customer-chart");
				}

				// Resize and Reload the Order/Customer - Day Chart
				if(chartOrderCustomerDayExists > 0){
					setCanvasWidth();
					getOrderCustomerChart("day", "#order-customer-chart-day");
				}

				// Resize and Reload the Order/Customer - Week Chart
				if(chartOrderCustomerWeekExists > 0){
					setCanvasWidth();
					getOrderCustomerChart("week", "#order-customer-chart-week");
				}

				// Resize and Reload the Order/Customer - Month Chart
				if(chartOrderCustomerMonthExists > 0){
					setCanvasWidth();
					getOrderCustomerChart("month", "#order-customer-chart-month");
				}

				// Resize and Reload the Order/Customer - Year Chart
				if(chartOrderCustomerYearExists > 0){
					setCanvasWidth();
					getOrderCustomerChart("year", "#order-customer-chart-year");
				}

				// Resize and Reload the Top Customer Chart
				if(chartTopCustomerExists > 0){
					setCanvasWidth();
					getTopCustomerProductChart($('#range-top-customers').val(), "#top-customers-chart", "sale/customer/gettopcustomers");
				}

				// Resize and Reload the Top Product Chart
				if(chartTopProductExists > 0){
					setCanvasWidth();
					getTopCustomerProductChart($('#range-top-products').val(), "#top-products-chart", "catalog/product/gettopproducts");
				}

				// Resize and Reload the Sales-Value Chart
				if(chartSalesValueExists > 0){
					setCanvasWidth();
					getSalesValueChart();
				}
			}

		}, 500, generateUniqueString());
	});

	/* Step 3b For Chart: Window Resize - Resets Widths Of Charts, Menu - End */


});