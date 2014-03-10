<?php
//==============================================================================
// Restrict Shipping Methods v155.1
// 
// Author: Clear Thinking, LLC
// E-mail: johnathan@getclearthinking.com
// Website: http://www.getclearthinking.com
//==============================================================================
?>

<?php echo $header; ?>
<style type="text/css">
	div {
		white-space: nowrap;
	}
	.help, .tooltip, .scrollbox div, #examples div {
		white-space: normal;
	}
	td {
		background: #FFF;
	}
	thead td {
		height: 24px;
	}
	.scrollbox {
		height: 270px;
		margin: auto;
		min-width: 130px;
		text-align: left;
		width: 95%;
	}
	.alternating label:nth-child(even) div {
		background: #E4EEF7;
	}
	.selectall-links {
		font-size: 11px;
		padding: 0 0 8px !important;
		text-align: center;
	}
	.order-criteria-title {
		background: #E4EEF7;
		font-weight: bold;
		text-align: center;
	}
	.sub-table td {
		border: none;
		padding: 0 !important;
	}
	.bluebox {
		background: #E4EEF7;
		border: 1px solid #BCD;
		font-size: 11px;
		margin-bottom: 5px;
		padding: 2px 4px;
		text-align: center;
	}
	.tooltip-mark {
		background: #FF8;
		border: 1px solid #888;
		border-radius: 10px;
		color: #000;
		font-size: 10px;
		padding: 1px 4px;
	}
	.tooltip {
		background: #FFC;
		border: 1px solid #CCC;
		color: #000;
		display: none;
		font-size: 11px;
		font-weight: normal;
		line-height: 1.3;
		max-width: 350px;
		padding: 10px;
		position: absolute;
		text-align: left;
		z-index: 100;
	}
	.tooltip-mark:hover, .tooltip-mark:hover + .tooltip, .tooltip:hover {
		display: inline;
		cursor: help;
	}
	.tooltip, .ui-dialog {
		box-shadow: 0 6px 9px #AAA;
		-moz-box-shadow: 0 6px 9px #AAA;
		-webkit-box-shadow: 0 6px 9px #AAA;
	}
	#examples, #product-dialog {
		display: none;
	}
	#examples h2 {
		background: #DDD;
		border: 1px dashed #888;
		display: inline-block;
		margin: 10px;
		padding: 10px;
		text-align: center;
		width: 25%;
	}
	#examples h2:hover, #examples .selected {
		cursor: pointer;
		background: #FFF;
	}
	#examples ul {
		margin-top: 0;
	}
