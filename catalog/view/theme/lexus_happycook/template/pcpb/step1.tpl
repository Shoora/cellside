<head>
	<link rel="stylesheet" type="text/css" href="catalog/view/theme/default/stylesheet/stylesheet.css">
	<style>
#preview{
	position:absolute;
	border:1px solid #ccc;
	background:#333;
	padding:5px;
	display:none;
	color:#fff;
	z-index: 2001;
}
#preview img{
	width: 250px;
}
.dd-options
{
	height: auto;
	max-height: 211px;
}
</style>
	<script type="text/javascript" src="catalog/view/javascript/pcpb/jquery-1.7.2.min.js"></script>
	<script src="catalog/view/javascript/pcpb/jquery.ddslick.min.js"></script>
	<script src="catalog/view/javascript/pcpb/image_preview.js"></script>
</head>
<body>
<div style="display:none">
	<select id="myDropdownTemp">
		<?php foreach($images as $image) {?>
		<option value="<?php echo $image['width'] . 'x' . $image['height'];?>"></option>
		<?php } ?>
	</select>
</div>
<div style="display:none">
	<select id="myDropdownTemp1">
		<?php foreach($images as $image) {?>
		<option value="<?php echo $image['product_option_value_id'];?>"></option>
		<?php } ?>
	</select>
</div>
<div style="display:none">
	<select id="optionPrice">
		<?php foreach($images as $image) {?>
		<option value="<?php echo $image['price'];?>"></option>
		<?php } ?>
	</select>
</div>
<div>
	<form method="post" action="index.php?route=pcpb/create/step2">
	<input type="hidden" value="" id="pcpb_background" name="background" />
	<input type="hidden" value="<?php echo $product_id; ?>" name="product_id" />
	<input type="hidden" value="" name="size" id='background_size'/>
	<input type="hidden" value="" name="product_option_value_id" id='product_option_value_id'/>
	<input type="hidden" value="" name="product_option_price" id='product_option_price'/>
	<table style="margin-top:25px;margin:auto;">
		<tr>
			<td><?php echo $text_select_background; ?>:</td>
			<td>
				<select id="myDropdown" name="pcpb_backgroundview">
					<?php foreach($images as $image) {?>
					<option value="<?php echo $image['popup'];?>" data-size="123" data-imagesrc="<?php echo $image['thumb'];?>" data-description=""><?php echo $image['name']; ?> <?php if($image['price'] > 0) echo ' (+' . $image['price'] . ')';?></option>
					<?php } ?>
				</select>
			</td>
		</tr>
		<tr>
			<td>
				<input class="button" type="button" onclick="parent.closePopupPCPB();" value="<?php echo $text_cancel_and_close; ?>" />
			</td>
			<td>
				<input class="button" type="submit" value="<?php echo $text_next; ?>" />
			</td>
		</tr>
		
	</table>
	</form>
	<script>
	$(document).ready(function(){
		$('#myDropdown').ddslick({ 
			selectText: '',
			onSelected: function(selectedData){
				$('#background_size').val($('#myDropdownTemp option:eq(' + selectedData.selectedIndex + ')').val());
				$('#product_option_value_id').val($('#myDropdownTemp1 option:eq(' + selectedData.selectedIndex + ')').val());
				$('#product_option_price').val($('#optionPrice option:eq(' + selectedData.selectedIndex + ')').val());
				$('#pcpb_background').val(selectedData.selectedData.value);
			},
			width: 200
		});
		imagePreview();
	})
	//resize window
	//var width = <?php echo 300 + 100 + $width; ?>;
	//var height = <?php echo 160 + $height; ?>;
	//window.resizeTo(width, height);
		
	parent.resizePopupPCPB('90%', '70%');
	<?php if(!empty($error)) {?>
		alert('<?php echo $error; ?>');
	<?php } ?>
	</script>
</div>
</body>