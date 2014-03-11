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
<div class="box">
  <div class="heading">
    
			<h1><img src="view/image/admin_theme/base5builder_circloid/icon-extensions.png" alt="<?php echo $heading_title; ?>" width="32" height="32" /> <?php echo $heading_title; ?></h1>
			
    <div class="buttons"><a onclick="$('#form').submit();" class="button"><span><?php echo $button_save; ?></span></a><a onclick="location = '<?php echo $cancel; ?>';" class="button"><span><?php echo $button_cancel; ?></span></a></div>
  </div>
  <div class="content">
    <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form">
      <table class="form">
        <tr>
          <td style="text-align:center;"><label><?php echo $text_scrollspeed;?></label>
				<input style="margin-right:25px;" type="text" name="top1e_scrolltop_scrollspeed" value="<?php echo  isset($scrollspeed) ? $scrollspeed : ''; ?>" />
		 
          <label><?php echo $text_indelay;?></label>
				<input style="margin-right:25px;" type="text" name="top1e_scrolltop_indelay" value="<?php echo  isset($indelay) ? $indelay : ''; ?>" />
		  
		  <label><?php echo $text_outdelay;?></label>
				<input style="margin-right:25px;" type="text" name="top1e_scrolltop_outdelay" value="<?php echo  isset($outdelay) ? $outdelay : ''; ?>" />
		  </td>
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
            <td class="left"><select name="top1e_scrolltop_module[<?php echo $module_row; ?>][layout_id]">
                <?php foreach ($layouts as $layout) { ?>
                <?php if ($layout['layout_id'] == $module['layout_id']) { ?>
                <option value="<?php echo $layout['layout_id']; ?>" selected="selected"><?php echo $layout['name']; ?></option>
                <?php } else { ?>
                <option value="<?php echo $layout['layout_id']; ?>"><?php echo $layout['name']; ?></option>
                <?php } ?>
                <?php } ?>
              </select></td>
            <td class="left"><select name="top1e_scrolltop_module[<?php echo $module_row; ?>][position]">
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
                <?php if ($module['position'] == 'column_left') { ?>
                <option value="column_left" selected="selected"><?php echo $text_column_left; ?></option>
                <?php } else { ?>
                <option value="column_left"><?php echo $text_column_left; ?></option>
                <?php } ?>
                <?php if ($module['position'] == 'column_right') { ?>
                <option value="column_right" selected="selected"><?php echo $text_column_right; ?></option>
                <?php } else { ?>
                <option value="column_right"><?php echo $text_column_right; ?></option>
                <?php } ?>
              </select></td>
            <td class="left"><select name="top1e_scrolltop_module[<?php echo $module_row; ?>][status]">
                <?php if ($module['status']) { ?>
                <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
                <option value="0"><?php echo $text_disabled; ?></option>
                <?php } else { ?>
                <option value="1"><?php echo $text_enabled; ?></option>
                <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
                <?php } ?>
              </select></td>
            <td class="right"><input type="text" name="top1e_scrolltop_module[<?php echo $module_row; ?>][sort_order]" value="<?php echo $module['sort_order']; ?>" size="3" /></td>
            <td class="left"><a onclick="$('#module-row<?php echo $module_row; ?>').remove();" class="button"><?php echo $button_remove; ?></a></td>
          </tr>
        </tbody>
        <?php $module_row++; ?>
        <?php } ?>
        <tfoot>
          <tr>
            <td colspan="4"></td>
            <td class="left"><a onclick="addModule();" class="button"><?php echo $button_add_module; ?></a></td>
          </tr>
        </tfoot>
      </table>
	  	  
    </form>
	
	<div class="help-googletranslate">
	 <h3><img src="../catalog/view/theme/default/stylesheet/top1e_scrolltop/img/help.png" />HELP</h3>
	 <p>
	 For customizations or assistance, please contact: <strong>support@top1extensions.com</strong>
	 <br>
	 </p>
	</div>
	<div class="about-googletranslate">
            <h3><img src="../catalog/view/theme/default/stylesheet/top1e_scrolltop/img/logo.png" /> AUTO SCROLL TOP</h3>
            <ul>
                <li>Author                                              	 : Top1Extensions</li>
                <li>Version                                            	:  1.0</li>
                <li>Opencart Compatibility             	 : v1.3.x, v1.4.x, v1.5.x</li>             
            </ul>
    </div>
      <div class="about-top1extension">
            <h3><img src="../catalog/view/theme/default/stylesheet/top1e_scrolltop/img/aboutus.png" />  <a TARGET="_blank" href="http://top1extensions.com/"> TOP1EXTENSIONS.COM</a></h3>
             <p>
                        We have expert developers that can assist for many eCommerce extensions, modules, widget development, new extension creation or customization.
                        <br>
                        We are a teams of seasoned web professionals with many years of hands-on experience  and alway use new technology, so we will bring best solutions for your site.
                        </p>
    </div> 
	
	
  </div>
</div>
<script type="text/javascript"><!--
var module_row = <?php echo $module_row; ?>;

function addModule() {	
	html  = '<tbody id="module-row' + module_row + '">';
	html += '  <tr>';
	html += '    <td class="left"><select name="top1e_scrolltop_module[' + module_row + '][layout_id]">';
	<?php foreach ($layouts as $layout) { ?>
	html += '      <option value="<?php echo $layout['layout_id']; ?>"><?php echo $layout['name']; ?></option>';
	<?php } ?>
	html += '    </select></td>';
	html += '    <td class="left"><select name="top1e_scrolltop_module[' + module_row + '][position]">';
	html += '      <option value="content_top"><?php echo $text_content_top; ?></option>';
	html += '      <option value="content_bottom"><?php echo $text_content_bottom; ?></option>';
	html += '      <option value="column_left"><?php echo $text_column_left; ?></option>';
	html += '      <option value="column_right"><?php echo $text_column_right; ?></option>';
	html += '    </select></td>';
	html += '    <td class="left"><select name="top1e_scrolltop_module[' + module_row + '][status]">';
    html += '      <option value="1" selected="selected"><?php echo $text_enabled; ?></option>';
    html += '      <option value="0"><?php echo $text_disabled; ?></option>';
    html += '    </select></td>';
	html += '    <td class="right"><input type="text" name="top1e_scrolltop_module[' + module_row + '][sort_order]" value="" size="3" /></td>';
	html += '    <td class="left"><a onclick="$(\'#module-row' + module_row + '\').remove();" class="button"><?php echo $button_remove; ?></a></td>';
	html += '  </tr>';
	html += '</tbody>';
	
	$('#module tfoot').before(html);
	
	module_row++;
}
//--></script>
<?php echo $footer; ?>