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
?>

<link rel="stylesheet" type="text/css" href="view/stylesheet/chain.css" />

<div id="chain_notify"></div>

<div class="chain-cpanel">
	<a href="javascript:save_combo();" class="chain_save_btn"><?php echo $entry_save_combo; ?></a>
	<a href="javascript:add_combo();" class="chain_add_btn"><?php echo $entry_add_combo; ?></a>
	<?php if ($this->user->hasPermission('modify', 'module/chain')) { ?><a href="<?php echo $view_module; ?>"><?php echo $entry_view_module; ?></a><?php } ?>
</div>

<input type="hidden" value="<?php echo $product['product_id']?>" name="main_product_id">

<script>
var make_chain_group_tpl = function(group_id) {
chain_group_tpl = 
'<table id="chain-group-'+ group_id +'" class="chain-group" data-group_id="'+group_id+'">'+
	'<thead>'+
		'<tr>'+
			'<th><?php echo $entry_product_name; ?></th>'+
			'<th><?php echo $entry_price; ?></th>'+ 
			'<th><?php echo $entry_quantity; ?></th>'+
			'<th><?php echo $entry_combo_price; ?></th>'+
			'<th><a class="combo-delete" group_id="' + group_id + '"><?php echo $entry_delete_combo; ?></a> <div class="combo-chain-position"></div></th>'+
		'</tr>'+
	'</thead>'+
	
	'<tbody>'+
		'<tr>'+
			'<td class="chain-name"><?php echo htmlspecialchars($product['name'], ENT_QUOTES); ?></td>'+
			'<td class="chain-price text-align-center"><?php echo $product['price']; ?></td>'+
			'<td class="chain-quantity text-align-center"><input type="text" name="chain_quantity[' + group_id + '][<?php echo $product['product_id']; ?>]" value="1"></td>'+
			'<td class="chain-combo-price text-align-center"><?php echo $product['price']; ?></td>'+
			'<td class="chain-action text-align-center">-</td>'+
		'</tr>'+
	'</tbody>'+
	
	'<tfoot>'+
		'<tr>'+
			'<td class="chain-name"><input type="text" id="chain-'+group_id+'" name="chain'+group_id+'" value="" /></td>'+
			'<td></td>'+
			'<td></td>'+
			'<td></td>'+
			'<td></td>'+
		'</tr>'+
		'<tr class="totals-row">'+
			'<td><?php echo $entry_total_price; ?></td>'+
			'<td class="chain-real-total-price text-align-center"></td>'+
			'<td></td>'+
			'<td class="chain-total-price text-align-center"></td>'+
			'<td></td>'+
		'</tr>'+
	'</tfoot>'+
	
'</table>';
}
</script>
<div id="combo-container">

<?php if (!empty($chains)) { ?>


	<?php foreach ($chains as $key => $chain) { ?>
		<?php

			$group_id = $chain['chain_discount_id'];
			
			$quantity = array_key_exists($product['product_id'], $chain['quantity']) ? $chain['quantity'][$product['product_id']] : 1;
			$real_total = $product['price'];
			$combo_total = $product['price'];
		?>
		<table id="chain-group-<?php echo $group_id; ?>" class="chain-group" data-group_id="<?php echo $group_id; ?>">
			<thead>
				<tr>
					<th><?php echo $entry_product_name; ?></th>
					<th><?php echo $entry_price; ?></th>
					<th><?php echo $entry_quantity; ?></th>
					<th><?php echo $entry_combo_price; ?></th>
					<th>
						<a class="combo-delete" group_id="<?php echo $group_id?>"><?php echo $entry_delete_combo; ?></a>
						<div class="combo-chain-position"></div>
					</th>
				</tr>
			</thead>
			
			<tbody>
				<tr>
					<td class="chain-name"><?php echo $product['name']; ?></td>
					<td class="chain-price text-align-center"><?php echo $product['price']; ?></td>
					<td class="chain-quantity text-align-center"><input type="text" data-grounp-id="<?php echo $group_id; ?>" name="chain_quantity[<?php echo $group_id; ?>][<?php echo $product['product_id']; ?>]" value="<?php echo $quantity; ?>"></td>
					<td class="chain-combo-price text-align-center"><?php echo $product['price']; ?></td>
					<td class="chain-action text-align-center">
						-
						<span class="exists" data-id="<?php echo $group_id;?>"></span>
						<input type="hidden" name="update_chain[<?php echo $group_id;?>]" value="1">
					</td>
				</tr>
			</tbody>
	
		<?php 
			foreach ($chain['data'] as $chain_product) { 
			$quantity = array_key_exists($chain_product['product_id'], $chain['quantity']) ? $chain['quantity'][$chain_product['product_id']] : 1;
			$real_total = $real_total + $quantity * $chain_product['price'];
			$combo_total = $combo_total + $quantity * $chain_product['combo_price'];
		?>
			<tbody>
				<tr>
					<td class="chain-name"><?php echo $chain_product['name']; ?></td>
					<td class="chain-price text-align-center"><?php echo $chain_product['price']; ?></td>
					<td class="chain-quantity text-align-center"><input type="text" data-grounp-id="<?php echo $group_id; ?>" name="chain_quantity[<?php echo $group_id; ?>][<?php echo $chain_product['product_id']; ?>]" value="<?php echo $quantity; ?>"></td>
					<td class="chain-combo-price text-align-center"><input type="text" data-grounp-id="<?php echo $group_id; ?>" value="<?php echo $chain_product['combo_price']; ?>" id="input-<?php echo $group_id; ?>-<?php echo $chain_product['product_id']; ?>" name="product[<?php echo $group_id; ?>][<?php echo $chain_product['product_id']; ?>]"></td>
					<td class="chain-action text-align-center"><span class="chain-product-action"></span> <img class="combo-delete-row" style="cursor: pointer;" src="view/image/delete.png" alt="" /></td>
				</tr>
			</tbody>
		<?php } ?>
		<tfoot>
			<tr>
				<td class="chain-name"><input type="text" id="chain-<?php echo $group_id?>" name="chain<?php echo $group_id?>" value="" /></td>
				<td></td>
				<td></td>
				<td></td>
				<td></td>
			</tr>
			<tr class="totals-row">
				<td><?php echo $entry_total_price; ?></td>
				<td class="chain-real-total-price text-align-center"><?php echo $real_total; ?></td>
				<td></td>
				<td class="chain-total-price text-align-center"><?php echo $combo_total; ?></td>
				<td></td>
			</tr>
		</tfoot>
		
	</table>
	<?php } ?>
<?php } ?>

<script>
var group_id = <?php echo (isset($group_id) ? $group_id : 0);?>;
for (var i=1;i<=group_id;i++) {
	makeAutoComplite(i);
}
</script>
</div>
