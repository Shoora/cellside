<?php require( DIR_TEMPLATE.$this->config->get('config_template')."/template/common/config.tpl" );

	$themeConfig = $this->config->get('themecontrol');
	$productConfig = array(
			'product_enablezoom'         => 1,
			'product_zoommode'           => 'basic',
			'product_zoomeasing'         => 1,
			'product_zoomlensshape'      => "round",
			'product_zoomlenssize'       => "150",
			'product_zoomgallery'        => 0,
			'enable_product_customtab'   => 0,
			'product_customtab_name'     => '',
			'product_customtab_content'  => '',
				
	);
	$languageID = $this->config->get('config_language_id');
	$productConfig = array_merge( $productConfig, $themeConfig ); 
?>
<?php echo $header; ?>


<?php require( DIR_TEMPLATE.$this->config->get('config_template')."/template/common/breadcrumb.tpl" );  ?>  
<div class="container">
	<div id="group-content">
	<?php if( $SPAN[0] ): ?>
		<aside class="col-lg-<?php echo $SPAN[0];?> col-md-<?php echo $SPAN[0];?> col-sm-12 col-xs-12">
			<?php echo $column_left; ?>
		</aside>	
	<?php endif; ?> 
<section class="col-lg-9 col-md-9 col-sm-12 col-xs-12">
	<div id="content"><?php echo $content_top; ?>
		<div class="product-info">
			<div class="row">
				<?php if ($thumb || $images) { ?>
					<div class="col-lg-5 col-md-5 col-sm-4 image-container">
						<?php if( $special )  { ?>
							<div class="product-label-special label"><?php echo $this->language->get( 'text_sale' ); ?></div>
						<?php } ?>
						<?php if ($thumb) { ?>
							<div class="image">
								<img src="<?php echo $thumb; ?>" title="<?php echo $heading_title; ?>" alt="<?php echo $heading_title; ?>" id="image"/><!-- data-zoom-image="<?php echo $popup; ?>" class="product-image-zoom" -->
								<a href="<?php echo $popup; ?>" title="<?php echo $heading_title; ?>" class="colorbox viewLarger"><span class="fa fa-search"></span> View Lager</a>
							</div>   
						<?php } ?>
						<?php if ($images) { ?>
							<div class="image-additional slide carousel" id="image-additional" style="<?php if(count($images) < 4) echo "padding: 0 !important;" ?>">
								<div class="carousel-inner">
									<?php 
										if( $productConfig['product_zoomgallery'] == 'slider' && $thumb ) {  
											$eimages = array( 0=> array( 'popup'=>$popup,'thumb'=> $thumb )  ); 
											$images = array_merge( $eimages, $images );
										}
										$icols = 3; $i= 0;
									foreach ($images as  $image) { ?>
										<?php if( (++$i)%$icols == 1 ) { ?>
											<div class="item">
										<?php } ?>
											<a href="<?php echo $image['popup']; ?>" title="<?php echo $heading_title; ?>" class="colorbox" data-zoom-image="<?php echo $image['popup']; ?>" data-image="<?php echo $image['popup']; ?>">
												<img src="<?php echo $image['thumb']; ?>" style="max-width:<?php echo $this->config->get('config_image_additional_width');?>px"  title="<?php echo $heading_title; ?>" alt="<?php echo $heading_title; ?>" data-zoom-image="<?php echo $image['popup']; ?>" class="product-image-zoom" />
											</a>
										<?php if( $i%$icols == 0 || $i==count($images) ) { ?>
											</div>
										<?php } ?>
									<?php } ?>
								</div>
								<?php if(count($images) > 4) : ?>
									<div class="carousel-control left" href="#image-additional" data-slide="prev">&lsaquo;</div>
									<div class="carousel-control right" href="#image-additional" data-slide="next">&rsaquo;</div>
								<?php endif; ?>
							</div>
							<script type="text/javascript">
								$('#image-additional .item:first').addClass('active');
								$('#image-additional').carousel({interval:false})
							</script>
						<?php } ?>
					</div>
				<?php } ?>
				<div class="col-lg-7 col-md-7 col-sm-8">
					<h1 class="prd_title"><?php echo $heading_title; ?></h1>
						<div class="description container">
							<?php if ($manufacturer) { ?>
								<div class="col-xs-12 col-sm-4">
									<span><?php echo $text_manufacturer; ?></span>
									<a href="<?php echo $manufacturers; ?>"><?php echo $manufacturer; ?></a>
								</div>
							<?php } ?>
								<div class="col-xs-12 col-sm-4">
									<span><?php echo $text_item; ?></span> <?php echo $product_id; ?>
								</div>
							<?php if ($points) { ?>
								<div class="col-xs-12 col-sm-4">
									<span><?php echo $text_reward; ?></span> <?php echo $points; ?><br />
								</div>
							<?php } ?>
							<!-- <span><?php echo $text_stock; ?></span> <?php echo $stock; ?> -->
					</div>

					 <?php if ($review_status) { ?>
						<div class="review">
							<div style="font-size:18px;font-weight:bold !important;border-top:1px solid #d7d7d7;border-bottom:1px solid #d7d7d7;line-height:22px !important;padding:13px 0 !important;">
								<img style="height:19px !important;width:120px !important;" src="catalog/view/theme/<?php echo $this->config->get('config_template');?>/image/stars-<?php echo $rating; ?>.png" alt="<?php echo $reviews; ?>" />
								<div class="review_block"><?php echo $rating_decimal; ?><span> (<?php echo $reviews; ?>)</span></div>
								<!-- <a style="color:#af0917 !important;" onclick="$('a[href=\'#tab-review\']').trigger('click');"><?php echo $reviews; ?></a> -->
								<?php if ($reviews_count == 0) : ?>
									<a id="writeReview" onclick="$('a[href=\'#tab-review\']').trigger('click');"><?php echo $text_write; ?></a>
								<?php endif; ?>
							</div>
						</div>
					<?php } ?>
					<div class="row">
						<div class="col-xs-6 col-sm-5">
							<select name="" id="ColorDesign" class="sel">
								<option value="">Select Color/Design</option>
							</select>
						</div>
						<div class="col-xs-6 col-sm-7">
							Share 
							<div class="social-media" style="display: inline-block;"><a class="fb" href="#">&nbsp;</a><a class="twtt" href="#">&nbsp;</a><a class="youtube" href="#">&nbsp;</a><a class="instagram" href="#">&nbsp;</a><a class="pinterest" href="#">&nbsp;</a></div>
						</div>
					</div>
					<div class="row ProductPriceContainer">
						<?php if ($price) { ?>
							<div class="price prd_price">
								<?php if (!$special) { ?>
									<div class="col-xs-6"><div class="onePrice"><?php echo $price; ?></div></div>
									<div class="col-xs-6 text-center"><img src="/catalog/view/theme/lexus_happycook_v2/image/pay.png" alt=""></div>
								<?php } else { ?>
									<div class="col-xs-6 price_block">
										<p class="old_price row"><?php echo $text_old_price; ?> <span><?php echo $price; ?></span></p>
										<p class="new_price row"><?php echo $text_new_price; ?> <span><?php echo $special; ?></span></p>
										<p class="you_save row"><?php echo $text_save; ?> <span><?php echo $you_save; ?></span></p>
									</div>
									<div class="col-xs-6 text-center">
										<img src="/catalog/view/theme/lexus_happycook_v2/image/deal.png" alt="">
										<img src="/catalog/view/theme/lexus_happycook_v2/image/pay.png" alt="">
									</div>
								<?php } ?>
							</div>
							<?php if ($price) { ?>
								<div class="price-other">
									<?php if ($discounts) { ?>
										<div class="discount">
											<?php foreach ($discounts as $discount) { ?>
												<?php echo sprintf($text_discount, $discount['quantity'], $discount['price']); ?><br />
											<?php } ?>
										</div>
									<?php } ?>
								</div>
							<?php } ?>
						<?php } ?>
					</div>

		<div class="price-cart row">
			<div class="col-xs-7 col-sm-6">
				<div class="product-extra">
					
					<div class="quantity-adder">
						<div><?php echo $text_qty; ?></div>
						<input class="form-control" type="text" name="quantity" size="2" value="<?php echo $minimum; ?>" />
						<!-- <span class="add-up add-action" onClick="quantity(this,'up');">+</span> 
						<span class="add-down add-action" onClick="quantity(this,'down');">-</span> -->
					</div>
					<input type="hidden" name="product_id" size="2" value="<?php echo $product_id; ?>" />
					&nbsp;
					
					<?php if($quantity > 0) : ?>					
					 	<div id="available-block" class="available">
					 		<div class="status"><span class="fa fa-check"></span> <?php echo $text_available; ?></div>
					 		<div class="count"><span class="fa fa-inbox"></span> <?php echo $quantity; ?> <?php echo $text_in_stock; ?></div>
					 	</div>
					<?php else : ?>
						<div id="available-block" class="not-available">
					 		<div class="status"><span class="fa fa-times-circle"></span> <?php echo $text_not_available; ?></div>
					 	</div>
					<?php endif; ?>

				</div>
				<div class="clearfix"></div>
			</div>
			
			<div class="col-xs-5 col-sm-6">
				<div class="cart" style="width:auto !important;">
					<a href="javascript:void(0);" id="button-cart" class="add_cart cart-single btn btn-lg btn-success"><span class="fa fa-shopping-cart"></span>Add to Cart</a>
				</div>
			</div>

			<?php if ($profiles): ?>
			<div class="option">
					<h2><span class="required">*</span><?php echo $text_payment_profile ?></h2>
					<br />
					<select name="profile_id">
							<option value=""><?php echo $text_select; ?></option>
							<?php foreach ($profiles as $profile): ?>
							<option value="<?php echo $profile['profile_id'] ?>"><?php echo $profile['name'] ?></option>
							<?php endforeach; ?>
					</select>
					<br />
					<br />
					<span id="profile-description"></span>
					<br />
					<br />
			</div>
			<?php endif; ?>
		
	
 
			<?php if ($options) { ?>
			<!-- <div class="options">
				<h2><?php echo $text_option; ?></h2>
				<br />
				<?php foreach ($options as $option) { ?>
				<?php if ($option['type'] == 'select') { ?>
				<div id="option-<?php echo $option['product_option_id']; ?>" class="option">
					<?php if ($option['required']) { ?>
					<span class="required">*</span>
					<?php } ?>
					<b><?php echo $option['name']; ?>:</b><br />
					<select name="option[<?php echo $option['product_option_id']; ?>]">
						<option value=""><?php echo $text_select; ?></option>
						<?php foreach ($option['option_value'] as $option_value) { ?>
						<option value="<?php echo $option_value['product_option_value_id']; ?>"><?php echo $option_value['name']; ?>
						<?php if ($option_value['price']) { ?>
						(<?php echo $option_value['price_prefix']; ?><?php echo $option_value['price']; ?>)
						<?php } ?>
						</option>
						<?php } ?>
					</select>
				</div>
				<br />
				<?php } ?>
				<?php if ($option['type'] == 'radio') { ?>
				<div id="option-<?php echo $option['product_option_id']; ?>" class="option">
					<?php if ($option['required']) { ?>
					<span class="required">*</span>
					<?php } ?>
					<b><?php echo $option['name']; ?>:</b><br />
					<?php foreach ($option['option_value'] as $option_value) { ?>
					<input type="radio" name="option[<?php echo $option['product_option_id']; ?>]" value="<?php echo $option_value['product_option_value_id']; ?>" id="option-value-<?php echo $option_value['product_option_value_id']; ?>" />
					<label for="option-value-<?php echo $option_value['product_option_value_id']; ?>"><?php echo $option_value['name']; ?>
						<?php if ($option_value['price']) { ?>
						(<?php echo $option_value['price_prefix']; ?><?php echo $option_value['price']; ?>)
						<?php } ?>
					</label>
					<br />
					<?php } ?>
				</div>
				<br />
				<?php } ?>
				<?php if ($option['type'] == 'checkbox') { ?>
				<div id="option-<?php echo $option['product_option_id']; ?>" class="option">
					<?php if ($option['required']) { ?>
					<span class="required">*</span>
					<?php } ?>
					<b><?php echo $option['name']; ?>:</b><br />
					<?php foreach ($option['option_value'] as $option_value) { ?>
					<input type="checkbox" name="option[<?php echo $option['product_option_id']; ?>][]" value="<?php echo $option_value['product_option_value_id']; ?>" id="option-value-<?php echo $option_value['product_option_value_id']; ?>" />
					<label for="option-value-<?php echo $option_value['product_option_value_id']; ?>"><?php echo $option_value['name']; ?>
						<?php if ($option_value['price']) { ?>
						(<?php echo $option_value['price_prefix']; ?><?php echo $option_value['price']; ?>)
						<?php } ?>
					</label>
					<br />
					<?php } ?>
				</div>
				<br />
				<?php } ?>
				<?php if ($option['type'] == 'image') { ?>
				<div id="option-<?php echo $option['product_option_id']; ?>" class="option">
					<?php if ($option['required']) { ?>
					<span class="required">*</span>
					<?php } ?>
					<b><?php echo $option['name']; ?>:</b><br />
					<table class="option-image">
						<?php foreach ($option['option_value'] as $option_value) { ?>
						<tr>
							<td style="width: 1px;"><input type="radio" name="option[<?php echo $option['product_option_id']; ?>]" value="<?php echo $option_value['product_option_value_id']; ?>" id="option-value-<?php echo $option_value['product_option_value_id']; ?>" /></td>
							<td><label for="option-value-<?php echo $option_value['product_option_value_id']; ?>"><img src="<?php echo $option_value['image']; ?>" alt="<?php echo $option_value['name'] . ($option_value['price'] ? ' ' . $option_value['price_prefix'] . $option_value['price'] : ''); ?>" /></label></td>
							<td><label for="option-value-<?php echo $option_value['product_option_value_id']; ?>"><?php echo $option_value['name']; ?>
									<?php if ($option_value['price']) { ?>
									(<?php echo $option_value['price_prefix']; ?><?php echo $option_value['price']; ?>)
									<?php } ?>
								</label></td>
						</tr>
						<?php } ?>
					</table>
				</div>
				<br />
				<?php } ?>
				<?php if ($option['type'] == 'text') { ?>
				<div id="option-<?php echo $option['product_option_id']; ?>" class="option">
					<?php if ($option['required']) { ?>
					<span class="required">*</span>
					<?php } ?>
					<b><?php echo $option['name']; ?>:</b><br />
					<input type="text" name="option[<?php echo $option['product_option_id']; ?>]" value="<?php echo $option['option_value']; ?>" />
				</div>
				<br />
				<?php } ?>
				<?php if ($option['type'] == 'textarea') { ?>
				<div id="option-<?php echo $option['product_option_id']; ?>" class="option">
					<?php if ($option['required']) { ?>
					<span class="required">*</span>
					<?php } ?>
					<b><?php echo $option['name']; ?>:</b><br />
					<textarea name="option[<?php echo $option['product_option_id']; ?>]" cols="40" rows="5"><?php echo $option['option_value']; ?></textarea>
				</div>
				<br />
				<?php } ?>
				<?php if ($option['type'] == 'file') { ?>
				<div id="option-<?php echo $option['product_option_id']; ?>" class="option">
					<?php if ($option['required']) { ?>
					<span class="required">*</span>
					<?php } ?>
					<b><?php echo $option['name']; ?>:</b><br />
					<input type="button" value="<?php echo $button_upload; ?>" id="button-option-<?php echo $option['product_option_id']; ?>" class="button">
					<input type="hidden" name="option[<?php echo $option['product_option_id']; ?>]" value="" />
				</div>
				<br />
				<?php } ?>
				<?php if ($option['type'] == 'date') { ?>
				<div id="option-<?php echo $option['product_option_id']; ?>" class="option">
					<?php if ($option['required']) { ?>
					<span class="required">*</span>
					<?php } ?>
					<b><?php echo $option['name']; ?>:</b><br />
					<input type="text" name="option[<?php echo $option['product_option_id']; ?>]" value="<?php echo $option['option_value']; ?>" class="date" />
				</div>
				<br />
				<?php } ?>
				<?php if ($option['type'] == 'datetime') { ?>
				<div id="option-<?php echo $option['product_option_id']; ?>" class="option">
					<?php if ($option['required']) { ?>
					<span class="required">*</span>
					<?php } ?>
					<b><?php echo $option['name']; ?>:</b><br />
					<input type="text" name="option[<?php echo $option['product_option_id']; ?>]" value="<?php echo $option['option_value']; ?>" class="datetime" />
				</div>
				<br />
				<?php } ?>
				<?php if ($option['type'] == 'time') { ?>
				<div id="option-<?php echo $option['product_option_id']; ?>" class="option">
					<?php if ($option['required']) { ?>
					<span class="required">*</span>
					<?php } ?>
					<b><?php echo $option['name']; ?>:</b><br />
					<input type="text" name="option[<?php echo $option['product_option_id']; ?>]" value="<?php echo $option['option_value']; ?>" class="time" />
				</div>
				<br />
				<?php } ?>
				<?php } ?>
			</div> -->
			<?php } ?>
	
		</div>
		<?php if ($tags) { ?>
		<!-- <div class="tags"><b><?php echo $text_tags; ?></b>
			<?php for ($i = 0; $i < count($tags); $i++) { ?>
			<?php if ($i < (count($tags) - 1)) { ?>
			<a href="<?php echo $tags[$i]['href']; ?>"><?php echo $tags[$i]['tag']; ?></a>,
			<?php } else { ?>
			<a href="<?php echo $tags[$i]['href']; ?>"><?php echo $tags[$i]['tag']; ?></a>
			<?php } ?>
			<?php } ?>
		</div> -->
		<?php } ?>
		<div id="dealSlasher">
			<div class="col-xs-5 text-center header_deal">Deal Slasher</div>
			<div class="col-xs-7 text-center">Share this product and receive an additional discount!</div>
			<div class="clearfix"></div>
		</div>
	</div>
	</div>
	<div class="tabs-group">
	<div id="tabs" class="htabs clearfix">
		<a href="#tab-description"><?php echo $tab_description; ?></a>
		<?php if ($attribute_groups) { ?>
		<a href="#tab-attribute"><?php echo $tab_attribute; ?></a>
		<?php } ?>
		<?php if ($review_status) { ?>
		<a href="#tab-review"><?php echo $tab_review; ?></a>
		<?php } ?>
		<a href="#tab-faq"><?php echo $tab_faq; ?></a>
		<a href="#tab-fb">FACEBOOK COMMENTS</a>
		<?php if( $productConfig['enable_product_customtab'] && isset($productConfig['product_customtab_name'][$languageID]) ) { ?>
		 <a href="#tab-customtab"><?php echo $productConfig['product_customtab_name'][$languageID]; ?></a>
	 <?php } ?> 

	</div>
	<div id="tab-description" class="tab-content"><?php echo $description; ?></div>
	<div id="tab-faq" class="tab-content">
		<?php 
			// $helper = ThemeControlHelper::getInstance( $this->registry, $themeName );
			// $modules = $helper->getModulesByPosition( 'content_bottom' );
			// print_r($modules); 
		?>
	</div>
	<div id="tab-fb" class="tab-content">FACEBOOK COMMENTS</div>
	<?php if ($attribute_groups) { ?>
	<div id="tab-attribute" class="tab-content">
		<table class="attribute">
			<?php foreach ($attribute_groups as $attribute_group) { ?>
			<thead>
				<tr>
					<td colspan="2"><?php echo $attribute_group['name']; ?></td>
				</tr>
			</thead>
			<tbody>
				<?php foreach ($attribute_group['attribute'] as $attribute) { ?>
				<tr>
					<td><?php echo $attribute['name']; ?></td>
					<td><?php echo $attribute['text']; ?></td>
				</tr>
				<?php } ?>
			</tbody>
			<?php } ?>
		</table>
	</div>
	<?php } ?>
	<?php if ($review_status) { ?>
	<div id="tab-review" class="tab-content">
		<div id="review"></div>
		<h2 id="review-title"><?php echo $text_write; ?></h2>
		<b><?php echo $entry_name; ?></b><br />
		<input type="text" name="name" value="" />
		<br />
		<br />
		<b><?php echo $entry_review; ?></b>
		<textarea name="text" cols="40" rows="8" style="width: 98%;"></textarea>
		<span style="font-size: 11px;"><?php echo $text_note; ?></span><br />
		<br />
		<b><?php echo $entry_rating; ?></b> <span><?php echo $entry_bad; ?></span>&nbsp;
		<input type="radio" name="rating" value="1" />
		&nbsp;
		<input type="radio" name="rating" value="2" />
		&nbsp;
		<input type="radio" name="rating" value="3" />
		&nbsp;
		<input type="radio" name="rating" value="4" />
		&nbsp;
		<input type="radio" name="rating" value="5" />
		&nbsp;<span><?php echo $entry_good; ?></span><br />
		<br />
		<b><?php echo $entry_captcha; ?></b><br /> <br /> 
	<img src="index.php?route=product/product/captcha" alt="" id="captcha" />
		<br />
			<br />
		<input type="text" name="captcha" value="" />
		<br />
			 <br />
		<div>
			<a id="button-review" class="button"><?php echo $button_continue; ?></a>
		</div>
	</div>
	<?php } ?>

		<?php if( $productConfig['enable_product_customtab'] && isset($productConfig['product_customtab_content'][$languageID]) ) { ?>
		 <div id="tab-customtab" class="tab-content custom-tab">
			<div class="inner">
				<?php echo html_entity_decode( $productConfig['product_customtab_content'][$languageID], ENT_QUOTES, 'UTF-8'); ?>
			</div></div>
	 <?php } ?> 
	</div>


	<div id="together">
		<h2 class="relatedhead green" style=""><?php echo $text_together; ?></h2>
		<div class="box-content">
			<div class="box-products">
				<div class="carousel-inner" style="overflow:hidden;margin-top:25px;">
					<p class="save_line"><?php echo $text_together_save; ?></p>
					<?php foreach ($together_list['items'] as $key => $value) : ?>
						<div class="together-block col-xs-3">
							<div class="item-block col-xs-6">
								<div class="image">
									<a href="/index.php?route=product/product&amp;product_id=<?php echo $value['product_id']; ?>">
										<img src="image/<?php echo $value['image'];?>" alt="">
									</a>
								</div>
								<?php if ($product['rating']) : ?>
									<div class="rating"><img src="catalog/view/theme/<?php echo $this->config->get('config_template');?>/image/stars-<?php echo $product['rating']; ?>.png" alt="<?php echo $product['reviews']; ?>" /></div>
								<?php else : ?>
									<div class="norating"><img src="catalog/view/theme/<?php echo $this->config->get('config_template');?>/image/stars-0.png"></div>
								<?php endif; ?>
								<a href="/index.php?route=product/product&amp;product_id=<?php echo $value['product_id']; ?>">
									<p class="name"><?php echo $value['name'];?></p>
								</a>
								<p class="price">
									<?php if($value['special']) { echo $value['special']; } else { echo $value['price']; } ?>
								</p>
							</div>
							<div class="symbol col-xs-6">
								<?php 
									if ($key == count($together_list['items']) - 1) {
										echo '=';
									} else { echo '+'; }
								?>
							</div>
						</div>
					<?php endforeach; ?>
					<div class="total col-xs-3">
						<div class="price"><?php echo $together_list['total']; ?></div>
						<div class="cart" style="width:auto !important;"><a href="javascript:void(0);" id="button-cart" class="add_cart cart-single btn btn-lg btn-success"><span class="fa fa-shopping-cart"></span>Add to Cart</a></div>
						<div class="save"><?php echo $text_save_single; ?></div>
					</div>
				</div>
			</div>
		</div>
	</div>		
	
	<?php 
		// $cols = 4;
		// $span = 3;
		$itemsperpage = 4;
		$active = 'latest';
		$id = rand(1,rand(0,9))+rand(2,time());	
	?>
	<?php if(!empty($products)) : ?>
		<h2 class="relatedhead"><?php echo $tab_related; ?>
			<button class="green_button ch_cart sm" onClick="addChekedToCart('.rel-prod');" style="<?php if( count($products) > $itemsperpage ){ echo 'margin-right:86px;'; } ?>">Add checked to cart</button>
		</h2>
		<?php if( count($products) > $itemsperpage ) : ?>
			<div class="carousel-controls1" style="position:relative !important;right:10px !important; float:right;"> <a class="carousel-control1 left" href="#productcarousel<?php echo $id;?>"   data-slide="prev">&lsaquo;</a> <a class="carousel-control1 right" href="#productcarousel<?php echo $id;?>"  data-slide="next">&rsaquo;</a> </div>
		<?php endif; ?>
		<div class="box-content" >
			<div class="box-products slide" id="productcarousel<?php echo $id;?>"  style="<?php if(count($products) < $itemsperpage){ echo "margin-top:25px;"; } ?>">
				<div class="carousel-inner" style="overflow:hidden;margin-top:25px;">
					<?php $pages = array_chunk( $products, $itemsperpage); ?>
					<?php foreach ($pages as  $k => $tproducts ) {   ?>
					<div class="item rel-item <?php if($k==0) {?>active<?php } ?>">
						<?php foreach( $tproducts as $i => $product ) {  $i=$i+1;?>
							<div class="rel-prod no-padding col-xs-12 col-sm-6 col-md-4 col-lg-3 <?php if($i%$cols == 0) { echo "last";} ?>">
								<div class="checkbox text-center"><label>Add <input type="checkbox" data-id="<?php echo $product['product_id'] ?>"></label></div>
								<div class="inner">
									<div class="left-part col-xs-4">
										<div class="image">
											<?php if( $product['special'] ) {   ?>
											<div class="product-label-special label"><?php echo $this->language->get( 'text_sale' ); ?></div>
											<?php } ?>
											<a class="img" href="<?php echo $product['href']; ?>"><img id="image<?php echo $id;?>" data="<?php echo $product['product_id'];?>" src="<?php echo $product['thumb']; ?>" alt="<?php echo $product['name']; ?>" /></a>
											<?php if(!$heading_title == 'Special'){ ?>
											<div class="compare-wishlish">
												<div class="wishlist"><a class="fa fa-heart" onclick="addToWishList('<?php echo $product['product_id']; ?>');"  data-toggle="tooltip" title="<?php echo $this->language->get("button_wishlist"); ?>" ></a></div>
												<div class="compare"><a class="fa fa-retweet"  onclick="addToCompare('<?php echo $product['product_id']; ?>');" data-toggle="tooltip" title="<?php echo $this->language->get("button_compare"); ?>" ></a></div>
											</div>
											<?php } ?>
											<?php if ($product['rating']) { ?>
												<div class="rating"><img src="catalog/view/theme/<?php echo $this->config->get('config_template');?>/image/stars-<?php echo $product['rating']; ?>.png" alt="<?php echo $product['reviews']; ?>" /></div>
												<?php } else { ?>
												<div class="norating"><img src="catalog/view/theme/<?php echo $this->config->get('config_template');?>/image/stars-0.png"></div>
												<?php } ?>
										</div>
									</div>
									<div class="right-part col-xs-8">
										<div class="name"><a href="<?php echo $product['href']; ?>"><?php echo $product['name']; ?></a></div>
										<?php if ($product['price']) { ?>
											<div class="price" style="padding:0px !important;">
												<?php if (!$product['special']) {  echo $product['price'];  } else { echo $product['special']; }?>
											</div>
										<?php } ?>
									</div>
								</div>	
								<div class="clearfix"></div>
							</div>
						<?php } //endforeach; ?>
					</div>
					<?php } ?>
				</div>
			</div>
		</div>
	<?php endif; ?>


	<!-- in the same category -->
	<?php $id = rand(1,rand(0,9))+rand(2,time()); $itemsperpage = 6; ?>
		<h2 class="relatedhead" style="<?php if(count($same_products) < $itemsperpage){ echo "width:100% !important;"; } ?>"><?php echo $text_in_same_category; ?></h2>
		<?php if( count($same_products) > $itemsperpage ) : ?>
			<div class="carousel-controls1" style="position:relative !important;right:10px !important; float:right;"> <a class="carousel-control1 left" href="#productcarousel<?php echo $id;?>"   data-slide="prev">&lsaquo;</a> <a class="carousel-control1 right" href="#productcarousel<?php echo $id;?>"  data-slide="next">&rsaquo;</a> </div>
		<?php endif; ?>
		<div class="box-content sameCategory">
			<div class="box-products slide" id="productcarousel<?php echo $id;?>"  style="<?php if(count($same_products) < $itemsperpage){ echo "margin-top:25px;"; } ?>">
				<div class="carousel-inner" style="overflow:hidden;margin-top:25px;">
					<?php $pages = array_chunk( $same_products, $itemsperpage); ?>
					<?php foreach ($pages as  $k => $tproducts ) {   ?>
					<div class="item rel-item <?php if($k==0) {?>active<?php } ?>">
						<?php foreach( $tproducts as $i => $product ) {  $i=$i+1;?>
							<div class="box-product">
								<div class="col-xs-6 col-sm-4 col-md-4 col-lg-2 prod-list">
									<div class="product-block cat_prd" style="padding:10px;">
									<?php if ($product['thumb']) { ?>
									<div class="image" style="border:none !important;">
										
									<?php if( $product['special'] ) {   ?>
										<span class="salebg" style="!important;left:32% !important;"><img src="../image/salebg.png"></span>
										<!--<div class="product-label-special label"><?php echo $this->language->get( 'text_sale' ); ?></div>-->
									<?php } ?>
									<a class="img" href="<?php echo $product['href']; ?>"><img src="<?php echo $product['thumb']; ?>" alt="<?php echo $product['name']; ?>" /></a>
									<div class="compare-wishlish">
									 <div class="wishlist" style="width:50% !important;"><a class="fa fa-heart" onclick="addToWishList('<?php echo $product['product_id']; ?>');"  data-toggle="tooltip" title="<?php echo $this->language->get("button_wishlist"); ?>" ></a></div>
										<div class="compare"><a class="fa fa-retweet"  onclick="addToCompare('<?php echo $product['product_id']; ?>');" data-toggle="tooltip" title="<?php echo $this->language->get("button_compare"); ?>" ></a></div>
										
									</div>
									</div>
									<?php } ?>
									<div class="product-meta">
									<div class="name"><a href="<?php echo $product['href']; ?>"><?php echo $product['name']; ?></a></div>
									<div class="description">
										<?php echo utf8_substr( strip_tags($product['description']),0,58);?>...
									</div>
									<?php if ($product['rating']) { ?>
										<div class="rating"><img src="catalog/view/theme/<?php echo $this->config->get('config_template');?>/image/stars-<?php echo $product['rating']; ?>.png" alt="<?php echo $product['reviews']; ?>" />
										</div>
										<?php } else { ?>
										<div class="norating"><img src="catalog/view/theme/<?php echo $this->config->get('config_template');?>/image/stars-0.png"></div>
									<?php } ?>
									
										<div class="cart">
											<a href="javascript:void(0);" onclick="addToCart('<?php echo $product['product_id']; ?>');" class="featured-btt"><?php if (!$product['special']) { echo $product['price']; } else { echo $product['special']; } ?></a>
											<!--<span class="fa fa-shopping-cart"></span>
											<input type="button" value="<?php echo $button_cart; ?>" onclick="addToCart('<?php echo $product['product_id']; ?>');" class="button" />-->
										</div>
										<?php if ($product['price']) { ?>
									<div class="price" style="padding:0px;">
										<?php if (!$product['special']) { ?>
										<?php //echo $product['price']; ?>
										<span class="price-old"></span>
										<?php } else { ?>
										<span class="price-old"><?php echo $product['price']; ?></span><!-- <span class="price-new"><?php echo $product['special']; ?></span>-->
										<?php } ?>
									</div>
									<?php } ?>
									</div>
									<div class="clearfix"></div>
									</div>
								</div>
							</div>
						<?php } //endforeach; ?>
					</div>
					<?php } ?>
				</div>
			</div>
		</div>


	<?php echo $content_bottom; ?></div>
	<?php if( $productConfig['product_enablezoom'] ) { ?>
</div>
<script type="text/javascript" src=" catalog/view/javascript/jquery/elevatezoom/elevatezoom-min.js"></script>
<script type="text/javascript">
 <?php if( $productConfig['product_zoomgallery'] == 'slider' ) {  ?>
	//$("#image").elevateZoom({gallery:'image-additional', cursor: 'pointer', galleryActiveClass: 'active'}); 
	<?php } else { ?>
	//var zoomCollection = '<?php echo $productConfig["product_zoomgallery"]=="basic"?".product-image-zoom":"#image";?>';
	 // $( zoomCollection ).elevateZoom({
		// 	<?php if( $productConfig['product_zoommode'] != 'basic' ) { ?>
		// 	zoomType        : "<?php echo $productConfig['product_zoommode'];?>",
		// 	<?php } ?>
		// 	lensShape : "<?php echo $productConfig['product_zoomlensshape'];?>",
		// 	lensSize    : <?php echo (int)$productConfig['product_zoomlenssize'];?>,
	
	 // });
	<?php } ?> 
</script>
<?php } ?>
<script type="text/javascript"><!--
$(document).ready(function() {
	$('.colorbox').colorbox({
		overlayClose: true,
		opacity: 0.5,
		rel: "colorbox"
	});
});
//--></script> 
 <script type="text/javascript"><!--

