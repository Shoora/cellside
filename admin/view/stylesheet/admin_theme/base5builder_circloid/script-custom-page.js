$(document).ready(function(){

	/*

	General JS

	*/

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


	/* Close Open Menus If User CLicks Outside the Menu (Works on both Left and Secondary Menus) - Start */

	$('html').click(function() {
		// Hide the menus if visible
		$("ul.mainnav > li.menu-open > ul, .secondary-menu > ul ul").animate({"top": "50px", "opacity":"hide"},200, function(){
			$(this).removeAttr("style");
			$(this).parent().removeClass("menu-open");

			// Mobile Menu Close
			var leftMenuOpen = $("#left-column").css("left");

			if(leftMenuOpen == "0px"){
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

});