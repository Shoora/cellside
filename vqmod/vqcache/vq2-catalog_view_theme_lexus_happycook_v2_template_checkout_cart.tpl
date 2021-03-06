<?php require( DIR_TEMPLATE.$this->config->get('config_template')."/template/common/config.tpl" ); ?>
<?php echo $header; ?>
<?php //require( DIR_TEMPLATE.$this->config->get('config_template')."/template/common/breadcrumb.tpl" );  ?>  

<div id="group-content">
<?php if( $SPAN[0] ): ?>
<aside class="col-lg-<?php echo $SPAN[0];?> col-md-<?php echo $SPAN[0];?> col-sm-12 col-xs-12">
	<?php echo $column_left; ?>
</aside>
<?php endif; ?> 

<section class="col-lg-<?php echo $SPAN[1];?> col-md-<?php echo $SPAN[1];?> col-sm-12 col-xs-12">
	<?php if ($attention) { ?>
<div class="attention"><?php echo $attention; ?><img src="catalog/view/theme/default/image/close.png" alt="" class="close" /></div>
<?php } ?>
<?php if ($success) { ?>
<div class="success"><?php echo $success; ?><img src="catalog/view/theme/default/image/close.png" alt="" class="close" /></div>
<?php } ?>
<?php if ($error_warning) { ?>
<div class="warning"><?php echo $error_warning; ?><img src="catalog/view/theme/default/image/close.png" alt="" class="close" /></div>
<?php } ?>
 
<div id="content">

