<?php if (count($products)>0) { ?>
	<div class="box">
		<?php echo ($titlelink) ? '<a href="'.$titlelink.'">' : ''; ?>
				<div class="view_head text-center" style="border:none; margin:0px; padding:0px;">
					<div class="col-xs-6">
						<b><?php echo $heading_title; ?></b>
					</div>
					<div class="col-xs-6">
						<a href="javascript:void(0);" class="anycart pull-right" onclick="addAllToolsToCart();"><?php echo $button_cart_all; ?><span class="glyphicon glyphicon-chevron-right"></span></a>
					</div>
					<div class="clearfix"></div>
				</div>
				<div class="sidebar_prod_view_line"></div>
				<div class="sidebar_arrow"></div>
		<?php echo ($titlelink) ? '</a>' : ''; ?>
			<div class="box-content">
			  <div class="box-product">
				<?php foreach ($products as $product) { ?>
				<div style="width:100%;min-height:100px;border-bottom:1px solid #f0f0f0;" class="product-tool" data-id="<?php echo $product['product_id']; ?>">
					<div style="width:40%;float:left;">
						<?php if ($product['thumb']) { ?>
							<div class="image"><a href="<?php echo $product['href']; ?>"><img src="<?php echo $product['thumb']; ?>" alt="<?php echo $product['name']; ?>" /></a></div>
						<?php } ?>
					</div>
					<div style="width:60%;float:right;margin:20px 0 0 0;">
						<div class="name"><a href="<?php echo $product['href']; ?>"><?php echo $product['name']; ?></a></div>
						<div class="col-xs-12">
							<div class="col-xs-4">
								<?php if ($product['price']) { ?>
								<div class="price">
								  <?php if (!$product['special']) { ?>
								  <span style="font-size:18px;color:#AF0917;font-weight:bold;"><?php echo $product['price']; ?></span>
								  <?php } else { ?>
								  <span class="price-new" style="font-size:18px;color:#AF0917;font-weight:bold;"><?php echo $product['special']; ?></span>
								  <span class="price-old" style="text-decoration:line-through;"><?php echo $product['price']; ?></span> 
								  <?php } ?>
								</div>
								<?php } ?>	
							</div>
							<div class="col-xs-8">
								<a href="javascript:void(0);" class="anycart pull-right" onclick="addToCart('<?php echo $product['product_id']; ?>');"><?php echo $button_cart; ?><span class="glyphicon glyphicon-chevron-right"></span></a>
							</div>
						</div>
						<!-- <div class="clearfix"></div> -->
					</div>
					<div class="clearfix"></div>
				</div>
				
				<?php /*if ($product['rating']) { ?>
				<div class="rating"><img src="catalog/view/theme/default/image/stars-<?php echo $product['rating']; ?>.png" alt="<?php echo $product['reviews']; ?>" /></div>
				<?php }*/ ?>
				
			  <?php } ?>
			</div>
		  </div>
	</div>
<?php } ?>