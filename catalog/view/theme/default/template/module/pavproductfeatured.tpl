<?php 
	$span = 12/$cols; 
	$active = 'latest';
	$id = rand(1,time()+9);	
	$bspan = 12-$block_width;

?>
<div class="box featured <?php echo $addition_class;?>">
	<div class="box-heading"><?php echo $heading_title; ?></div>
	<div class="box-content" >
 		<div class="box-products slide row-fluid" id="productfeatured<?php echo $id;?>">
 			<div class="span<?php echo $bspan;?> featured-banner">
 				<?php if ( $banner ) { ?>
				<img src="image/<?php echo $banner; ?>">
 				<?php } ?>
				<?php if( trim($message) ) { ?>
				<div class="box-description"><?php echo $message;?></div>
				<?php } ?>
			</div>
			<div class="span<?php echo $block_width;?> featured-products">
						<?php if( count($products) > $itemsperpage ) { ?>
						<div class="carousel-controls">
						<a class="carousel-control left" href="#productfeatured<?php echo $id;?>"   data-slide="prev">&lsaquo;</a>
						<a class="carousel-control right" href="#productfeatured<?php echo $id;?>"  data-slide="next">&rsaquo;</a>
						</div>
						<?php } ?>
						<div class="carousel-inner ">		
						 <?php 
							$pages = array_chunk( $products, $itemsperpage);
						//	echo '<pre>'.print_r( $pages, 1 ); die;
						 ?>	
						  <?php foreach ($pages as  $k => $tproducts ) {   ?>
								<div class="item <?php if($k==0) {?>active<?php } ?>">
									<?php foreach( $tproducts as $i => $product ) {  $i=$i+1;?>
										<?php if( $i%$cols == 1 ) { ?>
										  <div class="row-fluid box-product">
										<?php } ?>
											  <div class="span<?php echo $span;?> product-block"><div class="product-inner">
												<?php if ($product['thumb']) { ?>
												<div class="image">
												<?php if( $product['special'] ) {   ?>
												<div class="product-label-special label"><?php echo $this->language->get( 'text_sale' ); ?></div>
											<?php } ?>
												<a href="<?php echo $product['href']; ?>"><img src="<?php echo $product['thumb']; ?>" alt="<?php echo $product['name']; ?>" /></a></div>
												<?php } ?>
												<div class="name"><a href="<?php echo $product['href']; ?>"><?php echo $product['name']; ?></a></div>
												<div class="description">
													<?php echo utf8_substr( strip_tags($product['description']),0,58);?>...
												</div>
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
											  </div></div>
									  
									  <?php if( $i%$cols == 0 || $i==count($tproducts) ) { ?>
										 </div>
										<?php } ?>
									<?php } //endforeach; ?>
								</div>
						  <?php } ?>
						</div> 
				</div> 
		</div>
 </div> </div>


<script>
 
$('#productfeatured<?php echo $id;?>').carousel({interval:false,auto:false,pause:'hover'});
</script>