<?php echo $content_top; ?>
	<div class="checkout">

	<link rel="stylesheet" type="text/css" href="catalog/view/theme/lexus_happycook_v2/stylesheet/style.css">
	<link rel="stylesheet" type="text/css" href="catalog/view/theme/lexus_happycook_v2/stylesheet/checkbox_login.css">
	<link href='http://fonts.googleapis.com/css?family=Titillium+Web' rel='stylesheet' type='text/css'>
	
	<div class="shopping">
	
	<div class="container">
	<div class="row">
		<div class="col-sm-15">
		<header class="shopping_cart">shopping cart
			<?php //if ($weight) {  echo ' ('.$weight.')'; } 
				$i = 1;
			?>
		</header>
		 
		<div class="table-responsive">
		 
	<form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data">

			<table class="table container">
			<tr><th colspan="3">Item</th> <th>Price</th> <th>Quantity</th> <th>Total</th> <th>Remove</th></tr>
			 <?php foreach ($products as $product) { ?>


			<tr>
				<td class="num col-lg-1 col-md-1 col-sm-1"><?php echo $i++; ?></td>
				<td class="photo col-lg-1 col-md-1 col-sm-3 text-center">
					<?php if ($product['thumb']) { ?>
					<a href="<?php echo $product['href']; ?>"><img src="<?php echo $product['thumb']; ?>" alt="<?php echo $product['name']; ?>" title="<?php echo $product['name']; ?>" /></a>
					<?php } ?>
				</td>
				<td class="desc col-lg-3 col-md-3 col-sm-3">  <a href="<?php echo $product['href']; ?>"><?php echo $product['name']; ?></a><br />
					<?php if ($product['reward']) { ?>
					<small><?php echo $product['reward']; ?></small>
					<?php } ?>
					<?php if (!$product['stock']) { ?>
					<span class="stock">***</span>
					<?php } ?>
					<div>
					<?php foreach ($product['option'] as $option) { ?>
					- <small><?php echo $option['name']; ?>: <?php echo $option['value']; ?></small><br />
					<?php } ?>

					<?php if($product['recurring']): ?>
					- <small><?php echo $text_payment_profile ?>: <?php echo $product['profile_name'] ?></small>
					<?php endif; ?>

					<?php if ($product['rating']) { ?>
					<div class="rating"><img src="catalog/view/theme/<?php echo $this->config->get('config_template');?>/image/stars-<?php echo $product['rating']; ?>.png" alt="<?php echo $product['reviews']; ?>" />
					</div>
					<?php } else { ?>
					<div class="norating"><img src="catalog/view/theme/<?php echo $this->config->get('config_template');?>/image/stars-0.png"></div>
					<?php } ?>
				</td>
				<td class="price col-lg-2 col-md-2 col-sm-2">
					<span class="current"><?php echo $product['price']; ?></span>
					<?php if ($product['old_price']) : ?>
						<div class="cart_price"><span class="old"><?php echo $product['old_price']; ?></span><span class="dv"><?php echo $text_save ." " . $product['dv']; ?></span></div>
					<?php endif; ?>
				</td> 
				<td class="quantity col-lg-2 col-md-2 col-sm-3"> 
					<div class="q_block">
						<div class="q_block_inner">
							<span class="qChange no-select" onClick="quantity(this,'down', updateTotal)">-</span>
							<input type="text" readonly class="cart_quantity" name="quantity[<?php echo $product['key']; ?>]" value="<?php echo $product['quantity']; ?>" size="1" />
							<span class="qChange no-select" onClick="quantity(this,'up', updateTotal)">+</span>
							<div class="clearfix"></div>
						</div>
					</div>
					
					&nbsp;
					<input type="image" src="catalog/view/theme/default/image/update.png" alt="<?php echo $button_update; ?>" title="<?php echo $button_update; ?>" class="update_total_cart"/>
				</td> 
				<td class="total col-lg-2 col-md-2"><?php echo $product['total']; ?></td> 
				<td class="remove col-lg-1 col-md-1 col-sm-1"> 
					<input type="checkbox" class="removeFromCart" data-remove="<?php echo $product['product_id']; ?>">
				<!-- &nbsp;<a href="<?php echo $product['remove']; ?>"><img src="catalog/view/theme/default/image/remove.png" alt="<?php echo $button_remove; ?>" title="<?php echo $button_remove; ?>" /></a>  -->  

				</td> 
			</tr>
			<?php  } ?>
			
			</table>

			<div class="red_button no-select pull-right" id="rSelected" onClick="removeSelectedCart();">Remove selected</div>
			
		</div>
		</div>
	</div>
	<div class="row">
		<div class="fees">
			<div class="calculate col-xs-12 col-sm-12 col-md-6 col-lg-6 no-padding">
			
				<?php if ($coupon_status || $voucher_status || $reward_status || $shipping_status) { ?>
				<h2><?php echo $text_next; ?></h2>
				<div class="content">
					<p><?php echo $text_next_choice; ?></p>
					<table class="radio">
						<?php if ($coupon_status) { ?>
						<tr class="highlight">
						<td><?php if ($next == 'coupon') { ?>
							<input type="radio" name="next" value="coupon" id="use_coupon" checked="checked" />
							<?php } else { ?>
							<input type="radio" name="next" value="coupon" id="use_coupon" />
							<?php } ?></td>
						<td><label for="use_coupon"><?php echo $text_use_coupon; ?></label></td>
						</tr>
						<?php } ?>
						<?php if ($voucher_status) { ?>
						<tr class="highlight">
						<td><?php if ($next == 'voucher') { ?>
							<input type="radio" name="next" value="voucher" id="use_voucher" checked="checked" />
							<?php } else { ?>
							<input type="radio" name="next" value="voucher" id="use_voucher" />
							<?php } ?></td>
						<td><label for="use_voucher"><?php echo $text_use_voucher; ?></label></td>
						</tr>
						<?php } ?>
						<?php if ($reward_status) { ?>
						<tr class="highlight">
						<td><?php if ($next == 'reward') { ?>
							<input type="radio" name="next" value="reward" id="use_reward" checked="checked" />
							<?php } else { ?>
							<input type="radio" name="next" value="reward" id="use_reward" />
							<?php } ?></td>
						<td><label for="use_reward"><?php echo $text_use_reward; ?></label></td>
						</tr>
						<?php } ?>
						<?php if ($shipping_status) { ?>
						<tr class="highlight">
						<td><?php if ($next == 'shipping') { ?>
							<input type="radio" name="next" value="shipping" id="shipping_estimate" checked="checked" />
							<?php } else { ?>
							<input type="radio" name="next" value="shipping" id="shipping_estimate" />
							<?php } ?></td>
						<td><label for="shipping_estimate"><?php echo $text_shipping_estimate; ?></label></td>
						</tr>
						<?php } ?>
					</table>
				</div>
				<div class="cart-module">
					<div id="coupon" class="content" style="display: <?php echo ($next == 'coupon' ? 'block' : 'none'); ?>;">
						<form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data">
						<?php echo $entry_coupon; ?>&nbsp;
						<input type="text" name="coupon" value="<?php echo $coupon; ?>" />
						<input type="hidden" name="next" value="coupon" />
						&nbsp;
						<input type="submit" value="<?php echo $button_coupon; ?>" class="button" />
						</form>
					</div>
					<div id="voucher" class="content" style="display: <?php echo ($next == 'voucher' ? 'block' : 'none'); ?>;">
						<form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data">
						<?php echo $entry_voucher; ?>&nbsp;
						<input type="text" name="voucher" value="<?php echo $voucher; ?>" />
						<input type="hidden" name="next" value="voucher" />
						&nbsp;
						<input type="submit" value="<?php echo $button_voucher; ?>" class="button" />
						</form>
					</div>
					<div id="reward" class="content" style="display: <?php echo ($next == 'reward' ? 'block' : 'none'); ?>;">
						<form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data">
						<?php echo $entry_reward; ?>&nbsp;
						<input type="text" name="reward" value="<?php echo $reward; ?>" />
						<input type="hidden" name="next" value="reward" />
						&nbsp;
						<input type="submit" value="<?php echo $button_reward; ?>" class="button" />
						</form>
					</div>
					<div id="shipping" class="content" style="display: <?php echo ($next == 'shipping' ? 'block' : 'none'); ?>;">
						<p><?php echo $text_shipping_detail; ?></p>
						<table>
						<tr>
							<td><span class="required">*</span> <?php echo $entry_country; ?></td>
							<td><select name="country_id">
								<option value=""><?php echo $text_select; ?></option>
								<?php foreach ($countries as $country) { ?>
								<?php if ($country['country_id'] == $country_id) { ?>
								<option value="<?php echo $country['country_id']; ?>" selected="selected"><?php echo $country['name']; ?></option>
								<?php } else { ?>
								<option value="<?php echo $country['country_id']; ?>"><?php echo $country['name']; ?></option>
								<?php } ?>
								<?php } ?>
							</select></td>
						</tr>
						<tr>
							<td><span class="required">*</span> <?php echo $entry_zone; ?></td>
							<td><select name="zone_id">
							</select></td>
						</tr>
						<tr>
							<td><span id="postcode-required" class="required">*</span> <?php echo $entry_postcode; ?></td>
							<td><input type="text" name="postcode" value="<?php echo $postcode; ?>" /></td>
						</tr>
						</table>
						<input type="button" value="<?php echo $button_quote; ?>" id="button-quote" class="button" />
					</div>
				</div>
	<?php } ?>        
			
		 </div>
		
		 
		<div class="totals col-xs-12 col-sm-12 col-md-6 col-lg-6 no-padding"> 
			<header>Cart Totals</header>
			<div class="wraper">
				<div class="top-total">
					<?php foreach ($totals as $total) : ?>
						<div class="row">
							<div class="col-sm-6 subtotal"><?php echo $total['title']; ?>:</div>
							<div class="col-sm-6 text-right price"><?php echo $total['text']; ?></div>
						</div>
					<?php endforeach; ?>
				</div>
				<div class="bottom-total">
					<div class="buttonsCart text-right"> 
						<!-- <a href="<?php echo $continue; ?>"><div class=" medium medium_red">Continue Shopping</div></a> -->
						<div id="update_total" class="red_button" onClick="$('.update_total_cart').click();">Update Total</div>
						<a href="<?php echo $checkout; ?>"><div class="green_button">Checkout</div></a>
					</div>
				</div>
			</div>
		</div>
		<div class="clearfix"></div>
		</div>
	</div>
	</div>
