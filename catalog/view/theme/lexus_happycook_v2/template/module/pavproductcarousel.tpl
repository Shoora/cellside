<?php 
	$span = 12/$cols;
	$active = 'latest';
	$id = rand(1,rand(0,9))+rand(2,time());	
?>

<div class="<?php echo $prefix;?> box productcarousel" id="module<?php echo $id; ?>">
<?php if($heading_title == 'Best Seller'){ ?>
<div class="prod_list_top_banner">
	<div class="top_banner_title"><?php echo $heading_title; ?></div>
	<div class="top_banner_line"></div>
	<div class="top_banner_nav">
		<?php if( count($products) > $itemsperpage ) { ?>
		<div class="carousel-controls" style="margin:-13px 0 0 0; width:65px !important;"> <a class="banner_nav_left carousel-control left" style="margin:0 0 0 -30px !important;" href="#productcarousel<?php echo $id;?>"   data-slide="prev">&lsaquo;</a> <a class="banner_nav_right carousel-control right" style="right:-4px; " href="#productcarousel<?php echo $id;?>"  data-slide="next">&rsaquo;</a> </div>
		<?php } ?>
	</div>
	<div class="box-content" >
		<div class="box-products slide" id="productcarousel<?php echo $id;?>">
			<?php if( trim($message) ) { ?>
			<div class="box-description"><?php echo $message;?></div>
			<?php } ?>
			<div class="carousel-inner" style="margin:25px 0 0 0;overflow:hidden !important;">
				<?php $pages = array_chunk( $products, $itemsperpage); ?>
				<?php foreach ($pages as  $k => $tproducts ) {   ?>
				<div class="item <?php if($k==0) {?>active<?php } ?>">
					<?php foreach( $tproducts as $i => $product ) {  $i=$i+1;?>
					<?php if( $i%$cols == 1 || $cols == 1) { ?>
					<div class="<?php echo (count($tproducts) - $cols +1);?> row box-product <?php ;if($i == count($tproducts) - $cols +1) { echo "last";} ?>">
						<?php //start box-product?>
						<?php } ?>
						<div class="pavcol-sm-<?php echo $cols;?> col-xs-12 col-sm-6 <?php if($i%$cols == 0) { echo "last";} ?>">
							<div class="product-block" style="border:none !important;">
								<div class="product-inner">
									<?php //start product-inner?>
									<?php if ($product['thumb']) { ?>
									<a class="img" href="<?php echo $product['href']; ?>" ><img id="image<?php echo $id;?>" data="<?php echo $product['product_id'];?>" src="<?php echo $product['thumb']; ?>" alt="<?php echo $product['name']; ?>" /></a>
									<?php } ?>
									<div class="product-meta" style="float:right !important; width:80%;">
										<div class="name top_banner_header best_seller_category"><a href="<?php echo $product['href']; ?>"><?php echo $product['name']; ?></a></div>
										<div class="description" style="display:block;"><?php echo utf8_substr(strip_tags($product['description']),0,90); ?>...</div>
										<?php if ($product['price']) { ?>
										<div class="price priceCarousel">
											<?php if (!$product['special']) { ?>
											<?php echo $product['price']; ?>
											<?php } else { ?>
											<span class="price-new"><?php echo $product['special']; ?></span>
											<span class="price-old"><?php echo $product['price']; ?></span> 
											<?php } ?>
										</div>
										<?php } ?>
										<?php if($product['quantity'] > 0) : ?>					
										 	<div class="top_banner_avail"><span class="fa fa-check"></span> Available in stock</div>
										<?php else : ?>
											<div class="top_banner_avail"><span class="fa fa-times-circle"></span> Not available in stock</div>
										<?php endif; ?>
										
									</div>
								</div>
								<?php //end product-inner?>
							</div>
						</div>
						<?php if( $i%$cols == 0 || $i==count($tproducts) ) { ?>
					</div>
					<?php } ?>
					<?php } //endforeach; ?>
				</div>
				<?php } ?>
			</div>
		</div>
	</div>
	<?php } elseif($heading_title == 'Most Viewed'){ ?>
	<!--<div class="box-heading" style="border:none !important; margin:0px !important; padding:0px !important;"><span class="sidebar_category_text" style="margin:10px 0 0 0 !important;"><b><?php echo $heading_title; ?></b></span></div>-->
	<?php if($heading_title == 'Special'){ ?>
	<!-- <h2 class="onsalehead"><?php echo $heading_title; ?></h2> -->
	<?php } else { ?>
	<!-- <h2 class="view_head text-center"><b><?php echo $heading_title; ?></b></h2> -->
	<?php } ?>
	<!-- <div class="sidebar_prod_view_line"></div>
	<div class="sidebar_arrow"></div> -->
	<div class="box-content" >
		<div class="box-products slide" id="productcarousel<?php echo $id;?>">
			<?php if( trim($message) ) { ?>
			<div class="box-description"><?php echo $message;?></div>
			<?php } ?>
			<div class="carousel-inner" style="overflow:hidden !important;">
				<?php $pages = array_chunk( $products, $itemsperpage); ?>
				<?php foreach ($pages as  $k => $tproducts ) {   ?>
				<div class="item <?php if($k==0) {?>active<?php } ?>">
					<?php foreach( $tproducts as $i => $product ) {  $i=$i+1;?>
					<?php if( $i%$cols == 1 || $cols == 1) { ?>
					<div class="<?php echo (count($tproducts) - $cols +1);?> row box-product <?php ;if($i == count($tproducts) - $cols +1) { echo "last";} ?>">
						<?php //start box-product?>
						<?php } ?>
						<div class="pavcol-sm-<?php echo $cols;?> col-xs-12 col-sm-6 <?php if($i%$cols == 0) { echo "last";} ?>">
							<div class="product-block" style="border:none !important; margin-bottom:0px;">
								<!-- <div class="name top_banner_header text-center" style="font-size:21px ;"><a href="<?php echo $product['href']; ?>"><?php echo $product['name']; ?></a></div> -->
								<div class="product-inner text-center">
									<?php //start product-inner?>
									<?php if ($product['thumb']) { ?>
									<!-- <a class="img" href="<?php echo $product['href']; ?>" class="top_banner_img"><img id="image<?php echo $id;?>" style="margin-top:0px;;" data="<?php echo $product['product_id'];?>" src="<?php echo $product['thumb']; ?>" alt="<?php echo $product['name']; ?>" ></a> -->
									<?php } ?>
									<div class="product_left_buttons">
										<?php if($byModel) : ?>
											<div class="select_decor">
												<select name="" id="" class="findphone sel">
													<option value="59">Find your phone</option>
													<?php foreach ($byModel as $model) : ?>
														<?php foreach ($model as $value) : ?>
															<option value="<?php echo $value['category_id'];?>"><?php echo $value['name']; ?></option>
														<?php endforeach; ?>
													<?php endforeach; ?>
												</select>
												<div class="step-item-decor"><div class="step-item-decor-inner"></div></div>
											</div>
										<?php endif; ?>
										<div class="select_decor">
											<select name="" id="" class="shopBrand sel">
												<option value="undefined">Shop by Brand</option>
												<?php foreach ($byBrand as $key => $value) : ?>
													<option value="<?php echo $value['manufacturer_id']; ?>"><?php echo $value['name']; ?></option>
												<?php endforeach; ?>
											</select>
											<div class="step-item-decor"><div class="step-item-decor-inner"></div></div>
										</div>
										<div class="btn btn-success" id="filter_search">Search</div>
										<script>
											$('#filter_search').click(function() {
												var cat_id = $(this).parent().find('.findphone').val();
												var man_id = $(this).parent().find('.shopBrand').val();
												var query ='/index.php?route=product/category&path=59_'+cat_id+'#category_id='+cat_id+'&page=0&path=59_224&sort=p.sort_order&order=ASC&limit=15&manufacturer%5B%5D='+man_id+'&min_price=0&max_price=5000';
												if (man_id == 'undefined') query ='/index.php?route=product/category&path=59_'+cat_id+'#category_id='+cat_id+'&page=0&path=59_224&sort=p.sort_order&order=ASC&limit=15&min_price=0&max_price=5000';
												window.location.href = query;
											});
										</script>
										<?php if($byCategory) : ?>
											<div class="select_decor shopByCategory">
												<select name="" id="" class="sel" onchange="this.options[this.selectedIndex].value && (window.location = this.options[this.selectedIndex].value);">
													<option value="59">Shop by Category</option>
													<?php foreach ($byCategory as $value) : ?>
														<option value="/index.php?route=product/category&path=<?php echo $value['category_id'];?>"><?php echo $value['name']; ?></option>
													<?php endforeach; ?>
												</select>
												<div class="step-item-decor"><div class="step-item-decor-inner"></div></div>
											</div>
										<?php endif; ?>
										
									</div>
								</div>
								<?php //end product-inner?>
							</div>
						</div>
						<?php if( $i%$cols == 0 || $i==count($tproducts) ) { ?>
					</div>
					<?php } ?>
					<?php } //endforeach; ?>
				</div>
				<?php } ?>
			</div>
		</div>
	</div>
	<?php } else { ?>
	<?php if($heading_title == 'Special'){ ?>
	<h2 class="onsalehead"><?php echo $heading_title; ?></h2>
	<?php } else { ?>
	<h2 class="h2head"><span class="dot" style="background-color:#fff !important;"><?php echo $heading_title; ?></span><span class="divider"></span></h2>
	<?php } ?>
	<div class="box-content" >
		<div class="box-products slide" id="productcarousel<?php echo $id;?>">
			<?php if( trim($message) ) { ?>
			<div class="box-description"><?php echo $message;?></div>
			<?php } ?>
			<?php if( count($products) > $itemsperpage ) { ?>
			<?php if($heading_title == 'Special'){ ?>
			<div class="carousel-controls" style="margin:10px 10px 0 0;"> <a class="carousel-control left" href="#productcarousel<?php echo $id;?>"   data-slide="prev">&lsaquo;</a> <a class="carousel-control right" href="#productcarousel<?php echo $id;?>"  data-slide="next">&rsaquo;</a> </div>
			<?php } else { ?>
			<div class="carousel-controls" style="margin:-13px 0 0 0;"> <a class="carousel-control left" href="#productcarousel<?php echo $id;?>"   data-slide="prev">&lsaquo;</a> <a class="carousel-control right" href="#productcarousel<?php echo $id;?>"  data-slide="next">&rsaquo;</a> </div>
			<?php } ?>
			<?php } ?>
			<div class="carousel-inner" style="margin:25px 0 0 0;overflow:hidden !important;">
				<?php $pages = array_chunk( $products, $itemsperpage); ?>
				<?php foreach ($pages as  $k => $tproducts ) {   ?>
				<div class="item <?php if($k==0) {?>active<?php } ?>">
					<?php foreach( $tproducts as $i => $product ) {  $i=$i+1;?>
					<?php if( $i%$cols == 1 || $cols == 1) { ?>
					<div class="<?php echo (count($tproducts) - $cols +1);?> row box-product <?php ;if($i == count($tproducts) - $cols +1) { echo "last";} ?>">
						<?php //start box-product?>
						<?php } ?>
						<div class="pavcol-sm-<?php echo $cols;?> col-xs-12 col-sm-6 <?php if($i%$cols == 0) { echo "last";} ?>">
							<div class="product-block">
								<?php if($tooltip):?>
								<?php //start product-inner for tooltip?>
								<div class="product-inner" id="product-<?php echo $product['product_id'];?>" style="display:none;">
									<?php //start product-inner?>
									<?php if ($product['thumb']) { ?>
									<div class="image">
										<?php if( $product['special'] ) {   ?>
										<div class="product-label-special label"><?php echo $this->language->get( 'text_sale' ); ?></div>
										<?php } ?>
										<a class="img" href="<?php echo $product['href']; ?>"><img src="<?php echo $product['thumb']; ?>" alt="<?php echo $product['name']; ?>" /></a>
										<?php if(!$heading_title = 'Special'){ ?>
										<div class="compare-wishlish">
											<div class="wishlist"><a class="fa fa-heart" onclick="addToWishList('<?php echo $product['product_id']; ?>');"  data-toggle="tooltip" title="<?php echo $this->language->get("button_wishlist"); ?>" ></a></div>
											<div class="compare"><a class="fa fa-retweet"  onclick="addToCompare('<?php echo $product['product_id']; ?>');" data-toggle="tooltip" title="<?php echo $this->language->get("button_compare"); ?>" ></a></div>
										</div>
										<?php } ?>
									</div>
									<?php } ?>
									<div class="product-meta">
										<div class="name"><a href="<?php echo $product['href']; ?>"><?php echo $product['name']; ?></a></div>
										<div class="description"> <?php echo utf8_substr( strip_tags($product['description']),0,100);?>... </div>
										<?php if ($product['rating']) { ?>
										<div class="rating"><img src="catalog/view/theme/<?php echo $this->config->get('config_template');?>/image/stars-<?php echo $product['rating']; ?>.png" alt="<?php echo $product['reviews']; ?>" /></div>
										<?php } else { ?>
										<div class="norating"><img src="catalog/view/theme/<?php echo $this->config->get('config_template');?>/image/stars-0.png"></div>
										<?php } ?>
										<?php if ($product['price']) { ?>
										<div class="price">
											<?php if (!$product['special']) { ?>
											<?php echo $product['price']; ?>
											<?php } else { ?>
											<span class="price-old"><?php echo $product['price']; ?></span> <span class="price-new"><?php echo $product['special']; ?></span>
											<?php } ?>
										</div>
										<?php } ?>
										<div class="cart"> <span class="fa fa-shopping-cart"></span>
											<input type="button" value="<?php echo $button_cart; ?>" onclick="addToCart('<?php echo $product['product_id']; ?>');" class="btn btn-lg btn-success" />
										</div>
									</div>
								</div>
								<?php //end product-inner?>
								<?php endif; ?>
								<?php //end product-inner for tooltip?>
								<div class="product-inner">
									<?php //start product-inner?>
									<?php if ($product['thumb']) { ?>
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
									</div>
									<?php } ?>
									<div class="product-meta">
										<?php if($heading_title == 'Special'){ ?>
										<div class="sale-cont">
											<p class="sale-title"><a href="<?php echo $product['href']; ?>"><?php echo $product['name']; ?></a></p>
											<p><?php echo utf8_substr( strip_tags($product['description']),0,58);?>...</p>
											<?php if ($product['rating']) { ?>
											<span class="rate"><img src="catalog/view/theme/<?php echo $this->config->get('config_template');?>/image/stars-<?php echo $product['rating']; ?>.png" alt="<?php echo $product['reviews']; ?>" /></span>
											<?php } else { ?>
											<span class="rate"><img src="catalog/view/theme/<?php echo $this->config->get('config_template');?>/image/stars-0.png"></span>
											<?php } ?>
											<?php if(!$heading_title == 'Special'){ ?>
											<?php if ($product['price']) { ?>
											<span class="price flt-left">
											<?php if (!$product['special']) { ?>
											<?php echo $product['price']; ?>
											<?php } else { ?>
											<?php echo $product['special']; ?> <span class="discount-prc"> <?php echo $product['price']; ?> </span>
											<?php } ?>
											</span>
											<?php } ?>
											<a href="javascript:void(0);" onclick="addToCart('<?php echo $product['product_id']; ?>');" class="btn btn-lg btn-success">Add to cart</a>
											<?php } else { ?>
											<?php if ($product['price']) { ?>
											<span class="price flt-left" style="margin:0 0 -66px 0 !important; padding:10px 0 35px !important; width:65% !important;">
											<?php if (!$product['special']) { ?>
											<?php echo $product['price']; ?>
											<?php } else { ?>
											<?php echo $product['special']; ?> <span class="discount-prc"> <?php echo $product['price']; ?> </span>
											<?php } ?>
											</span>
											<?php } ?>
											<a href="javascript:void(0);" style="float:right;" onclick="addToCart('<?php echo $product['product_id']; ?>');" class="btn btn-lg btn-success">Add to cart</a>
											<?php } ?>
										</div>
										<?php } else { ?>
										<div class="name"><a href="<?php echo $product['href']; ?>"><?php echo $product['name']; ?></a></div>
										<div class="description"><?php echo utf8_substr( strip_tags($product['description']),0,58);?>...</div>
										<?php if ($product['rating']) { ?>
										<div class="rating"><img src="catalog/view/theme/<?php echo $this->config->get('config_template');?>/image/stars-<?php echo $product['rating']; ?>.png" alt="<?php echo $product['reviews']; ?>" /></div>
										<?php } else { ?>
										<div class="norating"><img src="catalog/view/theme/<?php echo $this->config->get('config_template');?>/image/stars-0.png"></div>
										<?php } ?>
										<?php if ($product['price']) { ?>
										<div class="price">
											<?php if (!$product['special']) { ?>
											<?php echo $product['price']; ?>
											<?php } else { ?>
											<span class="price-old"><?php echo $product['price']; ?></span> <span class="price-new"><?php echo $product['special']; ?></span>
											<?php } ?>
										</div>
										<?php } ?>
										<div class="cart"> <a href="javascript:void(0);" onclick="addToCart('<?php echo $product['product_id']; ?>');" class="btn btn-lg btn-success"><i class="fa fa-shopping-cart pull-right"></i>Add to cart</a>                        
										</div>
										<?php } ?>
									</div>
								</div>
								<?php //end product-inner?>
							</div>
						</div>
						<?php if( $i%$cols == 0 || $i==count($tproducts) ) { ?>
					</div>
					<?php } ?>
					<?php } //endforeach; ?>
				</div>
				<?php } ?>
			</div>
		</div>
	</div>
</div>
<?php } ?>
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
