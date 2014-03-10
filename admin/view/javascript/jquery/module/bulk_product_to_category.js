var token = '';
var saving = false;
var select_message = '';

(function($){
	function select_none() {
		var cat_id = $('#category_id').val();
		if(!cat_id > 0) {
			alert(select_message);
			$('#category_id').focus();
			return false;
		}
		$('.prod_box:not(.prod_hide) .product_checkbox').attr('checked', false).parent().removeClass('prod_selected');
	}
	
	function select_all() {
		var cat_id = $('#category_id').val();
		if(!cat_id > 0) {
			alert(select_message);
			return false;
		}
		$('.prod_box:not(.prod_hide) .product_checkbox').attr('checked', true).parent().addClass('prod_selected');
	}
	
	function show_spinner() {
		$('#spinner').css('visibility', 'visible');
	}
	
	function hide_spinner() {
		$('#spinner').css('visibility', 'hidden');
	}
	
	function prod_click(id) {
		var cat_id = $('#category_id').val();
		if(!cat_id > 0) {
			alert(select_message);
			return false;
		}
		var chk = $('#'+id);
		if(chk.attr('checked')) {
			chk.attr('checked', false).parent().removeClass('prod_selected');
		}else{
			chk.attr('checked', true).parent().addClass('prod_selected');
		}
	}
	
	function filter() {
		$('.prod_hide').removeClass('prod_hide');
		
		if($('#filter_name').val().length > 0) {
			$('.prod_box').not('[data-name*="' + $('#filter_name').val().toLowerCase() + '"]').addClass('prod_hide');
		}
		
		if($('#filter_manufacturer').val() > 0) {
			$('.prod_box:not(.prod_hide)').not('[data-manufacturer="' + $('#filter_manufacturer').val() + '"]').addClass('prod_hide');
		}
		
		if($('#filter_category').val() > 0) {
			$('.prod_box:not(.prod_hide)').not('[data-categories*="|' + $('#filter_category').val() + '|"]').addClass('prod_hide');
		}
	}
	
	function clear_filter_name() {
		$('#filter_name').val('');
		filter();
	}
	
	$(function(){
		$('.product_checkbox').click(function(){
			var cat_id = $('#category_id').val();
			if(!cat_id > 0) {
				alert(select_message);
				return false;
			}
			prod_click($(this).attr('id'));
		});
	
		$('.prod_box').click(function(){
			prod_click($(this).attr('rel'));
		})
	
	 	$('#category_id').change(function(){
	 		var cat_id = $(this).val();
	 		if(!cat_id > 0) {
	 			return false;
	 		}else{
	 			show_spinner();
	 			$.getJSON(
					'index.php',
					{
						'route' : 'module/bulk_product_to_category/getProductsByCategory',
						'token' : token,
						'category_id' : cat_id
					},
					function(data) {
						if(!$('#sticky-cats').attr('checked')) {
							select_none();
						}
						
						// $('#sticky-cats').attr('checked', false);
						
						if(data.length) {
							$.each(data, function(idx, value){
								id = value.toString();
								$('div[rel="product_' + id + '"]').addClass('prod_selected');
								$('#product_' + id).attr('checked', true);
							});
						}
	 					hide_spinner();
					}
				);
	 		}
	 	});
	
	 	$('.save_selection').click(function(){
			if(saving) return false;
			var cat_id = $('#category_id').val();
			if(!cat_id > 0) return false;
			saving = true;
			
			$('.prod_box').each(function(){
				category = '|' + cat_id + '|';
				categories = $(this).attr('data-categories').replace(category, '');
				
				if($(this).hasClass('prod_selected')) {
					categories += category;
				}
				
				$(this).attr('data-categories', categories);
			});
			
			if($('#filter_category').val() > 0) {
				filter();
			}
	
			var products = new Array();
			$('.product_checkbox:checked').each(function(){
				products.push($(this).attr('rel'));
			});
	
			$.post(
				'index.php?route=module/bulk_product_to_category/SaveProductsToCategory&token=' + token + '&category_id=' + cat_id,
				{
					'products[]' : products
				},
				function(ret_data) {
					alert(ret_data);
				}
			);
	
			saving = false;
	 	});
	
	 	$('.select_all').click(function(){select_all();});
	
	 	$('.select_none').click(function(){select_none();});
	
	 	$('#show-pics').click(function(){
	 		if($(this).attr('checked')) {
	 			$('.prod_img').show();
	 		}else{
	 			$('.prod_img').hide();
	 		}
	 	});
	 	
	 	$('.filters').change(function(){
		 	filter();
	 	});
	 	
	 	$('.filters').keyup(function(){
		 	filter();
	 	});
	 	
	 	$('#clear_filter_name').click(function(){
	 		clear_filter_name();
	 	});
	 	
	 	$('#clear_filter').click(function(){
	 		$('.filters').val('');
	 		filter();
	 	});
	});
})(jQuery);