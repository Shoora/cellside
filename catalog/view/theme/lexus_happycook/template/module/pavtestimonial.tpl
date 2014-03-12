<?php if( count($testimonials) ) { ?>
	<?php $id = rand(1,10)+rand();?>
   <div id="pavtestimonial<?php echo $id;?>" class="carousel slide pavtestimonial box" style="margin:50px 0 0 0;">
   	
    <h2 class="h2head pull-left col-lg-12 col-sm-12" style="margin-bottom:20px !important;" ><span class="dot" style="background-color:#ededed !important;"><?php echo $this->language->get('text_testimonial');?></span><span class="divider" style="width:91% !important;"></span></h2>
    <!--<div class="box-heading"><span><?php echo $this->language->get('text_testimonial');?></span></div>-->
		<div class="carousel-inner" style="overflow:hidden !important;">
			 <?php $pages = array_chunk($testimonials, $row ); ?>
			 <?php foreach ( $pages as $i => $testimonials ) { ?>
				<div class="item <?php if($i==0) {?>active<?php } ?>">
			 <?php foreach ($testimonials as $i => $testimonial) { ?>
				<div class="testimonial-wrapper clearfix">
	 				<div class="testimonial-item">
	 					<div class="col-sm-3 col-xs-3">
	 						<div class="t-avatar testi-bg"><img src="<?php echo $testimonial['thumb']; ?>" class="img-circle"/></div>
							<?php if(  $testimonial['profile'] ) { ?>
							
							<?php } ?>
							<?php if( $testimonial['video_link']) { ?>
							<a class="colorbox-t" href="<?php echo $testimonial['video_link'];?>"><?php echo $this->language->get('text_watch_video_testimonial');?></a>
							<?php } ?>
	 					</div>
	 					<div class="col-sm-9 col-xs-9">
	 						<?php if(  $testimonial['description'] ) { ?>
							<div class="testimonial">
								<div><?php echo $testimonial['description']; ?></div>
							</div>
							<?php } ?>
                           	<br>
							<img src="../image/testibg.png" />
                            <div class="profile">
								<div><?php echo $testimonial['profile']; ?></div>
							</div>
	 					</div>
					</div>
				</div>
				<?php } ?>
				</div>
			<?php } ?>
		</div>
	 		
		<?php if( count($pages) > 1 ){ ?>
		<div class="carousel-controls">
				<a class="carousel-control left" href="#pavtestimonial<?php echo $id;?>" data-slide="prev">&lsaquo;</a>
				<a class="carousel-control right" href="#pavtestimonial<?php echo $id;?>" data-slide="next">&rsaquo;</a>
		</div>
		<?php } ?>
    </div>
	<?php if( count($pages) > 1 ){ ?>
	<script type="text/javascript">
	<!--
		$('#pavtestimonial<?php echo $id;?>').carousel({interval:<?php echo ( $auto_play_mode?$interval:'false') ;?>,auto:<?php echo $auto_play;?>,pause:'hover'});
	-->
	</script>
	<?php } ?>
	<script type="text/javascript"><!--
		$(document).ready(function() {
		  $('.colorbox-t').colorbox({iframe:true, innerWidth:640, innerHeight:390});
		});
//--></script> 
<?php } ?>
