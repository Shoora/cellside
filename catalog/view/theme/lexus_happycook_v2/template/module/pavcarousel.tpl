<?php $id = rand(1,10); $col =  12/$columns; // echo $columns;die;?>
   <div id="pavcarousel<?php echo $id;?>" class="carousel slide pavcarousel box hidden-xs">
	   <h2 class="h2head" style="padding:32px 0 0px 0;"><span class="dot" style="background-color:#fff !important;"><?php echo $this->language->get('Ours Brands');?></span><span class="divider" style="width:95% !important;"></span></h2>
       <!--<div class="box box-heading"><span><?php echo $this->language->get('Ours clients');?></span></div>-->
	   <div class="box box-content">
	   		<div class="carousel-controls">
			<?php if( count($banners) > $columns ){ ?>	
			<a class="carousel-control left" href="#pavcarousel<?php echo $id;?>" data-slide="prev">&lsaquo;</a>
			<a class="carousel-control right" href="#pavcarousel<?php echo $id;?>" data-slide="next">&rsaquo;</a>
			<?php } ?>
	   		</div>
			<div class="carousel-inner" style="overflow:hidden !important;">
				 <?php foreach ($banners as $i => $banner) { $i=$i+1;?>
					<?php if($i%$columns==1) { ?>
					<div class="row item <?php if(($i-1)==0) {?>active<?php } ?>">
					<?php } ?>
					<div class="col-lg-<?php echo $col;?>">
						<div class="item-inner">
							<?php if ($banner['link']) { ?>
							<a href="<?php echo $banner['link']; ?>"><img src="<?php echo $banner['image']; ?>" alt="<?php echo $banner['title']; ?>" /></a>
							<?php } else { ?>
							<img src="<?php echo $banner['image']; ?>" alt="<?php echo $banner['title']; ?>" />
							<?php } ?>
						</div>
					</div>	
					<?php if( $i%$columns==0 || $i==count($banners)) { ?>
					</div>
					<?php } ?>
				<?php } ?>
			</div>
		</div>
    </div>
<?php if( count($banners) > 1 ){ ?>
<script type="text/javascript"><!--
 $('#pavcarousel<?php echo $id;?>').carousel({interval:false});
--></script>
<?php } ?>