</style>
<?php if ($version > 149) { ?>
<div id="content">
	<div class="breadcrumb">
		<?php foreach ($breadcrumbs as $breadcrumb) { ?>
			<?php echo $breadcrumb['separator']; ?><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a>
		<?php } ?>
	</div>
<?php } ?>
<?php if ($error_warning) { ?><div class="warning"><?php echo $error_warning; ?></div><?php } ?>
<?php if ($success) { ?><div class="success"><?php echo $success; ?></div><?php } ?>
<div class="box">
	<?php if ($version < 150) { ?><div class="left"></div><div class="right"></div><?php } ?>
	<div class="heading">
		<h1 style="padding: 10px 2px 0"><img src="view/image/<?php echo $type; ?>.png" alt="" style="vertical-align: middle" /> <?php echo $heading_title; ?></h1>
		<div class="buttons">
			<a onclick="$('#form').attr('action', location + '&exit=true'); $('#form').submit()" class="button"><span><?php echo $button_save_exit; ?></span></a>
			<a onclick="$('#form').submit()" class="button"><span><?php echo $button_save_keep_editing; ?></span></a>
			<a onclick="location = '<?php echo $exit; ?>'" class="button"><span><?php echo $button_cancel; ?></span></a>
		</div>
	</div>
	<div class="content">
		<form action="" method="post" enctype="multipart/form-data" id="form">
			<table class="form" style="margin-bottom: -1px">
				<tr>
					<td><?php echo $entry_status; ?></td>
					<td><select name="<?php echo $name; ?>_status">
							<option value="1" <?php if (!empty(${$name.'_status'})) echo 'selected="selected"'; ?>><?php echo $text_enabled; ?></option>
							<option value="0" <?php if (empty(${$name.'_status'})) echo 'selected="selected"'; ?>><?php echo $text_disabled; ?></option>
						</select>
					</td>
				</tr>
			</table>
			<table class="list">
			<thead>
				<tr>
					<td class="center"><div style="float: right"><span class="tooltip-mark">?</span> <span class="tooltip"><?php echo $help_extensions; ?></span></div> <?php echo $entry_extensions; ?></td>
					<td class="center"><div style="float: right"><span class="tooltip-mark">?</span> <span class="tooltip"><?php echo $help_order_criteria; ?></span></div> <?php echo $entry_order_criteria; ?></td>
					<td class="center"><div style="float: right"><span class="tooltip-mark">?</span> <span class="tooltip"><?php echo $help_cart_criteria; ?></span></div><?php echo $entry_cart_criteria; ?></td>
					<td class="center"><div style="float: right"><span class="tooltip-mark">?</span> <span class="tooltip"><?php echo $help_categories; ?></span></div><?php echo $entry_categories; ?> </td>
					<td class="center"><div style="float: right"><span class="tooltip-mark">?</span> <span class="tooltip" style="right: 30px"><?php echo $help_manufacturers; ?></span></div> <?php echo $entry_manufacturers; ?></td>
					<td class="center"><div style="float: right"><span class="tooltip-mark">?</span> <span class="tooltip" style="right: 80px"><?php echo $help_products; ?></span></div> <?php echo $entry_products; ?></td>
					<td class="center"><div><span class="tooltip-mark">?</span> <span class="tooltip" style="right: 0"><?php echo $help_actions; ?></span></div></td>
				</tr>
			</thead>
			<tbody>
			<?php $row = 0;
			$rates = (!empty(${$name.'_data'})) ? ${$name.'_data'} : array('');
			foreach ($rates as $rate) { ?>
				<tr>
					<td class="center" style="background: #EEE">
						<div><strong><?php echo $text_internal_notes; ?></strong></div>
						<div><input type="text" name="<?php echo $name; ?>_data[<?php echo $row; ?>][notes]" value="<?php echo (!empty($rate['notes'])) ? $rate['notes'] : ''; ?>" /></div>
						<br />
						<div class="scrollbox alternating" style="height: 250px">
							<?php echo str_replace('#ROW#', $row, preg_replace('/value="(' . implode('|', (!empty($rate['extensions']) ? $rate['extensions'] : array())) . ')"/', 'value="$1" checked="checked"', $extension_checkboxes)); ?>
						</div>
						<?php echo $selectall_links; ?>
					</td>
					<td class="center">
						<div class="scrollbox" style="height: 320px">
							<?php foreach ($order_criteria as $oc) { ?>
								<div class="order-criteria-title"><?php echo ${'text_'.$oc.'s'}; ?></div>
								<div style="padding: 0">
									<?php foreach (${$oc.'s'} as $c) { ?>
										<?php $checked = (empty($rate) || (isset($rate[$oc.'s']) && in_array($c[$oc.'_id'], $rate[$oc.'s']))) ? 'checked="checked"' : ''; ?>
										<label><div><input class="default-checked" type="checkbox" name="<?php echo $name; ?>_data[<?php echo $row; ?>][<?php echo $oc.'s'; ?>][]" value="<?php echo $c[$oc.'_id']; ?>" <?php echo $checked; ?> /><?php echo $c['name']; ?></div></label>
									<?php } ?>
								</div>
								<?php echo $selectall_links; ?>
							<?php } ?>
						</div>
					</td>
					<td class="center">
						<table class="sub-table" align="center">
							<tr>
								<td></td>
								<td><?php echo $text_min; ?></td>
								<td><?php echo $text_max; ?></td>
							</tr>
						<?php foreach ($cart_criteria as $cc) { ?>
							<tr>
								<td style="text-align: right">
									<?php if ($cc == 'total') { ?>
										<select dir="rtl" name="<?php echo $name; ?>_data[<?php echo $row; ?>][total_value]">
											<?php $total_value = (isset($rate['total_value'])) ? $rate['total_value'] : 'subtotal'; ?>
											<option value="prediscounted" <?php if ($total_value == 'prediscounted') echo 'selected="selected"'; ?>><?php echo $text_prediscounted_subtotal; ?></option>
											<option value="subtotal" <?php if ($total_value == 'subtotal') echo 'selected="selected"'; ?>><?php echo $text_subtotal; ?></option>
											<option value="taxed" <?php if ($total_value == 'taxed') echo 'selected="selected"'; ?>><?php echo $text_taxed_subtotal; ?></option>
											<option value="total" <?php if ($total_value == 'total') echo 'selected="selected"'; ?>><?php echo $text_total; ?></option>
										</select>
										<?php echo '(' . $total_unit . '):'; ?>
									<?php } else {
										echo ${'text_'.$cc} . (($cc == 'item') ? 's' : '') . ' (' . ${$cc.'_unit'} . '):';
									} ?>
								</td>
								<td><input type="text" size="3" name="<?php echo $name; ?>_data[<?php echo $row; ?>][min_<?php echo $cc; ?>]" value="<?php echo (isset($rate['min_'.$cc])) ? $rate['min_'.$cc] : ''; ?>" /></td>
								<td><input type="text" size="3" name="<?php echo $name; ?>_data[<?php echo $row; ?>][max_<?php echo $cc; ?>]" value="<?php echo (isset($rate['max_'.$cc])) ? $rate['max_'.$cc] : ''; ?>" /></td>
							</tr>
						<?php } ?>
							<tr>
								<td style="text-align: right"><?php echo $text_postcode . 's'; ?>:</td>
								<td colspan="2"><input type="text" size="16" name="<?php echo $name; ?>_data[<?php echo $row; ?>][postcodes]" value="<?php echo (isset($rate['postcodes'])) ? $rate['postcodes'] : ''; ?>" /></td>
							</tr>
							<tr>
								<td style="text-align: right"><?php echo $text_postcode_format; ?>:</td>
								<td colspan="3">
									<select name="<?php echo $name; ?>_data[<?php echo $row; ?>][postcode_format]">
										<?php $postcode_format = (isset($rate['postcode_format'])) ? $rate['postcode_format'] : 'none'; ?>
										<option value="none" <?php if ($postcode_format == 'none') echo 'selected="selected"'; ?>><?php echo $text_none; ?></option>
										<option value="uk" <?php if ($postcode_format == 'uk') echo 'selected="selected"'; ?>><?php echo $text_uk_format; ?></option>
									</select>
								</td>
							</tr>
							<tr>
								<td style="text-align: right"><?php echo $text_date_start; ?>:</td>
								<td colspan="2"><input class="date" type="text" size="16" name="<?php echo $name; ?>_data[<?php echo $row; ?>][date_start]" value="<?php echo (isset($rate['date_start'])) ? $rate['date_start'] : ''; ?>" /></td>
							</tr>
							<tr>
								<td style="text-align: right"><?php echo $text_date_end; ?>:</td>
								<td colspan="2"><input class="date" type="text" size="16" name="<?php echo $name; ?>_data[<?php echo $row; ?>][date_end]" value="<?php echo (isset($rate['date_end'])) ? $rate['date_end'] : ''; ?>" /></td>
							</tr>
							<tr>
								<td style="text-align: right"><?php echo $text_compare_against; ?>:</td>
								<td colspan="2">
									<select name="<?php echo $name; ?>_data[<?php echo $row; ?>][cart_comparison]">
										<?php $cart_comparison = (isset($rate['cart_comparison'])) ? $rate['cart_comparison'] : 'cart'; ?>
										<option value="cart" <?php if ($cart_comparison == 'cart') echo 'selected="selected"'; ?>><?php echo $text_entire_cart; ?></option>
										<option value="items" <?php if ($cart_comparison == 'items') echo 'selected="selected"'; ?>><?php echo $text_applicable_items; ?></option>
									</select>
								</td>
							</tr>
						</table>
					</td>
					<td class="center">
						<select name="<?php echo $name; ?>_data[<?php echo $row; ?>][category_comparison]" style="margin-bottom: 5px">
							<optgroup label="<?php echo $text_cart_must_match; ?>">
								<?php $rate_comparison = (isset($rate['category_comparison'])) ? $rate['category_comparison'] : 'any'; ?>
								<?php foreach ($comparisons as $comparison) { ?>
									<option value="<?php echo $comparison; ?>" <?php if ($comparison == $rate_comparison) echo 'selected="selected"'; ?>><?php echo ${'text_'.strtoupper($comparison)}; ?></option>
								<?php } ?>
							</optgroup>
							<optgroup label="<?php echo $text_of_these_categories; ?>"></optgroup>
						</select>
						<br />
						<div class="scrollbox alternating">
							<?php echo str_replace('#ROW#', $row, preg_replace('/value="(' . implode('|', (!empty($rate['categories']) ? $rate['categories'] : array())) . ')"/', 'value="$1" checked="checked"', $category_checkboxes)); ?>
						</div>
						<?php echo $selectall_links; ?>
					</td>
					<td class="center">
						<select name="<?php echo $name; ?>_data[<?php echo $row; ?>][manufacturer_comparison]" style="margin-bottom: 5px">
							<optgroup label="<?php echo $text_cart_must_match; ?>">
								<?php $rate_comparison = (isset($rate['manufacturer_comparison'])) ? $rate['manufacturer_comparison'] : 'any'; ?>
								<?php foreach ($comparisons as $comparison) { ?>
									<option value="<?php echo $comparison; ?>" <?php if ($comparison == $rate_comparison) echo 'selected="selected"'; ?>><?php echo ${'text_'.strtoupper($comparison)}; ?></option>
								<?php } ?>
							</optgroup>
							<optgroup label="<?php echo $text_of_these_manufacturers; ?>"></optgroup>
						</select>
						<br />
						<div class="scrollbox alternating">
							<?php echo str_replace('#ROW#', $row, preg_replace('/value="(' . implode('|', (!empty($rate['manufacturers']) ? $rate['manufacturers'] : array())) . ')"/', 'value="$1" checked="checked"', $manufacturer_checkboxes)); ?>
						</div>
						<?php echo $selectall_links; ?>
					</td>
					<td class="center">
						<div><a onclick="$('#product-dialog').parent().css({position:'fixed'}).end().dialog('option', 'position', 'center').dialog('open')"><img src="view/image/product.png" alt="Products" width="16" height="16" style="vertical-align: middle" /></a>
							&nbsp;
							<a onclick="addProduct($(this))"><img src="view/image/add.png" alt="Add" style="vertical-align: middle" /></a>
							&nbsp;
							<a onclick="removeProduct($(this))"><img src="view/image/delete.png" alt="Remove" style="vertical-align: middle" /></a>
							&nbsp;
							<select name="<?php echo $name; ?>_data[<?php echo $row; ?>][product_comparison]" style="margin-bottom: 5px">
								<optgroup label="<?php echo $text_cart_must_match; ?>">
									<?php $rate_comparison = (isset($rate['product_comparison'])) ? $rate['product_comparison'] : 'any'; ?>
									<?php foreach ($comparisons as $comparison) { ?>
										<option value="<?php echo $comparison; ?>" <?php if ($comparison == $rate_comparison) echo 'selected="selected"'; ?>><?php echo ${'text_'.strtoupper($comparison)}; ?></option>
									<?php } ?>
								</optgroup>
								<optgroup label="<?php echo $text_of_these_products; ?>"></optgroup>
							</select>
						</div>
						<select id="[<?php echo $row; ?>]" multiple="multiple" class="scrollbox" style="height: 290px">
							<?php if (!empty($rate['products'])) {
								$this->load->model('catalog/product');
								$enabled_products = array();
								$disabled_products = array();
								foreach ($rate['products'] as $product_id) {
									$product = $this->model_catalog_product->getProduct($product_id);
									if (empty($product)) continue;
									if ($product['status']) {
										$enabled_products[$product_id] = $product['name'] . ' (' . $product['model'] . ')';
									} else {
										$disabled_products[$product_id] = $product['name'] . ' (' . $product['model'] . ')';
									}
								}
								natcasesort($enabled_products);
								natcasesort($disabled_products);
								$product_options = '';
								foreach ($enabled_products as $id => $text) $product_options .= '<option value="' . $id . '">' . $text . '</option>';
								foreach ($disabled_products as $id => $text) $product_options .= '<option value="' . $id . '">' . $text_DISABLED . ': ' . $text . '</option>';
								echo $product_options;
							} ?>
						</select>
						<div>
							<?php if (!empty($rate['products'])) { ?>
								<?php foreach ($rate['products'] as $product_id) { ?>
									<input type="hidden" name="<?php echo $name; ?>_data[<?php echo $row; ?>][products][]" value="<?php echo $product_id; ?>" />
								<?php } ?>
							<?php } ?>
						</div>
					</td>
					<td class="left" style="width: 1px">
						<a onclick="removeRow($(this))"><img src="view/image/error.png" title="Remove" /></a>
						<br /><br /><br /><br /><br /><br /><br /><br />
						<a onclick="copyRow($(this))"><img src="view/image/category.png" title="Copy" /></a>
					</td>
				</tr>
				<?php $row++; ?>
			<?php } ?>
				<tr>
					<td class="left" colspan="7" style="background: #EEE">
						<a class="button" style="float: right" onclick="$('#examples').parent().css({position:'fixed'}).end().dialog('open');"><span><?php echo $button_show_examples; ?></span></a>
						<a onclick="addRow($(this))" class="button"><span><?php echo $button_add_row; ?></span></a>
					</td>
				</tr>
			</tbody>
			</table>
		</form>
		<?php echo $copyright; ?>
	</div>