$('select[name="profile_id"], input[name="quantity"]').change(function(){
		$.ajax({
		url: 'index.php?route=product/product/getRecurringDescription',
		type: 'post',
		data: $('input[name="product_id"], input[name="quantity"], select[name="profile_id"]'),
		dataType: 'json',
				beforeSend: function() {
						$('#profile-description').html('');
				},
		success: function(json) {
			$('.success, .warning, .attention, information, .error').remove();
						
			if (json['success']) {
								$('#profile-description').html(json['success']);
			} 
		}
	});
});
		
$('#button-cart').bind('click', function() {
	$.ajax({
		url: 'index.php?route=checkout/cart/add',
		type: 'post',
		data: $('.product-info input[type=\'text\'], .product-info input[type=\'hidden\'], .product-info input[type=\'radio\']:checked, .product-info input[type=\'checkbox\']:checked, .product-info select, .product-info textarea'),
		dataType: 'json',
		success: function(json) {
			$('.success, .warning, .attention, information, .error').remove();
			
			if (json['error']) {
				if (json['error']['option']) {
					for (i in json['error']['option']) {
						$('#option-' + i).after('<span class="error">' + json['error']['option'][i] + '</span>');
					}
				}
								
								if (json['error']['profile']) {
										$('select[name="profile_id"]').after('<span class="error">' + json['error']['profile'] + '</span>');
								}
			} 
			
			if (json['success']) {
				$('#notification').html('<div class="success" style="display: none;">' + json['success'] + '<img src="catalog/view/theme/default/image/close.png" alt="" class="close" /></div>');
					
				$('.success').fadeIn('slow');
					
				$('#cart-total').html(json['total']);
				
				$('html, body').animate({ scrollTop: 0 }, 'slow'); 
			} 
		}
	});
});
//--></script>
<?php if ($options) { ?>
<script type="text/javascript" src="catalog/view/javascript/jquery/ajaxupload.js"></script>
<?php foreach ($options as $option) { ?>
<?php if ($option['type'] == 'file') { ?>
<script type="text/javascript"><!--
new AjaxUpload('#button-option-<?php echo $option['product_option_id']; ?>', {
	action: 'index.php?route=product/product/upload',
	name: 'file',
	autoSubmit: true,
	responseType: 'json',
	onSubmit: function(file, extension) {
		$('#button-option-<?php echo $option['product_option_id']; ?>').after('<img src="catalog/view/theme/default/image/loading.gif" class="loading" style="padding-left: 5px;" />');
		$('#button-option-<?php echo $option['product_option_id']; ?>').attr('disabled', true);
	},
	onComplete: function(file, json) {
		$('#button-option-<?php echo $option['product_option_id']; ?>').attr('disabled', false);
		
		$('.error').remove();
		
		if (json['success']) {
			alert(json['success']);
			
			$('input[name=\'option[<?php echo $option['product_option_id']; ?>]\']').attr('value', json['file']);
		}
		
		if (json['error']) {
			$('#option-<?php echo $option['product_option_id']; ?>').after('<span class="error">' + json['error'] + '</span>');
		}
		
		$('.loading').remove(); 
	}
});
//--></script>
<?php } ?>
<?php } ?>
<?php } ?>
<script type="text/javascript"><!--
$('#review .pagination a').live('click', function() {
	$('#review').fadeOut('slow');
		
	$('#review').load(this.href);
	
	$('#review').fadeIn('slow');
	
	return false;
});     

