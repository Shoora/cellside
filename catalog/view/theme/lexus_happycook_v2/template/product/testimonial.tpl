<?php echo $header; ?><?php echo $column_left; ?><?php echo $column_right; ?>
<div class="container">
	<div id="content"><?php echo $content_top; ?>
		<!-- <div class="breadcrumb">
			<?php foreach ($breadcrumbs as $breadcrumb) { ?>
				<?php echo $breadcrumb['separator']; ?><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a>
			<?php } ?>
		</div> -->
		<h1><?php echo $heading_title; ?></h1>
		<div><?php echo $page_content['heading_content']; ?></div>
		<?php if ($testimonials) { ?>
			<div class="hreview-aggregate" style="display: none;">
				<span class="type">business</span>
				<div class="item vcard">
					<a class="url fn org" href="<?php echo $website['website']; ?>"><?php echo $website['company']; ?></a>
					<div class="tel"><?php echo $website['telephone']; ?></div>
					<div class="adr">
						<div class="street-address"><?php echo $website['address']; ?></div>
						<span class="locality"><?php echo $website['city']; ?></span>
						<span class="region"><?php echo $website['state']; ?></span>, <span class="postal-code"><?php echo $website['postal_code']; ?></span>
						<div class="country-name"><?php echo $website['country']; ?></div>
					</div>
				   <span class="rating">
					  <span class="average"><?php echo $website['rating']; ?></span> out of <span class="best">5</span>
				   </span>
				   based on <span class="count"><?php echo $website['total']; ?></span> reviews.
				</div>
			</div>
		<?php } ?>
		<div class="middle">
			<?php if ($testimonials) { ?>
				<?php foreach ($testimonials as $testimonial) { ?>
					<table class="content testimonial" width="100%">
						<tr>
							<td style="text-align: left;">
								<div class="hreview">
									<h3 class="summary"><?php echo $testimonial['title']; ?></h3>
									<blockquote class="description" style="margin:0px; padding:0px;"><?php echo $testimonial['description']; ?></blockquote>
									<?php if ($testimonial['rating']) { ?>
										<abbr class="rating" title="<?php echo $testimonial['rating'] ?>"></abbr>
										<?php if ($settings['star_template'] && $settings['star_size']) { ?>
											<img src="image/testimonials/<?php echo $settings['star_template'] . '/' . $settings['star_size'] . '/'; ?>stars-<?php echo $testimonial['rating'] . '.png'; ?>" alt="<?php echo $testimonial['rating_text']; ?>" style="margin-top: 2px;" />
										<?php } else { ?>
											<img src="catalog/view/theme/default/image/stars-<?php echo $testimonial['rating'] . '.png'; ?>" alt="<?php echo $testimonial['rating_text']; ?>" style="margin-top: 2px;" />
										<?php } ?>
									<?php } ?><br />
									<strong><?php echo $testimonial['author']; ?></strong>
									<?php if ($settings['company_enabled'] && !empty($testimonial['company'])) echo '<br />'.$testimonial['company']; ?>
									<?php if ($settings['location_enabled'] && !empty($testimonial['location'])) echo '<br />'.$testimonial['location']; ?>
									<?php if ($settings['url_enabled'] && !empty($testimonial['url'])) { ?>
										<br /><a href="http://<?php echo $testimonial['url']; ?>" target="_new" /><?php echo $testimonial['url']; ?></a>
									<?php } ?>
								</div>
							</td>
						</tr>
					</table>
				<?php } ?>
				<?php if ( isset($pagination)) { ?>
					<div class="pagination"><?php echo $pagination;?></div>
				<?php }?>
			<?php } ?>
			
			<a name="form"></a>
			<div class="testimonial-form">
				<div style="padding-top: 30px;"><h1><?php echo $page_content['form_title']; ?></h1></div>
				<div><?php echo $page_content['form_content']; ?></div>
				<?php if($settings['require_login'] && !$this->customer->isLogged()) { ?>
					<div class="content">
						<?php echo $text_login_required; ?>
					</div>
				<?php } elseif (isset($success) && $success) { ?>
					<div id="#notification" style="margin-bottom:20px;"><span class="success"><?php echo $text_success_message; ?></span></div>
					<div class="content">
					</div>
				<?php } else { ?>
					<?php if ($error_has_errors) { ?>
						<div id="#notification" style="margin-bottom:20px;"><span class="warning"><?php echo $error_has_errors; ?></span></div>
					<?php } ?>
					
					<form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="testimonial">
						<div class="content">
							<table width="100%">
								<tr>
									<td><?php echo $entry_title ?><span class="required">*</span><br />
										<input type="text" name="title" value="<?php echo $title; ?>" size="90" class="inputPen"/>
										<?php if ($error_title) { ?>
											<span class="error"><?php echo $error_title; ?></span>
										<?php } ?>
									</td>
								</tr>
								<?php if($settings['public_text_enabled']) { ?>
								<tr>
									<td><?php echo $entry_public_text; ?><br />
										<textarea name="public_text" style="width: 100%;" rows="10"><?php echo $public_text; ?></textarea><br />
										<?php if ($error_public_text) { ?>
											<span class="error"><?php echo $error_enquiry; ?></span>
										<?php } ?>
									</td>
								</tr>
								<?php } ?>
								<?php if ($settings['private_text_enabled']) { ?>
								<tr>
									<td><?php echo $entry_private_text; ?><br />
										<textarea name="private_text" style="width: 100%;" rows="10"><?php echo $private_text; ?></textarea><br />
										<?php if ($error_private_text) { ?>
											<span class="error"><?php echo $error_private_text; ?></span>
										<?php } ?>
									</td>
								</tr>
								<?php } ?>
								<tr>
									<td><?php echo $entry_author ?><span class="required">*</span><br />
										<input type="text" name="author" value="<?php echo $author; ?>" class="inputPen"/>
										<?php if ($error_author) { ?>
											<span class="error"><?php echo $error_author; ?></span>
										<?php } ?>
									</td>
								</tr>
								<?php if ($settings['company_enabled']) { ?>
								<tr>
									<td><?php echo $entry_company ?><br />
										<input type="text" name="company" value="<?php echo $company; ?>" class="inputPen"/>
									</td>
								</tr>
								<?php } ?>
								<?php if ($settings['location_enabled']) { ?>
								<tr>
									<td><?php echo $entry_location; ?><br />
										<input type="text" name="location" value="<?php echo $location; ?>" class="inputPen"/>
									</td>
								</tr>
								<?php } ?>
								<?php if ($settings['url_enabled']) { ?>
								<tr>
									<td><?php echo $entry_url; ?><br />
										<input type="text" name="url" value="<?php echo $url; ?>" class="inputPen"/>
									</td>
								</tr>
								<?php } ?>
								<?php if ($settings['telephone_enabled']) { ?>
								<tr>
									<td><?php echo $entry_telephone; ?><br />
										<input type="text" name="telephone" value="<?php echo $telephone; ?>" class="inputPen"/>
									</td>
								</tr>
								<?php } ?>
								<?php if ($settings['email_enabled']) { ?>
								<tr>
									<td><?php echo $entry_email; ?><br />
										<input type="text" name="email" value="<?php echo $email; ?>" class="inputPen"/>
									</td>
								</tr>
								<?php } ?>
								
								<tr>
									<td><br><?php echo $entry_rating; ?><span class="required">*</span><br /><span><?php echo $entry_bad; ?></span>&nbsp;
										<input type="radio" name="rating" value="1" style="margin: 0;" <?php if ( $rating == 1 ) echo 'checked="checked"';?> />&nbsp;
										<input type="radio" name="rating" value="2" style="margin: 0;" <?php if ( $rating == 2 ) echo 'checked="checked"';?> />&nbsp;
										<input type="radio" name="rating" value="3" style="margin: 0;" <?php if ( $rating == 2 ) echo 'checked="checked"';?> />&nbsp;
										<input type="radio" name="rating" value="4" style="margin: 0;" <?php if ( $rating == 4 ) echo 'checked="checked"';?> />&nbsp;
										<input type="radio" name="rating" value="5" style="margin: 0;" <?php if ( !$rating ) echo 'checked="checked"';?> />
										&nbsp; <span><?php echo $entry_good; ?></span><br /><br>
									</td>
								</tr>

								<?php if ($settings['captcha_enabled']) { ?>
								<tr>
									<td><?php echo $entry_captcha; ?><span class="required">*</span> <br />
									<input type="text" name="captcha" value="<?php echo $captcha; ?>" class="inputPen"/><br>
									<?php if ($error_captcha) { ?>
										<span class="error"><?php echo $error_captcha; ?></span>
									<?php } ?>
									<br />
									<img src="index.php?route=information/contact/captcha" /></td>
								</tr>
								<?php } ?>
							</table>
						</div>
						<div class="buttons">
							<table>
								<tr>
									<td align="right"><a onclick="$('#testimonial').submit();" class="button"><span><?php echo $button_submit_testimonial; ?></span></a></td>
								</tr>
							</table>
						</div>
					</form>
				<?php } ?>
			</div>
		</div>
		<?php echo $content_bottom; ?>
	</div>
</div>
<?php echo $footer; ?>
<script>
	$('#offcanvas-container').addClass('bubble_bg');
</script>