</div>



	</form>
	
	
	
	<?php echo $content_bottom; ?>
	</div>
	</div>
<script type="text/javascript"><!--
$('input[name=\'next\']').bind('change', function() {
	$('.cart-module > div').hide();
	
	$('#' + this.value).show();
});
jQuery(document).ready(function(){
            <?php if (isset($this->session->data['popup'])) { ?>
            <?php unset($this->session->data['popup']); ?>
				if (jQuery().colorbox) {
					// Reload parent page when colorbox closes to update any changes
					$(document).bind('cbox_closed', function(){
   						//parent.location.reload();
					});

					jQuery.fn.colorbox({
						open:true,
						href:"index.php?route=checkout/checkout_one",
						iframe:true,
						width:"90%",
						height:"90%",
						overlayClose:false,
						scrolling:true,
					});
					//parent.$.fn.colorbox.resize({
						//innerWidth: $(document).width() - 200,
						//innerHeight: $(document).height() - 200
					//});
				}
				if (jQuery().fancybox) {
					$('body').append('<a id="hidden_link"></a>');
					$("#hidden_link").fancybox({
						href:"index.php?route=checkout/checkout_one",
						type:'iframe',
						width:"90%",
						height:"90%",
					}).trigger('click');
				}
			<?php } ?>
			});
