<?php 
	$span = 12/$cols; 
	$active = 'latest';
	$id = rand(1,time()+9);	
	$bspan = 12-$block_width;

?>
<div class="box featured <?php echo $addition_class;?>">
	<h2 class="h2head" style="padding:25px 0 10px 0;">
		<span class="dot"><?php echo $heading_title; ?></span>
		<span class="divider" style="width:95% !important;"></span>
	</h2>
	<div class="box-content" style="overflow:hidden !important;">
		<div class="box-products slide row-fluid" id="productfeatured<?php echo $id;?>">
			<!-- <div class="carousel-controls" style="margin:-13px 0 0 0;">
							<a class="carousel-control left" href="#productfeatured<?php echo $id;?>" data-slide="prev"><</a> 
							<a class="carousel-control right" href="#productfeatured<?php echo $id;?>" data-slide="next">></a> 
						</div> -->
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
						<div class="carousel-controls" style="margin:-20px 0 0 0 !important;">
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
										<!--<?php if( $i%$cols == 1 ) { ?>
										  <div class="row box-product">
										<?php } ?> -->
											  <div class="col-xs-6 col-sm-4 col-md-2">
												<div class="product-block">
												<?php if ($product['thumb']) { ?>
												<div class="image">
													
												<?php if( $product['special'] ) {   ?>
													<span class="salebg"><img src="../image/salebg.png"></span>
													<!--<div class="product-label-special label"><?php echo $this->language->get( 'text_sale' ); ?></div>-->
												<?php } ?>
												<a class="img" href="<?php echo $product['href']; ?>"><img src="<?php echo $product['thumb']; ?>" alt="<?php echo $product['name']; ?>" /></a>
												<div class="compare-wishlish">
												 <div class="wishlist"><a class="fa fa-heart" onclick="addToWishList('<?php echo $product['product_id']; ?>');"  data-toggle="tooltip" title="<?php echo $this->language->get("button_wishlist"); ?>" ></a></div>
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
														<a href="javascript:void(0);" onclick="addToCart('<?php echo $product['product_id']; ?>');" class="featured-btt"><?php echo ($product['special']) ? $product['special'] : $product['price']; ?></a>
													</div>
												<?php if ($product['price']) { ?>
												<div class="price">
												  <?php if (!$product['special']) { ?>
												  <?php //echo $product['price']; ?>
												  <?php } else { ?>
												  <span class="price-old price-featured"><?php echo $product['price']; ?></span>
												  <?php } ?>
												</div>
												<?php } ?>
													
												</div>
											  </div></div>
									  
									 <!--  <?php if( $i%$cols == 0 || $i==count($tproducts) ) { ?>
																			 </div>
																			<?php } ?> -->
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
