<?php require( DIR_TEMPLATE.$this->config->get('config_template')."/template/common/config.tpl" ); 
	$themeConfig = $this->config->get('themecontrol');
	 
	 $categoryConfig = array( 
		'listing_products_columns' 		     => 0,
		'listing_products_columns_small' 	 => 2,
		'listing_products_columns_minismall' => 1,
		'cateogry_display_mode' 			 => 'grid',
		'category_pzoom'				     => 1,
	); 
	$categoryConfig  = array_merge($categoryConfig, $themeConfig );
	$DISPLAY_MODE 	 = $categoryConfig['cateogry_display_mode'];
	$MAX_ITEM_ROW 	 = $themeConfig['listing_products_columns']?$themeConfig['listing_products_columns']:4; 
	$MAX_ITEM_ROW_SMALL = $categoryConfig['listing_products_columns_small'] ;
	$MAX_ITEM_ROW_MINI  = $categoryConfig['listing_products_columns_minismall']; 
	$categoryPzoom 	    = $categoryConfig['category_pzoom']; 
?>
<?php
$cols = $MAX_ITEM_ROW ;
$span = floor(12/$cols);
$small = floor(12/$MAX_ITEM_ROW_SMALL);
$mini = floor(12/$MAX_ITEM_ROW_MINI);
 ?>

	<?php foreach ($products as $product) { ?>
		<div class="box-product">
			<div class="col-xs-6 col-sm-4 col-md-4 col-lg-3 prod-list">
				<div class="product-block cat_prd" style="padding:10px;">
					<?php if ($product['thumb']) { ?>
						<div class="image" style="border:none !important;">
							<?php if( $product['special'] ) {   ?>
								<span class="salebg" style="top:9px !important;left:32% !important;"><img src="../image/salebg.png"></span>
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
						<div class="name"><a href="<?php echo $product['href']; ?>" title="<?php echo $product['name']; ?>">
							<?php //echo $product['name']; ?>
							<?php echo utf8_substr( strip_tags($product['name']),0,58);?>...
						</a></div>
						<?php if ($product['rating']) { ?>
							<div class="rating"><img src="catalog/view/theme/<?php echo $this->config->get('config_template');?>/image/stars-<?php echo $product['rating']; ?>.png" alt="<?php echo $product['reviews']; ?>" />
							</div>
							<?php } else { ?>
							<div class="norating"><img src="catalog/view/theme/<?php echo $this->config->get('config_template');?>/image/stars-0.png"></div>
						<?php } ?>
						<div class="description">
							<?php echo utf8_substr( strip_tags($product['description']),0,75);?>...
						</div>
						<?php //if (!$product['special']) { echo $product['price']; } else { echo $product['special']; } ?>
						<?php if ($product['price']) { ?>
							<div class="price" style="padding:0px; margin: 0">
								<?php if (!$product['special']) { ?>
									<span class="price-new"><?php echo $product['price']; ?></span>
									<span class="price-old"></span>
								<?php } else { ?>
									<span class="price-new"><?php echo $product['special']; ?></span>
									<span class="price-old"><?php echo $product['price']; ?></span>
								<?php } ?>
							</div>
						<?php } ?>
						<div class="cart">
							<a href="javascript:void(0);" onclick="addToCart('<?php echo $product['product_id']; ?>');" class="featured-btt"><?php echo $button_cart; ?></a>
							<!--<span class="fa fa-shopping-cart"></span>
							<input type="button" value="<?php echo $button_cart; ?>" onclick="addToCart('<?php echo $product['product_id']; ?>');" class="button" />-->
						</div>
					</div>
					<div class="clearfix"></div>
				</div>
			</div>
		</div>
	<?php } ?>	

   
   
   
   
   
   <!-- <?php foreach ($products as $product) { ?>
    <div>
      <?php if ($product['thumb']) { ?>
      <div class="image"><a href="<?php echo $product['href']; ?>"><img src="<?php echo $product['thumb']; ?>" title="<?php echo $product['name']; ?>" alt="<?php echo $product['name']; ?>" /></a></div>
      <?php } ?>
      <div class="name"><a href="<?php echo $product['href']; ?>"><?php echo $product['name']; ?></a></div>
      <div class="description"><?php echo $product['description']; ?></div>
      <?php if ($product['price']) { ?>
      <div class="price">
        <?php if (!$product['special']) { ?>
        <?php echo $product['price']; ?>
        <?php } else { ?>
        <span class="price-old"><?php echo $product['price']; ?></span> <span class="price-new"><?php echo $product['special']; ?></span>
        <?php } ?>
        <?php if ($product['tax']) { ?>
        <br />
        <span class="price-tax"><?php echo $text_tax; ?> <?php echo $product['tax']; ?></span>
        <?php } ?>
      </div>
      <?php } ?>
      <?php if ($product['rating']) { ?>
      <div class="rating"><img src="catalog/view/theme/default/image/stars-<?php echo $product['rating']; ?>.png" alt="<?php echo $product['reviews']; ?>" /></div>
      <?php } ?>
      <div class="cart">
        <input type="button" value="<?php echo $button_cart; ?>" onclick="addToCart('<?php echo $product['product_id']; ?>');" class="button" />
      </div>
      <div class="wishlist"><a onclick="addToWishList('<?php echo $product['product_id']; ?>');"><?php echo $button_wishlist; ?></a></div>
      <div class="compare"><a onclick="addToCompare('<?php echo $product['product_id']; ?>');"><?php echo $button_compare; ?></a></div>
    </div>
    <?php } ?>-->