//--></script>
<?php if ($shipping_status) { ?>
<script type="text/javascript"><!--
$('#button-quote').live('click', function() {
	$.ajax({
		url: 'index.php?route=checkout/cart/quote',
		type: 'post',
		data: 'country_id=' + $('select[name=\'country_id\']').val() + '&zone_id=' + $('select[name=\'zone_id\']').val() + '&postcode=' + encodeURIComponent($('input[name=\'postcode\']').val()),
		dataType: 'json',		
		beforeSend: function() {
			$('#button-quote').attr('disabled', true);
			$('#button-quote').after('<span class="wait">&nbsp;<img src="catalog/view/theme/default/image/loading.gif" alt="" /></span>');
		},
		complete: function() {
			$('#button-quote').attr('disabled', false);
			$('.wait').remove();
		},		
		success: function(json) {
			$('.success, .warning, .attention, .error').remove();			
						
			if (json['error']) {
				if (json['error']['warning']) {
					$('#notification').html('<div class="warning" style="display: none;">' + json['error']['warning'] + '<img src="catalog/view/theme/default/image/close.png" alt="" class="close" /></div>');
					
					$('.warning').fadeIn('slow');
					
					$('html, body').animate({ scrollTop: 0 }, 'slow'); 
				}	
							
				if (json['error']['country']) {
					$('select[name=\'country_id\']').after('<span class="error">' + json['error']['country'] + '</span>');
				}	
				
				if (json['error']['zone']) {
					$('select[name=\'zone_id\']').after('<span class="error">' + json['error']['zone'] + '</span>');
				}
				
				if (json['error']['postcode']) {
					$('input[name=\'postcode\']').after('<span class="error">' + json['error']['postcode'] + '</span>');
				}					
			}
			
			if (json['shipping_method']) {
				html  = '<h2><?php echo $text_shipping_method; ?></h2>';
				html += '<form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data">';
				html += '  <table class="radio">';
				
				for (i in json['shipping_method']) {
					html += '<tr>';
					html += '  <td colspan="3"><b>' + json['shipping_method'][i]['title'] + '</b></td>';
					html += '</tr>';
				
					if (!json['shipping_method'][i]['error']) {
						for (j in json['shipping_method'][i]['quote']) {
							html += '<tr class="highlight">';
							
							if (json['shipping_method'][i]['quote'][j]['code'] == '<?php echo $shipping_method; ?>') {
								html += '<td><input type="radio" name="shipping_method" value="' + json['shipping_method'][i]['quote'][j]['code'] + '" id="' + json['shipping_method'][i]['quote'][j]['code'] + '" checked="checked" /></td>';
							} else {
								html += '<td><input type="radio" name="shipping_method" value="' + json['shipping_method'][i]['quote'][j]['code'] + '" id="' + json['shipping_method'][i]['quote'][j]['code'] + '" /></td>';
							}
								
							html += '  <td><label for="' + json['shipping_method'][i]['quote'][j]['code'] + '">' + json['shipping_method'][i]['quote'][j]['title'] + '</label></td>';
							html += '  <td style="text-align: right;"><label for="' + json['shipping_method'][i]['quote'][j]['code'] + '">' + json['shipping_method'][i]['quote'][j]['text'] + '</label></td>';
							html += '</tr>';
						}		
					} else {
						html += '<tr>';
						html += '  <td colspan="3"><div class="error">' + json['shipping_method'][i]['error'] + '</div></td>';
						html += '</tr>';						
					}
				}
				
				html += '  </table>';
				html += '  <br />';
				html += '  <input type="hidden" name="next" value="shipping" />';
				
				<?php if ($shipping_method) { ?>
				html += '  <input type="submit" value="<?php echo $button_shipping; ?>" id="button-shipping" class="button" />';	
				<?php } else { ?>
				html += '  <input type="submit" value="<?php echo $button_shipping; ?>" id="button-shipping" class="button" disabled="disabled" />';	
				<?php } ?>
							
				html += '</form>';
				
				$.colorbox({
					overlayClose: true,
					opacity: 0.5,
					width: '600px',
					height: '400px',
					href: false,
					html: html
				});
				
				$('input[name=\'shipping_method\']').bind('change', function() {
					$('#button-shipping').attr('disabled', false);
				});
			}
		}
	});
});
//--></script> 
<script type="text/javascript"><!--
$('select[name=\'country_id\']').bind('change', function() {
	$.ajax({
		url: 'index.php?route=checkout/cart/country&country_id=' + this.value,
		dataType: 'json',
		beforeSend: function() {
			$('select[name=\'country_id\']').after('<span class="wait">&nbsp;<img src="catalog/view/theme/default/image/loading.gif" alt="" /></span>');
		},
		complete: function() {
			$('.wait').remove();
		},			
		success: function(json) {
			if (json['postcode_required'] == '1') {
				$('#postcode-required').show();
			} else {
				$('#postcode-required').hide();
			}
			
			html = '<option value=""><?php echo $text_select; ?></option>';
			
			if (json['zone'] != '') {
				for (i = 0; i < json['zone'].length; i++) {
					html += '<option value="' + json['zone'][i]['zone_id'] + '"';
					
					if (json['zone'][i]['zone_id'] == '<?php echo $zone_id; ?>') {
						html += ' selected="selected"';
					}
	
					html += '>' + json['zone'][i]['name'] + '</option>';
				}
			} else {
				html += '<option value="0" selected="selected"><?php echo $text_none; ?></option>';
			}
			
			$('select[name=\'zone_id\']').html(html);
		},
		error: function(xhr, ajaxOptions, thrownError) {
			alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
		}
	});
});

$('select[name=\'country_id\']').trigger('change');
//--></script>
<?php } ?>
</section> 
<?php if( $SPAN[2] ): ?>
<aside class="col-lg-<?php echo $SPAN[2];?> col-md-<?php echo $SPAN[2];?> col-sm-12 col-xs-12">	
	<?php echo $column_right; ?>
</aside>
<?php endif; ?>
</div>
<?php echo $footer; ?>
<script>
	$('#offcanvas-container').addClass('bubble_bg');
</script>