<?php
/*

Readme English: http://shop.workshop200.com/en/blog?news_id=5

Note: This readme relates to the main branch of extension which is distributed under ionCube.
You are currently using Open Source version without access to any updates, but you can still 
find a lot of useful information in readme.

The developer is not responsible for any problems that arose after or as a consequence of the modification 
of the original source of extension. Everything supposed work fine just AS IT IS. 

Developer: workshop200@yandex.ru

Note: In a case you need to get free technical support you need to provide the following information:
1. When and where did you purchase the extension?
2. What account \ email was used?

*/
?>

<?php echo $header; ?>
<div id="content">

<?php echo breadcrumb($breadcrumbs); ?>

<?php if ($error_warning) { ?>
<div class="warning"><?php echo $error_warning; ?></div>
<?php } ?>

<div class="box">
  <div class="heading">
    <h1><img src="view/image/module.png" alt="" /> <?php echo $heading_title; ?></h1>
    <div class="buttons">
	<?php if (!$block_form) { ?><a onclick="$('#form').submit();" class="button"><span><?php echo $button_save; ?></span></a><?php } ?>
	<a onclick="location = '<?php echo $cancel; ?>';" class="button"><span><?php echo $button_cancel; ?></span></a>
	</div>
  </div>
  <div class="content">
    <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form">
	
	<table class="form">
        <tr>
          <td><?php echo $txt_chains; ?><div class="help"><?php echo $txt_chains_hint; ?></div></td>
          <td><input type="text" name="chains" value="" <?php echo $block_form ? 'readonly' : ''; ?> /></td>
        </tr>
        <tr>
          <td>&nbsp;</td>
          <td><div class="scrollbox" id="chain-products" style="width: 800px;">
              <?php $class = 'odd'; ?>
              <?php  foreach ($chains_list as $chain_id => $chain_name) { ?>
              <?php $class = ($class == 'even' ? 'odd' : 'even'); ?>
              <div id="chain-products<?php echo $chain_id; ?>" class="<?php echo $class; ?>"><?php echo $chain_name; ?> <img src="view/image/delete.png" />
                <input type="hidden" value="<?php echo $chain_id; ?>" />
              </div>
              <?php }  ?>
            </div>
            <input type="hidden" name="chains_of_products" value="<?php echo $chains_ids; ?>" /></td>
        </tr>
      </table>

      <table id="module" class="list">
        <thead>
          <tr>
            <td class="left"><?php echo $entry_layout; ?></td>
            <td class="left"><?php echo $entry_position; ?></td>
            <td class="left"><?php echo $entry_status; ?></td>
            <td class="right"><?php echo $entry_sort_order; ?></td>
            <td></td>
          </tr>
        </thead>
        <?php $module_row = 0; ?>
        <?php foreach ($modules as $module) { ?>
        <tbody id="module-row<?php echo $module_row; ?>">
          <tr>
            <td class="left"><select name="chainwidget_module[<?php echo $module_row; ?>][layout_id]">
                <?php foreach ($layouts as $layout) {
				
					if ($layout['layout_id'] == 2) { 
						continue; 
					} // dont show module on the product page!
					
				?>
                <?php if ($layout['layout_id'] == $module['layout_id']) { ?>
                <option value="<?php echo $layout['layout_id']; ?>" selected="selected"><?php echo $layout['name']; ?></option>
                <?php } else { ?>
                <option value="<?php echo $layout['layout_id']; ?>"><?php echo $layout['name']; ?></option>
                <?php } ?>
                <?php } ?>
              </select></td>
            <td class="left"><select name="chainwidget_module[<?php echo $module_row; ?>][position]">
                <?php if ($module['position'] == 'content_top') { ?>
                <option value="content_top" selected="selected"><?php echo $text_content_top; ?></option>
                <?php } else { ?>
                <option value="content_top"><?php echo $text_content_top; ?></option>
                <?php } ?>  
                <?php if ($module['position'] == 'content_bottom') { ?>
                <option value="content_bottom" selected="selected"><?php echo $text_content_bottom; ?></option>
                <?php } else { ?>
                <option value="content_bottom"><?php echo $text_content_bottom; ?></option>
                <?php } ?>    
               </select></td>
            <td class="left"><select name="chainwidget_module[<?php echo $module_row; ?>][status]">
                <?php if ($module['status']) { ?>
                <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
                <option value="0"><?php echo $text_disabled; ?></option>
                <?php } else { ?>
                <option value="1"><?php echo $text_enabled; ?></option>
                <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
                <?php } ?>
              </select></td>
            <td class="right"><input type="text" name="chainwidget_module[<?php echo $module_row; ?>][sort_order]" value="<?php echo $module['sort_order']; ?>" size="3" /></td>
            <td class="left"><a onclick="$('#module-row<?php echo $module_row; ?>').remove();" class="button"><span><?php echo $button_remove; ?></span></a></td>
          </tr>
        </tbody>
        <?php $module_row++; ?>
        <?php } ?>
        <tfoot>
          <tr>
            <td colspan="4"></td>
            <td class="left"><a onclick="addModule();" class="button"><span><?php echo $button_add_module; ?></span></a></td>
          </tr>
        </tfoot>
      </table>
    </form>
  </div>
