$(document).ready(function(){

	/*

	Dashboard Editor & Widget Editor JS

	*/

	/* Dashboard Editor View - Start */


	/* Color Profile - Start */

	// Enable Color Profile - Function enables your selected Color Profile
	function enableColorProfile(id, clickedLink) {

		// Get the token Var from URL
		var split = location.search.replace('?','').split('&').map(function(val){
			return val.split('=');
		});

		$.ajax({
			type: 'GET',
			url: 'index.php?route=common/admin_circloid_dashboard_editor/enablecolorprofile&token=' + split[1][1] + '&enabled=' + id,
			dataType: 'json',
			beforeSend: function(){
				$(".dashboard-editor-color-profile .loading").show();
			},
			error: function(){
				var textAjaxError = $(".ajax-error").text();
				$('<div class="warning hidden">' + textAjaxError + '</div>').appendTo(".dashboard-editor-content").css("visibility", "visible").fadeIn(300);
				$(".dashboard-editor-color-profile .loading").hide();
			},
			success: function(json) {

				/*
				If change successful, then 1) change the body class to the new profile, 2) Change all the text from Enabled to disabled and vice versa
				*/

				$('.success').remove();
				$('.warning').remove();

				$(".dashboard-editor-color-profile .loading").hide();

				if(json.success_profile_enabled){
					$('<div class="success">' + json.success_profile_enabled + '</div>').appendTo(".dashboard-editor-content").css("visibility", "visible").fadeIn(300, function(){

						$("body").removeClass().addClass(json.profile_enabled['css_name']);

						$(".dashboard-editor-color-profile table.list tbody tr .disabled").css("visibility", "visible").fadeIn(300);
						$(".dashboard-editor-color-profile table.list tbody tr .enabled").hide();
						$(".dashboard-editor-color-profile table.list tbody tr .action span").css("visibility", "visible").fadeIn(300);

						$(clickedLink).parents().eq(1).prev().find(".disabled").hide();
						$(clickedLink).parents().eq(1).prev().find(".enabled").css("visibility", "visible").fadeIn(300);
						$(clickedLink).parents().eq(0).hide();

						setTimeout(function() {
							location.reload();
						}, 300);
					});
				}

				if(json.error_profile_enabled){
					$('<div class="warning">' + json.error_profile_enabled + '</div>').appendTo(".dashboard-editor-content").css("visibility", "visible").fadeIn(300);
				}
			}
		});
	}

	// Click event to enable Color Profile
	$(".enable-color-profile").click(function(e){
		var id = $(this).data("id");
		var clickedLink = this;

		enableColorProfile(id, clickedLink);
		e.preventDefault();
	});

	/* Color Profile - End */


	/* Enable Widget - Start */

	// Enable Widget Layout - Function enables your selected Widget Layout
	function enableWidgetLayout(id, clickedLink) {

		// Get the token Var from URL
		var split = location.search.replace('?','').split('&').map(function(val){
			return val.split('=');
		});

		$.ajax({
			type: 'GET',
			url: 'index.php?route=common/admin_circloid_dashboard_editor/enablewidgetlayout&token=' + split[1][1] + '&enabled=' + id,
			dataType: 'json',
			beforeSend: function(){
				$(".dashboard-editor-widget-editor .loading").show();
			},
			error: function(){
				var textAjaxError = $(".ajax-error").text();
				$('<div class="warning hidden">' + textAjaxError + '</div>').appendTo(".dashboard-editor-content").css("visibility", "visible").fadeIn(300);
				$(".dashboard-editor-widget-editor .loading").hide();
			},
			success: function(json) {
				// If change successful, then 1) change the active layout, 2) Change all the text from Enabled to disabled and vice versa
				$('.success').remove();
				$('.warning').remove();

				$(".dashboard-editor-widget-editor .loading").hide();

				if(json.success_widget_layout){
					$('<div class="success">' + json.success_widget_layout + '</div>').appendTo(".dashboard-editor-content").css("visibility", "visible").fadeIn(300);

					$(".dashboard-editor-widget-editor table.list tbody tr .disabled").css("visibility", "visible").fadeIn(300);
					$(".dashboard-editor-widget-editor table.list tbody tr .enabled").hide();
					$(".dashboard-editor-widget-editor table.list tbody tr .action span").css("visibility", "visible").fadeIn(300);

					$(clickedLink).parents().eq(1).prev().find(".disabled").hide();
					$(clickedLink).parents().eq(1).prev().find(".enabled").css("visibility", "visible").fadeIn(300);
					$(clickedLink).parents().eq(0).hide();
				}

				if(json.error_widget_layout){
					$('<div class="warning">' + json.error_widget_layout + '</div>').appendTo(".dashboard-editor-content").css("visibility", "visible").fadeIn(300);
				}
			}
		});
	}

	// Click event to enable Widget Layout
	$(".enable-widget-layout").click(function(e){
		var id = $(this).data("id");
		var clickedLink = this;

		enableWidgetLayout(id, clickedLink);
		e.preventDefault();
	});

	/* Enable Widget - End */


	/* Create New Layout - Start */

	// Copy Exsiting Layout
	function copyWidgetLayout(id, new_layout_name, new_description, clickedLink) {

		// Get the token Var from URL
		var split = location.search.replace('?','').split('&').map(function(val){
			return val.split('=');
		});

		$.ajax({
			type: 'GET',
			url: 'index.php?route=common/admin_circloid_dashboard_editor/copywidgetlayout&token=' + split[1][1] + '&copy=' + id + "&new_layout_name=" + new_layout_name + "&new_description=" + new_description,
			dataType: 'json',
			beforeSend: function(){
				$("#create-new-layout-modal .loading").show();
			},
			error: function(){
				var textAjaxError = $(".ajax-error").text();
				$('<div class="warning">' + textAjaxError + '</div>').appendTo(".dashboard-editor-content .modal-header").css("visibility", "visible").fadeIn(300);
				$("#create-new-layout-modal .loading").hide();
			},
			success: function(json) {

				$('.success').remove();
				$('.warning').remove();

				$("#create-new-layout-modal .loading").hide();

				if(json.success_layout_copied){
					$('<div class="success">' + json.success_layout_copied + '</div>').appendTo(".dashboard-editor-content .modal-header").css("visibility", "visible").fadeIn(300);

					// If successful, refresh page
					location.reload();
				}

				if(json.error_layout_copied){
					$('<div class="warning">' + json.error_layout_copied + '</div>').insertAfter(".dashboard-editor-content .modal-header").css("visibility", "visible").fadeIn(300);
				}
			}
		});
}

	// Click event to copy Widget Layout
	$("#create-layout").click(function(e){

		var clickedLink = this;
		var id = $("#old-layouts").val();
		var new_layout_name = $("#new-layout-name").val();
		var new_description = $("#new-description").val();

		copyWidgetLayout(id, new_layout_name, new_description, clickedLink);
		e.preventDefault();
	});

	/* Create New Layout - End */


	/* Delete Widget - Start */

	// Delete Widget Layout - Function enables your selected Widget Layout
	function deleteWidgetLayout(id, clickedLink) {

		// Get the token Var from URL
		var split = location.search.replace('?','').split('&').map(function(val){
			return val.split('=');
		});

		$.ajax({
			type: 'GET',
			url: 'index.php?route=common/admin_circloid_dashboard_editor/deletewidgetlayout&token=' + split[1][1] + '&delete=' + id,
			dataType: 'json',
			beforeSend: function(){
				$(".dashboard-editor-widget-editor .loading").show();
			},
			error: function(){
				var textAjaxError = $(".ajax-error").text();
				$('<div class="warning">' + textAjaxError + '</div>').appendTo(".dashboard-editor-content").css("visibility", "visible").fadeIn(300);
				$(".dashboard-editor-widget-editor .loading").hide();
			},
			success: function(json) {
				// If change successful, change all the text from Enabled to disabled and vice versa
				$('.success').remove();
				$('.warning').remove();

				$(".dashboard-editor-widget-editor .loading").hide();

				if(json.success_widget_layout_deleted){
					$('<div class="success">' + json.success_widget_layout_deleted + '</div>').appendTo(".dashboard-editor-content").css("visibility", "visible").fadeIn(300);

					$(clickedLink).parents().eq(1).fadeOut(500, function(){
						$(this).remove();
					});
				}

				if(json.error_widget_layout_deleted){
					$('<div class="warning">' + json.error_widget_layout_deleted + '</div>').appendTo(".dashboard-editor-content").css("visibility", "visible").fadeIn(300);
				}
			}
		});
}

	// Click event to delete Widget Layout
	$(".delete-widget-layout").click(function(e){
		// first confirm delete with an confirm box

		var textComfirm = $(".text_confirm").text();

		if (!confirm(textComfirm)) {
			return false;
		}else{

			var id = $(this).data("id");
			var clickedLink = this;

			deleteWidgetLayout(id, clickedLink);
			e.preventDefault();
		}
	});

	/* Delete Widget - End */


	/* ACTUAL Widget Editor - Start */

	// Enable drag 'n drop on Enabled/Disabled Widget List
	$( "#sortable1, #sortable2" ).sortable({
		connectWith: ".connectedSortable"
	}).disableSelection();

	// Edit button for widget color
	$(".color-edit").click(function(e){
		// load color editor
		e.preventDefault();
	});

	// Color Picker for all 8 Chart Widgets
	
	// Order Customer Statistic
	var colorOrderCustomerStatistic1 = $("#order_customer_statistic-color-1").val();
	$("#order_customer_statistic-color-1").spectrum({
		color: colorOrderCustomerStatistic1,
		showSelectionPalette: true,
		showInput: true,
		clickoutFiresChange: true
	});	
	var colorOrderCustomerStatistic2 = $("#order_customer_statistic-color-2").val();
	$("#order_customer_statistic-color-2").spectrum({
		color: colorOrderCustomerStatistic2,
		showSelectionPalette: true,
		showInput: true,
		clickoutFiresChange: true
	});
	
	// Order Customer Statistic Day
	var colorOrderCustomerStatisticDay1 = $("#order_customer_statistic_day-color-1").val();
	$("#order_customer_statistic_day-color-1").spectrum({
		color: colorOrderCustomerStatisticDay1,
		showSelectionPalette: true,
		showInput: true,
		clickoutFiresChange: true
	});	
	var colorOrderCustomerStatisticDay2 = $("#order_customer_statistic_day-color-2").val();
	$("#order_customer_statistic_day-color-2").spectrum({
		color: colorOrderCustomerStatisticDay2,
		showSelectionPalette: true,
		showInput: true,
		clickoutFiresChange: true
	});
	
	// Order Customer Statistic Week
	var colorOrderCustomerStatisticWeek1 = $("#order_customer_statistic_week-color-1").val();
	$("#order_customer_statistic_week-color-1").spectrum({
		color: colorOrderCustomerStatisticWeek1,
		showSelectionPalette: true,
		showInput: true,
		clickoutFiresChange: true
	});
	var colorOrderCustomerStatisticWeek2 = $("#order_customer_statistic_week-color-2").val();
	$("#order_customer_statistic_week-color-2").spectrum({
		color: colorOrderCustomerStatisticWeek2,
		showSelectionPalette: true,
		showInput: true,
		clickoutFiresChange: true
	});
	
	// Order Customer Statistic Month
	var colorOrderCustomerStatisticMonth1 = $("#order_customer_statistic_month-color-1").val();
	$("#order_customer_statistic_month-color-1").spectrum({
		color: colorOrderCustomerStatisticMonth1,
		showSelectionPalette: true,
		showInput: true,
		clickoutFiresChange: true
	});
	var colorOrderCustomerStatisticMonth2 = $("#order_customer_statistic_month-color-2").val();
	$("#order_customer_statistic_month-color-2").spectrum({
		color: colorOrderCustomerStatisticMonth2,
		showSelectionPalette: true,
		showInput: true,
		clickoutFiresChange: true
	});
	
	// Order Customer Statistic Year
	var colorOrderCustomerStatisticYear1 = $("#order_customer_statistic_year-color-1").val();
	$("#order_customer_statistic_year-color-1").spectrum({
		color: colorOrderCustomerStatisticYear1,
		showSelectionPalette: true,
		showInput: true,
		clickoutFiresChange: true
	});
	var colorOrderCustomerStatisticYear2 = $("#order_customer_statistic_year-color-2").val();
	$("#order_customer_statistic_year-color-2").spectrum({
		color: colorOrderCustomerStatisticYear2,
		showSelectionPalette: true,
		showInput: true,
		clickoutFiresChange: true
	});
	
	// Sales Value
	var colorSalesValue1 = $("#sales_value-color-1").val();
	$("#sales_value-color-1").spectrum({
		color: colorSalesValue1,
		showSelectionPalette: true,
		showInput: true,
		clickoutFiresChange: true
	});
	var colorSalesValue2 = $("#sales_value-color-2").val();
	$("#sales_value-color-2").spectrum({
		color: colorSalesValue2,
		showSelectionPalette: true,
		showInput: true,
		clickoutFiresChange: true
	});
	
	// Top 5 Customers (One color for each)
	var colorTopCustomers1 = $("#top_customers-color-1").val();
	$("#top_customers-color-1").spectrum({
		color: colorTopCustomers1,
		showSelectionPalette: true,
		showInput: true,
		clickoutFiresChange: true
	});
	var colorTopCustomers2 = $("#top_customers-color-2").val();
	$("#top_customers-color-2").spectrum({
		color: colorTopCustomers2,
		showSelectionPalette: true,
		showInput: true,
		clickoutFiresChange: true
	});
	var colorTopCustomers3 = $("#top_customers-color-3").val();
	$("#top_customers-color-3").spectrum({
		color: colorTopCustomers3,
		showSelectionPalette: true,
		showInput: true,
		clickoutFiresChange: true
	});
	var colorTopCustomers4 = $("#top_customers-color-4").val();
	$("#top_customers-color-4").spectrum({
		color: colorTopCustomers4,
		showSelectionPalette: true,
		showInput: true,
		clickoutFiresChange: true
	});
	var colorTopCustomers5 = $("#top_customers-color-5").val();
	$("#top_customers-color-5").spectrum({
		color: colorTopCustomers5,
		showSelectionPalette: true,
		showInput: true,
		clickoutFiresChange: true
	});
	
	// Top 5 Products (One color for each)
	var colorTopCustomers1 = $("#top_products-color-1").val();
	$("#top_products-color-1").spectrum({
		color: colorTopCustomers1,
		showSelectionPalette: true,
		showInput: true,
		clickoutFiresChange: true
	});
	var colorTopProducts2 = $("#top_products-color-2").val();
	$("#top_products-color-2").spectrum({
		color: colorTopProducts2,
		showSelectionPalette: true,
		showInput: true,
		clickoutFiresChange: true
	});
	var colorTopProducts3 = $("#top_products-color-3").val();
	$("#top_products-color-3").spectrum({
		color: colorTopProducts3,
		showSelectionPalette: true,
		showInput: true,
		clickoutFiresChange: true
	});
	var colorTopProducts4 = $("#top_products-color-4").val();
	$("#top_products-color-4").spectrum({
		color: colorTopProducts4,
		showSelectionPalette: true,
		showInput: true,
		clickoutFiresChange: true
	});
	var colorTopProducts5 = $("#top_products-color-5").val();
	$("#top_products-color-5").spectrum({
		color: colorTopProducts5,
		showSelectionPalette: true,
		showInput: true,
		clickoutFiresChange: true
	});


	// Save Items
	// Function converts RGB to Hex
	function rgbToHex(rgbFull) {
		var lastNumber = rgbFull.length - 1;
		var rgbCode = rgbFull.substring(4,lastNumber);
		var rgbSplit = rgbCode.split(", ");
		var r = parseInt(rgbSplit[0]);
		var g = parseInt(rgbSplit[1]);
		var b = parseInt(rgbSplit[2]);

		return "#" + ((1 << 24) + (r << 16) + (g << 8) + b).toString(16).slice(1);
	}

	$(".save-layout").click(function(e){

		var layoutId = $("#layout-id").val();
		var layoutName = $("#layout-name").val();
		var layoutDescription = $("#description").val();
		var layoutEnabled = $("#layout-enabled").val();

		// Get Enabled Widget List
		var widgetPosition = 0;
		var layoutArray = [];

		$("#sortable2 li").each(function(){
			var widgetId = $(this).data("widget-id");
			var widgetName = $(this).data("widget-name");
			var widgetColors = [];

			$(this).find(".sp-preview-inner").each(function(){
				var getColor = $(this).css("background-color");

				widgetColors.push(rgbToHex(getColor).toUpperCase());
			});

			layoutArray.push({name: widgetName, widget_id: widgetId, colors: widgetColors, enabled: '1'});

			widgetPosition += 1;
		});

		// Get Disabled Widget List
		var widgetPosition = 0;
		
		$("#sortable1 li").each(function(){
			var widgetId = $(this).data("widget-id");
			var widgetName = $(this).data("widget-name");
			var widgetColors = [];

			$(this).find(".sp-preview-inner").each(function(){
				var getColor = $(this).css("background-color");

				widgetColors.push(rgbToHex(getColor).toUpperCase());
			});

			layoutArray.push({name: widgetName, widget_id: widgetId, colors: widgetColors, enabled: '0'});

			widgetPosition += 1;
		});

		var layout = encodeURIComponent(serializeJS(layoutArray));

		// Get the token Var from URL
		var split = location.search.replace('?','').split('&').map(function(val){
			return val.split('=');
		});

		$.ajax({
			type: 'GET',
			url: 'index.php?route=common/admin_circloid_widget_editor/updatewidgetlayout&token=' + split[1][1] + '&layout_id=' + layoutId + "&layout_name=" + layoutName + "&layout_description=" + layoutDescription + "&enabled=" + layoutEnabled + "&layout=" + layout,
			dataType: 'json',
			beforeSend: function(){
				$(".loading").show();
			},
			error: function(){
				var textAjaxError = $(".ajax-error").text();
				$('<div class="warning">' + textAjaxError + '</div>').appendTo("#layout-editor-outer").css("visibility", "visible").fadeIn(300);
				$(".loading").hide();
			},
			success: function(json) {

				$('.success').remove();
				$('.warning').remove();

				$(".loading").hide();

				if(json.success_layout_updated){
					$('<div class="success">' + json.success_layout_updated + '</div>').appendTo("#layout-editor-outer").css("visibility", "visible").fadeIn(300, function(){

						// If successful, return to Dashboard Editor Page
						location.reload();
						// window.location.replace('index.php?route=common/admin_circloid_dashboard_editor&token=' + split[1][1]);
						
					});
				}

				if(json.error_layout_updated){
					$('<div class="warning">' + json.error_layout_updated + '</div>').appendTo("#layout-editor-outer").css("visibility");

				}
			}
		});

		e.preventDefault();
	});

	// Preview Layout

	$(".preview-button").click(function(){
		$("#preview-box .preview-content-box").fadeOut(function(){
			$("#preview-box .preview-content-box").html("");

			$("#sortable2 li").each(function(){
				var widgetName = $(this).data("widget-name");
				var widgetNameReadable = $(this).find(".widget-details-name").text();

				$('<div class="preview-box-widget preview-box-' + widgetName + '">' + widgetNameReadable + '</div>').appendTo("#preview-box .preview-content-box");
			});
			$("#preview-box .preview-content-box").fadeIn();
		});
	});


	/* ACTUAL Widget Editor - End */

	/* Dashboard Editor View - End */

});

