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


  
  <?php if ($products) { ?>
 
<div class="product-list"> <div class="products-block">
    <?php
	$cols = 6;
	$span = floor(2);
	$small = floor(2);
	$mini = floor(1);
	foreach ($products as $i => $product) { ?>
	<?php if( $i++%$cols == 0 ) { ?>
		  <div class="row">
	<?php } ?>
	
	<div class="box-product">
		<input type="radio" class="radio" name="case" id="<?php echo $product['id']; ?>" value="<?php echo $product['name']; ?>" />
		<div class="col-xs-12 col-lg-<?php echo $span;?> col-sm-<?php echo $small;?> col-<?php echo $mini;?>">
			<div class="product-block cat_prd">
			<?php if ($product['thumb']) { ?>
			<div class="image" style="border:none !important;">
				<?php if( $product['special'] ) {   ?>
					<span class="salebg" style="left:23% !important;"><img src="../image/salebg.png"></span>
					<!--<div class="product-label-special label"><?php echo $this->language->get( 'text_sale' ); ?></div>-->
				<?php } else{ ?>
					<span class="salebg" style="left:42% !important;top:-7px !important;"><img src="../image/view_line_arow.png"></span>
				<?php } ?>
			<a href="javascript:select(<?php echo $product['product_id']; ?>)" class="img"><img style="margin:0px !important;" src="<?php echo $product['thumb']; ?>" alt="<?php echo $product['name']; ?>" /></a>
			<div id="prod<?php echo $product['product_id']; ?>"></div>
			</div>
			<?php } ?>
			<div class="product-meta text-center" style="background-color:#fff !important;">
			<span><?php echo "Art by:- "; ?></span>
			<div class="name"><a href="<?php echo $product['href']; ?>"><?php echo $product['name']; ?></a></div>
			<div class="description">
				<?php echo utf8_substr( strip_tags($product['description']),0,58);?>...
			</div>
			
			<?php /*if ($product['price']) { ?>
			<div class="price" style="padding:0px; margin: -20px 0 0 0; min-height:42px;">
			  <?php if (!$product['special']) { ?>
				<?php //echo $product['price']; ?>
				<span class="price-old"></span>
			  <?php } else { ?>
			  <span class="price-old"><?php echo $product['price']; ?></span><!-- <span class="price-new"><?php echo $product['special']; ?></span>-->
			  <?php } ?>
			</div>
			<?php }*/ ?>
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
  
<script type="text/javascript">
$(".radio").css("display","none");
function select(id){
	alert(id);
	$("#"+id).append("<span><?php echo "Selected"; ?></span>");
}
</script>
  
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