<?php echo $header; ?>
<div id="content">
	<div class="breadcrumb">
		<?php foreach ($breadcrumbs as $breadcrumb) { ?>
			<?php echo $breadcrumb['separator']; ?><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a>
		<?php } ?>
	</div>
	<?php if ($error_warning) { ?>
		<div class="warning"><?php echo $error_warning; ?></div>
	<?php } ?>
	<?php if ($success) { ?>
		<div class="success"><?php echo $success; ?></div>
	<?php } ?>
	<script type="text/javascript" src="view/javascript/jquery/msdropdown/jquery.dd.min.js"></script>
	<link rel="stylesheet" type="text/css" href="view/javascript/jquery/msdropdown/css/msdropdown/dd.css" />

	<script type="text/javascript"><!--
		$(document).ready(function(e) {
		try {
			$("#star-template-dropdown").msDropDown();
			$("#payments").msDropDown();
		} catch(e) { }
		});
	// --></script>
	<style type="text/css">
	.box > .content h2 { border-bottom: 1px dotted #000000; color: #FF802B; font-size: 15px; font-weight: bold; padding-bottom: 3px; text-transform: uppercase; }
	.btn-advanced { -moz-box-shadow:inset 0px 1px 0px 0px #ffffff; -webkit-box-shadow:inset 0px 1px 0px 0px #ffffff; box-shadow:inset 0px 1px 0px 0px #ffffff; background:-webkit-gradient( linear, left top, left bottom, color-stop(0.05, #ededed), color-stop(1, #dfdfdf) ); background:-moz-linear-gradient( center top, #ededed 5%, #dfdfdf 100% ); filter:progid:DXImageTransform.Microsoft.gradient(startColorstr='#ededed', endColorstr='#dfdfdf'); background-color:#ededed; -moz-border-radius:3px; -webkit-border-radius:3px; border-radius:3px; border:1px solid #dcdcdc; display:inline-block; color:#777777; font-family:arial; font-size:11px; font-weight:bold; padding:6px 12px; text-decoration:none; text-shadow:1px 1px 0px #ffffff; }
	.btn-advanced:hover { cursor: pointer; background:-webkit-gradient( linear, left top, left bottom, color-stop(0.05, #dfdfdf), color-stop(1, #ededed) ); background:-moz-linear-gradient( center top, #dfdfdf 5%, #ededed 100% ); filter:progid:DXImageTransform.Microsoft.gradient(startColorstr='#dfdfdf', endColorstr='#ededed'); background-color:#dfdfdf; }
	.btn-advanced:active { cursor: pointer; position:relative; top:1px; }
	</style>
	<h1><?php echo $heading_title; ?></h1>
	<form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form">
	<div class="box">
			<div class="heading">
				<h1><?php echo $heading_general_settings; ?></h1>
				<div class="buttons"><a onclick="$('#form').submit();" class="button"><?php echo $button_save; ?></a><a onclick="location = '<?php echo $cancel; ?>';" class="button"><?php echo $button_cancel; ?></a></div>
			</div>
			<div class="content">
				<table class="form">
					<tr>
						<td><?php echo $entry_public_text_enabled; ?></td>
						<td>
							<input type="radio" name="testimonial_public_text_enabled" value="1" <?php echo ($testimonial_public_text_enabled) ? 'checked="checked"' : ''; ?> /><?php echo $text_enabled; ?>
							<input type="radio" name="testimonial_public_text_enabled" value="0" <?php echo (!$testimonial_public_text_enabled) ? 'checked="checked"' : ''; ?> /><?php echo $text_disabled; ?>
						</td>
					</tr>

					<tr>
						<td><?php echo $entry_private_text_enabled; ?></td>
						<td>
							<input type="radio" name="testimonial_private_text_enabled" value="1" <?php echo ($testimonial_private_text_enabled) ? 'checked="checked"' : ''; ?> /><?php echo $text_enabled; ?>
							<input type="radio" name="testimonial_private_text_enabled" value="0" <?php echo (!$testimonial_private_text_enabled) ? 'checked="checked"' : ''; ?> /><?php echo $text_disabled; ?>
						</td>
					</tr>
					
					<tr>
						<td><?php echo $entry_company_enabled; ?></td>
						<td>
							<input type="radio" name="testimonial_company_enabled" value="1" <?php echo ($testimonial_company_enabled) ? 'checked="checked"' : ''; ?> /><?php echo $text_enabled; ?>
							<input type="radio" name="testimonial_company_enabled" value="0" <?php echo (!$testimonial_company_enabled) ? 'checked="checked"' : ''; ?> /><?php echo $text_disabled; ?>
						</td>
					</tr>

					<tr>
						<td><?php echo $entry_location_enabled; ?></td>
						<td>
							<input type="radio" name="testimonial_location_enabled" value="1" <?php echo ($testimonial_location_enabled) ? 'checked="checked"' : ''; ?> /><?php echo $text_enabled; ?>
							<input type="radio" name="testimonial_location_enabled" value="0" <?php echo (!$testimonial_location_enabled) ? 'checked="checked"' : ''; ?> /><?php echo $text_disabled; ?>
						</td>
					</tr>
					
					<tr>
						<td><?php echo $entry_url_enabled; ?></td>
						<td>
							<input type="radio" name="testimonial_url_enabled" value="1" <?php echo ($testimonial_url_enabled) ? 'checked="checked"' : ''; ?> /><?php echo $text_enabled; ?>
							<input type="radio" name="testimonial_url_enabled" value="0" <?php echo (!$testimonial_url_enabled) ? 'checked="checked"' : ''; ?> /><?php echo $text_disabled; ?>
						</td>
					</tr>

										
					<tr>
						<td><?php echo $entry_email_enabled; ?></td>
						<td>
							<input type="radio" name="testimonial_email_enabled" value="1" <?php echo ($testimonial_email_enabled) ? 'checked="checked"' : ''; ?> /><?php echo $text_enabled; ?>
							<input type="radio" name="testimonial_email_enabled" value="0" <?php echo (!$testimonial_email_enabled) ? 'checked="checked"' : ''; ?> /><?php echo $text_disabled; ?>
						</td>
					</tr>
					
					<tr>
						<td><?php echo $entry_telephone_enabled; ?></td>
						<td>
							<input type="radio" name="testimonial_telephone_enabled" value="1" <?php echo ($testimonial_telephone_enabled) ? 'checked="checked"' : ''; ?> /><?php echo $text_enabled; ?>
							<input type="radio" name="testimonial_telephone_enabled" value="0" <?php echo (!$testimonial_telephone_enabled) ? 'checked="checked"' : ''; ?> /><?php echo $text_disabled; ?>
						</td>
					</tr>

					<tr>
						<td><?php echo $entry_captcha_enabled; ?></td>
						<td>
							<input type="radio" name="testimonial_captcha_enabled" value="1" <?php echo ($testimonial_captcha_enabled) ? 'checked="checked"' : ''; ?> /><?php echo $text_enabled; ?>
							<input type="radio" name="testimonial_captcha_enabled" value="0" <?php echo (!$testimonial_captcha_enabled) ? 'checked="checked"' : ''; ?> /><?php echo $text_disabled; ?>
						</td>
					</tr>

					<tr>
						<td><?php echo $entry_require_login; ?></td>
						<td>
							<input type="radio" name="testimonial_require_login" value="1" <?php echo ($testimonial_require_login) ? 'checked="checked"' : ''; ?> /><?php echo $text_yes; ?>
							<input type="radio" name="testimonial_require_login" value="0" <?php echo (!$testimonial_require_login) ? 'checked="checked"' : ''; ?> /><?php echo $text_no; ?>
						</td>
					</tr>

					<tr>
						<td><?php echo $entry_approval_mode; ?></td>
						<td>
							<input type="radio" name="testimonial_approval_mode" value="1" <?php echo ($testimonial_approval_mode) ? 'checked="checked"' : ''; ?> /><?php echo $text_approval_automatic; ?>
							<input type="radio" name="testimonial_approval_mode" value="0" <?php echo (!$testimonial_approval_mode) ? 'checked="checked"' : ''; ?> /><?php echo $text_approval_manual; ?>
						</td>
					</tr>

					<tr>
						<td><?php echo $entry_star_template; ?></td>
						<td>
							<select id="star-template-dropdown" name="testimonial_star_template"  style="width:270px;">
							<option value="" data-description="<?php echo $text_star_template_choose; ?>"><?php echo $text_star_template; ?></option>
							<?php foreach ($star_templates as $star_template) { ?>
								<option value="<?php echo $star_template['name']; ?>" data-image="<?php echo HTTP_CATALOG . 'image/testimonials/' . $star_template['name'] . '/preview-icon.png' ?>" data-description="<?php echo $star_template['subtext']; ?>"<?php echo ($star_template['name'] == $testimonial_star_template) ? ' selected="selected"' : ''; ?>><?php echo $star_template['name']; ?></option>
							<?php } ?>
							</select>
						</td>
					</tr>

					<tr>
						<td><?php echo $entry_star_size; ?></td>
						<td>
							<select id="star-template-size" name="testimonial_star_size"  style="width:270px;">
							<?php foreach ($star_sizes as $star_size) { ?>
								<option value="<?php echo $star_size['value']; ?>"<?php echo ($testimonial_star_size == $star_size['value']) ? 'selected="selected"' : ''; ?>><?php echo $star_size['name']; ?></option>
							<?php } ?>
							</select>
						</td>
					</tr>
		
					<tr>
						<td><?php echo $entry_language_display; ?></td>
						<td>
							<select name="testimonial_language_active_only">
								<option value="1"<?php echo ($testimonial_language_active_only) ? ' selected="selected"' : ''; ?>><?php echo $text_language_active; ?></option>
								<option value="0"<?php echo (!$testimonial_language_active_only) ? ' selected="selected"' : ''; ?>><?php echo $text_language_all; ?></option>
							</select>
						</td>
					</tr>

					<tr>
						<td><?php echo $entry_per_page; ?></td>
						<td><input type="text" name="testimonial_per_page" value="<?php echo $testimonial_per_page; ?>" size="2" /></td>
					</tr>
					
				</table>
			</div>
			<div style="height:25px;">&nbsp;</div>
			<div class="heading">
				<h1><?php echo $heading_search_settings; ?></h1>
			</div>
			<div class="content">
				<table class="form">
		
					<tr>
						<td><?php echo $entry_optimization_type; ?></td>
						<td><select name="testimonial_optimization_type">
						<?php if ($testimonial_optimization_type) { ?>
						<option value="1" selected="selected"><?php echo $text_business; ?></option>
						<option value="0"><?php echo $text_website; ?></option>
						<?php } else { ?>
						<option value="1"><?php echo $text_business; ?></option>
						<option value="0" selected="selected"><?php echo $text_website; ?></option>
						<?php } ?>
						</select></td>
					</tr>
	  
					<tr>
						<td><?php echo $entry_company; ?></td>
						<td><input type="text" name="testimonial_company" value="<?php echo $testimonial_company; ?>" size="40" /></td>
					</tr>
					<tr>
						<td><?php echo $entry_address1; ?></td>
						<td><input type="text" name="testimonial_address1" value="<?php echo $testimonial_address1; ?>" size="40" /></td>
					</tr>
					<tr>
						<td><?php echo $entry_address2; ?></td>
						<td><input type="text" name="testimonial_address2" value="<?php echo $testimonial_address2; ?>" size="40" /></td>
					</tr>
					<tr>
						<td><?php echo $entry_city; ?></td>
						<td><input type="text" name="testimonial_city" value="<?php echo $testimonial_city; ?>" size="40" /></td>
					</tr>
					<tr>
						<td><?php echo $entry_state; ?></td>
						<td><input type="text" name="testimonial_state" value="<?php echo $testimonial_state; ?>" size="40" /></td>
					</tr>
					<tr>
						<td><?php echo $entry_postal_code; ?></td>
						<td><input type="text" name="testimonial_postal_code" value="<?php echo $testimonial_postal_code; ?>" size="40" /></td>
					</tr>
					<tr>
						<td><?php echo $entry_country; ?></td>
						<td><input type="text" name="testimonial_country" value="<?php echo $testimonial_country; ?>" size="40" /></td>
					</tr>
					<tr>
						<td><?php echo $entry_telephone; ?></td>
						<td><input type="text" name="testimonial_telephone" value="<?php echo $testimonial_telephone; ?>" size="40" /></td>
					</tr>
					<tr>
						<td><?php echo $entry_website; ?></td>
						<td><input type="text" name="testimonial_website" value="<?php echo $testimonial_website; ?>" size="40" /></td>
					</tr>
				</table>
				
				<h2><?php echo $heading_price_of_goods; ?></h2>
				<table class="form">
					<tr>
						<td><?php echo $entry_display_price; ?></td>
						<td>
							<input type="radio" name="testimonial_display_price" value="1" <?php echo ($testimonial_display_price) ? 'checked="checked"' : ''; ?> /><?php echo $text_yes; ?>
							<input type="radio" name="testimonial_display_price" value="0" <?php echo (!$testimonial_display_price) ? 'checked="checked"' : ''; ?> /><?php echo $text_no; ?>
						</td>
					</tr>
					<tr>
						<td><?php echo $entry_price_from; ?></td>
						<td><input type="text" name="testimonial_price_from" value="<?php echo $testimonial_price_from; ?>" size="3" /></td>
					</tr>
					<tr>
						<td><?php echo $entry_price_to; ?></td>
						<td><input type="text" name="testimonial_price_to" value="<?php echo $testimonial_price_to; ?>" size="3" /></td>
					</tr>
				</table>
			</div>
			<div style="height:25px;">&nbsp;</div>
			<div class="heading">
				<h1><?php echo $heading_page_settings; ?></h1>
			</div>
			<div class="content">
			
				<div id="languages" class="htabs">
					<?php foreach ($languages as $language) { ?>
						<a href="#language<?php echo $language['language_id']; ?>"><img src="view/image/flags/<?php echo $language['image']; ?>" title="<?php echo $language['name']; ?>" /> <?php echo $language['name']; ?></a>
					<?php } ?>
				</div>
				<?php foreach ($languages as $language) { ?>
					<div id="language<?php echo $language['language_id']; ?>">
						<table class="form">
							<tr>
								<td><?php echo $entry_page_title; ?></td>
								<td><input type="text" name="page_content[<?php echo $language['language_id']; ?>][page_title]" value="<?php echo isset($page_content[$language['language_id']]) ? $page_content[$language['language_id']]['page_title'] : ''; ?>" size="80" /></td>
							</tr>
							<tr>
								<td><?php echo $entry_meta_description; ?></td>
								<td><textarea name="page_content[<?php echo $language['language_id']; ?>][meta_description]" cols="50" rows="4"><?php echo isset($page_content[$language['language_id']]) ? $page_content[$language['language_id']]['meta_description'] : ''; ?></textarea></td>
							</tr>
							<tr>
								<td><?php echo $entry_meta_keywords; ?></td>
								<td><textarea name="page_content[<?php echo $language['language_id']; ?>][meta_keywords]" cols="50" rows="4"><?php echo isset($page_content[$language['language_id']]) ? $page_content[$language['language_id']]['meta_keywords'] : ''; ?></textarea></td>
							</tr>
							<tr>
								<td><?php echo $entry_heading_title; ?></td>
								<td><input type="text" name="page_content[<?php echo $language['language_id']; ?>][heading_title]" value="<?php echo isset($page_content[$language['language_id']]) ? $page_content[$language['language_id']]['heading_title'] : ''; ?>" size="80" /></td>
							</tr>
							<tr>
								<td valign="top"><?php echo $entry_heading_content; ?></td>
								<td><textarea name="page_content[<?php echo $language['language_id']; ?>][heading_content]" id="testimonial_heading_content<?php echo $language['language_id']; ?>"><?php echo isset($page_content[$language['language_id']]) ? $page_content[$language['language_id']]['heading_content'] : ''; ?></textarea></td>
							</tr>
							<tr>
								<td><?php echo $entry_form_title; ?></td>
								<td><input type="text" name="page_content[<?php echo $language['language_id']; ?>][form_title]" value="<?php echo isset($page_content[$language['language_id']]) ? $page_content[$language['language_id']]['form_title'] : ''; ?>" size="80" /></td>
							</tr>
							<tr>
								<td valign="top"><?php echo $entry_form_content; ?></td>
								<td><textarea name="page_content[<?php echo $language['language_id']; ?>][form_content]" id="testimonial_form_content<?php echo $language['language_id']; ?>"><?php echo isset($page_content[$language['language_id']]) ? $page_content[$language['language_id']]['form_content'] : ''; ?></textarea></td>
							</tr>							
						</table>
					</div>
				<?php } ?>
			</div>
			<div style="height:25px;">&nbsp;</div>
			<div class="heading">
				<h1><?php echo $heading_email_reminder; ?></h1>
			</div>
			<div class="content">
				<table class="form">
					<tr>
						<td><?php echo $entry_email_reminder_enabled; ?></td>
						<td>
							<input type="radio" name="testimonial_email_reminder_enabled" value="1" <?php echo ($testimonial_email_reminder_enabled) ? 'checked="checked"' : ''; ?> /><?php echo $text_yes; ?>
							<input type="radio" name="testimonial_email_reminder_enabled" value="0" <?php echo (!$testimonial_email_reminder_enabled) ? 'checked="checked"' : ''; ?> /><?php echo $text_no; ?>
						</td>
					</tr>
					<tr>
						<td><?php echo $entry_email_status; ?></td>
						<td><div class="scrollbox">
							<?php $class = 'odd'; ?>
							<?php foreach ($order_statuses as $order_status) { ?>
								<?php $class = ($class == 'even' ? 'odd' : 'even'); ?>
								<div class="<?php echo $class; ?>">
									<input type="checkbox" name="testimonial_email_status[]" value="<?php echo $order_status['order_status_id']; ?>" <?php echo (in_array($order_status['order_status_id'], $testimonial_email_status)) ? 'checked="checked"' : ''; ?> />
									<?php echo $order_status['name']; ?>
								</div>
							<?php } ?>
						</div></td>
					</tr>
					<tr>
						<td><?php echo $entry_email_date; ?></td>
						<td>
							<input type="radio" name="testimonial_email_date" value="0" <?php echo (!(int)$testimonial_email_date) ? 'checked="checked"' : ''; ?> /><?php echo $text_date_created; ?>
							<input type="radio" name="testimonial_email_date" value="1" <?php echo ((int)$testimonial_email_date) ? 'checked="checked"' : ''; ?> /><?php echo $text_date_modified; ?>
						</td>
					</tr>
					<tr>
						<td><?php echo $entry_email_days; ?></td>
						<td>
							<select name="testimonial_email_days">
							<?php for ($i=1; $i<=60; $i++) { ?>
								<option value="<?php echo $i; ?>"<?php echo ($i == $testimonial_email_days) ? ' selected="selected"' : ''; ?>><?php echo $i; ?></option>
							<?php } ?>
							</select>
						</td>
					</tr>
				</table>
				<div id="langemail" class="htabs">
					<?php foreach ($languages as $language) { ?>
						<a href="#langemail<?php echo $language['language_id']; ?>"><img src="view/image/flags/<?php echo $language['image']; ?>" title="<?php echo $language['name']; ?>" /> <?php echo $language['name']; ?></a>
					<?php } ?>
				</div>
				<?php foreach ($languages as $language) { ?>
					<div id="langemail<?php echo $language['language_id']; ?>">
						<table class="form">
							<tr>
								<td><?php echo $entry_email_subject; ?></td>
								<td><input type="text" name="page_content[<?php echo $language['language_id']; ?>][email_subject]" value="<?php echo isset($page_content[$language['language_id']]) ? $page_content[$language['language_id']]['email_subject'] : ''; ?>" size="80" /></td>
							</tr>
							<tr>
								<td valign="top"><?php echo $entry_email_content; ?></td>
								<td><textarea name="page_content[<?php echo $language['language_id']; ?>][email_content]" id="testimonial_email_content<?php echo $language['language_id']; ?>"  cols="90" rows="8"><?php echo isset($page_content[$language['language_id']]) ? $page_content[$language['language_id']]['email_content'] : ''; ?></textarea><?php echo $text_email_variables; ?></td>
							</tr>
						</table>
					</div>
				<?php } ?>
				<table class="form">
					<tr>
						<td><?php echo $entry_email_test; ?></td>
						<td>
							<input type="text" name="testimonial_email_test" value="" size="40" />
							<button class="btn-advanced" onclick="this.form.action='index.php?route=catalog/testimonial/sendtestemail&token=<?php echo $this->session->data['token']; ?>'; this.form.submit();"><?php echo $text_email_send_test; ?></button>
						</td>
					</tr>				
					<tr>
						<td><?php echo $entry_email_cron; ?></td>
						<td><?php echo html_entity_decode($testimonial_email_cron); ?><textarea style="visibility:hidden;display:none;" name="testimonial_email_cron"><?php echo $testimonial_email_cron; ?></textarea></td>
					</tr>				
				</table>
			</div>
		</form>
	</div>
</div>
<script type="text/javascript" src="view/javascript/ckeditor/ckeditor.js"></script> 
<script type="text/javascript"><!--
<?php foreach ($languages as $language) { ?>
CKEDITOR.replace('testimonial_heading_content<?php echo $language['language_id']; ?>', {
	filebrowserBrowseUrl: 'index.php?route=common/filemanager&token=<?php echo $this->session->data['token']; ?>',
	filebrowserImageBrowseUrl: 'index.php?route=common/filemanager&token=<?php echo $this->session->data['token']; ?>',
	filebrowserFlashBrowseUrl: 'index.php?route=common/filemanager&token=<?php echo $this->session->data['token']; ?>',
	filebrowserUploadUrl: 'index.php?route=common/filemanager&token=<?php echo $this->session->data['token']; ?>',
	filebrowserImageUploadUrl: 'index.php?route=common/filemanager&token=<?php echo $this->session->data['token']; ?>',
	filebrowserFlashUploadUrl: 'index.php?route=common/filemanager&token=<?php echo $this->session->data['token']; ?>'
});
CKEDITOR.replace('testimonial_form_content<?php echo $language['language_id']; ?>', {
	filebrowserBrowseUrl: 'index.php?route=common/filemanager&token=<?php echo $this->session->data['token']; ?>',
	filebrowserImageBrowseUrl: 'index.php?route=common/filemanager&token=<?php echo $this->session->data['token']; ?>',
	filebrowserFlashBrowseUrl: 'index.php?route=common/filemanager&token=<?php echo $this->session->data['token']; ?>',
	filebrowserUploadUrl: 'index.php?route=common/filemanager&token=<?php echo $this->session->data['token']; ?>',
	filebrowserImageUploadUrl: 'index.php?route=common/filemanager&token=<?php echo $this->session->data['token']; ?>',
	filebrowserFlashUploadUrl: 'index.php?route=common/filemanager&token=<?php echo $this->session->data['token']; ?>'
});
<?php } ?>
//--></script> 
<script type="text/javascript"><!--
$('#languages a').tabs(); 
$('#langemail a').tabs(); 
//--></script> 
<?php echo $footer; ?>