</div>
<div><div id="examples"><?php echo $help_examples; ?></div></div>
<div>
	<div id="product-dialog" style="text-align: center">
		<select id="category-list" onchange="getCategoryProducts()"><?php echo $category_options; ?></select>
		<br />
		<select multiple="multiple" id="product-list" size="25" style="width: 100%"></select>
	</div>
</div>
<?php if ($version < 150) { ?>
	<script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jqueryui/1.8.16/jquery-ui.min.js"></script>
	<script type="text/javascript" src="view/javascript/jquery/ui/ui.datepicker.js"></script>
<?php } else { ?>
	</div>
<?php } ?>
<script type="text/javascript"><!--
	// UI scripts
	$('#examples').dialog({
		autoOpen: false,
		title: 'Examples',
		width: $(window).width() * 0.5,
		height: $(window).height() * 0.67
	});
	$('#examples h2').click(function(){
		if (!$(this).hasClass('selected')) {
			$('#examples h2').removeClass('selected');
			$(this).addClass('selected');
			$('#examples div').slideUp();
			$(this).next().next().next().slideDown();
		}
	});
	
	$('#product-dialog').dialog({
		autoOpen: false,
		resizable: false,
		title: '<?php echo $text_products; ?>',
		width: 500
	});
	
	function attachUIelements() {
		$('input.date').removeClass('hasDatepicker').removeAttr('id').datepicker({
			dateFormat: 'yy-mm-dd'
		});
	}
	attachUIelements();
	
	// Product scripts
	function getCategoryProducts() {
		$('#product-list option').remove();
		if ($('#category-list').val() == -1) return;
		$.ajax({
			url: 'index.php?route=<?php echo $type; ?>/<?php echo $name; ?>/getCategoryProducts&category_id=' + $('#category-list').val() + '&token=<?php echo $token; ?>',
			dataType: 'json',
			success: function(data) {
				for (i = 0; i < data.length; i++) {
					$('#product-list').append('<option value="' + data[i]['product_id'] + '">' + (data[i]['status'] == '1' ? '' : '<?php echo $text_DISABLED; ?>: ') + data[i]['name'] + ' (' + data[i]['model'] + ')</option>');
				}
			}
		});
	}
	
	function addProduct(element) {
		var comparisonArray = [];
		element.parent().next().find('option').each(function(){
			comparisonArray[comparisonArray.length] = $(this).val();
		});
		$('#product-list :selected').each(function(){
			if ($.inArray($(this).val(), comparisonArray) == -1) {
				element.parent().next().append('<option value="' + $(this).val() + '">' + $(this).html() + '</option>');
				var row = element.parent().next().attr('id').replace('[','').replace(']','');
				element.parent().next().next().append('<input type="hidden" name="<?php echo $name; ?>_data[' + row + '][products][]" value="' + $(this).val() + '" />');
			}
		});
	}
	
	function removeProduct(element) {
		element.parent().next().find(':selected').each(function(){
			$(this).remove();
			element.parent().next().next().find('input[value="' + $(this).val() + '"]').remove();
		});
	}
	
	// Row scripts
	var newRow = <?php echo $row; ?>;
	
	function addRow(element) {
		var clone = element.parent().parent().prev().clone();
		clone.html(clone.html().replace(/\[\d+\]/g, '['+newRow+']'));
		clone.find('input[type="text"]').val('');
		clone.find('input[type="checkbox"]').removeAttr('checked');
		clone.find('input.default-checked').attr('checked', 'checked');
		clone.find('input[type="hidden"]').remove();
		clone.find('.scrollbox option').remove();
		clone.find(':selected').removeAttr('selected');
		$('.list > tbody > tr:last-child').before(clone);
		window.scrollTo(0, document.body.scrollHeight);
		attachUIelements();
		newRow++;
	}
	
	function copyRow(element) {
		var row = element.parent().parent();
		row.find('input').each(function(){
			$(this).attr('value', $(this).val());
			if ($(this).is(':checked')) {
				$(this).attr('checked', 'checked');
			} else {
				$(this).removeAttr('checked');
			}
		});
		var clone = row.clone();
		row.find('option').each(function(i){
			if($(this).is(':selected')) {
				clone.find('option').eq(i).attr('selected', 'selected');
			} else {
				clone.find('option').eq(i).removeAttr('selected');
			}
		});
		clone.html(clone.html().replace(/\[\d+\]/g, '['+newRow+']'));
		$('.list > tbody > tr:last-child').before(clone);
		window.scrollTo(0, document.body.scrollHeight);
		attachUIelements();
		newRow++;
	}
	
	function removeRow(element) {
		if ($('.list > tbody > tr').length < 3) {
			element.parent().parent().find('input[type="text"]').val('');
			element.parent().parent().find('input[type="checkbox"]').removeAttr('checked');
			element.parent().parent().find('input.default-checked').attr('checked', 'checked');
			element.parent().parent().find('input[type="hidden"]').remove();
			element.parent().parent().find('.scrollbox option').remove();
			element.parent().parent().find('option:first-child').attr('selected', 'selected');
		} else {
			element.parent().parent().remove();
		}
	}
//--></script>
<?php echo $footer; ?>