<?php echo $header; ?>
<script type="text/javascript" src="view/javascript/jquery/msdropdown/jquery.dd.min.js"></script>
<link rel="stylesheet" type="text/css" href="view/javascript/jquery/msdropdown/css/msdropdown/dd.css" />

<div id="content">
	<div class="breadcrumb">
		<?php foreach ($breadcrumbs as $breadcrumb) { ?>
			<?php echo $breadcrumb['separator']; ?><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a>
		<?php } ?>
	</div>
	<?php if ($error_warning) { ?>
		<div class="warning"><?php echo $error_warning; ?></div>
	<?php } ?>
	<style type="text/css">
	.box > .content h2 { border-bottom: 1px dotted #000000; color: #FF802B; font-size: 15px; font-weight: bold; padding-bottom: 3px; text-transform: uppercase; }
	</style>

	<div class="box">
		<div class="heading">
			<h1><img src="view/image/module.png" alt="" /> <?php echo $heading_title; ?></h1>
			<div class="buttons"><a onclick="$('#form').submit();" class="button"><?php echo $button_save; ?></a><a onclick="location = '<?php echo $cancel; ?>';" class="button"><?php echo $button_cancel; ?></a></div>
		</div>
		<div class="content">
			<form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form">
				<div class="vtabs">
					<?php $module_row = 1; ?>
					<?php foreach ($modules as $module) { ?>
						<a href="#tab-module-<?php echo $module_row; ?>" id="module-<?php echo $module_row; ?>"><?php echo $tab_module . ' ' . $module_row; ?>&nbsp;<img src="view/image/delete.png" alt="" onclick="$('.vtabs a:first').trigger('click'); $('#module-<?php echo $module_row; ?>').remove(); $('#tab-module-<?php echo $module_row; ?>').remove(); return false;" /></a>
						<?php $module_row++; ?>
					<?php } ?>
					
					<span id="module-add"><?php echo $button_add_module; ?>&nbsp;<img src="view/image/add.png" alt="" onclick="addModule();" /></span> 
				</div>
				
				
				<?php $module_row = 1; ?>
				<?php foreach ($modules as $module) { ?>
					<div id="tab-module-<?php echo $module_row; ?>" class="vtabs-content">
						<h2><?php echo $heading_display_settings; ?></h2>
						<table class="form">
							<tr>
								<td><?php echo $entry_display_style; ?></td>
								<td><select name="ptestimonial_module[<?php echo $module_row; ?>][display_style]">
									<option value="1" <?php echo ($module['display_style']) ? 'selected="selected"' : '' ?>><?php echo $text_display_title; ?></option>
									<option value="0" <?php echo (!$module['display_style']) ? 'selected="selected"' : '' ?>><?php echo $text_display_title_description; ?></option>
								</select></td>
							</tr>
							<tr>
								<td><?php echo $entry_description_length; ?></td>
								<td><input type="text" name="ptestimonial_module[<?php echo $module_row; ?>][description_length]" value="<?php echo $module['description_length']; ?>" size="2" /></td>
							</tr>
							<tr>
								<td><?php echo $entry_keep_reading; ?></td>
								<td>
									<input type="radio" name="ptestimonial_module[<?php echo $module_row; ?>][read_more]" value="1"<?php echo ($module['read_more']) ? ' checked="checked"' : '' ?> /><?php echo $text_yes; ?>
									<input type="radio" name="ptestimonial_module[<?php echo $module_row; ?>][read_more]" value="0"<?php echo (!$module['read_more']) ? ' checked="checked"' : '' ?> /><?php echo $text_no; ?>
								</td>
							</tr>
							<tr>
								<td><?php echo $entry_view_all; ?></td>
								<td>
									<input type="radio" name="ptestimonial_module[<?php echo $module_row; ?>][view_all]" value="1"<?php echo ($module['view_all']) ? ' checked="checked"' : '' ?> /><?php echo $text_yes; ?>
									<input type="radio" name="ptestimonial_module[<?php echo $module_row; ?>][view_all]" value="0"<?php echo (!$module['view_all']) ? ' checked="checked"' : '' ?> /><?php echo $text_no; ?>
								</td>
							</tr>
							<tr>
								<td><?php echo $entry_display_order; ?></td>
								<td><select name="ptestimonial_module[<?php echo $module_row; ?>][display_order]">
									<option value="1" <?php echo ($module['display_style']) ? 'selected="selected"' : '' ?>><?php echo $text_display_order_random; ?></option>
									<option value="0" <?php echo (!$module['display_style']) ? 'selected="selected"' : '' ?>><?php echo $text_display_order_latest; ?></option>
								</select></td>
							</tr>
							
							<tr>
								<td><?php echo $entry_display_featured; ?></td>
								<td>
									<input type="radio" name="ptestimonial_module[<?php echo $module_row; ?>][featured_only]" value="1"<?php echo ($module['featured_only']) ? ' checked="checked"' : '' ?> /><?php echo $text_yes; ?>
									<input type="radio" name="ptestimonial_module[<?php echo $module_row; ?>][featured_only]" value="0"<?php echo (!$module['featured_only']) ? ' checked="checked"' : '' ?> /><?php echo $text_no; ?>
								</td>
							</tr>
							
							<tr>
								<td><?php echo $entry_display_stars; ?></td>
								<td>
									<input type="radio" name="ptestimonial_module[<?php echo $module_row; ?>][show_stars]" value="1"<?php echo ($module['show_stars']) ? ' checked="checked"' : '' ?> /><?php echo $text_yes; ?>
									<input type="radio" name="ptestimonial_module[<?php echo $module_row; ?>][show_stars]" value="0"<?php echo (!$module['show_stars']) ? ' checked="checked"' : '' ?> /><?php echo $text_no; ?>
								</td>
							</tr>
							
							<tr>
								<td><?php echo $entry_star_template; ?></td>
								<td>
									<select id="star-template-dropdown-<?php echo $module_row; ?>" name="ptestimonial_module[<?php echo $module_row; ?>][star_template]"  style="width:270px;">
									<option value="" data-description="<?php echo $text_star_template_choose; ?>"><?php echo $text_star_template; ?></option>
									<?php foreach ($star_templates as $star_template) { ?>
										<option value="<?php echo $star_template['name']; ?>" data-image="<?php echo HTTP_CATALOG . 'image/testimonials/' . $star_template['name'] . '/preview-icon.png' ?>" data-description="<?php echo $star_template['subtext']; ?>"<?php echo ($star_template['name'] == $module['star_template']) ? ' selected="selected"' : ''; ?>]><?php echo $star_template['name']; ?></option>
									<?php } ?>
									</select>
								</td>
							</tr>
							<script type="text/javascript"><!--
								$(document).ready(function(e) {
									try {
										$("#star-template-dropdown-<?php echo $module_row; ?>").msDropDown();
									} catch(e) { }
								});
							// --></script>

							<tr>
								<td><?php echo $entry_star_size; ?></td>
								<td>
									<select id="star-size-dropdown" name="ptestimonial_module[<?php echo $module_row; ?>][star_size]"  style="width:270px;">
									<?php foreach ($star_sizes as $star_size) { ?>
										<option value="<?php echo $star_size['value']; ?>"<?php echo ($star_size['value'] == $module['star_size']) ? ' selected="selected"' : ''; ?>]><?php echo $star_size['name']; ?></option>
									<?php } ?>
									</select>
								</td>
							</tr>
							
							<tr>
								<td><?php echo $entry_limit; ?></td>
								<td><input type="text" name="ptestimonial_module[<?php echo $module_row; ?>][testimonial_limit]" value="<?php echo $module['testimonial_limit']; ?>" size="2" /></td>
							</tr>
							
						</table>
						
						<h2><?php echo $heading_layout_template; ?></h2>
						<table class="form">
							<tr>
								<td><?php echo $entry_layout; ?></td>
								<td><select name="ptestimonial_module[<?php echo $module_row; ?>][layout_id]">
								<?php foreach ($layouts as $layout) { ?>
									<option value="<?php echo $layout['layout_id']; ?>" <?php echo ($layout['layout_id'] == $module['layout_id']) ? 'selected="selected"' : '' ?>><?php echo $layout['name']; ?></option>
								<?php } ?>
								</select></td>
							</tr>
						
							<tr>
								<td><?php echo $entry_position; ?></td>
								<td><select name="ptestimonial_module[<?php echo $module_row; ?>][position]">
									<option value="content_top" <?php echo ($module['position'] == 'content_top') ? 'selected="selected"' : '' ?>><?php echo $text_content_top; ?></option>
									<option value="content_bottom" <?php echo ($module['position'] == 'content_bottom') ? 'selected="selected"' : '' ?>><?php echo $text_content_bottom; ?></option>
									<option value="column_left" <?php echo ($module['position'] == 'column_left') ? 'selected="selected"' : '' ?>><?php echo $text_column_left; ?></option>
									<option value="column_right" <?php echo ($module['position'] == 'column_right') ? 'selected="selected"' : '' ?>><?php echo $text_column_right; ?></option>
								</select></td>
							</tr>
						
							<tr>
								<td><?php echo $entry_status; ?></td>
								<td><select name="ptestimonial_module[<?php echo $module_row; ?>][status]">
									<option value="1" <?php echo ($module['status']) ? 'selected="selected"' : '' ?>><?php echo $text_enabled; ?></option>
									<option value="0" <?php echo (!$module['status']) ? 'selected="selected"' : '' ?>><?php echo $text_disabled; ?></option>
								</select></td>
							</tr>
						
							<tr>
								<td><?php echo $entry_sort_order; ?></td>
								<td><input type="text" name="ptestimonial_module[<?php echo $module_row; ?>][sort_order]" value="<?php echo $module['sort_order']; ?>" size="3" /></td>
							</tr>						
						</table>
						
						<h2><?php echo $heading_language_specific; ?></h2>
						<div>
							<div id="language-<?php echo $module_row; ?>" class="htabs">
								<?php foreach ($languages as $language) { ?>
									<a href="#tab-language-<?php echo $module_row; ?>-<?php echo $language['language_id']; ?>"><img src="view/image/flags/<?php echo $language['image']; ?>" title="<?php echo $language['name']; ?>" /> <?php echo $language['name']; ?></a>
								<?php } ?>
							</div>
							<?php foreach ($languages as $language) { ?>
							<div id="tab-language-<?php echo $module_row; ?>-<?php echo $language['language_id']; ?>">
								<table class="form">
									<tr>
										<td><?php echo $entry_title; ?></td>
										<td><input type="text" name="ptestimonial_module[<?php echo $module_row; ?>][testimonial_title][<?php echo $language['language_id']; ?>]" id="description-<?php echo $module_row; ?>-<?php echo $language['language_id']; ?>"  value="<?php echo isset($module['testimonial_title'][$language['language_id']]) ? $module['testimonial_title'][$language['language_id']] : ''; ?>" size="30" /></td>
									</tr>
								</table>
							</div>
							<?php } ?>
						</div>
						
					</div>
					<?php $module_row++; ?>
				<?php } ?>
			</form>
		</div>
	</div>
	<br>
	<div style="text-align:center; color:#555555;">Premium Customer Testimonials v<?php echo $testimonial_version; ?></div>
