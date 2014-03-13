<?php if (count($products) > 0) { ?>
<div class="box">
  <div class="sidebar_prod_view_line"></div>
  <!-- <div class="sidebar_arrow"></div> -->
  <div class="box-content recentlyViewed">
  	<span class="sidebar_filter_text text-center"><?php echo $heading_title; ?></span>
    <div class="box-product">
      <?php foreach ($products as $product) { ?>
      		<div class="item">
				<div class="block col-xs-4">
					<?php if ($product['thumb']) { ?>
						<div class="image text-center"><a href="<?php echo $product['href']; ?>"><img src="<?php echo $product['thumb']; ?>" alt="<?php echo $product['name']; ?>" /></a></div>
					<?php } ?>
				</div>
				<div class="block block-name col-xs-8">
					<div class="name"><a href="<?php echo $product['href']; ?>"><?php echo $product['name']; ?></a></div>
				</div>
				<div class="clearfix"></div>
			</div>
      <?php } ?>
    </div>
  </div>
</div>
<?php } ?>
