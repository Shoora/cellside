<?php 

/*

Readme English: http://shop.workshop200.com/en/blog?news_id=5

Note: This readme relates to the main branch of extension which is distributed under ionCube.
You are currently using Open Source version without access to any updates, but you can still 
find a lot of useful information in readme.

The developer is not responsible for any problems that arose after or as a consequence of the modification 
of the original source of extension. Everything supposed work fine just AS IT IS. 

Developer: workshop200@yandex.ru

Note: In a case you need to get free technical support you need to provide the following information:
1. When and where did you purchase the extension?
2. What account \ email was used?

*/

function index_value($array, $key, $zero = false) {

	if (!is_array($array) && !$zero) 
		{
			return false;
		}
		
	if (!is_array($array) && $zero) 
		{
			return 0;
		}
	
	if (!isset($array[$key]) && !$zero)
		{
			return false;
		}
		
	if (!isset($array[$key]) && $zero)
		{
			return 0;
		}
		
	if (isset($array[$key]) && ($array[$key] === false || $array[$key] === 0) && !$zero) 
		{
			return false;
		}
	
	if (isset($array[$key]) && ($array[$key] === false || $array[$key] === 0) && $zero) 
		{
			return 0;
		}
		
	return $array[$key];
		
}

	header('Content-Type: application/javascript'); 
	
	$p_id					= index_value($_GET, 'p_id');
	$chain_tab				= index_value($_GET, 'chain_tab');
	$tab_title				= urldecode(index_value($_GET, 'tab_title'));
	$redirect 				= urldecode(index_value($_GET, 'redirect'));
	$slider_autoscroll 		= index_value($_GET, 'slider_autoscroll');
	$slider_mousewheel 		= index_value($_GET, 'slider_mousewheel');
	$slider_nav 			= index_value($_GET, 'slider_nav');
	$ajax_loader 			= base64_decode(index_value($_GET, 'ajax_loader'));
	
	$exit = false; 
	
	if (!$position_type = index_value($_GET, 'position_type')) {
		$exit = true;
	}
	
	if (!$position_container = urldecode(index_value($_GET, 'position_container'))) {
		$exit = true;
	}
	
?>
<?php ob_start(); ?>
<?php if ($exit) { ?>
	console.log('Script execution is interrupted. Required input parameters are empty. Please, try to reinstall Chain Module.');
	<?php exit; ?>
<?php }	?>

if ($('html').attr('dir') == 'rtl') {
	var flex_direction_rtl = true;
} else {
	var flex_direction_rtl = false;
}

var show_in_tab = '<?php echo $chain_tab; ?>';
var p_id 		= '<?php echo $p_id; ?>';
var redirect = '<?php echo $redirect; ?>';
var carouselWidth = 0;
var ajax_loading = '<?php echo $ajax_loader; ?>';
if (ajax_loading.length > 1) {
	ajax_loading = '<div class="chain_preloading"><img src="catalog/view/theme/default/image/' + ajax_loading + '"></div>';
} else {
	ajax_loading = '';
}

var makeTabSlider = function() {
	carouselWidth = $('#tab-chain').width();
	if ( jQuery.isFunction(jQuery.fn.flexslider) ) {
		makeChainCarousel();
	} else {
		chainLoadScript('catalog/view/javascript/jquery/flexslider/jquery.flexslider-min.js', makeChainCarousel);
	}
}

$(document).ready(function() {

	<?php if ($p_id > 0) { ?>
			if (show_in_tab == 'on') {
				$('#tabs').append('<a href="#tab-chain" id="resize_flexslider" style="display: inline;"><?php echo $tab_title; ?></a>');
				$('#tabs').after('<div id="tab-chain" class="tab-content" style="display: block;"><div id="chain_container">'+ ajax_loading +'</div></div>');
				$('#tabs a').tabs();
				$('#resize_flexslider').click(function() {
					makeTabSlider();
				});
			} else {
				if ($('<?php echo $position_container; ?>').length > 0) {
					$('<?php echo $position_container; ?>').<?php echo $position_type; ?>('<div id="chain_container">'+ ajax_loading +'</div>');
					carouselWidth = $('#chain_container').width();
				} else {
					console.log('ERROR! Container for Chain Discount Moudle doesn`t exist! ');
				}
			}
			
			$.ajax({
				type: 'get',
				url: 'index.php?route=product/chain&p_id='+p_id,
				success: function(data) { 
					if (data.length == 0 && show_in_tab == 'on') {
						$('#resize_flexslider').remove();
						$('#tab-chai').remove();
					} else {
						$('#chain_container').hide().html(data); 
						
						if (show_in_tab != 'on') {
							if ( jQuery.isFunction(jQuery.fn.flexslider) ) {
								makeChainCarousel();
							} else {
								chainLoadScript('catalog/view/javascript/jquery/flexslider/jquery.flexslider-min.js', makeChainCarousel);
							}
						} else if (show_in_tab == 'on' && $('#resize_flexslider').hasClass('selected') && data.length > 0) {
							makeTabSlider();
						}
					}
				
				},
				error: function(error) { console.log(error); }
			});
	<?php } else { ?>
			carouselWidth = $('#chain_container').width();
			
			if ( jQuery.isFunction(jQuery.fn.flexslider) ) {
				makeChainCarousel();
			} else {
				chainLoadScript('catalog/view/javascript/jquery/flexslider/jquery.flexslider-min.js', makeChainCarousel);
			}
	<?php } ?>


});