</div>


<script type="text/javascript"><!--
var module_row = <?php echo $module_row; ?>;

function addModule() {	
	html =  '<div id="tab-module-' + module_row + '" class="vtabs-content">';
	html += '	<h2><?php echo $heading_display_settings; ?></h2>';
	html += '	<table class="form">';
	html += '		<tr>';
	html += '		<td><?php echo $entry_display_style; ?></td>';
	html += '			<td><select name="ptestimonial_module[' + module_row + '][display_style]">';
	html += '				<option value="1"><?php echo $text_display_title; ?></option>';
	html += '				<option value="0"><?php echo $text_display_title_description; ?></option>';
	html += '			</select></td>';
	html += '	</tr>';
	html += '		<tr>';
	html += '			<td><?php echo $entry_description_length; ?></td>';
	html += '			<td><input type="text" name="ptestimonial_module[' + module_row + '][description_length]" value="0" size="2" /></td>';
	html += '		</tr>';
	html += '		<tr>';
	html += '			<td><?php echo $entry_keep_reading; ?></td>';
	html += '			<td>';
	html += '				<input type="radio" name="ptestimonial_module[' + module_row + '][read_more]" value="1" checked="checked" /><?php echo $text_yes; ?>';
	html += '				<input type="radio" name="ptestimonial_module[' + module_row + '][read_more]" value="0" /><?php echo $text_no; ?>';
	html += '			</td>';
	html += '		</tr>';
	html += '		<tr>';
	html += '			<td><?php echo $entry_view_all; ?></td>';
	html += '			<td>';
	html += '				<input type="radio" name="ptestimonial_module[' + module_row + '][view_all]" value="1" checked="checked" /><?php echo $text_yes; ?>';
	html += '				<input type="radio" name="ptestimonial_module[' + module_row + '][view_all]" value="0" /><?php echo $text_no; ?>';
	html += '			</td>';
	html += '		</tr>';
	html += '		<tr>';
	html += '			<td><?php echo $entry_display_order; ?></td>';
	html += '			<td><select name="ptestimonial_module[' + module_row + '][display_order]">';
	html += '				<option value="1"><?php echo $text_display_order_random; ?></option>';
	html += '				<option value="0"><?php echo $text_display_order_latest; ?></option>';
	html += '			</select></td>';
	html += '		</tr>';
			
	html += '		<tr>';
	html += '			<td><?php echo $entry_display_featured; ?></td>';
	html += '			<td>';
	html += '				<input type="radio" name="ptestimonial_module[' + module_row + '][featured_only]" value="1" /><?php echo $text_yes; ?>';
	html += '				<input type="radio" name="ptestimonial_module[' + module_row + '][featured_only]" value="0" checked="checked" /><?php echo $text_no; ?>';
	html += '			</td>';
	html += '		</tr>';
			
	html += '		<tr>';
	html += '			<td><?php echo $entry_display_stars; ?></td>';
	html += '			<td>';
	html += '				<input type="radio" name="ptestimonial_module[' + module_row + '][show_stars]" value="1" checked="checked" /><?php echo $text_yes; ?>';
	html += '				<input type="radio" name="ptestimonial_module[' + module_row + '][show_stars]" value="0" /><?php echo $text_no; ?>';
	html += '			</td>';
	html += '		</tr>';
			
	html += '		<tr>';
	html += '			<td><?php echo $entry_star_template; ?></td>';
	html += '			<td>';
	html += '				<select id="star-template-dropdown-' + module_row + '" name="ptestimonial_module[' + module_row + '][star_template]"  style="width:270px;">';
	html += '				<option value="" data-description="<?php echo $text_star_template_choose; ?>"><?php echo $text_star_template; ?></option>';
	<?php foreach ($star_templates as $star_template) { ?>
	html += '					<option value="<?php echo $star_template['name']; ?>" data-image="<?php echo HTTP_CATALOG . 'image/testimonials/' . $star_template['name'] . '/preview-icon.png' ?>" data-description="<?php echo $star_template['subtext']; ?>"><?php echo $star_template['name']; ?></option>';
	<?php } ?>
	html += '				</select>';
	html += '			</td>';
	html += '		</tr>';

	html += '		<tr>';
	html += '			<td><?php echo $entry_star_size; ?></td>';
	html += '			<td>';
	html += '				<select id="star-size-dropdown" name="ptestimonial_module[' + module_row + '][star_size]"  style="width:270px;">';
	<?php foreach ($star_sizes as $star_size) { ?>
	html += '					<option value="<?php echo $star_size['value']; ?>"><?php echo $star_size['name']; ?></option>';
	<?php } ?>
	html += '				</select>';
	html += '			</td>';
	html += '		</tr>';
			
	html += '		<tr>';
	html += '			<td><?php echo $entry_limit; ?></td>';
	html += '			<td><input type="text" name="ptestimonial_module[' + module_row + '][testimonial_limit]" value="0" size="2" /></td>';
	html += '		</tr>';
	html += '	</table>';
	
	html += '	<h2><?php echo $heading_layout_template; ?></h2>';
	html += '	<table class="form">';
	html += '		<tr>';
	html += '			<td><?php echo $entry_layout; ?></td>';
	html += '			<td><select name="ptestimonial_module[' + module_row + '][layout_id]">';
	<?php foreach ($layouts as $layout) { ?>
	html += '					<option value="<?php echo $layout['layout_id']; ?>"><?php echo $layout['name']; ?></option>';
	<?php } ?>
	html += '		</select></td>';
	html += '		</tr>';
		
	html += '		<tr>';
	html += '			<td><?php echo $entry_position; ?></td>';
	html += '			<td><select name="ptestimonial_module[' + module_row + '][position]">';
	html += '				<option value="content_top"><?php echo $text_content_top; ?></option>';
	html += '				<option value="content_bottom"><?php echo $text_content_bottom; ?></option>';
	html += '				<option value="column_left"><?php echo $text_column_left; ?></option>';
	html += '				<option value="column_right"><?php echo $text_column_right; ?></option>';
	html += '			</select></td>';
	html += '		</tr>';
		
	html += '		<tr>';
	html += '			<td><?php echo $entry_status; ?></td>';
	html += '			<td><select name="ptestimonial_module[' + module_row + '][status]">';
	html += '				<option value="1"><?php echo $text_enabled; ?></option>';
	html += '				<option value="0"><?php echo $text_disabled; ?></option>';
	html += '			</select></td>';
	html += '		</tr>';
		
	html += '		<tr>';
	html += '			<td><?php echo $entry_sort_order; ?></td>';
	html += '			<td><input type="text" name="ptestimonial_module[' + module_row + '][sort_order]" value="0" size="2" /></td>';
	html += '		</tr>';
	html += '	</table>';
	html += '	<h2><?php echo $heading_language_specific; ?></h2>';
	html += '	<div>';
	html += '		<div id="language-' + module_row + '" class="htabs">';
	<?php foreach ($languages as $language) { ?>
	html += '				<a href="#tab-language-' + module_row + '-<?php echo $language['language_id']; ?>"><img src="view/image/flags/<?php echo $language['image']; ?>" title="<?php echo $language['name']; ?>" /> <?php echo $language['name']; ?></a>';
	<?php } ?>
	html += '		</div>';
	<?php foreach ($languages as $language) { ?>
	html += '		<div id="tab-language-' + module_row + '-<?php echo $language['language_id']; ?>">';
	html += '			<table class="form">';
	html += '				<tr>';
	html += '					<td><?php echo $entry_title; ?></td>';
	html += '					<td><input type="text" name="ptestimonial_module[' + module_row + '][testimonial_title][<?php echo $language['language_id']; ?>]" id="description-' + module_row + '-<?php echo $language['language_id']; ?>" value="" size="30" /></td>';
	html += '				</tr>';
	html += '			</table>';
	html += '		</div>';
	<?php } ?>
	html += '	</div>';
	html += '</div>';
	
	$('#form').append(html);
	

	$("#star-template-dropdown-" + module_row).msDropDown();
	
	$('#language-' + module_row + ' a').tabs();
	
	$('#module-add').before('<a href="#tab-module-' + module_row + '" id="module-' + module_row + '"><?php echo $tab_module; ?> ' + module_row + '&nbsp;<img src="view/image/delete.png" alt="" onclick="$(\'.vtabs a:first\').trigger(\'click\'); $(\'#module-' + module_row + '\').remove(); $(\'#tab-module-' + module_row + '\').remove(); return false;" /></a>');
	
	$('.vtabs a').tabs();
	
	$('#module-' + module_row).trigger('click');
	
	module_row++;
}
//--></script> 
<script type="text/javascript"><!--
$('.vtabs a').tabs();
//--></script> 
<script type="text/javascript"><!--
<?php $module_row = 1; ?>
<?php foreach ($modules as $module) { ?>
$('#language-<?php echo $module_row; ?> a').tabs();
<?php $module_row++; ?>
<?php } ?> 
//--></script> 
<?php echo $footer; ?>