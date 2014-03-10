<head>
	<script type="text/javascript" src="catalog/view/javascript/pcpb/jquery-1.7.2.min.js"></script>
	<script src="catalog/view/javascript/pcpb/jquery.ddslick.min.js"></script>
	<script src="catalog/view/javascript/pcpb/image_preview.js"></script>
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
</head>
<body>
<div style="display:none">
	<select id="imageWidth">
		<?php foreach($images as $image) {?>
		<option value="<?php echo $image['width'];?>"></option>
		<?php } ?>
	</select>
</div>
<div style="display:none">
	<select id="imageHeight">
		<?php foreach($images as $image) {?>
		<option value="<?php echo $image['height'];?>"></option>
		<?php } ?>
	</select>
</div>
<div style="display:none">
	<select id="imageId">
		<?php foreach($images as $image) {?>
		<option value="<?php echo $image['image_option_id'];?>"></option>
		<?php } ?>
	</select>
</div>
<div>
	<form method="post" action="index.php?route=pcpb/create/step2">
	<input type="hidden" value="<?php echo $pcpb_token; ?>" name="token" />
	<input type="hidden" value="" id="pcpb_background" name="background" />
	<input type="hidden" value="" id="image_Width" />
	<input type="hidden" value="" id="image_Height" />
	<input type="hidden" value="" id="image_Id" />
	<input type="hidden" value="<?php echo $product_id; ?>" name="product_id" />
	<table style="margin:auto; margin-top:25px;">
		<tr>
			<td><?php echo $text_Present_Images; ?>: </td>
			<td>
				<select id="myDropdown" name="pcpb_backgroundview">
					<?php foreach($images as $v => $image) {?>
					<option value="<?php echo $image['popup'];?>" data-imagesrc="<?php echo $image['thumb'];?>" data-description=""><?php echo $image['name'];?> <?php if($image['price'] > 0) echo ' (+' . $image['price'] . ')'; ?></option>
					<?php } ?>
				</select>
			</td>
		</tr>
		<tr>
			<td>
				<input class="button" type="button" onclick="parent.closePopupPCPB();" value="<?php echo $text_cancel_and_close; ?>" />
			</td>
			<td>
				<input class="button" type="button" onclick="parent.pcpb.setCurrentImagePath($('#pcpb_background').val(), $('#image_Width').val(), $('#image_Height').val()); parent.setOptionImageId($('#image_Id').val()); parent.closePopupPCPB();" value="<?php echo $text_Select; ?>"/>
			</td>
		</tr>
	</table>
	</form>
	<script>
	var width = <?php echo $images[0]['width']; ?>;
	var height = <?php echo $images[0]['height']; ?>;
	$(document).ready(function(){
		$('#myDropdown').ddslick({ 
			selectText: '',
			onSelected: function(selectedData){
				$('#image_Width').val($('#imageWidth option:eq(' + selectedData.selectedIndex + ')').val());
				$('#image_Height').val($('#imageHeight option:eq(' + selectedData.selectedIndex + ')').val());
				$('#image_Id').val($('#imageId option:eq(' + selectedData.selectedIndex + ')').val());
				$('#pcpb_background').val(selectedData.selectedData.value);
			},
			width: 200
		});
		imagePreview();
	})
	</script>
</div>
</body>