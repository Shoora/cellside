<div class="box category">
	
	<!-- <div class="box-heading" style="border:none !important; margin:0px !important; padding:0px !important;"><span class="sidebar_category_text" style="margin:10px 0 0 0 !important;"><b><?php echo $heading_title; ?></b></span></div> -->
	<!-- <div class="sidebar_prod_view_line"></div>
	<div class="sidebar_arrow"></div> -->
	<div class="box-content">
		<!-- <span class="sidebar_filter_text"><?php echo $heading_title?></span> -->
		<!-- <ul class="box-category">
			<?php foreach ($categories as $category) { 
			 $class = "";
		 if(isset($category["children"]) && !empty($category["children"])){
			$class = "haschild";
		 }
			$name = str_replace("(", '<span class="badge">(',  $category['name'] );
			$category['name'] = str_replace(")", ')</span>', $name); 
		?>
			<li class="<?php echo $class; ?>">
				<?php if ($category['category_id'] == $category_id) { ?>
				<a href="<?php echo $category['href']; ?>" class="active"><?php echo $category['name']; ?></a>
				<?php } else { ?>
				<a href="<?php echo $category['href']; ?>"><?php echo $category['name']; ?></a>
				<?php } ?>
				<?php if ($category['children']) { ?>
				<ul>
					<?php foreach ($category['children'] as $child) { ?>
					<?php
						 $child['name'] = str_replace("(", '<span class="badge">(',  $child['name'] );
						 $child['name'] = str_replace(")", ')</span>', $child['name']);  
					?>
					<li>
						<?php if ($child['category_id'] == $child_id) { ?>
						<a href="<?php echo $child['href']; ?>" class="active"> <?php echo $child['name']; ?></a>
						<?php } else { ?>
						<a href="<?php echo $child['href']; ?>"> <?php echo $child['name']; ?></a>
						<?php } ?>
					</li>
					<?php } ?>
				</ul>
				<?php } ?>
			</li>
			<?php } ?>
		</ul> -->
	</div>
	<div id="freeShipping">
		<a href="#">
			<h2><b>Free</b> <br> 2 day Shipping on orders <br><b>over $100</b></h2>
			<p>Click here for more details</p>
		</a>
	</div>
	<div id="dollarDeals">
		<a href="#">
			<h2><b>Dollar deals!</b> <br> <br>
			Check out these <br><b>$1 deals to save</b><br> up to 95% off our deals</h2>
		</a>
	</div>
	<div id="shopCabble">
		<a href="#">
			<h2><b>Shop <br> our cables <br> and chargers</b> <br><br><br>
			and get the best quality</h2>
		</a>
	</div>
</div>
