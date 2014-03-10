<?php
/******************************************************
 * @package  : Pav Popular tags module for Opencart 1.5.x
 * @version  : 1.0
 * @author   : http://www.pavothemes.com
 * @copyright: Copyright (C) Feb 2013 PavoThemes.com <@emai:pavothemes@gmail.com>.All rights reserved.
 * @license  : GNU General Public License version 1
*******************************************************/
?>
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

	<div class="box">
		<div class="heading">
			<h1><img src="view/image/module.png" alt="" /> <?php echo $heading_title; ?></h1>
			<div class="buttons">
				<a onclick="$('#form').submit();" class="button"><?php echo $button_save; ?></a>
				<a onclick="$('#action').val('save-edit');$('#form').submit();" class="button"><?php echo $this->language->get('text_save_edit'); ?></a>
				<a href="<?php echo $cancel; ?>" class="button"><?php echo $button_cancel; ?></a>
			</div>
		</div>
		<div class="content">
			<form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form">
				<input name="action" type="hidden" id="action"/>  
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
					<div id="language-<?php echo $module_row; ?>" class="htabs">
						<?php foreach ($languages as $language) { ?>
						<a href="#tab-language-<?php echo $module_row; ?>-<?php echo $language['language_id']; ?>"><img src="view/image/flags/<?php echo $language['image']; ?>" title="<?php echo $language['name']; ?>" /> <?php echo $language['name']; ?></a>
						<?php } ?>
					</div>
					<?php foreach ($languages as $language) { ?>
					<div id="tab-language-<?php echo $module_row; ?>-<?php echo $language['language_id']; ?>">
						<table class="form">
					 		<tr>
								<td><?php echo $this->language->get('entry_title'); ?></td>
								<td><textarea rows="2" cols="60" name="pavpopulartags_module[<?php echo $module_row; ?>][title][<?php echo $language['language_id']; ?>]" id="title-<?php echo $module_row; ?>-<?php echo $language['language_id']; ?>"><?php echo isset($module['title'][$language['language_id']]) ? $module['title'][$language['language_id']] : ''; ?></textarea></td>
							</tr>
						</table>
					</div>
				  	<?php } ?>
					<table class="form">
						<tr>
							<td><span class="required">* </span><?php echo $this->language->get("entry_limit_tags"); ?>
								<br/><span class="help"><?php echo $this->language->get("help_limit_tags"); ?></span>
							</td>
							<td>
								<input name="pavpopulartags_module[<?php echo $module_row; ?>][limit_tags]" value="<?php echo (isset($module['limit_tags'])?$module['limit_tags']:'' ) ?>" size="3"/>
							</td>
						</tr>
						
						<tr>
							<td><?php echo $this->language->get("entry_min_font_size"); ?><br>
								<span class="help"><?php echo $this->language->get("help_min_font_size"); ?></span>
							</td>
							<td>
								<input name="pavpopulartags_module[<?php echo $module_row; ?>][min_font_size]" value="<?php echo (isset($module['min_font_size'])?$module['min_font_size']:'' ) ?>" size="3"/>
							</td>
						</tr>
						
						<tr>
							<td><?php echo $this->language->get("entry_max_font_size"); ?><br>
								<span class="help"><?php echo $this->language->get("help_max_font_size"); ?></span>
							</td>
							<td>
								<input name="pavpopulartags_module[<?php echo $module_row; ?>][max_font_size]" value="<?php echo (isset($module['max_font_size'])?$module['max_font_size']:'' ) ?>" size="3"/>
							</td>
						</tr>

						<tr>
							<td><?php echo $this->language->get("entry_font_weight"); ?><br>
								<span class="help"><?php echo $this->language->get("help_font_weight"); ?></span>
							</td>
							<td><select name="pavpopulartags_module[<?php echo $module_row; ?>][font_weight]">
								<?php foreach ($fontweights as $font) { ?>
								<?php if ($font == $module['font_weight']) { ?>
								<option value="<?php echo $font; ?>" selected="selected"><?php echo $font; ?></option>
								<?php } else { ?>
								<option value="<?php echo $font; ?>"><?php echo $font; ?></option>
								<?php } ?>
								<?php } ?>
								</select>
							</td>
						</tr>

						<tr>
							<td><?php echo $this->language->get('prefix_class'); ?></td>
							<td>
								<input name="pavpopulartags_module[<?php echo $module_row; ?>][prefix]" value="<?php echo (isset($module['prefix'])?$module['prefix']:'' ) ?>"/>
							</td>
						</tr>
						<tr>
							<td><?php echo $entry_layout; ?></td>
							<td><select name="pavpopulartags_module[<?php echo $module_row; ?>][layout_id]">
								<?php foreach ($layouts as $layout) { ?>
								<?php if ($layout['layout_id'] == $module['layout_id']) { ?>
								<option value="<?php echo $layout['layout_id']; ?>" selected="selected"><?php echo $layout['name']; ?></option>
								<?php } else { ?>
								<option value="<?php echo $layout['layout_id']; ?>"><?php echo $layout['name']; ?></option>
								<?php } ?>
								<?php } ?>
								</select>
							</td>
						</tr>

						<tr>
							<td><?php echo $entry_position; ?></td>
							<td><select name="pavpopulartags_module[<?php echo $module_row; ?>][position]">
								<?php foreach( $positions as $pos ) { ?>
								<?php if ($module['position'] == $pos) { ?>
								<option value="<?php echo $pos;?>" selected="selected"><?php echo $this->language->get('text_'.$pos); ?></option>
								<?php } else { ?>
								<option value="<?php echo $pos;?>"><?php echo $this->language->get('text_'.$pos); ?></option>
								<?php } ?>
								<?php } ?> 
								</select>
							</td>
						</tr>
						<tr>
							<td><?php echo $entry_status; ?></td>
							<td><select name="pavpopulartags_module[<?php echo $module_row; ?>][status]">
								<?php if ($module['status']) { ?>
								<option value="1" selected="selected"><?php echo $text_enabled; ?></option>
								<option value="0"><?php echo $text_disabled; ?></option>
								<?php } else { ?>
								<option value="1"><?php echo $text_enabled; ?></option>
								<option value="0" selected="selected"><?php echo $text_disabled; ?></option>
								<?php } ?>
							</select>
						</td>
						</tr>
						<tr>
							<td><?php echo $entry_sort_order; ?></td>
							<td><input type="text" name="pavpopulartags_module[<?php echo $module_row; ?>][sort_order]" value="<?php echo $module['sort_order']; ?>" size="3" /></td>
						</tr>
					</table>
				</div>
				<?php $module_row++; ?>
				<?php } ?>
			</form>
		</div>
	</div>
