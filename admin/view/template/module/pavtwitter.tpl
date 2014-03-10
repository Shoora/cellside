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
      <h1><img src="view/image/module.png" alt="" /> <?php echo $heading_title; ?></h1>
      <div class="buttons"><a onclick="$('#form').submit();" class="button"><?php echo $button_save; ?></a><a href="<?php echo $cancel; ?>" class="button"><?php echo $button_cancel; ?></a></div>
    </div>
    <div class="content">
      <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form">
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
              <table class="form">
                        <tr>
                          <td><?php echo $entry_layout; ?></td>
                          <td><select name="pavtwitter_module[<?php echo $module_row; ?>][layout_id]">
      
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
                          <td><select name="pavtwitter_module[<?php echo $module_row; ?>][position]">
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
                          <td><select name="pavtwitter_module[<?php echo $module_row; ?>][status]">
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
                          <td><input type="text" name="pavtwitter_module[<?php echo $module_row; ?>][sort_order]" value="<?php echo $module['sort_order']; ?>" size="3" /></td>
                        </tr>
                        <tr>
                          <td><?php echo $entry_widgetid; ?></td>   
                          <td><input type="text" name="pavtwitter_module[<?php echo $module_row; ?>][widget_id]" value="<?php echo isset($module['widget_id'])?$module['widget_id']:''; ?>" size="35" /><br/><p><?php echo $entry_widget_help; ?></p></td> 
                        </tr>
                        <tr>
                          <td><?php echo $entry_limit; ?></td>   
                          <td><input type="text" name="pavtwitter_module[<?php echo $module_row; ?>][count]" value="<?php echo $module['count']; ?>" size="3" /><br/>
                            <p><?php echo $entry_count_help; ?></p></td> 
                        </tr>
                        <tr>
                          <td><?php echo $entry_username; ?></td>   
                          <td><input type="text" name="pavtwitter_module[<?php echo $module_row; ?>][username]" value="<?php echo $module['username']; ?>" size="35" /></td> 
                        </tr>
                        <tr>
                          <td><?php echo $entry_theme; ?></td>   
                          <td><select name="pavtwitter_module[<?php echo $module_row; ?>][theme]">
                              <?php foreach($themes as $theme):?>
                                <?php if(isset($module['theme']) && $module['theme'] == $theme):?>
                                  <option value="<?php echo $theme; ?>" selected="selected"><?php echo $theme; ?></option>
                              <?php else: ?>
                                  <option value="<?php echo $theme; ?>"><?php echo $theme; ?></option>
                               <?php endif;?>
                              <?php endforeach; ?>
                          </select> 
                        </tr>
                        <tr>
                          <td><?php echo $entry_linkcolor; ?></td>   
                          <td><input type="text" class="color" name="pavtwitter_module[<?php echo $module_row; ?>][link_color]" value="<?php echo $module['link_color']; ?>" size="35" /></td> 
                        </tr>
                        <tr>
                          <td><?php echo $entry_bordercolor; ?></td>   
                          <td><input type="text" class="color" name="pavtwitter_module[<?php echo $module_row; ?>][border_color]" value="<?php echo $module['border_color']; ?>" size="35" /></td> 
                        </tr>
                        <tr>
                          <td><?php echo $entry_width; ?></td>   
                          <td><input type="text" name="pavtwitter_module[<?php echo $module_row; ?>][width]" value="<?php echo isset($module['width'])?$module['width']:''; ?>" size="10" /></td> 
                        </tr>
                        <tr>
                          <td><?php echo $entry_height; ?></td>   
                          <td><input type="text" name="pavtwitter_module[<?php echo $module_row; ?>][height]" value="<?php echo isset($module['height'])?$module['height']:''; ?>" size="10" /></td> 
                        </tr>
                        <tr>
                          <td><?php echo $entry_showreply; ?></td>   
                          <td><select name="pavtwitter_module[<?php echo $module_row; ?>][show_replies]">
                          <?php if ($module['show_replies']) { ?>
                          <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
                          <option value="0"><?php echo $text_disabled; ?></option>
                          <?php } else { ?>
                          <option value="1"><?php echo $text_enabled; ?></option>
                          <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
                          <?php } ?>
                        </select></td> 
                        </tr>
                        <tr>
                          <td><?php echo $entry_chrome; ?></td>   
                          <td><select name="pavtwitter_module[<?php echo $module_row; ?>][chrome][]" multiple="multiple">
                              <?php foreach($chromes as $chrome):?>
                                <?php if(isset($module['chrome']) && is_array($module['chrome']) && in_array($chrome, $module['chrome'])):?>
                                  <option value="<?php echo $chrome; ?>" selected="selected"><?php echo $chrome; ?></option>
                              <?php else: ?>
                                  <option value="<?php echo $chrome; ?>"><?php echo $chrome; ?></option>
                               <?php endif;?>
                              <?php endforeach; ?>
                          </select><br/><p><?php echo $entry_chrome_help; ?></p></td> 
                        </tr>
          </table> 
          </div>
          <?php $module_row++; ?>
        <?php } ?>
      </form>
    </div>
  </div>
</div>
<script type="text/javascript"><!--
var module_row = <?php echo $module_row; ?>;
$(".vtabs a").tabs();
$('.colorbox').colorbox({
    overlayClose: true,
    opacity: 0.5,
    rel: "colorbox"
  });