$('#review').load('index.php?route=product/product/review&product_id=<?php echo $product_id; ?>');

$('#button-review').bind('click', function() {
	$.ajax({
		url: 'index.php?route=product/product/write&product_id=<?php echo $product_id; ?>',
		type: 'post',
		dataType: 'json',
		data: 'name=' + encodeURIComponent($('input[name=\'name\']').val()) + '&text=' + encodeURIComponent($('textarea[name=\'text\']').val()) + '&rating=' + encodeURIComponent($('input[name=\'rating\']:checked').val() ? $('input[name=\'rating\']:checked').val() : '') + '&captcha=' + encodeURIComponent($('input[name=\'captcha\']').val()),
		beforeSend: function() {
			$('.success, .warning').remove();
			$('#button-review').attr('disabled', true);
			$('#review-title').after('<div class="attention"><img src="catalog/view/theme/default/image/loading.gif" alt="" /> <?php echo $text_wait; ?></div>');
		},
		complete: function() {
			$('#button-review').attr('disabled', false);
			$('.attention').remove();
		},
		success: function(data) {
			if (data['error']) {
				$('#review-title').after('<div class="warning">' + data['error'] + '</div>');
			}
			
			if (data['success']) {
				$('#review-title').after('<div class="success">' + data['success'] + '</div>');
								
				$('input[name=\'name\']').val('');
				$('textarea[name=\'text\']').val('');
				$('input[name=\'rating\']:checked').attr('checked', '');
				$('input[name=\'captcha\']').val('');
			}
		}
	});
});
//--></script> 
<script type="text/javascript"><!--
$('#tabs a').tabs();
//--></script> 
<script type="text/javascript" src="catalog/view/javascript/jquery/ui/jquery-ui-timepicker-addon.js"></script> 
<script type="text/javascript"><!--
$(document).ready(function() {
	if ($.browser.msie && $.browser.version == 6) {
		$('.date, .datetime, .time').bgIframe();
	}

	$('.date').datepicker({dateFormat: 'yy-mm-dd'});
	$('.datetime').datetimepicker({
		dateFormat: 'yy-mm-dd',
		timeFormat: 'h:m'
	});
	$('.time').timepicker({timeFormat: 'h:m'});
});
//--></script> 

</section> 
<?php if( $SPAN[2] ): ?>
	<aside class="col-lg-<?php echo $SPAN[2];?> col-md-<?php echo $SPAN[2];?> col-sm-12 col-xs-12">	
		<?php echo $column_right; ?>
	</aside>
<?php endif; ?>
</div>
<?php echo $footer; ?>