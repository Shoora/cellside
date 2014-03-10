$(document).ready(function(){

	/*

	General JS

	*/

	/* Change Header Icon Based on Color Profile - Start */

	var getColorProfile = $("body").data("color-profile");
	if(getColorProfile){
		var colorProfile = getColorProfile.split("-");
		var getHeaderImage = $("h1 img").attr("src");
		if(getHeaderImage){
			var splitHeaderImage = getHeaderImage.split("/");

			if(colorProfile[0] != "default"){
				$("h1 img").attr("src", splitHeaderImage[0] + "/" + splitHeaderImage[1] + "/" + splitHeaderImage[2] + "/" + splitHeaderImage[3] + "/" + "color_profiles/" + colorProfile[0] + "_" + colorProfile[1] + "/" + splitHeaderImage[4]);
			}
		}
	}

	/* Change Header Icon Based on Color Profile - End */

	/* Secondary Menu - Toggle Effects - Start */

	$(".secondary-menu > ul > li#store > a").click(function(e){
		// Check if menu is open or close
		var menuOpen = $(".secondary-menu > ul ul").is(':visible');
		if(!menuOpen){
			// Open the dropdown menu and add the "menu-open" class
			$(this).parent().addClass("menu-open");
			$(this).next("ul").removeAttr("style").animate({"top": "38px", "opacity":"show"},200);
		}else{
			// Close the dropdown menu and remove the "menu-open" class
			$(this).next("ul").animate({"top": "50px", "opacity":"hide"},200);
			$(this).parent().removeClass("menu-open");
		}
		e.stopPropagation();
	});

	/* Secondary Menu - Toggle Effects - End */


	/* Stock Alert (Header) - Tooltip - Start */

	$(".stock-alert-header .stock-alert a").hover(function(e){
		// Shows the title on hover
		$(this).next("div.alert-label").removeAttr("style").animate({"bottom": "-32px", "opacity":"show"},200);
		e.stopPropagation();
	},function(e){
		// Hides the title on blur
		$(this).next("div.alert-label").animate({"bottom": "-100px", "opacity":"hide"},200);
		e.stopPropagation();
	});

	/* Stock Alert (Header) - Tooltip - End */


	/* Main Nav - Highlight Active Menu Item - Start */

	// This function is copied straight from the default OpenCart theme
	function getURLVar(urlVarName) {
		var urlHalves = String(document.location).toLowerCase().split('?');
		var urlVarValue = '';

		if (urlHalves[1]) {
			var urlVars = urlHalves[1].split('&');

			for (var i = 0; i <= (urlVars.length); i++) {
				if (urlVars[i]) {
					var urlVarPair = urlVars[i].split('=');

					if (urlVarPair[0] && urlVarPair[0] == urlVarName.toLowerCase()) {
						urlVarValue = urlVarPair[1];
					}
				}
			}
		}
		return urlVarValue;
	} 

	route = getURLVar('route');
	
	// Get Current URL Route
	if (!route) {
		$('#dashboard').addClass('selected');
	} else {
		part = route.split('/');
		
		url = part[0];
		
		if (part[1]) {
			url += '/' + part[1];
		}
		
		$('a[href*=\'' + url + '\']').parents('li[id]').addClass('selected');

		// Add Class To Right Column Based On Active Menu
		$("#right-column").addClass(part[0]);
	}

	// Mobile Device Menu Control
	
	$("#menu-control").click(function(e){
		var leftMenuOpen = $("#left-column").is(":visible");

		if(leftMenuOpen){
			// Else, if opened, close it
			$("#left-column").animate({"left": "-110px", "opacity":"hide"},300, function(){
				$("#left-column").removeAttr("style");
				$(".menu-control-outer").removeClass("opened");
			});
		}else{
			// If menu closed, then slide open
			$("#left-column").animate({"left": "0", "opacity":"show"},300);
			$(".menu-control-outer").addClass("opened");
		}
		e.stopPropagation();
	});

	/* Main Nav - Highlight Active Menu Item - End */


	/* Main/Left Menu - Toggle Effects - Start */

	// First Level Menu
	// Clicked Menu Item
	$("ul.mainnav > li > a.top").click(function(e){
		var getOpenMenuOthers = $(this).parent().siblings().hasClass("menu-open"); // Get the class of other menu items
		var getOpenMenuThis = $(this).parent().hasClass("menu-open"); // Get the class of clicked menu item

		// If other menu items have the "menu-open" class. This means this menu is open. So...
		if(getOpenMenuOthers){
			// Close the menu
			$("ul.mainnav > li > ul").animate({"top": "50px", "opacity":"hide"},200, function(){
				// Remove the "menu-open" class
				$(this).parent().removeClass("menu-open");
				// Remove the styling that is adding by the animate. This resets the dropdown's position.
				$(this).removeAttr("style");
				$("ul.mainnav > li > ul ul").removeAttr("style");
			});
		}

		// If the clicked menu item has the "menu-open" class. This means this menu is open. So...
		if(getOpenMenuThis){
			// Close the menu
			$("ul.mainnav > li > ul").animate({"top": "50px", "opacity":"hide"},200, function(){
				// Remove the "menu-open" class
				$(this).parent().removeClass("menu-open");
				// Remove the styling that is adding by the animate. This resets the dropdown's position.
				$(this).removeAttr("style");
				$("ul.mainnav > li > ul ul").removeAttr("style");
			});
		}else{
			// If this menu item doesn't have the "menu-open" class, then open the menu
			$(this).next("ul").animate({"top": "0px", "opacity":"show"},200, function(){
				// Add "menu-open" class
				$(this).parent().addClass("menu-open");
			});
		}

		e.stopPropagation();
	});

	// Second, Third, etc... Level
	// Using Accordion Script
	// Clicked Menu Item
	$("ul.mainnav > li > ul").accordion({
		accordion:true,
		speed: 200,
		closedSign: '', // Leave blank because I use arrows set in CSS file
		openedSign: '' // Leave blank because I use arrows set in CSS file
	});

	// Bug Fix - Prevents Menu from closing when dropdown is clicked
	$("ul.mainnav > li > ul").click(function(e){
		e.stopPropagation();
	});

	/* Main/Left Menu - Toggle Effects - End */


	/* Close Open Menus If User CLicks Outside the Menu (Works on both Left and Secondary Menus) - Start */

	$('html').click(function() {
		// Hide the menus if visible
		$("ul.mainnav > li.menu-open > ul, .secondary-menu > ul ul").animate({"top": "50px", "opacity":"hide"},200, function(){
			$(this).removeAttr("style");
			$(this).parent().removeClass("menu-open");

			// Mobile Menu Close
			// var leftMenuOpen = $("#left-column").css("left");
			var leftMenuOpen = $(".menu-control-outer").hasClass("opened");

			if(leftMenuOpen){
				$("#left-column").animate({"left": "-110px", "opacity":"hide"},300, function(){
					$("#left-column").removeAttr("style");
					$(".menu-control-outer").removeClass("opened");
				});
			}
		});
	});

	/* Close Open Menus If User CLicks Outsite the Menu - End */


	/* Close Success/Warning Messages - Start */

	$(".success, .warning").live("click", function(){
		$(".success, .warning").remove();
	});

	/* Close Success/Warning Messages - End */


	/* Horizontal Scrolling For Tables For Small Screens - Start */
	var boxWidth = $(".box").width();
	var tableListWidth = $("table.list").width();
	var formTableWidth = $("form#form").height();

	if(tableListWidth > boxWidth){
		if(formTableWidth > 0){
			$("form#form").css("overflow", "auto");
		}else{
			$("table.list").parent().css("overflow", "auto");
		}
	}else{
		if(formTableWidth > 0){
			$("form#form").css("overflow", "auto");
		}else{
			$("table.list").parent().css("overflow", "auto");
		}
	}

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

				var boxWidth = $(".box").width();
				var tableListWidth = $("table.list").width();
				var formTableWidth = $("form#form").height();

				if(tableListWidth > boxWidth){
					if(formTableWidth > 0){
						$("form#form").css("overflow", "auto");
					}else{
						$("table.list").parent().css("overflow", "auto");
					}
				}else{
					if(formTableWidth > 0){
						$("form#form").css("overflow", "auto");
					}else{
						$("table.list").parent().css("overflow", "auto");
					}
				}

				// Close Menu On Mobile Device
				$("#left-column").removeAttr("style");
				$(".menu-control-outer").removeClass("opened");
			}

		}, 500, generateUniqueString());
	});
	/* Horizontal Scrolling For Tables For Small Screens - End */
	

	/* Tabs - Start */

	$('#tabs a').tabs();

	/* Tabs - End */


	/* Add Class To Save/Insert/Delete... etc - Start */

	var buttonExists = $(".buttons .button").height();

	if(buttonExists > 0){

		function getURLVars(urlVarName, getActionURL) {
			
			if(getActionURL == undefined){
				var getActionURL = '?';
			}
			var urlHalves = getActionURL.toLowerCase().split('?');
			var urlVarValue = '';

			if (urlHalves[1]) {
				var urlVars = urlHalves[1].split('&');

				for (var i = 0; i <= (urlVars.length); i++) {
					if (urlVars[i]) {
						var urlVarPair = urlVars[i].split('=');

						if (urlVarPair[0] && urlVarPair[0] == urlVarName.toLowerCase()) {
							urlVarValue = urlVarPair[1].split("/");
						}
					}
				}
			}

			return urlVarValue;
		}
		
		$(".buttons .button").each(function(){

			// first get the "href", then break it up to find the "key" term, like "insert", "delete", etc

			var getHrefFull = $(this).attr("href");

			var getAttrFull = $(this).attr("onclick");

			var getCancelButton = getURLVars("route",getHrefFull);

			if(getHrefFull != undefined){

				if(getHrefFull.indexOf("/insert&") > 0){

					$(this).addClass("btn btn-primary");

				}else if(getHrefFull.indexOf("/copy&") > 0){

					$(this).addClass("btn btn-primary");

				}else if((getCancelButton[0] && !getCancelButton[2]) || (getHrefFull.indexOf("/cancel&") > 0)){

					$(this).addClass("btn btn-danger");

				}else if(getHrefFull.indexOf("/delete&") > 0){

					$(this).addClass("btn btn-danger");

				}else if(getHrefFull.indexOf("/repair&") > 0){

					$(this).addClass("btn btn-primary");

				}

			}else{

				var getFormAction = $("#form").attr("action");
				var formAction = getURLVars("route",getFormAction);

				// Strip jargon from "onclick" data
				var toRemove = "location = '";
				var cleanAttr = getAttrFull.replace(toRemove,'');

				var toRemove = "';";
				var getAttr = cleanAttr.replace(toRemove,'');

				var getCancelButton = getURLVars("route",getHrefFull);

				// check if attr contains certain keywords
				if(getAttr.indexOf("/insert&") > 0){

					$(this).addClass("btn btn-primary");

				}else if(((getAttr.indexOf("('#form').submit()") > 0) && (formAction[2] == 'delete')) || ((getAttr.indexOf("('form').submit()") > 0) && (formAction[2] == 'delete'))){

					if(getAttr.indexOf("/copy&") > 0){
						$(this).addClass("btn btn-primary");
					}else{
						$(this).addClass("btn btn-danger");
					}

				}else if(((getAttr.indexOf("('#form').submit()") > 0) && (formAction[2] == 'insert')) || ((getAttr.indexOf("('#form').submit()") > 0) && (formAction[2] == 'update')) || ((getAttr.indexOf("('#form').submit()") > 0) && (formAction[2] == 'save')) || ((getAttr.indexOf("('#form').submit()") > 0) && (!formAction[2])) || (getAttr.indexOf("/approve&") > 0) ){

					if(getAttr.indexOf("/delete&") > 0){
						$(this).addClass("btn btn-danger");
					}else if(getAttr.indexOf("/invoice&") > 0){
						$(this).addClass("btn btn-primary");
					}else{
						$(this).addClass("btn btn-success");
					}

				}else if((getCancelButton[0] && !getCancelButton[2]) || (getAttr.indexOf("/cancel&") > 0)){
					$(this).addClass("btn btn-delete");
				}else if(getAttr.indexOf("/copy&") > 0){
					$(this).removeClass("btn-danger");
					$(this).addClass("btn-primary");

				}else if(getAttr.indexOf("/delete&") > 0){
					$(this).addClass("btn-danger");
				}else if(getAttr.indexOf("('#restore').submit()") > 0){
					$(this).addClass("btn-primary");
				}else if(getAttr.indexOf("('#backup').submit()") > 0){
					$(this).addClass("btn-primary");
				}
			}

		});
	}

	/* Add Class To Save/Insert/Delete... etc - End */

});