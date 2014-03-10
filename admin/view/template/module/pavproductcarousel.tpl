<?php
/******************************************************
 * @package Pav Megamenu module for Opencart 1.5.x
 * @version 1.0
 * @author http://www.pavothemes.com
 * @copyright	Copyright (C) Feb 2012 PavoThemes.com <@emai:pavothemes@gmail.com>.All rights reserved.
 * @license		GNU General Public License version 2
*******************************************************/

echo $header; ?>
<div id="content">
  <div class="breadcrumb">
    <?php foreach ($breadcrumbs as $breadcrumb) { ?>
    <?php echo $breadcrumb['separator']; ?><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a>
    <?php } ?>
  </div>
  <?php if ($error_warning) { ?>
  <div class="warning"><?php echo $error_warning; ?></div>
  <?php } ?>
  <div class="box">
    <div class="heading">
      <h1><img src="view/image/module.png" alt="" /> <?php echo $heading_title; ?></h1>
        <div class="buttons">
          <a onclick="$('#form').submit();" class="button"><?php echo $button_save; ?></a>
          <a onclick="$('#action_mode').val('save-edit');$('#form').submit();" class="button"><?php echo $this->language->get('text_save_edit'); ?></a>
        <a href="<?php echo $cancel; ?>" class="button"><?php echo $button_cancel; ?></a>

      </div>
    </div>
    <div class="content">
      <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form">
        <input name="action_mode" type="hidden" id="action_mode"/>  
        <div class="vtabs">
          <?php $module_row = 1; ?>
          <?php foreach ($modules as $module) { ?>
          <a href="#tab-module-<?php echo $module_row; ?>" id="module-<?php echo $module_row; ?>"><?php echo $tab_module . ' ' . $module_row; ?>&nbsp;<img src="view/image/delete.png" alt="" onclick="$('.vtabs a:first').trigger('click'); $('#module-<?php echo $module_row; ?>').remove(); $('#tab-module-<?php echo $module_row; ?>').remove(); return false;" /></a>
          <?php $module_row++; ?>
          <?php } ?>
          <span id="module-add"><?php echo $button_add_module; ?>&nbsp;<img src="view/image/add.png" alt="" onclick="addModule();" /></span> </div>
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
                <td><?php echo $entry_description; ?></td>
                <td><textarea name="pavproductcarousel_module[<?php echo $module_row; ?>][description][<?php echo $language['language_id']; ?>]" id="description-<?php echo $module_row; ?>-<?php echo $language['language_id']; ?>"><?php echo isset($module['description'][$language['language_id']]) ? $module['description'][$language['language_id']] : ''; ?></textarea></td>
              </tr>
            </table>
          </div>
          <?php } ?>
          <table class="form">
			<!--<?php /*<tr>
				<td><?php echo $this->language->get('label_btn_view_more'); ?></td>
				<td>
					<select name="pavproductcarousel_module[<?php echo $module_row; ?>][btn_view_more]">
						<?php if ($module['btn_view_more']) { ?>
						<option value="1" selected="selected"><?php echo $text_enabled; ?></option>
						<option value="0"><?php echo $text_disabled; ?></option>
						<?php } else { ?>
						<option value="1"><?php echo $text_enabled; ?></option>
						<option value="0" selected="selected"><?php echo $text_disabled; ?></option>
						<?php } ?>
					</select>	
				</td>
            </tr>*/?>-->
			<tr><?php //start config tooltip?>
				<td><?php echo $this->language->get('label_tooltip'); ?></td>
				<td>
					<select onchange="tooltip(<?php echo $module_row;?>);" class="tooltip-<?php echo $module_row;?>" name="pavproductcarousel_module[<?php echo $module_row; ?>][tooltip]">
						<?php if ($module['tooltip']) { ?>
						<option value="1" selected="selected"><?php echo $text_enabled; ?></option>
						<option value="0"><?php echo $text_disabled; ?></option>
						<?php } else { ?>
						<option value="1"><?php echo $text_enabled; ?></option>
						<option value="0" selected="selected"><?php echo $text_disabled; ?></option>
						<?php } ?>
					</select>	
				</td>
            </tr>
			<tbody id="tooltip-<?php echo $module_row; ?>">
			<tr>
				<td><?php echo $this->language->get('label_tooltip_placement'); ?></td>
				<td>
					<select name="pavproductcarousel_module[<?php echo $module_row; ?>][tooltip_placement]">
						<?php foreach($tooltip_placement as $item):?>
						<option value="<?php echo $item;?>"><?php echo $item;?></option>
						<?php endforeach;?>
					</select>	
				</td>
            </tr>
			<tr>
				<td><?php echo $this->language->get('label_tooltip_show'); ?></td>
				<td>
					<input name="pavproductcarousel_module[<?php echo $module_row; ?>][tooltip_show]" value="<?php echo ( isset($module['tooltip_show'])?$module['tooltip_show']:100 ); ?>"/>
				</td>
            </tr>
			<tr>
				<td><?php echo $this->language->get('label_tooltip_hide'); ?></td>
				<td>
					<input name="pavproductcarousel_module[<?php echo $module_row; ?>][tooltip_hide]" value="<?php echo ( isset($module['tooltip_hide'])?$module['tooltip_hide']:100 ); ?>"/>
				</td>
            </tr>
			</tbody><?php //end config tooltip?>
             <tr>
              <td><?php echo $this->language->get('prefix_class'); ?></td>
              <td><input name="pavproductcarousel_module[<?php echo $module_row; ?>][prefix]" value="<?php echo ( isset($module['prefix'])?$module['prefix']:'' ) ?>"/>
                 </td>
            </tr>
			<tr>
				<td>
				<?php echo $entry_tabs;?>
				</td>
				<td>
				  <select name="pavproductcarousel_module[<?php echo $module_row; ?>][tabs][]">
                  <?php foreach ($tabs as $tab => $tabName) { ?>
                  <?php if ( in_array($tab,(array)$module['tabs']) ) { ?>
                  <option value="<?php echo $tab; ?>" selected="selected"><?php echo $tabName; ?></option>
                  <?php } else { ?>
                  <option value="<?php echo $tab; ?>"><?php echo $tabName; ?></option>
                  <?php } ?>
                  <?php } ?>
                </select>
				</td>
			</tr>
			<tr>
				<td><?php echo $entry_dimension; ?></td>
				<td class="left"><input type="text" name="pavproductcarousel_module[<?php echo $module_row; ?>][width]" value="<?php echo $module['width']; ?>" size="3" />
                <input type="text" name="pavproductcarousel_module[<?php echo $module_row; ?>][height]" value="<?php echo $module['height']; ?>" size="3"/>
                <?php if (isset($error_dimension[$module_row])) { ?>
                <span class="error"><?php echo $error_dimension[$module_row]; ?></span>
                <?php } ?></td>	
			</tr>
			<tr>
				 <td class="left"><?php echo $entry_carousel; ?></td>
				  <td class="left"><input type="text" name="pavproductcarousel_module[<?php echo $module_row; ?>][itemsperpage]" value="<?php echo $module['itemsperpage']; ?>" size="3" /> - 
                <input type="text" name="pavproductcarousel_module[<?php echo $module_row; ?>][cols]" value="<?php echo $module['cols']; ?>" size="3"/> - 
				<input type="text" name="pavproductcarousel_module[<?php echo $module_row; ?>][limit]" value="<?php echo $module['limit']; ?>" size="3"/>
                <?php if (isset($error_carousel[$module_row])) { ?>
                <span class="error"><?php echo $error_carousel[$module_row]; ?></span>
                <?php } ?></td>
			</tr>
       <tr>
              <td><?php echo $this->language->get('text_interval'); ?></td>
              <td><input name="pavproductcarousel_module[<?php echo $module_row; ?>][interval]" value="<?php echo ( isset($module['interval'])?$module['interval']:8000 ) ?>"/>
                 </td>
            </tr>

            <tr>
              <td><?php echo $this->language->get('text_auto_play'); ?></td>
              <td><select name="pavproductcarousel_module[<?php echo $module_row; ?>][auto_play]">
                 <?php foreach ($yesno as $k=>$v) { ?>
                    <option value="<?php echo $k; ?>" <?php if( isset($module['auto_play']) && $module['auto_play'] == $k ) { ?> selected="selected" <?php } ?>><?php echo $v; ?></option>
                  <?php } ?>
                </select></td>
            </tr>

            <tr>
              <td><?php echo $entry_layout; ?></td>
              <td><select name="pavproductcarousel_module[<?php echo $module_row; ?>][layout_id]">
                 <?php foreach ($layouts as $layout) { ?>
                  <?php if ($layout['layout_id'] == $module['layout_id']) { ?>
                  <option value="<?php echo $layout['layout_id']; ?>" selected="selected"><?php echo $layout['name']; ?></option>
                  <?php } else { ?>
                  <option value="<?php echo $layout['layout_id']; ?>"><?php echo $layout['name']; ?></option>
                  <?php } ?>
                  <?php } ?>
                </select></td>
            </tr>

            <tr>
              <td><?php echo $entry_position; ?></td>
              <td><select name="pavproductcarousel_module[<?php echo $module_row; ?>][position]">
                  <?php foreach( $positions as $pos ) { ?>
                  <?php if ($module['position'] == $pos) { ?>
                  <option value="<?php echo $pos;?>" selected="selected"><?php echo $this->language->get('text_'.$pos); ?></option>
                  <?php } else { ?>
                  <option value="<?php echo $pos;?>"><?php echo $this->language->get('text_'.$pos); ?></option>
                  <?php } ?>
                  <?php } ?> 
                </select></td>
            </tr>
            <tr>
              <td><?php echo $entry_status; ?></td>
              <td><select name="pavproductcarousel_module[<?php echo $module_row; ?>][status]">
                  <?php if ($module['status']) { ?>
                  <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
                  <option value="0"><?php echo $text_disabled; ?></option>
                  <?php } else { ?>
                  <option value="1"><?php echo $text_enabled; ?></option>
                  <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
                  <?php } ?>
                </select></td>
            </tr>
            <tr>
              <td><?php echo $entry_sort_order; ?></td>
              <td><input type="text" name="pavproductcarousel_module[<?php echo $module_row; ?>][sort_order]" value="<?php echo $module['sort_order']; ?>" size="3" /></td>
            </tr>
          </table>
        </div>
        <?php $module_row++; ?>
        <?php } ?>
      </form>
    </div>
  </div>