var chainLoadScript = function(url, callback) {
	// adding the script tag to the head as suggested before
   var head = document.getElementsByTagName('head')[0];
   var script = document.createElement('script');
   script.type = 'text/javascript';
   script.src = url;

   if (callback) {
	   // then bind the event to the callback function 
	   // there are several events for cross browser compatibility
	   script.onreadystatechange = callback;
	   script.onload = callback;
   }

   // fire the loading
   head.appendChild(script);
};

var makeChainCarouselSuccess = function() {
	
	$("a.chain_option").colorbox({ 
		inline: true, 
		href: function () {
			var product_id = $(this).attr('data-id');
			var chain_id = $(this).attr('data-chain_id');
			var HTML_ID = "#chain" + chain_id + " #chain_options_list" + product_id;
			$(HTML_ID).show();
			return HTML_ID;
		},
		onCleanup: function() {
			$('.container_for_chan_options').hide();
		}
	}); 
	
	$('.chain-item').each(function(index) {
		var $item = $(this);
		checkItemOptions($item, false);
	});
	
	$('select,input,textarea').change(function() {
		var product_id = $(this).parents('.chain_options_list').attr('data-id');
		var chain_id = $(this).parents('.chain_options_list').attr('data-chain_id');
		var $item = $('#chain'+chain_id).find('#chain-item'+product_id);
		var $options = $(this).parents('.chain_options_list').find('.option.required_option');
		checkItemOptions($item, $options);
	});
	
	if ( jQuery.isFunction(jQuery.fn.tipsy) ) {
		makeChainTipsy();
	} else {
		chainLoadScript('catalog/view/javascript/jquery/jquery.tipsy.js', makeChainTipsy);
	}
	
};

var checkItemOptions = function($item, $options) { 
	if ($options || $item.find('.chain_options_list').length > 0) {
		if (!$options) {
			$options = $item.find('.chain_options_list').find('.option.required_option');
		}
		$options.each(function(index) {
			if ( !checkOption($(this), $item) ) {
				return false;
			}
		});
	}
};

var checkOption = function(obj, $item) {
	
	if (obj.find('input[type=\'radio\']').length > 0) 
		{
			if (obj.find('input[type=\'radio\']:checked').length > 0) {
				$item.removeClass('chain_required');
				return true;
			} else {
				$item.addClass('chain_required');
				return false;
			}
		}
	else if (obj.find('input[type=\'checkbox\']').length > 0) 
		{
			if (obj.find('input[type=\'checkbox\']:checked').length > 0) {
				$item.removeClass('chain_required');
				return true;
			} else {
				$item.addClass('chain_required');
				return false;
			}
		}
	else if (obj.find('select,input[type=\'text\'],input[type=\'hidden\'],textarea').length > 0) 
		{
			if (obj.find('select,input,textarea').val().length > 0) {
				$item.removeClass('chain_required');
				return true;
			} else {
				$item.addClass('chain_required');
				return false;
			}
		}
		
	return true;
};


var makeChainCarousel = function() {
	
	$('#chain_container').show(); // show
	
	$('.flexslider-chain').flexslider({
		animation: "slide",
		rtl: flex_direction_rtl,
		itemWidth: carouselWidth,
		controlNav: <?php echo ($slider_nav ? 'true' : 'false'); ?>,
		slideshow: <?php echo ($slider_autoscroll ? 'true' : 'false'); ?>,
		mousewheel: <?php echo ($slider_mousewheel ? 'true' : 'false'); ?>,
		animationLoop: true,
		randomize: false,
		start: makeChainCarouselSuccess
	});
};



var makeChainTipsy = function() {
	$('a.chain_option, .chain_product_quantity').tipsy({
		fade: true,
		gravity: 's'
	});
};