function addModule() {
  html  = '<div id="tab-module-' + module_row + '" class="vtabs-content">';

  html += '  <table class="form">';
  
  html += '    <tr>';
  html += '      <td><?php echo $entry_layout; ?></td>';
  html += '      <td><select name="pavtwitter_module[' + module_row + '][layout_id]">';
  <?php foreach ($layouts as $layout) { ?>
  html += '           <option value="<?php echo $layout['layout_id']; ?>"><?php echo addslashes($layout['name']); ?></option>';
  <?php } ?>
  html += '      </select></td>';
  html += '    </tr>';
  html += '    <tr>';
  html += '      <td><?php echo $entry_position; ?></td>';
  html += '      <td><select name="pavtwitter_module[' + module_row + '][position]">';
  <?php foreach( $positions as $pos ) { ?>
  html += '<option value="<?php echo $pos;?>"><?php echo $this->language->get('text_'.$pos); ?></option>';      
  <?php } ?>    html += '      </select></td>';
  html += '    </tr>';
  html += '    <tr>';
  html += '      <td><?php echo $entry_status; ?></td>';
  html += '      <td><select name="pavtwitter_module[' + module_row + '][status]">';
  html += '        <option value="1"><?php echo $text_enabled; ?></option>';
  html += '        <option value="0"><?php echo $text_disabled; ?></option>';
  html += '      </select></td>';
  html += '    </tr>';
  html += '    <tr>';
  html += '      <td><?php echo $entry_sort_order; ?></td>';
  html += '      <td><input type="text" name="pavtwitter_module[' + module_row + '][sort_order]" value="" size="3" /></td>';
  html += '    </tr>';
  html += '<tr>';
  html += '<tr>';
  html += '                        <td><?php echo $entry_widgetid; ?></td>';   
  html += '                        <td><input type="text" name="pavtwitter_module[<?php echo $module_row; ?>][widget_id]" value="366766896986591232" size="35" /><br/><p><?php echo $entry_widget_help; ?></p></td>'; 
  html += '                      </tr>';
  html += '                        <td><?php echo $entry_limit; ?></td>';  
  html += '                        <td><input type="text" name="pavtwitter_module[<?php echo $module_row; ?>][count]" value="" size="3" /><br/><p><?php echo $entry_count_help; ?></p></td> ';
  html += '                      </tr>';
  html += '                      <tr>';
  html += '                        <td><?php echo $entry_username; ?></td>  '; 
  html += '                        <td><input type="text" name="pavtwitter_module[<?php echo $module_row; ?>][username]" value="pavothemes" size="35" /></td>'; 
  html += '                      </tr>';
  html += '<tr>';
  html += '                        <td><?php echo $entry_theme; ?></td>';   
  html += '                        <td><select name="pavtwitter_module[<?php echo $module_row; ?>][theme]">';
                          <?php foreach($themes as $theme):?>
  html += '                                <option value="<?php echo $theme; ?>"><?php echo $theme; ?></option>';
                          <?php endforeach; ?>
  html += '                        </select>';
  html += '                      </tr>';
  html += '                      <tr>';
  html += '                        <td><?php echo $entry_linkcolor; ?></td>';   
  html += '                        <td><input type="text" class="color" name="pavtwitter_module[<?php echo $module_row; ?>][link_color]" value="#cc0000" size="35" /></td>';
  html += '                      </tr>';
  html += '                      <tr>';
  html += '                        <td><?php echo $entry_bordercolor; ?></td>';  
  html += '                        <td><input type="text" class="color" name="pavtwitter_module[<?php echo $module_row; ?>][border_color]" value="" size="35" /></td>';
  html += '                      </tr>';
  html += '                      <tr>';
  html += '                        <td><?php echo $entry_width; ?></td>';   
  html += '                        <td><input type="text" name="pavtwitter_module[<?php echo $module_row; ?>][width]" value="300" size="10" /></td>';
  html += '                      </tr>';
  html += '                      <tr>';
  html += '                        <td><?php echo $entry_height; ?></td>';   
  html += '                        <td><input type="text" name="pavtwitter_module[<?php echo $module_row; ?>][height]" value="500" size="10" /></td>'; 
  html += '                      </tr>';
  html += '                      <tr>';
  html += '                        <td><?php echo $entry_showreply; ?></td>';  
  html += '                        <td><select name="pavtwitter_module[<?php echo $module_row; ?>][show_replies]">';
  html += '                        <option value="1" selected="selected"><?php echo $text_enabled; ?></option>';
  html += '                        <option value="0"><?php echo $text_disabled; ?></option>';
  
  html += '                      </select></td>'; 
  html += '                      </tr>';
  html += '                      <tr>';
  html += '                        <td><?php echo $entry_chrome; ?></td>';   
  html += '                        <td><select name="pavtwitter_module[<?php echo $module_row; ?>][chrome][]" multiple="multiple">';
                              <?php foreach($chromes as $chrome):?>
  html += '                                <option value="<?php echo $chrome; ?>"><?php echo $chrome; ?></option>';
                              <?php endforeach; ?>
  html += '                        </select><br/><p><?php echo $entry_chrome_help; ?></p></td>'; 
  html += '                      </tr>';
  html += '  </table>'; 
  html += '</div>';
  
  $('#form').append(html);

  $('#module-add').before('<a href="#tab-module-' + module_row + '" id="module-' + module_row + '"><?php echo $tab_module; ?> ' + module_row + '&nbsp;<img src="view/image/delete.png" alt="" onclick="$(\'.vtabs a:first\').trigger(\'click\'); $(\'#module-' + module_row + '\').remove(); $(\'#tab-module-' + module_row + '\').remove(); return false;" /></a>');
  
  $('.vtabs a').tabs();
  
  $('#module-' + module_row).trigger('click');
  jscolor.install(true);
  $('.colorbox').colorbox({
    overlayClose: true,
    opacity: 0.5,
    rel: "colorbox"
  });
  module_row++;
}
//--></script> 
<?php echo $footer; ?>