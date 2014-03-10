<?php
/******************************************************
 * @package Pav Product Featured module for Opencart 1.5.x
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
        <a onclick="$('#frmaction').val('save-edit');$('#form').submit();" class="button"><?php echo $this->language->get('text_save_edit'); ?></a>
        <a href="<?php echo $cancel; ?>" class="button"><?php echo $button_cancel; ?></a>
      </div>
    </div>
    <div class="content">
      <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form">
        <input type="hidden" name="pavproductfeatured_action" value="" id="frmaction"/>
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
               <td> <?php echo $this->language->get( 'entry_icon_image' );?> </td>
                  <td> 
                     <?php 
                    $idx = $language['language_id'];
                    $imgidx = $module_row."-".$idx;
                    $thumb = isset( $module['image'][$idx]) ?  $this->model_tool_image->resize( $module['image'][$idx], 200, 200) :"";
                    $image = isset($module['image'][$idx])?$module['image'][$idx]:"";  
                    $no_image = '';
                     ?> 
                  <img src="<?php echo $thumb; ?>" alt="" id="thumb<?php echo $imgidx; ?>" />
                  <input type="hidden" name="pavproductfeatured_module[<?php echo $module_row; ?>][image][<?php echo  $idx;?>]" value="<?php echo $image; ?>" id="image<?php echo $imgidx; ?>"  />
                  <br />

                 <a onclick="image_upload('image<?php echo $imgidx; ?>', 'thumb<?php echo $imgidx; ?>');"><?php echo $text_browse; ?></a>&nbsp;&nbsp;|&nbsp;&nbsp;
				 <a onclick="$('#thumb<?php echo $imgidx; ?>').attr('src', '<?php echo $no_image; ?>'); $('#image<?php echo $imgidx; ?>').attr('value', '');"><?php echo $text_clear; ?></a>


                  </td>
              </tr>
              <tr>
                <td><?php echo $entry_description; ?></td>
                <td><textarea name="pavproductfeatured_module[<?php echo $module_row; ?>][description][<?php echo $language['language_id']; ?>]" id="description-<?php echo $module_row; ?>-<?php echo $language['language_id']; ?>"><?php echo isset($module['description'][$language['language_id']]) ? $module['description'][$language['language_id']] : ''; ?></textarea></td>
              </tr>
            </table>
          </div>
          <?php } ?>

     <table class="form" style="background-color:#f3f3f3; padding-top:12px">
      <tr>
        <td><?php echo $this->language->get('text_product_container_width');?></td>
        <td>
            <select class="pavproductfeatured_block_width" name="pavproductfeatured_module[<?php echo $module_row; ?>][block_width]">
                <?php
                  $d = ( isset($module['block_width']) ? $module['block_width'] : 6 );  
                 for( $i=1; $i<=12; $i++ ) { ?>
                <option value="<?php echo $i ;?>" <?php if( $i == $d) { ?> selected="selected" <?php } ?> ><?php echo $i; ?></option>
                <?php } ?>
             </select>

        </td>
      </tr>
      <tr>
        <td><?php echo $this->language->get('text_class_addition');?></td>
        <td><input type="text" name="pavproductfeatured_module[<?php echo $module_row; ?>][class]" value="<?php echo ( isset($module['class']) ?$module['class']:"") ;?>" id="frmaction"/></td>
      </tr>
      <tr>
            <td><?php echo $this->language->get("entry_product"); ?></td>
            <td><input type="text" size="45" name="product<?php echo $module_row; ?>" value="" placeholder="<?php echo $this->language->get("text_input_product_name");?>"/></td>
      </tr>
      <tr>
        <td>&nbsp;</td>
        <td><div id="featured-product<?php echo $module_row; ?>" class="scrollbox">
            <?php $class = 'odd'; ?>

            <?php if(isset($module['products']) && !empty($module['products'])){ ?>
            <?php foreach ($module['products'] as $product) { ?>
            <?php $class = ($class == 'even' ? 'odd' : 'even'); ?>
            <div id="featured-product<?php echo $module_row;?>-<?php echo $product['product_id']; ?>" class="<?php echo $class; ?>"><?php echo $product['name']; ?> <img src="view/image/delete.png" alt="" />
              <input type="hidden" value="<?php echo $product['product_id']; ?>" />
            </div>
            <?php } ?>
            <?php } ?>
          </div>
          <input type="hidden" name="pavproductfeatured_module[<?php echo $module_row; ?>][featured_product]" value="<?php echo isset($module['featured_product'])?$module['featured_product']:''; ?>" /></td>
           <script type="text/javascript">
            $(document).ready(function(){
              productAutocomplete(<?php echo $module_row; ?>);
            })
          </script>
      </tr>
       
			<tr>
				<td><?php echo $entry_dimension; ?></td>
				<td class="left"><input type="text" name="pavproductfeatured_module[<?php echo $module_row; ?>][width]" value="<?php echo $module['width']; ?>" size="3" />
                <input type="text" name="pavproductfeatured_module[<?php echo $module_row; ?>][height]" value="<?php echo $module['height']; ?>" size="3"/>
                <?php if (isset($error_dimension[$module_row])) { ?>
                <span class="error"><?php echo $error_dimension[$module_row]; ?></span>
                <?php } ?></td>	
			</tr>
			<tr>
				 <td class="left"><?php echo $entry_carousel; ?></td>
				  <td class="left"><input type="text" name="pavproductfeatured_module[<?php echo $module_row; ?>][itemsperpage]" value="<?php echo $module['itemsperpage']; ?>" size="3" /> - 
                <input type="text" name="pavproductfeatured_module[<?php echo $module_row; ?>][cols]" value="<?php echo $module['cols']; ?>" size="3"/> - 
				<input type="text" name="pavproductfeatured_module[<?php echo $module_row; ?>][limit]" value="<?php echo $module['limit']; ?>" size="3"/>
                <?php if (isset($error_carousel[$module_row])) { ?>
                <span class="error"><?php echo $error_carousel[$module_row]; ?></span>
                <?php } ?></td>
			</tr>
            <tr>
              <td><?php echo $entry_layout; ?></td>
              <td><select name="pavproductfeatured_module[<?php echo $module_row; ?>][layout_id]">
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
              <td><select name="pavproductfeatured_module[<?php echo $module_row; ?>][position]">
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
              <td><select name="pavproductfeatured_module[<?php echo $module_row; ?>][status]">
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
              <td><input type="text" name="pavproductfeatured_module[<?php echo $module_row; ?>][sort_order]" value="<?php echo $module['sort_order']; ?>" size="3" /></td>
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
function productAutocomplete(module_id){
  $('input[name=\'product'+module_id+'\']').autocomplete({
  delay: 500,
  source: function(request, response) {
    $.ajax({
      url: 'index.php?route=catalog/product/autocomplete&token=<?php echo $token; ?>&filter_name=' +  encodeURIComponent(request.term),
      dataType: 'json',
      success: function(json) {   
        response($.map(json, function(item) {
          return {
            label: item.name,
            value: item.product_id
          }
        }));
      }
    });
  }, 
  select: function(event, ui) {
    $('#featured-product' + module_id + '-' + ui.item.value).remove();
    
    $('#featured-product'+module_id).append('<div id="featured-product' +module_id + '-' + ui.item.value + '">' + ui.item.label + '<img src="view/image/delete.png" alt="" /><input type="hidden" value="' + ui.item.value + '" /></div>');

    $('#featured-product'+module_id+' div:odd').attr('class', 'odd');
    $('#featured-product'+module_id+' div:even').attr('class', 'even');
    
    data = $.map($('#featured-product'+module_id+' input'), function(element){
      return $(element).attr('value');
    });
            
    $('input[name=\'pavproductfeatured_module\['+module_id+'\]\[featured_product\]\']').attr('value', data.join());
          
    return false;
  },
  focus: function(event, ui) {
        return false;
    }
});

$('#featured-product'+module_id+' div img').live('click', function() {
  $(this).parent().remove();
  
  $('#featured-product'+module_id+' div:odd').attr('class', 'odd');
  $('#featured-product'+module_id+' div:even').attr('class', 'even');

  data = $.map($('#featured-product'+module_id+' input'), function(element){
    return $(element).attr('value');
  });
          
  $('input[name=\'pavproductfeatured_module\['+module_id+'\]\[featured_product\]\']').attr('value', data.join()); 
});
}
//--></script> 
<script type="text/javascript"><!--
var module_row = <?php echo $module_row; ?>;

function addModule() {	
	html  = '<div id="tab-module-' + module_row + '" class="vtabs-content">';
	html += '  <div id="language-' + module_row + '" class="htabs">';
    <?php foreach ($languages as $language) { ?>
    html += '    <a href="#tab-language-'+ module_row + '-<?php echo $language['language_id']; ?>"><img src="view/image/flags/<?php echo $language['image']; ?>" title="<?php echo $language['name']; ?>" /> <?php echo $language['name']; ?></a>';
    <?php } ?>
	html += '  </div>';

	<?php $no_image = ''; foreach ($languages as $language) { ?>
	html += '    <div id="tab-language-'+ module_row + '-<?php echo $language['language_id']; ?>">';
	html += '      <table class="form">';
	html += '        <tr>';
	html += '          <td><?php echo $entry_description; ?></td>';
	html += '          <td><textarea name="pavproductfeatured_module[' + module_row + '][description][<?php echo $language['language_id']; ?>]" id="description-' + module_row + '-<?php echo $language['language_id']; ?>"></textarea></td>';
	html += '        </tr>';
  html += '        <tr>';
  var banner_row =  module_row+"<?php echo $language['language_id']; ?>";
  html += '          <td><?php echo $entry_description; ?></td>';
   html += '<div class="image"><img src="<?php echo $no_image; ?>" alt="" id="thumb' + banner_row + '" /><input type="hidden" name="pavproductfeatured_module[' + module_row + '][image][<?php echo $language['language_id']; ?>]" value="" id="image' + banner_row + '" /><br /><a onclick="image_upload(\'image' + banner_row + '\', \'thumb' + banner_row + '\');"><?php echo $text_browse; ?></a>&nbsp;&nbsp;|&nbsp;&nbsp;<a onclick="$(\'#thumb' + banner_row + '\').attr(\'src\', \'<?php echo $no_image; ?>\'); $(\'#image' + banner_row + '\').attr(\'value\', \'\');"><?php echo $text_clear; ?></a></div>';
  html += '       </td></tr>';

	html += '      </table>';
	html += '    </div>';
	<?php } ?>

	html += '  <table class="form" style="background-color:#f3f3f3; padding-top:12px">';

  html +=  ' <tr>';
  html +=  ' <td><?php echo $this->language->get('text_product_container_width');?></td>';
  html +=  '  <td>';
  html +=  '<select class="pavproductfeatured_block_width" name="pavproductfeatured_module[' + module_row + '][block_width]">';
                <?php
                  $d = 6;  
                 for( $i=1; $i<=12; $i++ ) { ?>
   html +=  ' <option value="<?php echo $i ;?>" <?php if( $i == $d) { ?> selected="selected" <?php } ?> ><?php echo $i; ?></option>';
                <?php } ?>
   html +=          ' </select>';

   html +=    '  </td>';
   html +=    '</tr>';

	html += ' <tr>';
    html +=    ' <td><?php echo $this->language->get('text_class_addition');?></td>';
   html +=    '  <td><input type="text" name="pavproductfeatured_module[' + module_row + '][class]" value=""  /></td>';
    html +=   '</tr>';
  html += '         <tr>';
  html += '           <td><?php echo $this->language->get("entry_product"); ?></td>';
  html += '           <td><input type="text" size="45" name="product' + module_row + '" value=""  placeholder="<?php echo $this->language->get("text_input_product_name");?>"/></td>';
  html += '         </tr>';
  html += '         <tr>';
  html += '           <td>&nbsp;</td>';
  html += '           <td><div id="featured-product' + module_row + '" class="scrollbox"></div>';
  html += '            <input type="hidden" name="pavproductfeatured_module[' + module_row + '][featured_product]" value="" /></td>';
  html += '        </tr>';
  html += '    </tr>';
		html += '    <tr>';
	html += '      <td><?php echo $entry_dimension; ?></td>';
	html += '    <td class="left"><input type="text" name="pavproductfeatured_module[' + module_row + '][width]" value="" size="3" /> <input type="text" name="pavproductfeatured_module[' + module_row + '][height]" value="" size="3" /></td>';
	html += '    <tr>';
	html += '    </tr>';
	html += '      <td><?php echo $entry_carousel; ?></td>';
	html += '    <td class="left"><input type="text" name="pavproductfeatured_module[' + module_row + '][itemsperpage]" value="3" size="3" /> - <input type="text" name="pavproductfeatured_module[' + module_row + '][cols]" value="3" size="3" /> - <input type="text" name="pavproductfeatured_module[' + module_row + '][limit]" value="9" size="3" /></td>';
	html += '    </tr>';
	html += '    <tr>';
	html += '      <td><?php echo $entry_layout; ?></td>';
	html += '      <td><select name="pavproductfeatured_module[' + module_row + '][layout_id]">';
	<?php foreach ($layouts as $layout) { ?>
	html += '           <option value="<?php echo $layout['layout_id']; ?>"><?php echo addslashes($layout['name']); ?></option>';
	<?php } ?>
	html += '      </select></td>';
	html += '    </tr>';
	html += '    <tr>';
	html += '      <td><?php echo $entry_position; ?></td>';
	html += '      <td><select name="pavproductfeatured_module[' + module_row + '][position]">';
	<?php foreach( $positions as $pos ) { ?>
	html += '<option value="<?php echo $pos;?>"><?php echo $this->language->get('text_'.$pos); ?></option>';      
	<?php } ?>		html += '      </select></td>';
	html += '    </tr>';
	html += '    <tr>';
	html += '      <td><?php echo $entry_status; ?></td>';
	html += '      <td><select name="pavproductfeatured_module[' + module_row + '][status]">';
	html += '        <option value="1"><?php echo $text_enabled; ?></option>';
	html += '        <option value="0"><?php echo $text_disabled; ?></option>';
	html += '      </select></td>';
	html += '    </tr>';
	html += '    <tr>';
	html += '      <td><?php echo $entry_sort_order; ?></td>';
	html += '      <td><input type="text" name="pavproductfeatured_module[' + module_row + '][sort_order]" value="" size="3" /></td>';
	html += '    </tr>';
	html += '  </table>'; 
	html += '</div>';
	
	$('#form').append(html);

	productAutocomplete(module_row);

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
<script type="text/javascript"><!--
function image_upload(field, thumb) {
  $('#dialog').remove();
  
  $('#content').prepend('<div id="dialog" style="padding: 3px 0px 0px 0px;"><iframe src="index.php?route=common/filemanager&token=<?php echo $token; ?>&field=' + encodeURIComponent(field) + '" style="padding:0; margin: 0; display: block; width: 100%; height: 100%;" frameborder="no" scrolling="auto"></iframe></div>');
  
  $('#dialog').dialog({
    title: '<?php echo $text_image_manager; ?>',
    close: function (event, ui) {
      if ($('#' + field).attr('value')) {
        $.ajax({
          url: 'index.php?route=common/filemanager/image&token=<?php echo $token; ?>&image=' + encodeURIComponent($('#' + field).attr('value')),
          dataType: 'text',
          success: function(data) {
            $('#' + thumb).replaceWith('<img src="' + data + '" alt="" id="' + thumb + '" />');
          }
        });
      }
    },  
    bgiframe: false,
    width: 700,
    height: 400,
    resizable: false,
    modal: false
  });
};
//--></script> 
<?php echo $footer; ?>