var addChainToCart = function(chain_id) {
	$('.chain-notification').fadeOut('hide', function() {
		$(this).remove();
	});
	showChainMask(chain_id, true);
	var allow_add_to_cart = true;
	var disallowed_items_list = '';
	$('#chain' + chain_id + ' .chain-item').each(function(index) {
		if ($(this).hasClass('chain_required')) {
			allow_add_to_cart = false;
			if (disallowed_items_list.length === 0) {
				disallowed_items_list += '<b>' + $(this).attr('item-name') + '</b>';
			} else {
				disallowed_items_list += ', <b>' + $(this).attr('item-name') + '</b>';
			}
		}
	});
	
	if (!allow_add_to_cart){ 
		$('#chain'+chain_id +' .warning').remove();
		hideChainMask(chain_id);
		$('#chain'+chain_id).prepend('<div class="chain-notification warning" style="display: none;">' + text_select_options.csprintf(disallowed_items_list) +'<img style="width: auto; height: auto;" src="catalog/view/theme/default/image/close.png" alt="" class="close" /></div>');
		$('#chain'+chain_id +' .warning').fadeIn('slow');
		setTimeout(function() { 
			$('#chain'+chain_id +' .warning').fadeOut('slow', function() {
				$(this).remove();
			}) 
		}, 5000);
		return false;
	}
	
	
	var request_url = 'index.php?route=product/chain/add_chain';
	var $this_chain_selector = '#chain'+chain_id;
	
	$.ajax({
		type: "post",
		url: request_url,
		data: $($this_chain_selector + ' input[type=\'text\'], ' + $this_chain_selector + ' input[type=\'hidden\'],' + $this_chain_selector + ' input[type=\'radio\']:checked,' + $this_chain_selector + ' input[type=\'checkbox\']:checked,'+ $this_chain_selector + ' select,'+ $this_chain_selector + ' textarea'),
		dataType: 'json',
		success: function(json) {
			if (json.error) 
				{
					$($this_chain_selector).prepend('<div class="chain-notification warning" style="display: none;">' + json.error +'<img style="width: auto; height: auto;"src="catalog/view/theme/default/image/close.png" alt="" class="close" /></div>');
					$('#chain'+chain_id +' .warning').fadeIn('slow');
					hideChainMask(chain_id);
				} 
			else if (json.pids) 
				{
					
					var items_list = '';
					var items_count = 0;
					$($this_chain_selector + ' .chain-item').each(function(index) {
							items_count++;
							if (items_list.length === 0) {
								items_list += '<b>' + $(this).attr('item-name') + '</b>';
							} else {
								items_list += ', <b>' + $(this).attr('item-name') + '</b>';
							}
					});
					
					if (redirect.length > 0) {
						location = redirect;
					} else {
						$('#cart').load('index.php?route=module/cart #cart > *');
						hideChainMask(chain_id);
						$($this_chain_selector).prepend('<div class="chain-notification success" style="display: none;">' + text_success.csprintf(items_list, chain_shoping_cart_href) +'<img style="width: auto; height: auto;" src="catalog/view/theme/default/image/close.png" alt="" class="close" /></div>');
						$($this_chain_selector +' .success').fadeIn('slow');
					}
					
					

						
				}
		}, 
		error: function(error) {
			console.log('error: addChainToCart() { $.ajax({ ... })};');
			console.log(error);
		}
	});
};

var showChainMask = function(chain_id, show_img) {
	$('.flex-prev,.flex-next').css('visibility', 'hidden');
	var width 		  = $('#chain'+chain_id).width();
	var height 		  = $('#chain'+chain_id).height();
	var img_margin_t  = (height / 2) - 50;
	var img_margin_l  = (width / 2) - 50;
	
	if (show_img) {
		var html = '<div class="mask-chain" style="height: '+height+'px; width: '+width+'px;" id="mask-chain-'+chain_id+'"><img style="margin-top:'+ img_margin_t +'px; margin-left: '+img_margin_l+'px; width: 100px; height: 100px;" src="catalog/view/theme/default/image/chain_loader.gif"></div>';
	} else {
		var html = '<div class="mask-chain" style="height: '+height+'px; width: '+width+'px;" id="mask-chain-'+chain_id+'"></div>';
	}
	$('.flexslider-chain').prepend(html);
	
};

var hideChainMask = function(chain_id) {
	$('#mask-chain-'+chain_id).fadeOut('slow', function() {
		$(this).remove();
		$('.flex-prev,.flex-next').css('visibility', 'visible');
	});
};

<?php
/**
 * @author Dmitry (dio) Levashov, dio@std42.ru
 */
?>

(function($) {

$.waterfall = function() {
	var steps   = [],
		dfrd    = $.Deferred(),
		pointer = 0;

	$.each(arguments, function(i, a) {
		steps.push(function() {
			var args = [].slice.apply(arguments), d;

			if (typeof(a) == 'function') {
				if (!((d = a.apply(null, args)) && d.promise)) {
					d = $.Deferred()[d === false ? 'reject' : 'resolve'](d);
				}
			} else if (a && a.promise) {
				d = a;
			} else {
				d = $.Deferred()[a === false ? 'reject' : 'resolve'](a);
			}

			d.fail(function() {
				dfrd.reject.apply(dfrd, [].slice.apply(arguments));
			})
			.done(function(data) {
				pointer++;
				args.push(data);

				pointer == steps.length
					? dfrd.resolve.apply(dfrd, args)
					: steps[pointer].apply(null, args);
			});
		});
	});

	steps.length ? steps[0]() : dfrd.resolve();

	return dfrd;
}

})(jQuery);

if (!String.prototype.csprintf) {
  String.prototype.csprintf = function() {
    var args = arguments;
    return this.replace(/{(\d+)}/g, function(match, number) { 
      return typeof args[number] != 'undefined'
        ? args[number]
        : match
      ;
    });
  };
};
<?php 
	$js = ob_get_clean(); 
	echo $js;
?>