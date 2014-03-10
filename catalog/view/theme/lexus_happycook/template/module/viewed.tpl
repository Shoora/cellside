<?php if (count($products) > 0) { ?>
<div class="box">
  <h2 class="view_head text-center"><b><?php echo $heading_title; ?></b></h2>
  <div class="sidebar_prod_view_line"></div>
  <div class="sidebar_arrow"></div>
  <div class="box-content">
    <div class="box-product">
      <?php foreach ($products as $product) { ?>
      <div style="width:100%;min-height:100px;border-bottom:1px solid #f0f0f0;">
					<div style="width:40%;float:left;">
						<?php if ($product['thumb']) { ?>
							<div class="image"><a href="<?php echo $product['href']; ?>"><img src="<?php echo $product['thumb']; ?>" alt="<?php echo $product['name']; ?>" /></a></div>
						<?php } ?>
					</div>
					<div style="width:60%;float:right;margin:20px 0 0 0;">
						<div class="name"><a href="<?php echo $product['href']; ?>"><?php echo $product['name']; ?></a></div>
						<div style="width:100%;">
							<div style="width:50%;float:left;">
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
							<div style="width:50%;float:right;">
								<a href="javascript:void(0);" class="anycart pull-right" style="margin:1px -13px 0 0;" onclick="addToCart('<?php echo $product['product_id']; ?>');"><?php echo $button_cart; ?><span class="glyphicon glyphicon-chevron-right"></span></a>
							</div>
						</div>	
					</div>
				</div>
      <?php } ?>
    </div>
  </div>
</div>
<?php } ?>
