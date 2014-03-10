function doquick_search( ev, keywords ) {

	if( ev.keyCode == 38 || ev.keyCode == 40 ) {
		return false;
	}	

	$('#ajax_search_results').remove();
	updown = -1;

	if( keywords == '' || keywords.length < 1 ) {
		return false;
	}
	keywords = encodeURI(keywords);

	$.ajax({url: $('base').attr('href') + 'index.php?route=module/d_ajax_search/ajaxsearch&keyword=' + keywords, dataType: 'json', success: function(result) {
            console.log(result);
		if( result.length > 0 ) {
			var html, i;
			html = '<table id="ajax_search_results"><tbody id="ajax_search_results_body">';
			for(i=0;i<result.length;i++) {
				html += '<tr>';
				html += '<td><a href="' + result[i].href + '"><img src="' + result[i].thumb + '" /></a></td>';
				html += '<td><a href="' + result[i].href + '"><span class="name">' + result[i].name + '</span>';
				if(result[i].model.length > 0) html += ' (<span class="model">' + result[i].model + '</span>)';
				html += '</a></td>';
				
				if(result[i].special.length > 0){
					html += '<td><a href="' + result[i].href + '"><p class="old-price">' + result[i].price + '</p>';
					html += '<p class="special">' + result[i].special + '</p></a></td>';
				}else{
					if(result[i].price.length > 0){
					html += '<td><a href="' + result[i].href + '"><p class="price">' + result[i].price + '</p></a></td>';	
					}
				}
				html += '</tr>';
			}
			html += '</tbody></table>';
			
			if( $('#ajax_search_results').length > 0 ) {
				$('#ajax_search_results').remove();
			}
			
			$('#search').append(html);
		}
	}});
    
	return true;
}

function upDownEvent( ev ) {
	
	var elem = document.getElementById('ajax_search_results_body');
	var fkey = $('#search').find('[name=search]').first();
	
	if( elem ) {
		
		var length = elem.childNodes.length - 1;

		if( updown != -1 && typeof(elem.childNodes[updown]) != 'undefined' ) {
			$(elem.childNodes[updown]).removeClass('selected');
		}
       
		if( ev.keyCode == 38 ) {
			updown = ( updown > 0 ) ? --updown : updown;	
		}
		else if( ev.keyCode == 40 ) {
			updown = ( updown < length ) ? ++updown : updown;
		}
		
		if( updown >= 0 && updown <= length ) {
			
			$(elem.childNodes[updown]).addClass('selected');

			var text = $(elem.childNodes[updown]).find('.name').html();
			
			$('#search').find('[name=search]').first().val(text);
		}
	}

	return false;
}

var updown = -1;

$(document).ready(function(){
	$('[name=search],[name=filter_name], [name=search_oc]').keyup(function(ev){
		doquick_search(ev, this.value);
	}).focus(function(ev){
		doquick_search(ev, this.value);
	}).keydown(function(ev){
		upDownEvent( ev );
	}).blur(function(){
		window.setTimeout("$('#ajax_search_results').remove();updown=0;", 1500);
	});
	$(document).bind('keydown', function(ev) {
		try {
			if( ev.keyCode == 13 && $('.selected').length > 0 ) {
				if($('.selected').find('a').first().attr('href')){
					document.location.href = $('.selected').find('a').first().attr('href');
				}
			}
		}
		catch(e) {}
	});
});