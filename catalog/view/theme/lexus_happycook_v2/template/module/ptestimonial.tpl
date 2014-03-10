<div class="box">
	<div class="box-heading"><?php echo $testimonial_title; ?></div>
	<div class="box-content">
		<div class="box-product">
			<?php foreach ($testimonials as $testimonial) { ?>
				<table class="content" width="100%">
					<tr>
						<td style="text-align: left;">
							<div class="hreview" style="text-align:left; font-size:10px; margin-bottom:12px; padding-bottom:4px;border-bottom:dotted silver 1px;">
								<h3 class="summary"><?php echo $testimonial['title']; ?></h3>
								<blockquote class="description" style="margin:0px; padding:0px;"><?php echo $testimonial['description']; ?></blockquote><br /><br />
								<?php if ($testimonial['rating']) { ?>
									<?php if ($settings['star_template'] && $settings['star_size']) { ?>
										<img src="image/testimonials/<?php echo $settings['star_template'] . '/' . $settings['star_size'] . '/'; ?>stars-<?php echo $testimonial['rating'] . '.png'; ?>" alt="<?php echo $testimonial['rating_text']; ?>" style="margin-top: 2px;" />
									<?php } else { ?>
										<img src="catalog/view/theme/default/image/stars-<?php echo $testimonial['rating'] . '.png'; ?>" alt="<?php echo $testimonial['rating_text']; ?>" style="margin-top: 2px;" />
									<?php } ?>
								<?php } ?><br />
								<strong><?php echo $testimonial['author']; ?></strong>
								<?php if ($settings['company_enabled']) echo '<br />'.$testimonial['company']; ?>
								<?php if ($testimonial['read_more_url']) { ?><div align="right"><a href="<?php echo $testimonial['read_more_url'] ?>"><span><?php echo $text_keep_reading; ?></span></a></div><?php } ?>
							</div>
						</td>
					</tr>
				</table>
			<?php } ?>
			<?php if ($settings['view_all_enabled']) { ?>
			<table class="content" width="100%">
				<tr><td>
					<div width=100% align="right" style="margin-top:0px;margin-left:8px;"><a href="<?php echo $testimonials_url; ?>"><span><?php echo $text_view_all; ?></span></a>  </div>
				</td></tr>
			</table>
			<?php } ?>
		</div>
	</div>
</div>

