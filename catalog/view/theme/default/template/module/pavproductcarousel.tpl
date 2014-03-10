<?php 
	$span = 12/$cols; 
	$active = 'latest';
	$id = rand(1,rand(0,9))+rand(2,time());	
?>
<div class="<?php echo $prefix;?> box productcarousel" id="module<?php echo $id; ?>">
	<div class="box-heading"><span><?php echo $heading_title; ?></span></div>
	<div class="box-content" >
 		<div class="box-products slide" id="productcarousel<?php echo $id;?>">
			<?php if( trim($message) ) { ?>
			<div class="box-description"><?php echo $message;?></div>
			<?php } ?>
			<?php if( count($products) > $itemsperpage ) { ?>
			<div class="carousel-controls">
				<a class="carousel-control left" href="#productcarousel<?php echo $id;?>"   data-slide="prev">&lsaquo;</a>
				<a class="carousel-control right" href="#productcarousel<?php echo $id;?>"  data-slide="next">&rsaquo;</a>
			</div>
			<?php } ?>
			<div class="carousel-inner ">		
				<?php $pages = array_chunk( $products, $itemsperpage); ?>	
				<?php foreach ($pages as  $k => $tproducts ) {   ?>
				<div class="item <?php if($k==0) {?>active<?php } ?>">
					<?php foreach( $tproducts as $i => $product ) {  $i=$i+1;?>
						<?php if( $i%$cols == 1 || $cols == 1) { ?>
						<div class="<?php echo (count($tproducts) - $cols +1);?> row box-product <?php ;if($i == count($tproducts) - $cols +1) { echo "last";} ?>"><?php //start box-product?>
						<?php } ?>
							<div class="col-lg-<?php echo $span;?> col-sm-<?php echo $span;?> col-xs-12 product-block <?php if($i%$cols == 0) { echo "last";} ?>">
							
								<?php if($tooltip):?><?php //start product-inner for tooltip?>
								<div class="product-inner" id="product-<?php echo $product['product_id'];?>" style="display:none;"><?php //start product-inner?>
									<?php if ($product['thumb']) { ?>
									<div class="image">
										<?php if( $product['special'] ) {   ?>
											<div class="product-label-special label"><?php echo $this->language->get( 'text_sale' ); ?></div>
										<?php } ?>
										<a href="<?php echo $product['href']; ?>"><img src="<?php echo $product['thumb']; ?>" alt="<?php echo $product['name']; ?>" /></a>
									</div>
									<?php } ?>
									<div class="name"><a href="<?php echo $product['href']; ?>"><?php echo $product['name']; ?></a></div>
									<div class="description"><?php echo utf8_substr( strip_tags($product['description']),0,58);?>...</div>
									<?php if ($product['price']) { ?>
									<div class="price">
										<?php if (!$product['special']) { ?>
										<?php echo $product['price']; ?>
										<?php } else { ?>
										<span class="price-old"><?php echo $product['price']; ?></span> <span class="price-new"><?php echo $product['special']; ?></span>
										<?php } ?>
									</div>
									<?php } ?>
									<?php if ($product['rating']) { ?>
									<div class="rating"><img src="catalog/view/theme/default/image/stars-<?php echo $product['rating']; ?>.png" alt="<?php echo $product['reviews']; ?>" /></div>
									<?php } ?>
									<div class="cart"><input type="button" value="<?php echo $button_cart; ?>" onclick="addToCart('<?php echo $product['product_id']; ?>');" class="button" /></div>
								</div><?php //end product-inner?>
								<?php endif; ?><?php //end product-inner for tooltip?>
							
							
								<div class="product-inner"><?php //start product-inner?>
									<?php if ($product['thumb']) { ?>
									<div class="image">
										<?php if( $product['special'] ) {   ?>
											<div class="product-label-special label"><?php echo $this->language->get( 'text_sale' ); ?></div>
										<?php } ?>
										<a href="<?php echo $product['href']; ?>"><img id="image<?php echo $id;?>" data="<?php echo $product['product_id'];?>" src="<?php echo $product['thumb']; ?>" alt="<?php echo $product['name']; ?>" /></a>
									</div>
									<?php } ?>
									<div class="name"><a href="<?php echo $product['href']; ?>"><?php echo $product['name']; ?></a></div>
									<div class="description"><?php echo utf8_substr( strip_tags($product['description']),0,58);?>...</div>
									<?php if ($product['price']) { ?>
									<div class="price">
										<?php if (!$product['special']) { ?>
										<?php echo $product['price']; ?>
										<?php } else { ?>
										<span class="price-old"><?php echo $product['price']; ?></span> <span class="price-new"><?php echo $product['special']; ?></span>
										<?php } ?>
									</div>
									<?php } ?>
									<?php if ($product['rating']) { ?>
									<div class="rating"><img src="catalog/view/theme/default/image/stars-<?php echo $product['rating']; ?>.png" alt="<?php echo $product['reviews']; ?>" /></div>
									<?php } ?>
									<div class="cart"><input type="button" value="<?php echo $button_cart; ?>" onclick="addToCart('<?php echo $product['product_id']; ?>');" class="button" /></div>
								</div><?php //end product-inner?>
							</div>
							  
						<?php if( $i%$cols == 0 || $i==count($tproducts) ) { ?>
						</div><?php //end box-product?>
						<?php } ?>
					<?php } //endforeach; ?>
				</div>
			  <?php } ?>
			</div>  
		</div>
	</div>
</div>
<?php if($show_button):?>
<div class="btn-viewmore">
	<input type="button" value="<?php echo $view_more; ?>" onclick="location.href='<?php echo $button_link;?>'" class="button" />
</div>
<?php endif;?>

<script type="text/javascript"><!--
	<?php if($tooltip):?>
	$(function (){
		$('#module<?php echo $id;?> #image<?php echo $id;?>').each(function(){
			$(this).popover({
				placement: '<?php echo $tooltip_placement;?>',
				container: '#module<?php echo $id;?>',
				trigger: 'hover',
				template: '<div class="popover"><div class="popover-content"></div></div>',
				content: function () { 
					return getProduct($(this).attr('data'));
				},
				html: 'true',
				delay: { 
					show: <?php echo $tooltip_show;?>, 
					hide: <?php echo $tooltip_hide;?> 
				},
			});

		});
		function getProduct(product_id){
			return $('#product-' + product_id).html();
		}
	});
	<?php endif;?>
	$('#productcarousel<?php echo $id;?>').carousel({interval:<?php echo ( $auto_play_mode?$interval:'false') ;?>,auto:<?php echo $auto_play;?>,pause:'hover'});
--></script>
