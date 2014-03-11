<?php 
	$span = 12/$cols; 
?>

<div class="box pav-block bloglatest">
	<h2 class="h2head"><span class="dot" style="background-color:#ededed !important;"><?php echo $heading_title; ?></span><span class="divider"></span><a href="#" class="blg-vw-all">View All</a></h2>
    <?php if( trim($message) ) { ?>
				<div class="box-description"><?php echo $message;?></div>
				<?php } ?>
		<?php if( !empty($blogs) ) { ?>
		<div class="pavblog-latest clearfix">
			<?php foreach( $blogs as $key => $blog ) { ?>
			<?php if( $key++%$cols == 0 ) { ?>
			<div class="row">
			<?php } ?>
				<div class="col-lg-<?php echo $span;?> pavblock">
					<div class="blog-item">					
						<div class="blog-body clearfix" style="margin:50px 0 0 0;">
							
							<div class="image clearfix">
								<?php if( $blog['thumb']  )  { ?>
									<img src="<?php echo $blog['thumb'];?>" title="<?php echo $blog['title'];?>" align="left"/>
								<?php } ?>
							</div>
							<div class="group-blog">
								<div class="blog-title">
									<a href="<?php echo $blog['link'];?>" title="<?php echo $blog['title'];?>"><?php echo $blog['title'];?></a>
								</div>
								<span class="comment_count"><span><?php echo $this->language->get("text_comment_count");?></span> <?php echo $blog['comment_count'];?></span>
								<div class="description">
										<?php $blog['description'] = strip_tags($blog['description']); ?>
									<?php echo utf8_substr( $blog['description'],0, 70 );?>...
								</div>

								<p>
									<a href="<?php echo $blog['link'];?>" class="readmore rd-more pull-right"><?php echo $this->language->get('text_readmore');?></a>
								</p>
                                <div class="dotted-line"></div>
							</div>
							
						</div>	
					</div>
				</div>
			<?php if( ( $key%$cols==0 || $key == count($blogs)) ){  ?>			
			</div>
			<?php } ?>
			<?php } ?>
		</div>
		<?php } ?>
	</div>

