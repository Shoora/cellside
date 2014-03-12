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
 

<?php require( DIR_TEMPLATE.$this->config->get('config_template')."/template/common/breadcrumb.tpl" ); ?>


<div id="group-content">
<?php if( $SPAN[0] ): ?>
	<aside class="col-lg-<?php echo $SPAN[0];?> col-md-<?php echo $SPAN[0];?> col-sm-12 col-xs-12">
		<?php echo $column_left; ?>
	</aside>	
<?php endif; ?> 
<section class="col-lg-<?php echo $SPAN[1];?> col-md-<?php echo $SPAN[1];?> col-sm-12 col-xs-12">
<div id="content"><?php echo $content_top; ?>
  <!--<h1 class="heading_title"><span><?php echo $heading_title; ?></span></h1>-->

  <?php if ($thumb || $description) { ?>
  <div class="category-info clearfix">
    <?php if ($thumb) { ?>
    <div class="image"><img src="<?php echo $thumb; ?>" alt="<?php echo $heading_title; ?>" /></div>
    <?php } ?>
    <?php if ($description) { ?>
    <?php echo $description; ?>
    <?php } ?>
  </div>
  <?php } ?> 
  <?php if ($categories) { ?>
  <!--<h4><?php echo $text_refine; ?></h4>-->
  <div class="category-list clearfix">
    <?php if (count($categories) <= 5) { ?>
    <ul>
      <?php foreach ($categories as $category) { ?>
      <li><a href="<?php echo $category['href']; ?>"><?php echo $category['name']; ?></a></li>
      <?php } ?>
    </ul>
    <?php } else { ?>
    <?php for ($i = 0; $i < count($categories);) { ?>
    <ul>
      <?php $j = $i + ceil(count($categories) / 4); ?>
      <?php for (; $i < $j; $i++) { ?>
      <?php if (isset($categories[$i])) { ?>
      <li><a href="<?php echo $categories[$i]['href']; ?>"><?php echo $categories[$i]['name']; ?></a></li>
      <?php } ?>
      <?php } ?>
    </ul>
    <?php } ?>
    <?php } ?>
  </div>
  <?php } ?>
  <?php if ($products) { ?>
  <div class="row product-filter clearfix">
	<div class="col-md-1"><span style="color:#AF0917; font-size:13px;"><?php echo count($products)." Item(s)"; ?></span></div>
	<div class="col-md-7" style="border-bottom:1px solid #E4E4E4; margin:11px 0 0 0;"></div>
	<div class="col-md-1">
		<div class="display">
			<span><?php echo $text_list; ?></span>
			<a onclick="display('grid');"><?php echo $text_grid; ?></a>
		</div>
	</div>
	<div class="col-md-1">
		<div class="limit"><!--<span><?php echo $text_limit; ?></span>-->
	      <select class="form-control" onchange="location = this.value;">
	        <?php foreach ($limits as $limits) { ?>
	        <?php if ($limits['value'] == $limit) { ?>
	        <option value="<?php echo $limits['href']; ?>" selected="selected"><?php echo $limits['text']; ?></option>
	        <?php } else { ?>
	        <option value="<?php echo $limits['href']; ?>"><?php echo $limits['text']; ?></option>
	        <?php } ?>
	        <?php } ?>
	      </select>
	    </div>
	</div>
	<div class="col-md-2">
		<div class="sort"><!--<span><?php echo $text_sort; ?></span>-->
		  <select class="form-control" onchange="location = this.value;">
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
  </div>
  
	<!--<div class="product-filter clearfix">
		<div class="product-compare"><a href="<?php echo $compare; ?>" id="compare-total"><?php echo $text_compare; ?></a></div>
	</div>-->

  
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
	
	
	
	  <div class="box-product">
		<div class="col-xs-12 col-lg-<?php echo $span;?> col-sm-<?php echo $small;?> col-<?php echo $mini;?>">
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
			<div class="price" style="padding:0px; margin: -20px 0 0 0; min-height:42px;">
			  <?php if (!$product['special']) { ?>
				<?php //echo $product['price']; ?>
				<span class="price-old"></span>
			  <?php } else { ?>
			  <span class="price-old"><?php echo $product['price']; ?></span><!-- <span class="price-new"><?php echo $product['special']; ?></span>-->
			  <?php } ?>
			</div>
			<?php } ?>
			</div>
		  </div></div>
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
  <?php if (!$categories && !$products) { ?>
  <div class="content"><?php echo $text_empty; ?></div>
  <div class="buttons">
    <div class="right"><a href="<?php echo $continue; ?>" class="button"><?php echo $button_continue; ?></a></div>
  </div>
  <?php } ?>
  <?php echo $content_bottom; ?></div>
<script type="text/javascript"><!--
function display(view) {
	if (view == 'list') {
		$('.product-grid').attr('class', 'product-list');
		
		$('.products-block  .product-block').each(function(index, element) {
 
			 $(element).parent().addClass("col-fullwidth");
		});		
		
		$('.display').html('<span style="float: left;"><?php //echo $text_display; ?></span><a class="grid"  onclick="display(\'grid\');"><span class="fa fa-th"></span><em><?php echo $text_grid; ?></em></a><a class="list active"><span class="fa fa-th-list"></span><em><?php echo $text_list; ?></em></a>');
	
		$.totalStorage('display', 'list'); 
	} else {
		$('.product-list').attr('class', 'product-grid');
		
		$('.products-block  .product-block').each(function(index, element) {
			 $(element).parent().removeClass("col-fullwidth");  
		});	
					
		$('.display').html('<span style="float: left;"><?php //echo $text_display; ?></span><a class="grid active"><span class="fa fa-th"></span><em><?php echo $text_grid; ?></em></a><a class="list" onclick="display(\'list\');"><span class="fa fa-th-list"></span><em><?php echo $text_list; ?></em></a>');
	
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