var get_chain_content = function() 
	{
		$.get('index.php?route=module/chain/products&product_id='+product_id+'&token='+token, function(data) {
			$('#tab-chain').html(data); 
			if (chain_manager_ad && $('#combo-container').length > 0 && $.trim($('#combo-container').html())) {
				$.get('index.php?route=module/chain/chain_manager_ad&token='+ token, function(add_text) {
					if (add_text) {
						$('#tab-chain').append('<br><div class="chain_manager_ad">'+ add_text +'</div>');
					}
				});
			}

			combo_make_sort();
			combo_chain_make_sort();
		});
	
	}
	
var hide_chain_manager_ad = function() {
	$.get('index.php?route=module/chain/hide_chain_manager_ad&token='+token, function(data) {
		$('.chain_manager_ad').remove();
	});
}	

var isNumber = function(n) {
  return !isNaN(parseFloat(n)) && isFinite(n);
}

var combo_chain_make_sort = function() {
	var desc_tpl = '<a class="c-table-down" title="Move Down"><img src="view/image/desc.png" style="cursor:pointer"></a>';
	var asc_tpl = '<a class="c-table-up" title="Move Up"><img src="view/image/asc.png" style="cursor:pointer"></a>';
	
	$('.chain-group').each(function(index) {
		var ch_g_obj = $('#combo-container');
		ch_g_obj.find('.combo-chain-position').each(function(tb_index) {
			if ((tb_index == (ch_g_obj.children().length - 1)) && tb_index == 0) {
				$(this).html('');
			} else if (tb_index == 0) {
				$(this).html(desc_tpl);
			} else if (tb_index == ch_g_obj.children().length - 1) {
				$(this).html(asc_tpl);
			}  else {
				$(this).html(asc_tpl+' '+desc_tpl);
			}
		});
	});
	
	if ( jQuery.isFunction(jQuery.fn.on) ) 
		{
			$('#tab-chain').on('click', '.c-table-down', function() {
				var this_tb = $(this).parent().parent().parent().parent().parent().fadeOut('slow', function() {
					this_tb.clone().insertAfter(this_tb.next()).fadeIn('slow');
					this_tb.remove();
					combo_chain_make_sort();
					makeAllAutoComplite();
				});
			});
			
			$('#tab-chain').on('click', '.c-table-up', function() {
				var this_tb = $(this).parent().parent().parent().parent().parent().fadeOut('slow', function() {
					this_tb.clone().insertBefore(this_tb.prev()).fadeIn('slow');
					this_tb.remove();
					combo_chain_make_sort();
					makeAllAutoComplite();
				});
			});
		}
	else 
		{
			$('.c-table-down').live('click', function() {
				var this_tb = $(this).parent().parent().parent().parent().parent().fadeOut('slow', function() {
					this_tb.clone().insertAfter(this_tb.next()).fadeIn('slow');
					this_tb.remove();
					combo_chain_make_sort();
					makeAllAutoComplite();
				});
			});
			
			$('.c-table-up').live('click', function() {
				var this_tb = $(this).parent().parent().parent().parent().parent().fadeOut('slow', function() {
					this_tb.clone().insertBefore(this_tb.prev()).fadeIn('slow');
					this_tb.remove();
					combo_chain_make_sort();
					makeAllAutoComplite();
				});
			});
		}
	
};

var makeAllAutoComplite = function() {
	$('.chain-group').each(function() {
		var chain_id = $(this).attr('data-group_id');
		makeAutoComplite(chain_id);
	});
};