</div>
<?php /* 
	//Editor
<script type="text/javascript" src="view/javascript/ckeditor/ckeditor.js"></script> 
<script type="text/javascript"><!--
<?php $module_row = 1; ?>
<?php foreach ($modules as $module) { ?>
<?php foreach ($languages as $language) { ?>
CKEDITOR.replace('description-<?php echo $module_row; ?>-<?php echo $language['language_id']; ?>', {
	filebrowserBrowseUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>',
	filebrowserImageBrowseUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>',
	filebrowserFlashBrowseUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>',
	filebrowserUploadUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>',
	filebrowserImageUploadUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>',
	filebrowserFlashUploadUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>'
});
<?php } ?>
<?php $module_row++; ?>
<?php } ?>
//--></script> 
*/ ?>
<script type="text/javascript"><!--
var module_row = <?php echo $module_row; ?>;

function addModule() {  

	html  = '<div id="tab-module-' + module_row + '" class="vtabs-content">';
	html += '	<div id="language-' + module_row + '" class="htabs">';
					<?php foreach ($languages as $language) { ?>
	html += '		<a href="#tab-language-'+ module_row + '-<?php echo $language['language_id']; ?>"><img src="view/image/flags/<?php echo $language['image']; ?>" title="<?php echo $language['name']; ?>" /> <?php echo $language['name']; ?></a>';
					<?php } ?>
	html += '  </div>';

	<?php foreach ($languages as $language) { ?>
	html += '	<div id="tab-language-'+ module_row + '-<?php echo $language['language_id']; ?>">';
	html += '		<table class="form">';
	html += '			<tr>';
	html += '				<td><?php echo $this->language->get("entry_title"); ?></td>';
	html += '				<td><textarea cols="60" rows="2" name="pavpopulartags_module[' + module_row + '][title][<?php echo $language['language_id']; ?>]" id="title-' + module_row + '-<?php echo $language['language_id']; ?>">Popular tags</textarea></td>';
	html += '			</tr>';
	html += '		</table>';
	html += ' 	</div>';
	<?php } ?>

	html += '<table class="form">';
	html += '	<tr>';
	html += '		<td><span class="required">* </span><?php echo $this->language->get("entry_limit_tags"); ?><br/><span class="help"><?php echo $this->language->get("help_limit_tags"); ?></span></td>';
	html += '		<td><input name="pavpopulartags_module[' + module_row + '][limit_tags]" value="20" size="3"/></td>';
	html += '	</tr>';
	
	html += '	<tr>';
	html += '		<td><?php echo $this->language->get("entry_min_font_size"); ?><br/><span class="help"><?php echo $this->language->get("help_min_font_size"); ?></span></td>';
	html += '		<td><input name="pavpopulartags_module[' + module_row + '][min_font_size]" value="9" size="3"/></td>';
	html += '	</tr>';
	
	html += '	<tr>';
	html += '		<td><?php echo $this->language->get("entry_max_font_size"); ?><br/><span class="help"><?php echo $this->language->get("help_max_font_size"); ?></span></td>';
	html += '		<td><input name="pavpopulartags_module[' + module_row + '][max_font_size]" value="20" size="3"/></td>';
	html += '	</tr>';

	html += '	<tr>';
	html += '		<td><?php echo $this->language->get("entry_font_weight"); ?><br/><span class="help"><?php echo $this->language->get("help_font_weight"); ?></span></td>';
	html += '		<td><select name="pavpopulartags_module[<?php echo $module_row; ?>][font_weight]">';
						<?php foreach ($fontweights as $font) { ?>
						<?php if ($font == "bold") { ?>
	html += '			<option value="<?php echo $font; ?>" selected="selected"><?php echo $font; ?></option>';
						<?php } else { ?>
	html += '			<option value="<?php echo $font; ?>"><?php echo $font; ?></option>';
						<?php } ?>
						<?php } ?>
	html += '			</select>';
	html += '		</td>';

	html += '	</tr>';
	html += '	<tr>';
	html += '		<td><?php echo $this->language->get("prefix_class"); ?></td>';
	html += '		<td>';
	html += '			<input name="pavpopulartags_module['+module_row+'][prefix]" value="prefix_class'+module_row+'"/>';
	html += '		</td>';
	html += '	</tr>';
	html += '	<tr>';
	html += '		<td><?php echo $entry_layout; ?></td>';
	html += '		<td><select name="pavpopulartags_module[' + module_row + '][layout_id]">';
						<?php foreach ($layouts as $layout) { ?>
	html += '			<option value="<?php echo $layout['layout_id']; ?>"><?php echo addslashes($layout['name']); ?></option>';
						<?php } ?>
	html += '		</select></td>';
	html += '	</tr>';
	html += '	<tr>';
	html += '		<td><?php echo $entry_position; ?></td>';
	html += '		<td><select name="pavpopulartags_module[' + module_row + '][position]">';
						<?php foreach( $positions as $pos ) { ?>
						<?php if ($pos == "column_left") { ?>
	html += '			<option selected="selected" value="<?php echo $pos;?>"><?php echo $this->language->get('text_'.$pos); ?></option>';
						<?php } else { ?>
	html += '			<option value="<?php echo $pos;?>"><?php echo $this->language->get('text_'.$pos); ?></option>';      
						<?php } ?>
						<?php } ?>
	html += '		</select></td>';
	html += '	</tr>';
	html += '	<tr>';
	html += '		<td><?php echo $entry_status; ?></td>';
	html += '		<td><select name="pavpopulartags_module[' + module_row + '][status]">';
	html += '			<option value="1"><?php echo $text_enabled; ?></option>';
	html += '			<option value="0"><?php echo $text_disabled; ?></option>';
	html += '		</select></td>';
	html += '	</tr>';
	html += '	<tr>';
	html += '		<td><?php echo $entry_sort_order; ?></td>';
	html += '		<td><input type="text" name="pavpopulartags_module[' + module_row + '][sort_order]" value="1" size="3" /></td>';
	html += '	</tr>';
	html += '</table>';

	html += '</div>';
	
	$('#form').append(html);
	
	<?php /* 
	//Editor
	<?php foreach ($languages as $language) { ?>
	CKEDITOR.replace('description-' + module_row + '-<?php echo $language['language_id']; ?>', {
		filebrowserBrowseUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>',
		filebrowserImageBrowseUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>',
		filebrowserFlashBrowseUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>',
		filebrowserUploadUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>',
		filebrowserImageUploadUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>',
		filebrowserFlashUploadUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>'
	});  
	<?php } ?> 
	*/?>

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