</div>
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
<script type="text/javascript"><!--
var module_row = <?php echo $module_row; ?>;

$(document).ready(function(){
	$(".vtabs a").each(function(){
		var tab_selected = $(this).attr("class");
		var id = $(this).attr("id").substr($(this).attr("id").length - 1);
		if(tab_selected == 'selected' && $(this).hasClass('selected')){
			tooltip(id);
		} else {
			tooltip(id);
		}
	});
});

function tooltip(id){
	var selected = $('.tooltip-' + id + ' option:selected').val();
	if(selected == 1){
		$('#tooltip-' + id).show();
	} else {
		$('#tooltip-' + id).hide();
	}
}

function addModule() {	
	html  = '<div id="tab-module-' + module_row + '" class="vtabs-content">';
	html += '  <div id="language-' + module_row + '" class="htabs">';
    <?php foreach ($languages as $language) { ?>
    html += '    <a href="#tab-language-'+ module_row + '-<?php echo $language['language_id']; ?>"><img src="view/image/flags/<?php echo $language['image']; ?>" title="<?php echo $language['name']; ?>" /> <?php echo $language['name']; ?></a>';
    <?php } ?>
	html += '  </div>';

	<?php foreach ($languages as $language) { ?>
	html += '    <div id="tab-language-'+ module_row + '-<?php echo $language['language_id']; ?>">';
	html += '      <table class="form">';
	html += '        <tr>';
	html += '          <td><?php echo $entry_description; ?></td>';
	html += '          <td><textarea name="pavproductcarousel_module[' + module_row + '][description][<?php echo $language['language_id']; ?>]" id="description-' + module_row + '-<?php echo $language['language_id']; ?>"></textarea></td>';
	html += '        </tr>';
	html += '      </table>';
	html += '    </div>';
	<?php } ?>

	html += '  <table class="form">';
	
	//button view more
	html += '<tr>';
	html += '	<td><?php echo $this->language->get('label_btn_view_more'); ?></td>';
	html += '	<td>';
	html += '		<select name="pavproductcarousel_module[' + module_row + '][btn_view_more]">';
	html += '			<option value="1" selected="selected"><?php echo $text_enabled; ?></option>';
	html += '			<option value="0"><?php echo $text_disabled; ?></option>';
	html += '		</select>';
	html += '	</td>';
	html += '</tr>';
	//tooltip
	html += '<tr>';
	html += '	<td><?php echo $this->language->get('label_tooltip'); ?></td>';
	html += '	<td>';
	html += '		<select onchange="tooltip(' + module_row + ');" class="tooltip-' + module_row + '" name="pavproductcarousel_module['+module_row+'][tooltip]">';
	html += '			<option value="1" selected="selected"><?php echo $text_enabled; ?></option>';
	html += '			<option value="0"><?php echo $text_disabled; ?></option>';
	html += '		</select>';	
	html += '	</td>';
	html += '</tr>';
	//start body tooltip
	html += '<tbody id="tooltip-' + module_row + '">';
	html += '	<tr>';
	html += '		<td><?php echo $this->language->get('label_tooltip_placement'); ?></td>';
	html += '		<td>';
	html += '			<select name="pavproductcarousel_module[' + module_row + '][tooltip_placement]">';
						<?php foreach($tooltip_placement as $item):?>
	html += '				<option value="<?php echo $item;?>"><?php echo $item;?></option>';
						<?php endforeach;?>
	html += '			</select>';	
	html += '		</td>';
    html += '	</tr>';
	html += '	<tr>';
	html += '		<td><?php echo $this->language->get('label_tooltip_show'); ?></td>';
	html += '		<td>';
	html += '			<input name="pavproductcarousel_module[' + module_row + '][tooltip_show]" value="<?php echo ( isset($module['tooltip_show'])?$module['tooltip_show']:100 ); ?>"/>';
	html += '		</td>';
    html += '	</tr>';
	html += '	<tr>';
	html += '		<td><?php echo $this->language->get('label_tooltip_hide'); ?></td>';
	html += '		<td><input name="pavproductcarousel_module[' + module_row + '][tooltip_hide]" value="<?php echo ( isset($module['tooltip_hide'])?$module['tooltip_hide']:100 ); ?>"/></td>';
    html += '	</tr>';
	html += '</tbody>';
	//end body tooltip
	
	
  html +='<tr>';
  html +='            <td><?php echo $this->language->get('prefix_class'); ?></td>';
  html +='            <td><input name="pavproductcarousel_module[' + module_row + '][prefix]" value=""/>';
  html +='               </td></tr>';
	html += '  <tr>';
	html += '      <td><?php echo $entry_tabs; ?></td>';		
	html += '    <td class="left"><select name="pavproductcarousel_module[' + module_row + '][tabs][]"  >';
	<?php foreach ($tabs as $tab => $tabName ) { ?>
	html += '      <option value="<?php echo $tab; ?>"><?php echo addslashes($tabName); ?></option>';
	<?php } ?>
	html += '    </select></td>';
		html += '    <tr>';
	html += '      <td><?php echo $entry_dimension; ?></td>';
	html += '    <td class="left"><input type="text" name="pavproductcarousel_module[' + module_row + '][width]" value="202" size="3" /> <input type="text" name="pavproductcarousel_module[' + module_row + '][height]" value="168" size="3" /></td>';
	html += '    <tr>';
	html += '    </tr>';
	html += '      <td><?php echo $entry_carousel; ?></td>';
	html += '    <td class="left"><input type="text" name="pavproductcarousel_module[' + module_row + '][itemsperpage]" value="8" size="3" /> - <input type="text" name="pavproductcarousel_module[' + module_row + '][cols]" value="4" size="3" /> - <input type="text" name="pavproductcarousel_module[' + module_row + '][limit]" value="16" size="3" /></td>';
	html += '    </tr>';

    html += '    <tr>';
  html += '      <td><?php echo $this->language->get("text_auto_play"); ?></td>';
  html += '      <td><select name="pavproductcarousel_module[' + module_row + '][auto_play]">';
  <?php foreach ($yesno as $k=>$v) { ?>
  html += '           <option value="<?php echo $k; ?>"><?php echo addslashes($v); ?></option>';
  <?php } ?>
  html += '      </select></td>';
  html += '    </tr>';


  html += '    <tr>';
  html += '      <td><?php echo $this->language->get("text_interval"); ?></td>';
  html += '      <td><input type="text" name="pavproductcarousel_module[' + module_row + '][interval]" value="8000">';
 
  html += '      </select></td>';
  html += '    </tr>';
	html += '    <tr>';
	html += '      <td><?php echo $entry_layout; ?></td>';
	html += '      <td><select name="pavproductcarousel_module[' + module_row + '][layout_id]">';
	<?php foreach ($layouts as $layout) { ?>
	html += '           <option value="<?php echo $layout['layout_id']; ?>"><?php echo addslashes($layout['name']); ?></option>';
	<?php } ?>
	html += '      </select></td>';
	html += '    </tr>';
	html += '    <tr>';
	html += '      <td><?php echo $entry_position; ?></td>';
	html += '      <td><select name="pavproductcarousel_module[' + module_row + '][position]">';
	<?php foreach( $positions as $pos ) { ?>
	html += '<option value="<?php echo $pos;?>"><?php echo $this->language->get('text_'.$pos); ?></option>';      
	<?php } ?>		html += '      </select></td>';
	html += '    </tr>';
	html += '    <tr>';
	html += '      <td><?php echo $entry_status; ?></td>';
	html += '      <td><select name="pavproductcarousel_module[' + module_row + '][status]">';
	html += '        <option value="1"><?php echo $text_enabled; ?></option>';
	html += '        <option value="0"><?php echo $text_disabled; ?></option>';
	html += '      </select></td>';
	html += '    </tr>';
	html += '    <tr>';
	html += '      <td><?php echo $entry_sort_order; ?></td>';
	html += '      <td><input type="text" name="pavproductcarousel_module[' + module_row + '][sort_order]" value="" size="3" /></td>';
	html += '    </tr>';
	html += '  </table>'; 
	html += '</div>';
	
	$('#form').append(html);
	
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