</div>
<script type="text/javascript"><!--
var module_row = <?php echo $module_row; ?>;

function addModule() {	
	html  = '<tbody id="module-row' + module_row + '">';
	html += '  <tr>';
	html += '    <td class="left"><select name="chainwidget_module[' + module_row + '][layout_id]">';
	<?php foreach ($layouts as $layout) { 
	
		if ($layout['layout_id'] == 2) { 
			continue; 
		} // dont show module on the product page!
		
	?>
	html += '      <option value="<?php echo $layout['layout_id']; ?>"><?php echo $layout['name']; ?></option>';
	<?php } ?>
	html += '    </select></td>';
	html += '    <td class="left"><select name="chainwidget_module[' + module_row + '][position]">';
	html += '      <option value="content_top"><?php echo $text_content_top; ?></option>';
	html += '      <option value="content_bottom"><?php echo $text_content_bottom; ?></option>';
	html += '    </select></td>';
	html += '    <td class="left"><select name="chainwidget_module[' + module_row + '][status]">';
    html += '      <option value="1" selected="selected"><?php echo $text_enabled; ?></option>';
    html += '      <option value="0"><?php echo $text_disabled; ?></option>';
    html += '    </select></td>';
	html += '    <td class="right"><input type="text" name="chainwidget_module[' + module_row + '][sort_order]" value="" size="3" /></td>';
	html += '    <td class="left"><a onclick="$(\'#module-row' + module_row + '\').remove();" class="button"><span><?php echo $button_remove; ?></span></a></td>';
	html += '  </tr>';
	html += '</tbody>';
	
	$('#module tfoot').before(html);
	
	module_row++;
}

<?php
if (version_compare(VERSION, '1.5.4', '>='))
	{
		$delete_function = "$('#content').on('click', '#chain-products div img', function() {";
	}
else 
	{
		$delete_function = "$('#chain-products div img').live('click', function() {";
	}
?>

$('input[name=\'chains\']').autocomplete({
	delay: 0,
	source: function(request, response) {
		$.ajax({
			url: 'index.php?route=module/chain/autocomplete&token=<?php echo $this->session->data['token']; ?>&filter_name=' +  encodeURIComponent(request.term),
			dataType: 'json',
			success: function(json) {		
				response($.map(json, function(item) {
					return {
						label: item.name,
						value: item.chain_id
					}
				}));
			}
		});
		
	}, 
	select: function(event, ui) {
		$('#chain-products' + ui.item.value).remove();
		
		$('#chain-products').append('<div id="chain-products' + ui.item.value + '">' + ui.item.label + '<img src="view/image/delete.png" /><input type="hidden" value="' + ui.item.value + '" /></div>');

		$('#chain-products div:odd').attr('class', 'odd');
		$('#chain-products div:even').attr('class', 'even');
		
		data = $.map($('#chain-products input'), function(element){
			return $(element).attr('value');
		});
						
		$('input[name=\'chains_of_products\']').attr('value', data.join());
					
		return false;
	}
});

<?php echo $delete_function; ?>
	$(this).parent().remove();
	
	$('#chain-products div:odd').attr('class', 'odd');
	$('#chain-products div:even').attr('class', 'even');

	data = $.map($('#chain-products input'), function(element){
		return $(element).attr('value');
	});
					
	$('input[name=\'chains_of_products\']').attr('value', data.join());	
});


//--></script>
<?php echo $footer; ?>