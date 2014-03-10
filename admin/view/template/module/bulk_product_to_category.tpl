<?php echo $header; ?>
<style>
#prods > div {
	float: left;
	width: 140px;
	opacity: 0.7;
}
.prod_img {
	text-align: center; 
	padding: 3px;
	display: none;
}
.prod_img img {
	border: 1px solid #aaf;
	
}
.prod_box {
	cursor: default;
	border: 2px solid #aaf;
	margin: 1px;
	padding: 2px 0;
	background-color: #ddf;
}
#prods > .prod_selected{
	background-color: #393;
	color: #fff;
	opacity: 1;
}
.prod_name {
	width: 80%;
	height: 30px;
	float: left;
	overflow: hidden;
}
.product_checkbox {
	float: left;
	margin: 2px 5px;
}
.prod_hide {
	display: none;
}
</style>
<script type="text/javascript"><!--
	token = '<?php echo $this->session->data['token']; ?>';
	select_message = '<?php echo $text_select_category; ?>';
--></script>
<div id="content">
<div class="breadcrumb">
  <?php foreach ($breadcrumbs as $breadcrumb) { ?>
  <?php echo $breadcrumb['separator']; ?><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a>
  <?php } ?>
</div>
<?php if ($error_warning) { ?>
<div class="warning"><?php echo $error_warning; ?></div>
<?php } ?>
<div class="box">
  <div class="heading">
    <h1><img src="view/image/module.png" alt="" /> <?php echo $heading_title; ?></h1>
    <div class="buttons"><a onclick="location = '<?php echo $cancel; ?>';" class="button"><span><?php echo $button_cancel; ?></span></a></div>
  </div>
  <div class="content">
	<table class="form">
		<tr>
			<td colspan="3"><?php echo $entry_category; ?> 
				<select id="category_id">
					<option value=""><?php echo $text_select; ?></option>
<?php foreach($categories as $category): ?>
					<option value="<?php echo $category['category_id']; ?>"><?php echo $category['name']; ?></option>
<?php endforeach; ?>
				</select> <span id="spinner" style="visibility: hidden;"><img src="<?php echo HTTPS_SERVER . 'view/image/loading.gif'; ?>" /></span> &nbsp; &nbsp;<input type="checkbox" id="sticky-cats" /> <?php echo $text_sticky_cats; ?> &nbsp; &nbsp;<input type="checkbox" id="show-pics" /> <?php echo $text_show_images; ?></td>
			<td style="text-align: right; width: 35%"><a class="button select_all"><span><?php echo $button_select_all; ?></span></a> <a class="button select_none"><span><?php echo $button_select_none; ?></span></a> <a class="button save_selection"><span><?php echo $button_save_selection; ?></span></a></td>
		</tr>
		<tr>
			<td colspan="4" style="text-align: right;"><strong style="font-size: 20px;"><?php echo $entry_filter; ?></strong>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <?php echo $entry_filter_name; ?> <input type="text" value="" id="filter_name" class="filters" /> <img id="clear_filter_name" src="view/image/delete.png" alt="" /> &nbsp; <?php echo $entry_filter_manufacturer; ?> <select id="filter_manufacturer" class="filters">
					<option value="0"><?php echo $text_select; ?></option>
<?php foreach($manufacturers as $manufacturer): ?>
					<option value="<?php echo $manufacturer['manufacturer_id']; ?>"><?php echo $manufacturer['name']; ?></option>
<?php endforeach; ?>
				</select> &nbsp; <?php echo $entry_filter_category; ?> <select id="filter_category" class="filters">
					<option value="0"><?php echo $text_select; ?></option>
<?php foreach($categories as $category): ?>
					<option value="<?php echo $category['category_id']; ?>"><?php echo $category['name']; ?></option>
<?php endforeach; ?>
				</select>
				<a class="button" id="clear_filter"><span><?php echo $button_clear_filter; ?></span></a></td>
		</tr>
		<tr>
			<td colspan="4" id="prods">
<?php foreach($products as $product): ?>
			<div class="prod_box" rel="product_<?php echo $product['product_id']; ?>" data-name="<?php echo strtolower($product['name']); ?>" data-manufacturer="<?php echo $product['manufacturer_id']; ?>" data-categories="<?php echo $product['categories']; ?>">
				<div class="prod_img" style="">
					<img src="<?php echo $product['thumb']; ?>" alt="<?php echo $product['name']; ?>" title="<?php echo $product['name']; ?>" />
				</div>
				<input class="product_checkbox" type="checkbox" id="product_<?php echo $product['product_id']; ?>" rel="<?php echo $product['product_id']; ?>" />
				<div class="prod_name" title="<?php echo $product['name']; ?>"><?php echo $product['name']; ?></div>
			</div>
<?php endforeach; ?>
			</td>
		</tr>
		<tr>
			<td style="text-align: right;" colspan="4"><a class="button select_all"><span><?php echo $button_select_all; ?></span></a> <a class="button select_none"><span><?php echo $button_select_none; ?></span></a> <a class="button save_selection"><span><?php echo $button_save_selection; ?></span></a></td>
		</tr>
	</table>
    <div style="text-align: center;">&copy; Copyright Jay Gilford 2010 - <?php echo date('Y'); ?><br />
    <a href="http://store.jaygilford.com/" target="_blank" style="font-weight: bold;">Click here for more modules</a></div>
  </div>
</div>
<?php echo $footer; ?>