var combo_make_sort = function() {
	var desc_tpl = '<img src="view/image/desc.png" style="cursor:pointer" title="Move Down" class="c-tr-down">';
	var asc_tpl = '<img src="view/image/asc.png" style="cursor:pointer" title="Move Up" class="c-tr-up">';
	
	$('.chain-group').each(function(index) {
		var ch_g_obj = $(this);
		ch_g_obj.find('tbody .chain-product-action').each(function(tb_index) {
			if ((tb_index == (ch_g_obj.children().length - 4)) && tb_index == 0) {
				$(this).html('');
			} else if (tb_index == 0) {
				$(this).html(desc_tpl);
			} else if (tb_index == ch_g_obj.children().length - 4) {
				$(this).html(asc_tpl);
			}  else {
				$(this).html(asc_tpl+' '+desc_tpl);
			}
		});
	});
	
	if ( jQuery.isFunction(jQuery.fn.on) ) 
		{
			$('#tab-chain').on('click', '.c-tr-down', function() {
				var this_tb = $(this).parent().parent().parent().parent().fadeOut('slow', function() {
					this_tb.clone().insertAfter(this_tb.next()).fadeIn('slow');
					this_tb.remove();
					combo_make_sort();
				});
				
			});

			$('#tab-chain').on('click', '.c-tr-up', function() {
				var this_tb = $(this).parent().parent().parent().parent().fadeOut('slow', function() {
					this_tb.clone().insertBefore(this_tb.prev()).fadeIn('slow');
					this_tb.remove();
					combo_make_sort();
				});
			});
		} 
	else 
		{
			$('.c-tr-down').live('click', function() {
				var this_tb = $(this).parent().parent().parent().parent().fadeOut('slow', function() {
					this_tb.clone().insertAfter(this_tb.next()).fadeIn('slow');
					this_tb.remove();
					combo_make_sort();
				});
				
			});

			$('.c-tr-up').live('click', function() {
				var this_tb = $(this).parent().parent().parent().parent().fadeOut('slow', function() {
					this_tb.clone().insertBefore(this_tb.prev()).fadeIn('slow');
					this_tb.remove();
					combo_make_sort();
				});
			});
		}
}

var save_combo = function() {
	
	$('.chain_save_btn').before('<img id="chain_ajax_img_loader" src="view/image/loading.gif">&nbsp;&nbsp;');
	
	$('#chain_notify').html('');
	
	var my_chain_inputs = $('#tab-chain').clone();
	var my_chain_inputs_serialize = $('<form>').append(my_chain_inputs).serialize();
	
	$.ajax({
		type: 'post',
		url: 'index.php?route=module/chain/save&token=' + token, 
		data: my_chain_inputs_serialize,
		success: function(data) {
			$('#tab-chain').html('<div id="chain_notify">' + data + '</div>');
		},
		error: function(error) {
			alert( 'ERROR! Bad Ajax Respond!' );
			console.log( error );
		}
	});
}
var add_combo = function() {
	group_id = group_id + 1;
	make_chain_group_tpl(group_id);
	$('#combo-container').append(chain_group_tpl);
	makeAutoComplite(group_id);
	count_totals(group_id);
	combo_chain_make_sort();
}

if ( jQuery.isFunction(jQuery.fn.on) ) 
	{
		$('#tab-chain').on('click', '.combo-delete-row', function() {
			$(this).parent().parent().parent().remove();
		});

		$('#tab-chain').on('click', '.combo-delete', function() {
			var group_id_attr = $(this).attr('group_id');
			var $this_combo = $('#chain-group-'+group_id_attr);
			if ($this_combo.find('.exists').length > 0) {
				$('#combo-container').prepend('<input type="hidden" value="' + group_id_attr + '" name="chain_delete[]">');
			}
			$this_combo.remove();
		});
		$('#tab-chain').on('keyup', '.chain-combo-price input', function() {
			count_totals($(this).attr('data-grounp-id'));
		});
		
		$('#tab-chain').on('keyup', '.chain-quantity input', function() {
			if (!isNumber($(this).val()) || $(this).val() < 0) {
				$(this).val('1');
			} else if ($(this).val() != Math.round($(this).val())) {
				$(this).val(Math.round($(this).val()));
			}
			count_totals($(this).attr('data-grounp-id'));
		});
		
	}
