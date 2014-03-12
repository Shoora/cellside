$(document).ready(function(){

	/*

	Logged Out JS

	*/

	/* Add Class to Forgotten Page - Start */

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
	
	part = route.split('/');
	
	url = part[0];
	
	if (part[1]) {
		url += '/' + part[1];
	}

	// Add Class To Right Column Based On Active Menu
	$("body").addClass(part[1]);
	$("body").addClass("login");
	

	/* Main Nav - Highlight Active Menu Item - End */


	/* Close Success/Warning Messages - Start */

	$(".success, .warning").live("click", function(){
		$(".success, .warning").remove();
	});

	/* Close Success/Warning Messages - End */

});