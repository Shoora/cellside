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

<?php echo $header; ?>



	<?php require( DIR_TEMPLATE.$this->config->get('config_template')."/template/common/breadcrumb.tpl" );  ?> 
<div id="group-content">
<?php if( $SPAN[0] ): ?>
	<aside class="col-lg-<?php echo $SPAN[0];?> col-md-<?php echo $SPAN[0];?> col-sm-12 col-xs-12">
		<?php echo $column_left; ?>
	</aside>	
<?php endif; ?> 

<section class="col-lg-<?php echo $SPAN[1];?> col-md-<?php echo $SPAN[1];?> col-sm-12 col-xs-12"> 
	<div id="content" class="special">
		<?php echo $content_top; ?>
		<h1><?php echo $heading_title; ?></h1>
		<?php if ($products) { ?>
		<div class="product-filter clearfix">
			<div class="display">
				<span><?php echo $text_display; ?></span>
				<span><?php echo $text_list; ?></span>
				<a onclick="display('grid');"><?php echo $text_grid; ?></a>
			</div>
			<div class="product-compare"><a href="<?php echo $compare; ?>" id="compare-total"><?php echo $text_compare; ?></a></div>

			<div class="limit"><span><?php echo $text_limit; ?></span>
				<select class="form-filter" onchange="location = this.value;">
					<?php foreach ($limits as $limits) { ?>
					<?php if ($limits['value'] == $limit) { ?>
					<option value="<?php echo $limits['href']; ?>" selected="selected"><?php echo $limits['text']; ?></option>
					<?php } else { ?>
					<option value="<?php echo $limits['href']; ?>"><?php echo $limits['text']; ?></option>
					<?php } ?>
					<?php } ?>
				</select>
			</div>
			<div class="sort"><span><?php echo $text_sort; ?></span>
				<select class="form-filter" onchange="location = this.value;">
					<?php foreach ($sorts as $sorts) { ?>
					<?php if ($sorts['value'] == $sort . '-' . $order) { ?>
					<option value="<?php echo $sorts['href']; ?>" selected="selected"><?php echo $sorts['text']; ?></option>
					<?php } else { ?>
					<option value="<?php echo $sorts['href']; ?>"><?php echo $sorts['text']; ?></option>
					<?php } ?>
					<?php } ?>
				</select>
			</div>
		

	</div>

		<div class="product-list"> <div class="products-block">
				<?php
				$cols = $MAX_ITEM_ROW ;
				$span = floor(12/$cols);
				$small = floor(12/$MAX_ITEM_ROW_SMALL);
				$mini = floor(12/$MAX_ITEM_ROW_MINI);
				foreach ($products as $i => $product) { ?>
				<?php if( $i++%$cols == 0 ) { ?>
				<div class="row">
					<?php } ?>
					<div class="col-xs-12 col-lg-<?php echo $span;?> col-sm-<?php echo $small;?> col-xs-<?php echo $mini;?>">
						<div class="product-block">	
							<?php if ($product['thumb']) { ?>
							<div class="image"><?php if( $product['special'] ) {   ?>
								<span class="product-label-special label"><?php echo $this->language->get( 'text_sale' ); ?></span>
								<?php } ?>
								<a class="img" href="<?php echo $product['href']; ?>"><img src="<?php echo $product['thumb']; ?>" title="<?php echo $product['name']; ?>" alt="<?php echo $product['name']; ?>" /></a>
								<div class="compare-wishlish">
								 <div class="wishlist"><a class="fa fa-heart" onclick="addToWishList('<?php echo $product['product_id']; ?>');"  data-placement="top" data-toggle="tooltip" data-original-title="<?php echo $button_wishlist; ?>"><span><?php echo $button_wishlist; ?></span></a></div>
								 <?php if( $categoryPzoom ) { $zimage = str_replace( "cache/","", preg_replace("#-\d+x\d+#", "",  $product['thumb'] ));  ?>
						      	 <div class="product-zoom">
						      	 	<a href="<?php echo $zimage;?>" class="colorbox" rel="colorbox" title="<?php echo $product['name']; ?>"><span class="fa fa-search-plus"></span></a>
						      	 </div>
						      	 <?php } ?>
							      <div class="compare"><a class="fa fa-retweet" onclick="addToCompare('<?php echo $product['product_id']; ?>');"  data-placement="top" data-toggle="tooltip" data-original-title="<?php echo $button_compare; ?>"><span><?php echo $button_compare; ?></span></a></div>
						    	</div>
							</div>
							<div class="product-meta"> 
								<?php } ?>
								<h3 class="name"><a href="<?php echo $product['href']; ?>"><?php echo $product['name']; ?></a></h3>
								<div class="description"><?php echo utf8_substr( strip_tags($product['description']),0,60);?>...</div>
								<?php if ($product['rating']) { ?>
							      <div class="rating"><img src="catalog/view/theme/<?php echo $this->config->get('config_template');?>/image/stars-<?php echo $product['rating']; ?>.png" alt="<?php echo $product['reviews']; ?>" />
							      </div>
							      <?php } else { ?>
							      <div class="norating"><img src="catalog/view/theme/<?php echo $this->config->get('config_template');?>/image/stars-0.png"></div>
							      <?php } ?>
								<div class="price-cart">
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

									<div class="cart">
										<span class="fa fa-shopping-cart"></span>
										<input type="button" value="<?php echo $button_cart; ?>" onclick="addToCart('<?php echo $product['product_id']; ?>');" class="button" />
									</div>
								</div>

							</div>
						</div>
					</div>
					<?php if( $i%$cols == 0 || $i==count($products) ) { ?>
				</div>
				<?php } ?>

				<?php } ?>
			</div>
		</div>

		<div class="pagination">
			<div class="product-compare"><a href="<?php echo $compare; ?>" id="compare-total"><?php echo $text_compare; ?></a></div>
			<?php echo $pagination; ?>
		</div>
		<?php } ?>

		<?php echo $content_bottom; ?>
	</div>
	<script type="text/javascript"><!--
	function display(view) {
		if (view == 'list') {
			$('.product-grid').attr('class', 'product-list');

		$('.products-block  .product-block').each(function(index, element) {
 
			 $(element).parent().addClass("col-fullwidth");
		});		
		
		$('.display').html('<span style="float: left;"><?php echo $text_display; ?></span><a class="list active"><span class="fa fa-th-list"></span><em><?php echo $text_list; ?></em></a><a class="grid"  onclick="display(\'grid\');"><span class="fa fa-th"></span><em><?php echo $text_grid; ?></em></a>');
	
		$.totalStorage('display', 'list'); 
	} else {
		$('.product-list').attr('class', 'product-grid');
		
		$('.products-block  .product-block').each(function(index, element) {
			 $(element).parent().removeClass("col-fullwidth");  
		});	
					
		$('.display').html('<span style="float: left;"><?php echo $text_display; ?></span><a class="list" onclick="display(\'list\');"><span class="fa fa-th-list"></span><em><?php echo $text_list; ?></em></a><a class="grid active"><span class="fa fa-th"></span><em><?php echo $text_grid; ?></em></a>');
	
	$.totalStorage('display', 'grid');
}
}

view = $.totalStorage('display');

if (view) {
	display(view);
} else {
	display('<?php echo $DISPLAY_MODE;?>');
}
//--></script> 
<?php if( $categoryPzoom ) {  ?>
<script type="text/javascript"><!--
$(document).ready(function() {
	$('.colorbox').colorbox({
		overlayClose: true,
		opacity: 0.5,
		rel: false,
		onLoad:function(){
			$("#cboxNext").remove(0);
			$("#cboxPrevious").remove(0);
			$("#cboxCurrent").remove(0);
		}
	});

});
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