else 
	{
		$('.combo-delete-row').live('click', function() {
			$(this).parent().parent().parent().remove();
		});

		$('.combo-delete').live('click', function() {
			var group_id_attr = $(this).attr('group_id');
			var $this_combo = $('#chain-group-'+group_id_attr);
			if ($this_combo.find('.exists').length > 0) {
				$('#combo-container').prepend('<input type="hidden" value="' + group_id_attr + '" name="chain_delete[]">');
			}
			$this_combo.remove();
		});
		$('.chain-combo-price input').live('keyup', function() {
			count_totals($(this).attr('data-grounp-id'));
		});
		$('.chain-quantity input').live('keyup', function() {
			if (!isNumber($(this).val()) || $(this).val() < 0) {
				$(this).val('1');
			} else if ($(this).val() != Math.round($(this).val())) {
				$(this).val(Math.round($(this).val()));
			}
			count_totals($(this).attr('data-grounp-id'));
		});
	}
var count_totals = function(group_id) {
	var chain_total_price = 0;
	var chain_real_total_price = 0;
	var quantity = 1;
	
	$('#chain-group-'+group_id).find('tbody .chain-price').each(function(index) {
		chain_real_total_price = parseFloat(chain_real_total_price) + parseFloat($(this).html());
	});
	
	$('#chain-group-'+group_id).find('tbody .chain-combo-price').each(function(index) {
		if ($(this).find('input').length > 0) {
			$(this).prev().find('input').val(Number($(this).prev().find('input').val()));
			quantity  = $(this).prev().find('input').val();
			var add_value = quantity * $(this).find('input').val();
		} else {
			$(this).prev().find('input').val(Number($(this).prev().find('input').val()));
			quantity  = $(this).prev().find('input').val();
			var add_value = quantity * $(this).html();
		}
		chain_total_price = parseFloat(chain_total_price) + parseFloat(add_value);
	});
	$('#chain-group-'+group_id+' .chain-total-price').html(chain_total_price);
	$('#chain-group-'+group_id+' .chain-real-total-price').html(chain_real_total_price);
}

if (autocomplite == 152) 
	{

		var source_autocomplite = function(request, response) 
			{
				$.ajax({
					url: 'index.php?route=catalog/product/autocomplete&token='+ token +'&filter_name=' +  encodeURIComponent(request.term),
					dataType: 'json',
					success: function(json) {
						response($.map(json, function(item) {
							return {
								label: item.name,
								product_id: item.product_id,
								price: item.price,
								option: item.option
							}
						}));
					}
				});
			}
	} 
else if (autocomplite == 151)
	{
		var source_autocomplite = function(request, response) 
			{
				$.ajax({
					url: 'index.php?route=catalog/product/autocomplete&token='+ token +'&filter_name=' +  encodeURIComponent(request.term),
					dataType: 'json',
					type: 'POST',
					data: 'filter_name=' +  encodeURIComponent(request.term),
					success: function(json) {
						response($.map(json, function(item) {
							return {
								label: item.name,
								product_id: item.product_id,
								price: item.price
							}
						}));
					}
				});
			}
	}
var makeAutoComplite = function(group_id_value) {

 $('#chain-'+group_id_value).autocomplete({
		delay: 500,
		source: source_autocomplite, 
		select: function(event, ui) {
			var template = 	'<tbody>'+
								'<tr>'+
									'<td class="chain-name">'+ ui.item.label +'</td>'+
									'<td class="chain-price text-align-center">'+ ui.item.price +'</td>'+
									'<td class="chain-quantity text-align-center"><input type="text" name="chain_quantity[' + group_id_value + '][' + ui.item.product_id + ']" value="1"></td>'+
									'<td class="chain-combo-price text-align-center"><input type="text" data-grounp-id="'+group_id_value+'" value="'+ ui.item.price +'" id="input-'+group_id_value+'-'+ui.item.product_id+'" name="product['+group_id_value+']['+ui.item.product_id+']"></td>'+
									'<td class="chain-action text-align-center"><span class="chain-product-action"></span> <img class="combo-delete-row" style="cursor: pointer;" src="view/image/delete.png" alt="" /></td>'+
								'</tr>'+
							'</tbody>';
							
			$('#chain-group-'+group_id_value+' tfoot').before(template);
			
			$('#chain-'+group_id_value).val('');
			
			$('#input-'+ group_id_value + '-' + ui.item.product_id).focus();
			
			count_totals(group_id_value);
			combo_make_sort();
			return false;
		},
		focus: function(event, ui) {
			return false;
		}
	});

}
$(document).ready(function() {
  get_chain_content();
});
