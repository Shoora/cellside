<div>
	View link: <input type="text" readonly value="<?php echo $view_link ?>" style="width: 600px;"/>
</div>
<div>
	<img src="<?php echo $image_link; ?>" />
</div>
<script>
	var link = '<?php echo htmlspecialchars_decode($view_link); ?>';
	var product_option_value_id = '<?php echo $product_option_value_id; ?>';
	var image_option_id = '<?php echo $image_option_id; ?>';
	this.parent.setPCPBLink(link, product_option_value_id);
	if(image_option_id != '')
		this.parent.setImageOptionId(image_option_id);
	//this.parent.setPriceOption('<?php echo $product_option_price; ?>');
	this.parent.setTotalPrice('<?php echo $total_price; ?>');
	this.parent.showViewYourPrint();
	this.parent.closePopupPCPB();
</script>