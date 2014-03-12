$(document).ready(function() {

	setTimeout(unlockMagic, 1000);
	$(window).on('resize', function() {
		unlockMagic();
	});
	classChange('sm', '.ulTopButtons', 'dropdown-menu');
	topExchange('xs');

	$('.rel-item').eqHeights({child:'.rel-prod'});

	//menu fixed
	$(document).scroll(function(){
		if($(this).scrollTop() >= 38) {
			$('#pav-mainnav').addClass('fixed_menu');
			$('#search_f').addClass('scrolled');
		} else {
			$('#pav-mainnav').removeClass('fixed_menu');
			$('#search_f').removeClass('scrolled');
		}	
	});

	var old_pr = $('.widget-product').find('.price-old');
	var new_pr = $('.widget-product').find('.price-new');
	old_pr.before(new_pr);
	new_pr.addClass('featured-btt').on('click', function() {
		$(this).parent().parent().find('.cart input').click();
	});
		
	$(".navigateButtons").find('a').click(function(e) {
		e.preventDefault();
		var href = $(this).attr('href');
		scrollToElement($(href), 30);
	});
});


function classChange(width, selector, className) {
	width = eqWidthName(width);
	var tempWidth;
	$(window).ready(function() {
		tempWidth = $(this).width() +15;
		if(tempWidth <= width) { $(selector).addClass(className); }
		else { $(selector).removeClass(className); }
	}).resize(function() {
		tempWidth = $(this).width()+15;
		if(tempWidth <= width) { $(selector).addClass(className); }
		else { $(selector).removeClass(className); }
	});
}

function topExchange(width) {
	width = eqWidthName(width);
	var tempWidth;
	$(window).ready(function() {
		tempWidth = $(this).width();
		if(tempWidth <= width) {
			var topCall = $('.top-call').parent();
			$('.currency').parent().before(topCall);
			topCall.append(topCall.find('.top-time'));
		}
		else {
			var topCall = $('.top-call').parent();
			$('.currency').parent().after(topCall);
			topCall.find('.top-call').append(topCall.find('.top-time'));
		}
	}).resize(function() {
		tempWidth = $(this).width();
		// console.log(tempWidth+' - ' + width);
		if(tempWidth <= width) {
			var topCall = $('.top-call').parent();
			$('.currency').parent().before(topCall);
			topCall.append(topCall.find('.top-time'));
		}
		else {
			var topCall = $('.top-call').parent();
			$('.currency').parent().after(topCall);
			topCall.find('.top-call').append(topCall.find('.top-time'));
		}
	});
}

function eqWidthName(width) {
	switch(width) {
		case 'xs' : return 768; break;
		case 'sm' : return 991; break;
		case 'md' : return 1200; break;
		case 'lg' : return 1980; break;
	}
}

function toggleCart(div) {
	var ch = $(div).parent().find('.content');
	ch.is(":visible") ? ch.hide() : ch.show();
}

function unlockMagic() {
	$('#unlock').css("height", $('#unlock>img').height()+"px");
	var margin_top = ($('#unlock>img').height()/2 - $('#row').height()) > 0 ? $('#unlock>img').height()/2 - $('#row').height() : 0;
	$('#row').css('margin-top', margin_top +"px")
}

function scrollToElement(el, dv) {
	$('html, body').animate({
		scrollTop: el.offset().top - $('#page').height() - dv
	}, 2000);
}

function findClosestPrev(element, id) {
	var s = $(id).find('.bx-prev').trigger('click');
}

function findClosestNext(element, id) {
	var s = $(id).find('.bx-next').trigger('click');
}

function footerToggle(element) {
	var cont = $(element).next();
	if ($(window).width() <= 991) {
		if (cont.is(':visible')) {
			cont.stop().slideUp(200);
		} else {
			cont.stop().slideDown(200);
		}
	}
}

function sResize() {
	$('#search-inner').each(function() {
	   var eHeight = $(this).innerHeight();

	   $(this).find('.no-padding').outerHeight(eHeight);
	});
}

function quantity(this_el, type, callback) {
	var input = $(this_el).parent().find('input[name^="quantity"]');
	if (type == "up") {
		input.val(parseInt(input.val()) + 1);
	};
	if (type == "down") {
		if(parseInt(input.val()) > 1) {
			input.val(parseInt(input.val()) - 1);
		}
	};

	if (typeof callback != "undefined") { callback(input); };
}

function updateTotal(el) {
	var price = $(el.closest('tr')[0]).find('.price').find('.current').html().trim();
	var char_ = price.slice(0, 1);
	var total = $(el.closest('tr')[0]).find('.total');
	var count = el.val();

	total.html(char_ + (price.slice(1) * count).toFixed(2));
}

function addAllToolsToCart() {
	$('.product-tool').each(function() {
		addToCart($(this).attr('data-id'));
	});
}

function addChekedToCart(selector) {
	$(selector).find('.checkbox').find('input').each(function() {
		if ($(this).is(':checked')) {
			console.log($(this).attr('data-id'));
			addToCart($(this).attr('data-id'));
		};
	});
}

function removeSelectedCart() {
	var ids = "";
	$('.table .remove').find('.removeFromCart').each(function() {
		if($(this).is(':checked'))
		ids += $(this).attr('data-remove') + '::_';
	});
	ids = ids.substring(0, ids.length - 1);
	window.location = '/index.php?route=checkout/cart&remove=' + ids;
}

$.fn.eqHeights = function(options) {

    var defaults = {  
        child: false 
    };  
    var options = $.extend(defaults, options); 

    var el = $(this);
    if (el.length > 0 && !el.data('eqHeights')) {
        $(window).bind('resize.eqHeights', function() {
            el.eqHeights(options);
        });
        el.data('eqHeights', true);
    }

    if( options.child && options.child.length > 0 ){
        var elmtns = $(options.child, this);
    } else {
        var elmtns = $(this).children();
    }

    var prevTop = 0;
    var max_height = 0;
    var elements = [];

    var paddT , bordT;
    elmtns.height('auto').each(function() {

        paddT = $(this).innerWidth() - $(this).width();
        bordT = $(this).outerWidth() - $(this).innerWidth();
       
        max_height = Math.max(max_height, $(this).height());

        elements.push(this);
    });
    max_height = max_height < 85 ? 85 : max_height; //just now
    $(elements).height(max_height+paddT+bordT);
};